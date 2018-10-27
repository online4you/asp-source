<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
%>
<!--#include file="actuTipoServicio.asp"-->
<%
laid=clng(request.QueryString("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT * FROM " & precrs & "TiposServicio WHERE id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre_es=rs("Nombre_es")
		nombre_it=rs("Nombre_it")
		nombre_en=rs("Nombre_en")
		nombre_de=rs("Nombre_de")
		nombre_fr=rs("Nombre_fr")
		foto=rs("foto")
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	if (parent.ultimoFrame=="")
		parent.location="TipoServicio.asp?p=<%=pag%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?modo=actu";

	document.f1.submit();
}
function QuitarFoto(cualo){
	document.f1.action="<%=MiPag%>?quitar="+cualo+"&est=<%=est%>";
	document.f1.submit();
}
function Subir(){
	document.f1.lafoto.src=document.f1.foto.value;
}
</script>

<body class="laFicha">
<div class="tituloFicha" onmousedown="pulsada(top.document.getElementById('verFicha'))" onmouseup="javascript:top.liberaCapa();" onDblClick="javascript:cambiaForma();">
	<div class="nombreFicha">TIPO SERVICIO -> <%=nombre_es%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="post" enctype="multipart/form-data">
<table border="0" align="center" cellpadding="0" cellspacing="0">

  <tr><td class="tdTabla">
      <table width='350' border='0' align='center' cellpadding="0" cellspacing="2">
      <tr>
        <td align='right'>Nombre Esp.</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='nombre_es' value='<%=nombre_es%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Ita.</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='nombre_it' value='<%=nombre_it%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Ing.</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='nombre_en' value='<%=nombre_en%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Ale.</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='nombre_de' value='<%=nombre_de%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Fr.</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='nombre_fr' value='<%=nombre_fr%>'></td>
      </tr>
	  <tr><td colspan="2" align="center">
	  		Tamaño 141x73 px en la home<br/>
			<%if foto<>"" then%>
				<img id='lafoto' <%=vwdImageBounds(rutaFotos & foto,141,73)%> border="1" src="<%=rutaFotos & foto%>">
			<%else%>
				<img id='lafoto' border='1' src="img/tr.gif" width="141" height="73" />
			<%end if%>
			<br />
			<input name='foto' type="file" size='30' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br><br>	
			<input id='quitafoto' type="button" class='boton86' value='Quitar Foto' onclick="javascript:QuitarFoto('foto');" style='cursor:pointer'>
	  </td></tr>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" type='button' class='boton86' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
          <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button3" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
      </tr>
    </table></td></tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.nombre_es.focus();
</script>
</body>
</html>