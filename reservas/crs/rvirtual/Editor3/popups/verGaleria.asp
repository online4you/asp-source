<!--#include file="../../../includes/FunGestion.asp"-->
<!--#include file="../../../includes/claseCookie.asp"-->
<!--#include file="vwd_imgbounds.asp"-->
<html>
<head>
<title>Galer&iacute;a de Im&aacute;genes</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font: 11px Tahoma,Verdana,sans-serif;
	background: ButtonFace;
	color: ButtonText;
}
form {margin:0px;}
table {
  font: 9px Tahoma,Verdana,sans-serif;
}
input {
	font: 11px Tahoma,Verdana,sans-serif;
}
button,submit {
	font: 11px Tahoma,Verdana,sans-serif;
	cursor:pointer;
}
-->
</style></head>
<script language="javascript">
var afoto=null;
function marca(esa){
	if (afoto!=null)
		afoto.style.border='none';
		
	esa.style.border="2px solid #ff0000";
	opener.reCarga(esa.src);
	afoto=esa;
	//alert(esa.src);
}
</script>
<body>
<center>
<div class="button">PULSAR SOBRE LA IMAGEN PARA SELECCIONARLA</div>
</center>
<fieldset style="float: left; margin-left: 5px;">
<legend>Galería imágenes</legend>
<div style="width:600px; height:370px; overflow:auto">
<table border='0' cellspacing='5' cellpadding="0" ALIGN='left'>
<%
rfotos=rutaFotos
Set fs = Server.CreateObject("Scripting.FileSystemObject")
Set lista_archivos = fs.GetFolder(Server.MapPath(rfotos))

maxc=5
nc=1
'Mostramos los archivos...
For each filefound in lista_archivos.files
	if nc=1 then response.write "<tr>"
	response.write "<td align='center'><div style='width:110px; height:110px; border:1px solid #000000'>"
	Response.Write "<div style='height:15px'>" & filefound.datecreated & "</div>"
	Response.Write "<div style='height:60px'>"
	response.write "<img src='" & rfotos & filefound.Name & "' width='80' height='60' onclick='javascript:marca(this);'></div>"
	response.write "<div style='height:35px'>" & ori_width & " x " & ori_height & "<br>"
	response.write filefound.Name & "<br>"
	Response.Write "(" & formatnumber((filefound.size / 1024),2,-1,0) & " Kb)"
	response.write "</div></div></td>"
	nc=nc+1
	if nc=6 then
		response.write "</tr>"
		nc=1
	end if
Next
if nc<6 then response.write "</tr>"

set lista_archivos=nothing
set fs=nothing
%>
</TABLE>
</div>
<br>
</fieldset>
</body>
</html>
