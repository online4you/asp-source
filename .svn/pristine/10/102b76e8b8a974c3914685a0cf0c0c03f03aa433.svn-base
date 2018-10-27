<%
IdAlta=0
if request.form<>"" and request.QueryString("modo")<>"" then 'Actualizar

	modo=request.QueryString("modo")
	MiId=request.form("id")
	
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi

	texto=QuitarApos(request.form("texto_" & langPorDefecto))
	redim TexIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TexIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi
	
	url=quitarApos(request.form("url"))
	codigoesta=request.form("codigoesta")
	activo=paClng(request.form("activo"))
	orden=paClng(request.form("orden"))
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "Id=" & trim(queborro(t)) & " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				
				base.execute "DELETE FROM " & precrs & "ServiciosExtras " & cs
				controlRegistro("DELETE FROM " & precrs & "ServiciosExtras " & cs) 'guarda seguimiento
				'Borrar precios servicios
				cs=replace(cs,"Id=","IdServicio=")
				base.execute "DELETE FROM " & precrs & "ServiciosPrecios " & cs
			end if
			
		case "nuevo" 'Añadir
			cs="INSERT INTO " & precrs & "ServiciosExtras (CodigoEsta,Nombre,URL,Activo,Texto,Orden) VALUES ("
			cs=cs & codigoesta & ",'" & nombre & "','" & url & "'," & activo & ",'"
			cs=cs & texto & "'," & orden & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Busco el id de la ult. servicio
			cs="SELECT MAX(Id) as Maxima FROM " & precrs & "ServiciosExtras"
			rs.open cs,base
			if not rs.eof then
				IdAlta=paClng(rs("maxima"))
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
					cs=cs & IdAlta & ",'" & listaIdiomas(idi) & "','ServiciosExtras','Nombre','"
					cs=cs & TIdiomas(idi) & "'," & codigoesta & ")"
					base.execute cs
				end if
				if TexIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
					cs=cs & IdAlta & ",'" & listaIdiomas(idi) & "','ServiciosExtras','Texto','"
					cs=cs & TexIdiomas(idi) & "'," & codigoesta & ")"
					base.execute cs
				end if
			next 'idi
			
			
		case "actu"
			cs="UPDATE " & precrs & "ServiciosExtras SET "
			cs=cs & "CodigoEsta=" & codigoesta & ","
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Texto='" & texto & "',"
			cs=cs & "URL='" & url & "',"
			cs=cs & "Activo=" & activo & ","
			cs=cs & "Orden=" & orden & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write "cs: " & cs & "<br>"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='ServiciosExtras' AND Campo='Nombre' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','ServiciosExtras','Nombre','"
						cs=cs & TIdiomas(idi) & "'," & codigoesta & ")"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='ServiciosExtras' AND Campo='Nombre' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
				end if
				
				if TexIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='ServiciosExtras' AND Campo='Texto' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TexIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','ServiciosExtras','Texto','"
						cs=cs & TexIdiomas(idi) & "'," & codigoesta & ")"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='ServiciosExtras' AND Campo='Texto' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
				end if
				
			next 'idi

			
			
	end select
	pasalir=1

end if

%>