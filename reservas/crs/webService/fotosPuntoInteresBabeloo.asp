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
cs="Select Id, Archivo From fotos where idproducto = "&idprod
cs=cs & " ORDER BY fecha, id"

'response.write "cs : " & cs & "<br>"
rs.Open cs, baseGsys
hayfotos=false
if not rs.eof then
	RegFotos=rs.GetRows
	'Variables para la tabla Habitaciones
	PiFotoId=0
	PiFoto=1
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
		response.write vbtab & vbtab & "<idfoto>" & RegFotos(PiFotoId,f) & "</idfoto>" & vbcrlf
		response.write vbtab & vbtab & "<foto>" & server.HTMLEncode(RegFotos(PiFoto,f)) & "</foto>" & vbcrlf
		response.write vbtab & "</foto>" & vbcrlf
	next 'h
end if 'hayfotos
response.write "</data>"
%>