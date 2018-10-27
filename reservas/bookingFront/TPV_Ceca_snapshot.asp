<div style="visibility: hidden">
<h2>En construccion, disculpen las molestias</h2>
</div>

<div style="visibility: hidden">
<!-- #include file = "hex_sha1_js.asp" -->
<!-- #include file="./includes/dvim_apiRedsys_VB.asp" -->
<%
'codres=idres
'prepago=redondear(paDbl(request.form("prepago")))
'///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
' En variable prepago almacenamos el monto de la prepago del cliente con solo 2 decimales por eso usamos la funcion redondear; este
' valor lo sacamos de "CR_GrabaDatosBD.asp", es pagina y la actual estan incluidas en "pagoTPV" es por esta razón que  podemos 
' llamar a la varible prepago asignada en "CR_GrabaDatosBD.asp"
prepago=redondear(paDbl(prepago))
'Como el TPV solo acepta los precio sin decimales lo multiplicamos por 100 para quitarles los decimales
pelas=prepago*100 'para quitar los decimales

'lang=request.Form("lang")
'Codigos de idioma:
'1.- Español 	2.- Catalán 	3.- Euskera	4.- Gallego	5.- Valenciano
'6.- Inglés		7.- Francés	8.- Alemán	9.- Portugués	10.- Italiano
	select case lcase(lang)
		case "es"
			idiceca="1"
		case "en"
			idiceca="6"
		case "de"
			idiceca="8"
		case "it"
			idiceca="10"
		case "fr"
			idiceca="7"
		case else
			idiceca="1"		
	end select

	
	Response.CharSet = "utf-8"

	' Se crea Objeto
	Dim miObj 
	Set miObj = new RedsysAPI
	
	' Valores de entrada
	Dim fuc,terminal,moneda,trans,url,urlOKKO,id,amount
	fuc="336848593"
	terminal="001"
	moneda="978"
	trans="0"
	amount=pelas
	'url="http://www.online4you.es/reservas/bookingFront/respuestaCeca_snapshot.asp?num_operacion=" & codres
	url="http://www.online4youhotels.com/online4youcontroller.php?num_operacion=" & codres
	URLOK= Front_url & "graciasCECA.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres 
	URLKO= Front_url & "KO_GraciasCeca.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&%20lang=" & lang
	id=codres
	
	call miObj.setParameter("DS_MERCHANT_AMOUNT",amount)
	call miObj.setParameter("DS_MERCHANT_ORDER",CStr(id))
	call miObj.setParameter("DS_MERCHANT_MERCHANTCODE",fuc)
	call miObj.setParameter("DS_MERCHANT_CURRENCY",moneda)
	call miObj.setParameter("DS_MERCHANT_TRANSACTIONTYPE",trans)
	call miObj.setParameter("DS_MERCHANT_TERMINAL",terminal)
	call miObj.setParameter("DS_MERCHANT_MERCHANTURL",url)
	call miObj.setParameter("DS_MERCHANT_URLOK",URLOK)	
	call miObj.setParameter("DS_MERCHANT_URLKO",URLKO)
	
	' Datos de configuración
	Dim version
	version="HMAC_SHA256_V1"
	
	Dim CLAVE
	CLAVE = "Vj9aBonkfr04DWEEPyYk/fUFzlS6Rm1x" 'real
	Dim CLAVE_PRUEBAS
	CLAVE_PRUEBAS="sq7HjrUOBfKmC576ILgskD5srU870gJ7" 'pruebas
	
	kc = CLAVE
	
	' Se generan los parámetros de la petición
	Dim params,signature
	params = miObj.createMerchantParameters()
	signature = miObj.createMerchantSignature(kc)

Dim URL_SAB
URL_SAB ="https://sis.redsys.es/sis/realizarPago" 'real
Dim URL_PRUEBAS_SAB
URL_PRUEBAS_SAB= "https://sis-t.redsys.es:25443/sis/realizarPago" 'pruebas

Dim postURL
postURL = URL_SAB

%>
<form name="frm" action="<%=postURL%>" method="POST" target="_self">
Ds_Merchant_SignatureVersion <input type="text" name="Ds_SignatureVersion" value="<%=version%>"/><br/>
Ds_Merchant_MerchantParameters <input type="text" name="Ds_MerchantParameters" value="<%=params%>"/><br/>
Ds_Merchant_Signature <input type="text" name="Ds_Signature" value="<%=signature%>"/><br/>
<input type="submit" value="Enviar" >
</form>

<script language="javascript">
	document.frm.submit();
</script>

</body>
</html>


