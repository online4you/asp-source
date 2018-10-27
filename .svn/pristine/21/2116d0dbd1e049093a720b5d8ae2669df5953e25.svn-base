<%
if request.form<>"" then 'Actualizar
	'valores form
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	desde=request.form("desde")
	hasta=request.form("hasta")
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi

	modo=request.QueryString("modo")
	select case modo 
		case "actu"
			MiId=request.form("id")
			
			'Actualiza Desde-Hasta
			cs="UPDATE " & precrs & "Colectivos SET "
			cs=cs & "DesdeEdad=" & desde & ", "
			cs=cs & "HastaEdad=" & hasta & " "
			cs=cs & "WHERE CodigoColec=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Colectivos SET "
			cs=cs & "Nombre='" & nombre & "' "
			cs=cs & "WHERE CodigoColec=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='Colectivos' AND Campo='Nombre' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Colectivos','Nombre','"
						cs=cs & TIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='Colectivos' AND Campo='Nombre' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
					
				end if
			next 'idi

			
	end select
	pasalir=1
end if 'form<>""
%>