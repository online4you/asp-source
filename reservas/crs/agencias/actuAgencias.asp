<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Datos del form
	nombre=QuitarApos(request.form("nombre"))
	email=QuitarApos(request.form("email"))
	obs=QuitarApos(request.form("obs"))
	direccion=QuitarApos(request.form("direccion"))
	pais=QuitarApos(request.form("pais"))
	poblacion=QuitarApos(request.form("poblacion"))
	cp=QuitarApos(request.form("cp"))
	usuario=QuitarApos(request.form("usuario"))
	clave=QuitarApos(request.form("clave"))
	telefono=QuitarApos(request.form("telefono"))
	fax=QuitarApos(request.form("fax"))
	contacto=QuitarApos(request.form("contacto"))
	comision=QuitarComa(request.form("comision"))
	activa=paClng(request.form("activa"))
	bal=QuitarApos(request.form("bal"))
	

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
				cs="DELETE FROM " & precrs & "Agencias WHERE " & cadena
				base.execute cs
				
			end if
		
		case "actu"
			cs="UPDATE " & precrs & "Agencias SET "
			cs=cs & "nombre='" & nombre & "',"
			cs=cs & "email='" & email & "',"
			cs=cs & "direccion='" & direccion & "',"
			cs=cs & "comision=" & comision & ","
			cs=cs & "cp='" & cp & "',"
			cs=cs & "poblacion='" & poblacion & "',"
			cs=cs & "pais='" & pais & "',"
			cs=cs & "observaciones='" & obs & "',"
			cs=cs & "activa=" & activa & ","
			cs=cs & "usuario='" & usuario & "',"
			cs=cs & "clave='" & clave & "',"
			cs=cs & "contacto='" & contacto & "',"
			cs=cs & "telefono='" & telefono & "',"
			cs=cs & "fax='" & fax & "',"
			cs=cs & "BAL='" & bal & "' "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			cs="INSERT INTO " & precrs & "Agencias(nombre,email,direccion,comision,cp,poblacion,pais,observaciones,activa,"
			cs=cs & "usuario,clave,contacto,telefono,fax,bal) VALUES ('"
			cs=cs & nombre & "','" & email & "','" & direccion & "'," & comision & ",'" & cp & "','" & poblacion
			cs=cs & "','" & pais & "','" & obs & "'," & activa & ",'" & usuario & "','" & clave & "','" & contacto
			cs=cs & "','" & telefono & "','" & fax & "','" & bal & "')"
			'response.write cs
			
			base.execute cs
			
	end select
	pasalir=1

end if

%>