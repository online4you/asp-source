<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")

	codigoesta=request.form("codigoesta")
	idficha=paClng(request.form("idficha"))
	fecha=request.form("fecha")
	codreserva=paClng(request.form("codreserva"))
	noches=paClng(request.form("noches"))
	habitacion=paClng(request.form("habitacion"))
	pax=paClng(request.form("pax"))
	obs=quitarApos(request.form("obs"))
		
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
				cs="DELETE FROM VisitasVIP WHERE " & cadena
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
		
		case "actu"
			cs="UPDATE " & precrs & "VisitasVIP SET "
			cs=cs & "CodigoEsta=" & codigoesta & ","
			cs=cs & "Fecha=" & FechaMySQL(fecha) & ","
			cs=cs & "Noches=" & noches & ","
			cs=cs & "Pax=" & pax & ","
			cs=cs & "Habitacion=" & habitacion & ","
			cs=cs & "CodReserva=" & codreserva & ","
			cs=cs & "Comentario='" & obs & "' "
			cs=cs & "WHERE Id=" & MiId 
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "nuevo"
			cs="INSERT INTO " & precrs & "VisitasVIP (CodigoEsta,IdFicha,Fecha,Noches,Pax,Habitacion,CodReserva,"
			cs=cs & "Comentario) VALUES ("
			cs=cs & codigoesta & "," & idficha & "," & FechaMySQL(fecha) & ","
			cs=cs & noches & "," & pax & "," & habitacion & "," & codreserva & ",'" & obs & "')"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
	pasalir=1

end if

%>