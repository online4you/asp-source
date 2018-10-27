<%
	'datos obligatorios
	'est, fini, ffin, lang
	'ids opcional (id del servicio)

	'Array de los servicios
	'dim RegServis() 'puede dar error de que ya está definida
	hayServis = false
	redim RegServis(15, 0)
	nservis = -1
	SCodi = 0
	SNombre = 1
	STexto = 2
	SURL = 3
	SFoto = 4
	STipo = 5
	SPelas = 6
	SCColec = 7 'codigo colectivo
	SColectivo = 8 'nombre colectivoex
	SOrde = 9 'orden colectivo
	SRegis = 10 'array de regimenes
	SHabis = 11 'array de habitaciones
	SObliga = 12
	SIncluidoEnOferta = 13
	SFini = 14
	SFfin = 15
	
	
	parametros = "extrasHotel.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=" & lang & "&fini=" & fini & "&ffin=" & ffin & "&ids=" & ids

	response.write vbcrlf & "<!--" & xmlURL & parametros & "-->" & vbcrlf
		
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then

		'response.write xmlURL & parametros

		For Each objItem in objDom.documentElement.SelectNodes("/data")
			
			'Cargar los servicios
			For Each esto in objDom.documentElement.SelectNodes("/data/servicio")
				hayServis = true
				nservis = nservis + 1
				redim preserve RegServis(15, nservis)
				RegServis(SCodi, nservis) = esto.SelectSingleNode("id").text
				RegServis(SNombre, nservis) = esto.SelectSingleNode("titulo").text
				RegServis(STexto, nservis) = esto.SelectSingleNode("descripcion").text
				RegServis(SURL, nservis) = esto.SelectSingleNode("url").text
				lasfotos = ""
				
				on error resume next 'evitar el error si no tiene fotos

				For Each estoes in esto.SelectNodes("fotos")
					lasfotos = lasfotos & estoes.SelectSingleNode("foto").text & ";"
				next 'lasfotos

				on error goto 0

				RegServis(SFoto, nservis) = lasfotos

				lineaprecio = 1
				For Each estoes in esto.SelectNodes("precios/precio")
					if lineaprecio > 1 then 'añadir otro registro
						nservis = nservis + 1
						redim preserve RegServis(15, nservis)
						RegServis(SCodi, nservis) = esto.SelectSingleNode("id").text
						RegServis(SNombre, nservis) = esto.SelectSingleNode("titulo").text
					end if 'lineaprecio > 1
					
					RegServis(SPelas, nservis) = paDbl(estoes.SelectSingleNode("importe").text)
					RegServis(STipo, nservis) = PaClng(estoes.SelectSingleNode("tipo").text)					
					elcolec = split(estoes.SelectSingleNode("colectivo").text,";")
					RegServis(SCColec, nservis) = paClng(elcolec(0))
					RegServis(SColectivo, nservis) = elcolec(1)
					if ubound(elColec) > 1 then RegServis(SOrde, nservis) = elcolec(2)
					RegServis(SRegis, nservis) = estoes.SelectSingleNode("regimen").text
					RegServis(SHabis, nservis) = estoes.SelectSingleNode("habitaciones").text
					RegServis(SIncluidoEnOferta, nservis) = estoes.SelectSingleNode("oferta").text
					RegServis(SObliga, nservis) = paClng(estoes.SelectSingleNode("obligado").text)
					RegServis(SFini, nservis) = cdate(estoes.SelectSingleNode("fechaInicio").text)
					RegServis(SFfin, nservis) = cdate(estoes.SelectSingleNode("fechaFinal").text)
					
					lineaprecio = lineaprecio + 1
				next				
			next 'las habis
		next 'each
	else
		 ' No se ha cargado el documento.		
			' Obtenga el objeto ParseError
			Set xPE = objDom.parseError
			
			strErrText = "Your XML Document failed to load due the following error.<br>"
			strErrText = strErrText & "Error #: " & xPE.errorCode & ": " & xPE.reason & "<br>"
			strErrText = strErrText & "Line #: " & xPE.Line & "<br>"
			strErrText = strErrText & "Line Position: " & xPE.linepos & "<br>"
			strErrText = strErrText & "Position In File: " & xPE.filepos & "<br>"
			strErrText = strErrText & "Source Text: " & xPE.srcText & "<br>"
			strErrText = strErrText & "Document URL: " & xPE.url & "<br>"

			'response.write strErrText
			'errormsg="Hotel cerrado o sin disponibilidad"
	end if	
	
	Set objDom = Nothing
	Set objItem = Nothing
%>