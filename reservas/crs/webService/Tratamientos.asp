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
cs="Select Id, "
cs=cs&" IsNull(dbo.fnGetTraduccion('Tratamientos','Nombre',Id,'"&lang&"'),Nombre) Nombre, "
cs=cs&" IsNull(dbo.fnGetTraduccion('Tratamientos','Breve',Id,'"&lang&"'),Breve) Breve "
cs=cs&" From " & precrs & "Tratamientos "
rs.Open cs, base
hayTratamiento=false
if not rs.eof then
	RegTratamiento=rs.GetRows
	TId=0
	TNombre=1
	TBreve=2
	hayTratamiento=true
end if
rs.close

set rs=nothing
base.close
set base=nothing

'Generar XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<tratamientos>" & vbcrlf
if hayTratamiento then
for t=0 to ubound(RegTratamiento,2)
	response.write "<tratamiento>" & vbcrlf
	response.write vbtab & "<codigo>" & RegTratamiento(TId,t) & "</codigo>" & vbcrlf
	response.write vbtab & "<nombre>" & server.HTMLEncode(RegTratamiento(TNombre,t)) & "</nombre>" & vbcrlf
	response.write vbtab & "<breve>" & server.HTMLEncode(RegTratamiento(tBreve,t)) & "</breve>" & vbcrlf
	response.write "</tratamiento>" & vbcrlf
next
else 'no hay
	response.write "No hay tratamientos"
end if
response.write "</tratamientos>"
%>