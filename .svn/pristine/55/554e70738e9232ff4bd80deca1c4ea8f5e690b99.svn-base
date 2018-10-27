<%
	idh = paClng(request.QueryString("idh"))
	
	haytempo=false
	ntempo = -1 'contador
	redim RegTempoInfo(8, 0)
	
	TCodigoTemp = 0
	TCodigoEsta = 1
	TFInicio = 2
	TFFinal = 3
	TRelease = 4
	TMinimo = 5
	TPrepago = 6
	TOferta = 7
	TTraduccion = 8
	
	parametros = "temporadaInfo.asp?ide=" & IdEmpresa & "&idh=" & idh & "&lang=" & lang & "&temp=" & temporada
	response.Write("<!--" & xmlURL & parametros & "-->")
	
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then

		For Each objItem in objDom.documentElement.SelectNodes("/data/temporada")
			'Carga suplementos
			haytempo = true
			ntempo = ntempo + 1
			
			redim preserve RegTempoInfo(8, ntempo)
			
			RegTempoInfo(TCodigoTemp, ntempo) = paClng(objItem.SelectSingleNode("codigoTemp").text)
			RegTempoInfo(TCodigoEsta, ntempo) = paClng(objItem.SelectSingleNode("codigoEsta").text)
			RegTempoInfo(TFInicio, ntempo) = objItem.SelectSingleNode("fInicio").text
			RegTempoInfo(TFFinal, ntempo) = objItem.SelectSingleNode("fFinal").text
			RegTempoInfo(TRelease, ntempo) = objItem.SelectSingleNode("release").text
			RegTempoInfo(TMinimo, ntempo) = objItem.SelectSingleNode("minimo").text
			RegTempoInfo(TPrepago, ntempo) = paDbl(objItem.SelectSingleNode("prepago").text) 
			RegTempoInfo(TOferta, ntempo) = objItem.SelectSingleNode("oferta").text
			RegTempoInfo(TTraduccion, ntempo) = objItem.SelectSingleNode("traduccion").text	
		next 'each
	
	else
		 ' No se ha cargado el documento.		
			' Obtenga el objeto ParseError
			Set xPE = objDom.parseError
			
			strErrText = "Your XML Document failed to load due the following error.<br>"
			strErrText =strErrText & "Error #: " & xPE.errorCode & ": " & xPE.reason & "<br>"
			strErrText =strErrText & "Line #: " & xPE.Line & "<br>"
			strErrText =strErrText & "Line Position: " & xPE.linepos & "<br>"
			strErrText =strErrText & "Position In File: " & xPE.filepos & "<br>"
			strErrText =strErrText & "Source Text: " & xPE.srcText & "<br>"
			strErrText =strErrText & "Document URL: " & xPE.url & "<br>"
			'response.write strErrText
			errormsg="Hotel cerrado o sin disponibilidad"
	end if	
	
	Set objDom = Nothing
	Set objItem = Nothing
%>