<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla hoteles
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


recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre

pasalir=0
if request.form<>"" then 'hacer filtro
	bnombre=request.form("nombre")
	bape=request.form("apellidos")
	info=request.form("info")
	if info="1" then binfo="informacion=0 " 'no public
	if info="-1" then binfo="informacion<>0 " 'si public
	
	confir=request.form("confir")
	if confir="1" then bconfir="Reservas.Activa<>0 " 'SI confirmada
	if confir="0" then bconfir="Reservas.Activa=0 " 'NO confirmada
	
	fadesde=request.Form("fadesde")
	if fadesde<>"" then bfecha="(FechaAlta>=" & FechaMySQL(fadesde) & ") "
	fahasta=request.Form("fahasta")
	if fahasta<>"" then bfecha="(FechaAlta<=" & FechaMySQL(fahasta) & ") "
	if fahasta<>"" AND fadesde<>"" then 
		bfecha="(FechaAlta BETWEEN " & FechaMySQL(fadesde) & " AND " & FechaMySQL(fahasta) & ") "
	end if
	bidioma=request.Form("idioma")
	bhotel=request.Form("bhotel")

	condicion="WHERE EMail<>'' AND "

	if bnombre<>"" then condicion=condicion & "Nombre LIKE '%" & controlAcentos(bnombre) & "%' AND "
	if bape<>"" then condicion=condicion & "Apellidos LIKE '%" & controlAcentos(bape) & "%' AND "
	if info<>"" then condicion=condicion & binfo & "AND "
	if confir<>"" then condicion=condicion & bconfir & "AND "
	if bfecha<>"" then condicion=condicion & bfecha & "AND "
	if bidioma<>"" then condicion=condicion & "IdiomaWeb='" & bidioma & "' AND "
	if bhotel<>"" then condicion=condicion & "CodigoEsta=" & bhotel & " AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
			
	response.Cookies("cookieFiltroLCli")=condicion '& " ORDER BY Cod_res DESC"
	'response.write condicion
	'response.End()
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
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="ListaClientes.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function SinFiltro(){
	top.frames['<%=recarga%>'].location="ListaClientes.asp?sf=si";
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccion("i_filtrolistado")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?p=<%=pag%>&recarga=<%=recarga%>" method="POST">
<table id='contenido' border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
		<table align='center' width='400' border='0' cellpadding="0" cellspacing="2" style="margin-top:10px;">
		<tr>
			<td align='right'>Hotel:</td>
			<td align="left">
				<select name='bhotel' style="width:230px">
				<option value="">Todos</option>
				<%if hayHoteles then
					for h=0 to ubound(RegHoteles,2)%>
						<option value='<%=RegHoteles(HCodi,h)%>'<%=marca%>><%=RegHoteles(HNombre,h)%></option>
					<%next
				end if%>
				</select>
			</td></tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccion("i_nombre")%>:</td>
				<td align='left'>
					<input type='text' style="width:150px;" maxlength='50' name='nombre'>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccion("i_apellidos")%>:</td>
				<td align='left'>
					<input type='text' style="width:150px;" maxlength='50' name='apellidos'>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccion("i_fechaalta")%>:</td>
				<td align='left'><%=objIdioma.getTraduccion("i_desdedia")%>&nbsp;<input type='text' size='15' maxlength='10' name='fadesde'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'><%=objIdioma.getTraduccion("i_hastadia")%>&nbsp;<input type='text' size='15' maxlength='10' name='fahasta'></td>
			</tr>
			<tr>
				<td align="right"><%=objIdioma.getTraduccion("i_idioma")%>:</td>
				<td align="left">
				<select name="idioma" style='width:80px'>
					<option value=""><%=objIdioma.getTraduccion("i_cualquiera")%></option>
					<option value="es"><%=objIdioma.getTraduccion("i_espanol")%></option>
					<option value="en"><%=objIdioma.getTraduccion("i_ingles")%></option>
					<option value="de"><%=objIdioma.getTraduccion("i_aleman")%></option>
					<option value="fr"><%=objIdioma.getTraduccion("i_frances")%></option>
					<option value="it"><%=objIdioma.getTraduccion("i_italiano")%></option>
				</select>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccion("i_publicidad")%>:</td>
				<td align='left'>
					<select name='info'>
						<option value=''><%=objIdioma.getTraduccion("i_todas")%></option>
						<option value='-1'><%=objIdioma.getTraduccion("i_si")%></option>
						<option value='1'><%=objIdioma.getTraduccion("i_no")%></option>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccion("i_confirmadas")%>:</td>
				<td align='left'>
					<select name='confir'>
						<option value=''><%=objIdioma.getTraduccion("i_todas")%></option>
						<option value='1'><%=objIdioma.getTraduccion("i_si")%></option>
						<option value='0'><%=objIdioma.getTraduccion("i_no")%></option>
					</select>
				</td>
			</tr>
			<tr><td align='center' colspan='2'>
				<input type='submit' class="boton86" value='<%=objIdioma.getTraduccion("i_filtrar")%>' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='<%=objIdioma.getTraduccion("i_sinfiltro")%>' class="boton86" onclick="javascript:SinFiltro();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccion("i_cerrar")%>"></table>
		</td></tr></table>
	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	document.f1.nombre.focus();
</script>
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>
