
<%
modo=request.QueryString("modo")
url = "http://www.online4you.es/templates/photel/custom/httpFunctions.php?toCmd=setPromotions(" & est & "," & MiId & ")" 
aplicar= request.QueryString("aplicar")
response.write aplicar
if modo<>"" then	

	Set objUpload = new clsUpload
	
	if objUpload.Loaded then 'cargado correctamente
		MiId=objUpload.getForm("id")
		codpromocion=QuitarApos(objUpload.getForm("codpromocion"))
		CodigoOferta=QuitarApos(objUpload.getForm("CodigoOferta"))
		
		titulo=QuitarApos(objUpload.getForm("titulo_" & langPorDefecto))
		redim TIdiomas(ubound(ListaIdiomas))
		for idi=1 to ubound(ListaIdiomas)
			TIdiomas(idi)=QuitarApos(objUpload.getForm("titulo_" & listaIdiomas(idi)))
		next 'idi
	
		texto=QuitarApos(objUpload.getForm("texto_" & langPorDefecto))
		redim TexIdiomas(ubound(ListaIdiomas))
		for idi=1 to ubound(ListaIdiomas)
			TexIdiomas(idi)=QuitarApos(objUpload.getForm("texto_" & listaIdiomas(idi)))
		next 'idi
	
		aplicar=objUpload.getForm("aplicar")
		faplicar=objUpload.getForm("faplicar")
		habi=paClng(objUpload.getForm("habi"))
		suple=paClng(objUpload.getForm("suple"))
		colec=paClng(objUpload.getForm("colectivo"))
		noches=QuitarComa(objUpload.getForm("noches"))
		dto=QuitarComa(objUpload.getForm("dto"))
		precio=QuitarComa(objUpload.getForm("precio"))
		nochesgratis=QuitarComa(objUpload.getForm("nochesgratis"))
		diasAdelanto=paClng(objUpload.getForm("diasAdelanto"))
		destacada=objUpload.getForm("destacada")
		if destacada="" then destacada=0
		calcula=objUpload.getForm("calcula")
		if calcula="" then calcula=0
		activa=objUpload.getForm("activa")
		if activa="" then activa=0
		diasemana=objUpload.getForm("L")
		diasemana=diasemana & objUpload.getForm("M")
		diasemana=diasemana & objUpload.getForm("X")
		diasemana=diasemana & objUpload.getForm("J")
		diasemana=diasemana & objUpload.getForm("V")
		diasemana=diasemana & objUpload.getForm("S")
		diasemana=diasemana & objUpload.getForm("D")
		fini=objUpload.getForm("fini")
		ffin=objUpload.getForm("ffin")
		if not isdate(fini) or not isdate(ffin) then
			msgerror="Fechas Incorrectas"
		end if
		fcaduca=objUpload.getForm("fcaduca")
		if not isdate(fcaduca) then fcaduca=ffin
		fvalida=objUpload.getForm("fvalida")
		if not isdate(fvalida) then fvalida=date
		
		set baseCR=server.createobject("ADODB.Connection")
		baseCR.Open ConectaMDB
	
		'Comprobar si tienen diferentes tamaños de fotos
		cs="SELECT Ancho,Alto,Prefijo,ProporcionAncho FROM " & precrsgen & "sizegraficos WHERE IdEmpresa=" & idempresa
		cs=cs & " ORDER BY Ancho DESC"
		rs.open cs,baseCR
		haySize=false
		if not rs.eof then
			RegSize=rs.getrows
			RegAncho=0
			RegAlto=1
			RegPrefi=2
			RegPAncho=3
			haySize=true
		end if
		rs.close
		
		baseCR.close
		set baseCR=nothing
		
		filefoto=false
		
		for each miFoto in objUpload.Files
			foto=miFoto.FileName
			'Añadir la id hotel al nombre de la foto
			sufijo="_" & miId
			if sufijo="_0" then 'buscar id nueva está añadiendo hotel
				cs="SELECT MAX(CodigoEsta) as Ulti FROM " & precrs & "Establecimientos "
				rs.open cs,base
				if not rs.eof then
					sufijo="_" & paClng(rs("ulti"))+1
				end if
				rs.close
			end if
			foto=replace(foto,"." & laExtension(foto),sufijo & "." & laExtension(foto))
			foto=transformaURL(foto)
			if objUpload.saveAs(miFoto,server.MapPath(rutafotos & foto)) then 'ha grabado bien
				filefoto=true
				if haySize then 'hay que redimensionar las fotos
					original=server.MapPath(rutafotos & foto)
					'response.write original
					for sz=0 to ubound(RegSize,2)
						alto=0
						ancho=0
						if RegSize(RegPAncho,sz) then 'mantener el ancho
							ancho=RegSize(RegAncho,sz)
						else 'mantener el alto
							alto=RegSize(RegAlto,sz)
						end if 'proporcion
						guena=objUpload.ReSizeImg(original,trim(RegSize(RegPrefi,sz)),ancho,alto)
					next 'sz
				end if 'haySize
			end if 'grabado
		next 'los files

	
	end if
	set objUpload=nothing
	
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
				response.write cs & "<br>"
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
	url = "http://www.online4you.es/templates/photel/custom/httpFunctions.php?toCmd=setPromotions(" & est & "," & MiId & ")" 
	set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
	xmlhttp.open "GET", url, false 
	xmlhttp.send "" 
	'Response.write xmlhttp.responseText 
set xmlhttp = nothing 

end if 'modo


%>