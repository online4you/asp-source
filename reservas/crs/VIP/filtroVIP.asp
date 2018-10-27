<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre

pasalir=0
cs="WHERE CodigoVIP<>'' "
if request.form<>"" then 'hacer filtro
	bcodigo=request.form("bcodigo")
	if bcodigo<>"" then cs=cs & "AND CodigoVIP='" & bcodigo & "' "
	
	publicidad=request.form("publicidad")
	if publicidad="0" then cs=cs & "AND Informacion=0 "
	if publicidad="1" then cs=cs & "AND Informacion<>0 "
	
	mescumple=paClng(request.form("mescumple"))
	if mescumple<>0 then cs=cs & "AND MONTH(FechaNac)=" & mescumple & " "
	
	bidioma=request.Form("bidioma")
	if bidioma<>"" then cs=cs & "AND IdiomaWeb='" & bidioma & "' "
	
	altadesde=request.Form("altadesde")
	altahasta=request.Form("altahasta")
	if isdate(altadesde) and not isdate(altahasta) then cs=cs & "AND FechaAlta>=" & FechaMySQL(altadesde) & " "
	if not isdate(altadesde) and isdate(altahasta) then cs=cs & "AND FechaAlta<=" & FechaMySQL(altahasta) & " "
	if isdate(altadesde) and isdate(altahasta) then cs=cs & "AND (FechaAlta BETWEEN " & FechaMySQL(altadesde) & " AND " & FechaMySQL(altahasta) & ") "
	
	bnombre=request.Form("bnombre")
	if bnombre<>"" then cs=cs & "AND (Nombre LIKE '%" & ControlAcentos(bnombre) & "%' OR Apellidos LIKE '%" & ControlAcentos(bnombre) & "%') "
	
	response.Cookies("cookieFiltroVIP")=cs
	pasalir=1
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
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['elFrame<%=ff%>'].location="fichas.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function SinFiltro(){
	top.frames['elFrame<%=ff%>'].location="fichas.asp?sf=si&recarga="+self.name;
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">FILTRO DEL LISTADO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?p=<%=pag%>&fc=<%=fc%>&ff=<%=ff%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align='right'>Nombre o Apellidos:</td>
				<td align='left'><input type='text' style='width:220px' maxlength='25' name='bnombre'></td>
			</tr>
			<tr>
				<td align='right'>Código VIP:</td>
				<td align='left'><input type='text' style='width:120px' maxlength='15' name='bcodigo'></td>
			</tr>
			<tr>
				<td align='right'>Fecha Alta:</td>
				<td align='left'>Desde <input type='text' style='width:80px' maxlength='15' name='altadesde'>
				&nbsp;&nbsp;&nbsp;&nbsp;hasta <input type='text' style='width:80px' maxlength='15' name='altahasta'>
				</td>
			</tr>
			<tr>
				<td align='right'>Idioma Web:</td>
				<td align='left'>
				<select name="bidioma">
				<option value="" selected>Cualquiera</option>
				<option value="es">Español</option>
				<option value="en">Inglés</option>
				<option value="de">Alemán</option>
				<option value="fr">Francés</option>
				<option value="it">Italiano</option>
				</select>
				</td>
			</tr>
			<tr>
				<td align='right'>¿Cumpleaños el mes?:</td>
				<td align='left'><input type='text' style='width:30px' maxlength='2' name='mescumple' value="0"> (nº del mes)
				</td>
			</tr>
			<tr>
				<td align='right'>¿Acepta publicidad?:</td>
				<td align='left'>
				<select name="publicidad">
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
