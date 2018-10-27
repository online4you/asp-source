<%
localConnection=true
%>
<!--#include file="includes/constantes.asp"-->
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
promo=request.QueryString("promo")
numHabs=paClng(request.querystring("numHabs"))

parametros="precioHabitacion.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=es&fini=" & fini & "&ffin=" & ffin
parametros=parametros & "&codhab=" & th & "&ad=" & adultos & "&ni1=" & ninos1
parametros=parametros & "&ni2=" & ninos2 & "&idregi=" & tr
parametros=parametros & "&promo=" & promo
parametros=parametros & "&numHabs=" & numHabs

response.write "<!-- calculo habi" & xmlURL & parametros & "-->"

Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
if objDom.Load(xmlURL & parametros) then

	For Each objItem in objDom.documentElement.SelectNodes("/data")
		monedaHotel=objItem.SelectSingleNode("moneda").text
		total=objItem.SelectSingleNode("totalbruto").text
		totalextras=objItem.SelectSingleNode("netoextras").text
		if isnumeric(total) then
			laspelas = cdbl(total)
		end if
		netoextras=0
		if isnumeric(totalextras) then
			netoextras = cdbl(totalextras)
		end if
		prepagoTemp=objItem.SelectSingleNode("prepagoTemp").text
		if isnumeric(prepagoTemp) then
			prepagoTemp = cdbl(prepagoTemp)
		end if
		estado=objItem.SelectSingleNode("estadohabitacion").text
		release=paClng(objItem.SelectSingleNode("release").text)
		diasminimos=paClng(objItem.SelectSingleNode("diasminimos").text)
		
		'mirar oferta
		sumaOfertas = 0
		sumaDescuento = 0
		thereIsPromo=0
		on error resume next
		For Each ojete in objDom.documentElement.SelectNodes("/data/oferta")
			nofer=nofer+1
			redim preserve IdOferta(nofer)
			redim preserve NomOferta(nofer)
			redim preserve PelasOferta(nofer)
			redim preserve DescuentoOferta(nofer)
			pelillas=paDbl(ojete.SelectSingleNode("totaloferta").text)
			sumaOfertas=sumaOfertas+pelillas
			IdOferta(nofer)=ojete.SelectSingleNode("codioferta").text
			NomOferta(nofer)=ojete.SelectSingleNode("textooferta").text
			PelasOferta(nofer)=pelillas
			DescuentoOferta(nofer)=paDbl(ojete.SelectSingleNode("descuento").text)
			
			thereIsPromo=IdOferta(nofer)

			if sumaDescuento = 0 then
				sumaDescuento = sumaDescuento + DescuentoOferta(nofer)
			end if
		next 'las ofertas
		on error goto 0

'response.Write("<br>laspelas=" & laspelas)	
'response.Write("<br>netoextras=" & netoextras)	
'response.Write("<br>sumaOfertas=" & sumaOfertas)	
		laspelas = laspelas + netoextras - sumaOfertas
		
		if (thereIsPromo=0) then 
			ofertatem=objItem.SelectSingleNode("ofertatem").text
			if isnumeric(ofertatem) then
				thereIsPromo = ofertatem
			end if
		end if
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
	'fini=cdate(fini);
	textovisible=textovisible & "&nbsp;&nbsp;<a id='hab_" & th & "' href=javascript:parent.abreCalendarDispo(" & th & "," & idh & ","
	textovisible=textovisible & month(fini) & "," & year(fini) & ")>"
	textovisible=textovisible & "<img src='css/img/calendar.gif' border='0'></a>"
	laspelas=0
else 
	textovisible=formatnumber(laspelas*elCambio,2) & sufijoMoneda
end if

%>
<script language="javascript" type="text/javascript">
	document.getElementById('ofertaActiva').value="<%=thereIsPromo%>";
	document.getElementById('verimporte_<%=fr%>').innerHTML="<b><%=textovisible%></b>";
	document.getElementById('importe_<%=fr%>').value="<%= laspelas * elCambio %>";	
	document.getElementById('descuentopct_<%=fr%>').value="<%= sumaDescuento %>";
</script>
