<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

est=paClng(request.QueryString("est"))
pasalir=0
%>
<!--#include file="ActuFotosServicio.asp"-->
<%
ids=paClng(request.QueryString("ids"))
cs="SELECT Id,Foto,Orden FROM " & precrs & "ServiciosFotos WHERE IdServicio=" & ids
cs=cs & " ORDER BY Orden,Id"
rs.open cs,base
hayFotos=false
if not rs.eof then
	RegFotos=rs.getrows
	RFId=0
	RFFoto=1
	RFOrden=2
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
		document.f1.action="<%=MiPag%>?modo=nuevo&ids=<%=ids%>&est=<%=est%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&ids=<%=ids%>&idf="+eso+"&est=<%=est%>";

	document.f1.submit();
}

function Subir(esa){
	eval("document.f1.lafoto_"+esa+".src=document.f1.foto_"+esa+".value");
}

function quitaFoto(esa){
	document.f1.action="<%=MiPag%>?p=<%=p%>&ids=<%=ids%>&qf="+esa+"&est=<%=est%>";
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
	parent.cerrar();
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
<body class="laFicha">
<form name='f1' action="<%=MiPag%>?ids=<%=ids%>" method="POST" enctype="multipart/form-data">
<div style="width:930px; margin-top:5px;">
	<table border='0' cellspacing='2' ALIGN='center' cellpadding="0">
		<tr><th align="center" colspan="4" class="tituloFicha" style="text-align:center"><%=objIdioma.getTraduccionHTML("i_subirfotos")%></th></tr>
		<tr>
			<td align="justify" width="320" style="white-space:normal;">&bull;&nbsp;<%=objIdioma.getTraduccionHTML("i_textofotos")%>
			</td>
			<td align='right' width="90">
				<img id='lafoto_0' border='1' src="../img/tr.gif" width="80" height="67" />
			</td>
			<td width="20"></td>
			<td align="left" valign="middle" width="400">
				<input name='foto_0' type="file" size='35' style="width:200px" onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,150,'','','','','','');Subir(0);"><br/>
				<br/>
				<input type='button' id='boton_0' onclick="javascript:Modificar(0);" value='<%=objIdioma.getTraduccionHTML("i_subirfoto")%>' class="boton86">
			</td>
		</tr>
		<tr><th align="center" colspan="4" class="tituloFicha" style="text-align:center"><%=objIdioma.getTraduccionHTML("i_galeriafotos")%></th></tr>
		<tr><td colspan="4" align="center">
			<div style="height:80px; overflow-x:hidden; overflow-y:scroll">
			<%if hayFotos then%>
			<table width='100%' border='0' cellspacing='2' ALIGN='center' cellpadding="0">
			<%colu=1
			for f=0 to ubound(RegFotos,2)
				if colu=1 then response.write "<tr>"%>
				<td align="center" valign="middle">
					<%if RegFotos(RFFoto,f)<>"" then%>
						<img id='lafoto_<%=RegFotos(RFId,f)%>' width="80" src="<%="../" & rutaFotos & "/" & RegFotos(RFFoto,f)%>">
					<%else%>
						<img id='lafoto_<%=RegFotos(RFId,f)%>' border='1' src="../img/tr.gif" width="80" height="67" />
					<%end if%>
				</td>
				<td align="left">
				<input name='foto_<%=RegFotos(RFId,f)%>' type="file" size='25' style="width:200px" onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,150,'','','','','','');Subir(<%=RegFotos(RFId,f)%>);">
				<br/><br/>
				<input type='button' id='boton_<%=RegFotos(RFId,f)%>' onclick="javascript:Modificar(<%=RegFotos(RFId,f)%>);" value='<%=objIdioma.getTraduccionHTML("i_cambiarfoto")%>' class="boton86">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='<%=objIdioma.getTraduccionHTML("i_quitarfoto")%>' class="boton86" onClick="javascript:quitaFoto(<%=RegFotos(RFId,f)%>);">
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
			<%end if 'hayfotos%>
			</div>
		</td></tr>
		<tr><td colspan="4" align="center">
	        <input type='hidden' name='id' value='<%=ids%>'>
      		<input name="button3" type="button" onClick="javascript:Cerrar()" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86">
		</td></tr>
	</TABLE>
</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
