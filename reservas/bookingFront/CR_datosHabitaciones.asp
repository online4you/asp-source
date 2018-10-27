<%
	idh=paClng(request.QueryString("idh"))
	
	'Arrays del registro de habitaciones
	'dim RegHabis()
	hayhabis=false
	redim RegHabis(3,0)
	nhabis=-1
	HaCodi=0
	HaNombre=1
	HaTexto=2
	HaFotos=3
	
	parametros="habitacionesHotel.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=" & lang
	'response.write xmlURL & parametros & "<br>"
		
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then

		'Cargar las habitaciones
		For Each esto in objDom.documentElement.SelectNodes("/data/habitacion")
			hayhabis=true
			nhabis=nhabis+1
			redim preserve RegHabis(3,nhabis)
			RegHabis(HaCodi,nhabis)=paClng(esto.SelectSingleNode("codhab").text)
			RegHabis(HaNombre,nhabis)=esto.SelectSingleNode("nomhab").text
			RegHabis(HaTexto,nhabis)=esto.SelectSingleNode("descripcion").text
			RegHabis(HaFotos,nhabis)=esto.SelectSingleNode("fotos").text
		next 'las habis
			
	
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