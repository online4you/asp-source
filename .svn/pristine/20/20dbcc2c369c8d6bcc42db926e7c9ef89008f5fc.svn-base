<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

ConectaGSys="Provider=SQLOLEDB.1;Persist Security Info=True;User ID=WebUser;pwd=P1AN3TAweb;Initial Catalog=globalsys;Data Source=localhost"

set baseGsys=server.createobject("ADODB.Connection")
set rsg=server.createobject("ADODB.Recordset")
rsg.CursorLocation = adUseServer
rsg.CursorType=adOpenForwardOnly
rsg.LockType=adLockReadOnly
baseGsys.Open ConectaGSys

idprod=request.QueryString("idprod") 'el producto

'fotos hotel
cs="SELECT p1.IDproducto,isnull(p1.foto1,isnull(p2.foto1,isnull(p3.foto1,p4.foto1))) "
cs=cs& " FROM productos p1 LEFT JOIN productos p2 ON "
cs=cs& " p2.idproducto = p1.idpadre LEFT JOIN productos p3 ON p3.idproducto = p2.idpadre "
cs=cs& " LEFT JOIN productos p4 ON p4.idproducto = p3.idpadre "
cs=cs& " where p1.IDproducto = "&idprod&" AND isnull(p1.foto1,isnull(p2.foto1,isnull(p3.foto1,isnull(p4.foto1, '')))) != ''"
  
'response.write "cs : " & cs & "<br>"
rs.Open cs, baseGsys
hayfotos=false
if not rs.eof then
	RegFotos=rs.GetRows
	'Variables para la tabla Habitaciones
	PrProductoId=0
	PrFoto1=1
	hayfotos=true
end if
rs.close
	
set rs=nothing
base.close
set base=nothing
	
'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & idprod & "</codigo>" & vbcrlf
'Poner fotos
If hayfotos Then
	For f=0 To UBound(RegFotos,2)
		response.write vbtab & "<foto>" & vbcrlf
		response.write vbtab & vbtab & "<idprod>" & RegFotos(PrProductoId,f) & "</idprod>" & vbcrlf
		response.write vbtab & vbtab & "<foto>" & server.HTMLEncode(RegFotos(PrFoto1,f)) & "</foto>" & vbcrlf
		response.write vbtab & "</foto>" & vbcrlf
	next 'h
end if 'hayfotos
response.write "</data>"
%>