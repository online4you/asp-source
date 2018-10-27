<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	apellidos=quitarApos(request.Form("apellidos"))
	nombre=quitarApos(request.Form("nombre"))
	telefono=quitarApos(request.Form("telefono"))
	email=quitarApos(request.Form("email"))
	fax=quitarApos(request.Form("fax"))
	direccion=quitarApos(request.Form("direccion"))
	poblacion=quitarApos(request.Form("poblacion"))
	provincia=quitarApos(request.Form("provincia"))
	cp=quitarApos(request.Form("cp"))
	pais=quitarApos(request.Form("pais"))
	codigoVIP=quitarApos(request.Form("codigoVIP"))
	obs=quitarApos(request.Form("obs"))
	idiomaweb=request.form("idiomaweb")
	publicidad=request.form("publicidad")
	if publicidad="" then publicidad=0
	activo=request.form("activo")
	if activo="" then activo=0
	fechanac=request.Form("fechanac")
		
	select case modo
		case "borra"
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cadena=""
				for t=0 to ubound(queborro)
					cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
				next
				if right(cadena,4)=" OR " then 'Quitar el ultimo operador
					cadena=left(cadena,len(cadena)-4)
				end if	
				'Borrar 
				cs="DELETE FROM " & precrs & "Fichas WHERE " & cadena
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
				'Borrar en visitas
				cadena=replace(cadena,"Id=","IdFicha=")
				cs="DELETE FROM " & precrs & "VisitasVIP WHERE " & cadena
				base.execute cs
			end if
		
		case "actu"
			cs="UPDATE " & precrs & "Fichas SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Apellidos='" & apellidos & "',"
			cs=cs & "CodigoVIP='" & codigoVIP & "',"
			cs=cs & "Telefono='" & telefono & "',"
			cs=cs & "Fax='" & fax & "',"
			cs=cs & "EMail='" & email & "',"
			cs=cs & "Direccion='" & direcion & "',"
			cs=cs & "Poblacion='" & Poblacion & "',"
			cs=cs & "CP='" & CP & "',"
			cs=cs & "Provincia='" & provincia & "',"
			cs=cs & "NombrePais='" & Pais & "',"
			cs=cs & "IdiomaWeb='" & idiomaweb & "',"
			cs=cs & "Informacion=" & publicidad & ","
			cs=cs & "Activo=" & activo & ","
			cs=cs & "FechaNac=" & FechaMySQL(fechanac) & ","
			cs=cs & "Observaciones='" & obs & "' "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "nuevo"
			cs="INSERT INTO " & precrs & "Fichas (CodigoVIP,Nombre,Apellidos,Telefono,Fax,Direccion,Poblacion,CP,"
			cs=cs & "Provincia,NombrePais,Email,Observaciones,IdiomaWeb,Informacion,FechaNac,FechaAlta,Activo) VALUES ('"
			cs=cs & codigoVIP & "','" & nombre & "','" & apellidos & "','" & telefono & "','"
			cs=cs & fax & "','" & direccion & "','" & poblacion & "','" & CP & "','" & provincia & "','"
			cs=cs & nombrePais & "','" & email & "','" & obs & "','" & idiomaweb & "'," & publicidad & ","
			cs=cs & FechaMySQL(fechanac) & "," & FechaMySQL(date) & "," & activo & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
	pasalir=1

end if

%>