<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
'response.Write(ConectaMDB)
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

response.Cookies("IdEmpresa")=paClng(request.Form("laempre"))
response.Cookies("filtrores")=""
response.Cookies("codiHotel")=""
response.Cookies("tarifa")=1 'tarifa general
'response.redirect(request.ServerVariables("HTTP_REFERER"))
server.Transfer("inicio.asp")
%>