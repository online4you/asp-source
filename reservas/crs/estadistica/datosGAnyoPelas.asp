<%

tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

'Buscar reservas del año (importes)
cs="SELECT month(" & tipofecha & "),SUM(Importe) as LasPelas "
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
hayestemesP=false
rs.open cs,base
if not rs.eof then
	RegMesP=rs.getrows
	MFechaP=0
	MPelasP=1
	hayestemesP=true
	totalIReservas=0
	for r=0 to ubound(RegMesP,2)
		totalIReservas=totalIReservas+RegMesP(MPelasP,r)
	next
	'response.write cs
end if
rs.close

if compara<>any then 'buscar los importes del otro año

	cs="SELECT month(" & tipofecha & "),SUM(Importe) as LasPelas "
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
	hayestemesP_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesP_A=rs.getrows
		MFechaP_A=0
		MPelasP_A=1
		hayestemesP_A=true
		totalIReservas_A=0
		for r=0 to ubound(RegMesP_A,2)
			totalIReservas_A=totalIReservas_A+RegMesP_A(MPelasP_A,r)
		next
	end if
	rs.close



end if 'compara<>any

%>