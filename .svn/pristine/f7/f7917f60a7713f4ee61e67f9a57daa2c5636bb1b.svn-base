<%
lang=request.QueryString("lang")
if lang="" then lang="es"


'Para poner la fecha en cada idioma
lcid_es=3082
lcid_en=1033
lcid_de=1031
lcid_ca=1027
lcid_fr=1036
lcid_it=1040

select case lang
	case "es"
		session.LCID=lcid_es
		i_cerrar="Cerrar"
	case "en"
		session.LCID=lcid_en
		i_cerrar="Close"
	case "de"
		session.LCID=lcid_de
		i_cerrar="Schliessen"
	case "ca"
		session.LCID=lcid_ca
		i_cerrar="Tancar"
	case "fr"
		session.LCID=lcid_fr
		i_cerrar="Fin"
	case "it"
		session.LCID=lcid_it
		i_cerrar="Fine"
end select

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
session.LCID=lcid_es 'Sesion en formato español

'Nombre del form

if request.Form="" then 'cambiando de mes
	elform=request.QueryString("elForm") 'nombre del formulario
	valor=request.QueryString("valor") 'input que se actualiza
	fini=request.QueryString(valor) 'el valor ya seleccionado
	iniMes=month(fini)
	iniAnyo=year(fini)
else 'cambia el mes
	elform=request.form("elForm")
	valor=request.form("valor") 'input que se actualiza
	fini=request.form(valor) 'el valor ya seleccionado
	iniMes=request.QueryString("mes")
	iniAnyo=request.QueryString("anyo")
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Calendario</title>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
<meta name="copyright" content="Planeta Web" />
<meta name="author" content="www.planeta-web.com" />
<meta name="language" content="<%=lang%>" />
<link href="select.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body,p,form { margin:0px }

#caption {
	clear:both;
	width:180px;
	height:22px;
	overflow:hidden;
}

#elmes {
	border:1px solid #333333;
	width:130px;
	height:18px;
	text-decoration:none;
}
#spanLeft {
	float:left;
	width:25px;
	font-size:18px;
	text-align:center;
	cursor:pointer;
	line-height:18px;
	
}
#spanCentro {
	float:left;
	width:130px;
	text-align:center;
	line-height:18px;
	padding-top:2px;
	overflow:hidden;
	/*margin-left:5px;*/
}
#spanRight {
	float:left;
	width:25px;
	font-size:18px;
	text-align:center;
	cursor:pointer;
	line-height:18px;
	/*margin-left:5px;*/
}

#clnd {
	width:230px;
	overflow:visible;
	margin:0px;
	padding:0px;
}

.div-calendario {
	background-color: #EDECD7;
}
.table-calendario {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	/*border:1px solid #ACB702;*/
	font-size: 10px;
}

.title-style {
	font-family:Arial, Helvetica, sans-serif;
	font-size:11px;
	color: #000000;
}

.dropdown-style-normal {
	background-color: #339900;
	color: #ffffff;
}

.title-background-style {
	background-color: #d2d2d2;
}

.title-control-normal-style {
	border:0em solid transparent;
	cursor: pointer;
	width: 80px;
	color: #FF0000;
	font-size: 11px;
	font-weight: bold;
}

.title-control-select-style {
	border:0em solid transparent;
	cursor: pointer;
}

.dropdown-style {
font-family: arial;
font-size: 11px;
border:1px solid #001F5A;
background-color: #339900;
cursor: pointer;
color: #ffffff;
}

.dropdown-select-style {
background-color: #267700;
color: #cccccc;
}

.selected-day-style {
border:0px solid;
background-color: red;
color: white;
font-weight: bold;
}

.dropdown-normal-style {
background-color: transparent;
}

.body-style {
font-family: verdana;
font-size: 11px;
background-color: #FFFFFF;
}

.title-name-day {
background-color: #FFFFFF;
font-family: verdana;
font-size: 10px;
color: black;
font-weight: bold;
}

.end-of-weekday-style {
color: black;
text-decoration: none;
}

.current-day-style {
font-weight: bold;
text-decoration: none;
}

.normal-day-style {
color: black;
text-decoration: none;
}
.normal-day-style:hover {
color: green;
text-decoration: none;
}

.not-selected-day-style {
border:0px solid;
background-color: #FFFFFF;
text-decoration: line-through;
color: #CFCFCF;
}

.holiday-style {
background-color: silver;
color: silver;
}

.today-style {
color: #ffffff;
background-color: #339900;
text-align: center;
text-decoration: none;
}

.weeknumber-div-style {
background-color: #d0d0d0;
color: #ffffff;
}
a.botonGris75{color:#000000;}
a:hover.botonGris75{color:#000000;}
-->
</style>
<script language="javascript" type="text/javascript" src="funciones.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	encogeCapa(top.document.getElementById('verCalendario'));
	top.document.getElementById('verCalendario').style.visibility='hidden';
}

function iM() { //mes palante
	mes=<%=iniMes%>+1;
	anyo=<%=iniAnyo%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="calendario_SMichel.asp?lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=iniMes%>-1;
	anyo=<%=iniAnyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="calendario_SMichel.asp?lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}

function eseDia(esooo){
	top.document.<%=elForm%>.<%=valor%>.value=esooo;
	<%if valor="fini" then%>
	top.document.<%=elForm%>.ffin.value=esooo;
	<%end if%>
	//top.ponSelec(); //cambia la fecha del select
	cerrar();
}
function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="calendario_SMichel.asp?lang=<%=lang%>&mes="+imes+"&anyo="+ianyo;
	document.f1.submit();
}
</script>

</head>

<body>
<form name="f1" method="post" action="">
<input name="elForm" type="hidden" value="<%=elForm%>"/>
<input name="<%=valor%>" type="hidden" value="<%=fini%>"/>
<input name="Valor" type="hidden" value="<%=valor%>"/>
<div id='clnd' class='div-calendario'>
<table width='100%' class='table-calendario' align="center" cellpadding="0">
	<tr>
	<td>
		<table width='100%' border='0'>
			<tr><td class='title-style' align="left">
			<div id='caption' class='title-style' onmousedown="javascript:marcaCapa(top.document.getElementById('verCalendario'))" onmouseup="javascript:liberaCapa();">
				<div id='spanLeft' class='title-style' onclick='javascript:dM()'>&laquo;</div>
				<div id='spanCentro' class='title-style'>
					<div id='selectMarca' onClick="javascript:verLista('lista');" onmouseOut="javascript:quitaLista();"><%=nombreMes(iniMes) & " " & iniAnyo%></div>
						<ul id='lista'>
						<%for mm=0 to 12
							fechita=dateAdd("m",mm,date)%>
							<li onmouseOver="javascript:verLista('lista');" onmouseOut="javascript:quitaLista();" onClick="javascript:saltaMes('<%=month(fechita) & "-" & year(fechita)%>');"><%=nombreMes(month(fechita)) & " " & year(fechita)%></li>
						<%next%>
						</ul>
				</div>
				<div id='spanRight' class='title-style' onclick='iM()'>&raquo;</div>
			</div></td>
			<td align='right' class='title-style'>
				<a href='javascript:cerrar();' class="botonGris75"><%=i_cerrar%></a>
			</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td class='body-style'>
	<div id='content'>
		<table border=0 class='body-style'>
		<tr>
		<%for d=1 to 7%>
			<td width='27' class='title-name-day' align='center'><%=diasCortos(d)%></td>
		<%next%>
		</tr>
		<tr>
		<%colu=1
		for d=1 to 31
			if not isdate(d & "/" & iniMes & "/" & iniAnyo) then exit for
			dia=cdate(d & "/" & iniMes & "/" & iniAnyo)
			do while weekday(dia,2)<>colu%>
				<td>&nbsp;</td>
				<%colu=colu+1
				if colu>7 then colu=1
			loop%>
			<td align="center">
				<%clase="normal-day-style"
				if dia=cdate(fini) then clase="selected-day-style" 'seleccionado
				if dia<date then clase="not-selected-day-style" 'dias anteriores a hoy
				if dia>=date then%>
					<a href="javascript:eseDia('<%=dia%>');" class="<%=clase%>"><%=d%></a>
				<%else%>
					<span class="<%=clase%>"><%=d%></span>
				<%end if%>
			</td>
			<%colu=colu+1
			if colu>7 then
				response.write "</tr><tr>"
				colu=1
			end if
		next%>
		</tr>
		
		</table>
	</div></td></tr>
</table>
</div>
</form>
<script language="javascript" type="text/javascript">
	//Ajustar el alto y ancho del iframe que lo carga
	alto=document.getElementById('clnd').offsetHeight;
	ancho=document.getElementById('clnd').offsetWidth;
	top.document.getElementById('verCalendario').style.height=alto+"px";
	top.document.getElementById('verCalendario').style.width=ancho+"px";
</script>
</body>
</html>
