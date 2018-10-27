<%
'Coger todas las variables de la pagina anterior
for v=0 to ubound(datos)
	'Separar nombre y valor
	camposC=split(datos(v),"=")
	nombreC=camposC(0)
	valorC=request.form(nombreC)
	if valorC="" then valorC=request.QueryString(nombreC)
		'Pongo los input Hidden de cada dato
	response.write "<input type='hidden' name='" & nombreC & "' value='" & valorC & "'>" & vbcrlf
next
%>