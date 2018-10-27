<%
	'Buscado cod. temporada
	cs="SELECT CodigoTemp FROM " & precrs & "Temporadas "
	cs=cs & "WHERE CodigoEsta=" & est
	cs=cs & " AND (FInicio<=" & FechaMySQL(d)& " AND "
	cs=cs & "FFinal>=" & FechaMySQL(d) & ")"
	rs.open cs,base
	codtem=0
	calcular=false
	if not rs.eof then 'Tenemos cod. temporada
		codtem=rs("CodigoTemp")
		calcular=true
	end if
	rs.close
	
%>