<%
if request.form<>"" then 'Actualizar
	'valores form
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	IdPadre=paClng(request.form("idpadre"))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi

	modo=request.QueryString("modo")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="("
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				cs=cs & ")"
				
				on error resume next
				base.BeginTrans
				
				base.execute "DELETE FROM " & precrs & "Zonas WHERE " & cs
				controlRegistro("DELETE FROM Zonas WHERE " & cs) 'guarda seguimiento
				
				'Borrar traducciones
				cs=replace(cs,"Id=","IdReferencia=")
				base.execute "DELETE FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='Zonas'"
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
			
			end if
			
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
			
			'Añadir
			cs="INSERT INTO " & precrs & "Zonas (Zona,IdPadre) VALUES ('" & nombre & "'," & IdPadre & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Busxcar la ultima Id
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Zonas"
			rs.open cs,base
			laUlti=0
			if not rs.eof then
				laulti=paClng(rs("ulti"))
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & laulti & ",'" & listaIdiomas(idi) & "','Zonas','Zona','"
					cs=cs & TIdiomas(idi) & "')"
					base.execute cs
					'response.write cs & "<br>"
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
		case "actu"
			MiId=request.form("id")
			
			on error resume next
			base.BeginTrans
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Zonas SET "
			cs=cs & "Zona='" & nombre & "',"
			cs=cs & "IdPadre=" & IdPadre & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='Zonas' AND Campo='Zona' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Zonas','Zona','"
						cs=cs & TIdiomas(idi) & "')"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='Zonas' AND Campo='Zona' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
					
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
	end select
	pasalir=1
end if 'form<>""
%>