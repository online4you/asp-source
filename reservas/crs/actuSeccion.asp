<%
if request.form<>"" then 'Actualizar
	'valores form
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	orden=paClng(request.form("orden"))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi

	modo=request.QueryString("modo")
	select case modo 
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
			'Añadir
			cs="INSERT INTO " & precrs & "SeccionesHotel (CodigoEsta,Seccion,Orden) VALUES (" & est & ",'" & nombre & "',"
			cs=cs & orden & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Busxcar la ultima Id
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "SeccionesHotel"
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
					cs=cs & laulti & ",'" & listaIdiomas(idi) & "','SeccionesHotel','Seccion','"
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
			cs="UPDATE " & precrs & "SeccionesHotel SET "
			cs=cs & "Seccion='" & nombre & "',"
			cs=cs & "Orden=" & orden & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='SeccionesHotel' AND Campo='Seccion' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','SeccionesHotel','Seccion','"
						cs=cs & TIdiomas(idi) & "')"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='SeccionesHotel' AND Campo='Seccion' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
					
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
	end select
	response.Cookies("cambioSecci")="1" 'para actualizar la ficha
	pasalir=1
end if 'form<>""
%>