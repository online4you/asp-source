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
	thab=paClng(request.QueryString("thab"))
	desdef=request.form("desdef")
	hastaf=request.form("hastaf")
	precio=request.form("precio") 'casi seguro que han usado el punto como separador decimal
	if precio<>"" then
		precio=paDbl(replace(precio,".",",")) 'decimales en España
	end if
	cupo=request.form("cupo")
	if cupo<>"" then cupo=paClng(cupo)
	minimos=request.form("minimos")
	if minimos<>"" then minimos=paClng(minimos)
	release=request.form("release")
	if release<>"" then release=paClng(release)
	diasSemana=request.form("diaS")
	listaFechas=split(request.form("arrayFechas"),"-")
	if ubound(listaFechas)>0 then 'seleccion fechas manual
		
		if precio<>"" or cupo<>"" or minimos<>"" or release<>"" then 'hay para actualizar
				cs="UPDATE " & precrs & "Cupos SET "
				if precio<>"" then cs=cs & "Precio=" & quitarComa(precio) & ","
				if cupo<>"" then cs=cs & "Cupo=" & cupo & ","
				if minimos<>"" then cs=cs & "DiasMinimos=" & minimos & ","
				if release<>"" then cs=cs & "Release=" & release & ","
				'Quitar la ultima coma
				if right(cs,1)="," then cs=left(cs,len(cs)-1) & " "
				cs=cs & "WHERE CodigoHab=" & thab & " AND ("
				for f=0 to ubound(listaFechas)
					if listaFechas(f)<>"" then
						cs=cs & "Dia=" & FechaMySQL(listaFechas(f)) & " OR "
					end if
				next 'f
				'Quitar el último OR
				if right(cs,4)=" OR " then cs=left(cs,len(cs)-4) & ")"
				'response.write cs
				base.execute cs
	
		end if 'datos por actualizar
		
	else 'rango de fechas

		if isdate(desdef) and isdate(hastaf) then
			if precio<>"" or cupo<>"" or minimos<>"" or release<>"" then 'hay para actualizar
				cs="UPDATE " & precrs & "Cupos SET "
				if precio<>"" then cs=cs & "Precio=" & quitarComa(precio) & ","
				if cupo<>"" then cs=cs & "Cupo=" & cupo & ","
				if minimos<>"" then cs=cs & "DiasMinimos=" & minimos & ","
				if release<>"" then cs=cs & "Release=" & release & ","
				'Quitar la ultima coma
				if right(cs,1)="," then cs=left(cs,len(cs)-1) & " "
				
				'Comprobar que dias de la semana
				if diasSemana="L, M, X, J, V, S, D" then 'son todos
					cs=cs & "WHERE (Dia BETWEEN " & FechaMySQL(desdef) & " AND " & FechaMySQL(hastaf)
					cs=cs & ") AND CodigoHab=" & thab
					'response.write cs & "<br>"
					base.execute cs
				else 'ahora viene el cacao
					'Array de la semana
					dim losdias(7)
					losdias(1)="L"
					losdias(2)="M"
					losdias(3)="X"
					losdias(4)="J"
					losdias(5)="V"
					losdias(6)="S"
					losdias(7)="D"
					'Bucle de fechas
					for dd=cdate(desdef) to cdate(hastaf)
						midia=losdias(weekday(dd,vbmonday))
						if instr(diasSemana,midia)<>0 then 'este dia es gueno
							cs2="WHERE Dia=" & FechaMySQL(dd)
							cs2=cs2 & " AND CodigoHab=" & thab
							base.execute cs & cs2
						end if
					next 'dd
				end if
				
				
			end if 'actualizar
		
		else
			msgerror="Fechas no válidas"
		end if
		
	end if 'lista manual fechas

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
	cs=cs & "FROM " & precrs & "Disponibles "
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
	cs="SELECT Dia,Precio,DiasMinimos,Release "
	cs=cs & "FROM " & precrs & "Cupos "
	cs=cs & "WHERE CodigoHab=" & thab
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
<style type="text/css">
#capaTabla {
	height:490px;
	overflow:hidden;
}
#miTabla {
	border:1px solid #999999;
}
#miTabla td {
	height:60px;
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
	padding-left:5px;
}
#miTabla td.guena, .sinmarca {
	cursor:pointer;
}
#miTabla td.guena:hover, .sinmarca:hover {
	background-color:blue;
	color:#FFFFFF;
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
	margin-top:5px;
	padding-top:5px;
	border:1px solid #666666;
	height:65px;
}
#diasSemana input {
	border:none;
	background-color:transparent;
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
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&recarga=<%=recarga%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mes%>-1;
	anyo=<%=el_anyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?mes="+mes+"&anyo="+anyo+"&thab=<%=thab%>&recarga=<%=recarga%>";
	document.f1.submit();
}

function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="<%=MiPag%>?mes="+imes+"&anyo="+ianyo+"&thab=<%=thab%>&recarga=<%=recarga%>";
	document.f1.submit();
}

function CambioHotel(lista){
	document.location="<%=MiPag%>?est="+lista.value+"&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>";
}
function CambioHabi(lista){
	document.location="<%=MiPag%>?thab="+lista.value+"&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>";
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
				document.getElementById('notas').innerHTML='Seleccionar la segunda fecha';
				//Guardo la primera marca
				SetCookie('desdef',eldia);
				SetCookie('lamarca','2');
				break;
		
			case 2: //segundo dia
				document.getElementById(eldia).className='marcado';
				document.getElementById('hastaf').value=eldia;
				queMarca=0 //pa la primera y desmarcar
				document.getElementById('notas').innerHTML='Poner los datos que quiera actualizar';
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
				document.getElementById('notas').innerHTML='Seleccionar la segunda fecha';
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
	txt="Cambios a realizar:\n";
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
	if (document.f1.cupo.value!='')
		txt=txt+"Cupo: "+document.f1.cupo.value+"\n";
	if (document.f1.minimos.value!='')
		txt=txt+"Estancia Mínima: "+document.f1.minimos.value+"\n";
	if (document.f1.release.value!='')
		txt=txt+"Release: "+document.f1.release.value+"\n";
	
	if (confirm(txt))
		document.f1.submit();
		
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">PRECIOS  -> <%=NHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name="f1" method="post" action="<%=MiPag%>?est=<%=est%>&thab=<%=thab%>&mes=<%=mes%>&anyo=<%=el_anyo%>&recarga=<%=recarga%>">
<input type="hidden" name="arrayFechas" value=""/>
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
	<td align='left'>Tipo Habitación:
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
</tr>
</table>
<div id='capaTabla'>
<table id='miTabla' align="center" width="100%" cellpadding="0" cellspacing="0" style="margin-top:3px;">
	<tr><td colspan="7" class="tituloTabla">
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
	<tr>
		<%for d=1 to 7%>
		<th class="colu_par" align="center" width="14%"><%=ucase1(diasLargos(d))%></th>
		<%next 'd%>
	</tr>
	<%
	regDia=0
	if hayCupos then
		for d=fini to ffin 'dias del mes
			for ds=1 to 7 'dias de la semana
				if ds=1 then response.write "<tr>"
				if weekday(d,vbmonday)=ds then 'dia de la semana
					'Poner datos del día
					if regDia<=ubound(RegCupos,2) then
						if RegCupos(CuDia,RegDia)=d then 'es fecha correcta de cupo
							response.write "<td align='left' id='" & right("0"&day(d),2) & "/" & right("0"&month(d),2) & "/" & year(d) & "' class='guena' onclick='javascript:marcar(this);'>"
							'response.write "<td align='left' id='" & right("0"&day(d),2) & "/" & right("0"&month(d),2) & "/" & year(d) & "' class='guena'>"
							response.write "<p align='center'><b>" & day(d) & "</b></p>"
							response.write "Precio: <b>" & formatnumber(RegCupos(CuPelas,regDia),2) & "</b><br/>"
							response.write "Est. Mínima: " & RegCupos(CuMinimos,regDia) & "&nbsp;&nbsp;&nbsp;"
							response.write "Release: " & paClng(RegCupos(CuRelease,regDia)) & "<br/>"
							if RegParon(PCupo,regDia)<1 then
								response.write "<span style='color:red'>Cupo: " & RegParon(PCupo,regDia) & "</span>&nbsp;&nbsp;&nbsp;"
							else
								response.write "Cupo: " & RegParon(PCupo,regDia) & "&nbsp;&nbsp;&nbsp;"
							end if
							response.write "Ocup.: " & paClng(RegParon(POcu,regDia)) & "<br/>"
							if (RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia)))<1 then
								response.write "<span style='color:red'>Libres: " & RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia)) & "</span>"
							else
								response.write "Libres: " & RegParon(PCupo,regDia)-paClng(RegParon(POcu,regDia))
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
	<div id='notas' align="center">Pulsar sobre el día para seleccionar fechas</div>
</div>
<div id='capaFin'>
	<div style="float:left; margin-top:3px;">&nbsp;Rango de fechas:</div>
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
			Precio <input type="text" id='precio' name="precio" maxlength="8" value="" style="width:50px;">
			&nbsp;&nbsp;&nbsp;Cupo <input type="text" id='cupo' name="cupo" maxlength="8" value="" style="width:30px;">
			&nbsp;&nbsp;&nbsp;Est. Mínima <input type="text" id='minimos' name="minimos" maxlength="8" value="" style="width:30px;">
			&nbsp;&nbsp;&nbsp;Release <input type="text" id='release' name="release" maxlength="8" value="" style="width:30px;">
			<p align="center">
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