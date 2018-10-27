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

'datos para visualizacion
th=paClng(request.QueryString("th")) 'tipo habitacion
rm=paClng(request.QueryString("rm")) 'rango meses
if rm=0 then rm=3 'trimestral por defecto

tipoD=paClng(request.QueryString("tipoD"))
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

laminima=cdate("01/" & mes & "/" & el_anyo)
midia=31
if mes+rm>12 then
	mesfin=(mes+rm)-12
	anyofin=el_anyo+1
	lamaxima=midia & "/" & mesfin & "/" & anyofin
else 'mismo año
	mesfin=mes+rm
	anyofin=el_anyo
	lamaxima=midia & "/" & mesfin & "/" & anyofin
end if
do while not isdate(lamaxima)
	midia=midia-1 'bajo un dia
	lamaxima=midia & "/" & mesfin & "/" & anyofin
loop
'response.write lamaxima 

'Minimos y release
select case tipoD
	case 0 'Cupos
		elcampo="Cupo,"	
		titulo=objIdioma.getTraduccionHTML("i_cuposhabitaciondia") & " "
	case 1 'Precios
		elcampo="Precio,"
		titulo=objIdioma.getTraduccionHTML("i_precioshabidia") & " "
	case 2 'Est. minima
		elcampo="DiasMinimos,"
		titulo=objIdioma.getTraduccionHTML("i_eminimahabidia") & " "
	case 3 'Release
		elcampo="ReleaseHab,"
		titulo=objIdioma.getTraduccionHTML("i_releasehabidia") & " "
	case 4 'Estado
		'Ya viene por defecto
		elcampo=""
		titulo=objIdioma.getTraduccionHTML("i_estadohabidia") & " "
		'cs="DiasMinimos,"
	case 5 'Limite check-in
		elcampo="LimiteCheckIn,"
		titulo=objIdioma.getTraduccionHTML("i_checkinhabidia") & " "
end select

cs="SELECT Dia,CodigoHab," & elcampo
cs=cs & "Estado,SUM(Cuantas) as Disponibles "
cs=cs & "FROM " & precrs & "Cupos Cupos LEFT JOIN "
cs=cs & "(SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM jos_crs_TipoReserva TipoReserva INNER JOIN jos_crs_Reservas Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0 AND Anulada=0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal) Confirmadas "
cs=cs & "ON Cupos.CodigoHab=Confirmadas.IdTipoHabitacion AND "
cs=cs & "Cupos.Dia>=Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal "
cs=cs & "WHERE Cupos.CodigoEsta=" & est & " AND (Dia BETWEEN " & FechaMySQL(laminima) & " AND " & FechaMySQL(lamaxima) & ")"
if th<>0 then 'hay tipo hab.
	cs=cs & " AND CodigoHab=" & th & " " 
end if
cs=cs & " GROUP BY CodigoHab,Dia," & elcampo
cs=cs & "Estado ORDER BY CodigoHab,Dia"
'response.write cs
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	PDia=0
	PHabi=1
	PValor=2
	PEstado=3
	PDispo=4
	if tipoD=4 then 'estado
		PEstado=2
		PDispo=3
	end if
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
cs= "SELECT TipoHabitaNombres.Id,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabitaNombres' AND Campo='Nombre' AND Idioma='" & lang & "' "
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

if multiTarifa then
	%><!--#include file="datosMultiTarifa.asp"--><%
end if 'multiTarifa

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
	height:430px;
	/*overflow-x:hidden;
	overflow-y:scroll;*/
	overflow:scroll;
	/*margin-top:3px;*/
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
	/*height:88px;*/
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
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&tipoD=<%=tipoD%>&th=<%=th%>&rm=<%=rm%>&est=<%=est%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mes%>-1;
	anyo=<%=el_anyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&tipoD=<%=tipoD%>&th=<%=th%>&rm=<%=rm%>&est=<%=est%>";
	document.f1.submit();
}

function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="<%=MiPag%>?mes="+imes+"&anyo="+ianyo+"&thab=<%=thab%>&tipoD=<%=tipoD%>&th=<%=th%>&rm=<%=rm%>&est=<%=est%>";
	document.f1.submit();
}

queMarca=<%=paClng(request.QueryString("mc"))%>; //dia Inicial
if (queMarca==0) queMarca=1;
tablaMarcas="";
codiHab="0";
function marcar(celda){
	micelda=celda.id.split("_");
	eldia=micelda[0];
	if (codiHab!="0" && codiHab!=micelda[1] && queMarca==2){
		alert('<%=objIdioma.getTraduccion("i_solomismahab")%>');
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
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_segundafecha")%>';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				codiHab=micelda[1]; //codig. habitacion
				selectHabi(codiHab);
				break;
		
			case 2: //segundo dia
				celda.className='marcado';
				document.getElementById('hastaf').value=eldia;
				queMarca=0 //pa la primera y desmarcar
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_ponerdatos")%>';
				//Guardo la segunda marca
				SetCookie ('hastaf',eldia);
				SetCookie('lamarca','0');
				rangoMarca(true);
				//document.f1.precio.focus();
				codiHab=micelda[1]; //codig. habitacion
				document.f1.codigohabi.value=codiHab;
				selectHabi(codiHab);
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
				document.getElementById('notas').innerHTML='<%=objIdioma.getTraduccion("i_segundafecha")%>';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				codiHab=micelda[1]; //codig. habitacion
				selectHabi(codiHab);
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
	selectHabi(micelda[1]);
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
	txt='<%=objIdioma.getTraduccion("i_cambiosrealizar")%>:\n';
	if (document.f1.codigohabi.value!="0")
		txt=txt+"<%=objIdioma.getTraduccion("i_habitacion")%>: "+document.f1.esaHabi[document.f1.esaHabi.selectedIndex].text+"\n";
		
	if (tablaMarcas!="") { //seleccion multiple manual
		document.f1.arrayFechas.value=tablaMarcas;
		texto=tablaMarcas.replace(/-/g,"\n");
		txt=txt+"<%=objIdioma.getTraduccion("i_fechasseleccionadas")%>: "+texto+"\n\n";
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
	//alert(cualorango);
	if (cualorango=="1") { //mensual
		window.location="verMesPrecios.asp?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&thab=<%=th%>";
		return;
	}
	cualotipo=document.f1.eltipo.value;
	cualohotel=document.f1.HSeleccionado.value;
	cualahabi=document.f1.tipohabi.value;
	url="<%=MiPag%>?est="+cualohotel+"&mes=<%=mes%>&anyo=<%=el_anyo%>&tipoD="+cualotipo+"&rm="+cualorango+"&th="+cualahabi;
	window.location=url;
}

function selectHabi(esa){
	document.f1.esaHabi.value=esa;
	document.f1.codigohabi.value=esa;
}

function cambioTarifa(esa){
	//Guardar en cookie el anyo
	SetCookie("tarifa",esa.value,null,"/");
	//recarga la pagina
	window.location="<%=MiPag & "?" & request.QueryString()%>";
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=titulo%> -> <%=NHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name="f1" method="post" action="<%=MiPag%>?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&tipoD=<%=tipoD%>&th=<%=th%>&rm=<%=rm%>">
<input type="hidden" name="arrayFechas" value=""/>
<input type="hidden" name="codigohabi" value=""/>
<table cellspacing='0' cellpadding="0" border="0" width="100%" style="margin-top:3px;">
<tr>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_hotelseleccionado")%>:
		<select name='HSeleccionado' id='HSeleccionado' onchange="Javascript:cambiaFiltro();" style="width:200px">
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
				if RegHoteles(HCodi,h)=est then marca=" selected"%>
				<option value='<%=RegHoteles(HCodi,h)%>'<%=marca%>><%=RegHoteles(HNombre,h) & nestado%></option>
			<%next
		end if%>
		</select>
		<input type="text" name="ajaxHot" id='ajaxHot' style="width:50px;" maxlength="25" onblur="javascript:searchByNameFiltro();">

	</td>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_tipohab")%>:
		<select name='tipohabi' onchange="Javascript:cambiaFiltro();" style="width:200px">
		<option value="0"><%=objIdioma.getTraduccionHTML("i_todas")%></option>
		<%if hayhabis then
			for h=0 to ubound(RegHabis,2)
				marca=""
				if RegHabis(HaCodi,h)=th then marca=" selected"%>
				<option value='<%=RegHabis(HaCodi,h)%>'<%=marca%>><%=RegHabis(HaNombre,h)%></option>
			<%next
		end if%>
		</select>
	</td>
	<td align='left'><%=objIdioma.getTraduccionHTML("i_tipodatos")%>: 
	<select name="eltipo" onChange="javascript:cambiaFiltro();">
		<option value="0"<%if tipoD=0 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_disponibilidad")%></option>
		<option value="1"<%if tipoD=1 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_preciosdia")%></option>
		<option value="2"<%if tipoD=2 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_estanciaminima")%></option>
		<option value="3"<%if tipoD=3 then response.write " selected"%>>Release</option>
		<option value="4"<%if tipoD=4 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_estadohab")%></option>
		<option value="5"<%if tipoD=5 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_limitecheckin")%></option>
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
  <div class="tituloTabla" style="position:relative "> 
    <%if multiTarifa and hayTarifas then%>
    <p style="position:absolute; top:2px; left:3px; font-weight:bold"> 
      <%=objIdioma.getTraduccionHTML("i_tarifa")%>
      <select name='tarifa' onChange="javascript:cambioTarifa(this);">
        <%for t=0 to ubound(RegTarifas,2)
			marca=""
			if RegTarifas(TaCodi,t)=laTarifa then marca=" selected"%>
        <option value='<%=RegTarifas(TaCodi,t)%>'<%=marca%>> 
        <%=RegTarifas(TaNombre,t)%>
        </option>
        <%next 't%>
      </select>
    </p>
    <%end if%>
    <a href='javascript:dM()'>&laquo;&nbsp; 
    <%=objIdioma.getTraduccionHTML("i_mesanterior")%>
    &nbsp;&nbsp;</a> 
    <select name="elmes" onChange="javascript:saltaMes(this.value);" style="height:17px">
      <%
	for aa=year(date) to year(date)+1
		for mm=1 to 12%>
      <option value='<%=mm & "-" & aa%>'<%if mm=mes and aa=el_anyo then response.write " selected"%>> 
      <%=nombreMes(mm) & " " & aa%>
      </option>
      <%next 'mes
	next 'año%>
    </select>
    <a href='javascript:iM()'>&nbsp;&nbsp; 
    <%=objIdioma.getTraduccionHTML("i_messiguiente")%>
    &nbsp;&raquo;</a> </div>
<div id='capaTabla'>
<%if haylista then 'hay datos%>
<table id='losmeses' align="center" width="100%" cellpadding="0" cellspacing="0">
	<%
	'color del estado
	dim colorEstado(2)
	colorEstado(0)=" style='color:red'" 'no venta
	colorEstado(1)=" style='color:blue'" 'on request
	colorEstado(2)=" style='color:green'" 'on oline
	
	for mm=0 to (rm-1) 'pa sumar los meses
		elmes=mes+mm
		if elmes>12 then
			elmes=elmes-12
			mianyo=el_anyo+1
		else
			mianyo=el_anyo
		end if
		%>
		<tr><td colspan="33" align="center" style="border:none"><b><%=titulo%> <%=ucase(nombreMes(elmes)) & " " & mianyo%></b></td></tr>
		
		<%for d=1 to 31
			if d=1 then 'el primero
				response.write "<tr><td></td>"
			end if
			midia=d & "/" & elmes & "/" & mianyo
			if isdate(midia) then
				fondillo=""
				if weekDay(midia)=vbsunday or weekDay(midia)=vbsaturday then fondillo=" bgcolor='#cccccc'"
				response.write "<td align='center'" & fondillo & ">" & d & "</td>" & vbcrlf
			else
				response.write "<td></td>" & vbcrlf
			end if
			if d=31 then response.write "<td width='10' style='border:none'></td></tr>"
		next%>
		<%'los tipos de habitacion
		if hayHabis then
		for h=0 to ubound(RegHabis,2)
			if th=0 OR RegHabis(HaCodi,h)=th then 'o todas o la seleccionada 
			for d=1 to 31
				if d=1 then 'el primero
					response.write "<tr><td align='right'>" & RegHabis(HNombre,h) & "&nbsp;</td>"
				end if
				midia=d & "/" & elmes & "/" & mianyo
				if isdate(midia) then
					fondillo=""
					if weekDay(midia)=vbsunday or weekDay(midia)=vbsaturday then fondillo=" bgcolor='#cccccc'"
					'Buscar dia en cupo de la habi
					haydia=false
					for hh=0 to ubound(RegLista,2)
						if RegLista(PDia,hh)=cdate(midia) AND RegLista(PHabi,hh)=RegHabis(HCodi,h) then 'este es el día
							haydia=true
							valor=RegLista(PValor,hh)
							if tipoD=4 then 'estado
								select case valor
									case 0
										valor="NV"
									case 1
										valor="OR"
									case 2
										valor="OL"
								end select
							end if
							if tipoD=5 then 'limite check-in
								if valor<0 then valor="NL" 'not limit
							end if 'tipoD=5
							exit for
						end if
					next 'hh
					if haydia then
						response.write "<td align='center'" & fondillo & colorEstado(paClng(RegLista(PEstado,hh))) & " id='" & right("0"&day(midia),2) & "/" & right("0"&month(midia),2) & "/" & year(midia) & "_" & RegLista(PHabi,hh) & "' onclick='javascript:marcar(this);' class='celdilla'>" & valor & "</td>" & vbcrlf
					else
						response.write "<td align='center'" & fondillo & " style='width:25px'> </td>" & vbcrlf
					end if
				else
					response.write "<td></td>" & vbcrlf
				end if
				if d=31 then response.write "<td width='10' style='border:none'></td></tr>"
			next 'dias
			end if 'esa habitacion
		next 'reglista
		end if 'haylista%>
		<tr><td colspan="33" height="10" style="border:none"></td></tr>
	<%next 'suma mes%>

</table>
	<div id='notas' align="center"><%=objIdioma.getTraduccionHTML("i_pulsarsobredia")%></div>
<%else 'no hay datos
	response.write objIdioma.getTraduccionHTML("i_nodatosfechas") 
end if 'haylista%>
</div>
<div id='capaFin'>
	<div id='finIzq' style="float:left; width:350px; overflow:hidden; height:auto">
        <div style="clear:both; height:20px;">
            &nbsp;<%=objIdioma.getTraduccionHTML("i_habiseleccionada")%>
            <select name='esaHabi' style="width:200px">
            <option value="0"><%=objIdioma.getTraduccionHTML("i_todas")%></option>
			<%if hayhabis then
                for h=0 to ubound(RegHabis,2)
                    marca=""
                    if RegHabis(HaCodi,h)=th then marca=" selected"%>
                    <option value='<%=RegHabis(HaCodi,h)%>'<%=marca%>><%=RegHabis(HaNombre,h)%></option>
                <%next
            end if%>
            </select>
        </div>
        
        <div style="float:left; margin-top:2px;">&nbsp;<%=objIdioma.getTraduccionHTML("i_rangofechas")%>:</div>
        <div style="float:left; margin-left:5px; text-align:right; line-height:21px">
        <%=objIdioma.getTraduccionHTML("i_desde")%> <input type="text" id='desdef' name="desdef" maxlength="14" value="" style="width:65px;" onChange="alert('cambio');"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('desdef','f1',self.name,'','<%=lang%>');" style="cursor:pointer"><br/>
        <%=objIdioma.getTraduccionHTML("i_hasta")%> <input type="text" id='hastaf' name="hastaf" maxlength="14" value="" style="width:65px;"><img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('hastaf','f1',self.name,'','<%=lang%>');" style="cursor:pointer">
        </div>
    </div> <!-- finIzq -->
    <div id='finDer' style="float:left; margin-left:10px; overflow:hidden; width:630px;">
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
			<span id='elprecio' class="tapaos"><%=objIdioma.getTraduccionHTML("i_precio")%> <input type="text" id='precio' name="precio" maxlength="8" value="" style="width:50px;"></span>
			<span id='elcupo' class="tapaos">
			<%=objIdioma.getTraduccionHTML("i_cupo")%> <input type="text" id='cupo' name="cupo" maxlength="8" value="" style="width:20px;"></span>
			<span id='elminimo' class="tapaos">
			<%=objIdioma.getTraduccionHTML("i_estanciaminima")%> <input type="text" id='minimos' name="minimos" maxlength="8" value="" style="width:20px;"></span>
			<span id='elrelease' class="tapaos">
			Release <input type="text" id='release' name="release" maxlength="8" value="" style="width:20px;"></span>
            <br style="clear:both;"/>
			<span id='elestado' class="tapaos">
			<%=objIdioma.getTraduccionHTML("i_estado")%> 
			<select name="estado">
				<option value=""><%=objIdioma.getTraduccionHTML("i_nocambiar")%></option>
				<option value="0"><%=objIdioma.getTraduccionHTML("i_noventa")%></option>
				<option value="1">On Request</option>
				<option value="2">On Line</option>
			</select>
			</span>
            <span id='elcheckin' class="tapaos">
			<%=objIdioma.getTraduccionHTML("i_limitecheckin")%>&nbsp;<input type="text" id='checkin' name="checkin" maxlength="5" value="" style="width:20px;">(NL=Not Limit)</span>

			<span id='vertodos' style="float:left; margin:5px 0 0 15px;"><a href="javascript:verOtros();"><%=objIdioma.getTraduccionHTML("i_cambiarotros")%></a></span>
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
function verCampo(ese){
	switch (ese){
		case 0:
			document.getElementById('elcupo').style.display='block';
			break;
		case 1:
			document.getElementById('elprecio').style.display='block';
			break;
		case 2:
			document.getElementById('elminimo').style.display='block';
			break;
		case 3:
			document.getElementById('elrelease').style.display='block';
			break;
		case 4:
			document.getElementById('elestado').style.display='block';
			break;
		case 5:
			document.getElementById('elcheckin').style.display='block';
			break;
	}
}	
verCampo(<%=paClng(tipoD)%>); //visualiza sólo el campo que veo

seve=false;
function verOtros(){
	if (seve) { //pos que no se vea
		document.getElementById('elcupo').style.display='none';
		document.getElementById('elprecio').style.display='none';
		document.getElementById('elminimo').style.display='none';
		document.getElementById('elrelease').style.display='none';
		document.getElementById('elestado').style.display='none';
		document.getElementById('elcheckin').style.display='none';
		verCampo(<%=paClng(tipoD)%>);
		
	}else{ //que se vean todos
		document.getElementById('elcupo').style.display='block';
		document.getElementById('elprecio').style.display='block';
		document.getElementById('elminimo').style.display='block';
		document.getElementById('elrelease').style.display='block';
		document.getElementById('elestado').style.display='block';
		document.getElementById('elcheckin').style.display='block';
	}
	seve=!seve;
}



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
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
