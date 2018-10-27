<%
tieneCupo=false
elCupo=0
'Cupo

cs="SELECT min(cupo-IF(ISNULL(Confirmadas),0,Confirmadas))  dispo FROM "
cs=cs & "(SELECT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM " & precrs & "Cupos Cupos "
cs=cs & " LEFT OUTER JOIN (SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM " & precrs & "TipoReserva TipoReserva "
cs=cs & " INNER JOIN " & precrs & "Reservas Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res and TipoReserva.CodigoEsta=Reservas.CodigoEsta "
cs=cs & " WHERE (Reservas.Activa <> 0 AND Anulada=0) and TipoReserva.CodigoEsta=" & est & " and Reservas.CodigoEsta=" & est & " ) Confirmadas ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio "
cs=cs & " AND Cupos.Dia < Confirmadas.FechaFinal and confirmadas.CodigoEsta=" & est & "  where Cupos.CodigoEsta=" & est & "  GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia) Disponibles "
cs=cs & " WHERE CodigoEsta=" & est & " and "
cs=cs & "CodigoHab=" & codhab
cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1)
cs=cs & ")"


rs.Open cs, base
if not rs.eof then
	if not isnull (rs("dispo")) then elCupo=clng(rs("dispo"))
	if not isnull(rs("dispo")) then
		if clng(rs("dispo"))>0 then tieneCupo=true
	end if

end if
rs.close
'response.write "elCupo" & elCupo &  "<br/>"

'Comprobar si todos los dias existe cupo
cs="SELECT COUNT(*) as todos,MAX(DiasMinimos) as minimos,MIN(Estado) as elEstado FROM " & precrs & "Cupos Cupos WHERE "
cs=cs & "CodigoHab=" & codhab ' & " AND Tarifa=" & tarifa
cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1)
cs=cs & ")"

rs.open cs,base
if not rs.eof then
	if not isnull(rs("todos")) then todos=clng(rs("todos"))
	if not isnull(rs("minimos")) then minimos=clng(rs("minimos"))
	if not isnull(rs("elEstado")) then elEstado=clng(rs("elEstado"))

	if noches<>todos then tieneCupo=false
	if noches<minimos then
		tieneCupo=false
		diasMinimos=minimos
	end if
	if elEstado=0 then 'no venta
		tieneCupo=false
		estadoHab="NV"
	end if

end if

rs.close

%>