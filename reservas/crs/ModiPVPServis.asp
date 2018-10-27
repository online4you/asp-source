<%
	'aqui solo llega si se envia la variable (precios=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")
	
	'Buscar la lista de ids de ServiciosPrecios
	cs="SELECT id FROM " & precrs & "ServiciosPrecios WHERE IdServicio=" & MiId
	rs.open cs,base
	hayregis=false
	if not rs.eof then
		RegIds=rs.getrows
		hayregis=true
	end if
	rs.close
	
	select case modo 
		case "borra" 'Borrar precios marcados
			queborro=split(request.form("pvpborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "ServiciosPrecios WHERE "
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
			
		case "nuevo" 'Añadir
			'Añadir en ServiciosPrecios
			tempo=request.form("temporada")
			colec=request.form("colectivo")
			pelas=request.form("importe")
			tipo=request.form("tipo")
			
			cs="INSERT INTO " & precrs & "ServiciosPrecios (IdServicio,IdTemporada,IdColectivo,Tipo,Importe) VALUES ("
			cs=cs & MiId & "," & tempo & "," & colec & "," & QuitarComa(tipo) & "," & QuitarComa(pelas) & ")"
			base.execute cs
			
		case "actu"
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					tempo=request.form("temporada-" & RegIds(0,r))
					colec=request.form("colectivo-" & RegIds(0,r))
					pelas=request.form("importe-" & RegIds(0,r))
					tipo=request.form("tipo-" & RegIds(0,r))
					cs="UPDATE " & precrs & "ServiciosPrecios SET "
					cs=cs & "IdTemporada=" & tempo & ","
					cs=cs & "IdColectivo=" & colec & ","
					cs=cs & "Importe=" & QuitarComa(pelas) & ","
					cs=cs & "tipo=" & QuitarComa(tipo) & " "
					cs=cs & "WHERE Id=" & RegIds(0,r)
					base.execute cs
				next	
			end if
			
	end select

%>