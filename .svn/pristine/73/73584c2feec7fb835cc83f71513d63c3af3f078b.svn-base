<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")

	modo=request.QueryString("modo")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(upload.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "TiposServicio WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
			end if
			
		case "nuevo" 'Añadir
				nombre_es=QuitarApos(upload.form("nombre_es"))
				nombre_it=QuitarApos(upload.form("nombre_it"))
				nombre_en=QuitarApos(upload.form("nombre_en"))
				nombre_de=QuitarApos(upload.form("nombre_de"))
				nombre_fr=QuitarApos(upload.form("nombre_fr"))
				cs="INSERT INTO " & precrs & "TiposServicio (Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr,Foto) VALUES ('"
				cs=cs & nombre_es & "','" & nombre_it & "','" & nombre_en & "','"
				cs=cs & nombre_de & "','" & nombre_fr & "','" & foto & "')"
				'response.write "cs: " & cs & "<br>"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			MiId=upload.form("id")
			nombre_es=QuitarApos(upload.form("nombre_es"))
			nombre_it=QuitarApos(upload.form("nombre_it"))
			nombre_en=QuitarApos(upload.form("nombre_en"))
			nombre_de=QuitarApos(upload.form("nombre_de"))
			nombre_fr=QuitarApos(upload.form("nombre_fr"))
			
			cs="UPDATE " & precrs & "TiposServicio SET "
			if filefoto then
				cs=cs & "Foto='" & foto & "',"
			end if
			cs=cs & "Nombre_es='" & nombre_es & "',"
			cs=cs & "Nombre_it='" & nombre_it & "',"
			cs=cs & "Nombre_en='" & nombre_en & "',"
			cs=cs & "Nombre_de='" & nombre_de & "',"
			cs=cs & "Nombre_fr='" & nombre_fr & "' "
			cs=cs & "WHERE id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select

	pasalir=1

end if

%>