<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

'Nombre del form

if request.Form="" then 'cambiando de mes
	elform=request.QueryString("elForm") 'nombre del formulario
	laCapa=request.QueryString("capa") 'nombre del iframe
	valor=request.QueryString("valor") 'input que se actualiza
	fini=request.QueryString(valor) 'el valor ya seleccionado
	iniMes=month(fini)
	iniAnyo=year(fini)
else 'cambia el mes
	elform=request.form("elForm")
	laCapa=request.form("capa") 'nombre del iframe
	valor=request.form("valor") 'input que se actualiza
	fini=request.form(valor) 'el valor ya seleccionado
	iniMes=request.QueryString("mes")
	iniAnyo=request.QueryString("anyo")
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
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
	width:auto;
	height:auto;
	overflow:hidden;
	display:block;
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
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}

function iM() { //mes palante
	mes=<%=iniMes%>+1;
	anyo=<%=iniAnyo%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="calendario_Meses.asp?lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=iniMes%>-1;
	anyo=<%=iniAnyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="calendario_Meses.asp?lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}

function eseDia(esooo){
	top.<%=laCapa%>.document.<%=elForm%>.<%=valor%>.value=esooo;
	cerrar();
}
function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="calendario_Meses.asp?lang=<%=lang%>&mes="+imes+"&anyo="+ianyo;
	document.f1.submit();
}

if (!es_IE) document.addEventListener("mousemove", posicRatonXY, true);
document.onmousemove = posicRatonXY;
var posicX = 0;
var posicY = 0;
var miX = 0;
var miY = 0;
function posicRatonXY(e) {
	scrolTop=0;
	scrolLeft=0;
	if (es_IE) { 
		if (document.documentElement && document.documentElement.scrollTop){
		  // Explorer 6 Strict
		  scrolTop = document.documentElement.scrollTop;
		  scrolLeft = document.documentElement.scrollLeft;
		} else if (document.body){
		  // all other Explorers
		  scrolTop = document.body.scrollTop;
		  scrolLeft = document.body.scrollLeft;
		}
		miX = window.event.clientX + scrolLeft;
		miY = window.event.clientY + scrolTop;
		posicX = window.event.screenX;
		posicY = window.event.screenY;
	} else { 
		miX = e.pageX;
		miY = e.pageY;
		posicX = e.screenX;
		posicY = e.screenY;
	}
} 

window.addEvent('domready',cargaLista);
</script>

</head>
<body>
<form name="f1" method="post" action="">
<input name="elForm" type="hidden" value="<%=elForm%>"/>
<input name="capa" type="hidden" value="<%=laCapa%>"/>
<input name="<%=valor%>" type="hidden" value="<%=fini%>"/>
<input name="Valor" type="hidden" value="<%=valor%>"/>
<div id='clnd' class='div-calendario'>
<table width='100%' class='table-calendario' align="center" cellpadding="0">
	<tr>
	<td>
		<table width='100%' border='0'>
			<tr><td class='title-style' align="left">
			<div id='caption' class='title-style'>
				<div id='spanLeft' class='title-style' onclick='javascript:dM()'>&laquo;</div>
				<div id='spanCentro' class='title-style'>
                	<div id='capa_lista1' class='capa_lista' style="width:126px;">
                        <span class='titulo_lista' id='ellang_select'>
						<%=nombreMes(iniMes) & " " & iniAnyo%></span>
                        <ul id='lista1' class='lista' style="width:126px;">
						<%
                        for aa=year(date) to year(date)+1
                            for mm=1 to 12%>
                            <li style="width:100px;" onClick="javascript:saltaMes('<%=mm & "-" & aa%>');"><%=nombreMes(mm) & " " & aa%></li>
                            <%next 'mes
                        next 'año%>
                        </ul>
                    </div> <!-- capaLista -->
				</div> <!--spanCentro-->
				<div id='spanRight' class='title-style' onclick='iM()'>&raquo;</div>
			</div></td>
			<td align='right' class='title-style'>
				<a href='javascript:cerrar();' class="botonGris75"><%=objIdioma.getTraduccionHTML("i_cerrar")%></a>
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
				if dia=cdate(fini) then clase="selected-day-style" 'seleccionado%>
				<a href="javascript:eseDia('<%=dia%>');" class="<%=clase%>"><%=d%></a>
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
	alto=document.body.offsetHeight;
	top.document.getElementById(self.name).style.height=(alto)+"px";
</script>
</body>
</html>
