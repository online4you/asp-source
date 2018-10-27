<!--#include file="ValidoUser.asp"-->
<!--#include file="Funciones.asp"-->
<%
pafuera=false
if request.querystring("subir")="si" then 
	ruta="D:\XVRT\sonpalou.com\data\"
	Set Upload = Server.CreateObject("Persits.Upload.1")
	'Count= Upload.Save(ruta)
	Upload.Save
	
	Set File = Upload.Files("labd")
	If Not File Is Nothing Then
		nuevo=SoloElFichero(File.Path)
		'response.Write(nuevo)
		File.SaveAs ruta & nuevo
		pafuera=true
	End If
	
	set file=nothing
	set upload=nothing
	
end if 'subir<>""
%>
<html>
<head>
<title>Son Palou</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
<%if pafuera then%>
	/*window.opener.location.reload();*/
	window.close();
<%end if%>
</script>
<style type="text/css">
<!--
body {
	background-image:none;
	background-color: #f2f2f2;
}
-->
</style>
<script language="javascript" type="text/javascript">
	function subir(){
		document.getElementById('afoto').style.visibility='visible';
		document.f1.submit();
	}
</script>
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>?subir=si" enctype="multipart/form-data">
<table width='350' border='0' cellspacing='4' ALIGN='center'>
<tr>
	<td align='right'>Base de Datos:</td>
	<td align="left"><input type="file" name="labd" size="30">
	</td>
</tr>
<tr><td colspan="2" height="30" valign="middle">
	<div id='afoto' style="visibility:hidden" align="center">
	<img src="img/indicator.gif" width="16" height="16" border="0"/>
	</div>
</td></tr>
<tr>
	<td align='center' colspan="2">
		<input type="button" value='Subir' onClick="javascript:subir();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value='Cerrar' onClick="javascript:window.close();">
	</td>
</tr>
</TABLE>
</form>
</body>
</html>
