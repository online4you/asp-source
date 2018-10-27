<%
function FechaHoraSQLServer(esafecha)
	mysqlBD=true
	if mysqlBD then
		if isdate(esafecha) then
			lmes=month(esafecha)
			ldia=day(esafecha)
			lano=year(esafecha)	
			FechaHoraSQLServer="'" & lano & "-" & lmes & "-" & ldia & " " & hour(esafecha) & ":" & minute(esafecha) & ":00'"
		else
			FechaHoraSQLServer=""
		end if
	
	else 'por defecto pal SQL Server
		if isdate(esafecha) then
			lmes=month(esafecha)
			ldia=day(esafecha)
			lano=year(esafecha)	
			FechaHoraSQLServer="CONVERT(DATETIME,'" & lano & "-" & lmes & "-" & ldia & " " & hour(esafecha) & ":" & minute(esafecha) & "',102)"
		else
			FechaHoraSQLServer="null"
		end if
	end if 'mysql<>""
end function
'Funcion para registrar los movimientos de delete,update e insert de los usuarios
Sub controlRegistro(elproceso)
	idusu=request.Cookies("idCR") 'id del usuario
	idnom=request.Cookies("userCR") 'Nombre del usuario
	codhotel=est
	if codhotel="" then codhotel=0
	anyotempo=anyo
	if anyotempo="" then anyotempo=0
	ccs="INSERT INTO " & precrs & "Registro (IdUsuario,Nombre,Fecha,CodigoEsta,Anyo,Proceso) VALUES ("
	ccs=ccs & idusu & ",'" & idnom & "'," & fechaHoraSQLServer(now()) & "," & codhotel & ","
	ccs=ccs & anyotempo & ",'" & quitarApos(elproceso) & "')"
	'response.write ccs & "<br>"
	base.execute ccs
end Sub
%>