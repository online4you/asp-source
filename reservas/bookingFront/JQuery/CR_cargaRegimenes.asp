<%
	idh=paClng(request.QueryString("idh"))
	
	'Array suplementos (regimen)
	'dim RegSuples()
	haysuples=false
	nsuples=-1 'contador
	redim RegSuples(4,0)
	SCodi=0
	SIdRegi=1
	SNombre=2
	SHotel=3
	SHabi=4
	
	'Fechas
	fini=request.querystring("fini")
	if fini="" then fini=request.form("fini")
	if fini="" then fini=request.cookies("bfini")
	if fini="" then fini=date+1
	
	parametros="regimenHotel.asp?ide=" & IdEmpresa & "&idh=" & idh & "&lang=" & lang & "&fini=" & fini
	'response.write xmlURL & parametros & "<br>"
	
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then

		For Each objItem in objDom.documentElement.SelectNodes("/data/regimen")
			'Carga suplementos
			haysuples=true
			nsuples=nsuples+1
			redim preserve RegSuples(4,nsuples)
			RegSuples(SCodi,nsuples)=paClng(objItem.SelectSingleNode("codigo").text)
			RegSuples(SIdRegi,nsuples)=paClng(objItem.SelectSingleNode("idregimen").text)
			RegSuples(SNombre,nsuples)=objItem.SelectSingleNode("nombre").text
			RegSuples(SHotel,nsuples)=paClng(objItem.SelectSingleNode("hotel").text)
			RegSuples(SHabi,nsuples)=paClng(objItem.SelectSingleNode("habitacion").text)
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