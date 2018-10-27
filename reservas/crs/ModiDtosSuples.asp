<%
	'aqui solo llega si se envia la variable (dtosuples=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Valores
	suple=request.form("codsupledto")
	colec=request.form("colectivodtosuple")
	dto=request.form("dtosuple")
	precio=request.form("preciosuple")

	select case modo 
		case "borra" 'Borrar dtos marcados
			queborro=split(request.form("dtosupleborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM RegimenDtos WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "Id=" & QueBorro(t) &  " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "nuevo" 'Añadir
			'Añadir en DescuentosColectivos
			
			'Comprobar que no exista en la tabla
			cs="SELECT Id FROM " & precrs & "RegimenDtos "
			cs=cs & "WHERE IdRegimenHotel=" & suple & " AND CodigoColec=" & colec 
			rs.open cs,base
			if not rs.eof then 'Ya existe
				rs.close
				set rs=nothing
				base.close
				set base=nothing
				response.write "<html><body><h2>Ese dto ya existe, modifíquelo y pulse actualizar tabla</h2>" & vbcrlf
				response.write "<input type='button' value='Volver' onclick='javascript:window.history.back();'>" & vbcrlf
				response.write "</body></html>"
				response.End()
			else
				rs.close
				cs="INSERT INTO " & precrs & "RegimenDtos (IdRegimenHotel,CodigoColec,Descuento,Precio) VALUES ("
				cs=cs & suple & "," & colec & "," & QuitarComa(dto)  & "," & QuitarComa(precio) & ")"
				'response.write cs & "<br>"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "actu"

			'Buscar la lista de cod. suplementos de la habitacion
			cs="SELECT RegimenDtos.Id "
			cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "RegimenDtos RegimenDtos "
			cs=cs & "ON RegimenHotel.Id=RegimenDtos.IdRegimenHotel "
			cs=cs & "WHERE CodigoEsta=" & est & " AND (CodigoHab=0 OR CodigoHab=" & miid & ")"
			rs.open cs,base
			hayregis=false
			if not rs.eof then
				RegIds=rs.getrows
				hayregis=true
			end if
			rs.close
		
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					'Formato (habi-suple-colec-tempo)
					identidad=RegIds(0,r)
					colec=request.form("suplecolectivo-" & identidad)
					dto=request.form("supledto-" & identidad)
					precio=request.form("supleprecio-" & identidad)
					cs="UPDATE " & precrs & "RegimenDtos SET "
					cs=cs & "CodigoColec=" & colec & ","
					cs=cs & "Descuento=" & QuitarComa(dto) & ","
					cs=cs & "Precio=" & QuitarComa(precio) & " "
					cs=cs & "WHERE Id=" & RegIds(0,r)
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
				next	
			end if
			
	end select
			
%>