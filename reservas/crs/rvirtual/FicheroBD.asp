<!--#include file="ValidoUser.asp"-->
<!--#include file="funciones.asp"-->
<%

pafuera=false
if request.form<>"" then 'cambiar la BD

	elfiche=request.Form("bd")
	response.Cookies("laBD")=elfiche
	response.cookies("laBD").expires=DateAdd("yyyy",1,date) 
	pafuera=true

end if

if not pafuera then
	set FSO = Server.CreateObject("Scripting.FileSystemObject")
	set oCarpeta = FSO.GetFolder("D:\XVRT\sonpalou.com\data")
	set colFicheros = oCarpeta.Files
	
	dim ficheMDB()
	lista=-1
	'Recorremos la colección de ficheros (objetos File)
	for each fichero in colFicheros
		lista=lista+1
		redim preserve ficheMDB(lista)
		ficheMDB(lista)=fichero.Name
	next 'fichero
	
	set colFicheros = nothing
	set oCarpeta = nothing
	set FSO = nothing
end if 'pafuera
%>
<html>
<head>
<title>Son Palou</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
<%if pafuera then%>
	window.opener.location.reload();
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
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>">
<table width='350' border='0' cellspacing='4' ALIGN='center'>
<tr>
	<td align='right'>Base de Datos:</td>
	<td align="left">
		<select name="bd">
		<%if lista>-1 then
			for l=0 to ubound(ficheMDB)
				marca=""
				if ficheMDB(l)=request.Cookies("laBD") then marca=" selected"%>
				<option value="<%=ficheMDB(l)%>"<%=marca%>><%=ficheMDB(l)%></option>
			<%next
		end if%>
		</select>
	</td>
</tr>
<tr><td colspan="2" height="20"></td></tr>
<tr>
	<td align='center' colspan="2">
		<input type="button" value='Aceptar' onClick="javascript:document.f1.submit();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value='Cerrar' onClick="javascript:window.close();">
	</td>
</tr>
</TABLE>
</form>
</body>
</html>
