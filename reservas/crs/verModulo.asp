<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

%><!--#include file="actuModulos.asp"--><%

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrsgen & "modulos WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		modulo=rs("modulo")
		descripcion=rs("descripcion")
		programa=rs("programa")
		orden=rs("orden")
		menu=rs("menu")
		superior=rs("moduloSuperior")
	end if
	rs.close
end if

'lista modulos
cs="SELECT Id,Modulo FROM " & precrsgen & "modulos WHERE ModuloSuperior=0 ORDER BY Modulo"
rs.open cs,base
hayTabla=false
if not rs.eof then
	RegTabla=rs.getrows
	TId=0
	TModulo=1
	hayTabla=true
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
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.modulo.value=="" || document.f1.programa.value==""){
		alert("Módulo y programa son obligatorios");
		return false;
	}
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}

</script>
</head>
<body class='laFicha'>
<form name='f1' action="<%=MiPag%>" method="POST">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">M&Oacute;DULO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<table width='100%' border='0' align='center' cellpadding="0" cellspacing="2" style="margin-top:10px;">
	  <tr>
		<td align='right'>Nombre M&oacute;dulo:</td>
		<td align='left'><input type='text' style="width:200px" maxlength='50' name='modulo' value='<%=modulo%>'></td>
	</tr>
	  <tr>
		<td align='right'>Descripci&oacute;n:</td>
		<td align='left'>
		<textarea name="descripcion" style="width:200px; height:60px"><%=descripcion%></textarea>
		</td>
	</tr>
	  <tr>
		<td align='right'>Programa Inicial:</td>
		<td align='left'><input type='text' style="width:200px" maxlength='100' name='programa' value='<%=programa%>'></td>
	</tr>
	  <tr>
		<td align='right'>Orden en el men&uacute;:</td>
		<td align='left'><input type='text' size='5' maxlength='15' name='orden' value='<%=orden%>'></td>
	</tr>
	  <tr>
		<td align='right'>¿Sale en Men&uacute;?</td>
		<td align='left'><input type="checkbox" name='menu' value='-1'<%if menu then response.write " checked"%>></td>
	</tr>
	  <tr>
		<td align='right'>M&oacute;dulo Superior:</td>
		<td align='left'>
		<select name="superior">
		<option value="0">No tiene</option>
		<%if hayTabla then
		for t=0 to ubound(RegTabla,2)
			marca=""
			if RegTabla(TId,t)=superior then marca=" selected"%>
			<option value="<%=RegTabla(TId,t)%>"<%=marca%>><%=RegTabla(TModulo,t)%></option>
		<%next
		end if%>
		</select>
		</td>
	</tr>
	<tr><td colspan="2" align="center">
	<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	</td>
	<%if laid<>0 then 'visualizar el iframe de las aplicaciones del modulo%>
	<tr><td colspan="2" align="center">
		<iframe frameborder="0" hspace="0" vspace="0" src="aplicaciones.asp?idm=<%=laid%>" width="480" height="210"></iframe>
	</td></tr>
	<%end if%>
</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.modulo.focus();
</script>
</body>
</html>