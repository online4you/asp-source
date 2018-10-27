<%

	'Buscar si ya tiene asociacion
	set base2=server.createobject("ADODB.Connection")
	set rs2=server.createobject("ADODB.Recordset")
	rs2.CursorLocation = adUseServer
	rs2.CursorType=adOpenForwardOnly
	rs2.LockType=adLockReadOnly
	base2.Open CONmailing

	'Comprobar si ya existe
	cs="SELECT * FROM AsociacionBD WHERE NombreBD='" & request.Cookies("laBD") & "' AND "
	cs=cs & "NombreTabla='" & request.Cookies("laTabla") & "'"
	rs2.open cs,base2
	if not rs2.eof then
		campoId=rs2("nombreId")
		campoNombre=rs2("nombre")
		campoApellidos=rs2("apellidos")
		campoEmail=rs2("email")
		campoFechaalta=rs2("fechaalta")
		campoFechanac=rs2("fechanac")
		campoIdioma=rs2("idioma")
		campoPais=rs2("pais")
	end if
	rs2.close
	set rs2=nothing
	base2.close
	set base2=nothing
%>