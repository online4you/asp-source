<%
tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

'Buscar estancia media del año (importes)
cs="SELECT month(" & tipofecha & "),AVG(importe) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 AND Anulada=0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 AND Anulada=0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 AND Anulada=0 "
end if
cs=cs & "AND YEAR(" & tipofecha & ")=" & any & " "
cs=cs & "GROUP BY month(" & tipofecha & ")"
'response.write cs
hayestemesEu=false
rs.open cs,base
if not rs.eof then
	RegMesEu=rs.getrows
	MFechaEu=0
	MPelasEu=1
	hayestemesEu=true
	
	totalEuReservas=0
	for r=0 to ubound(RegMesEu,2)
		totalEuReservas=totalEuReservas+RegMesEu(MPelasEu,r)
	next
	'media noches
	totalEuReservas=totalEuReservas/(ubound(RegMesEu,2)+1)
	
end if
rs.close

if compara<>any then 'buscar reservas del otro año

	cs="SELECT month(" & tipofecha & "),AVG(importe) as LasPelas "
	cs=cs & "FROM " & precrs & "Reservas Reservas "
	if todos="-1" then 'Ver Todos
		cadena=replace(buscoHoteles,"WHERE ","")
		cadena=replace(cadena,"Establecimientos.","Reservas.")
		if cadena<>"" then
			cs=cs & "WHERE (" & cadena & ") AND Activa<>0 AND Anulada=0 " '"WHERE Reservas.CodigoEsta<>0 "
		else
			cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 AND Anulada=0 "
		end if
	else
		cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 AND Anulada=0 "
	end if
	cs=cs & "AND YEAR(" & tipofecha & ")=" & compara & " "
	cs=cs & "GROUP BY month(" & tipofecha & ")"
	'response.write cs
	hayestemesEu_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesEu_A=rs.getrows
		MFechaEu_A=0
		MPelasEu_A=1
		hayestemesEu_A=true
		totalEuReservas_A=0
		for r=0 to ubound(RegMesEu_A,2)
			totalEuReservas_A=totalEuReservas_A+RegMesEu_A(MPelasEu_A,r)
		next
	end if
	rs.close

end if 'compara<>any
%>