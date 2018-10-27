<%
tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

'Buscar reservas del año (nº reservas)
cs="SELECT DAY(" & tipofecha & "),COUNT(*) as LasPelas "
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
cs=cs & "AND YEAR(" & tipofecha & ")=" & any & " AND MONTH(" & tipofecha & ")=" & mes
cs=cs & " GROUP BY DAY(" & tipofecha & ")"
'response.write cs
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MDia=0
	MPelas=1
	hayestemes=true
	
	totalnreservas=0
	for r=0 to ubound(RegMes,2)
		totalnreservas=totalnreservas+RegMes(MPelas,r)
	next
end if
rs.close


'Buscar reservas del año (importes)
cs="SELECT SUM(Importe) as LasPelas "
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
cs=cs & "AND YEAR(" & tipofecha & ")=" & any & " AND MONTH(" & tipofecha & ")=" & mes
rs.open cs,base
if not rs.eof then
	totalimporte=paDbl(rs("laspelas"))
end if
rs.close

'Buscar estancia media del año (importes)
cs="SELECT AVG(NumDias) as LasPelas "
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
cs=cs & "AND YEAR(" & tipofecha & ")=" & any & " AND MONTH(" & tipofecha & ")=" & mes
rs.open cs,base
if not rs.eof then
	totalestanciamedia=paDbl(rs("laspelas"))
end if
rs.close

cs="SELECT AVG(importe) as LasPelas "
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
cs=cs & "AND YEAR(" & tipofecha & ")=" & any & " AND MONTH(" & tipofecha & ")=" & mes
rs.open cs,base
if not rs.eof then
	totalimportemedio=paDbl(rs("laspelas"))
end if
rs.close

%>