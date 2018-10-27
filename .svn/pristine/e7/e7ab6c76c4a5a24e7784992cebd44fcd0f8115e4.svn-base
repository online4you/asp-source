<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

pasalir=0
cs="WHERE id<>'' "
if request.form<>"" then 'hacer filtro
	bcodigo=request.form("bcodigo")
	if bcodigo<>"" then cs=cs & "AND id='" & bcodigo & "' "
	
	comision1=paDbl(QuitarComa(request.form("comision1")))
	comision2=paDbl(QuitarComa(request.form("comision2")))
	if comision1<>0 then
		if comision2<>0 then 
			cs=cs & "AND (comision BETWEEN " & comision1 & " AND " & comision2 & ") "
		else
			cs=cs & "AND comision>=" & comision1 & " "
		end if
	else
		if comision2<>0 then cs=cs & "AND comision<=" & comision2 & " "
	end if
	bnombre=request.Form("bnombre")
	if bnombre<>"" then cs=cs & "AND (Nombre LIKE '%" & ControlAcentos(bnombre) & "%') "
	pais=request.Form("pais")
	if pais<>"" then cs=cs & "AND (Pais LIKE '%" & ControlAcentos(pais) & "%' ) "
	localidad=request.Form("localidad")
	if localidad<>"" then cs=cs & "AND (Localidad LIKE '%" & ControlAcentos(localidad) & "%' ) "
	contacto=request.Form("contacto")
	if contacto<>"" then cs=cs & "AND (Contacto LIKE '%" & ControlAcentos(contacto) & "%' ) "
	
	response.Cookies("cookieFiltroAge")=cs
	pasalir=1
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
	top.quitaFlota(self.name); //quito esta ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="fichas.asp?lang=<%=lang%>";
	cerrar();
<%end if%>

function SinFiltro(){
	top.frames['<%=recarga%>'].location="fichas.asp?lang=<%=lang%>&sf=si";
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">FILTRO DEL LISTADO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?lang=<%=lang%>&recarga=<%=recarga%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align='right'>Agencia:</td>
				<td align='left'><input type='text' style='width:220px' maxlength='25' name='bnombre'></td>
			</tr>
			<tr>
				<td align='right'>Id:</td>
				<td align='left'><input type='text' style='width:120px' maxlength='15' name='bcodigo'></td>
			</tr>
			<tr>
				<td align='right'>País:</td>
				<td align='left'><input type='text' style='width:80px' maxlength='15' name='pais'>
				</td>
			</tr>
			<tr>
				<td align='right'>Localidad:</td>
				<td align='left'><input type='text' style='width:80px' maxlength='15' name='localidad'></td>
			</tr>
			<tr>
				<td align='right'>Comision:</td>
				<td align='left'>Mayor o igual:<input type='text' style='width:30px' maxlength='10' name='comision1' > Menor o igual :<input type='text' style='width:30px' maxlength='10' name='comision2' >
				</td>
			</tr>
			<tr>
				<td align='right'>Activas:</td>
				<td align='left'>
				<select name="activas">
				<option value="" selected>Todas</option>
				<option value="1">Si</option>
				<option value="0">No</option>
				</select>
				</td>
			</tr>

			<tr><td align='center' colspan='2'>
				<input type='submit' class="boton86" value='Filtrar' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='Sin Filtro' class="boton86" onclick="javascript:SinFiltro();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></table>
		</td></tr></table>
	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	document.f1.bnombre.focus();
</script>
</body>
</html>
