<%
if request.form<>"" then
	MiId=request.querystring("id")
	
	'Buscar la lista de ids de serviciostemporadas
	cs="SELECT Temporada FROM TipoHabitaPrecios INNER JOIN Temporadas "
	cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
	cs=cs & " WHERE IdHabita=" & MiId & " AND YEAR(FInicio)=" & anyo
	rs.open cs,base
	hayregis=false
	if not rs.eof then
		RegIds=rs.getrows
		hayregis=true
	end if
	rs.close
	
	'Solo se puede actualizar
	if hayregis then 'Actualizar todos los registros
		for r=0 to ubound(RegIds,2)
			pelas=request.form("importe-" & RegIds(0,r))
			tipo=request.form("tipo-" & RegIds(0,r))
			cs="UPDATE TipoHabitaPrecios SET "
			cs=cs & "PrePreBase=" & QuitarComa(pelas) & ","
			cs=cs & "PreperHab=" & QuitarComa(tipo) & " "
			cs=cs & "WHERE IdHabita=" & MiId & " AND Temporada=" & RegIds(0,r)
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
		next	
	end if
end if 'form<>""		
%>