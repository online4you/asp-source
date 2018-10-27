<%

function CambioGoogle(M_original,M_destino)
	CambioGoogle=1 'valor por defecto
	'M_Destino="GBP"

	if(M_Original<>M_destino and M_Original<>"" and M_destino<>"") then
		theURL="http://finance.google.com/finance/converter?a=1&from=" + M_Original + "&to=" + M_Destino
		'response.Write(theURL & "<br>")
		strResult=getHTML(theURL)
		cadenaBuscar = "<span class=bld>"	
		ini=InStr(strResult,cadenaBuscar)

		strResult=mid(strResult,ini,len(strResult))
		
		fin=InStr(strResult,M_Destino)-1
		strResult=trim(mid(strResult,1,fin))
		'Response.Write("strResult= " & strResult & "<br>")
		CambioGoogle=paDbl(strResult)
	end if

End function

function getHTML (strUrl) 
    Set xmlHttp = Server.Createobject("MSXML2.ServerXMLHTTP") 
    xmlHttp.Open "GET", strUrl, False 
    xmlHttp.setRequestHeader "User-Agent", "asp httprequest" 
    xmlHttp.setRequestHeader "content-type", "application/x-www-form-urlencoded" 
    xmlHttp.Send 
    getHTML = xmlHttp.responseText 
    xmlHttp.abort() 
    set xmlHttp = Nothing    
end function 
monedaDefecto="EUR"
if coin="" then coin=request.Cookies("coin")
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