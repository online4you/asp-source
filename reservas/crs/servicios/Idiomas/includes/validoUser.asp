<%
'Activar en desarrollo
if request.Cookies("IDCR")="" then 
	response.write "<center><h4>La session a finalizado, tendrá que volver a entrar su clave<br><br>" & vbcrlf
	response.write "<a href='index.asp?salir=Si'>Volver</a></h4></center>"
	response.End()
end if

'If Request.ServerVariables("HTTPS")="off" Then
'	strRedirURL = "https://" & Request.ServerVariables("SERVER_NAME")
'	strRedirURL = strRedirURL & request.servervariables("SCRIPT_NAME")
'	Response.Redirect strRedirURL
'End If
%>