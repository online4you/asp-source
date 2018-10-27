<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

lang="es"
codres=paClng(Request.QueryString("id"))

'Buscar codigo del hotel
cs="SELECT Reservas.CodigoEsta,Establecimientos.Nombre,FechaIni,FechaFin,NumDias,Servicios,"
cs=cs & "Importe,ImportePag,Comentarios,Idi,CodOferta,IdCliente,PelasOferta "
cs=cs & "FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE cod_res=" & codres
rs.open cs,base
hayhotel=false
if not rs.eof then
	est=rs("codigoesta")
	hnombre=rs("nombre")
	FIni=VerFecha(rs("fechaini"))
	FFin=VerFecha(rs("fechafin"))
	ndias=rs("numdias")
	servis=rs("servicios")
	pelas=rs("importe")
	prepago=rs("importepag")
	obs=rs("comentarios")
	lang=rs("idi")
	codoferta=rs("CodOferta")
	dtooferta=paDbl(rs("pelasOferta"))
	idCliente=rs("IdCliente")
	hayhotel=true
end if
rs.close

if hayhotel then 'Buscar el resto de datos
	'Datos del Cliente
	cs="SELECT * FROM Fichas WHERE Id=" & IdCliente
	rs.open cs,base
	if not rs.eof then
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		pais=rs("nombrepais")
		telefono=rs("telefono")
		cp=rs("cp")
		fax=rs("fax")
		email=rs("email")
	end if
	rs.close
	
	'Buscar datos del hotel
	cs="SELECT Direccion,CP,Poblacion,Telefono,Fax,EMail FROM " & precrs & "DatosHotel DatosHotel "
	cs=cs & "WHERE CodigoEsta=" & est
	rs.open cs,base
	if not rs.eof then
		hdire=rs("direccion")
		hcp=rs("cp")
		hpobla=rs("poblacion")
		htele=rs("telefono")
		hfax=rs("fax")
		mailhotel="" & rs("email")
	end if
	rs.close

		dim codservi(),nservi(),cuantos(),codcolec()
		dim GSCuantos(),GSServi()
		dim otravez,intercambio
		dim Colec(3)
		dim CuantasH(),NombreH(),SupleH()			
		dim tadultos(),tninos1(),tninos2(),tbebes()
		
		rutaVoucher="saintmichel/plantillaReserva.htm"
		set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		'Abrir fichero plantilla
		set oFichero = FSO.OpenTextFile(server.MapPath(rutaVoucher)) 
		plantilla= oFichero.ReadAll  'Paso los datos a una variable
		'Cerrar el fichero
		oFichero.close
		set oFichero=nothing
		set FSO=nothing

		'Buscar nombres de colectivos
		cs="SELECT Nombre_" & lang & " FROM Colectivos "
		cs=cs & "WHERE CodigoEsta=" & est
		cs=cs & " ORDER BY orde"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			NColec=0
		end if
		rs.close

		'Suplementos del hotel
		cs="SELECT RegimenHotel.Id,Nombre_" & lang & " FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
		cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
		cs=cs & "WHERE CodigoEsta=" & est
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
		cs="SELECT CuantasHabis,NumAdultos,NumBebes,NumNinos1,NumNinos2,Suplementos,Nombre_" & lang & " "
		cs=cs & "FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id "
		cs=cs & "WHERE IdReserva=" & codres
		rs.open cs,base
		numhabis=0
		do while not rs.eof 
			numhabis=numhabis+1
			redim preserve cuantash(numhabis)
			redim preserve nombreh(numhabis)
			redim preserve Supleh(numhabis)
			cuantash(numhabis)=rs("cuantashabis")
			nombreh(numhabis)=rs("nombre_" & lang)
			
			redim preserve tadultos(numhabis)
			redim preserve tninos1(numhabis)
			redim preserve tninos2(numhabis)
			redim preserve tbebes(numhabis)
			tadultos(numhabis)=rs("NumAdultos")
			tbebes(numhabis)=rs("NumBebes")
			tninos1(numhabis)=rs("NumNinos1")
			tninos2(numhabis)=rs("NumNinos2")
			
			'Buscar nomnbre suplementos
			suples=rs("suplementos")
			if suples<>"" then
				TSuples=split(suples,";")
				for s=0 to ubound(TSuples)
					if TSuples(s)<>"" then
						Supleh(numhabis)=TSuples(s)
					end if
				next 
			end if
			
			rs.movenext
		loop
		rs.close
	
		texto=plantilla 'plantilla del voucher
		texto=Replace(texto, "Vte=lang","es") 
		texto=Replace(texto, "Vte=titulopagina","Reserva") 
		'datos hotel
		texto=Replace(texto, "Vte=nombrehotel",hnombre) 
		texto=Replace(texto, "Vte=direhotel",hdire) 
		texto=Replace(texto, "Vte=poblahotel",hpobla) 
		texto=Replace(texto, "Vte=cphotel",hcp) 
		texto=Replace(texto, "Vte=telehotel",htele) 
		texto=Replace(texto, "Vte=emailhotel","<a href='mailto:" & mailhotel & "'>" & mailhotel & "</a>") 
		
		'Datos Reserva
		texto=Replace(texto, "Vte=i_datosreserva","Datos reserva") 
		texto=Replace(texto, "Vte=i_codres","Nº Reserva") 
		texto=Replace(texto, "Vte=codigoreserva",codres) 
		texto=Replace(texto, "Vte=i_fechas","Fechas") 
		texto=Replace(texto, "Vte=i_fechallegada","Llegada") 
		texto=Replace(texto, "Vte=i_fechasalida","Salida") 
		texto=Replace(texto, "Vte=fini",fini) 
		texto=Replace(texto, "Vte=ffin",ffin) 
		texto=Replace(texto, "Vte=i_noches","Nº noches") 
		texto=Replace(texto, "Vte=numnoches",ndias) 
		
		texto=Replace(texto, "Vte=i_habitacion","Tipo habitación") 
		'habitaciones
		textohab=""
		if numhabis<>0 then
			for h=1 to numhabis
				textohab=textohab & nombreh(h)
				hay=false
				if haysuples then
					for s=0 to ubound(RegSuples,2)
						if RegSuples(SCodi,s)=clng(supleh(h)) then
							 textohab=textohab & "  - " & RegSuples(SNombre,s) & "<br/>"
							 hay=true
						end if
					next
				end if
				if not hay then textohab=textohab & "<br/>"
				if tadultos(h)<>0 then textohab=textohab & RegColec(NColec,0) & ":" & tadultos(h) & vbcrlf
				if tbebes(h)<>0 then textohab=textohab & " - Beb&eacute;s" & tbebes(h) & vbcrlf
				if tninos1(h)<>0 then textohab=textohab & " - " & RegColec(NColec,1) & ":" & tninos1(h) & vbcrlf
				if tninos2(h)<>0 then textohab=textohab & " - " & RegColec(NColec,2) & ":" & tninos2(h) & vbcrlf
				textohab=textohab & "<br/><br/>"
			next
		end if
		texto=Replace(texto, "Vte=habitaciones",textohab) 
		
		texto=Replace(texto, "Vte=i_total","Total")
		texto=Replace(texto, "Vte=total","<b>" & formatnumber(pelas+dtooferta,2) & "&nbsp;&euro;</b>")
		texto=Replace(texto, "Vte=i_oferta","Oferta")
		texto=Replace(texto, "Vte=oferta","<b>" & formatnumber(dtooferta*(-1),2) & "&nbsp;&euro;</b>")
		texto=Replace(texto, "Vte=i_precio","Precio")
		texto=Replace(texto, "Vte=precio","<b>" & formatnumber(pelas,2) & "&nbsp;&euro;</b>")
		texto=Replace(texto, "Vte=i_adelantado","Pago adelantado")
		texto=Replace(texto, "Vte=adelantado","<b>" & formatnumber(prepago,2) & "&nbsp;&euro;</b>")
		texto=Replace(texto, "Vte=i_pagohotel","Pago en el hotel")
		texto=Replace(texto, "Vte=pagohotel","<b>" & formatnumber(pelas-prepago,2) & "&nbsp;&euro;</b>")

		'Datos personales
		texto=Replace(texto, "Vte=i_datospersonales","Datos Personales") 
		texto=Replace(texto, "Vte=i_nombre","Nombre") 
		texto=Replace(texto, "Vte=nombrecliente",apellidos & ", " & nombre) 
		texto=Replace(texto, "Vte=i_direccion","Direcci&oacute;n") 
		texto=Replace(texto, "Vte=direcliente",direccion) 
		texto=Replace(texto, "Vte=i_poblacion","Localidad") 
		texto=Replace(texto, "Vte=poblacliente",poblacion) 
		texto=Replace(texto, "Vte=i_provincia","Provincia") 
		texto=Replace(texto, "Vte=provicliente",provincia) 
		texto=Replace(texto, "Vte=i_cp","C.P.") 
		texto=Replace(texto, "Vte=cpcliente",cp) 
		texto=Replace(texto, "Vte=i_pais","Pa&iacute;s") 
		texto=Replace(texto, "Vte=paiscliente",pais) 
		texto=Replace(texto, "Vte=i_telefono","Tel&eacute;fono")
		texto=Replace(texto, "Vte=telecliente",telefono) 
		texto=Replace(texto, "Vte=i_email","EMail")
		texto=Replace(texto, "Vte=emailcliente",email)
		texto=Replace(texto, "Vte=i_comentarios","Comentarios")
		texto=Replace(texto, "Vte=comentarios",obs)
		texto=Replace(texto, "Vte=politicahotel","") 
			
			
end if 'hayhotel
set rs=nothing
base.close
set base=nothing
response.write texto
%>
