<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
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

tipoD=paClng(request.QueryString("tipoD"))
recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 then est=RegHoteles(HCodi,0)
response.Cookies("codiHotel")=est

for h=0 to ubound(RegHoteles,2)
	if RegHoteles(HCodi,h)=est then
		nhotel=RegHoteles(HNombre,h)
		exit for
	end if
next 'h

if request.Form<>"" then 'actualizar
	%><!--#include file="actuManagement.asp"--><%
end if 'form<>""


mes=paClng(request.QueryString("mes"))
if mes=0 then mes=month(date)
el_anyo=paClng(request.QueryString("anyo"))
if el_anyo=0 then el_anyo=year(date)

dim NombreMes(12)
dim NombreMesAbrev(12)
arraymeses="new Array("
for m=1 to 12
	NombreMes(m)=MonthName(m)
	NombreMesAbrev(m)=ucase(left(MonthName(m),3))
	arraymeses=arraymeses & chr(34) & MonthName(m) & chr(34) & ","
next
'Quitar la ultima coma
arraymeses=left(arraymeses,len(arraymeses)-1)
arraymeses=arraymeses & ")"
dim diascortos(7)
dim diaslargos(7)
for d=1 to 7
	diascortos(d)=mid(WeekDayName(d,0,vbmonday),1,3)
	diaslargos(d)=WeekDayName(d,0,vbmonday)
next

laminima=cdate("01/" & mes & "/" & el_anyo)
midia=31
if mes+3>12 then
	mesfin=(mes+3)-12
	anyofin=el_anyo+1
	lamaxima=midia & "/" & mesfin & "/" & anyofin
else 'mismo año
	mesfin=mes+3
	anyofin=el_anyo
	lamaxima=midia & "/" & mesfin & "/" & anyofin
end if
do while not isdate(lamaxima)
	midia=midia-1 'bajo un dia
	lamaxima=midia & "/" & mesfin & "/" & anyofin
loop

'Minimos y release
cs="SELECT Dia,CodigoHab,Precio,SUM(Cuantas) as Disponibles "
cs=cs & "FROM " & precrs & "Cupos Cupos LEFT JOIN " & precrs & "Confirmadas Confirmadas "
cs=cs & "ON Cupos.CodigoHab=Confirmadas.IdTipoHabitacion AND "
cs=cs & "Cupos.Dia>=Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal "
cs=cs & "WHERE Cupos.CodigoEsta=" & est & " AND (Dia BETWEEN " & FechaMySQL(laminima) & " AND " & FechaMySQL(lamaxima)
cs=cs & ") GROUP BY CodigoHab,Dia,Precio "
cs=cs & "ORDER BY CodigoHab,Dia"
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	PDia=0
	PHabi=1
	PPelas=2
	POcu=3
	hayLista=true
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

'Lista habitaciones
cs= "SELECT Id,Nombre_es "
cs=cs & "FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
cs=cs & " ORDER BY Orden,Id"
rs.open cs,base
hayhabis=false
if not rs.eof then
	RegHabis=rs.getrows
	HaCodi=0
	HaNombre=1
	hayhabis=true
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
<style type="text/css">
#capaTabla {
	height:400px;
	overflow-x:hidden;
	overflow-y:scroll;
}
#losmeses {
	border:1px solid #999999;
}
#losmeses td {
	border:none;
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
}
#losmeses td.guena, .sinmarca, .celdilla {
	cursor:pointer;
	width:25px;
}
#losmeses td.guena:hover, .celdilla:hover, .sinmarca:hover, td.onrequest:hover, td.noventa:hover {
	background-color:blue;
	color:#FFFFFF;
}
#losmeses td.onrequest {
	cursor:pointer;
	color:blue;
}
#losmeses td.noventa {
	cursor:pointer;
	color:red;
}

.marcado {
	background-color:#99FF66;
	color:#000000;
}
#losmeses td.tituloTabla {
	text-align:center;
	height:20px;
	text-transform:none;
}
#losmeses td.tituloTabla a {
	color:white;
}
#miTabla th {
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
}
#notas {
	font-weight:bold;
	font-size:11px;
}
#capaFin {
	margin-top:3px;
	padding-top:5px;
	border:1px solid #666666;
	height:68px;
}
#diasSemana input {
	border:none;
	background-color:transparent;
}
#losmeses td {
	border:none;
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
	padding:0px;
	margin:0px;
}
</style>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
function iM() { //mes palante
	mes=<%=mes%>+1;
	anyo=<%=el_anyo%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&recarga=<%=recarga%>&tipoD=<%=tipoD%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mes%>-1;
	anyo=<%=el_anyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&recarga=<%=recarga%>&tipoD=<%=tipoD%>";
	document.f1.submit();
}

function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="<%=MiPag%>?mes="+imes+"&anyo="+ianyo+"&thab=<%=thab%>&recarga=<%=recarga%>&tipoD=<%=tipoD%>";
	document.f1.submit();
}

function CambioHotel(lista){
	document.location="<%=MiPag%>?est="+lista.value+"&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>&tipoD=<%=tipoD%>";
}

queMarca=<%=paClng(request.QueryString("mc"))%>; //dia Inicial
if (queMarca==0) queMarca=1;
tablaMarcas="";
codiHab="0";
function marcar(celda){
	micelda=celda.id.split("_");
	eldia=micelda[0];
	if (codiHab!="0" && codiHab!=micelda[1] && queMarca==2){
		alert("Sólo se pueden marcar fechas sobre la misma habitación");
		return false;
	}

	if (tControl) //tecla control pulsada
		marcaConControl(celda);
	else{
		quitarMarcasControl();
		switch (queMarca) {
			case 1://marcar primer dia
				celda.className='marcado';
				document.getElementById('desdef').value=eldia;
				queMarca=2 //pa la segunda
				document.getElementById('notas').innerHTML='Seleccionar la segunda fecha';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				codiHab=micelda[1]; //codig. habitacion
				break;
		
			case 2: //segundo dia
				celda.className='marcado';
				document.getElementById('hastaf').value=eldia;
				queMarca=0 //pa la primera y desmarcar
				document.getElementById('notas').innerHTML='Poner los datos que quiera actualizar';
				//Guardo la segunda marca
				SetCookie ('hastaf',eldia);
				SetCookie('lamarca','0');
				rangoMarca(true);
				document.f1.precio.focus();
				codiHab=micelda[1]; //codig. habitacion
				document.f1.codigohabi.value=codiHab;
				//codiHab=0; //por si cambia de habitacion
				break;
				
			case 0: //volver a marcar
				//desmarcar las anteriores
				primera=unescape(GetCookie('desdef'));
				document.getElementById(primera+"_"+codiHab).className='sinmarca';
				segunda=unescape(GetCookie('hastaf'));
				document.getElementById(segunda+"_"+codiHab).className='sinmarca';
				rangoMarca(false);
				//marcar la nueva
				celda.className='marcado';
				document.getElementById('desdef').value=eldia;
				queMarca=2 //pa la segunda
				document.getElementById('notas').innerHTML='Seleccionar la segunda fecha';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				codiHab=micelda[1]; //codig. habitacion
				break;
		}
	
	} //tControl (tecla control pulsada)
}

function marcaConControl(esedia){
	if (queMarca==0 || queMarca==2) { //está usando el otro sistema
		//desmarcar el otro sistema
		primera=unescape(GetCookie('desdef'));
		document.getElementById(primera+"_"+codiHab).className='sinmarca';
		segunda=unescape(GetCookie('hastaf'));
		document.getElementById(segunda+"_"+codiHab).className='sinmarca';
		rangoMarca(false);
		queMarca=1; //valor inicial
	} 
	
	//Comprobar que no esté marcado en caso contrario desmarcar
	micelda=esedia.id.split("_");
	eldia=micelda[0]; //la fecha
	if (tablaMarcas.indexOf(eldia)==-1){ //está no ta
		esedia.className='marcado';
		tablaMarcas=tablaMarcas+"-"+eldia;
	}else{ //ya ta, hay que desmarcarlo y quitarlo del array
		esedia.className='sinmarca';
		tablaMarcas=tablaMarcas.replace("-"+eldia,"");
	}
	document.f1.codigohabi.value=micelda[1];
	//ver las fechas seleccionadas
	//document.getElementById('notas').innerHTML="("+tablaMarcas+")";
}

function quitarMarcasControl(){
	if (tablaMarcas!=""){
		lista=tablaMarcas.split("-");
		for (q=0;q<lista.length;q++){
			if (lista[q]!="")
				document.getElementById(lista[q]+"_"+codiHab).className="sinmarca";
		}
		tablaMarcas="";
	}
}

function rangoMarca(quehago){
	//inicio=parseInt(GetCookie('desdef').substr(0,2),10);
	diaIni=parseInt(document.getElementById('desdef').value.substr(0,2),10);
	mesIni=parseInt(document.getElementById('desdef').value.substr(3,2),10);
	anyoIni=parseInt(document.getElementById('desdef').value.substr(6,4),10);
	inicio=new Date(anyoIni,(mesIni-1),diaIni,0,0,0);

	diaFin=parseInt(document.getElementById('hastaf').value.substr(0,2),10);
	mesFin=parseInt(document.getElementById('hastaf').value.substr(3,2),10);
	anyoFin=parseInt(document.getElementById('hastaf').value.substr(6,4),10);
	fin=new Date(anyoFin,(mesFin-1),diaFin,0,0,0);
	
	if (inicio>fin){ //intercambia fechas
		cambia_de_fecha_desde_a_fecha_hasta();
		//vuelve a coger los datos
		diaIni=parseInt(document.getElementById('desdef').value.substr(0,2),10);
		mesIni=parseInt(document.getElementById('desdef').value.substr(3,2),10);
		anyoIni=parseInt(document.getElementById('desdef').value.substr(6,4),10);
		inicio=new Date(anyoIni,(mesIni-1),diaIni,0,0,0);
	
		diaFin=parseInt(document.getElementById('hastaf').value.substr(0,2),10);
		mesFin=parseInt(document.getElementById('hastaf').value.substr(3,2),10);
		anyoFin=parseInt(document.getElementById('hastaf').value.substr(6,4),10);
		fin=new Date(anyoFin,(mesFin-1),diaFin,0,0,0);
	}
	if (quehago)
		esaclase='marcado';
	else
		esaclase='sinmarca';
	undia=(1000 * 60 * 60 * 24); //milisegundos de un día
	midia=new Date();
	for (q=inicio.getTime();q<=fin.getTime();q=q+undia){
		midia.setTime(q);
		//if (dia<10) dia="0"+dia;
		document.getElementById(fechaWeb(midia)+"_"+codiHab).className=esaclase;
	}
}
function cambia_de_fecha_desde_a_fecha_hasta(){
	//intercambiar las fechas
	inter=document.getElementById('desdef').value;
	document.getElementById('desdef').value=document.getElementById('hastaf').value;
	document.getElementById('hastaf').value=inter;
}

function marcaSemana(ese){
	for (t=0;t<document.f1.length;t++){
		if (document.f1[t].name=='diaS')
			document.f1[t].checked=ese.checked;
	}
}
function modificar(){
	txt="Cambios a realizar:\n";
	if (document.f1.codigohabi.value!="0")
		txt=txt+"Habitación: "+document.f1.codigohabi.value+"\n";
		
	if (tablaMarcas!="") { //seleccion multiple manual
		document.f1.arrayFechas.value=tablaMarcas;
		texto=tablaMarcas.replace(/-/g,"\n");
		txt=txt+"Fechas seleccionadas: "+texto+"\n\n";
	}else{
		txt=txt+"Desde fecha "+document.f1.desdef.value;
		txt=txt+" hasta "+document.f1.hastaf.value+"\n";
		//dias de la semana
		semana="";
		for (t=0;t<document.f1.length;t++){
			if (document.f1[t].name=='diaS' && document.f1[t].checked){
				if (document.f1[t].value=="L") semana=semana+"Lunes, ";
				if (document.f1[t].value=="M") semana=semana+"Martes, ";
				if (document.f1[t].value=="X") semana=semana+"Miércoles, ";
				if (document.f1[t].value=="J") semana=semana+"Jueves, ";
				if (document.f1[t].value=="V") semana=semana+"Viernes, ";
				if (document.f1[t].value=="S") semana=semana+"Sábado, ";
				if (document.f1[t].value=="D") semana=semana+"Domingo, ";
			}
		}
		if (semana!=""){
			if (semana=="Lunes, Martes, Miércoles, Jueves, Viernes, Sábado, Domingo, ") 
				semana="Todos los días de la semana.\n";
			else{
				//Quitar la ultima coma
				semana=semana.substring(0,(semana.length-2))+" de la semana.\n";
			}
		}
		txt=txt+semana;
	} //seleccion multiple manual

	//datos 
	if (document.f1.precio.value!='')
		txt=txt+"Precio: "+document.f1.precio.value+"\n";
	/*if (document.f1.cupo.value!='')
		txt=txt+"Cupo: "+document.f1.cupo.value+"\n";
	if (document.f1.minimos.value!='')
		txt=txt+"Estancia Mínima: "+document.f1.minimos.value+"\n";
	if (document.f1.release.value!='')
		txt=txt+"Release: "+document.f1.release.value+"\n";
	if (document.f1.estado.value!='')
		txt=txt+"Estado: "+document.f1.estado[document.f1.estado.selectedIndex].text+"\n";*/
	
	if (confirm(txt))
		document.f1.submit();
		
}

function cambiaTipo() {
	cualo=document.f1.opi.value;
	url="<%=MiPag%>?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>&tipoD="+cualo;
	window.location=url;
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">ESTANCIA MÍNIMA Y RELEASE POR HABITACIÓN Y DÍA -> <%=NHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name="f1" method="post" action="<%=MiPag%>?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>&tipoD=<%=tipoD%>">
<input type="hidden" name="arrayFechas" value=""/>
<input type="hidden" name="codigohabi" value=""/>
<table cellspacing='0' cellpadding="0" border="0" width="100%" style="margin-top:3px;">
<tr>
	<td align='left'>Hotel Seleccionado:
		<select name='HSeleccionado' onchange="Javascript:CambioHotel(this);" style="width:200px">
		<%if hayHoteles then
			for h=0 to ubound(RegHoteles,2)
				marca=""
				select case RegHoteles(HEstado,h)
					case noventa
						nestado=" (No Venta)"
					case onrequest
						nestado=" (On Request)"
					case online
						nestado=" (On Line)"
				end select
				if RegHoteles(HCodi,h)=clng(est) then marca=" selected"%>
				<option value='<%=RegHoteles(HCodi,h)%>'<%=marca%>><%=RegHoteles(HNombre,h) & nestado%></option>
			<%next
		end if%>
		</select>
	</td>
	<td align='left'>Tipo de datos: 
	<select name="opi" onChange="javascript:cambiaTipo();">
		<option value="0"<%if tipoD=0 then response.write " selected"%>>Estancias Mínimas</option>
		<option value="1"<%if tipoD=1 then response.write " selected"%>>Release</option>
	</select>
	</td>
</tr>
</table>
<div id='capaTabla'>
<table id='losmeses' align="center" width="100%" cellpadding="0" cellspacing="0" style="margin-top:3px;">
	<tr><td colspan="33" class="tituloTabla">
		<a href='javascript:dM()'>&laquo;&nbsp;Mes Anterior&nbsp;&nbsp;</a>
		<select name="elmes" onChange="javascript:saltaMes(this.value);" style="height:17px">
		<%
		for aa=year(date) to year(date)+1
			for mm=1 to 12%>
				<option value='<%=mm & "-" & aa%>'<%if mm=mes and aa=el_anyo then response.write " selected"%>><%=nombreMes(mm) & " " & aa%></option>
			<%next 'mes
		next 'año%>
		</select>
		<a href='javascript:iM()'>&nbsp;&nbsp;Mes Siguiente&nbsp;&raquo;</a>
	</td></tr>
	<tr><td colspan="33" height="5" style="border:none"></td></tr>
	<%
	'color del estado
	dim colorEstado(2)
	colorEstado(0)=" style='color:red'" 'no venta
	colorEstado(1)=" style='color:blue'" 'on request
	colorEstado(2)=" style='color:green'" 'on oline
	
	for mm=0 to 2 'pa sumar los meses
		elmes=mes+mm
		if elmes>12 then
			elmes=elmes-12
			mianyo=el_anyo+1
		else
			mianyo=el_anyo
		end if
		%>
		<tr><td colspan="33" align="center" style="border:none"><b><%=ucase(nombreMes(elmes)) & " " & mianyo%></b></td></tr>
		
		<%for d=1 to 31
			if d=1 then 'el primero
				response.write "<tr><td></td>"
			end if
			midia=d & "/" & elmes & "/" & mianyo
			if isdate(midia) then
				fondillo=""
				if weekDay(midia)=vbsunday or weekDay(midia)=vbsaturday then fondillo=" bgcolor='#F8D4AA'"
				response.write "<td align='center'" & fondillo & ">" & d & "</td>" & vbcrlf
			else
				response.write "<td></td>" & vbcrlf
			end if
			if d=31 then response.write "<td width='10' style='border:none'></td></tr>"
		next%>
		<%'los tipos de habitacion
		if hayHabis then
		for h=0 to ubound(RegHabis,2)
			for d=1 to 31
				if d=1 then 'el primero
					response.write "<tr><td align='right'>" & RegHabis(HNombre,h) & "&nbsp;</td>"
				end if
				midia=d & "/" & elmes & "/" & mianyo
				if isdate(midia) then
					fondillo=""
					if weekDay(midia)=vbsunday or weekDay(midia)=vbsaturday then fondillo=" bgcolor='#F8D4AA'"
					'Buscar dia en cupo de la habi
					haydia=false
					for hh=0 to ubound(RegLista,2)
						if RegLista(PDia,hh)=cdate(midia) AND RegLista(PHabi,hh)=RegHabis(HCodi,h) then 'este es el día
							haydia=true
							valor=PaDbl(RegLista(PPelas,hh))
							ocu=paClng(RegLista(POcu,hh))
							exit for
						end if
					next 'hh
					if haydia then
						response.write "<td align='center'" & fondillo & " id='" & right("0"&day(midia),2) & "/" & right("0"&month(midia),2) & "/" & year(midia) & "_" & RegLista(PHabi,hh) & "' onclick='javascript:marcar(this);' class='celdilla'>" & formatnumber(valor,1) & "</td>" & vbcrlf
					else
						response.write "<td align='center'" & fondillo & " style='width:25px'> </td>" & vbcrlf
					end if
				else
					response.write "<td></td>" & vbcrlf
				end if
				if d=31 then response.write "<td width='10' style='border:none'></td></tr>"
			next 'dias
		next 'reglista
		end if 'haylista%>
		<tr><td colspan="33" height="15" style="border:none"></td></tr>
	<%next 'suma mes%>

</table>
	<div id='notas' align="center">Pulsar sobre el día para seleccionar fechas</div>
</div>
<div id='capaFin'>
	<div style="float:left; margin-top:2px;">&nbsp;Rango de fechas:</div>
	<div style="float:left; margin-left:5px; text-align:right;">
	Desde <input type="text" id='desdef' name="desdef" maxlength="14" value="" style="width:65px;" onChange="alert('cambio');"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('desdef','f1',self.name,'');" style="cursor:pointer"><br/>
	hasta <input type="text" id='hastaf' name="hastaf" maxlength="14" value="" style="width:65px;"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('hastaf','f1',self.name,'');" style="cursor:pointer">
	</div>
	<div style="float:left;margin-left:50px;">
		<div align="center" style="vertical-align:top" id='diasSemana'>
			<input type="checkbox" onClick="javascript:marcaSemana(this);" checked>
			todos los días o  
			Lun.<input type="checkbox" value="L" name='diaS' checked>
			&nbsp;&nbsp;Mar.<input type="checkbox" value="M" name='diaS' checked>
			&nbsp;&nbsp;Mie.<input type="checkbox" value="X" name='diaS' checked>
			&nbsp;&nbsp;Jue.<input type="checkbox" value="J" name='diaS' checked>
			&nbsp;&nbsp;Vie.<input type="checkbox" value="V" name='diaS' checked>
			&nbsp;&nbsp;Sab.<input type="checkbox" value="S" name='diaS' checked>
			&nbsp;&nbsp;Dom.<input type="checkbox" value="D" name='diaS' checked>
		</div>
		<div style="float:left; margin-top:3px;"><b>Cambiar datos:</b></div>
		<div style="float:left; margin-left:5px; text-align:center; margin-top:3px;">
			<p>
			Precio <input type="text" id='precio' name="precio" maxlength="8" value="" style="width:50px;">
			<br/>
			<input name="buttons" type="button" class='boton86' onClick="javascript:modificar();" value="Actualizar datos">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="buttonq" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
			</p>
		</div>
	</div>	
</div>
</form>
<script language="javascript" type="text/javascript">
if (!es_IE) document.captureEvents(Event.MOUSEDOWN);
document.onmousedown= pulsadoControl;
var tControl=false; //codigo de la tecla pulsada
function pulsadoControl(e){
	if (!es_IE){
		tControl=e.ctrlKey;
		//alert(e.target.id);
	}else{
		evento=window.event;
		tControl=evento.ctrlKey;
		//alert(evento.srcElement.id);
	}
}
</script>
</body>
</html>