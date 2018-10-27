<%

'Variables del post
preu=redondear(prepago)*100 'quita decimales


select case lang
	case "es"
		idicaixa="001"
	case "ca"
		idicaixa="003"
	case "en"
		idicaixa="002"
	case "de"
		idicaixa="005"
	case "it"
		idicaixa="007"
	case "fr"
		idicaixa="004"
	case else
		idicaixa="002"
end select

	'/////////////////////         La Caixa              /////////////////////////////
	' Esta condicion es para saber si el TPV esta en modo pruebas o si ya esta online, 
	' este valor los sacamos de "CR_datosHotel.asp" 
	if TPV_produccion = 0 then 'Modulo en simulacion
		URL_TPVVIRTUAL = "https://sis-t.sermepa.es:25443/sis/realizarPago" 'Pruebas
	else
		'URL_TPVVIRTUAL = "https://sis.sermepa.es/sis/realizarPago" 'real
		response.write "no"
	end if
	
	Ds_Merchant_MerchantName= nombreHotel
	Ds_Merchant_MerchantCode="297603037"
	Ds_Merchant_Terminal="001"
	Ds_Merchant_Password="Q8VP99R7S2578P50" 'qwertyasdf0123456789

	' Moneda hotel viene de "CR_datosHotel.asp" 
	Select Case Ucase(monedaHotel) 
		Case "EUR" 
			Ds_Merchant_Currency="978" 'euros
		Case "USS"
			Ds_Merchant_Currency="840" 'dolares
		Case Else 
			Ds_Merchant_Currency="978" 'euros
	end Select
	
	Ds_Merchant_Amount=preu
	Ds_Merchant_Order=codres
	Ds_Merchant_ProductDescription="Booking "
	Ds_Merchant_Titular=mid(apellidos & ", " & nombre,1,60)
	Ds_Merchant_TransactionType= "0"
	Ds_Merchant_MerchantURL= "http://booking.kubikcrs.com/respuestaCeca.asp"
	Ds_Merchant_ConsumerLanguage=idicaixa

	'PruebaS
	Ds_Merchant_UrlOK="https://booking.kubikcrs.com/graciasOK.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&lang="&lang 
	Ds_Merchant_UrlKO="https://booking.kubikcrs.com/KO_gracias.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&lang="&lang 
	
	Dim ObjSHA1
	Dim StrDigest
	Set ObjSHA1 = New clsSHA1
	cadenaFirma = Ds_Merchant_Amount & Ds_Merchant_Order & Ds_Merchant_MerchantCode & Ds_Merchant_Currency & Ds_Merchant_TransactionType & Ds_Merchant_MerchantURL & Ds_Merchant_Password

	StrDigest = ObjSHA1.SecureHash(cadenaFirma)
	Set ObjSHA1 = Nothing
	
	'response.write "Firma: " & cadenaFirma & "<br/><br/>"
%>
<html>																														
<head><title><%= nombreHotel %></title>
</head>
<body bgcolor='white'>	
<h1 align="center">Conecting...</h1>
<form name='compra' action="<%=URL_TPVVIRTUAL%>" method='post'>
<input type=HIDDEN name=Ds_Merchant_Amount value="<%=Ds_Merchant_Amount%>">
<input type=HIDDEN name=Ds_Merchant_Currency value="<%=Ds_Merchant_Currency%>">
<input type=HIDDEN name=Ds_Merchant_Order  value="<%=Ds_Merchant_Order%>">
<input type=HIDDEN name=Ds_Merchant_MerchantCode value="<%=Ds_Merchant_MerchantCode%>">
<input type=HIDDEN name=Ds_Merchant_MerchantSignature value="<%=StrDigest%>">
<input type=HIDDEN name=Ds_Merchant_Terminal value="<%=Ds_Merchant_Terminal%>">
<input type=HIDDEN name=Ds_Merchant_ProductDescription value="<%=Ds_Merchant_ProductDescription%>">
<input type=HIDDEN name=Ds_Merchant_Titular value="<%=Ds_Merchant_Titular%>">
<input type=HIDDEN name=Ds_Merchant_TransactionType value="<%=Ds_Merchant_TransactionType%>">
<input type=HIDDEN name=Ds_Merchant_MerchantURL value="<%=Ds_Merchant_MerchantURL%>">
<input type=HIDDEN name=Ds_Merchant_ConsumerLanguage value="<%=Ds_Merchant_ConsumerLanguage%>">
<input type=HIDDEN name=Ds_Merchant_UrlOK value="<%=Ds_Merchant_UrlOK%>">
<input type=HIDDEN name=Ds_Merchant_UrlKO value="<%=Ds_Merchant_UrlKO%>">
<!--<input type="submit" value="enviar">-->
</form>
<script language="javascript" type="text/javascript">
	document.compra.submit();
</script>
</body>
</html>
