<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")

modo=request.QueryString("modo")
	MiId=request.form("id")
	titulo_es=QuitarApos(request.form("titulo_es"))
	titulo_it=QuitarApos(request.form("titulo_it"))
	titulo_en=QuitarApos(request.form("titulo_en"))
	titulo_de=QuitarApos(request.form("titulo_de"))
	titulo_fr=QuitarApos(request.form("titulo_fr"))
	nombre_es=QuitarApos(request.form("nombre_es"))
	nombre_it=QuitarApos(request.form("nombre_it"))
	nombre_en=QuitarApos(request.form("nombre_en"))
	nombre_de=QuitarApos(request.form("nombre_de"))
	nombre_fr=QuitarApos(request.form("nombre_fr"))
	aplicar=request.form("aplicar")
	faplicar=0 'request.form("faplicar")
	habi=clng("0" & request.form("habi"))
	suple=clng("0" & request.form("suple"))
	colec=clng("0" & request.form("colectivo"))
	noches=QuitarComa(request.form("noches"))
	dto=QuitarComa(request.form("dto"))
	precio=QuitarComa(request.form("precio"))
	nochesgratis=QuitarComa(request.form("nochesgratis"))
	destacada=request.form("destacada")
	if destacada="" then destacada=0
	calcula=request.form("calcula")
	if calcula="" then calcula=0
	activa=request.form("activa")
	if activa="" then activa=0
	diasemana=request.form("L")
	diasemana=diasemana & request.form("M")
	diasemana=diasemana & request.form("X")
	diasemana=diasemana & request.form("J")
	diasemana=diasemana & request.form("V")
	diasemana=diasemana & request.form("S")
	diasemana=diasemana & request.form("D")
	fini=request.form("fini")
	ffin=request.form("ffin")
	if not isdate(fini) or not isdate(ffin) then
		errorfecha="Fechas Incorrectas"
	end if
	fcaduca=request.form("fcaduca")
	if not isdate(fcaduca) then fcaduca=ffin
		
	select case modo 
		case "nuevo" 'Añadir
			
			'Añadir
			cs="INSERT INTO " & precrs & "OfertasVIP (Titulo_es,Titulo_it,Titulo_en,Titulo_de,Titulo_fr,"
			cs=cs & "Texto1_es,Texto1_it,Texto1_en,Texto1_de,"
			cs=cs & "Texto1_fr,PorPersona,"
			cs=cs & "FechaInicio,FechaFin,TotalNoches,Dto,"
			cs=cs & "Destacada,Calcula,Activa,Caduca) VALUES ('"
			cs=cs & titulo_es & "','" & titulo_it & "','" & titulo_en & "','" & titulo_de & "','" & titulo_fr & "','"
			cs=cs & nombre_es & "','" & nombre_it & "','" & nombre_en & "','" & nombre_de & "','"
			cs=cs & nombre_fr & "',1,"
			cs=cs & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
			cs=cs & noches & "," & dto & ","
			cs=cs & destacada & "," & calcula & "," & activa
			cs=cs & "," & FechaMySQL(fcaduca) & ")"
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			'Actualiza Nombres
			cs="UPDATE " & precrs & "OfertasVIP SET "
			cs=cs & "Titulo_es='" & titulo_es & "',"
			cs=cs & "Titulo_it='" & titulo_it & "',"
			cs=cs & "Titulo_en='" & titulo_en & "',"
			cs=cs & "Titulo_de='" & titulo_de & "',"
			cs=cs & "Titulo_fr='" & titulo_fr & "',"
			cs=cs & "Texto1_es='" & nombre_es & "',"
			cs=cs & "Texto1_it='" & nombre_it & "',"
			cs=cs & "Texto1_en='" & nombre_en & "',"
			cs=cs & "Texto1_de='" & nombre_de & "',"
			cs=cs & "Texto1_fr='" & nombre_fr & "',"
			cs=cs & "FechaInicio=" & FechaMySQL(fini) & ","
			cs=cs & "FechaFin=" & FechaMySQL(ffin) & ","
			cs=cs & "Caduca=" & FechaMySQL(fcaduca) & ","
			cs=cs & "TotalNoches=" & noches & ","
			cs=cs & "Destacada=" & destacada & ","
			cs=cs & "Calcula=" & calcula & ","
			cs=cs & "Activa=" & activa & ","
			cs=cs & "Dto=" & dto & " "
			'cs=cs & "FechaReserva=" & faplicar & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
	
			
	end select

	pasalir=1

end if

%>