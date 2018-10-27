<!--#include file="includes/FunGestion.asp"-->
<%
filtro=request.querystring("filtro")
if filtro="0" then response.Cookies("consultac2m")=""

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.form("filtro")<>"" then 'Realizar el filtro de la página
	confi=request.form("confi")
	if confi="1" then bconfi="activa=0 " 'no cnfirma
	if confi="-1" then bconfi="activa<>0 " 'si confirmadas
	frmayor=request.Form("frmayor")
	if frmayor<>"" then bfrmayor="(FechaAlta>=" & FechaMySQL(frmayor) & ") "
	frmenor=request.Form("frmenor")
	if frmenor<>"" then bfrmenor="(FechaAlta<=" & FechaMySQL(frmenor) & ") "

	femayor=request.Form("femayor")
	if femayor<>"" then bfemayor="(FechaIni>=" & FechaMySQL(femayor) & ") "
	femenor=request.Form("femenor")
	if femenor<>"" then bfemenor="(FechaIni<=" & FechaMySQL(femenor) & ") "
	
	condicion="WHERE "

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
	
	'Crear consulta 
	response.Cookies("consultac2m")=condicion
end if

condicion=request.Cookies("consultac2m")
if condicion="" then 'por defecto
	'confi="-1"
	'condicion="WHERE Activa<>0 "
end if

'Lista de registros
cs="SELECT Reservas.CodigoEsta,Establecimientos.Nombre,SUM(Importe) as TPelas,COUNT(*) as cuantas "
cs=cs & "FROM (" & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) INNER JOIN Fichas "
cs=cs & "ON Reservas.IdCliente=Fichas.Id " & condicion
cs=cs & " GROUP BY Reservas.CodigoEsta,Establecimientos.Nombre ORDER BY TPelas DESC"
'response.write cs & "<br>"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNombre=1
	RPelas=2
	RCuantas=3
	haylista=true

	PorPag=38
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("P")
	if Pag="" then Pag=MaxP 'Para que ponga la ultima
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close

'Buscar OBS
cs="SELECT Obs FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	lasObs="" & rs("obs")
end if
rs.close

set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style></head>
<script language="javascript">
function SinFiltro(){
	window.location="<%=MiPag%>?est=<%=est%>&filtro=0";
}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<img src="img/tr.gif" width="1" height="40"/><br/>
	<table align='center' width="600">
	<tr><td align='left'>
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" value='&nbsp;Filtrar Listado&nbsp;' onclick="javascript:document.getElementById('filtro').style.visibility='visible';">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' value='Quitar Filtro' onclick="javascript:SinFiltro();" style='cursor:pointer'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">RANKING C2M</div></td></tr>
  <tr><td valign="bottom" class="tdTabla">
	
      <table width='450' border="0" align='center' cellpadding="0" cellspacing="0" class="tdTabla">
      <tr class='cabetabla'>
		<th align='left' class="colu_par">Hotel</th>
        <th align='right'>Importe Total</th>
        <th align='right'>Nº Reservas</th>
		<th align='right'>Promedio</th>
      </tr>
      <%if haylista then
	  	sumapelas=0
		sumacuantas=0
	for R=IReg to IReg+PorPag-1
		if R>ubound(RegLista,2) then exit for
		sumapelas=sumapelas+RegLista(RPelas,r)
		sumacuantas=sumacuantas+RegLista(RCuantas,r)
		%>
      <tr>
        <td align="left" class='<%=laColu(0)%>' >
			<%=RegLista(RNombre,r)%>
		</td>
        <td align="right" class='<%=laColu(0)%>' > <%=formatnumber(RegLista(RPelas,r),2)%> </td>
        <td align="right" class='<%=laColu(0)%>' ><%=RegLista(RCuantas,r)%></td>
		<td align="right" class='<%=laColu(0)%>' >
		<%promod=redondear(RegLista(RPelas,r)/RegLista(RCuantas,r))%>
		<%=formatnumber(promod,2)%>
		</td>
      </tr>
      <%
		next
	end if%>
	<tr><td colspan="4" height="2"></td></tr>
	<tr>
        <td align="left" class='<%=laColu(0)%>' >&nbsp;</td>
        <td align="right" class='<%=laColu(0)%>' ><b><%=formatnumber(sumapelas,2)%></b></td>
        <td align="right" class='<%=laColu(0)%>' ><b><%=sumacuantas%></b></td>
		<td align="right" class='<%=laColu(0)%>' ><b>
		<%promod=redondear(sumapelas/sumacuantas)%>
		<%=formatnumber(promod,2)%></b>
		</td>
      </tr>
      <tr>
        <td height='10' colspan='4'>    
      </tr>
      <tr>
        <td align='center' colspan="4">
          <%if pag=1 or pag="" then%>
          <%=FlechaLeft%>P&aacute;gina Anterior
          <%else%>
          <a href="<%=MiPag%>?est=<%=est%>&P=<%=Pag-1%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>"><%=FlechaLeft%>P&aacute;gina Anterior</a>
          <%end if%>
&nbsp;&nbsp;&nbsp;<%=Pag%>/<%=MaxP%>&nbsp;&nbsp;&nbsp;
      <%if pag=MaxP or MaxP=1 then%>
      P&aacute;gina Siguiente<%=FlechaRight%>
      <%else%>
      <a href="<%=MiPag%>?est=<%=est%>&P=<%=Pag+1%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>">P&aacute;gina Siguiente<%=FlechaRight%></a>
      <%end if%>
        </td>
      </tr>
    </table></td></tr>
</table></td></tr>
</table>

<div id='filtro' style='position:absolute; z-index:10; top:100px; left:200px; width:415px; height:100px; visibility:hidden; overflow:visible; background-color: #F2F2F2; border: none;' class='texto10BLANCO'>
<form name='f2' action="<%=MiPag%>?est=<%=est%>&filtro=-1" method="POST">
<table border="0" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">FILTRO DEL LISTADO</div></td></tr>
  <tr><td class="tdTabla">

		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0">
			<tr><td height='10' colspan='2'></td></tr>
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
				<input type="hidden" value='-1' name='filtro'>
				<input type='submit' value='Filtrar' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='Sin Filtro' onclick="javascript:SinFiltro();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="Cerrar" onClick="javascript:document.getElementById('filtro').style.visibility='hidden';" style='cursor:pointer'></td></tr>
		</table>
		
	</td></tr>
</table>
		
</form>
</div>

<script language="JavaScript">
	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	document.getElementById('panel').style.top=35;
	document.getElementById('panel').style.left=l;
	<%if laid<>0 then 
			response.write "document.getElementById('panel').style.visibility='visible';" & bvcrlf
		end if	
	%>

	//Central capa filtro en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('filtro').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('filtro').style.width)/2); //Pos. izquierda
	document.getElementById('filtro').style.top=t;
	document.getElementById('filtro').style.left=l;
	
</script>
</body>
</html>
