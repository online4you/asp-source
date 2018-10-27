<%
function CambioGoogle(M_original,M_destino)
	CambioGoogle=1 'valor por defecto
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load("http://conversor.planetaweb.es/conversorMoneda.aspx?de=" & M_Original & "&a=" & M_Destino) then		
		queCambio=objDom.SelectSingleNode("/datos/cambio").text
		'ya viene con el decimal coma
		CambioGoogle=paDbl(queCambio) 'transforma en Double
	end if
	set objDom=nothing

End function

coin=request.Cookies("coin")
if coin="" then coin=request.QueryString("moneda")
if coin="" then coin=monedaDefecto 'por defecto 
elCambio=1 'osea no cambia
if paDbl(request.Cookies("miCambio"))=0 then 'volver a solicitar el cambio
	'Realizar el cambio
	if coin=monedaHotel then 'no cambia los precios
		elCambio=1
	else
		elCambio=CambioGoogle(monedaHotel,coin)
	end if
else 'uso la cookie
	elCambio=paDbl(request.Cookies("miCambio"))
end if

sufijoMoneda=" " & coin
response.Cookies("miCambio")=elCambio
%>