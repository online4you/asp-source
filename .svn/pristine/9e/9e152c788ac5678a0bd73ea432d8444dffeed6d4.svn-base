<%
if request.form<>"" then 'Actualizar

	modo=request.QueryString("modo")
	MiId=request.form("id")
	codpromocion=QuitarApos(request.form("codpromocion"))
	
	titulo=QuitarApos(request.form("titulo_" & langPorDefecto))
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("titulo_" & listaIdiomas(idi)))
	next 'idi

	texto=QuitarApos(request.form("texto_" & langPorDefecto))
	redim TexIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TexIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi

	aplicar=request.form("aplicar")
	faplicar=request.form("faplicar")
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
	hoteles=request.form("hoteles")
	if hoteles<>"" then hoteles=hoteles & ", "
	'response.write "Hoteles:" & hoteles & "<br>"
	ofertasuple=paClng(request.form("ofertasuple"))
	select case modo 
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
				
			'Añadir
			cs="INSERT INTO " & precrs & "OfertasVIP (Titulo,Texto,AplicarEn,IdHabitacion,CodigoSuple,PorPersona,"
			cs=cs & "Colectivo,FechaInicio,FechaFin,TotalNoches,Dto,Precio,"
			cs=cs & "DiasSemana,Destacada,NochesGratis,Calcula,Activa,Caduca,CodigoPromocion,Hoteles,OfertaRegimen) VALUES ('"
			cs=cs & titulo & "','" & texto & "'," & aplicar & "," & habi & "," & suple & ",1,"
			cs=cs & colec & "," & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
			cs=cs & noches & "," & dto & "," & precio & ",'"
			cs=cs & diasemana & "'," & destacada & "," & nochesgratis & "," & calcula & "," & activa
			cs=cs & "," & FechaMySQL(fcaduca) & ",'" & codpromocion & "','" & hoteles & "'," & ofertasuple & ")"
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Busxcar la ultima Id
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "OfertasVIP"
			rs.open cs,base
			laUlti=0
			if not rs.eof then
				laulti=paClng(rs("ulti"))
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
					cs=cs & laulti & ",'" & listaIdiomas(idi) & "','OfertasVIP','Titulo','"
					cs=cs & TIdiomas(idi) & "'," & est & ")"
					base.execute cs
				end if
				if TexIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
					cs=cs & laulti & ",'" & listaIdiomas(idi) & "','OfertasVIP','Texto','"
					cs=cs & TexIdiomas(idi) & "'," & est & ")"
					base.execute cs
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
		case "actu"
			on error resume next
			base.BeginTrans
				
			'Actualiza Nombres
			cs="UPDATE " & precrs & "OfertasVIP SET "
			cs=cs & "CodigoPromocion='" & codpromocion & "',"
			cs=cs & "Titulo='" & titulo & "',"
			cs=cs & "Texto='" & Texto & "',"
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
			cs=cs & "Hoteles='" & hoteles & "',"
			cs=cs & "Destacada=" & destacada & ","
			cs=cs & "Calcula=" & calcula & ","
			cs=cs & "Activa=" & activa & ","
			cs=cs & "Dto=" & dto & ","
			cs=cs & "Precio=" & precio & ","
			cs=cs & "OfertaRegimen=" & ofertasuple & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
	
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='OfertasVIP' AND Campo='Titulo' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','OfertasVIP','Titulo','"
						cs=cs & TIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='OfertasVIP' AND Campo='Titulo' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
				end if
				
				if TexIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='OfertasVIP' AND Campo='Texto' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TexIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','OfertasVIP','Texto','"
						cs=cs & TexIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='OfertasVIP' AND Campo='Texto' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
				end if
				
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
	end select

	pasalir=1

end if

%>