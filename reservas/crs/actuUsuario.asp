<%
est=request.QueryString("bh")
MiId=clng("0" & request.QueryString("id"))
if est<>"" then 'viene un valor, hay que añadir
	cs="INSERT INTO " & precrsgen & "permisosporesta (IdUsuario,CodigoEsta) VALUES ("
	cs=cs & MiId & "," & est & ")"
	base.execute cs
end if

'Comprobar si hay que borrar permisos de hotel
queborro=split(request.form("elimina"),",")
if ubound(queborro)>=0 then
	cadena="("
	for t=0 to ubound(queborro)
		cadena=cadena & "CodigoEsta=" & trim(queborro(t)) & " OR "
	next
	if right(cadena,4)=" OR " then 'Quitar el ultimo operador
		cadena=left(cadena,len(cadena)-4)
	end if	
	cadena=cadena & ") AND IdUsuario=" & MiId
	'Borrar en permisos hotels
	cs="DELETE FROM " & precrsgen & "permisosporesta WHERE " & cadena
	base.execute cs
end if

pasalir=0
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Datos del form
	nombre=QuitarApos(request.form("nombre"))
	nick=QuitarApos(request.form("nick"))
	pass=QuitarApos(request.form("pass"))
	nivel=paClng(request.form("nivel"))
	activo=paClng(request.form("activo"))

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
				cs="DELETE FROM " & precrs & "usuarios WHERE " & cadena
				base.execute cs
				
				'Borrar en permisos
				cadena=replace(cadena,"Id=","IdUsuario=")
				cs="DELETE FROM " & precrs & "permisosporesta WHERE " & cadena
				base.execute cs
				
			end if
		
		case "actu"
			cs="UPDATE " & precrsgen & "usuarios SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Usuario='" & nick & "',"
			cs=cs & "Clave='" & pass & "',"
			cs=cs & "Nivel=" & nivel & ","
			cs=cs & "Activo=" & activo & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			pasalir=1
			'controlRegistro(cs) 'guarda seguimiento
			
		case "nuevo"
			yaEsta=false
			'Comprobar que no exista esa clave y usuario
			cs="SELECT Id FROM " & precrsgen & "usuarios WHERE Usuario='" & nick & "' AND Clave='" & pass & "'"
			rs.open cs,base
			if not rs.eof then
				yaEsta=true
				msgError="Ya está registrado, pruebe con otro usuario y contraseña"
			end if
			rs.close
			
			if not yaEsta then 'crear nuevo
				cs="INSERT INTO " & precrsgen & "usuarios (Usuario,Clave,Nombre,Nivel,IdEmpresa,Activo) VALUES ('"
				cs=cs & nick & "','" & pass & "','" & nombre & "'," & nivel & "," & IdEmpresa & "," & activo & ")"
				base.execute cs
				'controlRegistro(cs) 'guarda seguimiento
				
				'Buscar el ult. registro
				cs="SELECT MAX(Id) as Ultimo FROM " & precrsgen & "usuarios"
				rs.open cs,base
				if not rs.eof then
					laid=paClng(rs("Ultimo"))
				end if
				rs.close
				
				if nivel<>TAdmin then 'pa poner hoteles
					pasalir=0
				else
					pasalir=1
				end if
			end if 'yaEsta
						
	end select
	
end if

%>