<%
'Modulo que recoge las variables y da de alta,modifica o borra ficha

modo=request.QueryString("modo")
if modo<>"" then 'procesar
	nombre=quitarApos(request.form("nombre"))
	apellidos=quitarApos(request.form("apellidos"))
	direccion=quitarApos(request.form("direccion"))
	cp=quitarApos(request.form("cp"))
	poblacion=quitarApos(request.form("poblacion"))
	tele=quitarApos(request.form("telefono"))
	fax=quitarApos(request.form("fax"))
	provincia=quitarApos(request.form("provincia"))
	email=quitarApos(request.form("email"))
	obs=quitarApos(request.form("obs"))
	pais=request.form("pais")
	idiomaW=request.form("idiomaweb")
	Info=request.form("info")
	if info="" then info=0

	select case modo
		case "actu"
			MiId=request.form("id")
			cs="UPDATE Fichas SET "
			cs=cs & "nombre='" & nombre & "',"
			cs=cs & "apellidos='" & apellidos & "',"
			cs=cs & "direccion='" & direccion & "',"
			cs=cs & "cp='" & cp & "',"
			cs=cs & "poblacion='" & poblacion & "',"
			cs=cs & "provincia='" & provincia & "',"
			cs=cs & "telefono='" & tele & "',"
			cs=cs & "fax='" & fax & "',"
			cs=cs & "pais='" & pais & "',"
			cs=cs & "email='" & email & "',"
			cs=cs & "idiomaweb='" & idiomaW & "',"
			cs=cs & "Informacion=" & info & ","
			cs=cs & "Observaciones='" & obs & "' "
			cs=cs & "WHERE id=" & MiId
			'response.Write(cs & "<br>")
			base.execute cs
			
		case "borra"
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE Fichas WHERE " 'no las borra
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
			end if
	end select
	pasalir=1
end if 'modo<>""

%>
