<!--#include file="includes/FunGestion.asp"-->
<%
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



nmes=request.QueryString("elmes")
if nmes="" then nmes=month(date)
nmes=clng(nmes)
any=request.QueryString("any")
if any="" then any=year(date)
any=clng(any)

	'Buscar ultimo dia del mes
	UDia="31/" & nmes & "/" & any
	resta=31
	do while not isdate(udia)
		UDia=RESTA & "/" & nmes & "/" & any
		resta=resta-1
	loop
	UDia=day(Udia)

fini=any & "/" & nmes & "/01"
ffin=any & "/" & nmes & "/" & udia

'Buscar reservas del mes y año
cs="SELECT TipoReserva.FechaInicio,TipoReserva.FechaFinal,IdReserva,Activa,"
cs=cs & "TipoReserva.NumAdultos,NumBebes,TipoReserva.NumNinos1,TipoReserva.NumNinos2 "
cs=cs & "FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "TipoReserva TipoReserva "
cs=cs & "ON Reservas.Cod_Res=TipoReserva.IdReserva "
cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND "
cs=cs & "(FechaInicio>CONVERT(DATETIME, '" & fini & "', 102) OR FechaFinal>CONVERT(DATETIME, '" & fini & "', 102)) "
cs=cs & "AND (FechaInicio<CONVERT(DATETIME, '" & ffin & "', 102) OR FechaFinal<CONVERT(DATETIME, '" & ffin & "', 102)) "
cs=cs & "ORDER BY IdReserva"
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFIni=0
	MFFin=1
	MRes=2
	MActi=3
	MAdultos=4
	MBebes=5
	MNinos1=6
	MNinos2=7
	hayestemes=true
end if
rs.close
if hayestemes then
	'Buscar el nombre de colectivo de ese hotel
	cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
	cs=cs & "ON Colectivos.COdigoColec=ColectivosNomres.ColectivoIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' ORDER BY orde"
	rs.open cs,base
	if not rs.eof then
		RegColec=rs.getrows
		CCodi=0
		CNombre=1
	end if
	rs.close

	'Tablas de los dias
	dim adultostrue()
	dim adultosfalse()
	dim bebestrue()
	dim bebesfalse()
	dim ninos1true()
	dim ninos1false()
	dim ninos2true()
	dim ninos2false()
	
	redim adultostrue(UDia)
	redim adultosfalse(UDia)
	redim bebestrue(UDia)
	redim bebesfalse(UDia)
	redim ninos1true(UDia)
	redim ninos1false(UDia)
	redim ninos2true(UDia)
	redim ninos2false(UDia)

	'Carga datos en las tablas
	for d=1 to UDia
		for r=0 to ubound(RegMes,2)
			laf=cdate(d & "/" & nmes & "/" & any)
			if cdate(RegMes(MFIni,r))<=laf and cdate(RegMes(MFFin,r))>=laf then 'este es el dia
				if RegMes(MActi,r) then 'Activa
					adultostrue(d)=adultostrue(d)+RegMes(MAdultos,r)
					bebestrue(d)=bebestrue(d)+RegMes(MBebes,r)
					ninos1true(d)=ninos1true(d)+RegMes(MNinos1,r)
					ninos2true(d)=ninos2true(d)+RegMes(MNinos2,r)
				else
					adultosfalse(d)=adultosfalse(d)+RegMes(MAdultos,r)
					bebesfalse(d)=bebesfalse(d)+RegMes(MBebes,r)
					ninos1false(d)=ninos1false(d)+RegMes(MNinos1,r)
					ninos2false(d)=ninos2false(d)+RegMes(MNinos2,r)
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
		<input type='button' class="boton145" value='Estad&iacute;sticas por Año' onclick="javascript:window.location='EstadisticaAny.asp?est=<%=est%>&any=<%=any%>';">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='Estad&iacute;sticas por Mes' onclick="javascript:window.location='<%=MiPag%>?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>';">
	</td></tr>
	</table>
<table width='100%'>
	<%
	if nmes=1 then
		busca="&elmes=12&any=" & (any-1)
	else
		busca="&elmes=" & (nmes-1) & "&any=" & any
	end if%>
	<tr>
	<td align='right' width='33%'>
	<a href="<%=MiPag%>?est=<%=est & busca%>">Mes Anterior</a></td>
	<td align='center' width='33%'>
	<b>Ocupaci&oacute;n en <%=ucase(monthname(nmes))%>&nbsp;<%=any%></b></td>
	<%
	if nmes=12 then
		busca="&elmes=1&any=" & (any+1)
	else
		busca="&elmes=" & (nmes+1) & "&any=" & any
	end if%>
	<td align='left' width='33%'>
	<a href="<%=MiPag%>?est=<%=est & busca%>">Mes Siguiente</a></td>
	</tr>
</table>
<table align="center" cellspacing='0' width='99%' border='1' bordercolor="#990000" cellpadding="0">
<%
	dim SeD()	
	redim SeD(UDia)
for I=1 to UDia
	'Tabla del dia de la semana
	DiaSemana= I & "/" & nmes & "/" & any 
	select case weekday(diasemana)
		case VbSunday 'Domingo
			SeD(I)="<font color='#FF0000'>D</font>"
		case VbMonday 'Lunes
			SeD(I)="L"
		case vbTuesday 'Martes
			SeD(I)="M"
		case vbwednesday 'Miercoles
			SeD(I)="X"
		case vbThursday 'Jueves
			SeD(I)="J"
		case vbfriday 'Viernes
			SeD(I)="V"
		case vbsaturday 'Sabado
			SeD(I)="S"
	end select
next
%>
<tr>
<td align=left class="CabeTabla">&nbsp;</td>
<%
	for I=1 to UDia
		response.write "<TD align=center class='cabetabla'>"
		response.write I
		response.write "</td>"
	next%>
</tr>
<tr>
<td align=left class="CabeTabla"><b>Dia</b></td>
<%
	for I=1 to UDia
		response.write "<TD align=center width='15'>"
		response.write SeD(I)
		response.write "</td>"
	next%>
</tr>
<%if hayestemes then
	Tmes=0%>
	<tr>
	<td align=left colspan='<%=udia+1%>'><b>Reservas Confirmadas</b></td></tr>
	<%if RegColec(CNombre,0)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,0)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & adultostrue(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+adultostrue(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>
		<tr><td align='left'>Bebés</td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & bebestrue(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+bebestrue(d)%>
			</td>
		<%next%>
		</tr>
	<%if RegColec(CNombre,1)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,1)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & ninos1true(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+ninos1true(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>
	<%if RegColec(CNombre,2)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,2)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			response.write "<b>" & ninos2true(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+ninos2true(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>
	<tr>
	<td align=left colspan='<%=udia+1%>'><b>Reservas No Confirmadas</b></td></tr>
	<%if RegColec(CNombre,0)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,0)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diafalse(d)="" then diafalse(d)=0
			response.write "<b>" & adultosfalse(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+adultosfalse(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>
		<tr><td align='left'>Bebés</td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diafalse(d)="" then diafalse(d)=0
			response.write "<b>" & bebesfalse(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+bebesfalse(d)%>
			</td>
		<%next%>
		</tr>
	<%if RegColec(CNombre,1)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,1)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diafalse(d)="" then diafalse(d)=0
			response.write "<b>" & ninos1false(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+ninos1false(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>
	<%if RegColec(CNombre,2)<>"" then 'Hay nombre colectivo%>
		<tr><td align='left'><%=RegColec(CNombre,2)%></td>
		<%for d=1 to UDia%>
			<TD align=center>
			<%'if diafalse(d)="" then diafalse(d)=0
			response.write "<b>" & ninos2false(d) & "</b><br>"
			'if diafalse(d)="" then diafalse(d)=0
			Tmes=Tmes+ninos2false(d)%>
			</td>
		<%next%>
		</tr>
	<%end if%>

	<tr><td colspan='<%=udia+1%>' class="CabeTabla" height="2"></td></tr>
	<tr>
	<td align=left><b>Total Personas d&iacute;a</b></td>
		<%
		for d=1 to UDia%>
			<TD align=center>
			<%'if diatrue(d)="" then diatrue(d)=0
			suma=adultostrue(d)+adultosfalse(d)+bebestrue(d)+bebesfalse(d)
			suma=suma+ninos1true(d)+ninos1false(d)+ninos2true(d)+ninos2false(d)
			response.write "<b>" & suma & "</b>"%>
			</td>
		<%next%>
	</tr>
<%end if 'Hayestemes%>
</table>
<b> Total Ocupaci&oacute;n mes <%=ucase(monthname(nmes))%>&nbsp;<%=any%>: <%=Tmes%></b>
<br><br>
		<input type='button' class="boton145" value='Nº Reservas Realizadas por fecha' onclick="javascript:window.location='EstadisticaMes.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>';">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='Nº Personas por Fecha Ocupación' onclick="javascript:window.location='EstadisticaMesOcu.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>';">

</td></tr>
</table>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
