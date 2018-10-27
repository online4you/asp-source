<%
'Lista de registros
cs="SELECT Tarifas.Id,ISNULL(Traduccion,Nombre) AS Tradu "
cs=cs & "FROM Tarifas LEFT JOIN Traducciones "
cs=cs & "On Tarifas.Id=Traducciones.IdReferencia AND Tabla='Tarifas' AND Campo='Nombre' "
cs=cs & "AND Idioma='" & lang & "'"
rs.Open cs, base
hayTarifas=false
if not rs.eof then
	RegTarifas=rs.GetRows
	TaCodi=0
	TaNombre=1
	hayTarifas=true
end if
rs.close

%>