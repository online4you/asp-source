<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Datos del form
	modulo=QuitarApos(request.form("modulo"))
	descripcion=QuitarApos(request.form("descripcion"))
	programa=QuitarApos(request.form("programa"))
	orden=paClng(request.form("orden"))
	menu=request.form("menu")
	if menu="" then menu=0
	superior=paClng(request.form("superior"))

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
				'Borrar
				cs="DELETE FROM " & precrsgen & "modulos WHERE " & cadena
				base.execute cs
				'Borrar en aplicaciones
				cadena=replace(cadena,"Id=","IdModulo=")
				cs="DELETE FROM " & precrsgen & "aplicaciones WHERE " & cadena
				base.execute cs
				
			end if
		
		case "actu"
			cs="UPDATE " & precrsgen & "modulos SET "
			cs=cs & "Modulo='" & modulo & "',"
			cs=cs & "Descripcion='" & descripcion & "',"
			cs=cs & "Programa='" & programa & "',"
			cs=cs & "Orden=" & orden & ","
			cs=cs & "Menu=" & menu & ","
			cs=cs & "ModuloSuperior=" & superior & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			cs="INSERT INTO " & precrsgen & "modulos (Modulo,Descripcion,Programa,Orden,Menu,ModuloSuperior) VALUES ('"
			cs=cs & modulo & "','" & descripcion & "','" & programa & "'," & orden & ","
			cs=cs & menu & "," & superior & ")"
			base.execute cs
			
	end select
	pasalir=1

end if

%>