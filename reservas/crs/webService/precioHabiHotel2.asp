<%
	precioHabi=0
	precioDia=0
	PrecioPerso=false
	cs="SELECT Preprebase,Preperhab FROM TipoHabitaPrecios "
	cs=cs & "WHERE IdHabita=" & RegTipoHab(HabCodi,hab) & " AND Temporada=" & CodTem
	'response.write cs
	rs.open cs,base
	if not rs.eof then 'Esa temporada
		precioDia=rs("Preprebase")
		if not rs("Preperhab") then 'precio por persona
			PrecioHabi=redondear((rs("Preprebase")*plazas))
			PrecioPerso=true
		else 'por hab.
			PrecioHabi=rs("Preprebase")
			PrecioPerso=false
		end if
	end if
	rs.close

%>