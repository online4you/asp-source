<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

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

rm=paClng(request.QueryString("rm")) 'rango meses
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

%><!--#include file="fechasCalendario.asp"--><%

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
cs= "SELECT TipoHabitaNombres.Id,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "on TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' "
cs=cs & "AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est
cs=cs & " ORDER BY Orden,TipoHabitaNombres.Id"
rs.open cs,base
hayhabis=false
if not rs.eof then
	RegHabis=rs.getrows
	HaCodi=0
	HaNombre=1
	hayhabis=true
end if
rs.close

if hayhabis then 'tiene habitaciones
	thab=paClng(request.QueryString("thab"))
	if thab=0 then thab=RegHabis(HaCodi,0) 'cargo la primera
	'fechas
	fini=cdate("01/" & mes & "/" & el_anyo)
	padia=31
	do while not isdate(padia & "/" & mes & "/" & el_anyo)
		padia=padia-1
	loop
	ffin=cdate(padia & "/" & mes & "/" & el_anyo)

	'Cupos y ocupadas	
	cs="SELECT Dia,Cupo,Confirmadas "
	cs=cs & "FROM " 
	cs=cs & "(SELECT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM " & precrs & "Cupos Cupos LEFT OUTER JOIN (SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "Reservas Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0 AND Anulada=0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal) Confirmadas ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia) Disponibles "
	cs=cs & "WHERE CodigoHab=" & thab 
	cs=cs & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin)
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

	'Precios y minimos
	cs="SELECT DISTINCT Dia,Precio,DiasMinimos,ReleaseHab,Estado,LimiteCheckIn "
	cs=cs & "FROM " & precrs & "Cupos "
	cs=cs & "WHERE CodigoHab=" & thab & " AND CodigoEsta=" & est
	cs=cs & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin)
	cs=cs & ") ORDER BY Dia"
	'response.write cs & "<br>"
	rs.Open cs, base
	hayCupos=false
	if not rs.eof then
		RegCupos=rs.GetRows
		CuDia=0
		CuPelas=1
		CuMinimos=2
		CuRelease=3
		CuEstado=4
		CuCheckin=5
		hayCupos=true
		'response.write cs & "<br>"
	end if
	rs.close

end if 'hayhabis

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<style type="text/css">
#capaTabla {
	height:400px;
	overflow:scroll;
}
#miTabla {
	border:1px solid #999999;
}
#miTabla td {
	height:60px;
	border:none;
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
	padding-left:5px;
	overflow:hidden;
	line-height:13px;
}

#miTabla td.guena, .sinmarca {
	cursor:pointer;
}
#miTabla td.guena:hover, .sinmarca:hover, td.onrequest:hover, td.noventa:hover {
	background-color:blue;
	color:#FFFFFF;
}
#miTabla td.onrequest {
	cursor:pointer;
	/*color:blue;*/
	color:#0099FF;
}
#miTabla td.noventa {
	cursor:pointer;
	color:red;
}

.marcado {
	background-color:#99FF66;
	color:#000000;
}
#miTabla td.tituloTabla {
	text-align:center;
	height:20px;
	text-transform:none;
}
#miTabla td.tituloTabla a {
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
	margin-top:4px;
	padding-top:5px;
	border:1px solid #666666;
	/*height:65px;*/
}
#diasSemana input {
	border:none;
	background-color:transparent;
}

div.tituloTabla {
	text-align:center;
	height:20px;
	text-transform:none;
}
div.tituloTabla a {
	color:white;
	text-decoration:none;
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
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&est=<%=est%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mes%>-1;
	anyo=<%=el_anyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&est=<%=est%>";
	document.f1.submit();
}

function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="<%=MiPag%>?mes="+imes+"&anyo="+ianyo+"&thab=<%=thab%>&est=<%=est%>";
	document.f1.submit();
}

function CambioHotel(lista){
	document.location="<%=MiPag%>?est="+lista.value+"&mes=<%=mes%>&anyo=<%=el_anyo%>";
}
function CambioHabi(lista){
	document.location="<%=MiPag%>?thab="+lista.value+"&mes=<%=mes%>&anyo=<%=el_anyo%>&est=<%=est%>";
}

queMarca=<%=paClng(request.QueryString("mc"))%>; //dia Inicial
if (queMarca==0) queMarca=1;
tablaMarcas="";
function marcar(eso){
	eldia=eso.id;
	if (tControl) //tecla control pulsada
		marcaConControl(eldia);
	else{
		quitarMarcasControl();
		switch (queMarca) {
			case 1://marcar primer dia
				document.getElementById(eldia).className='marcado';
				document.getElementById('desdef').value=eldia;
				queMarca=2 //pa la segunda
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_segundafecha")%>';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				break;
		
			case 2: //segundo dia
				document.getElementById(eldia).className='marcado';
				document.getElementById('hastaf').value=eldia;
				queMarca=0 //pa la primera y desmarcar
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_ponerdatos")%>';
				//Guardo la segunda marca
				SetCookie ('hastaf',eldia);
				SetCookie('lamarca','0');
				rangoMarca(true);
				document.f1.precio.focus();
				break;
				
			case 0: //volver a marcar
				//desmarcar las anteriores
				primera=unescape(GetCookie('desdef'));
				document.getElementById(primera).className='sinmarca';
				segunda=unescape(GetCookie('hastaf'));
				document.getElementById(segunda).className='sinmarca';
				rangoMarca(false);
				//marcar la nueva
				document.getElementById(eldia).className='marcado';
				document.getElementById('desdef').value=eldia;
				queMarca=2 //pa la segunda
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_segundafecha")%>';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				break;
		}
	
	} //tControl (tecla control pulsada)
}

function marcaConControl(esedia){
	if (queMarca==0 || queMarca==2) { //está usando el otro sistema
		//desmarcar el otro sistema
		primera=unescape(GetCookie('desdef'));
		document.getElementById(primera).className='sinmarca';
		segunda=unescape(GetCookie('hastaf'));
		document.getElementById(segunda).className='sinmarca';
		rangoMarca(false);
		queMarca=1; //valor inicial
	} 
	
	//Comprobar que no esté marcado en caso contrario desmarcar
	if (tablaMarcas.indexOf(esedia)==-1){ //está no ta
		document.getElementById(esedia).className='marcado';
		tablaMarcas=tablaMarcas+"-"+esedia;
	}else{ //ya ta, hay que desmarcarlo y quitarlo del array
		document.getElementById(esedia).className='sinmarca';
		tablaMarcas=tablaMarcas.replace("-"+esedia,"");
	}
	//ver las fechas seleccionadas
	//document.getElementById('notas').innerHTML="("+tablaMarcas+")";
}

function quitarMarcasControl(){
	if (tablaMarcas!=""){
		lista=tablaMarcas.split("-");
		for (q=0;q<lista.length;q++){
			if (lista[q]!="")
				document.getElementById(lista[q]).className="sinmarca";
		}
		tablaMarcas="";
	}
}

function rangoMarca(quehago){
	//inicio=parseInt(GetCookie('desdef').substr(0,2),10);
	inicio=parseInt(document.getElementById('desdef').value.substr(0,2),10);
	//fin=parseInt(GetCookie('hastaf').substr(0,2),10);
	fin=parseInt(document.getElementById('hastaf').value.substr(0,2),10);
	if (inicio>fin){ //intercambia fechas
		cambia_de_fecha_desde_a_fecha_hasta();
		xoco=inicio;
		inicio=fin;
		fin=xoco;
	}
	if (quehago)
		esaclase='marcado';
	else
		esaclase='sinmarca';
	for (q=inicio;q<=fin;q++){
		dia=q;
		if (dia<10) dia="0"+dia;
		document.getElementById(dia+'/<%=right("0"&mes,2)%>/<%=el_anyo%>').className=esaclase;
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
	txt='<%=objIdioma.getTraduccion("i_cambiosrealizar")%>:\n';
	if (tablaMarcas!="") { //seleccion multiple manual
		document.f1.arrayFechas.value=tablaMarcas;
		texto=tablaMarcas.replace(/-/g,"\n");
		txt=txt+'<%=objIdioma.getTraduccion("i_fechasseleccionadas")%>: '+texto+"\n\n";
	}else{
		if (document.f1.desdef.value=='') {
			alert("<%=objIdioma.getTraduccion("i_errorfechas")%>");
			return;
		}
		if (document.f1.hastaf.value=='')
			document.f1.hastaf.value=document.f1.desdef.value;
			
		txt=txt+'<%=objIdioma.getTraduccion("i_desdedia")%> '+document.f1.desdef.value;
		txt=txt+' <%=objIdioma.getTraduccion("i_hasta")%> '+document.f1.hastaf.value+"\n";
		//dias de la semana
		semana="";
		for (t=0;t<document.f1.length;t++){
			if (document.f1[t].name=='diaS' && document.f1[t].checked){
				if (document.f1[t].value=="L") semana=semana+"<%=nomdia(1)%>, ";
				if (document.f1[t].value=="M") semana=semana+"<%=nomdia(2)%>, ";
				if (document.f1[t].value=="X") semana=semana+"<%=nomdia(3)%>, ";
				if (document.f1[t].value=="J") semana=semana+"<%=nomdia(4)%>, ";
				if (document.f1[t].value=="V") semana=semana+"<%=nomdia(5)%>, ";
				if (document.f1[t].value=="S") semana=semana+"<%=nomdia(6)%>, ";
				if (document.f1[t].value=="D") semana=semana+"<%=nomdia(7)%>, ";
			}
		}
		if (semana!=""){
			if (semana=="<%=nomdia(1)%>, <%=nomdia(2)%>, <%=nomdia(3)%>, <%=nomdia(4)%>, <%=nomdia(5)%>, <%=nomdia(6)%>, <%=nomdia(7)%>, ") 
				semana='<%=objIdioma.getTraduccion("i_todoslosdias")%>\n';
			else{
				//Quitar la ultima coma
				semana=semana.substring(0,(semana.length-2))+' <%=objIdioma.getTraduccion("i_delasemana")%>\n';
			}
		}
		txt=txt+semana;
	} //seleccion multiple manual

	//datos 
	if (document.f1.precio.value!='')
		txt=txt+'<%=objIdioma.getTraduccion("i_precio")%>: '+document.f1.precio.value+"\n";
	if (document.f1.cupo.value!='')
		txt=txt+'<%=objIdioma.getTraduccion("i_cupo")%>: '+document.f1.cupo.value+"\n";
	if (document.f1.minimos.value!='')
		txt=txt+'<%=objIdioma.getTraduccion("i_estanciaminima")%>: '+document.f1.minimos.value+"\n";
	if (document.f1.release.value!='')
		txt=txt+"Release: "+document.f1.release.value+"\n";
	if (document.f1.estado.value!='')
		txt=txt+'<%=objIdioma.getTraduccion("i_estado")%>:'+document.f1.estado[document.f1.estado.selectedIndex].text+"\n";
	if (document.f1.checkin.value!='')
		txt=txt+'<%=objIdioma.getTraduccion("i_limitecheckin")%>:'+document.f1.checkin.value+"\n";
	
	if (confirm(txt))
		document.f1.submit();
		
}

function cambiaFiltro() {
	cualorango=document.f1.rangom.value;
	url="preciosTrimestre.asp?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>&rm="+cualorango+"&th=<%=thab%>";
	window.location=url;
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">YIELD MANAGEMENT -> <%=NHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name="f1" method="post" action="<%=MiPag%>?est=<%=est%>&thab=<%=thab%>&mes=<%=mes%>&anyo=<%=el_anyo%>">
<input type="hidden" name="arrayFechas" value=""/>
<table cellspacing='0' cellpadding="0" border="0" width="100%" style="margin-top:3px;">
<tr>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_hotelseleccionado")%>:
		<select name='HSeleccionado' id='HSeleccionado' onchange="Javascript:CambioHotel(this);" style="width:200px">
		<%if hayHoteles then
			for h=0 to ubound(RegHoteles,2)
				marca=""
				select case RegHoteles(HEstado,h)
					case noventa
						nestado=" (" & objIdioma.getTraduccionHTML("i_noventa") & ")"
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
		<input type="text" name="ajaxHot" id='ajaxHot' style="width:110px;" maxlength="25" onblur="javascript:searchByName();">

	</td>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_tipohab")%>:
		<select name='thab' onchange="Javascript:CambioHabi(this);">
		<%if hayhabis then
			for h=0 to ubound(RegHabis,2)
				marca=""
				if RegHabis(HaCodi,h)=thab then marca=" selected"%>
				<option value='<%=RegHabis(HaCodi,h)%>'<%=marca%>><%=RegHabis(HaNombre,h)%></option>
			<%next
		end if%>
		</select>
	</td>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_rangomeses")%>: 
	<select name="rangom" onChange="javascript:cambiaFiltro();">
		<option value="1"<%if rm=1 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_mensual")%></option>
		<option value="3"<%if rm=3 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_trimestral")%></option>
		<option value="6"<%if rm=6 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_semestral")%></option>
		<option value="12"<%if rm=12 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_anual")%></option>
	</select>
	</td>
</tr>
</table>
<div class="tituloTabla">
	<a href='javascript:dM()'>&laquo;&nbsp;<%=objIdioma.getTraduccionHTML("i_mesanterior")%>&nbsp;&nbsp;</a>
	<select name="elmes" onChange="javascript:saltaMes(this.value);" style="height:17px">
	<%
	for aa=year(date) to year(date)+1
		for mm=1 to 12%>
			<option value='<%=mm & "-" & aa%>'<%if mm=mes and aa=el_anyo then response.write " selected"%>><%=nombreMes(mm) & " " & aa%></option>
		<%next 'mes
	next 'año%>
	</select>
	<a href='javascript:iM()'>&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_messiguiente")%>&nbsp;&raquo;</a>
</div>
<div id='capaTabla'>
<table id='miTabla' align="center" width="100%"  cellpadding="0" cellspacing="0">
	<tr>
		<%for d=1 to 7%>
		<th class="colu_par" align="center" width="14%"><%=ucase1(nomdia(d))%></th>
		<%next 'd%>
	</tr>
	<%
	'color del estado
	dim colorEstado(2),textoEstado(2)
	colorEstado(0)=" class='noventa'" 'no venta
	colorEstado(1)=" class='onrequest'" 'on request
	colorEstado(2)=" class='guena'" 'on oline
	textoEstado(0)="NV" 'no venta
	textoEstado(1)="OR" 'On Request
	textoEstado(2)="OL" 'On Line
	regDia=0
	if hayCupos then
		for d=fini to ffin 'dias del mes
			for ds=1 to 7 'dias de la semana
				if ds=1 then response.write "<tr>"
				if weekday(d,vbmonday)=ds then 'dia de la semana
					'Poner datos del día
					if regDia<=ubound(RegCupos,2) then
						if RegCupos(CuDia,RegDia)=d then 'es fecha correcta de cupo
							response.write "<td align='left' id='" & right("0"&day(d),2) & "/" & right("0"&month(d),2) & "/" & year(d) & "' " & colorEstado(RegCupos(CuEstado,RegDia)) & " onclick='javascript:marcar(this);'>"
							'response.write "<td align='left' id='" & right("0"&day(d),2) & "/" & right("0"&month(d),2) & "/" & year(d) & "' class='guena'>"
							response.write "<p align='center'><b>" & day(d) & " - " & textoEstado(RegCupos(CuEstado,RegDia)) & "</b></p>"
							response.write objIdioma.getTraduccionHTML("i_precio") & ": <b>" & formatnumber(RegCupos(CuPelas,regDia),2) & "</b><br/>"
							response.write objIdioma.getTraduccionHTML("i_est_minima") & ": " & RegCupos(CuMinimos,regDia) & "&nbsp;&nbsp;&nbsp;"
							response.write "Release: " & paClng(RegCupos(CuRelease,regDia)) & "<br/>"
							if RegParon(PCupo,regDia)<1 then
								response.write "<span style='color:red'>Cupo: " & RegParon(PCupo,regDia) & "</span>&nbsp;&nbsp;&nbsp;"
							else
								response.write objIdioma.getTraduccionHTML("i_cupo") & ": " & RegParon(PCupo,regDia) & "&nbsp;&nbsp;&nbsp;"
							end if
							response.write objIdioma.getTraduccionHTML("i_ocup") & ": " & paClng(RegParon(POcu,regDia)) & "<br/>"
							if (RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia)))<1 then
								response.write "<span style='color:red'>" & objIdioma.getTraduccionHTML("i_libres") & ": " & RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia)) & "</span>"
							else
								response.write objIdioma.getTraduccionHTML("i_libres") & ": " & RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia))
							end if
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;" & objIdioma.getTraduccionHTML("i_lcheckin") & ": "
							if RegCupos(CuCheckIn,RegDia)<0 then
								response.Write "NL"
							else
								response.Write "<font color='red'>" & RegCupos(CuCheckIn,RegDia) & "</font>"
							end if
							response.write "</td>"
							regDia=regDia+1 'siguiente registro
						else 'no coincide con la fecha cupo
							response.write "<td align='center'"
							response.write "<p align='center'>" & day(d) & "</p></td>"
						end if 'fecha cupo
					end if 'regdias
					if d<ffin then 'comprobar no pasarse
						d=d+1 'suma fecha
					else 'me pasao
						'Salimos de la semana y del mes
						for dd=ds+1 to 7
							response.write "<td bgcolor='white'>&nbsp;</td>"
						next
						response.write "</tr>"
						exit for
					end if
				else
					response.write "<td bgcolor='white'>&nbsp;</td>"
				end if
				if ds=7 then 
					response.write "</tr>"
					d=d-1 'ahora lo bajo porque se va al next de la fecha
				end if 'ds=7
			next 'ds
		next 'd				
	end if 'haycupos
	%>
</table>
	<div id='notas' align="center"><%=objIdioma.getTraduccionHTML("i_pulsarsobredia")%></div>
</div>

<div id='capaFin'>
	<div id='finIzq' style="float:left; width:350px; overflow:hidden; height:auto">
        <div style="float:left; margin-top:2px;">&nbsp;<%=objIdioma.getTraduccionHTML("i_rangofechas")%>:</div>
        <div style="float:left; margin-left:5px; text-align:right; line-height:20px;">
        <%=objIdioma.getTraduccionHTML("i_desde")%> <input type="text" id='desdef' name="desdef" maxlength="14" value="" style="width:65px;" onChange="alert('cambio');"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('desdef','f1',self.name,'','<%=lang%>');" style="cursor:pointer"><br/>
        <%=objIdioma.getTraduccionHTML("i_hasta")%> <input type="text" id='hastaf' name="hastaf" maxlength="14" value="" style="width:65px;"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('hastaf','f1',self.name,'','<%=lang%>');" style="cursor:pointer">
        </div>
    </div> <!-- finIzq -->
    <div id='finDer' style="float:left; margin-left:10px; overflow:hidden; width:610px;">
		<div style="clear:both;" id='diasSemana'>
			<input type="checkbox" onClick="javascript:marcaSemana(this);" checked>
			<%=objIdioma.getTraduccionHTML("i_todoslosdias_o")%>
			&nbsp;&nbsp;<%=nomdia(1)%><input type="checkbox" value="L" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(2)%><input type="checkbox" value="M" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(3)%><input type="checkbox" value="X" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(4)%><input type="checkbox" value="J" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(5)%><input type="checkbox" value="V" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(6)%><input type="checkbox" value="S" name='diaS' checked>
			&nbsp;&nbsp;<%=nomdia(7)%><input type="checkbox" value="D" name='diaS' checked>
		</div>
        <div style="float:left; margin-top:5px;"><b><%=objIdioma.getTraduccionHTML("i_cambiardatos")%>:</b></div>
		<div style="float:left; width:500px; height:45px; overflow:hidden" align="left">
			<span id='elprecio' style='float:left; margin:3px 0px 0px 15px;'><%=objIdioma.getTraduccionHTML("i_precio")%> <input type="text" id='precio' name="precio" maxlength="8" value="" style="width:50px;"></span>
			<span id='elcupo' style='float:left; margin:3px 0px 0px 15px;'>
			<%=objIdioma.getTraduccionHTML("i_cupo")%> <input type="text" id='cupo' name="cupo" maxlength="8" value="" style="width:20px;"></span>
			<span id='elminimo' style='float:left; margin:3px 0px 0px 15px;'>
			<%=objIdioma.getTraduccionHTML("i_estanciaminima")%> <input type="text" id='minimos' name="minimos" maxlength="8" value="" style="width:20px;"></span>
			<span id='elrelease' style='float:left; margin:3px 0px 0px 15px;'>
			Release <input type="text" id='release' name="release" maxlength="8" value="" style="width:20px;"></span>
            <br style="clear:both"/>
			<span id='elestado' style='float:left; margin:3px 0px 0px 15px;'>
			<%=objIdioma.getTraduccionHTML("i_estado")%> 
			<select name="estado">
				<option value=""><%=objIdioma.getTraduccionHTML("i_nocambiar")%></option>
				<option value="0"><%=objIdioma.getTraduccionHTML("i_noventa")%></option>
				<option value="1">On Request</option>
				<option value="2">On Line</option>
			</select>
			</span>
            <span id='elcheckin' style='float:left; margin:3px 0px 0px 15px;'>
			<%=objIdioma.getTraduccionHTML("i_limitecheckin")%>&nbsp;<input type="text" id='checkin' name="checkin" maxlength="8" value="" style="width:20px;">(NL=Not Limit)</span>
		</div>
	</div> <!-- finder-->
    <div style="clear:both;" align="center">
        <input name="buttons" type="button" class='boton86' onClick="javascript:modificar();" value="<%=objIdioma.getTraduccionHTML("i_modificar")%>">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="buttonq" type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>">
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