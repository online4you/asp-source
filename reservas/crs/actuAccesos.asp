<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	select case modo
		case "borra"
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cadena=""
				for t=0 to ubound(queborro)
					cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
				next
				if right(cadena,4)=" OR " then 'Quitar el ultimo operador
					cadena=left(cadena,len(cadena)-4)
				end if	
				'Borrar en Usuaris
				cs="DELETE FROM " & precrsgen & "usuarios WHERE " & cadena
				base.execute cs
				
				'Borrar en permisos
				cadena=replace(cadena,"Id=","IdUsuario=")
				cs="DELETE FROM " & precrsgen & "permisosporesta WHERE " & cadena
				base.execute cs
			end if
		
		case "actu"
			nombre=QuitarApos(request.form("nombre"))
			nick=QuitarApos(request.form("nick"))
			pass=QuitarApos(request.form("pass"))
			nivel=request.form("nivel")
			cs="UPDATE " & precrsgen & "usuarios SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Usuario='" & nick & "',"
			cs=cs & "Clave='" & pass & "',"
			cs=cs & "Nivel=" & nivel & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			nombre=QuitarApos(request.form("nombre"))
			nick=QuitarApos(request.form("nick"))
			pass=QuitarApos(request.form("pass"))
			nivel=request.form("nivel")
			cs="INSERT INTO " & precrs & "usuarios (Usuario,Clave,Nombre,Nivel,IdEmpresa) VALUES ('"
			cs=cs & nick & "','" & pass & "','" & nombre & "'," & nivel & "," & clng("0" & request.Cookies("IdEmpresa")) & ")"
			base.execute cs
			
			'Buscar el ult. registro
			cs="SELECT MAX(Id) as Ultimo FROM " & precrs & "usuarios"
			rs.open cs,base
			if not rs.eof then
				laid=rs("Ultimo")
			end if
			rs.close
			
	end select
	pasalir=1

end if

%>