<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

ids=paClng(request.QueryString("ids")) 'id seccion 
idh=paClng(request.QueryString("idh")) 'codigo hotel
pasalir=0

server.ScriptTimeout=3000

%><!--#include file="actuFotosSeccionHotel.asp"--><%

cs="SELECT Id,Foto,Orden "
cs=cs & "FROM " & precrs & "FotosHotel WHERE IdSeccion=" & ids & " ORDER BY Orden,Id"
rs.open cs,base
hayFotos=false
if not rs.eof then
	RegFotos=rs.getrows
	RCodi=0
	RFoto=1
	ROrden=2
	hayFotos=true
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
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.cerrar(); //quito esa ventana
}

function Modificar(esa){
	if (compruebaFoto(document.getElementById('foto_'+esa))) {
		Subiendo(esa);
		if (esa==0)
			document.f1.action="<%=MiPag%>?modo=nuevo&ids=<%=ids%>&idh=<%=idh%>";
		else
			document.f1.action="<%=MiPag%>?modo=actu&ids=<%=ids%>&idh=<%=idh%>&idf="+esa;
		document.f1.submit();
	}
}

function quitaFoto(esa){
	document.f1.action="<%=MiPag%>?ids=<%=ids%>&idh=<%=idh%>&qf="+esa;
	document.f1.submit();
}

function Subiendo(cuala){
	$('imgfoto_'+cuala).style.visibility='visible';
}

function compruebaFoto(eseFile) {
	if (!checkOneFileUpload(eseFile,'GIF,JPG,JPEG,BMP,PNG',true,200,'','','','','','')) {
		$(eseFile.name).set('value',"");
		return false;
	}
	return true;
}

function cambiaOrden(esa) {
	idfoto=esa.name.split("_")[1];
	recarga=parent.parent.name+"."+parent.name+"."+self.name;
	url="actuOrdenFotos.asp?tabla=FotosHotel&idf="+idfoto+"&ord="+esa.value+"&recarga="+recarga;
	//alert(url);
	top.document.getElementById("paProcesos").src=url;
}
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
  if (extensions != '') var re = new RegExp("\.(" + extensions.replace(/,/gi,"|").replace(/\s/gi,"") + ")$","i");
    if (field.value == '') {
      if (requireUpload) {alert('Hace falta el fichero!');return false;}
    } else {
      if(extensions != '' && !re.test(field.value)) {
        alert('No se permite subir ese tipo de fichero.\nSólo las siguientes extensiones están permitidas: ' + extensions + '.\nPor favor seleccione otro fichero y vuelva a intentarlo.');
        return false;
      }
    document.PU_uploadForm = field.form;
    re = new RegExp(".(gif|jpg|png|bmp|jpeg)$","i");
    if(re.test(field.value) && (sizeLimit != '' || minWidth != '' || minHeight != '' || maxWidth != '' || maxHeight != '' || saveWidth != '' || saveHeight != '')) {
      checkImageDimensions(field,sizeLimit,minWidth,minHeight,maxWidth,maxHeight,saveWidth,saveHeight);
    } }
	return true;
}

function showImageDimensions(fieldImg) { //v2.09
  var isNS6 = (!document.all && document.getElementById ? true : false);
  var img = (fieldImg && !isNS6 ? fieldImg : this);
  alert(img.sizeLimit);
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
    document.MM_returnValue = false; 
	var imgURL = 'file:///' + field.value.replace(/\\/gi,'/').replace(/:/gi,'|').replace(/"/gi,'').replace(/^\//,'');
    if (!field.gp_img || (field.gp_img && field.gp_img.src != imgURL) || isNS6) {field.gp_img = new Image();
		   with (field) {gp_img.sizeLimit = sizeL*1024; gp_img.minWidth = minW; gp_img.minHeight = minH; gp_img.maxWidth = maxW; gp_img.maxHeight = maxH;
  	   gp_img.saveWidth = saveW; gp_img.saveHeight = saveH; gp_img.onload = showImageDimensions; gp_img.src = imgURL; }
	 } else showImageDimensions(field.gp_img);}
}

</script>
</head>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="post" enctype="multipart/form-data">
<div style="height:380px; width:<%=maxAncho%>px; overflow-x:hidden;">		

	<table width='100%' border='0' cellspacing='2' ALIGN='center' cellpadding="0">
		<tr><th align="center" colspan="4" class="tituloFicha"><%=objIdioma.getTraduccionHTML("i_subirfotos")%></th></tr>
		<tr>
			<td align="justify" width="320"><%=objIdioma.getTraduccionHTML("i_textofotos")%></td>
			<td width="20"></td>
			<td align="left" valign="middle" colspan="2">
				<input name='foto_0' id='foto_0' type="file" size='40' style="height:17px">
                <br><br>
				<input type='button' id='boton_0' onclick="javascript:Modificar(0);" value='Subir Foto' class="boton86">
                &nbsp;&nbsp;<img id='imgfoto_0' src="img/espera.gif" style="visibility:hidden" width="16" height="16">
			</td>
		</tr>
		<tr><td height="5" colspan="4"></td></tr>
		<tr><th align="center" colspan="4" class="tituloFicha"><%=objIdioma.getTraduccionHTML("i_galeriafotos")%></th></tr>
		<tr><td colspan="4" align="center">
		<%if hayFotos then%>
			<div style="height:240px; overflow-x:hidden; overflow-y:scroll">
			<table width='100%' border='0' cellspacing='15' ALIGN='center' cellpadding="0">
			<%colu=1
			for f=0 to ubound(RegFotos,2)
				if colu=1 then response.write "<tr>"%>
				<td align="center" valign="middle">
					<%if RegFotos(RFoto,f)<>"" then
						mifoto=rutaFotos & "Th_" & RegFotos(RFoto,f)
						if not existeFichero(mifoto) then mifoto=rutaFotos & RegFotos(RFoto,f)
						%>
						<img id='lafoto_<%=RegFotos(RCodi,f)%>' width="100" src="<%=mifoto%>">
					<%end if%>
				</td>
				<td align="left" style="line-height:20px;"><%=objIdioma.getTraduccionHTML("i_ordenvisual")%>: 
                <select name="orden_<%=RegFotos(RCodi,f)%>" onChange="javascript:cambiaOrden(this)">
                <%for ff=0 to 15
				marca=""
				if RegFotos(ROrden,f)=ff then marca=" selected"%>
                <option value="<%=ff%>"<%=marca%>><%=ff%></option>
                <%next%>
                </select><br/>
				<input name='foto_<%=RegFotos(RCodi,f)%>' id='foto_<%=RegFotos(RCodi,f)%>' type="file" size='30' style="width:200px; height:17px" onChange="javascript:compruebaFoto(this);">
				<br/>
				<input type='button' id='boton_<%=RegFotos(RCodi,f)%>' onclick="javascript:Modificar(<%=RegFotos(RCodi,f)%>);" value='<%=objIdioma.getTraduccionHTML("i_cambiarfoto")%>' class="boton86">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='<%=objIdioma.getTraduccionHTML("i_quitarfoto")%>' class="boton86" onClick="javascript:quitaFoto(<%=RegFotos(RCodi,f)%>);">
                &nbsp;&nbsp;<img id='imgfoto_<%=RegFotos(RCodi,f)%>' src="img/espera.gif" style="visibility:hidden" width="16" height="16">
				</td>
				<td width="5"></td>
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
	</TABLE>
</div>
<center>
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>