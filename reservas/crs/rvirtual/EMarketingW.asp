<!--#include file="validoUser.asp"-->
<!--#include file="Funciones.asp"-->
<html>
<head>
<title>Son Palou</title>
<link href="css.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<!-- Configure the path to the editor.  We make it relative now, so that the
    example ZIP file will work anywhere, but please NOTE THAT it's better to
    have it an absolute path, such as '/htmlarea/'. -->
<script type="text/javascript">
  _editor_url = "Editor3/";
  _editor_lang = "es";
</script>
<script type="text/javascript" src="Editor3/htmlarea.js"></script>
<script type="text/javascript" src="Editor3/htmlarea_css.js"></script>
<script type="text/javascript">
var editor = null;
function initEditor() {
  editor = new HTMLArea("mensaje");

	/*editor.config.toolbar =
	  [
		["bold","italic","underline","strikethrough","separator"],
		["forecolor","hilitecolor","separator"],
		["justifyleft","justifycenter","justifyright","justifyfull","separator"],
		["createlink","separator"],
		["killword","removeformat","separator","htmlmode"]
	  ];*/

  // comment the following two lines to see how customization works
  //editor.generate();
  //return false;

  var cfg = editor.config; // this is the default configuration
  cfg.fullPage=true;
  cfg.pageStyle = "body { background-color: #efd; } .hilite { background-color: yellow; } "+
                  ".sample { color: green; font-family: monospace; }";
				  
  editor.generate();
}
function insertHTML() {
  var html = prompt("Enter some HTML code here");
  if (html) {
    editor.insertHTML(html);
  }
}
function highlight() {
  editor.surroundHTML('<span style="background-color: yellow">', '</span>');
}
</script>
<script language="javascript">
	//Comprobar si tiene asunto
	function Envia(){
		if (document.f1.mensaje.value!="")
			document.f1.mensaje.value=editor.getHTML();
			
		if (document.f1.asunto.value.length==0){
			alert("Hay que poner Asunto");
			document.f1.asunto.focus();
			return false;
		}
		if (document.f1.mensaje.value.length==0){
			alert("Hay poner un Mensaje");
			document.f1.mensaje.focus();
			return false;
		}
		document.f1.submit();
	}	
	
	function cargaPlantilla(esta){
		window.location="<%=MiPag%>?pl="+esta.value;
	}
	
	function guardarPlantilla(){
		document.f1.mensaje.value=editor.getHTML(); //recarga
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="initEditor()">
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open CONmailing

pl=clng("0" & request.QueryString("pl"))
mimensaje=""
if pl>0 then 'cargar la plantilla
	cs="SELECT Plantilla FROM " & precrs & "PlantillasNews PlantillasNews "
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

base.close
base.Open ConectaMDB


'COmpruebo si hay filtro y caso contrario se añaden todas
cs="SELECT nombre,apellidos,EMail FROM " & precrs & "FormulariosWeb "
condicion=request.Cookies("cookieFiltroW")
if condicion="" then condicion="WHERE EMail<>'' " 'por defecto
cs=cs & condicion
rs.open cs,base
if not rs.eof then
	CNom=0
	CApe=1
	CEmail=2
	dim LosReg
	LosReg=rs.GetRows 'Los pongo en la tabla
	totreg=ubound(losreg,2)+1
end if
rs.close

set rs=nothing
base.close
set base=nothing

%>
<form name='f1' action="EnvioMail<%=sufijo%>.asp" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top' width="680" style="padding-left:5px;">
		<img src="img/transparente.gif" width="2" height="20"><br />
		<div style="padding-bottom:10px;">Base de Datos: <b><%=ucase(request.Cookies("laBD"))%></b></div>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr> 
			<td align="left">
				Total registros seleccionados <b></b><%=totreg%></b><br/>
				<table width="700" border="0" cellspacing="0">
				<tr><td align="left">
					<div class="cabeceraTitu" style="width:300px;">&nbsp;&middot;Asunto&nbsp;* <%=msg%></div> 
					</td>
					<td rowspan="2">
					<input type="button" onClick="guardarPlantilla()" value="Guardar Plantilla" style="cursor:pointer; padding-bottom:2px;"><br/>
					<input type="button" onClick="borrarPlantilla()" value="Borrar Plantilla" style="cursor:pointer">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  Cargar plantilla 
					  <select name="plantilla" onChange="javascript:cargaPlantilla(this);">
					  <option value="0"<%if pl=0 then response.write " selected"%>>No usar</option>
					  <%if hayplanti then
						for pp=0 to ubound(RegPlanti,2)
							marca=""
							if RegPlanti(PlCodi,pp)=pl then marca=" selected"%>
							<option value="<%=RegPlanti(PlCodi,pp)%>"<%=marca%>><%=RegPlanti(PlNombre,pp)%></option>
						<%next
					end if%>
					  </select>
					</td>
				</tr>
				<tr><td align="left">
					<input name="asunto" type="text" style="width:300px" maxlength='100'>
				</td></tr>
				</table>
			</td>
			</tr>
			<tr><td height='10' colspan="2"></td></tr>
			<tr> 
			<td class="cabeceraTitu" height="16">&nbsp;&middot;<strong> Mensaje:</strong></td>
			</tr>
			<tr> 
				<td height="19" colspan='2'><textarea name='mensaje' id='mensaje' style="width:700px; height:800px"><%=mimensaje%></textarea></td>
			</tr>
			<tr>
				<td align='center' colspan='2'>
				<br>
				<input type='button' value='Enviar Correos' style='cursor:hand' onclick='javascript:Envia();'>
				</td>
			</tr>
			<tr><td height='10'></td></tr>
			</table>
			</td></tr>
		</table>
		
</td></tr>
</table>		
</form>

<script language="JavaScript">
	document.f1.asunto.focus();
</script>
</body>
</html>
