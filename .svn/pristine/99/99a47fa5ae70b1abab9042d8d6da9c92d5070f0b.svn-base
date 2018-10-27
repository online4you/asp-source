<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

%><!--#include file="actuAgencias.asp"--><%

laid=paClng(request.QueryString("id"))
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrs & "Agencias WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		email=rs("email")
		direccion=rs("direccion")
		cp=rs("cp")
		poblacion=rs("poblacion")
		Pais=rs("pais")
		Obs=rs("observaciones")
		activa=rs("activa")
		usuario=rs("Usuario")
		clave=rs("clave")
		Comision=rs("comision")
		BAL=rs("BAL")
		contacto=rs("contacto")
		telefono=rs("telefono")
		fax=rs("fax")
		sistema=rs("sistema")
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
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="fichas.asp?lang=<%=lang%>";
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.nombre.value=="" ){
		alert("Nombre es obligatorio");
		return false;
	}
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}

</script>
<body class='laFicha'>
<form name='f1' action="<%=MiPag%>" method="POST">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">AGENCIA</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<table width='100%' border='0' align='center' cellpadding="0" cellspacing="2" style="margin-top:10px;">
	  <tr>
		<td align='right'>Nombre Agencia:</td>
		<td align='left'><input type='text' style="width:200px" maxlength='75' name='nombre' value='<%=nombre%>'></td>
	</tr>
	  <tr>
		<td align='right'>Dirección:</td>
		<td align='left'>
		<input type="text" name="direccion" style="width:200px;" maxlength='75'value="<%=direccion%>">
		</td>
	</tr>
	  <tr>
		<td align='right'>Población:</td>
		<td align='left'><input type='text' style="width:200px" maxlength='75' name='poblacion' value='<%=poblacion%>'></td>
	</tr>
	<tr>
		<td align='right'>País:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='75' name='pais' value='<%=pais%>'></td>
	</tr>
	<tr>
		<td align='right'>CP:</td>
		<td align='left'><input type='text' style='width:100px' maxlength='10' name='cp' value='<%=cp%>'></td>
	</tr>
	<tr>
		<td align='right'>Email:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='50' name='email' value='<%=email%>'></td>
	</tr>
	<tr>
		<td align='right'>Telefono:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='50' name='telefono' value='<%=telefono%>'></td>
	</tr>
	<tr>
		<td align='right'>Fax:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='25' name='fax' value='<%=fax%>'></td>
	</tr>
	<tr>
		<td align='right'>Comisión:</td>
		<td align='left'><input type='text' style='width:100px'  name='comision' value='<%=comision%>'></td>
	</tr>
	<tr>
		<td align='right'>CIF/NIF:</td>
		<td align='left'><input type='text' style='width:100px'  name='bal' value='<%=BAL%>'></td>
	</tr>
	<tr>
		<td align='right'>Contacto:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='75' name='contacto' value='<%=contacto%>'></td>
	</tr>
	<tr>
		<td align='right'>Usuario:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='25' name='usuario' value='<%=usuario%>'></td>
	</tr>
	<tr>
		<td align='right'>Clave:</td>
		<td align='left'><input type='text' style='width:200px' maxlength='25' name='clave' value='<%=clave%>'></td>
	</tr>
	  <tr>
		<td align='right'>Activa:</td>
		<td align='left'><input type="checkbox" name='activa' value='-1'<%if activa OR laid=0 then response.write " checked"%>></td>
	</tr>
	<tr>
		<td align='right'>Observaciones:</td>
		<td align='left'><textarea  style='width:200px;height:80px' name='obs'><%=obs%></textarea></td>
	</tr>
	<tr><td colspan="2" align="center">
	<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	</td>
</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.nombre.focus();
</script>
</body>
</html>