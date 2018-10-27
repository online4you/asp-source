
<%
modo=request.QueryString("modo")

if modo<>"" then	
		MiId=request.QueryString("id")
		codpromocion=QuitarApos(request.QueryString("codpromocion"))
		CodigoOferta=QuitarApos(request.QueryString("CodigoOferta"))
		
		titulo=QuitarApos(request.QueryString("titulo_" & langPorDefecto))
		redim TIdiomas(ubound(ListaIdiomas))
		for idi=1 to ubound(ListaIdiomas)
			TIdiomas(idi)=QuitarApos(request.QueryString("titulo_" & listaIdiomas(idi)))
		next 'idi
	
		texto=QuitarApos(request.QueryString("texto_" & langPorDefecto))
		redim TexIdiomas(ubound(ListaIdiomas))
		for idi=1 to ubound(ListaIdiomas)
			TexIdiomas(idi)=QuitarApos(request.QueryString("texto_" & listaIdiomas(idi)))
		next 'idi
	
		aplicar=request.QueryString("aplicar")
		faplicar=request.QueryString("faplicar")
		habi=paClng(request.QueryString("habi"))
		suple=paClng(request.QueryString("suple"))
		colec=paClng(request.QueryString("colectivo"))
		noches=QuitarComa(request.QueryString("noches"))
		dto=QuitarComa(request.QueryString("dto"))
		precio=QuitarComa(request.QueryString("precio"))
		nochesgratis=QuitarComa(request.QueryString("nochesgratis"))
		diasAdelanto=paClng(request.QueryString("diasAdelanto"))
		destacada=request.QueryString("destacada")
		if destacada="" then destacada=0
		calcula=request.QueryString("calcula")
		if calcula="" then calcula=0
		activa=request.QueryString("activa")
		if activa="" then activa=0
		diasemana=request.QueryString("L")
		diasemana=diasemana & request.QueryString("M")
		diasemana=diasemana & request.QueryString("X")
		diasemana=diasemana & request.QueryString("J")
		diasemana=diasemana & request.QueryString("V")
		diasemana=diasemana & request.QueryString("S")
		diasemana=diasemana & request.QueryString("D")
		fini=request.QueryString("fini")
		ffin=request.QueryString("ffin")
		if not isdate(fini) or not isdate(ffin) then
			msgerror="Fechas Incorrectas"
		end if
		fcaduca=request.QueryString("fcaduca")
		if not isdate(fcaduca) then fcaduca=ffin
		fvalida=request.QueryString("fvalida")
		if not isdate(fvalida) then fvalida=date
	
	if msgerror="" then 'procesar
		select case modo 
			case "nuevo" 'Añadir
				'on error resume next
				base.BeginTrans
					
				'Añadir
				cs="INSERT INTO " & precrs & "Ofertas (Titulo,Texto,CodigoEsta,AplicarEn,IdHabitacion,CodigoSuple,PorPersona,"
				cs=cs & "Colectivo,FechaInicio,FechaFin,TotalNoches,Dto,Precio,DiasAdelanto,"
				cs=cs & "DiasSemana,Destacada,NochesGratis,Calcula,Activa,Caduca,CodigoPromocion,Valida,Foto1,CodigoOferta) VALUES ('"
				cs=cs & titulo & "','" & texto & "'," & est & "," & aplicar & "," & habi & "," & suple & ",1,"
				cs=cs & colec & "," & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
				cs=cs & noches & "," & dto & "," & precio & "," & diasAdelanto & ",'"
				cs=cs & diasemana & "'," & destacada & "," & nochesgratis & "," & calcula & "," & activa
				cs=cs & "," & FechaMySQL(fcaduca) & ",'" & codpromocion & "'," & FechaMySQL(fvalida) & ",'"
				cs=cs & foto & "', '" & CodigoOferta & "')"
				'responseLog(cs)
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
				'Busxcar la ultima Id
				cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Ofertas"
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
						cs=cs & laulti & ",'" & listaIdiomas(idi) & "','Ofertas','Titulo','"
						cs=cs & TIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if
					if TexIdiomas(idi)<>"" then 'crear registro
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & laulti & ",'" & listaIdiomas(idi) & "','Ofertas','Texto','"
						cs=cs & TexIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if
				next 'idi
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
				
			case "actu"
				'on error resume next
				base.BeginTrans
					
				'Actualiza Nombres
				cs="UPDATE " & precrs & "Ofertas SET "
				cs=cs & "CodigoPromocion='" & codpromocion & "',"
				cs=cs & "CodigoOferta='" & CodigoOferta & "',"
				cs=cs & "Titulo='" & titulo & "',"
				cs=cs & "Texto='" & Texto & "',"
				cs=cs & "FechaInicio=" & FechaMySQL(fini) & ","
				cs=cs & "FechaFin=" & FechaMySQL(ffin) & ","
				cs=cs & "Caduca=" & FechaMySQL(fcaduca) & ","
				cs=cs & "Valida=" & FechaMySQL(fvalida) & ","
				cs=cs & "AplicarEn=" & aplicar & ","
				cs=cs & "IdHabitacion=" & habi & ","
				cs=cs & "CodigoSuple=" & suple & ","
				cs=cs & "Colectivo=" & colec & ","
				cs=cs & "TotalNoches=" & noches & ","
				cs=cs & "NochesGratis=" & nochesgratis & ","
				cs=cs & "DiasAdelanto=" & diasAdelanto & ","
				cs=cs & "DiasSemana='" & diasemana & "',"
				cs=cs & "Destacada=" & destacada & ","
				cs=cs & "Calcula=" & calcula & ","
				cs=cs & "Activa=" & activa & ","
				cs=cs & "Dto=" & dto & ","
				if filefoto then 'ha cambiado
					cs=cs & "Foto1='" & foto & "',"
				end if 'filefoto
				cs=cs & "Precio=" & precio & " "
				cs=cs & "WHERE Id=" & MiId
				'response.write cs & "<br>"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
		
				'Actu traduccion
				for idi=1 to ubound(ListaIdiomas)
					if TIdiomas(idi)<>"" then 'buscar si existe
						cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='Ofertas' AND Campo='Titulo' AND "
						cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
						rs.open cs,base
						if not rs.eof then
							cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
							cs=cs & "WHERE Id=" & rs("id")
							base.execute cs
						else
							cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
							cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Ofertas','Titulo','"
							cs=cs & TIdiomas(idi) & "'," & est & ")"
							base.execute cs
						end if 'eof
						rs.close
					else 'borrarlo si esta en blanco
						cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='Ofertas' AND Campo='Titulo' "
						cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
						base.execute cs
					end if
					
					if TexIdiomas(idi)<>"" then 'buscar si existe
						cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='Ofertas' AND Campo='Texto' AND "
						cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
						rs.open cs,base
						if not rs.eof then
							cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TexIdiomas(Idi) & "' "
							cs=cs & "WHERE Id=" & rs("id")
							base.execute cs
						else
							cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
							cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Ofertas','Texto','"
							cs=cs & TexIdiomas(idi) & "'," & est & ")"
							base.execute cs
						end if 'eof
						rs.close
					else 'borrarlo si esta en blanco
						cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='Ofertas' AND Campo='Texto' "
						cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
						base.execute cs
					end if
					
				next 'idi
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
				
		end select
	end if 'msgerror=""
	pasalir=1
	if (split(Request.ServerVariables("SERVER_NAME"),".")(0)="online4youhotels") then
		url = "http://www.online4youhotels.com/templates/photel/custom/httpFunctions.php?toCmd=setPromotions(" & est & "," & MiId & ")" 
	else 
		url = "http://www.book-villa.com/templates/photel/custom/httpFunctions.php?toCmd=setPromotions(" & est & "," & MiId & ")" 
	end if
	set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
	xmlhttp.open "GET", url, false 
	xmlhttp.send "" 
	'Response.write xmlhttp.responseText 
set xmlhttp = nothing 

end if 'modo


%>
