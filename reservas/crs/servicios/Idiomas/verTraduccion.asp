<!--#include file="includes/FunGestion.asp"-->
<!--#include file="claseIdioma.asp"-->
<%
elCharSet="iso-8859-1"
elCodePage="1252" 'por defecto
'encoding de la pagina
response.Charset=elCharSet 'las traducciones del administrador en ISO-8859-1
session.CodePage=elCodePage

tipo=request.QueryString("tipo")
if tipo="web" then rutaXML=server_path & "reservas/bookingFront/IdiomaXML/"

set objIdioma = new clsIdioma 'español

lang="es"
set objIdioma_es = new clsIdioma 'español
lang="en"
set objIdioma_en = new clsIdioma 'ingles
lang="de"
set objIdioma_de = new clsIdioma 'aleman
'lang="bg"
'set objIdioma_bg = new clsIdioma 'bulgarian
lang="pt"
set objIdioma_pt = new clsIdioma 'portugues
lang="fr"
set objIdioma_fr = new clsIdioma 'frances
lang="it"
set objIdioma_it = new clsIdioma 'italiano

%><!--#include file="actuTraduccion.asp"--><%

recarga=request.QueryString("recarga") 'id del frame de la ventana
etiqueta=request.QueryString("id")
laid=request.QueryString("id")
if etiqueta<>"" then 'buscar las traducciones
	texto_es=objIdioma_es.getTraduccionHTML(etiqueta)
	detalle=objIdioma_es.getDetalle(etiqueta)
	texto_en=objIdioma_en.getTraduccionHTML(etiqueta)
	texto_de=objIdioma_de.getTraduccionHTML(etiqueta)
	texto_pt=objIdioma_pt.getTraduccionHTML(etiqueta)
	texto_fr=objIdioma_fr.getTraduccionHTML(etiqueta)
	texto_it=objIdioma_it.getTraduccionHTML(etiqueta)

else'es nuevo registro o duplicado

	etiqueta=request.form("etiqueta")
	texto_es=request.form("texto_es")
	texto_en=request.form("texto_en")
	texto_de=request.form("texto_de")
	texto_pt=request.form("texto_pt")
	texto_fr=request.form("texto_fr")
	texto_it=request.form("texto_it")
	detalle=request.form("detalle")
	
end if

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?modo=nuevo&tipo=<%=tipo%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&tipo=<%=tipo%>&recarga=<%=recarga%>";
		
	document.f1.submit();
}

function Duplicar(){
	document.f1.action="<%=MiPag%>?id=&tipo=<%=tipo%>&recarga=<%=recarga%>";
	document.f1.submit();
}

function salta(){
	document.f1.texto_es.focus();
}
</script>
</head>
<body class="laFicha" style="min-height:420px;">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">TRADUCCION ->&nbsp;<%=etiqueta%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="post">
<table border="0" align="left" cellpadding="0" cellspacing="0" style="margin-top:10px;">
  <tr>
    <td class="tdTabla">
    
      <table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
        <tr>
          <td align="left" colspan="3">Etiqueta:&nbsp;
		  <input type='text' name='etiqueta' value="<%=etiqueta%>" style='width:200px' maxlength="100"<%if not adminboss then response.write " readonly"%>>
          </td>
        </tr>
        <tr>
          <td align="left">Traducci&oacute;n Esp.:	<input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_es',680,400);" onFocus="javascript:salta()">
		  </td>
		  <td align="left">Traducci&oacute;n Ing.:	<input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_en',680,400);">
		  </td>
		   <td align="left">Traducci&oacute;n Ale.: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_de',680,400);">
		   </td>
         </tr>
		  <tr>
		  	<td align="left">
		  	<textarea name='texto_es' id='texto_es' style="width:185px; height:80px;"><%=texto_es%></textarea>
          </td>
		  <td align="left">          
		  <textarea name='texto_en' id='texto_en' style="width:185px; height:80px;"><%=texto_en%></textarea>
          </td>
		  <td align="left">         
			<textarea name='texto_de' id='texto_de' style="width:185px; height:80px;"><%=texto_de%></textarea>
          </td>
         </tr>
         <tr>
		   <td align="left">Traducci&oacute;n Fra.: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_fr',680,400);">
		   </td>
		   <td align="left">Traducci&oacute;n Por.: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_pt',680,400);">
		   </td>
		   <td align="left">Traducci&oacute;n Ita.: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_it',680,400);">
		   </td>
		  </tr>
         <tr>
		  <td align="left">          
			<textarea name='texto_fr' id='texto_fr' style="width:185px; height:80px;"><%=texto_fr%></textarea>
          </td>
		  <td align="left">          
			<textarea name='texto_pt' id='texto_pt' style="width:185px; height:80px;"><%=texto_pt%></textarea>
          </td>
		  <td align="left">          
			<textarea name='texto_it' id='texto_it' style="width:185px; height:80px;"><%=texto_it%></textarea>
          </td>
        <tr>
          <td colspan='3' align="left">Detalles:<br/>
          <textarea name='detalle' style='width:350px; height:60px'><%=detalle%></textarea></td>
        </tr>
        <tr>
          <td colspan="3" height='5'></td>
        </tr>
        <tr>
          <td align='center' colspan="3">
            <input name="boton2" type='button' class="boton86" id='boton2' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=etiqueta%>'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	  		</td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</form>
<script language="javascript" type="text/javascript" charset='utf-8'>
<%if laid="" then%>
	document.getElementById('boton2').value='Añadir';
	document.f1.etiqueta.focus();
<%else%>
	document.f1.texto_es.focus();
<%end if%>
</script>
<!--#include file="pieTraduccion.asp"-->
</body>
</html>
