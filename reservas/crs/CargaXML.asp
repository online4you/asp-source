<%
	tipoa=request.querystring("tipoa")
	cate=request.querystring("cate")
	zona=request.querystring("zona")
	lang=request.querystring("lang")
	fechai=request.querystring("fechai")
	fechaf=request.querystring("fechaf")
	fechai=replace(fechai,"/","_")
	fechaf=replace(fechaf,"/","_")
	adultos=request.querystring("adultos")
	ninos=request.form("ninos")
	datos="lang=" & lang & "&tipoa=" & tipoa & "&cate=" & cate & "&zona=" & zona & "&fechai=" & fechai
	datos=datos & "&fechaf=" & fechaf & "&adultos=" & adultos & "&ninos=" & ninos

	fichero="http://www.hotel-reserved.com/admincala/BuscarPrecios.asp?" & datos
    'XML file object
    Set objDom = Server.CreateObject("Microsoft.XMLDOM")
    objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
    if objDom.Load(Fichero) then
		mierror=""
		on error resume next
		mierror=objDom.documentElement.SelectSingleNode("error").text
		if err.number=0 then 'hay un error
			response.write mierror & "<br>"
			response.End()
		end if
		on error goto 0
		
		For Each objItem in objDom.documentElement.SelectNodes("hotel")
			nhotel=objItem.SelectSingleNode("nombre").text
			cate=objItem.SelectSingleNode("categoria").text
			foto=objItem.SelectSingleNode("foto").text
			habita=objItem.SelectSingleNode("habitacion").text
			regimen=objItem.SelectSingleNode("regimen").text
			pelas=objItem.SelectSingleNode("importe").text
			enlacereserva=objItem.SelectSingleNode("enlacereserva").text
			response.write nhotel & "<br>"
			response.write cate & "<br>"
			response.write foto & "<br>"
			response.write habita & "<br>"
			response.write regimen & "<br>"
			response.write pelas & "<br>"
			response.write enlacereserva & "<br><br>"
			response.Flush()
		Next 'objetos
	
	
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
			response.write strErrText
	end if	
    'Release variables
    Set objDom = Nothing
    Set objItem = Nothing


%>