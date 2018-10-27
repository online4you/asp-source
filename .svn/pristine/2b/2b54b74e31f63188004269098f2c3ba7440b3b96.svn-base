<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
if tarifa=0 then tarifa=1 'por defecto

'fotos hotel
cs="Select FotosHotel.Id, FotosHotel.Foto, FotosHotel.Orden, FotosHotel.IdSeccion "
cs=cs & "From FotosHotel "
cs=cs & "Where FotosHotel.CodigoEsta=" & est & " ORDER BY orden"

'response.write "cs : " & cs & "<br>"
rs.Open cs, base
hayfotos=false
if not rs.eof then
	RegFotos=rs.GetRows
	'Variables para la tabla Habitaciones
	HoFotoId=0
	HoFoto=1
	HoOrden=2
	HoSeccionId=3
	hayfotos=true
end if
rs.close
	
set rs=nothing
base.close
set base=nothing
	
'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
'Poner fotos
If hayfotos Then
	For f=0 To UBound(RegFotos,2)
		response.write vbtab & "<foto>" & vbcrlf
		response.write vbtab & vbtab & "<idfoto>" & RegFotos(HoFotoId,f) & "</idfoto>" & vbcrlf
		response.write vbtab & vbtab & "<foto>" & server.HTMLEncode(RegFotos(HoFoto,f)) & "</foto>" & vbcrlf
		response.write vbtab & vbtab & "<orden>" & clng(RegFotos(HoOrden,f)) & "</orden>" & vbcrlf
		response.write vbtab & vbtab & "<idseccion>" & clng(RegFotos(HoSeccionId,f)) & "</idseccion>" & vbcrlf
		response.write vbtab & "</foto>" & vbcrlf
	next 'h
end if 'hayfotos
response.write "</data>"
%>