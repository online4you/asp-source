<!--#include file="includes/FunGestion.asp"-->
<!--#include file="include/vwd_imgbounds.asp" -->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

base.Open Conecta
'Coger las fotos de la tabla
id=request.QueryString("idf")
if id<>"" then 'Buscar el regsitro
	ver=request.QueryString("ver")
	cs="SELECT * "
	select case ver
		case "sh" 'Situacion hotel
			cs=cs & "FROM " & precrs & "SituacionHotel SituacionHotel "
		case "seh" 'Servicios
			cs=cs & "FROM " & precrs & "ServiciosHotel ServiciosHotel "
		case "pre" 'Presentacion
			cs=cs & "FROM " & precrs & "PresentacionHotel PresentacionHotel "
		case "enh" 'Entorno
			cs=cs & "FROM " & precrs & " EntornoHotel EntornoHotel "
		case "hah" 'Entorno
			cs=cs & "FROM " & precrs & "HabitacionesHotel HabitacionesHotel "
		case "fh" 'Galearia fotos
			cs=cs & "FROM " & precrs & "FotosHotel FotosHotel "
	end select
	cs=cs & "WHERE CodigoEsta=" & id
	rs.open cs,base
	if not rs.eof then
		foto1=rs("foto1")
		foto2=rs("foto2")
		if ver="fh" then 'tiene mas fotos
			foto3=rs("foto3")
			foto4=rs("foto4")
			foto5=rs("foto5")
			foto6=rs("foto6")
		end if
	end if
	rs.close
end if	
set rs=nothing
base.close
set base=nothing
%>


<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%if request.QueryString("otravez")<>1 then%>
	<META HTTP-EQUIV="Refresh" CONTENT="1; URL=<%=MiPag%>?idf=<%=id%>&ver=<%=ver%>&otravez=1">
<%end if%>
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.botones {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #000000;
	background-color: #FFFFFF;
	width: 75px;
}
body {
	background-image:none;
	background-color:#F2F2F2;
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

</script>
<body class="tdTabla">
<form name='f2' method="post" enctype="multipart/form-data" action='SubirFotosHotel.asp'>
<input type='hidden' name='id' value='<%=id%>'>
<input type='hidden' name='ver' value='<%=ver%>'>
<input type='hidden' name='quitar' value=''>
<table width='100%' border='0' cellspacing='0' ALIGN='center'>
<tr>
	<td align='right'>
		<%if foto1<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto1,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto1%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto1' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto1');">
	</td>
	<td align='right'>
		<%if foto2<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto2,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto2%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto2' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto2');">
	</td>
	
</tr>
<%if ver="fh" then 'Resto de las fotos %>
<tr>
	<td align='right'>
		<%if foto3<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto3,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto3%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto3' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto3');">
	</td>
	<td align='right'>
		<%if foto4<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto4,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto4%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto4' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto4');">
	</td>
</tr>

<tr>
	<td align='right'>
		<%if foto5<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto5,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto5%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto5' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto5');">
	</td>
	<td align='right'>
		<%if foto6<>"" then%>
			<img <%=vwdImageBounds(rutafotos & "/Ficha_" & foto6,100,75)%> border="1" src="<%=rutafotos & "/Ficha_" & foto6%>">
		<%else%>
			<div align='center' style='border: 1px solid #003366; width:100; height:75'>Sin foto</div>
		<%end if%>
	</td>
	<td align='left'>
		<input name='foto6' type="file" size='15' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br>	
		<input type="button" value='Quitar Foto' onclick="javascript:QuitarFoto('foto6');">
	</td>
</tr>

<%end if%>

</TABLE>
</form>
<div id='panelespera' style='z-index:20; position:absolute; top:45; left:300;visibility:hidden; height:40; width:120' class='panel'>
	<div id='espera' align='center'>
	<br>Subiendo Foto</div>
</div>
</body>
</html>
