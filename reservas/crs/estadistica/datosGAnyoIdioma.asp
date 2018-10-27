<%
tipofecha="FechaReserva"
if tipof="fe" then tipofecha="FechaIni"

colorIngles="#439043"
colorEspanol="#43ADF5"
colorAleman="#F54343"
colorFrances="#F58AD1"
colorItaliano="#F0F86D"

'Buscar Idiomas del año (nº reservas)
cs="SELECT Idi,COUNT(*) as LasPelas "
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
cs=cs & "GROUP BY Idi"
'response.write cs
hayIdioma=false
rs.open cs,base
if not rs.eof then
	RegIdioma=rs.getrows
	MIdioma=0
	MPelasIdi=1
	hayIdioma=true
	
	totalIdioma=0
	for r=0 to ubound(RegIdioma,2)
		totalIdioma=totalIdioma+RegIdioma(MPelasIdi,r)
	next
	
end if
rs.close

'Buscar Idiomas del año por meses (nº reservas)
cs="SELECT Idi,month(" & tipofecha & "),COUNT(*) as LasPelas "
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
cs=cs & "GROUP BY Idi,month(" & tipofecha & ")ORDER BY Idi"
hayMesIdioma=false
'response.write cs
rs.open cs,base
if not rs.eof then
	RegMesIdioma=rs.getrows
	MMIdioma=0
	MMesIdi=1
	MMPelasIdi=2
	hayMesIdioma=true
	
end if
rs.close

if compara<>any then 'buscar reservas del otro año

	cs="SELECT Idi,COUNT(*) as LasPelas "
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
	cs=cs & "GROUP BY Idi"
	'response.write cs
	hayIdioma_A=false
	rs.open cs,base
	if not rs.eof then
		RegIdioma_A=rs.getrows
		MIdioma_A=0
		MPelasIdi_A=1
		hayIdioma_A=true
		totalIdioma_A=0
		for r=0 to ubound(RegIdioma_A,2)
			totalIdioma_A=totalIdioma_A+RegIdioma_A(MPelasIdi_A,r)
		next
	end if
	rs.close
	
	'Buscar Idiomas del año por meses (nº reservas)
	cs="SELECT Idi,month(" & tipofecha & "),COUNT(*) as LasPelas "
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
	cs=cs & "GROUP BY Idi,month(" & tipofecha & ")ORDER BY Idi"
	hayMesIdioma_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesIdioma_A=rs.getrows
		MMIdioma_A=0
		MMesIdi_A=1
		MMPelasIdi_A=2
		hayMesIdioma_A=true
		
	end if
	rs.close

end if 'compara<>any
%>