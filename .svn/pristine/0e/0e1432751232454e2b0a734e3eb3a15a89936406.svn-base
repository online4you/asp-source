<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
lang=request.QueryString("lang") 
estado=request.QueryString("estado") 
tipoa=paClng(request.QueryString("tipoa"))
zona=paClng(request.QueryString("zona"))

cs="SELECT CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona,Poblacion "
cs=cs & "FROM " & precrs & "ConsultaHoteles ConsultaHoteles "
if zona<>0 then
	cs=cs & "WHERE Zona=" & zona
end if
cs=cs & " ORDER BY Orde,CodigoEsta"
rs.Open cs, base
hayhoteles=false
if not rs.eof then
	'Variables para la tabla RegHoteles
	RegHoteles=rs.getrows
	LCodi=0
	LNombre=1
	LEstado=2
	LCate=3
	LTipoA=4
	LZona=5
	LPobla=6
	hayhoteles=true
end if
rs.close


set rs=nothing
base.close
set base=nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if hayhoteles then
	for h=0 to ubound(RegHoteles,2)
		response.write "<hotel>" & vbcrlf
		response.write vbtab & "<codigo>" & RegHoteles(LCodi,h) & "</codigo>" & vbcrlf
		response.write vbtab & "<nombre>" & RegHoteles(LNombre,h) & "</nombre>" & vbcrlf
		response.write vbtab & "<estado>" & RegHoteles(LEstado,h) & "</estado>" & vbcrlf
		response.write vbtab & "<categoria>" & RegHoteles(LCate,h) & "</categoria>" & vbcrlf
		response.write vbtab & "<tipoalojamiento>" & RegHoteles(LTipoA,h) & "</tipoalojamiento>" & vbcrlf
		response.write vbtab & "<zona>" & RegHoteles(LZona,h) & "</zona>" & vbcrlf
		response.write vbtab & "<poblacion>" & RegHoteles(LPobla,h) & "</poblacion>" & vbcrlf
		response.write "</hotel>" & vbcrlf
	next
end if
response.write "</data>"
%>