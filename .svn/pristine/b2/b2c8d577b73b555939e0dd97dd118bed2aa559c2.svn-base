<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Datos del form
	boton=QuitarApos(request.form("boton"))
	descripcion=QuitarApos(request.form("descripcion"))
	ayuda=QuitarApos(request.form("ayuda"))
	programa=QuitarApos(request.form("programa"))
	orden=paClng(request.form("orden"))

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
				cs="DELETE FROM " & precrs & "Aplicaciones WHERE " & cadena
				base.execute cs
				
			end if
		
		case "actu"
			cs="UPDATE " & precrs & "Aplicaciones SET "
			cs=cs & "NombreBoton='" & boton & "',"
			cs=cs & "Descripcion='" & descripcion & "',"
			cs=cs & "Programa='" & programa & "',"
			cs=cs & "Ayuda='" & ayuda & "',"
			cs=cs & "Orden=" & orden & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			cs="INSERT INTO " & precrs & "Aplicaciones (IdModulo,NombreBoton,Descripcion,Programa,Ayuda,Orden) VALUES ("
			cs=cs & idm & ",'"
			cs=cs & boton & "','" & descripcion & "','" & programa & "','"
			cs=cs & ayuda & "'," & orden & ")"
			base.execute cs
			
	end select
	pasalir=1

end if

%>