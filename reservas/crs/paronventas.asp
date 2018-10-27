<!--#include file="includes/FunGestion.asp"-->
<%
est=request.QueryString("est") 
hab=request.QueryString("hab")
any=request.QueryString("any")
if any="" then any=year(date)

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

if request.form<>"" then 'ha actualizado
	if request.form("marca")="1" then 'añade fechas del paron de ventas
		fechai=cdate(request.form("fini1"))
		fechaf=cdate(request.form("fini2"))
		for fechaparon=fechai to fechaf
			paron=year(fechaparon) & "-" & month(fechaparon) & "-" & day(fechaparon)
			'Comprobar que no existe, para evitar el fallo de PRIMARY_KEY
			cs= "SELECT Dia FROM " & precrs & "paronventas "
			cs=cs & "WHERE CodigoHab=" & hab & " AND CodigoEsta =" & est &" AND Dia = CONVERT(DATETIME, '" & paron & "', 102)"
			rs.Open cs, base
			if rs.eof then 'Puedo añadir registro
				rs.close
				cs= "INSERT INTO " & precrs & "ParonVentas (CodigoHab, CodigoEsta, Dia) Values ("
				cs=cs & hab & "," & est & ",CONVERT(DATETIME, '" & paron & "', 102))"
				base.execute cs
			else
				rs.close
			end if
		next

	else 'Quita las fecha del paron de ventas
		fechai=cdate(request.form("fini1"))
		fechaf=cdate(request.form("fini2"))
		for fechaparon=fechai to fechaf
			paron=year(fechaparon) & "-" & month(fechaparon) & "-" & day(fechaparon) & " 00:00:00"
			cs="DELETE FROM " & precrs & "ParonVentas "
			cs=cs & "WHERE CodigoHab=" & hab &" AND CodigoEsta=" & est & " AND Dia = CONVERT(DATETIME, '" & paron & "', 102)"
			base.execute cs
		next
	end if



end if

'Temporadas
cs="SELECT FInicio,FFinal FROM " & precrs & "Temporadas WHERE "
cs=cs & "CodigoEsta=" & est & " ORDER BY FInicio"
rs.Open cs, base
if not rs.eof then
	hotelcerrado=false
	RegTempos=rs.GetRows
	TFIni=0
	TFFin=1
else
	hotelcerrado=true
end if
rs.close

'Paron ventas
cs="SELECT Dia FROM " & precrs & "ParonVentas WHERE "
cs=cs & "CodigoEsta=" & est & " AND CodigoHab=" & hab & " ORDER BY Dia"
rs.Open cs, base
hayparon=false
if not rs.eof then
	RegParon=rs.GetRows
	PDia=0
	hayparon=true
end if
rs.close

'Nombre Hotel
cs="SELECT Nombre FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nest=rs("Nombre")
end if
rs.close

'Nombre Habitacion
cs="SELECT Nombre FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE TipoHabiIdi=" & hab & " AND Idioma='es'"
rs.open cs,base
if not rs.eof then
	nhab=rs("Nombre")
end if
rs.close



set rs=nothing
base.close
set base=nothing

'colores
gris="#cccccc"
verde="#00ff66"
azul="#0099ff"
rojo="#ff0000"

dim Estado(4)
cerrado=0
abierto=1
marcado=2
completo=3
Estado(cerrado)=gris
Estado(abierto)=verde 'Verde
Estado(marcado)=azul 'Azul
Estado(completo)=rojo 'Rojo

dim DiaSemana(7)
DiaSemana(1)="L"
DiaSemana(2)="M"
DiaSemana(3)="X"
DiaSemana(4)="J"
DiaSemana(5)="V"
DiaSemana(6)="S"
DiaSemana(7)="D"

dim colordia(31,12)
inicio=cdate("01/01/" & any)
final=cdate("31/12/" & any)
if not hotelcerrado then
	for dia=inicio to final
		d=day(dia)
		m=month(dia)
		colordia(d,m)=Estado(cerrado)
		'Buscar en temporadas
		for t=0 to ubound(RegTempos,2)
			if dia>=RegTempos(TFIni,t) and dia<=RegTempos(TFFin,t) then
				colordia(d,m)=Estado(abierto)
			end if
		next 't
	
		'Buscar en Paron Ventas
		if hayparon then
			for t=0 to ubound(RegParon,2)
				if dia=RegParon(PDia,t) then
					colordia(d,m)=Estado(completo)
				end if
			next 't
		end if
	next 'dia
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Planeta-web</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<STYLE type=text/css>
.fondoindex {
	BACKGROUND-IMAGE: url(file:///C|/CLIENTES/THB/thb_web_actual/images/comunes/fondo_index.jpg); BACKGROUND-REPEAT: repeat
}
.thbwhite {
	COLOR: #ffffff; TEXT-DECORATION: underline
}

.notas {
	font-size: 10px;
	color: #FFFFFF;
	background-color: #849F2F;
}
.tabla {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #FFFFFF;
	background-color: #993300;
}
.tabla2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #FFFFFF;
	background-color: #5F0517;
}
.enlace {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}
</STYLE>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<link href="css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></HEAD>
<script language="javascript">
var pos=0;
var hecho=false;
var inicial;
var final;
var marcar;

function GetFechas(vfecha,ii){
	if (pos==0){
		if (hecho) { //desmarcar lo anterior
			for (var i=inicial; i<=final;i++){
				if(document.all['d'+i.toString()].style.backgroundColor!="<%=Estado(cerrado)%>"){
					document.all['d'+i.toString()].style.backgroundColor="<%=Estado(abierto)%>";
					document.all['c'+i.toString()].style.backgroundColor="<%=Estado(abierto)%>";
					}
				}
		}
		
		pos=1;
		marcar=true;
		hecho=false;
		inicial=ii;
		document.forms.f1.fIni1.value=vfecha;
		document.forms.f1.marca.value=1; //está marcando
		document.all.notas.value="Marcar último día";
		//Comprobar si está marcado
		if (document.all['d'+ii].style.backgroundColor=="<%=Estado(completo)%>"){
			marcar=false;
			document.forms.f1.marca.value=0; //está desmarcando
			document.all.notas.value="Desmarcar último día";
			}
	}else{
		pos=0;
		document.forms.f1.fIni2.value=vfecha;
		final=ii;
		if (final<inicial){
			ii=inicial;
			inicial=final;
			final=ii;
		}
		hecho=true;
		document.all.notas.value="Pulsar sobre Actualizar";

		if (marcar){
			//poner en rojo los dias marcados
			for (var i=inicial; i<=final;i++){
				if(document.all['d'+i.toString()].style.backgroundColor!='<%=Estado(cerrado)%>'){
					document.all['d'+i.toString()].style.backgroundColor="<%=Estado(completo)%>";
					document.all['c'+i.toString()].style.backgroundColor="<%=Estado(completo)%>";
					}
				}
		}else{
			//poner en verde los dias marcados
			for (var i=inicial; i<=final;i++){
				if(document.all['d'+i.toString()].style.backgroundColor!="<%=Estado(cerrado)%>"){
					document.all['d'+i.toString()].style.backgroundColor="<%=Estado(abierto)%>";
					document.all['c'+i.toString()].style.backgroundColor="<%=Estado(abierto)%>";
					}
				}
		}
	}

}

function CompruebaMarca(){
	if (!hecho){
		alert("falta marcar último día");
		return false;
		}
	
	document.f1.action="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>";
	document.f1.submit();
}
	
</script>

<BODY>
<%if hotelcerrado then
	response.write "<center><h3>Hotel Cerrado</h3></center>" & vbcrlf

else%>
<form name='f1' method="post">
  <input name="fIni1" type="hidden" id="fIni1" value="<%=fini%>">
  <input name="fIni2" type="hidden" id="fIni2" value="<%=ffin%>">
  <input name='marca' type='hidden' id='marca' value='0'>

<div align="center" class="titulo">
	<a href="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=clng(any)-1%>">
	Año Anterior
	</a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%=nest%> - Año <%=any%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=clng(any)+1%>">
	Año Siguiente
	</a>
</div>
<div align="center">
<table align='center' border="0" cellspacing="0" cellpadding="0" width='530'>
<tr>
<td align='center' width="100%">Tipo Habitacion: <%=nhab%></td>
</tr>
<tr>
	<td align='center' width="100%">
	<!--Tabla de MESES -->
	<table align='center' width="100%" cellspacing="0" border="1" cellpadding="0">
	<%ndia=1
	for m=1 to 12%>
	<tr>
		<td align='left' rowspan="2" class='tabla'>&nbsp;<%=ucase1(monthname(m))%></td>
		<%for d=1 to 31
			mifecha=d & "/" & m & "/" & any
			if isdate(mifecha) then
				fondo="tabla"
				if WeekDay(mifecha,vbmonday)=7 then
					 fondo="tabla2"
				end if
					%>
			<td align='center' class="<%=fondo%>"><%=DiaSemana(WeekDay(mifecha,vbmonday))%></td>
			<%else%>
				<td align='center'>&nbsp;</td>
			<%end if
		next%>
	</tr>
	<tr>
		
		<%for d=1 to 31
			mifecha=d & "/" & m & "/" & any
			dia=d
			if d<10 then dia="0" & d
			if isdate(mifecha) then%>
				<td id="c<%=ndia%>" align='center' style='background-color:<%=colordia(d,m)%>'>
				<a id="d<%=ndia%>" href='#' style='text-decoration:none;background-color:<%=colordia(d,m)%>' onClick="javascript:GetFechas('<%=mifecha%>','<%=ndia%>');"><%=d%></a>
				<%ndia=ndia+1 'Contador de días%>
				</td>
			<%else%>
				<td align='center'>&nbsp;</td>
			<%end if
		next%>
	</tr>
	<%next%>
	</table>
	<!-- FIN TABLA DE MESES -->
	</td>
</tr>
	<tr>
		<td align='center'>
			<input type='text' class='titulo' readonly id='notas' style='border:0; text-decoration:none;'>
		</td>
	</tr>
	<tr>
		<td align='center'>
			<input type='button' value='Actualizar Cambios' onclick="CompruebaMarca();" style="cursor:pointer">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' value='Cerrar Ventana' onclick="window.close();" style="cursor:pointer">
			
		</td>
	</tr>
</table>
</div>
</form>
<%end if%>
<script language="javascript">
	document.all.notas.value="Marcar primer día";
</script>
</body>
</html>
