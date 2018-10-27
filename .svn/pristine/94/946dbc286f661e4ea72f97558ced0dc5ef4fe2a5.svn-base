<%
'Suplementos
PrecioSuples=0
TotalSuples=0
codsuple=0
if TRegimen<>0 then 'Buscar el codigo para poner el precio
	'Buscar el correspondiente a la hab y la temporada
	cs="SELECT Precio,RegimenHotel.Id,Nombre_" & lang & " FROM RegimenHotel INNER JOIN Regimen "
	cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
	cs=cs & "WHERE RegimenHotel.IdRegimen=" & TRegimen & " AND CodigoEsta=" & est
	cs=cs & " AND (Codigotempo=" & CodTem & " OR CodigoTempo=0) AND "
	cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) AND Anyo=" & anyo
	'response.write cs & "<br>"
	rs.open cs,base
	if not rs.eof then
		codsuple=rs("id")
		nombreSuple=rs("nombre_" & lang)
		'response.write nombreSuple & "<br>"
		PrecioSuples=rs("precio")
		TotalSuples=redondear(rs("precio")*plazas)
	end if
	rs.close

else 'no se ha indicado, poner regimen por defecto
	
	'Buscar el correspondiente a la hab y la temporada
	cs="SELECT Precio,RegimenHotel.Id,Nombre_" & lang & " FROM RegimenHotel INNER JOIN Regimen "
	cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
	cs=cs & "WHERE Defecto<>0 AND CodigoEsta=" & est
	cs=cs & " AND (Codigotempo=" & CodTem & " OR CodigoTempo=0) AND "
	cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) AND Anyo=" & anyo
	rs.open cs,base
	if not rs.eof then
		codsuple=rs("id")
		nombreSuple=rs("nombre_" & lang)
		PrecioSuples=rs("precio")
		TotalSuples=redondear(rs("precio")*plazas)
	end if
	rs.close
	
end if
%>