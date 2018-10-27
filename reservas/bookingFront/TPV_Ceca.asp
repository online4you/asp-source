<div style="visibility: hidden">
<!-- #include file = "hex_sha1_js.asp" -->
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

'datos tpv del hotel
' Estos datos los sacamos de "CR_datosHotel.asp" salvo AcquirerBIN que es una constantes para todos los clientes
MerchantID   = TPV_codComercio
AcquirerBIN  = TPV_acquirerBIN
if AcquirerBIN="" then AcquirerBIN = "0000554041"
TerminalID   = TPV_terminal
clave        = TPV_clave


	' Esta condicion es para saber si el TPV esta en modo pruebas o si ya esta online, 
	' este valor los sacamos de "CR_datosHotel.asp" 
	if TPV_produccion <> 0 then 'Modulo en simulacion
		url="https://pgw.ceca.es/cgi-bin/tpv" 'modo real
	else
		url="http://tpv.ceca.es:8000/cgi-bin/tpv" 
	end if


URL_OK= Front_url & "graciasCECA.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&%20lang=" & lang
URL_NOK= Front_url & "KO_GraciasCeca.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&%20lang=" & lang
URL_OK= Front_url & "graciasCECA.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&lang=" & lang 
URL_NOK= Front_url & "KO_GraciasCeca.asp?ide=" & idempresa & "&idh=" & est & "&num_operacion=" & codres & "&lang=" & lang 
codMoneda="978"
exponent= "2"
strSHA="SHA1"

'clave ="99888888"
'MerchantID  ="111950028"
'AcquirerBIN  ="0000554052" 
'TerminalID  ="00000003"
'codres  ="123"
'pelas  ="500"
'strSHA="SHA1"
'URL_OK="http://www.ceca.es"
'URL_NOK="http://www.ceca.es"

toEncrypt=clave & MerchantID & AcquirerBIN & TerminalID & codres & pelas & codMoneda & exponent & strSHA & URL_OK & URL_NOK
'toEncrypt=""
'toEncrypt="El coche amarillo"
strHash = hex_sha1(toEncrypt)%>

%>
response.Write("<br>" )
response.Write("lang=" & lang & "<br>")
response.Write("clave=" & clave & "<br>")
response.Write("MerchantID=" & MerchantID& "<br>")
response.Write("AcquirerBIN=" & AcquirerBIN& "<br>")
response.Write("TerminalID=" & TerminalID& "<br>")
response.Write("codres=" & codres& "<br>")
response.Write("pelas=" & pelas& "<br>")
response.Write("codMoneda=" & codMoneda& "<br>")
response.Write("exponent=" & exponent& "<br>")
response.Write("strSHA=" & strSHA& "<br>")
response.Write("URL_OK=" & URL_OK& "<br>")
response.Write("URL_NOK=" & URL_NOK& "<br>")
Response.Write("<br>998888881119500280000554052000000031235009782SHA1http://www.ceca.eshttp://www.ceca.es<br>")
Response.Write(toEncrypt& "<br>")
Response.Write("15ba153908476895d9edd75ff23b207707d2c885<br>")
Response.Write("""""=<br>da39a3ee5e6b4b0d3255bfef95601890afd80709<br>")
Response.Write("El coche amarillo=<br>968be676ad7988e8d911fce686da3fececbb22eb<br>")
Response.Write(strHash& "<br>")


%>
<head>
</head>
url=<%=url%>
<body>
http://www.online4you.es/reservas/bookingFront/respuestaCeca.asp?num_operacion=81
<FORM name='f1' target="_self" ACTION="<%=url%>" method="post" ENCTYPE="application/xwww-form-urlencoded">
      MerchantID<input type=text name="MerchantID" value="<%=MerchantID%>"><br>
      AcquirerBIN<input type=text name="AcquirerBIN" value="<%=AcquirerBIN%>"><br>
      TerminalID<input type=text name="TerminalID" value="<%=TerminalID%>"><br>
      URL_OK<input type=text name="URL_OK" value="<%=URL_OK%>"><br>
      URL_NOK<input type=text name="URL_NOK" value="<%=URL_NOK%>"><br>
	  Firma<INPUT NAME="Firma" type=text VALUE="<%=strHash%>"><br>
	  Cifrado<INPUT NAME="Cifrado" type=text VALUE="SHA1"><br>
      Num_operacion<input type=text name="Num_operacion" value="<%=codres%>"><br>
      Importe<input type=text name="Importe" value="<%=pelas%>"><br>
      TipoMoneda<input type=text name="TipoMoneda" value="978"><br>
      Exponente<input type=text name="Exponente" value="2"><br>
      Pago_soportado<input type=text name="Pago_soportado" value="SSL"><br>
      Idioma<input type=text name="Idioma" value="<%=idiceca%>"><br>
	  <CENTER>
		<INPUT TYPE="submit" VALUE="Comprar"><br>
	  </CENTER>
</FORM>
</div>

<script language="javascript">
	document.f1.submit();
</script>
</body>
</html>


