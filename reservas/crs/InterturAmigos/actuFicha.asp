<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	apellidos=quitarApos(request.Form("apellidos"))
	nombre=quitarApos(request.Form("nombre"))
	telefono=quitarApos(request.Form("telefono"))
	email=quitarApos(request.Form("email"))
	movil=quitarApos(request.Form("movil"))
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
	beneficiario1=quitarApos(request.Form("beneficiario1"))
	tfamilia1=quitarApos(request.Form("tfamilia1"))
	fechanac1=request.Form("fechanac1")
	beneficiario2=quitarApos(request.Form("beneficiario2"))
	tfamilia2=quitarApos(request.Form("tfamilia2"))
	fechanac2=request.Form("fechanac2")
	beneficiario3=quitarApos(request.Form("beneficiario3"))
	tfamilia3=quitarApos(request.Form("tfamilia3"))
	fechanac3=request.Form("fechanac3")
		
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
			cs=cs & "Movil='" & movil & "',"
			cs=cs & "EMail='" & email & "',"
			cs=cs & "Direccion='" & direccion & "',"
			cs=cs & "Poblacion='" & Poblacion & "',"
			cs=cs & "CP='" & CP & "',"
			cs=cs & "Provincia='" & provincia & "',"
			cs=cs & "NombrePais='" & Pais & "',"
			cs=cs & "IdiomaWeb='" & idiomaweb & "',"
			cs=cs & "Informacion=" & publicidad & ","
			cs=cs & "Activo=" & activo & ","
			cs=cs & "FechaNac=" & FechaMySQL(fechanac) & ","
			cs=cs & "Observaciones='" & obs & "',"
			cs=cs & "Beneficiario1='" & beneficiario1 & "',"
			cs=cs & "TFamilia1='" & tfamilia1 & "',"
			cs=cs & "FechaNac1=" & FechaMySQL(fechanac1) & ","
			cs=cs & "Beneficiario2='" & beneficiario2 & "',"
			cs=cs & "TFamilia2='" & tfamilia2 & "',"
			cs=cs & "FechaNac2=" & FechaMySQL(fechanac2) & ","
			cs=cs & "Beneficiario3='" & beneficiario3 & "',"
			cs=cs & "TFamilia3='" & tfamilia3 & "',"
			cs=cs & "FechaNac3=" & FechaMySQL(fechanac3) & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "nuevo"
			cs="INSERT INTO " & precrs & "Fichas (CodigoVIP,Nombre,Apellidos,Telefono,Movil,Direccion,Poblacion,CP,"
			cs=cs & "Provincia,Pais,Email,Observaciones,IdiomaWeb,Informacion,FechaNac,FechaAlta,Activo,"
			cs=cs & "Beneficiario1,TFamilia1,FechaNac1,Beneficiario2,TFamilia2,FechaNac2,"
			cs=cs & "Beneficiario3,TFamilia3,FechaNac3) VALUES ('"
			cs=cs & codigoVIP & "','" & nombre & "','" & apellidos & "','" & telefono & "','"
			cs=cs & fax & "','" & direccion & "','" & poblacion & "','" & CP & "','" & provincia & "','"
			cs=cs & nombrePais & "','" & email & "','" & obs & "','" & idiomaweb & "'," & publicidad & ","
			cs=cs & FechaMySQL(fechanac) & "," & FechaMySQL(date) & "," & activo & ",'"
			cs=cs & beneficiario1 & "','" & tfamilia1 & "'," & FechaMySQL(fechanac1) & ",'"
			cs=cs & beneficiario2 & "','" & tfamilia2 & "'," & FechaMySQL(fechanac2) & ",'"
			cs=cs & beneficiario3 & "','" & tfamilia3 & "'," & FechaMySQL(fechanac3) & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
	pasalir=1

end if

%>