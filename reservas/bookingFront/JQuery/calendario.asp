<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="includes/fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Calendario</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=elCharSet%>" />
<link href="css/kubik.css" rel="stylesheet" type="text/css" />
<link href="css/calendario.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/funciones.js"></script>
<script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.$('#verCalendario').css('display','none');
}

function iM() { //mes palante
	mes=<%=iniMes%>+1;
	anyo=<%=iniAnyo%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="calendario.asp?ide=<%=idempresa%>&lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=iniMes%>-1;
	anyo=<%=iniAnyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="calendario.asp?ide=<%=idempresa%>&lang=<%=lang%>&mes="+mes+"&anyo="+anyo;
	document.f1.submit();
}

function eseDia(esooo){
	//Comprobar que el día final no sea menor al dia inicial
	<%if valor="ffin" then%>
		if (!verificaFecha(esooo)){
			alert('<%=objIdioma.getTraduccion("i_errorfechasalida")%>');
			return;
		}
	<%end if%>
	parent.document.<%=elForm%>.<%=valor%>.value=esooo;
	<%if valor="fini" then%>
	parent.document.<%=elForm%>.ffin.value=esooo;
	<%end if%>
	<%if valor="fechai" then%>
	parent.document.<%=elForm%>.fechaf.value=esooo;
	<%end if%>
	<%if elForm="f1" then%>
		parent.ponNoches(); //cambia el nº de noches en el paso2
	<%end if%>
	<%if elForm="fb" then%>
		parent.ponFechas(); //pone las fechas en el enlace
	<%end if%>
	cerrar();
}
function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="calendario.asp?ide=<%=idempresa%>&lang=<%=lang%>&mes="+imes+"&anyo="+ianyo;
	document.f1.submit();
}

function verificaFecha(esa) {
	//comprueba si la fecha final es menor a la inicial
	fi=parent.document.<%=elForm%>.fini.value;
	//ff=top.document.<%=elForm%>.ffin.value;
	da2=new Date(esa.substring(6,10),esa.substring(3,5)-1,esa.substring(0,2));
    da1=new Date(fi.substring(6,10),fi.substring(3,5)-1,fi.substring(0,2));
	if (da2<=da1)
		return false;
	return true;
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
			<div id='caption' class='title-style'>
				<div id='spanLeft' class='title-style' onclick='javascript:dM()'>&laquo;</div>
				<div id='spanCentro' class='capa_lista title-style'>
					<span id='selectMarca' class='titulo_lista'><%=nombreMes(iniMes) & " " & iniAnyo%></span>
                    <div id='listaMeses' class="lista">
                    <%for mm=0 to 18
                        fechita=dateAdd("m",mm,date)%>
                        <a href="javascript:saltaMes('<%=month(fechita) & "-" & year(fechita)%>');"><%=nombreMes(month(fechita)) & " " & year(fechita)%></a>
                    <%next%>
                    </div>
				</div>
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
<%set objIdioma=nothing%>
</form>
<script language="javascript" type="text/javascript">

	function cargaInicio() {
		montarSelect();
	
		//Ajustar el alto y ancho del iframe que lo carga
		alto=$('#clnd').height();
		ancho=$('#clnd').width();
		parent.$('#verCalendario').css("height",alto+"px");
		parent.$('#verCalendario').css("width",ancho+"px");

	} //cargaInicio

	$(document).ready(cargaInicio);

</script>
</body>
</html>
