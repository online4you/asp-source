<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
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
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

todos=request.QueryString("todos")
any=request.QueryString("any")
if any="" then any=anyo
any=clng(any)

'Buscar reservas del año (nº reservas)
cs="SELECT month(fechaReserva),COUNT(*) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas"
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY month(fechareserva)"
'response.write cs
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFecha=0
	MPelas=1
	hayestemes=true
	
	totalnreservas=0
	for r=0 to ubound(RegMes,2)
		totalnreservas=totalnreservas+RegMes(MPelas,r)
	next
end if
rs.close

'Buscar reservas del año (importes)
cs="SELECT month(fechaReserva),SUM(Importe) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY month(fechareserva)"
'response.write cs
hayestemesP=false
rs.open cs,base
if not rs.eof then
	RegMesP=rs.getrows
	MFechaP=0
	MPelasP=1
	hayestemesP=true
	totalIReservas=0
	for r=0 to ubound(RegMesP,2)
		totalIReservas=totalIReservas+RegMesP(MPelasP,r)
	next
end if
rs.close

if todos="-1" then
	titulo="(" & objIdioma.getTraduccionHTML("i_ctodosloshoteles") & ")"
else
	for h=0 to ubound(RegHoteles,2)
		if RegHoteles(HCodi,h)=est then
			titulo=ucase(RegHoteles(HNombre,h))
		end if
	next
end if

'Buscar reservas del año (media estancia)
cs="SELECT month(fechaReserva),AVG(NumDias) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY month(fechareserva)"
'response.write cs
hayestemesE=false
rs.open cs,base
if not rs.eof then
	RegMesE=rs.getrows
	MFechaE=0
	MPelasE=1
	hayestemesE=true
	
	totalEReservas=0
	for r=0 to ubound(RegMesE,2)
		totalEReservas=totalEReservas+RegMesE(MPelasE,r)
	next
	'media noches
	totalEReservas=totalEReservas/(ubound(RegMesE,2)+1)
	
end if
rs.close

'Buscar reservas del año (media importe)
cs="SELECT month(fechaReserva),AVG(importe) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY month(fechareserva)"
'response.write cs
hayestemesEu=false
rs.open cs,base
if not rs.eof then
	RegMesEu=rs.getrows
	MFechaEu=0
	MPelasEu=1
	hayestemesEu=true

	totalMReservas=0
	for r=0 to ubound(RegMesEu,2)
		totalMReservas=totalMReservas+RegMesEu(MPelasEu,r)
	next
	'media noches
	totalMReservas=totalMReservas/(ubound(RegMesEu,2)+1)

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
<script language="javascript" type="text/javascript" src="/fusion/FusionCharts.js"></script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right'> <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:window.location='<%=MiPag%>?todos=-1';"> 
                </td>
              </tr>
              <tr>
                <td align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_estadisticas")%></td>
              </tr>
            </table>
            <%
		if hayestemesP then
		'Generar XML del grafico
		elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccionHTML("i_importespormes") & "' xAxisName='" & ucase(objIdioma.getTraduccionHTML("i_totalimporteanyo")) & " " & any & ": " & formatnumber(totalIReservas,0) & " €' yAxisName='" & objIdioma.getTraduccionHTML("i_importe") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.'>"
		for m=1 to 12
			valor=0
			for r=0 to ubound(RegMesP,2)
				if RegMesP(MFechaP,r)=m then
					valor=quitarComa(redondear(RegMesP(MPelasP,r)))
					exit for
				end if
			next
			elxml=elxml & "<set name='" & ucase1(mid(nombremes(m),1,3)) & "' HoverText='" & ucase1(nombremes(m)) & "' value='" & valor & "' color='DF6C01' />"
		next 'los meses
		elxml=elxml & "</graph>"
		'response.write elxml
		%>
            <div id="PelasDiv" align="center" style="margin-top:20px;"></div>
            <script type="text/javascript">
		   var chart = new FusionCharts("fusion/FCF_Column3D.swf", "Importes", "650", "300");
		   chart.setDataXML("<%=elxml%>");		   
		   chart.render("PelasDiv");
		</script> 
            <%end if 'hay datos
		if hayestemes then
		'Generar XML del grafico
		elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccionHTML("i_confirmadaspormes") & "' xAxisName='" & ucase(objIdioma.getTraduccionHTML("i_reservasconfirmadasanyo")) & " " & any & ": " & totalNReservas & "' yAxisName='" & objIdioma.getTraduccionHTML("i_nreservas") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.'>"
		for m=1 to 12
			valor=0
			for r=0 to ubound(RegMes,2)
				if RegMes(MFecha,r)=m then
					valor=RegMes(MPelas,r)
					exit for
				end if
			next
			elxml=elxml & "<set name='" & ucase1(mid(nombremes(m),1,3)) & "' HoverText='" & ucase1(nombremes(m)) & "' value='" & valor & "' color='C77373' />"
		next 'los meses
		elxml=elxml & "</graph>"
		'response.write elxml
		%>
            <div id="ReservasDiv" align="center" style="margin-top:20px;"></div>
            <script type="text/javascript">
		   var chart = new FusionCharts("fusion/FCF_Column3D.swf", "Reservas", "650", "300");
		   chart.setDataXML("<%=elxml%>");		   
		   chart.render("ReservasDiv");
		</script> 
            <%end if 'hay datos

		if hayestemesE then
		'Generar XML del grafico
		elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccionHTML("i_nochespormes") & "' xAxisName='" & ucase(objIdioma.getTraduccionHTML("i_nochesporanyo")) & " " & any & ": " & formatNumber(totalEReservas,2) & " " & objIdioma.getTraduccionHTML("i_noches") & "' yAxisName='" & objIdioma.getTraduccionHTML("i_noches") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.'>"
		for m=1 to 12
			valor=0
			for r=0 to ubound(RegMesE,2)
				if RegMesE(MFechaE,r)=m then
					valor=quitarComa(redondear(RegMesE(MPelasE,r)))
					exit for
				end if
			next
			elxml=elxml & "<set name='" & ucase1(mid(nombremes(m),1,3)) & "' HoverText='" & ucase1(nombremes(m)) & "' value='" & valor & "' color='794BFA' />"
		next 'los meses
		elxml=elxml & "</graph>"
		'response.write elxml
		%>
            <div id="DiasDiv" align="center" style="margin-top:20px;"></div>
            <script type="text/javascript">
		   var chart = new FusionCharts("fusion/FCF_Column3D.swf", "Dias", "650", "300");
		   chart.setDataXML("<%=elxml%>");		   
		   chart.render("DiasDiv");
		</script> 
            <%end if 'hay datos

		if hayestemesEu then
		'Generar XML del grafico
		elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccionHTML("i_mediapormes") & "' xAxisName='" & ucase(objIdioma.getTraduccionHTML("i_mediaporanyo")) & " " & any & ": " & formatNumber(totalMReservas,2) & " €' yAxisName='" & objIdioma.getTraduccionHTML("i_importe") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.'>"
		for m=1 to 12
			valor=0
			for r=0 to ubound(RegMesEu,2)
				if RegMesEu(MFechaEu,r)=m then
					valor=quitarComa(redondear(RegMesEu(MPelasEu,r)))
					exit for
				end if
			next
			elxml=elxml & "<set name='" & ucase1(mid(nombremes(m),1,3)) & "' HoverText='" & ucase1(nombremes(m)) & "' value='" & valor & "' color='0B850B' />"
		next 'los meses
		elxml=elxml & "</graph>"
		'response.write elxml
		%>
            <div id="MediaDiv" align="center" style="margin-top:20px;"></div>
            <script type="text/javascript">
		   var chart = new FusionCharts("fusion/FCF_Column3D.swf", "Media", "650", "300");
		   chart.setDataXML("<%=elxml%>");		   
		   chart.render("MediaDiv");
		</script> 
            <%end if 'hay datos%>
          </td>
        </tr>
        <tr>
          <td height="20"></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
