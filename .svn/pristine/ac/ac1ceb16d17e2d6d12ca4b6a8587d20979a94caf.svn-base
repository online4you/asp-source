<%
	'aqui solo llega si se envia la variable (suples=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")

	select case modo 
		case "borra" 'Borrar suples marcados
			queborro=split(request.form("supletborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "RegimenHotel WHERE "
				filtro=""
				for t=0 to ubound(queborro)
					filtro=filtro & "Id=" & QueBorro(t) &  " OR "
				next
				if right(filtro,4)=" OR " then 'Quitar el ultimo operador
					filtro=left(filtro,len(filtro)-4)
				end if	
				base.execute cs & filtro
				'Borrar dtos suples
				filtro=replace(filtro,"Id=","IdRegimenHotel=")
				cs="DELETE FROM " & precrs & "RegimenDtos WHERE " & filtro
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento

			end if
			
		case "nuevo" 'Añadir
			'Añadir en SuplementosTempo
			tempo=request.form("supletemponew")
			habi=request.form("suplehabinew")
			suplet=request.form("suplecodi")
			pelas=request.form("supleprecionew")
			defecto=request.form("supledefectonew")
			if defecto="" then defecto=0
		
			cs="INSERT INTO " & precrs & "RegimenHotel (IdRegimen,CodigoEsta,CodigoTempo,CodigoHab,"
			cs=cs & "Precio,Defecto,Anyo) VALUES ("
			cs=cs & suplet & "," & est & "," & tempo & "," & habi & ","
			cs=cs & QuitarComa(pelas)  & "," & defecto & "," & anyo & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			'Buscar las id de suplementos de esa habitacion
			cs="SELECT Id FROM " & precrs & "RegimenHotel "
			cs=cs & "WHERE (CodigoHab=" & MiId & " OR CodigoHab=0) AND CodigoEsta=" & est
			cs=cs & " AND Anyo=" & anyo
			rs.open cs,base
			hayregis=false
			if not rs.eof then
				RegIds=rs.getrows
				hayregis=true
			end if
			rs.close
		
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					tempo=request.form("suplettempo-" & RegIds(0,r))
					thabi=request.form("suplethabi-" & RegIds(0,r))
					pelas=request.form("supletprecio-" & RegIds(0,r))
					defecto=request.form("supletdefecto-" & RegIds(0,r))
					if defecto="" then defecto=0
					cs="UPDATE " & precrs & "RegimenHotel SET "
					cs=cs & "CodigoHab=" & thabi & ","
					cs=cs & "CodigoTempo=" & tempo & ","
					cs=cs & "Precio=" & QuitarComa(pelas) & ","
					cs=cs & "Defecto=" & defecto & " "
					cs=cs & "WHERE Id=" & RegIds(0,r)
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
				next	
			end if

	end select
%>