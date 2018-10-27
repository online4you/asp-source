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
if request.form<>"" then 'hacer filtro
	agencia=paclng(request.form("agencia"))
	if agencia=0 then
		bagencia="Reservas.codAgencia<>0"
	else
		bagencia="Reservas.codAgencia=" & agencia & " "
	end if
	response.Write(hotel & "<br>")
	hotel=clng("0" & request.form("hotel"))
	response.Write(hotel)
	if hotel=0 then
		bhotel="Reservas.CodigoEsta<>0 "
	else
		bhotel="Reservas.CodigoEsta=" & hotel & " "
	end if
	cres=request.form("codres")
	if cres<>"" then bres="Cod_Res=" & cres & " "
	confi=request.form("confi")
	if confi="1" then bconfi="Reservas.activa=0 " 'no cnfirma
	if confi="-1" then bconfi="Reservas.activa<>0 " 'si confirmadas
	frmayor=request.Form("frmayor")
	if frmayor<>"" then bfrmayor="(FechaReserva>=" & FechaMySQL(frmayor) & ") "
	frmenor=request.Form("frmenor")
	if frmenor<>"" then bfrmenor="(FechaReserva<=" & FechaMySQL(frmenor) & ") "

	femayor=request.Form("femayor")
	if femayor<>"" then bfemayor="(FechaIni>=" & FechaMySQL(femayor) & ") "
	femenor=request.Form("femenor")
	if femenor<>"" then bfemenor="(FechaIni<=" & FechaMySQL(femenor) & ") "
	
	
	
	condicion="WHERE YEAR(FechaReserva)=" & anyo & " AND "
	if bagencia<>"" then condicion=condicion & bagencia & " AND "
	if bhotel<>"" then condicion=condicion & bhotel & "AND "
	if bres<>"" then condicion=condicion & bres & "AND "
	if bconfi<>"" then condicion=condicion & bconfi & "AND "
	if frmayor<>"" then condicion=condicion & bfrmayor & "AND "
	if frmenor<>"" then condicion=condicion & bfrmenor & "AND "
	if femayor<>"" then condicion=condicion & bfemayor & "AND "
	if femenor<>"" then condicion=condicion & bfemenor & "AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
	if right(condicion,6)="WHERE " then 'Quitar la condicion
		condicion=""
	end if
	
			
	response.Cookies("filtroresAge")=condicion & " ORDER BY Cod_res DESC"
	pasalir=1
end if
'response.write "buscoH" & buscoHoteles
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
cs="SELECT Id,Nombre FROM " & precrs & "Agencias Agencias " 
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayAgencias=false
if not rs.eof then
	RegAgencias=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayAgencias=true
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
</head>
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
	top.frames[self.name].location="Reservas_agencias.asp?sf=si&recarga="+self.name;
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">FILTRO DEL LISTADO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?recarga=<%=recarga%>&p=<%=pag%>&fc=<%=fc%>&ff=<%=ff%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align='right'>Agencia:</td>
				<td align='left'>
					<select name='agencia'>
						<%if paClng(session("codagencia"))<>0 then 'con agencia%>
							<option value='<%=session("codagencia")%>'><%=session("nomagencia")%></option>
						<%else 'no es nivel agencia%>
							<option value='0'>Todas</option>
							<%if hayagencias then
								for k=0 to ubound(RegAgencias,2)%>
								<option value='<%=RegAgencias(HCodi,k)%>'><%=RegAgencias(HNombre,k)%></option>
							<%next
							end if%>
						<%end if 'cdoagencia%>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'>Establecimiento:</td>
				<td align='left'>
					<select name='hotel'>
						<option value='0'>Todos</option>
						<%for h=0 to ubound(RegHoteles,2)%>
							<option value='<%=RegHoteles(HCodi,h)%>'><%=RegHoteles(HNombre,h)%></option>
						<%next%>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'>Cod. Reserva:</td>
				<td align='left'><input type='text' size='15' maxlength='10' name='codres'></td>
			</tr>
			<tr>
				<td align='right'>Fecha Reserva:</td>
				<td align='left'>Mayor o igual a <input type='text' size='15' maxlength='10' name='frmayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'>Menor o igual a <input type='text' size='15' maxlength='10' name='frmenor'></td>
			</tr>
			<tr>
				<td align='right'>Fecha Llegada:</td>
				<td align='left'>Mayor o igual a <input type='text' size='15' maxlength='10' name='femayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'>Menor o igual a <input type='text' size='15' maxlength='10' name='femenor'></td>
			</tr>
			<tr>
				<td align='right'>¿Confirmada?:</td>
				<td align='left'>
					<select name='confi'>
						<option value='0'>Todas</option>
						<option value='-1'>S&iacute;</option>
						<option value='1'>No</option>
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
	document.f1.hotel.focus();
</script>
</body>
</html>
