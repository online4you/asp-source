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
	
	pais=Request.Form("pais")
	if pais <> "" then cs=cs & " AND Pais='" & pais & "' "
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

	fnacdesde=request.Form("fnacdesde")
	fnachasta=request.Form("fnachasta")
	if isdate(fnacdesde) and not isdate(fnachasta) then cs=cs & "AND FechaNac>=" & FechaMySQL(fnacdesde) & " "
	if not isdate(fnacdesde) and isdate(fnachasta) then cs=cs & "AND FechaNac<=" & FechaMySQL(fnachasta) & " "
	if isdate(fnacdesde) and isdate(fnachasta) then cs=cs & "AND (FechaNac BETWEEN " & FechaMySQL(fnacdesde) & " AND " & FechaMySQL(fnachasta) & ") "
	
	desdeanyo=paClng(request.Form("desdeanyo"))
	hastaanyo=paClng(request.Form("hastaanyo"))
	if desdeanyo<>0 then 
		if hastaanyo=0 then hastaanyo=desdeanyo
		cs=cs & "AND ((YEAR(FechaNac1) BETWEEN " & desdeanyo & " AND " & hastaanyo & ") OR "
		cs=cs & "(YEAR(FechaNac2) BETWEEN " & desdeanyo & " AND " & hastaanyo & ") OR "
		cs=cs & "(YEAR(FechaNac3) BETWEEN " & desdeanyo & " AND " & hastaanyo & ")) "
	end if
	
	comprobado=request.form("comprobado")
	if comprobado="0" then cs=cs & "AND Activo=0 "
	if comprobado="1" then cs=cs & "AND Activo<>0 "

	conemail=request.form("conemail")
	if conemail="0" then cs=cs & "AND Email='' "
	if conemail="1" then cs=cs & "AND Email<>'' "


	bnombre=request.Form("bnombre")
	if bnombre<>"" then cs=cs & "AND (Nombre LIKE '%" & ControlAcentos(bnombre) & "%' OR Apellidos LIKE '%" & ControlAcentos(bnombre) & "%') "
	
	response.Cookies("cookieFiltroVIP")=cs
	pasalir=1
end if

set rs=nothing
base.close
set base=nothing

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'tabla paises
cs="SELECT IdCountry,CountryName FROM " & precrs & "tbl_Paises tbl_Paises WHERE IdLanguage='es' ORDER BY CountryName"
rs.open cs,base
hayPais=false
if not rs.eof then
	RegPais=rs.getrows
	PCodi=0
	PNombre=1
	haypais=true
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
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="fichas.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function SinFiltro(){
	top.frames['<%=recarga%>'].location="fichas.asp?sf=si";
	cerrar();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">FILTRO DEL LISTADO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?p=<%=pag%>&recarga=<%=recarga%>" method="POST">
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
              <td align='right'>Pais:</td>
			  <td align='left'>
                <select name='pais'>
                    <option value=''>Seleccione</option>
                <%if haypais then
                for p=0 to ubound(RegPais,2)
                    marca=""
                    if RegPais(PCodi,p)=pais then marca=" selected"%>
                    <option value='<%=RegPais(PCodi,p)%>'<%=marca%>><%=RegPais(PNombre,p)%></option>
                <%next
                end if%>
                </select>
               </td>
            </tr>
            <tr>
				<td align='right'>Fecha Alta:</td>
				<td align='left'>Desde <input type='text' style='width:80px' maxlength='15' name='altadesde'>
				&nbsp;&nbsp;&nbsp;&nbsp;hasta <input type='text' style='width:80px' maxlength='15' name='altahasta'>
				</td>
			</tr>
			<tr>
				<td align='right'>Fecha Nacim.:</td>
				<td align='left'>Desde <input type='text' style='width:80px' maxlength='15' name='fnacdesde'>
				&nbsp;&nbsp;&nbsp;&nbsp;hasta <input type='text' style='width:80px' maxlength='15' name='fnachasta'>
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
				<td align='right'>Beneficiario nacido año:</td>
				<td align='left'>
                <input type='text' style='width:50px' maxlength='4' name='desdeanyo' value="0">
                &nbsp;&nbsp;&nbsp;&nbsp;Hasta 
                <input type='text' style='width:50px' maxlength='4' name='hastaanyo' value="0">
				</td>
			</tr>
            <tr>
				<td align='right'>¿con email?:</td>
				<td align='left'>
				<select name="conemail">
				<option value="" selected>Todas</option>
				<option value="1">Si</option>
				<option value="0">No</option>
				</select>
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
			<tr>
				<td align='right'>¿Comprobadas?:</td>
				<td align='left'>
				<select name="comprobado">
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
