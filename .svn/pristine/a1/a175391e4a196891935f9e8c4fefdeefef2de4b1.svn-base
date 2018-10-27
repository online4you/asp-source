<!--#include file="includes/funciones.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open ConectaMDB

pasalir=0
pag=paClng(request.QueryString("p"))
ids=paClng(request.QueryString("ids"))
idh=paClng(request.QueryString("idh"))

%>
<!--#include file="ActuFotos.asp"-->
<%

cs="SELECT Id,Foto FROM " & precrs & "FotosHotel WHERE IdHotel=" & idh & " AND IdSeccion=" & ids & " ORDER BY Id"
rs.open cs,base
hayFotos=false
if not rs.eof then
	RegFotos=rs.getrows
	RFId=0
	RFFoto=1
	hayfotos=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
</head>
<script language="javascript">
function Modificar(eso){
	//efecto cargando 
	if (eval("document.f1.foto_"+eso+".value!=''"))
		Subiendo();
		
	if (eso==0)
		document.f1.action="<%=MiPag%>?modo=nuevo&p=<%=pag%>&ids=<%=ids%>&idh=<%=idh%>&idf="+eso;
	else
		document.f1.action="<%=MiPag%>?modo=actu&p=<%=pag%>&ids=<%=ids%>&idh=<%=idh%>&idf="+eso;

	document.f1.submit();
}

function Subir(esa){
	eval("document.f1.lafoto_"+esa+".src=document.f1.foto_"+esa+".value");
}

function quitaFoto(esa){
	document.f1.action="<%=MiPag%>?ids=<%=ids%>&idh=<%=idh%>&p=<%=pag%>&qf="+esa;
	document.f1.submit();
}

function Subiendo(){
	document.getElementById('boton_0').value='Subiendo Foto';
	document.getElementById('boton_0').style.visibility='hidden';
	reloj=setTimeout('parpadeo()',100);
}
var texto=true;
function parpadeo(){
	if (texto)
		document.getElementById('boton_0').style.visibility='visible';
	else
		document.getElementById('boton_0').style.visibility='hidden';
	
	texto=!(texto);
	reloj=setTimeout('parpadeo()',600);
}

function Cerrar(){
	parent.Cerrar();
	/*encogeCapa(top.document.getElementById('verHotel'));
	top.document.getElementById('verHotel').style.visibility='hidden';*/
}
<%if pasalir=1 then%>
	Cerrar();
<%end if%>
</script>
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

</script>
<body>
<form name='f1' action="" method="POST" enctype="multipart/form-data">
<div style="margin:auto; width:860px;">
	<div style="clear:both;">
		<table width='100%' border='0' cellspacing='2' ALIGN='center' cellpadding="0">
		<tr><th align="center" colspan="4">Subir nuevas fotos</th></tr>
		<tr>
			<td align="justify" width="320">&bull;&nbsp;Fotos del hotel, el sistema genera tres tamaños, el mayor será de 600px de ancho. Conviene que el nombre de la foto no tenga espacios en blanco, acentos o carácteres especiales, y tambien se aconseja poner en el nombre de la foto el nombre del hotel (posicionamiento en buscador). Se considera que es la foto principal la primera que se sube.
			</td>
			<td align='right'>
				<img id='lafoto_0' border='1' src="img/tr.gif" width="80" height="67" />
			</td>
			<td width="20"></td>
			<td align="left" valign="middle">
				<input name='foto_0' type="file" size='25' style="width:150px" onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,150,'','','','','','');Subir(0);"><br/>
				<br/>
				<input type='button' id='boton_0' onclick="javascript:Modificar(0);" value='Subir Foto' class="boton">
			</td>
		</tr>
		<tr><td height="5" colspan="4"></td></tr>
		<tr><th align="center" colspan="4">Galería de fotos</th></tr>
		<tr><td colspan="4" align="center">
		<%if hayFotos then%>
			<div style="height:200px; overflow-x:hidden; overflow-y:scroll">
			<table width='100%' border='0' cellspacing='2' ALIGN='center' cellpadding="0">
			<%colu=1
			for f=0 to ubound(RegFotos,2)
				if colu=1 then response.write "<tr>"%>
				<td align="center" valign="middle">
					<%if RegFotos(RFFoto,f)<>"" then%>
						<img id='lafoto_<%=RegFotos(RFId,f)%>' width="80" src="<%=rutaFotos & RegFotos(RFFoto,f)%>">
					<%else%>
						<img id='lafoto_<%=RegFotos(RFId,f)%>' border='1' src="img/tr.gif" width="80" height="67" />
					<%end if%>
				</td>
				<td align="left">
				<input name='foto_<%=RegFotos(RFId,f)%>' type="file" size='25' style="width:150px" onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,150,'','','','','','');Subir(<%=RegFotos(RFId,f)%>);">
				<br/><br/>
				<input type='button' id='boton_<%=RegFotos(RFId,f)%>' onclick="javascript:Modificar(<%=RegFotos(RFId,f)%>);" value='Cambiar Foto' class="boton">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='Quitar Foto' class="boton" onClick="javascript:quitaFoto(<%=RegFotos(RFId,f)%>);">
				</td>
				<td width="10"></td>
				<%
				colu=colu+1
				if colu=3 then
					response.Write "</tr>"
					colu=1
				end if
			next 'f%>
			</table>
			</div>
		<%end if 'hayfotos%>
		</td></tr>
		<tr><td colspan="4" align="center">
	        <input type='hidden' name='id' value='<%=laid%>'>
      		<input name="button3" type="button" onClick="javascript:Cerrar()" value="Cerrar" class="boton">
		</td></tr>
		</TABLE>
	</div> <!-- -->
</div>
</form>
</body>
</html>
