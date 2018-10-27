<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="includes/conversorMoneda.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma segun variable lang

idh=paClng(request.QueryString("est"))
laspelas=0
fr=request.QueryString("fr")
th=request.QueryString("th")
tr=request.QueryString("tr")
fini=request.QueryString("fini")
ffin=request.QueryString("ffin")
adultos=paClng(request.QueryString("ad"))
ninos1=paClng(request.QueryString("ni1"))
ninos2=paClng(request.QueryString("ni2"))
noches=cdate(ffin)-cdate(fini)

parametros="precioHabitacion.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=es&fini=" & fini & "&ffin=" & ffin
parametros=parametros & "&codhab=" & th & "&ad=" & adultos & "&ni1=" & ninos1
parametros=parametros & "&ni2=" & ninos2 & "&codsup=" & tr
response.write xmlURL & parametros

Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
if objDom.Load(xmlURL & parametros) then

	For Each objItem in objDom.documentElement.SelectNodes("/data")
		monedaHotel=objItem.SelectSingleNode("moneda").text
		total=objItem.SelectSingleNode("totalbruto").text
		if isnumeric(total) then
			laspelas=cdbl(total)
		end if
		estado=objItem.SelectSingleNode("estadohabitacion").text
		release=paClng(objItem.SelectSingleNode("release").text)
		diasminimos=paClng(objItem.SelectSingleNode("diasminimos").text)
		'mirar oferta
		on error resume next
		For Each ojete in objDom.documentElement.SelectNodes("/data/oferta")
			totalOfer=ojete.SelectSingleNode("totaloferta").text
			if err.number=0 then
				if isnumeric(totalOfer) then
					laspelas=laspelas-cdbl(totalOfer)
				end if
			end if
		next 'las ofertas
		on error goto 0
	next 'each


end if	

Set objDom = Nothing
Set objItem = Nothing

elCambio=1
if monedaHotel<>coin then elCambio=CambioGoogle(monedaHotel,coin)

if laspelas=0 and diasMinimos>noches then
	textovisible=objIdioma.getTraduccionHTML("i_diasminimos") & " " & diasMinimos
elseif release<>0 then 
	textovisible=objIdioma.getTraduccionHTML("i_conrelease") & " " & (date+release)
	laspelas=0
elseif estado="NV" or laspelas=0 then
	textovisible=objIdioma.getTraduccionHTML("i_nodisponibles")
	'poner calendario disponibilidad de la habitacion
	textovisible=textovisible & "&nbsp;&nbsp;<a id='hab_" & th & "' href=javascript:abreCalendarDispo('hab_" & th & "'," & idh & ","
	textovisible=textovisible & th & "," & month(fini) & "," & year(fini) & ")>"
	textovisible=textovisible & "<img src='css/img/calendar.gif' border='0'></a>"
	laspelas=0
else 
	textovisible=formatnumber(laspelas*elCambio,2) & sufijoMoneda
end if

%>
<script language="javascript" type="text/javascript">
	parent.document.getElementById('verimporte_<%=fr%>').innerHTML="<b><%=textovisible%></b>";
	parent.document.getElementById('importe_<%=fr%>').value="<%=laspelas*elCambio%>";
	
</script>