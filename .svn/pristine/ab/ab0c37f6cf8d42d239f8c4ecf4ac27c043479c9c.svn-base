<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang=request.QueryString(" lang")
est=paClng(request.QueryString("idh"))
fini=request.QueryString("fini")
if fini="" then fini=date
anyo=year(fini)

cs="SELECT IdRegimen, IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) Tradu,RegimenHotel.CodigoEsta,CodigoHab,RegimenHotel.Id,Regimen.Breve "
cs=cs & "FROM (" & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel "
cs=cs & "ON Regimen.Id=RegimenHotel.IdRegimen) LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE Anyo=" & anyo
if est<>0 then cs=cs & " AND RegimenHotel.CodigoEsta=" & est
'cs=cs & " GROUP BY RegimenHotel.CodigoEsta,IdRegimen,ISNULL(Traduccion,Nombre),CodigoHab"
cs=cs & " ORDER BY RegimenHotel.CodigoEsta,IdRegimen"
'response.write cs
rs.open cs,base
haysuple=false
if not rs.eof then
	RegSuple=rs.getrows
	RCodi=0
	RNombre=1
	RHotel=2
	RHabi=3
	RIdRegi=4
	RBreve=5
	haysuple=true
end if

set rs=nothing
base.close
set base=nothing

'Generar XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if haysuple then
antecodi=0
antehabi=-1
for s=0 to ubound(RegSuple,2)
	'if antecodi<>RegSuple(RCodi,s) or antehabi<>RegSuple(RHabi,s) then
		corto=""
		if not isnull(RegSuple(RBreve,s)) then  corto=server.HTMLEncode(RegSuple(RBreve,s))
		response.write "<regimen>" & vbcrlf
		response.write vbtab & "<codigo>" & RegSuple(RCodi,s) & "</codigo>" & vbcrlf
		response.write vbtab & "<idregimen>" & RegSuple(RIdRegi,s) & "</idregimen>" & vbcrlf
		response.write vbtab & "<nombre>" & server.HTMLEncode(RegSuple(RNombre,s)) & "</nombre>" & vbcrlf
		response.write vbtab & "<codigocorto>" & corto & "</codigocorto>" & vbcrlf
		response.write vbtab & "<hotel>" & RegSuple(RHotel,s) & "</hotel>" & vbcrlf
		response.write vbtab & "<habitacion>" & RegSuple(RHabi,s) & "</habitacion>" & vbcrlf
		response.write "</regimen>" & vbcrlf
	'end if
	antecodi=RegSuple(RCodi,s)
	anteHabi=RegSuple(RHabi,s)
next
else 'no hay
	'response.write "<regimen><codigo>Error</codigo></regimen>" & vbcrlf
	response.write "No tiene regimen"
end if
response.write "</data>"
%>