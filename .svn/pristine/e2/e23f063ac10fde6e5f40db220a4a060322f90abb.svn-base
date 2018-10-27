<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="includes/fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

'Variables post
idh=paClng(request.QueryString("idh"))
codhab=paClng(request.QueryString("codhab"))
mesini=paClng(request.QueryString("mesi"))
anyini=paClng(request.QueryString("anyi"))
if mesini=0 then 'poner por defecto la fecha del día
	mesini=month(date)
	anyini=year(date)
end if

'Habitaciones del hotel
dim RegHabis()
HaCodi=0
HaNombre=1
nhabi=-1

parametros="habitacionesHotel.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=" & lang

Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true

if objDom.Load(xmlURL & parametros) then
	For Each objItem in objDom.documentElement.SelectNodes("/data/habitacion")
		nhabi=nhabi+1
		redim preserve RegHabis(1,nhabi)
		RegHabis(HaCodi,nhabi)=paClng(objItem.SelectSingleNode("codhab").text)
		RegHabis(HaNombre,nhabi)=objItem.SelectSingleNode("nomhab").text
	next
	set objItem=nothing
end if 'load habis

if codhab=0 and nhabi<>-1 then codhab=RegHabis(HaCodi,0)
'Nombre hab
if nhabi>-1 then
for h=0 to ubound(RegHabis,2)
	if RegHabis(HaCodi,h)=codhab then
		nombreHabi=RegHabis(HaNombre,h)
		exit for
	end if
next
end if 'hayhabis
		
		
'calendario disponibilidad mes inicial
dim RegDias()
DDia=0
DDispo=1
redim RegDias(1,0)
fini=cdate("01/" & right("0"&mesini,2) & "/" & anyini)
for d=31 to 28 step -1
	if isdate(d & "/" & mesini & "/" & anyini) then
		ffin=cdate(d & "/" & mesini & "/" & anyini)
		exit for
	end if
next
parametros="calendario.asp?ide=" & IdEmpresa & "&codhab=" & codhab & "&fini=" & fini & "&ffin=" & ffin

if objDom.Load(xmlURL & parametros) then
	ndia=-1
	For Each objItem in objDom.documentElement.SelectNodes("/data/dia")
		ndia=ndia+1
		redim preserve RegDias(1,ndia)
		on error resume next
		RegDias(DDia,ndia)=objItem.SelectSingleNode("fecha").text
		if err.number<>0 then 'no hay datos
			ndia=-1
			on error goto 0
			exit for
		end if
		
		RegDias(DDispo,ndia)=paClng(objItem.SelectSingleNode("disponibles").text)
		if objItem.SelectSingleNode("estado").text="NV" then RegDias(DDispo,ndia)=0
		
	next
	set objItem=nothing
	on error goto 0
end if 'load hotel

mesfin=mesini+1
anyfin=anyini
if mesfin=13 then
	mesfin=1
	anyfin=anyini+1
end if

'calendario disponibilidad mes final
dim RegDiasF()
DDia=0
DDispo=1
redim RegDiasF(1,0)
fini=cdate("01/" & right("0"&mesfin,2) & "/" & anyfin)
for d=31 to 28 step -1
	if isdate(d & "/" & mesfin & "/" & anyfin) then
		ffin=cdate(d & "/" & mesfin & "/" & anyfin)
		exit for
	end if
next
parametros="calendario.asp?ide=" & idEmpresa & "&codhab=" & codhab & "&fini=" & fini & "&ffin=" & ffin
'response.write parametros
if objDom.Load(xmlURL & parametros) then
	ndiaF=-1
	For Each objItem in objDom.documentElement.SelectNodes("/data/dia")
		ndiaF=ndiaF+1
		redim preserve RegDiasF(1,ndiaF)
		on error resume next
		RegDiasF(DDia,ndiaF)=objItem.SelectSingleNode("fecha").text
		if err.number<>0 then 'no hay datos
			ndiaf=-1
			on error goto 0
			exit for
		end if
		RegDiasF(DDispo,ndiaF)=paClng(objItem.SelectSingleNode("disponibles").text)
		if objItem.SelectSingleNode("estado").text="NV" then RegDiasF(DDispo,ndiaF)=0
	next
	set objItem=nothing
end if 'load hotel

set objDom=nothing

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Calendario</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=elCharSet%>" />
<link href="css/kubik.css" rel="stylesheet" type="text/css" />
<link href="css/calendario.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/funciones.js"></script>
<script language="javascript" type="text/javascript" src="js/mootools.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.$('verCalendario').style.display='none';
}

function iM() { //mes palante
	mes=<%=mesini%>+1;
	anyo=<%=anyini%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="<%=MiPag%>?ide=<%=idEmpresa%>&lang=<%=lang%>&mesi="+mes+"&anyi="+anyo+"&idh=<%=idh%>&codhab=<%=codhab%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mesIni%>-1;
	anyo=<%=anyini%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?ide=<%=idEmpresa%>&lang=<%=lang%>&mesi="+mes+"&anyi="+anyo+"&idh=<%=idh%>&codhab=<%=codhab%>";
	document.f1.submit();
}

function cambiaHabi(esa){
	document.f1.action="<%=MiPag%>?ide=<%=idEmpresa%>&lang=<%=lang%>&mesi=<%=mesini%>&anyi=<%=anyini%>&idh=<%=idh%>&codhab="+esa;
	document.f1.submit();
}
</script>
<style>
a.botonGris75 {
	position:absolute;
	top:5px;
	left:440px;
}
a.botonGris75:hover {
	text-decoration:none;
}
span.titulo_lista {
	text-align:left;
	line-height:17px;
	height:18px;
}
</style>
</head>

<body>
<form name="f1" method="post" action="">
<input name="elForm" type="hidden" value="<%=elForm%>"/>
<input name="<%=valor%>" type="hidden" value="<%=fini%>"/>
<input name="Valor" type="hidden" value="<%=valor%>"/>
<div id='clnd' class='div-calendario' style="width:480px">
<table width='100%' class='table-calendario' align="center" cellpadding="0">
	<tr>
	<td colspan="2">
		<table width='100%' border='0'>
			<tr><td class='title-style' align="left">
			<div style="float:left; margin-left:20px;" id='listaHabitaciones'>
				<span><%=objIdioma.getTraduccionHTML("i_tipohab")%>:&nbsp;</span>
                <div class='capa_lista'>
                    <span id='selectMarca' class='titulo_lista'><%=nombreHabi%></span>
                    <div id='listaHabis' class="lista">
                    <%if nhabi<>-1 then
                    for h=0 to ubound(RegHabis,2)%>
                        <a href="javascript:cambiaHabi(<%=RegHabis(HaCodi,h)%>);"><%=ucase1(lcase(RegHabis(HaNombre,h)))%></a>
                    <%next
                    end if%>
                    </div>
                </div>
            </div>
			</td>
			</tr>
			<tr><td class='title-style' align="left">
				<div id='spanLeft' class='title-style' onclick='javascript:dM()'>&laquo;--</div>
				<div id='spanRight' class='title-style' onclick='iM()' style="float:right">--&raquo;</div>
			</td>
			</tr>
		</table>
		<a href='javascript:cerrar();' class="botonGris75"><%=objIdioma.getTraduccionHTML("i_cerrar")%></a>
	</td>
	</tr>
	<tr>
	<td class='body-style' valign="top">
	<div class='content'>
		<table border=0 class='body-style' width="100%">
		<tr><td class='title-name-day' align='center' colspan="7" style="background-color:#e5be24"><%=ucase(nombreMes(mesini)) & " " & anyini%></td></tr>
		<tr>
		<%for d=1 to 7%>
			<td width='27' class='title-name-day' align='center' style="background-color:#e5be24"><%=diasCortos(d)%></td>
		<%next%>
		</tr>
		<tr>
		<%colu=1
		for d=1 to 31
			if not isdate(d & "/" & mesini & "/" & anyini) then exit for
			dia=cdate(d & "/" & mesini & "/" & anyini)
			do while weekday(dia,2)<>colu%>
				<td>&nbsp;</td>
				<%colu=colu+1
				if colu>7 then colu=1
			loop
			if ndia=-1 then 'no hay resultados%>
				<td align="center">
					<span style="color:#999999"><%=d%></span>
				</td>
				<%colu=colu+1
				if colu>7 then
					response.write "</tr><tr>"
					colu=1
				end if

			else 'hay resultados
				for dd=d-1 to ubound(RegDias,2)%>
					<td align="center"<%if RegDias(DDispo,dd)=0 then response.write " style='color:red'" else response.write " style='color:#055b34'"%>><%=dd+1%></td>
					<%colu=colu+1
					if colu>7 then
						response.write "</tr><tr>"
						colu=1
					end if
				next 'regdias
				ndia=-1
				d=dd
			end if 'ndia
		next%>
		</tr>
		
		</table>
	</div></td>
	<td class='body-style' valign="top">
		<div class='content'>
		<table border=0 class='body-style' width="100%">
		<tr><td class='title-name-day' align='center' colspan="7" style="background-color:#e5be24"><%=ucase(nombreMes(mesfin)) & " " & anyfin%></td></tr>
		<tr>
		<%for d=1 to 7%>
			<td width='27' class='title-name-day' align='center' style="background-color:#e5be24"><%=diasCortos(d)%></td>
		<%next%>
		</tr>
		<tr>
		<%colu=1
		for d=1 to 31
			if not isdate(d & "/" & mesfin & "/" & anyfin) then exit for
			dia=cdate(d & "/" & mesfin & "/" & anyfin)
			do while weekday(dia,2)<>colu%>
				<td>&nbsp;</td>
				<%colu=colu+1
				if colu>7 then colu=1
			loop
			if ndiaF=-1 then 'no hay resultados%>
				<td align="center">
					<span style="color:#999999"><%=d%></span>
				</td>
				<%colu=colu+1
				if colu>7 then
					response.write "</tr><tr>"
					colu=1
				end if

			else 'hay resultados
				for dd=d-1 to ubound(RegDiasF,2)%>
					<td align="center"<%if RegDiasF(DDispo,dd)=0 then response.write " style='color:red'" else response.write " style='color:#055b34'"%>><%=dd+1%></td>
					<%colu=colu+1
					if colu>7 then
						response.write "</tr><tr>"
						colu=1
					end if
				next 'regdias
				ndiaF=-1 '
				d=dd
			end if 'ndia
		next%>
		</tr>
		
		</table>
	</div>
	</td>
	</tr>
	<tr><td colspan="2" align="left" bgcolor="#FFFFFF" style="padding-left:5px;">
		<p style="color:#055b34">X - <%=objIdioma.getTraduccionHTML("i_disponibles")%></p>
		<p style="color:red">X - <%=objIdioma.getTraduccionHTML("i_nodisponibles")%></p>
		<p style="color:#999999">X - <%=objIdioma.getTraduccionHTML("i_hotelcerrado")%></p>
	</td></tr>
</table>
</div>
</form>
<%set objIdioma=nothing%>
<script language="javascript" type="text/javascript">
	window.addEvent('domready',cargaInicio);
	
	function quitaLista(esa){
		$(esa).style.display='none';
	}
	
	function cargaInicio() {
		var idReloj;
		var mis_titulo_listas=$$('div.capa_lista');
		
		for(x=0;x<mis_titulo_listas.length;x++){
			mis_titulo_listas[x].addEvent("click",function(){
				var lista=$$("#"+this.id+" div.lista");
				for (i=0;i<lista.length;i++) {
					lista[i].style.display='block';
					//esto es por culpa del IE
					ancho=lista[i].offsetWidth-4;
					var enlaces=$$("#"+lista[i].id+" a");
					for (x=0;x<enlaces.length;x++) 
						enlaces[x].style.width=ancho+"px";
				}
	
			});
			mis_titulo_listas[x].addEvent("mouseover",function(){
				clearTimeout(idReloj); //detiene el reloj si hay un mouseout
			});
			mis_titulo_listas[x].addEvent("mouseout",function(){
				var lista=$$("#"+this.id+" div.lista");
				for (i=0;i<lista.length;i++)
					idReloj=setTimeout("quitaLista('"+lista[i].id+"')",200);
			});
		
		} //for
	
		//Ajustar el alto y ancho del iframe que lo carga
		alto=$('clnd').offsetHeight;
		ancho=$('clnd').offsetWidth;
		parent.$('verCalendario').style.height=alto+"px";
		parent.$('verCalendario').style.width=ancho+"px";

	} //cargaInicio

</script>
</body>
</html>
