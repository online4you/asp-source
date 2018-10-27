<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

pl=clng("0" & request.QueryString("pl"))
mimensaje=""
if pl>0 then 'cargar la plantilla
	cs="SELECT Plantilla FROM " & precrs & "PlantillasNews "
	cs=cs & "WHERE Id=" & pl
	rs.open cs,base
	if not rs.eof then
		mimensaje=rs("plantilla")
	end if
	rs.close
end if

'Tabla plantillas
cs="SELECT Id,Nombre FROM " & precrs & "PlantillasNews "
rs.open cs,base
hayplanti=false
if not rs.eof then
	RegPlanti=rs.getrows
	PlCodi=0
	PlNombre=1
	hayplanti=true
end if
rs.close

totreg=0
'Pongo el filtro 
cs=request.Cookies("envioFiltro")
rs.open cs,base
if not rs.eof then
	LosReg=rs.GetRows 'Los pongo en la tabla
	totreg=ubound(losreg,2)+1
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript" src="/editorHTML/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({
		// General options
		language : "es",
		mode : "textareas",
		theme : "advanced",
		plugins : "safari,pagebreak,style,layer,table,advhr,advimage,advlink,emotions,iespell,preview,searchreplace,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,xhtmlxtras,template,inlinepopups,imagemanager,filemanager,fullpage",

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,cut,copy,paste,pastetext,pasteword,bullist,numlist,|,outdent,indent,blockquote,undo,redo",
		theme_advanced_buttons2 : "link,unlink,anchor,image,cleanup,help,code,|,preview,|,forecolor,backcolor,tablecontrols,hr,removeformat,|,sub,sup,|,emotions,iespell,advhr,|,fullscreen",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		/*theme_advanced_buttons3 : "tablecontrols,hr,removeformat,|,sub,sup,|,emotions,iespell,advhr,|,fullscreen",*/
		/*theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",*/
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : false,
		
		// Example word content CSS (should be your site CSS) this one removes paragraph margins
		content_css : "/4.0/componentes/editorHTML/css/word.css",

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
<script language="javascript">
	//Comprobar si tiene asunto
	function Envia(){
		document.f1.mensaje.value=tinyMCE.activeEditor.getContent();
		if (document.f1.mensaje.value.length==0){
			alert("Hay poner un Mensaje");
			document.f1.mensaje.focus();
			return false;
		}
		if (document.f1.asunto.value.length==0){
			alert("Hay que poner Asunto");
			document.f1.asunto.focus();
			return false;
		}
		document.f1.submit();
	}	
	
	function cargaPlantilla(esta){
		window.location="<%=MiPag%>?pl="+esta.value;
	}
	
	function guardarPlantilla(){
		//document.f1.mensaje.value=editor.getHTML(); //recarga
		asu=document.f1.plantilla.options[document.f1.plantilla.selectedIndex].text;
		fichero=prompt("Escribir el nombre de la Plantilla",asu);
		if (fichero!=""){
			document.f1.action="grabaPlantilla.asp?volver=<%=MiPag%>&titu="+fichero;
			document.f1.submit();
		}
	}
	
	function borrarPlantilla(){
		pl=document.f1.plantilla.value;
		if (confirm("¿Está seguro/a?")){
			document.f1.action="grabaPlantilla.asp?volver=<%=MiPag%>&pl="+pl;
			document.f1.submit();
		}
	}
</script>
<body>
<!--#include file="../capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' action="EnvioMail.asp" method="POST">
      <table border="0" cellpadding="0" cellspacing="0" width="750">
        <tr> 
          <td align="left"> Total registros seleccionados <b><%=totreg%></b><br/> 
            <table border="0" cellspacing="0" cellpadding="0" width="760">
              <tr>
                <td align="left" valign="bottom"> Responder a 
                  <input type="text" name="remite" style="width:200px;" value="<%=remite_Cuenta%>" maxlength="100">
                  <br/>
                  Asunto&nbsp;* <%=msg%><br/> <input name="asunto" type="text" style="width:300px" maxlength='100'> 
                </td>
                <td align="right" valign="bottom"> Seleccionar plantilla 
                  <select name="plantilla" onChange="javascript:cargaPlantilla(this);">
                    <option value="0"<%if pl=0 then response.write " selected"%>>Ninguna</option>
                    <%if hayplanti then
						for pp=0 to ubound(RegPlanti,2)
							marca=""
							if RegPlanti(PlCodi,pp)=pl then marca=" selected"%>
                    <option value="<%=RegPlanti(PlCodi,pp)%>"<%=marca%>><%=RegPlanti(PlNombre,pp)%></option>
                    <%next
						end if%>
                  </select> <br/> <input type='button' value='Enviar EMail' class="boton145" onclick='javascript:Envia();' style="margin-bottom:0px;"> 
                  <input type="button" onClick="guardarPlantilla()" value="Guardar Plantilla" class="boton145" style="margin-bottom:0px;"> 
                  <input type="button" onClick="borrarPlantilla()" value="Borrar Plantilla" class="boton145" style="margin-bottom:0px;"> 
                </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height='10'></td>
        </tr>
        <tr> 
          <td class="tituloTabla">&nbsp;&middot;Mensaje:</td>
        </tr>
        <tr> 
          <td><textarea name='mensaje' id='mensaje' style="width:700px; height:550px"><%=mimensaje%></textarea></td>
        </tr>
        <tr> 
          <td align='center'> <br> <input type='button' value='Enviar EMail' class="boton145" onclick='javascript:Envia();'> 
          </td>
        </tr>
        <tr>
          <td height='10'></td>
        </tr>
      </table>
    </form>
    <script language="JavaScript">
		document.f1.asunto.focus();
	</script>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="../pieFrame.asp"-->
</body>
</html>
