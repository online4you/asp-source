<%
	'aqui solo llega si se envia la variable (suples=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")
	
	select case modo 
		case "borra" 'Borrar suples marcados
			queborro=split(request.form("supleborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "Suplementos WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "CodigoSuple=" & QueBorro(t) &  " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs

				'Borrar SuplementoNombres
				cs="DELETE FROM " & precrs & "SuplementoNombres WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "SuplementosIdi=" & QueBorro(t) &  " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs

				'Borrar DescuentosSuple
				cs="DELETE FROM " & precrs & "DescuentosSuple WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "CodigoSuple=" & QueBorro(t) &  " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs

				'Borrar SuplementosTempo
				cs="DELETE FROM " & precrs & "SuplementosTempo WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "CodigoSuple=" & QueBorro(t) &  " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs

			end if
			
		case "nuevo" 'Añadir
			'Añadir en Suplementos
			tipoh=request.form("habitacionnew")
			
			cs="INSERT INTO " & precrs & "Suplementos (CodigoEsta,TipoHab) VALUES ("
			cs=cs & est & "," & tipoh & ")"
			base.execute cs

			'Buscar el ult. registro
			cs="SELECT MAX(CodigoSuple) as idsuple FROM " & precrs & "Suplementos"
			rs.open cs,base
			if not rs.eof then
				idsuple=rs("idsuple")
				'Guardar los nombres de suplementos
				for i=1 to ubound(idioma)
					nombre=QuitarApos(request.form("nombre_" & idioma(i) & "2"))
					cs="INSERT INTO " & precrs & "SuplementoNombres (SuplementosIdi,Nombre,Idioma) VALUES ("
					cs=cs & idsuple & ",'" & nombre & "','" & idioma(i) & "')"
					base.execute cs
				next
			end if
			rs.close
			
		case "actu"
			'Buscar las id de suplementos de esa habitacion
			cs="SELECT CodigoSuple FROM " & precrs & "Suplementos "
			cs=cs & "WHERE (TipoHab=" & MiId & " OR TipoHab=0) AND CodigoEsta=" & est
			rs.open cs,base
			hayregis=false
			if not rs.eof then
				RegIds=rs.getrows
				hayregis=true
			end if
			rs.close
		
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					thabi=request.form("suplehabi-" & RegIds(0,r))
					cs="UPDATE " & precrs & "Suplementos SET "
					cs=cs & "TipoHab=" & thabi & " "
					cs=cs & "WHERE CodigoSuple=" & RegIds(0,r)
					base.execute cs
					
				next	
			end if

		case "actu2" 'Mpodifica desde la ficha suplemnto

			ids=request.form("ids")
			'Actualizar en Suplementos
			tipoh=request.form("habitacionnew")
			
			cs="UPDATE " & precrs & "Suplementos SET "
			cs=cs & "tipohab=" & tipoh & " "
			cs=cs & "WHERE CodigoSuple=" & ids
			base.execute cs
			
			'Guardar los nombres de suplementos
			for i=1 to ubound(idioma)
				nombre=QuitarApos(request.form("nombre_" & idioma(i) & "2"))
				cs="UPDATE " & precrs & "SuplementoNombres SET "
				cs=cs & "nombre='" & nombre & "' WHERE SuplementosIdi=" & ids & " AND idioma='" & idioma(i) & "'"
				base.execute cs
			next
			
	end select
			
%>