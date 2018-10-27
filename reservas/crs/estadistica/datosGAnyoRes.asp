<%
tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

'Buscar reservas del año (nº reservas)
cs="SELECT month(" & tipofecha & "),COUNT(*) as LasPelas "
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
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFecha=0
	MPelas=1
	hayestemes=true
	
	totalnreservas=0
	for r=0 to ubound(RegMes,2)
		totalnreservas=totalnreservas+RegMes(MPelas,r)
	next
end if
rs.close

if compara<>any then 'buscar reservas del otro año

	cs="SELECT month(" & tipofecha & "),COUNT(*) as LasPelas "
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
	hayestemes_A=false
	rs.open cs,base
	if not rs.eof then
		RegMes_A=rs.getrows
		MFecha_A=0
		MPelas_A=1
		hayestemes_A=true
		totalnreservas_A=0
		for r=0 to ubound(RegMes_A,2)
			totalnreservas_A=totalnreservas_A+RegMes_A(MPelas_A,r)
		next
	end if
	rs.close

end if 'compara<>any
%>