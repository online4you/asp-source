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


ptoI=request.QueryString("ptoI") 'el punto clave
laX=request.QueryString("laX") 'posición X 
laY=request.QueryString("laY") 'posición Y
lang=request.QueryString("lang")
tipoId=request.QueryString("tipoId")

haypunto=false
if(isNumeric(laX) And isNumeric(laY)) Then
If(lang = "es") Then
	cs="select IDproducto, tit_field, GeoPointX, GeoPointY "
Else
	cs="select IDproducto, isnull(tit_field_"&lang&",tit_field) 'tit_field', GeoPointX, GeoPointY "
End If
	cs=cs& " , ABS(CAST((GeoPointX-("&quitarComa(laX)&"))+(GeoPointY-("&quitarComa(laY)&")) AS FLOAT)) AS dif "
	cs=cs& " from productos "
	cs=cs& " where IdProductType = "&tipoId
	cs=cs& " and (GeoPointX Between ("&Replace(laX,",",".")&" - 2) And ("&Replace(laX,",",".")&" + 2)) "
	cs=cs& " and (GeoPointY Between ("&Replace(laY,",",".")&" - 2) And ("&Replace(laY,",",".")&" + 2)) "
	if(isNumeric(ptoI)) then
		cs=cs& " and IDproducto != " & ptoI
	end if
	cs=cs& " Order by dif "
	
	'response.write cs & "<br/>"
	
	rs.Open cs, baseGsys
	if not rs.eof then
		RegCercanos=rs.getrows
		N_IdProducto=0
		N_NombrePunto=1
		N_X=2
		N_Y=3
		N_Dife=4
		haypunto=true
	end if
	rs.close
end if

npuntos=0
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if haypunto then
	for h=0 to ubound(RegCercanos,2)
		if antepunto<>RegCercanos(HoCodi,h) then 'Cambio de punto, buscar datos
			antepunto=RegCercanos(HoCodi,h)
			npuntos=npuntos+1
			response.write "<punto>" & vbcrlf
			response.write vbtab & "<codigo>" & RegCercanos(N_IdProducto,h) & "</codigo>" & vbcrlf
			response.write vbtab & "<nombre>" & server.HTMLEncode(RegCercanos(N_NombrePunto,h)) & "</nombre>" & vbcrlf
			response.write vbtab & "<laX>" & CDbl(RegCercanos(N_X,h)) & "</laX>" & vbcrlf
			response.write vbtab & "<laY>" & CDbl(RegCercanos(N_Y,h)) & "</laY>" & vbcrlf
			'response.write vbtab & "<diferencia>" & paDbl(RegCercanos(N_Dife,h)) & "</diferencia>" & vbcrlf
			response.write "</punto>" & vbcrlf
		end if
	next
End if
response.write "<resultados>"&npuntos&"</resultados>"
response.write "</data>"
%>