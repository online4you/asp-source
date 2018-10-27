<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang=request.QueryString("lang")
codres=paClng(request.QueryString("codres"))


'Buscar codigo del hotel
cs="SELECT Reservas.CodigoEsta,Establecimientos.Nombre,FechaIni,FechaFin,NumDias,Servicios,"
cs=cs & "Importe,ImportePag,Comentarios,Idi,PelasOferta,IdCliente,CodigoISO,CodAgencia,TipoVentaAgencia,"
cs=cs & "Direccion,CP,Poblacion,Telefono,Fax,EMail,TipoAlojamiento,Categoria "
cs=cs & "FROM ((" & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) INNER JOIN DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) LEFT JOIN TiposMoneda "
cs=cs & "ON Establecimientos.Moneda=TiposMoneda.Id "
cs=cs & "WHERE cod_res=" & codres
rs.open cs,base
hayhotel=false
if not rs.eof then
	est=rs("codigoesta")
	nombreHotel=rs("nombre")
	direccionHotel=rs("direccion")
	CPHotel=rs("cp")
	poblacionHotel=rs("poblacion")
	telefonoHotel=rs("telefono")
	faxHotel=rs("fax")
	emailHotel=rs("email")
	tipoHotel=rs("tipoalojamiento")
	categoriaHotel=rs("categoria")
	
	FIni=rs("fechaini")
	FFin=rs("fechafin")
	ndias=rs("numdias")
	servis=rs("servicios")
	pelas=rs("importe")
	pagado=rs("importepag")
	dtooferta=paDbl(rs("pelasOferta"))
	obs=rs("comentarios")
	idcliente=rs("idcliente")
	lang=rs("idi")
	moneda=rs("codigoISO")
	idagencia=rs("codagencia")
	fpago=rs("tipoVentaAgencia")
	hayhotel=true
end if
rs.close

if hayhotel then 'Buscar el resto de datos
	
	'confirma la reserva
	cs= "UPDATE Reservas SET activa=-1, TpvFecha='" & date & "' WHERE Cod_res=" & codres
	base.execute cs

	'Datos del Cliente
	cs="SELECT * FROM Fichas WHERE Id=" & IdCliente
	rs.open cs,base
	if not rs.eof then
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		codigopais="" & rs("pais")
		nombrepais="" & rs("Nombrepais")
		telefono=rs("telefono")
		fax=rs("fax")
		email=rs("email")
	end if
	rs.close
	
	if idagencia<>0 then 'buscar datos de la agencia
		cs="SELECT Nombre,Direccion,CP,Poblacion,Email,Telefono,Fax FROM Agencias "
		cs=cs & "WHERE Id=" & idagencia
		rs.open cs,base
		if not rs.eof then
			nombre_age=rs("nombre")
			dire_age=rs("direccion")
			cp_age=rs("cp")
			pobla_age=rs("poblacion")
			email_age=rs("email")
			telefono_age=rs("telefono")
			fax_age=rs("fax")
		end if
		rs.close
	end if 'idagencia
	
	'Condiciones hotel
	cs="SELECT ISNULL(Traduccion,Texto) AS Tradu FROM " & precrs & "CondicionesHotel CondicionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones"
	cs=cs & "ON CondicionesHotel.CodigoEsta=Traducciones.IdReferencia AND Tabla='CondicionesHotel' AND "
	cs=cs & "Campo='Texto' AND Idioma='" & lang & "' "
	cs=cs & "WHERE CondicionesHotel.CodigoEsta=" & est
	'response.write cs
	rs.open cs,base
	if not rs.eof then
		condicionesHotel="" & rs("tradu")
	end if
	rs.close

	'Buscar nombres de colectivos
	cs="SELECT CodigoColec,ISNULL(Traduccion,Nombre) AS Tradu "
	cs=cs & "FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE Colectivos.CodigoEsta=" & est
	cs=cs & " ORDER BY orde"
	rs.open cs,base
	if not rs.eof then
		RegColec=rs.getrows
		CColec=0
		NColec=1
	end if
	rs.close

	'Suplementos del hotel
	cs="SELECT Regimen.Id,ISNULL(Traduccion,Nombre) AS Tradu FROM (" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
	cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id) LEFT JOIN Traducciones "
	cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est
	haysuples=false
	rs.open cs,base
	if not rs.eof then
		RegSuples=rs.getrows
		SCodi=0
		SNombre=1
		haysuples=true
	end if
	rs.close
				
	'Nombre habitaciones y cuantas
	cs="SELECT NumAdultos,NumBebes,NumNinos1,NumNinos2,Suplementos,ISNULL(Traduccion,Nombre) AS Tradu,Importe "
	cs=cs & "FROM (" & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id) LEFT JOIN Traducciones "
	cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE IdReserva=" & codres
	rs.open cs,base
	textoHabi=vbtab & "<habitaciones>" & vbcrlf
	do while not rs.eof 
		textoHabi=textohabi & vbtab & vbtab & "<habitacion>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<nombrehabitacion>" & server.HTMLEncode(rs("tradu")) & "</nombrehabitacion>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<adultos>" & paclng(rs("numadultos")) & "</adultos>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<ninos1>" & paclng(rs("numninos1")) & "</ninos1>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<ninos2>" & paclng(rs("numninos2")) & "</ninos2>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<bebes>" & paclng(rs("numbebes")) & "</bebes>" & vbcrlf
		'Buscar nomnbre suplementos
		suples=rs("suplementos")
		if suples<>"" then
			TSuples=split(suples,";")
			for s=0 to ubound(TSuples)
				if TSuples(s)<>"" then 'busca
					if haysuples then
					for ss=0 to ubound(RegSuples,2)
						if RegSuples(SCodi,ss)=paClng(TSuples(s)) then
							 textoHabi=textohabi & vbtab & vbtab & vbtab & "<regimen>" & TSuples(s) & ";"
							 textoHabi=textoHabi & server.HTMLEncode(RegSuples(SNombre,ss)) & "</regimen>" & vbcrlf
						end if
					next
					end if 'haysuples
				end if 'tsuples
			next 
		end if
		textoHabi=textohabi & vbtab & vbtab & vbtab & "<importe>" & rs("importe") & "</importe>" & vbcrlf
		textoHabi=textohabi & vbtab & vbtab & "</habitacion>" & vbcrlf
		rs.movenext
	loop
	rs.close
	textoHabi=textoHabi & vbtab & "</habitaciones>" & vbcrlf
	
	'Ofertas
	cs="SELECT Ofertas.Id,ISNULL(Traduccion,Titulo) AS Titulo,CodigoPromocion,Importe "
	cs=cs & "FROM (" & precrs & "OfertasReserva OfertasReserva INNER JOIN " & precrs & "Ofertas Ofertas "
	cs=cs & "ON OfertasReserva.IdOferta=Ofertas.Id) LEFT JOIN Traducciones "
	cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND "
	cs=cs & "Campo='Titulo' AND Idioma='" & lang & "' "
	cs=cs & "WHERE IdReserva=" & codres
	rs.open cs,base
	textoOferta=vbtab & "<ofertas>" & vbcrlf
	do while not rs.eof
		textoOferta=textoOferta & vbtab & vbtab & "<oferta>" & vbcrlf
		textoOferta=textoOferta & vbtab & vbtab & vbtab & "<idoferta>" & rs("id") & "</idoferta>" & vbcrlf
		textoOferta=textoOferta & vbtab & vbtab & vbtab & "<promocion>" & server.HTMLEncode(rs("codigopromocion")) & "</promocion>" & vbcrlf
		textoOferta=textoOferta & vbtab & vbtab & vbtab & "<titulo>" & server.HTMLEncode(rs("titulo")) & "</titulo>" & vbcrlf
		textoOferta=textoOferta & vbtab & vbtab & vbtab & "<importe>" & rs("importe") & "</importe>" & vbcrlf
		
		textoOferta=textoOferta & vbtab & vbtab & "</oferta>" & vbcrlf
		rs.movenext
	loop
	rs.close
	textoOferta=textoOferta & vbtab & "</ofertas>" & vbcrlf
	
	'Complementos servicios Extras
	cs="SELECT IdServicio,Cuantas,Pelas,IdColectivo,ISNULL(Traduccion,Nombre) AS Nombre "
	cs=cs & "FROM (" & precrs & "ReservaServicio ReservaServicio INNER JOIN " & precrs & "ServiciosExtras ServiciosExtras "
	cs=cs & "ON ReservaServicio.IdServicio=ServiciosExtras.Id) LEFT JOIN Traducciones "
	cs=cs & "ON ServiciosExtras.Id=Traducciones.IdReferencia AND Tabla='ServiciosExtras' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE CodReserva=" & codres
	'response.write cs
	rs.open cs,base
	textoServi=vbtab & "<servicios>" & vbcrlf
	do while not rs.eof
		textoServi=textoServi & vbtab & vbtab & "<servicio>" & vbcrlf
		textoServi=textoServi & vbtab & vbtab & vbtab & "<idservicio>" & rs("idservicio") & "</idservicio>" & vbcrlf
		textoServi=textoServi & vbtab & vbtab & vbtab & "<nombre>" & server.HTMLEncode(rs("nombre")) & "</nombre>" & vbcrlf
		textoServi=textoServi & vbtab & vbtab & vbtab & "<cantidad>" & rs("cuantas") & "</cantidad>" & vbcrlf
		textoServi=textoServi & vbtab & vbtab & vbtab & "<importe>" & rs("pelas") & "</importe>" & vbcrlf
		textoServi=textoServi & vbtab & vbtab & "</servicio>" & vbcrlf
		rs.movenext
	loop
	rs.close
	textoServi=textoServi & vbtab & "</servicios>" & vbcrlf
		
	
	'Generar XML de respuesta
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<reserva>" & vbcrlf
	response.write vbtab & "<codres>" & codres & "</codres>" & vbcrlf
	response.write vbtab & "<hotel>" & server.HTMLEncode(nombreHotel) & "</hotel>" & vbcrlf
	response.write vbtab & "<direccionhotel>" & server.HTMLEncode(direccionHotel) & "</direccionhotel>" & vbcrlf
	response.write vbtab & "<cphotel>" & server.HTMLEncode(cpHotel) & "</cphotel>" & vbcrlf
	response.write vbtab & "<poblacionhotel>" & server.HTMLEncode(poblacionHotel) & "</poblacionhotel>" & vbcrlf
	response.write vbtab & "<telefonohotel>" & server.HTMLEncode(telefonoHotel) & "</telefonohotel>" & vbcrlf
	response.write vbtab & "<faxhotel>" & server.HTMLEncode(faxHotel) & "</faxhotel>" & vbcrlf
	response.write vbtab & "<emailhotel>" & server.HTMLEncode(emailHotel) & "</emailhotel>" & vbcrlf
	response.write vbtab & "<condicioneshotel>" & server.HTMLEncode(condicionesHotel) & "</condicioneshotel>" & vbcrlf
	response.write vbtab & "<moneda>" & moneda & "</moneda>" & vbcrlf
	response.write vbtab & "<llegada>" & fini & "</llegada>" & vbcrlf
	response.write vbtab & "<salida>" & ffin & "</salida>" & vbcrlf
	response.write vbtab & "<total>" & pelas & "</total>" & vbcrlf
	response.write vbtab & "<prepago>" & pagado & "</prepago>" & vbcrlf
	
	response.write textoHabi
	response.write textoOferta
	response.write textoServi
	response.Write vbtab & "<cliente>" & vbcrlf
	response.Write vbtab & vbtab & "<nombre>" & server.HTMLEncode(nombre) & "</nombre>" & vbcrlf
	response.Write vbtab & vbtab & "<apellidos>" & server.HTMLEncode(apellidos) & "</apellidos>" & vbcrlf
	response.Write vbtab & vbtab & "<direccion>" & server.HTMLEncode(direccion) & "</direccion>" & vbcrlf
	response.Write vbtab & vbtab & "<telefono>" & server.HTMLEncode(telefono) & "</telefono>" & vbcrlf
	response.Write vbtab & vbtab & "<email>" & server.HTMLEncode(email) & "</email>" & vbcrlf
	response.Write vbtab & vbtab & "<poblacion>" & server.HTMLEncode(poblacion) & "</poblacion>" & vbcrlf
	response.Write vbtab & vbtab & "<provincia>" & server.HTMLEncode(provincia) & "</provincia>" & vbcrlf
	response.Write vbtab & vbtab & "<codigopais>" & server.HTMLEncode(codigopais) & "</codigopais>" & vbcrlf
	response.Write vbtab & vbtab & "<nombrepais>" & server.HTMLEncode(nombrepais) & "</nombrepais>" & vbcrlf
	response.Write vbtab & vbtab & "<comentarios>" & server.HTMLEncode(obs) & "</comentarios>" & vbcrlf
	response.write vbtab & "</cliente>" & vbcrlf
	response.write "</reserva>"

end if 'hayreserva
%>