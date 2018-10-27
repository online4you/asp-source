<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

campo=request.querystring("campo")
ancho=paClng(request.QueryString("an"))
alto=paClng(request.QueryString("al"))
recarga=request.querystring("recarga")
'texto=request.QueryString("texto")
'texto=request.form("texto")
'response.write texto & "<br>"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script type="text/javascript" src="/editorHTML/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({
		// General options
		language : "es",
		mode : "textareas",
		theme : "advanced",
		plugins : "safari,pagebreak,style,layer,table,advhr,advimage,advlink,emotions,iespell,preview,searchreplace,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,xhtmlxtras,template,inlinepopups,imagemanager",

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,cut,copy,paste,pastetext,pasteword,bullist,numlist,|,outdent,indent",
		theme_advanced_buttons2 : "link,unlink,anchor,image,cleanup,help,code,|,preview,|,forecolor,backcolor,tablecontrols,hr,removeformat,undo,redo",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		/*theme_advanced_buttons3 : "tablecontrols,hr,removeformat,|,sub,sup,|,emotions,iespell,advhr,|,fullscreen",*/
		/*theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",*/
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : false,
		
		// Example word content CSS (should be your site CSS) this one removes paragraph margins
		content_css : "/nueva.css",

		// Drop lists for link/image/media/template dialogs
		//template_external_list_url : "lists/template_list.js",
		//external_link_list_url : "lists/link_list.js",
		//external_image_list_url : "lists/image_list.js",
		//media_external_list_url : "lists/media_list.js",
		//external_image_list_url : "listaImagenes.asp",
		
		relative_urls : false, // Default value
		document_base_url : 'http://crs.planetaweb.es/',
		remove_script_host : false,
		
		// Replace values for the template plugin
		template_replace_values : {
			username : "Vte",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<script language="javascript" type="text/javascript">
function cerrar() {
	top.quitaFlota(self.name); //quito esa ventana
}
//Vicente
function actu(){
	texto=tinyMCE.activeEditor.getContent();
	//texto=editor.getHTML();
	top<%=recarga%>.cargaTexto('<%=campo%>',texto); //funcion del papi pa ponerl el texto
	cerrar();
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_texto")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<center>
	<textarea name='mensaje' id='mensaje' style="width:<%=ancho%>px; height:<%=alto%>px; margin-top:5px;"></textarea>
    <p>
	<input type="button" value="OK" onClick="javascript:actu();" class='boton86'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="Cerrar" onClick="javascript:cerrar();" class='boton86'><br/>
	<%=objIdioma.getTraduccionHTML("i_notacambio")%>
    </p>
</center>
<script language="javascript" type="text/javascript">
	$('mensaje').value=top<%=recarga%>.document.getElementById('<%=campo%>').value;
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
