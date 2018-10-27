<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

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

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

rm=paClng(request.QueryString("rm")) 'rango meses
if rm=0 then rm=paClng(objCookies.getCookie("rangomeses")) 'valor guardado
if rm=0 then rm=6 'semestral por defecto

mes=paClng(request.QueryString("mes"))
if mes=0 then mes=month(date)
el_anyo=paClng(request.QueryString("anyo"))
if el_anyo=0 then el_anyo=year(date)

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

masquery="&mes=" & mes & "&anyo=" & el_anyo & "&rm=" & rm

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
	'Cupos y ocupadas	
	cs="SELECT Dia,Cupo,Confirmadas,CodigoHab,Estado "
	cs=cs & "FROM "
	cs=cs & " (SELECT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM jos_crs_Cupos Cupos LEFT OUTER JOIN "
	cs=cs & " (SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM jos_crs_TipoReserva TipoReserva INNER JOIN jos_crs_Reservas Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0 AND Anulada=0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal) Confirmadas "
	cs=cs & " ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia) Disponibles "
	cs=cs & "WHERE CodigoEsta=" & est
	cs=cs & " AND (Dia BETWEEN " & FechaMySQL(laminima) & " AND " & FechaMySQL(lamaxima)
	cs=cs & ") ORDER BY Dia"
	rs.Open cs, base
	haydispo=false
	if not rs.eof then
		RegDispo=rs.GetRows
		DisDia=0
		DisCupo=1
		DisOcu=2
		DisHabi=3
		DisEstado=4
		haydispo=true
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
#capaTabla {
	/*height:430px;
	overflow-x:hidden;
	overflow-y:scroll;*/
	overflow:auto;
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
	width:19px;
}

#losmeses td.onrequest {
	cursor:pointer;
	color:blue;
}
#losmeses td.noventa {
	cursor:pointer;
	color:red;
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
#losmeses td {
	border:none;
	border-right:1px solid #666666;
	border-bottom:1px solid #666666;
	padding:0px;
	margin:0px;
}

div.tituloTabla {
	height:20px;
	text-transform:none;
}
div.tituloTabla a {
	color:white;
	text-decoration:none;
}

</style>

<script language="javascript" type="text/javascript">
function iM() { //mes palante
	mes=<%=mes%>+1;
	anyo=<%=el_anyo%>;
	if (mes>12){
		anyo=anyo+1;
		mes=1;
	}
	document.f1.action="<%=MiPag%>?est=<%=est%>&mes="+mes+"&anyo="+anyo+"&rm=<%=rm%>";
	document.f1.submit();
}
function dM() { //mes patras
	mes=<%=mes%>-1;
	anyo=<%=el_anyo%>;
	if (mes==0){
		anyo=anyo-1;
		mes=12;
	}
	document.f1.action="<%=MiPag%>?est=<%=est%>&mes="+mes+"&anyo="+anyo+"&rm=<%=rm%>";
	document.f1.submit();
}

function saltaMes(esa){
	imes=esa.split("-")[0];
	ianyo=esa.split("-")[1];
	document.f1.action="<%=MiPag%>?est=<%=est%>&mes="+imes+"&anyo="+ianyo+"&rm=<%=rm%>";
	document.f1.submit();
}
function cambiaFiltro() {
	cualorango=document.f1.rangom.value;
	//Guardo como cookie
	top.document.getElementById('paCookies').src="/includes/grabaCookie.asp?valor="+cualorango+"&eti=rangomeses";
	url="<%=MiPag%>?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&rm="+cualorango;
	window.location=url;
}

function cargaDispo(esemes,eseanyo,esahabi){
	top.creaFlotante("verMesPrecios.asp?est=<%=est%>&lang=<%=lang%>&mes="+esemes+"&anyo="+eseanyo+"&thab="+esahabi,1000,600,10,0);
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <table border="0" align='left' cellpadding="0" cellspacing="0">
      <tr> 
        <td align="left" width="765"> <!--#include file="seleccionado.asp"--> <form name="f1" method="post" action="<%=MiPag%>?est=<%=est%>&mes=<%=mes%>&anyo=<%=el_anyo%>&rm=<%=rm%>">
            <div class="tituloTabla"> 
              <div style="float:left; width:250px;"><b> 
                <%=ucase(objIdioma.getTraduccionHTML("i_informedispo"))%>
                </b></div>
              <div style="float:left"> <a href='javascript:dM()'>&laquo;&nbsp; 
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
              <div style="float:right; margin-right:5px;"> 
                <%=objIdioma.getTraduccionHTML("i_rangomeses")%>
                : 
                <select name="rangom" onChange="javascript:cambiaFiltro();">
                  <option value="1"<%if rm=1 then response.write " selected"%>> 
                  <%=objIdioma.getTraduccionHTML("i_mensual")%>
                  </option>
                  <option value="3"<%if rm=3 then response.write " selected"%>> 
                  <%=objIdioma.getTraduccionHTML("i_trimestral")%>
                  </option>
                  <option value="6"<%if rm=6 then response.write " selected"%>> 
                  <%=objIdioma.getTraduccionHTML("i_semestral")%>
                  </option>
                  <option value="12"<%if rm=12 then response.write " selected"%>> 
                  <%=objIdioma.getTraduccionHTML("i_anual")%>
                  </option>
                </select>
              </div>
            </div>
            <div id='capaTabla'> 
              <%if haydispo then 'hay datos%>
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
                <tr> 
                  <td colspan="33" align="center" style="border:none"><b> 
                    <%=ucase(nombreMes(elmes)) & " " & mianyo%>
                    </b></td>
                </tr>
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
							for hh=0 to ubound(RegDispo,2)
								if RegDispo(DisDia,hh)=cdate(midia) AND RegDispo(DisHabi,hh)=RegHabis(HCodi,h) then 'este es el día
									haydia=true
									valor=RegDispo(DisCupo,hh)-PaClng(RegDispo(DisOcu,hh))
									if valor<=0 then 
										'valor=0
										fondillo=colorEstado(0) 'noventa
									end if
									exit for
								end if
							next 'hh
							if haydia then
								response.write "<td align='center'" & fondillo & colorEstado(RegDispo(DisEstado,hh)) & " onclick='javascript:cargaDispo(" & elmes & "," & year(midia) & "," & RegDispo(DisHabi,hh) & ");' class='celdilla'>" & valor & "</td>" & vbcrlf
							else
								response.write "<td align='center'" & fondillo & " style='width:19px'> </td>" & vbcrlf
							end if
						else
							response.write "<td></td>" & vbcrlf
						end if
						if d=31 then response.write "<td width='10' style='border:none'></td></tr>"
					next 'dias

				next 'regDispo
				end if 'hayDispo%>
                <tr> 
                  <td colspan="33" height="10" style="border:none"></td>
                </tr>
                <%next 'suma mes%>
              </table>
              <%else 'no hay datos
			response.write objIdioma.getTraduccionHTML("i_nodatosfechas") 
		end if 'haylista%>
            </div>
          </form></td>
      </tr>
    </table>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
