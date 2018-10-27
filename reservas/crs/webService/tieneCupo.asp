<%
tieneCupo=false
gueno=false
'Cupos de la habitacion
cs="SELECT Cupo,Dia FROM Cupos "
cs=cs & "WHERE CodigoHab=" & RegTipoHab(HabCodi,hab) & " AND "
cs=cs & "(Dia BETWEEN " & FechaMySQL(fini) 
cs=cs & " AND " & FechaMySQL(ffin-1) & ")"
rs.open cs,base
'response.write cs & "<br>"
haycupos=false
if not rs.eof then 'Buscar los cupos y la ocupacion
	RegCupos=rs.getrows
	RCCupo=0
	RCDia=1
	haycupos=true
end if
rs.close
if haycupos then 'seguimos
	gueno=true
	'Antes de calcular nada comprueba cupo y ocupacion
	for dia=fini to ffin-1
		'Buscar cupo minimo en esa fechas de esa hab.
		cupo=0
		ocu=0
		for cc=0 to ubound(RegCupos,2)
			if RegCupos(RCDia,cc)=Dia then
				cupo=RegCupos(RCCupo,cc)
			end if
		next 'cc
		if cupo=0 then 'salir y otra hab.
			gueno=false
			exit for
		end if

		'Busco ocupacion
		ocu=0
		cs="SELECT SUM(CuantasHabis) as TotalHabis "
		cs=cs & "FROM TipoReserva INNER JOIN Reservas "
		cs=cs & "ON TipoReserva.IdReserva=Reservas.Cod_res "
		cs=cs & "WHERE Activa<>0 AND "
		cs=cs & "IdTipoHabitacion=" & RegTipoHab(HabCodi,hab) & " AND "
		cs=cs & "(FechaInicio<=" & FechaMySQL(dia) & " AND FechaFinal>" & FechaMySQL(dia) & ")"
		rs.open cs,base
		if not rs.eof then
			ocu=clng("0" & rs("TotalHabis")) 'Nº de hab. ocupadas
			'response.write RegTipoHab(HabNombre,hab) & " - " & dia & " -> Ocu: " & ocu & "<br>"
		end if
		rs.close
		if (cupo-ocu)<1 then 'salimos y a otra hab
			gueno=false
			exit for
		end if

	next 'dia pa ocupacion

end if 'haycupos

tieneCupo=gueno

%>