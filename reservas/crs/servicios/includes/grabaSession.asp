<!--#include virtual="/includes/Funciones.asp"-->
<!--#include virtual="/includes/claseCookie.asp"-->
<%
set objCookies = new clsCookie

valor=request.QueryString("valor")
ff=request.QueryString("if")
eti=request.QueryString("eti")
'Guarda el valor 
'objCookies.setCookie lcase(eti),valor
Session("PP")="aaaa"

set objCookies=nothing
if ff<>"" then 'recarga
%>
<script language="javascript" type="text/javascript">
top.frames['<%=ff%>'].recarga(); //recarga la pagina
</script>
<%end if%>