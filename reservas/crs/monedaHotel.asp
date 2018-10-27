<%
'Datos del hotel
cs="SELECT CodigoISO,Abreviado "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "TiposMoneda TiposMoneda "
cs=cs & "ON Establecimientos.Moneda=TiposMoneda.Id "
cs=cs & "WHERE Establecimientos.CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	monedaHotel=rs("CodigoISO")
	sufijoMoneda="&nbsp;" & trim(rs("abreviado"))
end if
rs.close
%>