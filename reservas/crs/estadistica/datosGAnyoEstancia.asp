<%
tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

'Buscar estancia media del año (importes)
cs="SELECT month(" & tipofecha & "),AVG(NumDias) as LasPelas "
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
hayestemesE=false
rs.open cs,base
if not rs.eof then
	RegMesE=rs.getrows
	MFechaE=0
	MPelasE=1
	hayestemesE=true
	
	totalEReservas=0
	for r=0 to ubound(RegMesE,2)
		totalEReservas=totalEReservas+RegMesE(MPelasE,r)
	next
	'media noches
	totalEReservas=totalEReservas/(ubound(RegMesE,2)+1)
	
end if
rs.close

if compara<>any then 'buscar reservas del otro año

	cs="SELECT month(" & tipofecha & "),AVG(NumDias) as LasPelas "
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
	hayestemesE_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesE_A=rs.getrows
		MFechaE_A=0
		MPelasE_A=1
		hayestemesE_A=true
		totalEReservas_A=0
		for r=0 to ubound(RegMesE_A,2)
			totalEReservas_A=totalEReservas_A+RegMesE_A(MPelasE_A,r)
		next
	end if
	rs.close

end if 'compara<>any
%>