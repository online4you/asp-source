<!--#include file="../../../includes/FunGestion.asp"-->
<html>
<head>
<title></title>
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
  font: 11px Tahoma,Verdana,sans-serif;
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
function checkFileUpload(form,extensions,requireUpload,sizeLimit,minWidth,minHeight,maxWidth,maxHeight,saveWidth,saveHeight) { //v2.09
  document.MM_returnValue = true;
  for (var i = 0; i<form.elements.length; i++) {
    field = form.elements[i];
    if (field.type.toUpperCase() != 'FILE') continue;
    checkOneFileUpload(field,extensions,requireUpload,sizeLimit,minWidth,minHeight,maxWidth,maxHeight,saveWidth,saveHeight);
} }

function checkOneFileUpload(field,extensions,requireUpload,sizeLimit,minWidth,minHeight,maxWidth,maxHeight,saveWidth,saveHeight) { //v2.09
  document.MM_returnValue = true;
  if (extensions != '') var re = new RegExp("\.(" + extensions.replace(/,/gi,"|").replace(/\s/gi,"") + ")$","i");
    if (field.value == '') {
      if (requireUpload) {alert('Hace falta el fichero!');document.MM_returnValue = false;return;}
    } else {
      if(extensions != '' && !re.test(field.value)) {
        alert('No se permite subir ese tipo de fichero.\nSólo las siguientes extensiones están permitidas: ' + extensions + '.\nPor favor seleccione otro fichero y vuelva a intentarlo.');
        document.MM_returnValue = false;return;
      }
    document.PU_uploadForm = field.form;
    re = new RegExp(".(gif|jpg|png|bmp|jpeg)$","i");
    if(re.test(field.value) && (sizeLimit != '' || minWidth != '' || minHeight != '' || maxWidth != '' || maxHeight != '' || saveWidth != '' || saveHeight != '')) {
      checkImageDimensions(field,sizeLimit,minWidth,minHeight,maxWidth,maxHeight,saveWidth,saveHeight);
    } }
}

function showImageDimensions(fieldImg) { //v2.09
  var isNS6 = (!document.all && document.getElementById ? true : false);
  var img = (fieldImg && !isNS6 ? fieldImg : this);
  if (img.width > 0 && img.height > 0) {
  if ((img.minWidth != '' && img.minWidth > img.width) || (img.minHeight != '' && img.minHeight > img.height)) {
    alert('¡Uploaded Image is too small!\nShould be at least ' + img.minWidth + ' x ' + img.minHeight); return;}
  if ((img.maxWidth != '' && img.width > img.maxWidth) || (img.maxHeight != '' && img.height > img.maxHeight)) {
    alert('¡La imagen es demasiado grande!\nComo máximo tiene que ser ' + img.maxWidth + ' x ' + img.maxHeight); return;}
  if (img.sizeLimit != '' && img.fileSize > img.sizeLimit) {
    alert('¡El tamaño del fichero es muy grande!\nComo máximo tiene que ser de ' + (img.sizeLimit/1024) + ' KBytes'); return;}
  if (img.saveWidth != '') document.PU_uploadForm[img.saveWidth].value = img.width;
  if (img.saveHeight != '') document.PU_uploadForm[img.saveHeight].value = img.height;
  document.MM_returnValue = true;
} }

function checkImageDimensions(field,sizeL,minW,minH,maxW,maxH,saveW,saveH) { //v2.09
  if (!document.layers) {
    var isNS6 = (!document.all && document.getElementById ? true : false);
    document.MM_returnValue = false; var imgURL = 'file:///' + field.value.replace(/\\/gi,'/').replace(/:/gi,'|').replace(/"/gi,'').replace(/^\//,'');
    if (!field.gp_img || (field.gp_img && field.gp_img.src != imgURL) || isNS6) {field.gp_img = new Image();
		   with (field) {gp_img.sizeLimit = sizeL*1024; gp_img.minWidth = minW; gp_img.minHeight = minH; gp_img.maxWidth = maxW; gp_img.maxHeight = maxH;
  	   gp_img.saveWidth = saveW; gp_img.saveHeight = saveH; gp_img.onload = showImageDimensions; gp_img.src = imgURL; }
	 } else showImageDimensions(field.gp_img);}
}

function Subir(){
	if (document.f2.foto1.value==""){
		alert("Primero pulsar sobre Examinar para indicar la imagen");
		return false;
	}
	document.getElementById('panelespera').style.visibility='visible';
	reloj=setTimeout('parpadeo()',100);
	document.f2.submit();
}

function QuitarFoto(cualo){
	document.f2.quitar.value=cualo;
	document.f2.submit();
}

var texto=true;
function parpadeo(){
	if (texto)
		document.getElementById('espera').style.visibility='visible';
	else
		document.getElementById('espera').style.visibility='hidden';
	
	texto=!(texto);
	reloj=setTimeout('parpadeo()',600);
}
<%
img=request.QueryString("img")
rutagal=rutafotos
if img<>"" then%>
	parent.document.getElementById('f_url').value="<%=rutagal & img%>";
	parent.onPreview();
<%end if%>
function reCarga(cualo){
	parent.document.getElementById('f_url').value=cualo;
	parent.onPreview();
}
function abreGaleria(){
	ancho=610;
	alto=420;
	l=(parseInt(screen.width)/2)-(ancho/2);
	t=(parseInt(screen.height)/2)-(alto/2);
	window.open("verGaleria.asp","","top="+t+",left="+l+",width="+ancho+",height="+alto+",status=no");
}
</script>
<body>
<form name='f2' method="post" enctype="multipart/form-data" action='SubirImg.asp' onSubmit="return Subir();">
<fieldset style="float: left; margin-left: 5px;">
<legend>Galería imágenes</legend>
<table width='400' border='0' cellspacing='0' ALIGN='center'>
<tr>
	<td align='left'>
		<input name='foto1' type="file" size='50' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,150,'','','','','','');">
		</td>
</tr>
<tr><td height="5"></td></tr>
<tr><td align="left">
	Tamaño máx. ancho: <input type="text" name="ancho" value="0" size="4" maxlength="5">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Tamaño máx. alto: <input type="text" name="alto" value="0" size="4" maxlength="5"><br>
	(dejando 0 mantiene el tamaño original)
	</td>
</tr>
<tr><td height="5"></td></tr>
<tr><td align="center">
	<input type="submit" value='Subir imagen a la galería'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value='Ver galería imágenes' onClick="javascript:abreGaleria();">
</td></tr>
</TABLE>
</fieldset>
</form>
<div id='panelespera' style='z-index:20; position:absolute; top:20px; left:150px;visibility:hidden; height:20px; width:120px; background-color:#FFFFFF'>
	<div id='espera' align='center'>Subiendo Imagen</div>
</div>
</body>
</html>
