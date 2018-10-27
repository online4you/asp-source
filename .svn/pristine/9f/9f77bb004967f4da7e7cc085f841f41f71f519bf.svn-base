<%
'Modulo que recoge las variables y da de alta,modifica o borra ficha

modo=request.QueryString("modo")
if modo<>"" then 'procesar
	if modo<>"borra" then 'Evita que cargue los datos cuando se borra
		nombre=replace(request.form("nombre"),"'","´")
		apellidos=replace(request.form("apellidos"),"'","´")
		direccion=replace(request.form("direccion"),"'","´")
		cp=replace(request.form("cp"),"'","´")
		poblacion=replace(request.form("poblacion"),"'","´")
		tele=replace(request.form("telefono"),"'","´")
		fax=replace(request.form("fax"),"'","´")
		provincia=replace(request.form("provincia"),"'","´")
		email=request.form("email")
		pais=request.form("pais")
		idiomaW=request.form("idiomaweb")
		contacto=request.form("contacto")
		Info=request.form("info")
		if info="" then info=0
		FNac=FechaMySQL(request.form("fnac"))
	end if	
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
			cs=cs & "ComoContacto=" & contacto & ","
			cs=cs & "Informacion=" & info & ","
			cs=cs & "FechaNac=" & FNac & " "
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
end if 'modo<>""

laid=clng("0" & request.querystring("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT * FROM Fichas WHERE ID=" & laid
	rs.Open cs, base
	if not rs.eof then
		nombre=rs("nombre")
		apellidos=rs("apellidos")
		direccion=rs("direccion")
		cp=rs("cp")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		tele=rs("telefono")
		fax=rs("fax")
		email=rs("email")
		pais=rs("nombrepais")
		chotel=rs("hotel")
		idiomaW=rs("idiomaweb")
		sexo=rs("sexo")
		fecha=rs("fechaAlta")
		FIni=rs("fechallegada")
		FFin=rs("Fechasalida")
		contacto=rs("comocontacto")
		Info=rs("informacion")
		Confi=rs("confirmado")
		FNac=rs("FechaNac")
		obser=rs("Observaciones")
		codreserva=rs("codreserva")
	end if
	rs.close
end if

'Tabla de tipos contacto
cs="SELECT id,Contacto_es FROM Contactar"
rs.open cs,base
if not rs.eof then
	RegContac=rs.GetRows
	CCodi=0
	CNombre=1
end if
rs.close

'Tabla de hoteles
cs="SELECT CodigoEsta,Nombre FROM Establecimientos"
rs.open cs,base
if not rs.eof then
	RegHoteles=rs.GetRows
	HCodi=0
	HNombre=1
end if
rs.close

%>
