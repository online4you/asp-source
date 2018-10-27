<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

pasalir=0
if request.form<>"" then 'hacer filtro
	hotel=clng("0" & request.form("hotel"))
	if hotel=0 then
		cadena=replace(buscoHoteles,"WHERE ","")
		cadena=replace(cadena,"Establecimientos.","Reservas.")
		if cadena<>"" then
			bhotel="(" & cadena & ") " '"Reservas.CodigoEsta<>0 "
		else
			bhotel="Reservas.CodigoEsta<>0 "
		end if
		'response.write "buscoHoteles: "&buscoHoteles
	else
		bhotel="Reservas.CodigoEsta=" & hotel & " "
	end if
	cres=request.form("codres")
	if cres<>"" then bres="Cod_Res in (" & cres & ") "
	confi=request.form("confi")
	if confi="1" then bconfi="Reservas.activa=0 " 'no cnfirma
	if confi="-1" then bconfi="Reservas.activa<>0 " 'si confirmadas
	frmayor=request.Form("frmayor")
	if frmayor<>"" then bfrmayor="(Reservas.FechaReserva>=" & FechaMySQL(frmayor) & ") "
	frmenor=request.Form("frmenor")
	if frmenor<>"" then bfrmenor="(Reservas.FechaReserva<=" & FechaMySQL(frmenor) & ") "

	femayor=request.Form("femayor")
	if femayor<>"" then bfemayor="(Reservas.FechaIni>=" & FechaMySQL(femayor) & ") "
	femenor=request.Form("femenor")
	if femenor<>"" then bfemenor="(Reservas.FechaIni<=" & FechaMySQL(femenor) & ") "
	
	anulada=request.form("anulada")
	if anulada="1" then banulada="Anulada=0 " 'no anulada
	if anulada="-1" then banulada="Anulada<>0 " 'si anuladas
	
	condicion="WHERE YEAR(Reservas.FechaReserva)=" & anyo & " AND "

	if bhotel<>"" then condicion=condicion & bhotel & "AND "
	if bres<>"" then condicion=condicion & bres & "AND "
	if bconfi<>"" then condicion=condicion & bconfi & "AND "
	if frmayor<>"" then condicion=condicion & bfrmayor & "AND "
	if frmenor<>"" then condicion=condicion & bfrmenor & "AND "
	if femayor<>"" then condicion=condicion & bfemayor & "AND "
	if femenor<>"" then condicion=condicion & bfemenor & "AND "
	if banulada<>"" then condicion=condicion & banulada & "AND "
	
	bpromocion=request.Form("cpromocion")
	if bpromocion<>"" then condicion=condicion & "CodigoPromocion='" & bpromocion & "' AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
	if right(condicion,6)="WHERE " then 'Quitar la condicion
		condicion=""
	end if
	
			
	response.Cookies("filtrores")=condicion & " ORDER BY Cod_res DESC"
	'response.End()
	pasalir=1
end if

cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
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
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function SinFiltro(){
	top.frames['<%=recarga%>'].location="ListaReservas.asp?sf=si";
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_filtrolistado")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?recarga=<%=recarga%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align='right'>Hotel:</td>
				<td align='left'>
					<select name='hotel'>
						<option value='0'><%=objIdioma.getTraduccionHTML("i_todo")%></option>
						<%for h=0 to ubound(RegHoteles,2)%>
							<option value='<%=RegHoteles(HCodi,h)%>'><%=RegHoteles(HNombre,h)%></option>
						<%next%>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_reserva")%>:</td>
				<td align='left'><input type='text' size='15' maxlength='10' name='codres'></td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_freserva")%>:</td>
				<td align='left'><%=objIdioma.getTraduccionHTML("i_desdedia")%><input type='text' size='15' maxlength='10' name='frmayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'><%=objIdioma.getTraduccionHTML("i_hastadia")%><input type='text' size='15' maxlength='10' name='frmenor'></td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_fllegada")%>:</td>
				<td align='left'><%=objIdioma.getTraduccionHTML("i_desdedia")%><input type='text' size='15' maxlength='10' name='femayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'><%=objIdioma.getTraduccionHTML("i_hastadia")%><input type='text' size='15' maxlength='10' name='femenor'></td>
			</tr>
           <!-- <tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_promocion")%></td>
				<td align='left'><input type='text' size='25' maxlength='50' name='cpromocion'></td>
			</tr>
			-->
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_confirmadas")%>:</td>
				<td align='left'>
					<select name='confi'>
						<option value='0'><%=objIdioma.getTraduccionHTML("i_todas")%></option>
						<option value='-1'><%=objIdioma.getTraduccionHTML("i_si")%></option>
						<option value='1'><%=objIdioma.getTraduccionHTML("i_no")%></option>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_anuladas")%>:</td>
				<td align='left'>
					<select name='anulada'>
						<option value='0'><%=objIdioma.getTraduccionHTML("i_todas")%></option>
						<option value='-1'><%=objIdioma.getTraduccionHTML("i_si")%></option>
						<option value='1' selected><%=objIdioma.getTraduccionHTML("i_no")%></option>
					</select>
				</td>
			</tr>
			<tr><td align='center' colspan='2'>
				<input type='submit' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_filtrar")%>' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='<%=objIdioma.getTraduccionHTML("i_sinfiltro")%>' class="boton86" onclick="javascript:SinFiltro();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>"></table>
		</td></tr></table>
	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	document.f1.hotel.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
