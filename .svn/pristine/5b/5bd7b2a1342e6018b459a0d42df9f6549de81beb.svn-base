<%
	
	parametros="confirmaReserva.asp?ide=" & IdEmpresa & "&codres=" & codres & "&lang=" & lang
	'response.write xmlURL & parametros & "<br>"
	
	'Registros habitaciones	
	dim RegHabis()
	HNombre=0
	HAdultos=1
	HNinos1=2
	HNinos2=3
	HBebes=4
	HRegimen=5
	HImporte=6
	hayhabis=false
	
	dim RegOfertas()
	OfCodi=0
	OfTitulo=1
	OfPromocion=2
	OfImporte=3
	hayofertas=false

	dim RegServisRes()
	SeCodi=0
	SeNonbre=1
	SeCantidad=2
	SeImporte=3
	hayservis=false
	
		
	Set objDom = Server.CreateObject("Microsoft.XMLDOM")
	objDom.async = false
	objDom.validateOnParse = false
	objDom.setProperty "ServerHTTPRequest", true
	if objDom.Load(xmlURL & parametros) then

		For Each objItem in objDom.documentElement.SelectNodes("/reserva")
			
			nombreHotel=objItem.SelectSingleNode("hotel").text
			emailHotel=objItem.SelectSingleNode("emailhotel").text
			direccionHotel=objItem.SelectSingleNode("direccionhotel").text
			cpHotel=objItem.SelectSingleNode("cphotel").text
			poblacionHotel=objItem.SelectSingleNode("poblacionhotel").text
			telefonoHotel=objItem.SelectSingleNode("telefonohotel").text
			faxHotel=objItem.SelectSingleNode("faxhotel").text
			condicionesHotel=objItem.SelectSingleNode("condicioneshotel").text
			moneda=objItem.SelectSingleNode("moneda").text
			totalreserva=paDbl(objItem.SelectSingleNode("total").text)
			prepago=paDbl(objItem.SelectSingleNode("prepago").text)
			fllegada=objItem.SelectSingleNode("llegada").text
			fsalida=objItem.SelectSingleNode("salida").text
			noches=cdate(fsalida)-cdate(fllegada)
			tipoHotel="" 'objItem.SelectSingleNode("tipoaloja").text
			categoriaHotel="" 'objItem.SelectSingleNode("categoria").text
			
			'Buscar las habitaciones
			nhabis=-1
			For Each esto in objItem.SelectNodes("habitaciones/habitacion")
				nhabis=nhabis+1
				hayhabis=true
				redim preserve RegHabis(6,nhabis)
				RegHabis(HNombre,nhabis)=esto.SelectSingleNode("nombrehabitacion").text
				RegHabis(HAdultos,nhabis)=paClng(esto.SelectSingleNode("adultos").text)
				RegHabis(HNinos1,nhabis)=paClng(esto.SelectSingleNode("ninos1").text)
				RegHabis(HNinos2,nhabis)=paClng(esto.SelectSingleNode("ninos2").text)
				RegHabis(HBebes,nhabis)=paClng(esto.SelectSingleNode("bebes").text)
				elregi=split(esto.SelectSingleNode("regimen").text,";") 'viene el codigo y el nombre separado por ;
				RegHabis(HRegimen,nhabis)=elregi(1) 'nombre del regimen 
				RegHabis(HImporte,nhabis)=paDbl(esto.SelectSingleNode("importe").text)
			next 'habis

			'Buscar las ofertas
			nofer=-1
			For Each esto in objItem.SelectNodes("ofertas/oferta")
				nofer=nofer+1
				hayofertas=true
				redim preserve RegOfertas(3,nofer)
				RegOfertas(OfCodi,nofer)=esto.SelectSingleNode("idoferta").text
				RegOfertas(OfPromocion,nofer)=esto.SelectSingleNode("promocion").text
				RegOfertas(OfTitulo,nofer)=esto.SelectSingleNode("titulo").text
				RegOfertas(OfImporte,nofer)=paDbl(esto.SelectSingleNode("importe").text)
			next 'habis

			'Buscar los servicios
			nservi=-1
			For Each esto in objItem.SelectNodes("servicios/servicio")
				nservi=nservi+1
				hayServis=true
				redim preserve RegServisRes(3,nservi)
				RegServisRes(SeCodi,nservi)=esto.SelectSingleNode("idservicio").text
				RegServisRes(SeNombre,nservi)=esto.SelectSingleNode("nombre").text
				RegServisRes(SeCantidad,nservi)=paClng(esto.SelectSingleNode("cantidad").text)
				RegServisRes(SeImporte,nservi)=paDbl(esto.SelectSingleNode("importe").text)
			next 'habis
			
			'datos cliente
			nombre=objItem.SelectSingleNode("cliente/nombre").text
			apellidos=objItem.SelectSingleNode("cliente/apellidos").text
			direccion=objItem.SelectSingleNode("cliente/direccion").text
			telefono=objItem.SelectSingleNode("cliente/telefono").text
			email=objItem.SelectSingleNode("cliente/email").text
			poblacion=objItem.SelectSingleNode("cliente/poblacion").text
			provincia=objItem.SelectSingleNode("cliente/provincia").text
			codigopais=objItem.SelectSingleNode("cliente/codigopais").text
			nombrepais=objItem.SelectSingleNode("cliente/nombrepais").text
			comentarios=objItem.SelectSingleNode("cliente/comentarios").text


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
			'errormsg="Hotel cerrado o sin disponibilidad"
	end if	
	
	Set objDom = Nothing
	Set objItem = Nothing
%>