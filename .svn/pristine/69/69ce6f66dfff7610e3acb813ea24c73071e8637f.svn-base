<%
	idh=paClng(request.QueryString("idh"))
	'Array colectivos
	'dim RegColec()
	redim RegColec(2,0)
	ncolec=-1
	CCodi=0
	CNombre=1
	COrden=2
	
	'Arrays del registro de habitaciones
	'dim RegHabis()
	hayhabis=false
	redim RegHabis(12,0)
	nhabis=-1
	HaCodi=0
	HaNombre=1
	HaCapMax=2
	HaCapMin=3
	HaAduMax=4
	HaAduMin=5
	HaNinMax=6
	HaCapNormal=7
	HaCupo=8
	HaCunaOcupa=9
	HaAdmiNinos=10
	HaFotos=11
	HaTextos=12
	
	'Array suplementos (regimen)
	'dim RegSuples()
	haysuples=false
	nsuples=-1 'contador
	redim RegSuples(3,0)
	SCodi=0
	SNombre=1
	SHabi=2
	SDefecto=3
	
	
	'Fechas
	fini=request.form("fechai")
	if fini="" then fini=request.querystring("fini")
	if fini="" then fini=request.form("fini")
	if fini="" then fini=request.cookies("bfini")
	if fini="" then fini=date+1

	if fini<>"" then 'no admite cookies
		ffin=request.form("fechaf")
		if ffin="" then ffin=request.querystring("ffin")
		if ffin="" then ffin= request.form("ffin")
		if ffin="" then ffin=request.cookies("bffin")
		if ffin="" then ffin=date+3
		
		parametros="habisHotel.asp?ide=" & IdEmpresa & "&est=" & idh & "& lang=" & lang & "&fini=" & fini & "&ffin=" & ffin
		response.write("<!--" & xmlURL & parametros & "-->")
		
		'response.write( xmlURL & parametros & "<br>")
		
		Set objDom = Server.CreateObject("Microsoft.XMLDOM")
		objDom.async = false
		objDom.validateOnParse = false
		objDom.setProperty "ServerHTTPRequest", true
		if objDom.Load(xmlURL & parametros) then
	
			For Each objItem in objDom.documentElement.SelectNodes("/data")
				'Datos del hotel
				nhotel=objItem.SelectSingleNode("hotel").text
				estado=objItem.SelectSingleNode("estado").text
				'Colectivos
				For Each esto in objDom.documentElement.SelectNodes("/data/colectivo")
					ncolec=ncolec+1
					redim preserve RegColec(2,ncolec)
					RegColec(CCodi,ncolec)=paClng(esto.SelectSingleNode("codcolec").text)
					RegColec(CNombre,ncolec)=esto.SelectSingleNode("nomcolec").text
					RegColec(COrden,ncolec)=paClng(esto.SelectSingleNode("ordencolec").text)
				next 'las colec.
				
				'Cargar las habitaciones
				For Each esto in objDom.documentElement.SelectNodes("/data/habitacion")
					hayhabis=true
					nhabis=nhabis+1
					redim preserve RegHabis(12,nhabis)
					RegHabis(HaCodi,nhabis)=paClng(esto.SelectSingleNode("codhab").text)
					RegHabis(HaNombre,nhabis)=esto.SelectSingleNode("nomhab").text
					RegHabis(HaFotos,nhabis)=esto.SelectSingleNode("fotos").text
					RegHabis(HaTextos,nhabis)=esto.SelectSingleNode("descripcion").text
					RegHabis(HaCapMax,nhabis)=paClng(esto.SelectSingleNode("capmax").text)
					RegHabis(HaCapMin,nhabis)=paClng(esto.SelectSingleNode("capmin").text)
					RegHabis(HaCapNormal,nhabis)=paClng(esto.SelectSingleNode("capnormal").text)
					RegHabis(HaAduMax,nhabis)=paClng(esto.SelectSingleNode("adultmax").text)
					RegHabis(HaAduMin,nhabis)=paClng(esto.SelectSingleNode("adultmin").text)
					RegHabis(HaNinMax,nhabis)=paClng(esto.SelectSingleNode("ninmax").text)
					RegHabis(HaCupo,nhabis)=paClng(esto.SelectSingleNode("cupo").text)
					RegHabis(HaCunaOcupa,nhabis)=paClng(esto.SelectSingleNode("cunaocupa").text)
					RegHabis(HaAdmiNinos,nhabis)=paClng(esto.SelectSingleNode("admiteninos").text)
					
					'Carga suplementos
					For Each estoes in esto.SelectNodes("regimen")
						haysuples=true
						nsuples=nsuples+1
						redim preserve RegSuples(3,nsuples)
						'RegSuples(SCodi,nsuples)=paClng(estoes.SelectSingleNode("codregimen").text)
						RegSuples(SCodi,nsuples)=paClng(estoes.SelectSingleNode("idregimen").text)
						RegSuples(SNombre,nsuples)=estoes.SelectSingleNode("nomregimen").text
						RegSuples(SHabi,nsuples)=RegHabis(HaCodi,nhabis)
						RegSuples(SDefecto,nsuples)=paClng(estoes.SelectSingleNode("pordefecto").text)
					next 'suples
					
				next 'las habis
				
				
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
	
	end if 'fini<>""

%>