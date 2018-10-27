<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
lang=request.QueryString("lang")
if lang="" then lang="es"
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close
est=request.QueryString("est")

any=request.QueryString("any")
if any="" then any=year(date)
any=clng(any)

'Buscar reservas del año
cs="SELECT TipoReserva.FechaInicio,TipoReserva.FechaFinal,IdReserva,Activa,"
cs=cs & "IdTipoHabitacion,CuantasHabis "
cs=cs & "FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "TipoReserva TipoReserva "
cs=cs & "ON Reservas.Cod_Res=TipoReserva.IdReserva "
cs=cs & "WHERE CodigoEsta=" & est & " AND "
cs=cs & "(YEAR(FechaInicio)>" & any & " OR YEAR(FechaFinal)>" & any & " "
cs=cs & "AND (YEAR(FechaInicio)<" & any & " OR YEAR(FechaFinal)<" & any & " "
cs=cs & "ORDER BY IdReserva"
hayestemes=false
response.Write cs 
response.End()

rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFIni=0
	MFFin=1
	MRes=2
	MActi=3
	MHCodi=4
	MHCanti=5
	hayestemes=true
end if
rs.close
if hayestemes then
	'Tablas de los dias
	dim diatrue(12)
	dim diafalse(12)
	'Carga datos en las tablas
	for d=1 to 12
		for r=0 to ubound(RegMes,2)
			if month(RegMes(MFecha,r))=d then 'este es este mes
				if RegMes(MActi,r) then 'Activa
					diatrue(d)=diatrue(d)+1
				else
					diafalse(d)=diafalse(d)+1
				end if
			end if
		next	
	next
end if 'hayestemes

set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr>
	  <td>
		* Este m&oacute;dulo depende del establecimiento que se haya seleccionado arriba. </td>
	</tr>
	<tr><td align='center'>
		<input type='button' class="boton145" value='Estad&iacute;sticas por Año' onclick="javascript:window.location='<%=MiPag%>?est=<%=est%>&any=<%=any%>';">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='Estad&iacute;sticas por Mes' onclick="javascript:window.location='EstadisticaMes.asp?est=<%=est%>&any=<%=any%>';">
	</td></tr>
	</table>
<table width='100%'>
	<%
	busca="&any=" & (any-1)
	%>
	<tr>
	<td align='right' width='33%'>
	<a href="<%=MiPag%>?est=<%=est & busca%>">Año Anterior</a></td>
	<td align='center' width='33%'>
	<b>Reservas realizadas en el año <%=any%></b></td>
	<%
		busca="&any=" & (any+1)
	%>
	<td align='left' width='33%'>
	<a href="<%=MiPag%>?est=<%=est & busca%>">Año Siguiente</a></td>
	</tr>
</table>
<table align="center" cellspacing='0' width='99%' border='1' bordercolor="#990000" cellpadding="0">
<tr>
<td align=left class="CabeTabla">&nbsp;</td>
<%
	for I=1 to 12
		response.write "<TD align=center class='cabetabla'>"
		response.write I
		response.write "</td>"
	next%>
</tr>
<tr>
<td align=left class="CabeTabla"><b>Mes</b></td>
<%
	for I=1 to 12
		response.write "<TD align=center>"
		response.write "<a href='EstadisticaMes.asp?est=" & est & "&elmes=" & i & "&any=" & any & "'>"
		response.write ucase1(monthName(I)) & "</a>"
		response.write "</td>"
	next%>
</tr>
<%if hayestemes then
	Tmes=0%>
	<tr>
	<td align=left><b>Reservas<br>Confirmadas</b></td>
		<%
		for d=1 to 12%>
			<TD align=center class='<%=laColu(0)%>' >
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & diatrue(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+diatrue(d)%>
			</td>
		<%next%>
	</tr>
	<tr>
	<td align=left><b>Reservas<br>No Confirmadas</b></td>
		<%
		for d=1 to 12%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write diafalse(d) & "<br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+diafalse(d)%>
			</td>
		<%next%>
	</tr>
	<tr><td colspan='13' class="CabeTabla" height="2"></td></tr>
	<tr>
	<td align=left><b>Total reservas mes</b></td>
		<%
		for d=1 to 12%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & diatrue(d)+diafalse(d) & "</b>"%>
			</td>
		<%next%>
	</tr>
<%end if 'Hayestemes%>
</table>
<b> Total Reservas año <%=any%>: <%=Tmes%></b>
<br><br>
		<input type='button' class="boton145" value='Nº Reservas Realizadas por fecha' onclick="javascript:window.location='EstadisticaAny.asp?est=<%=est%>&any=<%=any%>';">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='Nº Personas por Fecha Ocupación' onclick="javascript:window.location='EstadisticaAnyOcu.asp?est=<%=est%>&any=<%=any%>';">

</td></tr>
</table>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
