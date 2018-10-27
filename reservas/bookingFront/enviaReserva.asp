<%
	set FSO = Server.CreateObject("Scripting.FileSystemObject") 
	'Abrir fichero plantilla
	ficheroPlanti="plantillasCorreo/correoReserva_" & idEmpresa & ".html"
	set oFichero = FSO.OpenTextFile(server.MapPath(ficheroPlanti)) 
	plantilla= oFichero.ReadAll  'Paso los datos a una variable
	'Cerrar el fichero
	oFichero.close
	set oFichero=nothing
	set FSO=nothing
	
	texto=plantilla 'plantilla del voucher
	texto=Replace(texto, "Vte=lang",lang) 
	texto=Replace(texto, "Vte=LOGOHOTEL", idEmpresa)
	texto=Replace(texto, "Vte=codres",objIdioma.getTraduccionHTML("i_Vcodigores") & ": " & codres) 

	'datos hotel
	texto=Replace(texto, "Vte=datoshotel",ucase(objIdioma.getTraduccionHTML("i_Vdatoshotel"))) 
	texto=Replace(texto, "Vte=nombrehotel",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;<b>" & nombrehotel & "</b>") 
	texto=Replace(texto, "Vte=direhotel",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & direccionhotel) 
	texto=Replace(texto, "Vte=poblahotel",objIdioma.getTraduccionHTML("i_localidad") & ":&nbsp;" & poblacionhotel) 
	texto=Replace(texto, "Vte=telehotel",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & telefonohotel) 
	texto=Replace(texto, "Vte=emailhotel","<a href='mailto:" & emailhotel & "'>" & emailhotel & "</a>") 
	
	'Datos Reserva
	texto=Replace(texto, "Vte=datosreserva",ucase(objIdioma.getTraduccionHTML("i_datosres"))) 
	texto=Replace(texto, "Vte=codigoreserva",objIdioma.getTraduccionHTML("i_codres") & ":&nbsp;" & codres) 
	texto=Replace(texto, "Vte=fechallegada",objIdioma.getTraduccionHTML("i_llegada") & ":&nbsp;" & fllegada) 
	texto=Replace(texto, "Vte=fechasalida",objIdioma.getTraduccionHTML("i_salida") & ":&nbsp;" & fsalida) 
	texto=Replace(texto, "Vte=noches",objIdioma.getTraduccionHTML("i_noches") & ":&nbsp;" & noches) 
	
	textoHabitacion=""
	if hayhabis then
	for h=0 to ubound(RegHabis,2)
		textoHabitacion=textoHabitacion & "- " & RegHabis(HNombre,h) & ", " & RegHabis(HRegimen,h) & "<br/>"
		textoHabitacion=textoHabitacion & objIdioma.getTraduccionHTML("i_adultos") & ": " & RegHabis(HAdultos,h)
		if RegHabis(HNinos1,h)<>0 then
			textoHabitacion=textoHabitacion & ", " & objIdioma.getTraduccionHTML("i_ninos") & ": " & RegHabis(HNinos1,h)			
		end if
		if RegHabis(HNinos2,h)<>0 then
			textoHabitacion=textoHabitacion & ", " & objIdioma.getTraduccionHTML("i_ninos") & ": " & RegHabis(HNinos2,h)			
		end if
		if RegHabis(HBebes,h)<>0 then
			textoHabitacion=textoHabitacion & ", " & objIdioma.getTraduccionHTML("i_bebes") & ": " & RegHabis(HBebes,h)			
		end if
		if RegHabis(HImporte,h)<>0 then
			textoHabitacion=textoHabitacion & ", " & objIdioma.getTraduccionHTML("i_precio") & ": <b>" & formatNumber(RegHabis(HImporte,h),2) & " " & moneda & "</b>"
		end if
		textoHabitacion=textoHabitacion & "<br/>"
	next
	textoHabitacion=textoHabitacion & "<br/>"
	end if 'hayhabis
	if hayServis then
		textoHabitacion=textoHabitacion & "<b>" & objIdioma.getTraduccionHTML("i_serviciosextras") & ": </b><br/>" 
	for s=0 to ubound(RegServisRes,2)
		textoHabitacion=textoHabitacion & "- " & RegServisRes(SeNombre,s) & " (" & RegServisRes(SeCantidad,s) & "x" & formatNumber(RegServisRes(SeImporte,s),2) & "): " & formatNumber(RegServisRes(SeCantidad,s)*RegServisRes(SeImporte,s),2) & " " & moneda & "<br>"
	next 's
	end if 'hayServis
	texto=Replace(texto, "Vte=habitaciones",textoHabitacion) 
	
	textoOfertas=""
	if hayOfertas then
		for o=0 to ubound(RegOfertas,2)
			textoOfertas=textoOfertas & "* " & objIdioma.getTraduccionHTML("i_oferta") & ": "
			if RegOfertas(OfPromocion,o)<>"" then textoOfertas=textoOfertas & "(" & RegOfertas(OfPromocion,o) & ") "
			textoOfertas=textoOfertas & RegOfertas(OfTitulo,o) & "= <b>" & formatNumber(RegOfertas(OfImporte,o)*(-1),2) & " " & moneda & "</b>"
			textoOfertas=textoOfertas & "<br/>"
		next 'o
		textoOfertas=textoOfertas & "<br/>"
	end if 'hayOfertas
	texto=Replace(texto, "Vte=ofertas",textoOfertas) 
	
	
	textopelas=objIdioma.getTraduccionHTML("i_totalreserva") & ":&nbsp;<b>" & formatnumber(totalreserva,2) & "&nbsp;" & moneda & "</b><br/>"
	if tipotarjeta="" then 'es por tpv, no es verificacion
	textopelas=textopelas & objIdioma.getTraduccionHTML("i_prepago") & ":&nbsp;<b>" & formatnumber(prepago,2) & "&nbsp;" & moneda & "</b><br/>"
	textopelas=textopelas & objIdioma.getTraduccionHTML("i_pagoenhotel") & ":&nbsp;<b>" & formatnumber(totalreserva-prepago,2) & "&nbsp;" & moneda & "</b>"
	end if 'tipo TPV
	texto=Replace(texto, "Vte=precio",textopelas)
	
	
	'Datos personales
	texto=Replace(texto, "Vte=datospersonales",ucase(objIdioma.getTraduccionHTML("i_datos"))) 
	texto=Replace(texto, "Vte=nombrecliente",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & apellidos & ", " & nombre) 
	texto=Replace(texto, "Vte=direcliente",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & direccion) 
	texto=Replace(texto, "Vte=poblacliente",objIdioma.getTraduccionHTML("i_localidad") & ":&nbsp;" & poblacion) 
	texto=Replace(texto, "Vte=provicliente",objIdioma.getTraduccionHTML("i_provincia") & ":&nbsp;" & provincia) 
	texto=Replace(texto, "Vte=paiscliente",objIdioma.getTraduccionHTML("i_pais") & ":&nbsp;" & nombrepais) 
	texto=Replace(texto, "Vte=telefonocliente",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & telefono) 
	texto=Replace(texto, "Vte=emailcliente",objIdioma.getTraduccionHTML("i_email") & ":&nbsp;" & email)
	texto=Replace(texto, "Vte=obscliente",objIdioma.getTraduccionHTML("i_comentarios") & ":&nbsp;" & comentarios)
	texto=Replace(texto, "Vte=condiciones",condicionesHotel)
	
	textoCli=texto
	textoCli=Replace(textoCli, "Vte=datostarjeta","")
	textoHotel=texto
	if tipotarjeta<>"" then 'poner datos de tarjeta
		dtarjeta="<br><b>" & ucase(objIdioma.getTraduccionHTML("i_tarjetacredito")) & ":</b><br>"
		dtarjeta=dtarjeta & objIdioma.getTraduccionHTML("i_tipotarjeta") & ": " & tipotarjeta & "<br>"
		dtarjeta=dtarjeta & objIdioma.getTraduccionHTML("i_numerotarjeta") & ": " & numerotarjeta & "<br>"
		dtarjeta=dtarjeta & objIdioma.getTraduccionHTML("i_codigoseguridad") & ": " & codigoseguridad & "<br>"
		dtarjeta=dtarjeta & objIdioma.getTraduccionHTML("i_fechacaducidad") & ": " & fechacadu & "<br>"
	end if
	textoHotel=Replace(textoHotel, "Vte=datostarjeta",dtarjeta)
	
	
	'Enviar emails
	errormail=sendEmailTo(email,objIdioma.getTraduccion("i_confireserva") & " " & codres & " - " & nombreHotel,remitente,textoCli,"")
	
	errormail=sendEmailTo(emailHotel,objIdioma.getTraduccion("i_confireserva") & " " & codres & " - " & nombreHotel,remitente,textoHotel,"")
	
	errormail=sendEmailTo("gisela@planeta-web.com",objIdioma.getTraduccion("i_confireserva") & " " & codres & " - " & nombreHotel,remitente,textoHotel,"")
	
	if erromail<>"" then response.write errormail
	'response.write texto
%>