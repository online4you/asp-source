<!--#include file="includes/FunGestion.asp"-->
<%
est=request.QueryString("est") 
hab=request.QueryString("hab")
any=request.QueryString("any")
if any="" then any=year(date)
sv=request.QueryString("sv") 'scroll
if sv="" then sv=0

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

if request.form<>"" then 'Actualizar datos
	fini=request.form("desdedia")
	ffin=request.form("hastadia")
	elestado=request.form("estado")
	if elestado="" then elestado=0
	
	if isdate(fini) and isdate(ffin) then
		fini=cdate(fini)
		ffin=cdate(ffin)
		'Intercambiar la fechas, si las han puesto al reves
		if fini>ffin then	
			esa=ffin
			ffin=fini
			fini=esa
		end if
		
		cs="SELECT Dia FROM " & precrs & "EstadoHabitacion EstadoHabitacion WHERE Dia>=" & FechaMySQL(fini) & " AND "
		cs=cs & "Dia<=" & FechaMySQL(ffin) & " AND CodigoHab=" & hab
		rs.open cs,base
		haberlos=false
		if not rs.eof then 'Esta vacio, añadir todos los registros
			haberlos=true
		end if
		rs.close
		if not haberlos then 'Esta vacio, añadir todos los registros
		
			for f=fini to ffin
				cs="INSERT INTO " & precrs & "EstadoHabitacion EstadoHabitacion (CodigoHab,CodigoEsta,Dia,Estado) VALUES ("
				cs=cs & hab & "," & est & "," & FechaMySQL(f) & "," & elestado & ")"
				base.execute cs
				
			next
			
		else 'Buscar para actualizar, y en caso contrario añadir
		
			set rs2=server.createobject("ADODB.Recordset")
			rs2.CursorLocation = adUseServer
			rs2.CursorType=adOpenForwardOnly
			rs2.LockType=adLockReadOnly
			
			for f=fini to ffin
				'Si existe, actualizarlo
				cs="SELECT Dia FROM " & precrs & "EstadoHabitacion EstadoHabitacion WHERE Dia=" & FechaMySQL(f)
				cs=cs & " AND CodigoHab=" & hab
				rs2.open cs,base
				if not rs2.eof then 'Actualizar
					cs="UPDATE " & precrs & "EstadoHabitacion SET Estado=" & elestado
					cs=cs & " WHERE Dia=" & FechaMySQL(f) & " AND CodigoHab=" & hab
					base.execute cs
				else 'Añadir
					cs="INSERT INTO " & precrs & "EstadoHabitacion (CodigoHab,CodigoEsta,Dia,Estado) VALUES ("
					cs=cs & hab & "," & est & "," & FechaMySQL(f) & "," & elestado & ")"
					base.execute cs
				end if 'rs2.eof
				rs2.close
			next 'f
			
			set rs2=nothing
		end if 'haberlos
	
	end if 'fecha no validas


end if 'form<>""



'Temporadas
cs="SELECT FInicio,FFinal FROM " & precrs & "Temporadas Temporadas WHERE "
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

'Cupo
cs="SELECT Dia,Estado FROM " & precrs & "EstadoHabitacion EstadoHabitacion WHERE "
cs=cs & "CodigoEsta=" & est & " AND CodigoHab=" & hab & " ORDER BY Dia"
rs.Open cs, base
hayparon=false
if not rs.eof then
	RegParon=rs.GetRows
	PDia=0
	PEstado=1
	hayparon=true
end if
rs.close

'Nombre Hotel
cs="SELECT Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nest=rs("Nombre")
	HEstado=rs("estado")
end if
rs.close

'Nombre Habitacion
cs="SELECT Nombre_es FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
cs=cs & "WHERE Id=" & hab
rs.open cs,base
if not rs.eof then
	nhab=rs("Nombre_es")
end if
rs.close



set rs=nothing
base.close
set base=nothing

'colores
gris="#DFDFDF"
verde="#00ff66"
azul="#0099ff"
rojo="#ff0000"
blanco="#ffffff"
naranja="#FF9933"

dim Estado(3)
marcado=3
Estado(noventa)=gris
Estado(onrequest)=naranja 
Estado(online)=verde
Estado(marcado)=azul 'Azul


dim DiaSemana(7)
DiaSemana(1)="L"
DiaSemana(2)="M"
DiaSemana(3)="X"
DiaSemana(4)="J"
DiaSemana(5)="V"
DiaSemana(6)="S"
DiaSemana(7)="D"

dim colordia(31,12)
dim cupodia(31,12)
inicio=cdate("01/01/" & any)
final=cdate("31/12/" & any)
if not hotelcerrado then
	for dia=inicio to final
		d=day(dia)
		m=month(dia)
		colordia(d,m)=Estado(noventa)
		'Buscar en temporadas
		for t=0 to ubound(RegTempos,2)
			if dia>=RegTempos(TFIni,t) and dia<=RegTempos(TFFin,t) then
				colordia(d,m)=Estado(HEstado)
				cupodia(d,m)=HEstado
			end if
		next 't
	
		'Buscar los cupos
		if hayparon then
			for t=0 to ubound(RegParon,2)
				if dia=RegParon(PDia,t) then
					cupodia(d,m)=RegParon(PEstado,t)
					colordia(d,m)=Estado(RegParon(PEstado,t))
				end if
			next 't
		end if
	next 'dia
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Planeta-web</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<STYLE type=text/css>
.thbwhite {
	COLOR: #ffffff; TEXT-DECORATION: underline
}

.notas {
	font-size: 12px;
	color: #000099;
	font-weight: bold;
}
.tabla {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #FFFFFF;
	background-color:#006633;
}
.tabla2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #FFFFFF;
	background-color: #000099;
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
<style type="text/css">
<!--
body {
	background-image:none;
	margin-top:5px;
}
-->
</style>
</HEAD>
<script language="javascript">
var pos=0;
var hecho=false;
var inicial;
var colorInicial;
var colorFinal;
var finalc;
var marcar;

function GetFechas(vfecha){
	mifecha=new Array(3);
	mifecha=vfecha.split("/");
	dia=mifecha[0];
	mes=mifecha[1];

	if (pos==0){
		pos=1;
		marcar=true;
		hecho=false;
		inicial=dia+'-'+mes;
		//Guardar colores anteriores
		colorInicial=document.getElementById('c'+inicial).style.backgroundColor;
		
		//Marcar
		document.getElementById('t'+inicial).style.backgroundColor="<%=Estado(marcado)%>";
		document.getElementById('c'+inicial).style.backgroundColor="<%=Estado(marcado)%>";
		
		document.f1.desdedia.value=vfecha;
		document.getElementById("obs").innerHTML="Marcar último día";

	}else{
		pos=0;
		document.f1.hastadia.value=vfecha;
		finalc=dia+'-'+mes;
		hecho=true;
		
		//Guardar colores anteriores
		colorFinal=document.getElementById('c'+finalc).style.backgroundColor;

		//Marcar
		document.getElementById('t'+finalc).style.backgroundColor="<%=Estado(marcado)%>";
		document.getElementById('c'+finalc).style.backgroundColor="<%=Estado(marcado)%>";
		
		document.getElementById("obs").innerHTML="Pulsar sobre Aceptar";
		//Visualizar panel de cupo
		document.getElementById('panel').style.visibility='visible';
		document.f1.cupo.focus();
		}

}


function cierraPanel(){
	document.getElementById('t'+inicial).style.backgroundColor="<%=Estado(hestado)%>";
	document.getElementById('c'+inicial).style.backgroundColor=colorInicial;
	document.getElementById('t'+finalc).style.backgroundColor="<%=Estado(hestado)%>";
	document.getElementById('c'+finalc).style.backgroundColor=colorFinal;
	//ocultar
	document.getElementById('panel').style.visibility="hidden";
	document.getElementById("obs").innerHTML="Marcar primer día";
}	

function actualizar(){
	//Posicion scroll
	sv=document.getElementById("tabla").scrollTop;

	//Parpadeo
	reloj=setTimeout('parpadeo()',400);
	
	document.f1.action="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=any%>&sv="+sv;
	document.f1.submit();
}
var texto=true;
function parpadeo(){
	if (texto)
		document.getElementById('espera').innerHTML='<b>Actualizando</b>';
	else
		document.getElementById('espera').innerHTML='';
	
	texto=!(texto);
	reloj=setTimeout('parpadeo()',700);
}

</script>

<BODY>
<%if hotelcerrado then
	response.write "<center><h3>Hotel Cerrado</h3></center>" & vbcrlf

else%>
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
<table align='center' border="0" cellspacing="0" cellpadding="0" width='650'>
<tr>
<td align='center' width="100%">Tipo Habitacion: <%=nhab%></td>
</tr>
<tr>
	<td align='center' width="100%">
	<div id='tabla' style="height:350; overflow:auto">
	<!--Tabla de MESES -->
	<table align='center' width="100%" cellspacing="0" border="0" cellpadding="0">
	<%ndia=1
	for m=1 to 12%>
	<tr>
		<td align='left' class='tabla'>
			<table border='0' cellspacing='0' cellpadding="0" width="100%">
			<tr><td align='center' valign="middle" class="tabla"><%=ucase1(monthname(m))%></td></tr>
			<tr><td align='right' valign="button" class="tabla"><br>Estado --></td></tr>
			</table>
		</td>
		<td>
			<table border='1' cellspacing="0" cellpadding="0" width='100%'>
			<tr>
				<%' DIAS DE LA SEMANA
					for d=1 to 31
					mifecha=d & "/" & m & "/" & any
					if isdate(mifecha) then
						fondo="tabla"
						if WeekDay(mifecha,vbmonday)=7 then
							 fondo="tabla2"
						end if
							%>
					<td align='center' class="<%=fondo%>" width='15'><%=DiaSemana(WeekDay(mifecha,vbmonday))%></td>
					<%else%>
						<td align='center' width='15'>&nbsp;</td>
					<%end if
				next%>
			</tr>
			<tr>
				<%'Nº DIA DEL MES
					for d=1 to 31
					mifecha=d & "/" & m & "/" & any
					dia=d
					if d<10 then dia="0" & d
					if isdate(mifecha) then%>
						<td id="t<%=d%>-<%=m%>" align='center' style='background-color:<%=colordia(d,m)%>'>
						<a href='#' style='text-decoration:none;' onClick="javascript:GetFechas('<%=mifecha%>');"><%=d%></a>
						</td>
					<%else%>
						<td align='center'>&nbsp;</td>
					<%end if
				next%>
			</tr>
			<tr>
				<%'CUPO DE LOS DIAS
					for d=1 to 31
					mifecha=d & "/" & m & "/" & any
					dia=d
					if d<10 then dia="0" & d
					if isdate(mifecha) then
						select case cupodia(d,m)
							case noventa
								cupo="&nbsp;&ndash;&nbsp;"
							case onrequest
								cupo="R"
							case online
								cupo="O"
							end select
						colorcelda=colordia(d,m)%>
						<td id="c<%=d%>-<%=m%>" align='center' style='background-color:<%=colorcelda%>'>
						<a href='#' style='text-decoration:none;' onClick="javascript:GetFechas('<%=mifecha%>');"><%=cupo%></a>
						</td>
					<%else%>
						<td align='center'>&nbsp;</td>
					<%end if
				next%>
			
			
			</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan="2" height='1'></td></tr>
	<%next%>
	</table>
	<!-- FIN TABLA DE MESES -->
	</div>
	</td>
</tr>
	<tr>
		<td align='center' id='obs' class='notas'></td>
	</tr>
	<tr>
		<td align='center'>
			<br>
			<div style="float:left">
			<input type='button' value='Cupo Habitación' onclick="javascript:window.location='Cupos.asp?est=<%=est%>&hab=<%=hab%>&any=<%=any%>';" style="cursor:pointer">
			</div>
			<input type='button' value='Cerrar Ventana' onclick="window.close();" style="cursor:pointer">
		</td>
	</tr>
</table>
</div>
<div id="panel" style="position:absolute; width:200; height:130; z-index:12; visibility:hidden; left: 292px; top: 195px; background-color: #CCCCCC; layer-background-color: #CCCCCC; border: 2px solid #000099;">
<form name='f1' method="post" onSubmit="javascript:actualizar()">
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="0">
	<tr><td colspan="2" height='10'></td></tr>
	<tr><td colspan='2' align='center'><b>Introducción del Cupo</b></td></tr>
	<tr><td colspan="2" height='10'></td></tr>
	<tr><td align='right'>Desde día:</td>
		<td align='left'><input type='text' name="desdedia" size='12' maxlength="12"></td>
	</tr>
	<tr><td align='right'>Hasta día:</td>
		<td align='left'><input type='text' name="hastadia" size='12' maxlength="12"></td>
	</tr>
	<tr><td align='right'>Estado:</td>
		<td align='left'>
			<select name="estado">
			<option value="<%=noventa%>">No Venta</option>
			<option value="<%=onrequest%>">On Request</option>
			<option value="<%=online%>">On Line</option>
			</select>
		</td>
	</tr>
	<tr><td colspan="2" height='10'></td></tr>
	<tr><td colspan='2' align='center' id='espera'>
		<input type="submit" value="Aceptar" style="cursor:pointer">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="Cerrar" onClick="javascript:cierraPanel();" style="cursor:pointer">
	</td></tr>
	</table>
</form>
</div>

<%end if%>
<script language="javascript">
	document.getElementById("obs").innerHTML="Marcar primer día";
	
	//centrar panel cupo
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	document.getElementById('panel').style.top=t;
	document.getElementById('panel').style.left=l-50;
	
	//Posicion scroll
	document.getElementById('tabla').scrollTop=<%=sv%>;
</script>
</body>
</html>
