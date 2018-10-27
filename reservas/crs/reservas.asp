<%response.Redirect("/index.asp")%>
<%'<!--#include file="Connections/functions.asp" -->%>
<html>
<head>
<title>Hotel-Hoteles.com - Reservas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</script>
<link href="front-end/global.css" rel="stylesheet" type="text/css">
<link href="css1.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--


function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<style type="text/css">
<!--
.textorojopeq {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #CC0000;
}
-->
</style>
</head>
<%
	idi=request.querystring("idi")
	if id="" then idi=2
	est=request.QueryString("est")
	if est="" then est=1
%>
<body bgcolor="#d7ecf7" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="760" height="624" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>					
	  <td height="149" valign="top" class="texto11"> 
		<!-- Contenido de la WEB -->
		<%if lng=1 then lang2=1
		if lng=2 then lang2=3%>
		<IFRAME src="front-end/index.asp?idi=<%=idi%>&est=<%=est%>" width="700" height="500" scrolling="auto" frameborder="0">
		  [Su agente de usuario no soporta marcos o está actualmente configurado
		  para no mostrar marcos. Sin embargo, puede visitar
		  <A href="front-end/index.asp?<%=idi%>&est=<%=est%>">el documento relacionado.</A>]
		</IFRAME>
	  </td>
	</tr>
</table>
</body>
</html>
