<!--#include file="includes/FunGestion.asp"-->
<%
est=request.QueryString("est") 
hab=request.QueryString("hab")
any=clng("0" & request.QueryString("any"))
if any=0 then any=anyo
sv=request.QueryString("sv") 'scroll
if sv="" then sv=0
fc=request.QueryString("fc") 'id del frame flotante

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

if request.form<>"" then 'Actualizar datos
	fini=request.form("desdedia")
	ffin=request.form("hastadia")
	cupo=request.form("cupo")
	if cupo="" then cupo=0
	
	if isdate(fini) and isdate(ffin) then
		fini=cdate(fini)
		ffin=cdate(ffin)
		'Intercambiar la fechas, si las han puesto al reves
		if fini>ffin then	
			esa=ffin
			ffin=fini
			fini=esa
		end if
		
		cs="SELECT Dia FROM " & precrs & "Cupos WHERE Dia>=" & FechaMySQL(fini) & " AND "
		cs=cs & "Dia<=" & FechaMySQL(ffin) & " AND CodigoHab=" & hab
		rs.open cs,base
		haberlos=false
		if not rs.eof then 'Esta vacio, añadir todos los registros
			haberlos=true
		end if
		rs.close
		if not haberlos then 'Esta vacio, añadir todos los registros
		
			for f=fini to ffin
				cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo) VALUES ("
				cs=cs & hab & "," & est & "," & FechaMySQL(f) & "," & cupo & ")"
				base.execute cs
				'controlRegistro(cs) 'guarda seguimiento
			next
			controlRegistro("Añadiendo cupo de " & cupo & " Hab: " & hab & " desde " & fini & " hasta " & ffin) 'guarda seguimiento
			
		else 'Buscar para actualizar, y en caso contrario añadir
		
			set rs2=server.createobject("ADODB.Recordset")
			rs2.CursorLocation = adUseServer
			rs2.CursorType=adOpenForwardOnly
			rs2.LockType=adLockReadOnly
			
			for f=fini to ffin
				'Si existe, actualizarlo
				cs="SELECT Dia FROM" & precrs & " Cupos WHERE Dia=" & FechaMySQL(f)
				cs=cs & " AND CodigoHab=" & hab
				rs2.open cs,base
				if not rs2.eof then 'Actualizar
					cs="UPDATE " & precrs & "Cupos SET Cupo=" & cupo
					cs=cs & " WHERE Dia=" & FechaMySQL(f) & " AND CodigoHab=" & hab
					base.execute cs
				else 'Añadir
					cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo) VALUES ("
					cs=cs & hab & "," & est & "," & FechaMySQL(f) & "," & cupo & ")"
					base.execute cs
				end if 'rs2.eof
				rs2.close
			next 'f
			controlRegistro("Actualiza cupo de "&fini&" hasta "&ffin&"= "&cupo&" hab.") 'guarda seguimiento
			set rs2=nothing
		end if 'haberlos
	
	end if 'fecha no validas


end if 'form<>""



'Temporadas
cs="SELECT MIN(FInicio) as laMinima,MAX(FFinal) as laMaxima FROM " & precrs & "Temporadas WHERE "
cs=cs & "CodigoEsta=" & est & " AND YEAR(FInicio)=" & any 
rs.Open cs, base
if not rs.eof then
	hotelcerrado=false
	laminima=rs("laMinima")
	lamaxima=rs("laMaxima")
else
	hotelcerrado=true
end if
rs.close

if not hotelcerrado then
	'Cupo
	cs="SELECT Dia,Cupo,Confirmadas FROM " & precrs & "Disponibles WHERE "
	cs=cs & "CodigoHab=" & hab
	cs=cs & " AND (Dia BETWEEN " & FechaMySQL(laminima) & " AND " & FechaMySQL(lamaxima)
	cs=cs & ") ORDER BY Dia"
	rs.Open cs, base
	hayparon=false
	if not rs.eof then
		RegParon=rs.GetRows
		PDia=0
		PCupo=1
		POcu=2
		hayparon=true
		'response.write cs & "<br>"
	end if
	rs.close

end if 'hotelcerrado


'Nombre Hotel
cs="SELECT Nombre FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nest=rs("Nombre")
end if
rs.close

'Nombre Habitacion
cs="SELECT Nombre_es FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE Id=" & hab
rs.open cs,base
if not rs.eof then
	nhab=rs("Nombre_es")
end if
rs.close



'colores
gris="#DFDFDF"
verde="#00ff66"
azul="#0099ff"
rojo="#ff0000"
blanco="#ffffff"

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
dim cupodia(31,12)
dim ocudia(31,12)
inicio=cdate("01/01/" & any)
final=cdate("31/12/" & any)
regcupo=0
if not hotelcerrado then
	for dia=inicio to final
		d=day(dia)
		m=month(dia)
		colordia(d,m)=Estado(cerrado)
		'Buscar que sea temporada abierta
		if dia>=laminima and dia<=laMaxima then
			colordia(d,m)=Estado(abierto)
		end if
	
		'Buscar los cupos
		if hayparon then
			'response.write RegParon(PDia,ubound(RegParon,2)) & "<br>"
			if RegParon(PDia,0)<=dia and RegParon(PDia,ubound(RegParon,2))>=dia then 'está fecha esta dentro de dispon.
				'comprobar que está ese día sino pasar al siguiente
				'response.write regcupo & "<br> "
				'response.write RegParon(PDia,regcupo) & "<br> "
				do while RegParon(PDia,regcupo)<dia
					regcupo=regcupo+1
					if regcupo>ubound(RegParon,2) then
						regcupo=regcupo-1
						exit do
					end if
				loop
				if dia=RegParon(PDia,regcupo) then
					cupodia(d,m)=RegParon(PCupo,regcupo)
					ocudia(d,m)=paClng(RegParon(POcu,regcupo))
					regcupo=regcupo+1
				end if
			end if 't
		end if
		
	next 'dia
end if

set rs=nothing
base.close
set base=nothing

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<!--#include file="metasCabecera.asp"-->
<STYLE type=text/css>
.notas {
	font-size: 12px;
	color: #000099;
	font-weight: bold;
}
.tabla {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #000066;
	background-color: #00CCFF;
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
<style type="text/css">
<!--
body {
	background-image:none;
	margin-top:5px;
}
#losmeses td {
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
	width:17px;
	height:14px;
}
.tabla td {
	height:14px;
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
	document.getElementById('t'+inicial).style.backgroundColor="<%=Estado(abierto)%>";
	document.getElementById('c'+inicial).style.backgroundColor=colorInicial;
	document.getElementById('t'+finalc).style.backgroundColor="<%=Estado(abierto)%>";
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
	
	document.f1.action="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=any%>&sv="+sv+"&fc=<%=fc%>";
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
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
</script>

<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
		<div class="nombreFicha">CUPO -> <%=nhab%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<%if hotelcerrado then
	response.write "<center><h3>Hotel Cerrado</h3></center>" & vbcrlf

else%>
<div align="center" class="titulo">
	<a href="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=clng(any)-1%>&fc=<%=fc%>">
	Año Anterior
	</a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%=nest%> - Año <%=any%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="<%=MiPag%>?est=<%=est%>&hab=<%=hab%>&any=<%=clng(any)+1%>&fc=<%=fc%>">
	Año Siguiente
	</a>
</div>
<div align="center">
<table align='center' border="0" cellspacing="0" cellpadding="0" width='750'>
<tr>
<td align='center' width="100%">Tipo Habitacion: <%=nhab%></td>
</tr>
<tr>
	<td align='center' width="100%">
	<div id='tabla' style="height:420px; overflow:auto">
	<!--Tabla de MESES -->
	<table align='center' width="100%" cellspacing="0" border="0" cellpadding="0">
	<%ndia=1
	for m=1 to 12%>
	<tr>
		<td align='left' class='tabla'>
			<table border='0' cellspacing='0' cellpadding="0" width="100%">
			<tr><td align='center' valign="middle" class="tabla"><b><%=ucase1(monthname(m))%></b></td></tr>
			<tr><td height="20"></td></tr>
			<tr><td align='right' valign="button" class="tabla">Cupo --></td></tr>
			<tr><td align='right' valign="button" class="tabla">Libres --></td></tr>
			</table>
		</td>
		<td>
			<table id='losmeses' border='0' cellspacing="0" cellpadding="0" width='100%'>
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
					<td align='center' class="<%=fondo%>" width='18'><%=DiaSemana(WeekDay(mifecha,vbmonday))%></td>
					<%else%>
						<td align='center' width='18'>&nbsp;</td>
					<%end if
				next%>
			</tr>
			<tr>
				<%'Nº DIA DEL MES
					for d=1 to 31
					mifecha=d & "/" & m & "/" & any
					dia=d
					if d<10 then dia="0" & d
					if isdate(mifecha) then
						if colordia(d,m)<>estado(cerrado) then%>
							<td id="t<%=d%>-<%=m%>" align='center' style='background-color:<%=colordia(d,m)%>' width="18">
							<a href='#' style='text-decoration:none;' onClick="javascript:GetFechas('<%=mifecha%>');"><%=d%></a>
							</td>
						<%else%>
							<td align='center' style='background-color:<%=colordia(d,m)%>' width="18"><%=d%></td>
						<%end if%>
					<%else%>
						<td align='center' width="18">&nbsp;</td>
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
						cupo=paclng(cupodia(d,m))
						colorcelda=colordia(d,m)
						if cupo=0 then
							if colorcelda<>estado(cerrado) then 'si está cerrado no lo pongo en rojo
								colorcelda=estado(completo)
							end if
						else
							colorcelda=blanco
						end if
						if colorcelda<>estado(cerrado) then%>
							<td id="c<%=d%>-<%=m%>" align='center' style='background-color:<%=colorcelda%>'>
							<a href='#' style='text-decoration:none;' onClick="javascript:GetFechas('<%=mifecha%>');"><%=cupo%></a>
							</td>
						<%else%>
							<td align='center' style='background-color:<%=colorcelda%>'>&nbsp;</td>
						<%end if%>
					<%else%>
						<td align='center'>&nbsp;</td>
					<%end if
				next%>
			
			
			</tr>
			<tr>
				<%'Ocupacion DE LOS DIAS
					for d=1 to 31
					mifecha=d & "/" & m & "/" & any
					dia=d
					if d<10 then dia="0" & d
					if isdate(mifecha) then
						ocu=paclng(ocudia(d,m))
						libres=paclng(cupodia(d,m))-ocu
						colorcelda=blanco%>
						<td align='center' style='background-color:<%=colorcelda%>'>
						<%=libres%>
						</td>
					<%else%>
						<td align='center'>&nbsp;</td>
					<%end if
				next%>
			</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan="2" style="height:2px"></td></tr>
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
			<input type='button' value='Cerrar Ventana' onclick="javascript:cerrar();" class="boton86">
		</td>
	</tr>
</table>
</div>
<div id="panel" style="position:absolute; width:200px; height:130px; z-index:12; visibility:hidden; left: 292px; top: 195px; background-color: #CCCCCC; border: 2px solid #000099;">
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
	<tr><td align='right'>Cupo:</td>
		<td align='left'><input type='text' name="cupo" size='6' maxlength="6"></td>
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
