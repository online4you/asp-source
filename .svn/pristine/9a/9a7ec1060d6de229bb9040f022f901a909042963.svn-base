<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

ff=paClng(request.QueryString("ff"))
fc=paClng(request.QueryString("fc"))
idm=paClng(request.QueryString("idm"))
%><!--#include file="actuAplicaciones.asp"--><%

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrsgen & "Aplicaciones WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		boton=rs("NombreBoton")
		descripcion=rs("descripcion")
		ayuda=rs("ayuda")
		programa=rs("programa")
		orden=rs("orden")
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
	/*encogeCapa(parent.document.getElementById('verApli'));
	parent.document.getElementById('verApli').style.visibility='hidden';*/
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	if (parent.ultimoFrame=="")
		parent.location="aplicaciones.asp?idm=<%=idm%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.boton.value=="" || document.f1.programa.value==""){
		alert("Nombre y programa son obligatorios");
		return false;
	}
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&idm=<%=idm%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&idm=<%=idm%>&recarga=<%=recarga%>";

	document.f1.submit();
}

</script>
<body class='laFicha'>
<form name='f1' action="<%=MiPag%>" method="POST">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">APLICACIÓN</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<table width='100%' border='0' align='center' cellpadding="0" cellspacing="2" style="margin-top:10px;">
	  <tr>
		<td align='right'>Nombre en menú:</td>
		<td align='left'><input type='text' style="width:230px" maxlength='25' name='boton' value='<%=boton%>'></td>
	</tr>
	  <tr>
		<td align='right'>Descripción:</td>
		<td align='left'>
		<textarea name="descripcion" style="width:230px; height:60px"><%=descripcion%></textarea>
		</td>
	</tr>
	  <tr>
		<td align='right'>Programa Inicial:</td>
		<td align='left'><input type='text' style="width:230px" maxlength='25' name='programa' value='<%=programa%>'></td>
	</tr>
	  <tr>
		<td align='right'>Texto Ayuda:</td>
		<td align='left'>
		<textarea name="ayuda" style="width:230px; height:120px"><%=ayuda%></textarea>
		</td>
	</tr>
	  <tr>
		<td align='right'>Orden en el menú:</td>
		<td align='left'><input type='text' size='5' maxlength='15' name='orden' value='<%=orden%>'>
		&nbsp;Valor númerico a partir de 0
		</td>
	</tr>
	<tr><td colspan="2" align="center">
	<input id='boton2' type='button' value='Actualizar' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	</td>
</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton2').value='Añadir';
	<%end if%>
	document.f1.boton.focus();
</script>
</body>
</html>