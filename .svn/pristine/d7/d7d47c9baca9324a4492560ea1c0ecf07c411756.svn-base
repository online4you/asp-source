<%
modo=request.QueryString("modo")
if modo<>"" then 'Actualizar
est=request.QueryString("est")


	Set Upload = Server.CreateObject("Persits.Upload.1")
	Upload.SaveToMemory

	MiId=upload.form("id")
	titulo_es=QuitarApos(upload.form("titulo_es"))
	titulo_it=QuitarApos(upload.form("titulo_it"))
	titulo_en=QuitarApos(upload.form("titulo_en"))
	titulo_de=QuitarApos(upload.form("titulo_de"))
	titulo_fr=QuitarApos(upload.form("titulo_fr"))
	nombre_es=QuitarApos(upload.form("nombre_es"))
	nombre_it=QuitarApos(upload.form("nombre_it"))
	nombre_en=QuitarApos(upload.form("nombre_en"))
	nombre_de=QuitarApos(upload.form("nombre_de"))
	nombre_fr=QuitarApos(upload.form("nombre_fr"))
	aplicar=upload.form("aplicar")
	faplicar=upload.form("faplicar")
	habi=clng("0" & upload.form("habi"))
	suple=clng("0" & upload.form("suple"))
	colec=clng("0" & upload.form("colectivo"))
	noches=QuitarComa(upload.form("noches"))
	dto=QuitarComa(upload.form("dto"))
	precio=QuitarComa(upload.form("precio"))
	nochesgratis=QuitarComa(upload.form("nochesgratis"))
	destacada=upload.form("destacada")
	if destacada="" then destacada=0
	calcula=upload.form("calcula")
	if calcula="" then calcula=0
	activa=upload.form("activa")
	if activa="" then activa=0
	diasemana=upload.form("L")
	diasemana=diasemana & upload.form("M")
	diasemana=diasemana & upload.form("X")
	diasemana=diasemana & upload.form("J")
	diasemana=diasemana & upload.form("V")
	diasemana=diasemana & upload.form("S")
	diasemana=diasemana & upload.form("D")
	fini=upload.form("fini")
	ffin=upload.form("ffin")
	if not isdate(fini) or not isdate(ffin) then
		errorfecha="Fechas Incorrectas"
	end if
	fcaduca=upload.form("caduca")
	if not isdate(fcaduca) then fcaduca=ffin
	
	Set File = Upload.Files("foto1")
	filefoto=false
	If Not File Is Nothing Then
		foto=SoloElFichero(file.Path)
		file.saveAs(server.MapPath(rutaFotos) & "\" & foto)
		filefoto=true
	end if
	set file=nothing
	set upload=nothing
		
	select case modo 
		case "nuevo" 'Añadir
			
			'Añadir
			cs="INSERT INTO " & precrs & "Ofertas (Titulo_es,Titulo_it,Titulo_en,Titulo_de,Titulo_fr,"
			cs=cs & "Texto1_es,Texto1_it,Texto1_en,Texto1_de,"
			cs=cs & "Texto1_fr,CodigoEsta,AplicarEn,IdHabitacion,CodigoSuple,PorPersona,"
			cs=cs & "Colectivo,FechaInicio,FechaFin,TotalNoches,Dto,Precio,"
			cs=cs & "DiasSemana,Destacada,NochesGratis,Calcula,Activa,Caduca,foto1) VALUES ('"
			cs=cs & titulo_es & "','" & titulo_it & "','" & titulo_en & "','" & titulo_de & "','" & titulo_fr & "','"
			cs=cs & nombre_es & "','" & nombre_it & "','" & nombre_en & "','" & nombre_de & "','"
			cs=cs & nombre_fr & "'," & est & "," & aplicar & "," & habi & "," & suple & ",1,"
			cs=cs & colec & "," & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
			cs=cs & noches & "," & dto & "," & precio & ",'"
			cs=cs & diasemana & "'," & destacada & "," & nochesgratis & "," & calcula & "," & activa
			cs=cs & "," & FechaMySQL(fcaduca) &  ",'" & foto & "')"
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Ofertas SET "
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
			cs=cs & "AplicarEn=" & aplicar & ","
			cs=cs & "IdHabitacion=" & habi & ","
			cs=cs & "CodigoSuple=" & suple & ","
			cs=cs & "Colectivo=" & colec & ","
			cs=cs & "TotalNoches=" & noches & ","
			cs=cs & "NochesGratis=" & nochesgratis & ","
			cs=cs & "DiasSemana='" & diasemana & "',"
			cs=cs & "Destacada=" & destacada & ","
			cs=cs & "Calcula=" & calcula & ","
			cs=cs & "Activa=" & activa & ","
			cs=cs & "Dto=" & dto & ","
			if filefoto then 
				cs=cs & "Foto1='" & foto & "', "
			end if
			cs=cs & "Precio=" & precio & " "
			
			'cs=cs & "FechaReserva=" & faplicar & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
	
			
	end select

	pasalir=1

end if

%>