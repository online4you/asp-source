<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang=request.QueryString("lang")

'Lista de registros
cs="SELECT Id,ISNULL(dbo.fnGetTraduccion('Zonas','Zona',Id,'" & lang & "'),Zona) AS Zona "
cs=cs & "FROM " & precrs & "Zonas"
rs.Open cs, base
hayZona=false
if not rs.eof then
	RegZona=rs.GetRows
	ZCodi=0
	ZNombre=1
	hayZona=true
end if
rs.close

set rs=nothing
base.close
set base=nothing

'Generar XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<zonas>" & vbcrlf
if hayzona then
for z=0 to ubound(RegZona,2)
	response.write "<zona>" & vbcrlf
	response.write vbtab & "<codigo>" & RegZona(ZCodi,z) & "</codigo>" & vbcrlf
	response.write vbtab & "<nombre>" & server.HTMLEncode(RegZona(ZNombre,z)) & "</nombre>" & vbcrlf
	response.write "</zona>" & vbcrlf
next
else 'no hay
	'response.write "<regimen><codigo>Error</codigo></regimen>" & vbcrlf
	response.write "No tiene regimen"
end if
response.write "</zonas>"
%>