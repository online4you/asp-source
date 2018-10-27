<%
tieneCupo=false
'Cupo
cs="SELECT MIN(Cupo-isnull(confirmadas,0)) as Dispo FROM Disponibles WHERE "
cs=cs & "CodigoHab=" & RegTipoHab(HabCodi,hab)
cs=cs & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin-1)
cs=cs & ")"
rs.Open cs, base
if not rs.eof then
	if PaClng(rs("dispo"))>0 then tieneCupo=true
end if
rs.close

if tieneCupo then 'sigo comprobando
	'Comprobar que no esté parada la venta o minimos
	cs="SELECT MIN(Estado) as mestado,MAX(DiasMinimos) as minimo FROM Cupos "
	cs=cs & "WHERE CodigoHab=" & RegTipoHab(HabCodi,hab)
	cs=cs & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin-1) & ")"
	rs.open cs,base
	if not rs.eof then
		tieneCupo=true
		if paCLng(rs("mestado"))=0 then 'hay paron ventas
			tieneCupo=false
		end if
		if paClng(rs("minimo"))>noches then 'estancia minima
			tieneCupo=false
		end if
	end if 'eof
	rs.close
	
	if tieneCupo then 'comprobar release
		cs="SELECT Dia,Release FROM Cupos "
		cs=cs & "WHERE CodigoHab=" & RegTipoHab(HabCodi,hab)
		cs=cs & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin-1) & ")"
		rs.open cs,base
		tieneCupo=true
		do while not rs.eof
			miRelease=rs("dia")-date()
			'response.write MiRelease & "<br>"
			if paClng(rs("release"))>miRelease then 'release
				tieneCupo=false
				exit do
			end if
			rs.movenext
		loop 'eof
		rs.close
	
	end if 'tieneCupo release
	
end if 'tieneCupo

%>