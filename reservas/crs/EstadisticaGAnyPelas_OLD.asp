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
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
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
compara=paClng(request.QueryString("cp"))
if compara=0 then compara=any

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
	'response.write cs
end if
rs.close

if compara<>any then 'buscar los importes del otro año

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
	cs=cs & "AND YEAR(FechaReserva)=" & compara & " "
	cs=cs & "GROUP BY month(fechareserva)"
	'response.write cs
	hayestemesP_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesP_A=rs.getrows
		MFechaP_A=0
		MPelasP_A=1
		hayestemesP_A=true
		totalIReservas_A=0
		for r=0 to ubound(RegMesP_A,2)
			totalIReservas_A=totalIReservas_A+RegMesP_A(MPelasP_A,r)
		next
	end if
	rs.close



end if 'compara<>any

if todos="-1" then
	titulo="(" & objIdioma.getTraduccionHTML("i_ctodosloshoteles") & ")"
else
	for h=0 to ubound(RegHoteles,2)
		if RegHoteles(HCodi,h)=est then
			titulo=ucase(RegHoteles(HNombre,h))
		end if
	next
end if

set rs=nothing
base.close
set base=nothing

masquery="&todos=" & todos & "&cp=" & compara
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/fusion/FusionCharts.js"></script>
<script language="javascript" type="text/javascript">
function comparaD(cp){
	window.location="<%=MiPag%>?est=<%=est%>&todos=<%=todos%>&any=<%=any%>&cp="+cp.value;
}
</script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
#miFrame {
	border:1px solid #AAABA3;
	width:758px;
	height:510px;
}
</style>
</head>
<body>
<div id='miFrame'>
	<form name='f1' method="post">
	<table border="0" align='left' cellpadding="0" cellspacing="0" style="margin-top:10px">
	<tr>
		<td align="left" width="100%">
	
		<!--#include file="seleccionado.asp"-->
		
		<table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
		<tr><td align='right'>
			<input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:window.location='<%=MiPag%>?todos=-1&cp=<%=compara%>';">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Compara con año: 
			<select name='compara' onchange="Javascript:comparaD(this);">
			<%
			for aa=year(date)-4 to year(date)
				marca=""
				if compara=aa then marca=" selected"%>
				<option value="<%=aa%>"<%=marca%>><%=aa%></option>
			<%next%>
			</select>
		</td></tr>
		</table>
		<%
		losmeses="<categories>"
		for m=1 to 12
			losmeses=losmeses & "<category name='"& ucase1(mid(nombremes(m),1,3)) & "' HoverText='" & ucase1(nombremes(m)) & "'/>"
		next
		losmeses=losmeses & "</categories>"
		
		if hayestemesP then
			'Generar XML del grafico
			elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccionHTML("i_importespormes") & "' xAxisName='" & ucase(objIdioma.getTraduccionHTML("i_totalimporteanyo")) & " " & any & ": " & formatnumber(totalIReservas,0) & " €' yAxisName='" & objIdioma.getTraduccionHTML("i_importe") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2'>"
			elxml=elxml & losmeses
			'response.write elxml
			if hayestemesP_A then 'compara otro año
				elxml=elxml & "<dataset seriesname='" & objIdioma.getTraduccionHTML("i_anyo") & " " & compara & "' color='AC9FD6'>"
				for m=1 to 12
					valor=0
					for r=0 to ubound(RegMesP_A,2)
						if RegMesP_A(MFechaP_A,r)=m then
							valor=quitarComa(redondear(RegMesP_A(MPelasP_A,r)))
							exit for
						end if
					next
					elxml=elxml & "<set value='" & valor & "'/>"
				next 'los meses			
				elxml=elxml & "</dataset>"
			end if	'hayestemesP_A
			'Año actual
			elxml=elxml & "<dataset seriesname='" & objIdioma.getTraduccionHTML("i_anyo") & " " & any & "' color='DF6C01'>"
			for m=1 to 12
				valor=0
				for r=0 to ubound(RegMesP,2)
					if RegMesP(MFechaP,r)=m then
						valor=quitarComa(redondear(RegMesP(MPelasP,r)))
						exit for
					end if
				next
				elxml=elxml & "<set value='" & valor & "'/>"
			next 'los meses
			elxml=elxml & "</dataset>"
			elxml=elxml & "</graph>"
			'response.write elxml
			%>
			<div id="PelasDiv" align="center" style="margin-top:20px;"></div>
			<script type="text/javascript">
			   var chart = new FusionCharts("fusion/FCF_MSColumn3D.swf", "Importes", "740", "350");
			   chart.setDataXML("<%=elxml%>");		   
			   chart.render("PelasDiv");
			</script>
		
		<%end if 'hay datos%>
	
		</td>
	</tr>
	<tr><td height="20"></td></tr>
	</table>
	</form>
</div> <!-- iframePrincipal -->
</body>
</html>
