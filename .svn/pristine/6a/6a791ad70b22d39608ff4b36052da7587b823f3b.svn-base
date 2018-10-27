<%@LANGUAGE='VBScript'%>
<!--#include file="includes/langweb.asp"-->
<!--#include file="connections/functionesvte.asp"-->
<!--#include file="connections/lang.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla de categorias
cs="SELECT Id,Nombre_" & lang & ",IdTipo FROM Categorias"
hayCate=false
rs.open cs,base
if not rs.eof then
	RegCate=rs.getrows
	CaCodi=0
	CaNombre=1
	CaTipo=2
	haycate=true
end if
rs.close

'Tabla de zonas
cs="SELECT Id,Zona_" & lang & " FROM Zonas"
hayzona=false
rs.open cs,base
if not rs.eof then
	RegZona=rs.getrows
	ZCodi=0
	ZNombre=1
	hayzona=true
end if
rs.close

%>
<!--#include file="Includes/CalculoPrecios.asp"-->
<%

response.write "<?xml version='1.0' encoding='ISO-8859-1'?>" & vbcrlf
response.write "<data>" & vbcrlf
if msg<>"" then 'error
	response.write vbtab & "<error>" & msg & "</error>" & vbcrlf
end if
if nlista=-1 and msg="" then 'no hay lista
	response.write vbtab & "<error>" & ap("noencontrados") & "</error>" & vbcrlf
end if
if nlista>-1 then 'Ha encontrado alguna
	for p=0 to ubound(Lista,2)
		response.write vbtab & "<hotel>" & vbcrlf
		response.write vbtab & vbtab & "<codigo>" & Lista(LCodi,p) & "</codigo>" & vbcrlf
		response.write vbtab & vbtab & "<nombre>" & Lista(LNombre,p) & "</nombre>" & vbcrlf
		response.write vbtab & vbtab & "<categoria>" & Lista(LCate,p) & "</categoria>" & vbcrlf
		afoto=""
		if Lista(LFoto,p)<>"" then
			afoto="http://www.hotel-reserved.com" & rutafotos & "Ficha_" & Lista(LFoto,p)
		end if
		response.write vbtab & vbtab & "<foto>" & server.URLEncode(afoto) & "</foto>" & vbcrlf
		response.write vbtab & vbtab & "<habitacion>" & Lista(LNHabi,p) & "</habitacion>" & vbcrlf
		response.write vbtab & vbtab & "<regimen>" & Lista(LRegimen,p) & "</regimen>" & vbcrlf
		response.write vbtab & vbtab & "<importe>" & formatnumber(Lista(LPelas,p),2) & "</importe>" & vbcrlf
		enlace="http://www.hotel-reserved.com/admincala/front-end/lasfechas.asp?est="
		enlace=enlace & Lista(LCodi,p) & "&lang=" & lang
		enlace=enlace & "&fi=" & fechai & "&ff=" & fechaf & "&ad=" & adultos & "&ni=" & ninos
		enlace=enlace & "&salta=si"
		response.write vbtab & vbtab & "<enlacereserva>" & server.URLEncode(enlace) & "</enlacereserva>" & vbcrlf
		response.write vbtab & "</hotel>" & vbcrlf
	next 'p
end if
response.write "</data>" & vbcrlf

set rs=nothing
base.close
set base=nothing
%>
