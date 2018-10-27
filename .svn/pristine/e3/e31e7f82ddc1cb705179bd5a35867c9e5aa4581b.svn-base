<!--#include file="includes/claseUpload.asp"-->
<%
modo=request.QueryString("modo")
if modo<>"" then 'Actualizar

	Set objUpload = new clsUpload
	if objUpload.Loaded then 'cargado correctamente

		caracter=QuitarApos(objUpload.getForm("nombre_" & langPorDefecto))
		orden=paClng(objUpload.getForm("orden"))
		destacada=paClng(objUpload.getForm("destacada"))
		idgrupo=paClng(objUpload.getForm("IdGrupo"))
		icono=objUpload.getFile("icono")
		
		redim TIdiomas(ubound(ListaIdiomas))
		for idi=1 to ubound(ListaIdiomas)
			TIdiomas(idi)=QuitarApos(objUpload.getForm("nombre_" & listaIdiomas(idi)))
		next 'idi
		MiId=objUpload.getForm("id")
		
		'Guarda icono
		guena=objUpload.saveFiles(rutaFotos) 'sobreescribe

	end if 'loaded
	set objUpload=nothing
	
		
	select case modo 
		
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
			
			'Añadir
			cs="INSERT INTO " & precrs & "Caracteristicas (Caracteristica,Orden,Icono,Destacada,IdGrupo) VALUES ('"
			cs=cs & caracter & "'," & orden & ",'" & icono & "'," & destacada & "," & idgrupo & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			'response.write cs & "<br>"
			
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Caracteristicas"
			rs.open cs,base
			if not rs.eof then
				MiId=rs("Ulti")
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Caracteristicas','Caracteristica','"
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
			cs="UPDATE " & precrs & "Caracteristicas SET "
			cs=cs & "Caracteristica='" & caracter & "',"
			if icono<>"" then
				cs=cs & "Icono='" & icono & "',"
			end if
			cs=cs & "Orden=" & orden & ","
			cs=cs & "IdGrupo=" & idgrupo & ","
			cs=cs & "Destacada=" & destacada & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			'response.write cs & "<br>"
			controlRegistro(cs) 'guarda seguimiento
	
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='Caracteristicas' AND Campo='Caracteristica' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','Caracteristicas','Caracteristica','"
						cs=cs & TIdiomas(idi) & "')"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='Caracteristicas' AND Campo='Caracteristica' "
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