<%
modo=request.QueryString("modo")
if modo<>"" then 'Actualizar

	caracter=QuitarApos(request.Form("nombre_" & langPorDefecto))
	orden=paClng(request.Form("orden"))
	destacada=paClng(request.Form("destacada"))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.Form("nombre_" & listaIdiomas(idi)))
	next 'idi
	MiId=request.Form("id")
	
	select case modo 
		
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
			
			'Añadir
			cs="INSERT INTO " & precrs & "GrupoCaracteristicas (Nombre,Orden,Destacada) VALUES ('"
			cs=cs & caracter & "'," & orden & "," & destacada & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			'response.write cs & "<br>"
			
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "GrupoCaracteristicas"
			rs.open cs,base
			if not rs.eof then
				MiId=rs("Ulti")
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & MiId & ",'" & listaIdiomas(idi) & "','GrupoCaracteristicas','Nombre','"
					cs=cs & TIdiomas(idi) & "')"
					base.execute cs
					'response.write cs & "<br>"
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0			
			
			
		case "actu"
			on error resume next
			base.BeginTrans
			'Actualiza Nombres
			cs="UPDATE " & precrs & "GrupoCaracteristicas SET "
			cs=cs & "Nombre='" & caracter & "',"
			cs=cs & "Orden=" & orden & ","
			cs=cs & "Destacada=" & destacada & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			'response.write cs & "<br>"
			controlRegistro(cs) 'guarda seguimiento
	
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='GrupoCaracteristicas' AND Campo='Nombre' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','GrupoCaracteristicas','Nombre','"
						cs=cs & TIdiomas(idi) & "')"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='GrupoCaracteristicas' AND Campo='Nombre' "
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