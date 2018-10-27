<%
	est=paClng(request.QueryString("idh"))
	fini=request.Form("fini")
	if (fini="") then fini=request.QueryString("fini")
	fini=cdate(fini)

	ffin=request.Form("ffin")
	if (ffin="") then ffin=request.QueryString("ffin")
	ffin=cdate(ffin)


	Noches=dateDiff("d",fini,ffin)
	datos=split(request.form,"&") 'tabla de campos para usar en los calculos de precios
	if (ubound(datos)=-1) then
		datos=split(request.QueryString,"&") 'tabla de campos para usar en los calculos de precios
	end if
	hayhabis=false
	totalbruto=0
	cpromo=request.form("cpromo")
	if (cpromo="") then cpromo=request.QueryString("cpromo")
	npromo=request.form("npromo")
	if (npromo="") then npromo=request.QueryString("npromo")

	'Buscar precios de las habitaciones segun la temporada
	dim PrecioHab(),NombreHab(),NombreSuples(),Preciosuples(),TotalSuples(),PrecioPlazas(),DtoHab(),DtoSuples()
	dim FechaRes(),PrecioPerso(), prepagoHabArr()
	redim preserve PrecioHab(noches,cuantas)
	redim preserve NombreHab(noches,cuantas)
	redim preserve PrecioPerso(noches,cuantas)
	redim preserve FechaRes(noches,cuantas)
	redim preserve NombreSuples(noches,cuantas)
	redim preserve PrecioSuples(noches,cuantas)
	redim preserve PrecioPlazas(noches,cuantas)
	redim preserve DtoHab(noches,cuantas)
	redim preserve DtoSuples(noches,cuantas)
	redim preserve TotalSuples(noches,cuantas)
	redim preserve prepagoHabArr(noches,cuantas)
	
	dim codiOferta(),textoOferta(),totalOferta()
	o=0 'contador de ofertas
	pelasprepagoHab=0
	for hh=1 to cuantas 'se hace una llamada para cada hab.
		
		parametros="precioHabitacion.asp?ide=" & IdEmpresa & "&est=" & idh & "&lang=" & lang & "&fini=" & fini & "&ffin=" & ffin 
		parametros=parametros & "&codhab=" & Vhabis(hh) & "&ad=" & Vadultos(hh) & "&ni1=" & Vninos1(hh)
		parametros=parametros & "&ni2=" & Vninos2(hh) & "&idregi=" & codsuples(hh) & "&promo=" & cpromo
		
		Set objDom = Server.CreateObject("Microsoft.XMLDOM")
		objDom.async = false
		objDom.validateOnParse = false
		objDom.setProperty "ServerHTTPRequest", true
		if objDom.Load(xmlURL & parametros) then
		Response.Write("<!--" & xmlURL & parametros & "-->")
		
			For Each objItem in objDom.documentElement.SelectNodes("/data")
				'Datos del hotel
				nhotel=objItem.SelectSingleNode("hotel").text
				monedaHotel=objItem.SelectSingleNode("moneda").text
				estado=paClng(objItem.SelectSingleNode("estado").text)
				estadoHab=objItem.SelectSingleNode("estadohabitacion").text
				total=objItem.SelectSingleNode("totalbruto").text
				prepagoHabi=objItem.SelectSingleNode("prepagoHab").text
				ofertatem=objItem.SelectSingleNode("ofertatem").text
				
				prepago=objItem.SelectSingleNode("prepagoTemp").text
				if isnumeric(prepago)  then
					prepago=cdbl(prepago)
					pelasprepago=prepago
				else
					prepago=objItem.SelectSingleNode("prepago").text
					if isnumeric(prepago) then
						prepago=cdbl(prepago)
					else
						prepago=0
					end if
				end if
				

				
				
				sumaOfertas=0
				'ofertas
				For Each eso in objDom.documentElement.SelectNodes("/data/oferta")
					pelas=paDbl(eso.SelectSingleNode("totaloferta").text)
					if pelas>0 then
						hayofertas=true
						redim preserve codiOferta(o)
						redim preserve textoOferta(o)
						redim preserve totalOferta(o)
						codiOferta(o)=eso.SelectSingleNode("codioferta").text
						textoOferta(o)=eso.SelectSingleNode("textooferta").text
						totalOferta(o)=pelas
						sumaOfertas=sumaOfertas+totalOferta(o)
						o=o+1
					end if
				next
	'Servicios pro hab
			anteservi=0
				totalservi=0
				if hayServis then
					for s=0 to ubound(RegServis,2)
						'Comprobar si esta marcado
									if anteservi<>RegServis(SCodi,s) then
										linea=0
									else
										linea=linea+1
									end if
									servtmp=request.querystring("servi_" & RegServis(SCodi,s) & "_" & linea)
									if (servtmp="") then 
										servtmp=request.form("servi_" & RegServis(SCodi,s) & "_" & linea)
									end if
									
									if servtmp="1" then 'está marcado
										cantidadtmp=request.querystring("cuantos_" & RegServis(SCodi,s) & "_" & linea)
										if (cantidadtmp="") then 
											cantidadtmp=request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea)
										end if
										cantidad = paClng(cantidadtmp)
										descuentotmp = request.querystring("importedescuento_" & RegServis(SCodi,s) & "_" & linea)
										if (descuentotmp="") then 
											descuentotmp=request.form("importedescuento_" & RegServis(SCodi,s) & "_" & linea)
										end if
										descuento = descuentotmp
										descuento = replace(descuento, ".", ",")
										'response.write "<br>cantidad=" & cantidad
										'response.write "colec=" & RegServis(SColectivo, s)
										'response.write "SPelas=" & RegServis(SPelas, s)
										if cantidad > 0 then 
											nservi = nservi + 1
											totalservi = totalservi + (cantidad * RegServis(SPelas,s))			
											totalservi = totalservi - descuento
										end if 'cantidad>0
										end if

									anteservi = RegServis(SCodi,s)

					next
				end if
'end servicios por hab				
				if isnumeric(total) then
					totalTmp=cdbl(total)
					response.write "<!--totalTmp 1=" & totalTmp & "-->"
					
					totalbruto=totalbruto+totalTmp
					response.write "<!--totalbruto 1=" & totalbruto & "-->"
					
					totalTmp=totalTmp-sumaOfertas+(totalservi/cuantas)
					response.write "<!--totalTmp=" & totalTmp & "-->"
					response.write "<!--sumaOfertas=" & sumaOfertas & "-->"
					response.write "<!--totalservi=" & totalservi & "-->"

					
					if (cint(prepagoHabi<>0)) then
						pelasprepagoHab=pelasprepagoHab+(totalTmp*prepagoHabi/100)
						prepagoDB=prepagoHabi
						'response.write "<!--prepagoDB 1=" & prepagoDB & "-->"
					else
						response.write "<!--totalTmp=" & totalTmp & "-->"
						response.write "<!--prepago=" & prepago & "-->"
						response.write "<!--pelasprepagoHab=" & pelasprepagoHab & "-->"
						pelasprepagoHab=pelasprepagoHab+(totalTmp*(prepago/100))
						prepagoDB=prepago				
					end if

					response.write "<!--pelasprepagoHab 2=" & pelasprepagoHab & "-->"
					
					
				end if
	
				'lineas precio de la reserva
				d=0
				For Each esto in objDom.documentElement.SelectNodes("/data/reserva")
					hayhabis=true
					redim preserve NombreHab(noches,hh)
					redim preserve FechaRes(noches,hh)
					redim preserve NombreSuples(noches,hh)
					redim preserve PrecioSuples(noches,hh)
					redim preserve PrecioPlazas(noches,hh)
					redim preserve DtoHab(noches,hh)
					redim preserve DtoSuples(noches,hh)
					redim preserve TotalSuples(noches,hh)
					redim preserve prepagoHabArr(noches,hh)
					
					d=d+1
					FechaRes(d,hh)=esto.SelectSingleNode("dia").text
					NombreHab(d,hh)=esto.SelectSingleNode("nomhab").text
					prepagoHabArr(d,hh)=prepagoDB
					
					PrecioPlazas(d,hh)=esto.SelectSingleNode("preciohab").text
					if isnumeric(PrecioPlazas(d,hh)) then
						PrecioPlazas(d,hh)=cdbl(PrecioPlazas(d,hh))
					else
						PrecioPlazas(d,hh)=0
					end if
					DtoHab(d,hh)=esto.SelectSingleNode("dtohab").text
					if isnumeric(DtoHab(d,hh)) then
						DtoHab(d,hh)=cdbl(DtoHab(d,hh))
					else
						DtoHab(d,hh)=0
					end if
					NombreSuples(d,hh)=esto.SelectSingleNode("nomsuple").text
					TotalSuples(d,hh)=esto.SelectSingleNode("preciosuple").text
					if isnumeric(TotalSuples(d,hh)) then
						TotalSuples(d,hh)=cdbl(TotalSuples(d,hh))
					else
						TotalSuples(d,hh)=0
					end if
					DtoSuples(d,hh)=esto.SelectSingleNode("dtosuple").text
					if isnumeric(DtoSuples(d,hh)) then
						DtoSuples(d,hh)=cdbl(DtoSuples(d,hh))
					else
						DtoSuples(d,hh)=0
					end if
					
				next 'la reserva
				
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
				response.write strErrText
		end if	
		
		Set objDom = Nothing
		Set objItem = Nothing
	
	next 'nº habis
%>