<%coin="EUR"%>
<%



parametros="precioHabitacion.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=es&fini=" & fini & "&ffin=" & ffin
parametros=parametros & "&codhab=" & RegHabis(HaCodi,h) & "&ad=" & adultostmp & "&ni1=" & ni1tmp
parametros=parametros & "&ni2=" & ni2tmp & "&idregi=" & tRegAux
parametros=parametros & "&promo=" & promo
parametros=parametros & "&numHabs=" & numHabs

response.write "<!-- calculo habi Frame=" & xmlURL & parametros & "-->"
'http://www.online4you.es/reservas/crs/webservice/precioHabitacion.asp?ide=98&est=79&lang=es&fini=03/05/2011&ffin=05/05/2011&codhab=98&ad=2&ni1=&ni2=0&idregi=&promo=&numHabs=2
'http://www.online4you.es/reservas/crs/webservice/precioHabitacion.asp?ide=98&est=79&lang=es&fini=03/05/2011&ffin=05/05/2011&codhab=98&ad=2&ni1=0&ni2=0&idregi=5&promo=&numHabs=2
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
	textovisible=textovisible & "&nbsp;&nbsp;<a id='hab_" & RegHabis(HaCodi,h) & "' href=javascript:parent.abreCalendarDispo(" & RegHabis(HaCodi,h) & "," & idh & ","
	textovisible=textovisible & month(fini) & "," & year(fini) & ")>"
	textovisible=textovisible & "<img src='css/img/calendar.gif' border='0'></a>"
	laspelas=0
else 
	textovisible=formatnumber(laspelas*elCambio,2) & sufijoMoneda
end if

%>
<td <%=tdStyle%>>					
	<div class="PhotelTexxtoFila">
		<span style="font-size: 11px" id='porPersona_<%=hh%>_<%=h%>'><%= formatnumber((laspelas * elCambio)/dateDiff("d",fini,ffin),2) %><%= sufijoMoneda %></span>
	</div>
</td>
<td <%=tdStyle%>>
	 <div class="PhotelTexxtoFila">
		<img id='espera_<%=hh%>_<%=h%>' style="display: none" src="img/espera.gif" width="16" height="16" class="espera"/>
		<span tyle="font-size: 11px" id='verimporte_<%=hh%>_<%=h%>'><%= textovisible %></span>
	
	</div>
</td>
<script language="javascript" type="text/javascript">
setOferta('<%=thereIsPromo%>','Promo_<%=hh%>_<%=h%>');
</script>

