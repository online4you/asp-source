<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")


modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM TipoReserva WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "IdReserva=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			'Borrar Reserva
			cs="DELETE FROM Reservas WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "Cod_res=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			
		end if
		
	
	case "actu"
		MiId=request.form("id")
		activa=request.form("activa")
		tpelas=QuitarComaMiles(request.form("importe"))
		prepago=QuitarComaMiles(request.form("prepago"))
		obs=QuitarApos(request.form("obs"))

		'Reservas
		cs="UPDATE Reservas SET "
		cs=cs & "Activa=" & activa & ","
		cs=cs & "Importe=" & tpelas & ","
		cs=cs & "ImportePag=" & prepago & ","
		cs=cs & "Comentarios='" & obs & "' "
		cs=cs & "WHERE Cod_res=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		
		'Actualizar los datos de la ficha
		apellidos=QuitarApos(request.form("apellidos"))
		nombre=QuitarApos(request.form("nombre"))
		direccion=QuitarApos(request.form("direccion"))
		cp=QuitarApos(request.form("cp"))
		poblacion=QuitarApos(request.form("poblacion"))
		provincia=QuitarApos(request.form("provincia"))
		pais=QuitarApos(request.form("pais"))
		telefono=QuitarApos(request.form("telefono"))
		fax=QuitarApos(request.form("fax"))
		email=QuitarApos(request.form("email"))
		
		cs="UPDATE Fichas SET Apellidos='" & apellidos & "',"
		cs=cs & "Nombre='" & nombre & "',"
		cs=cs & "Direccion='" & direccion & "',"
		cs=cs & "CP='" & cp & "',"
		cs=cs & "Poblacion='" & poblacion & "',"
		cs=cs & "Provincia='" & provincia & "',"
		cs=cs & "NombrePais='" & pais & "',"
		cs=cs & "Telefono='" & telefono & "',"
		cs=cs & "Fax='" & fax & "',"
		cs=cs & "EMail='" & email & "' "
		cs=cs & "WHERE CodReserva=" & MiId
		base.execute cs
	
end select

	pasalir=1

end if

%>