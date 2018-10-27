<%
tieneCupo=false
elCupo=0
'Cupo
cs="SELECT MIN(Cupo-isnull(confirmadas,0)) as Dispo FROM Disponibles WHERE "
cs=cs & "CodigoHab=" & codhab
cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1)
cs=cs & ")"
response.write cs & "<br/>"
rs.Open cs, base
if not rs.eof then
	elCupo=PaClng(rs("dispo"))
	if elCupo>0 then tieneCupo=true
end if
rs.close

'Comprobar si todos los dias existe cupo
cs="SELECT COUNT(*) as todos,MAX(DiasMinimos) as Minimos,MIN(Estado) as elEstado FROM Cupos WHERE "
cs=cs & "CodigoHab=" & codhab ' & " AND Tarifa=" & tarifa
cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1)
cs=cs & ")"
'if est=5 then response.write "Cupo: " & elCupo & " - " & cs & "<br/>"
rs.open cs,base
if not rs.eof then
	if noches<>paClng(rs("todos")) then tieneCupo=false
	if noches<paClng(rs("minimos")) then
		tieneCupo=false
		diasMinimos=paClng(rs("minimos"))
	end if
	if rs("elEstado")=0 then 'no venta
		tieneCupo=false
		estadoHab="NV"
	end if
end if
rs.close

%>