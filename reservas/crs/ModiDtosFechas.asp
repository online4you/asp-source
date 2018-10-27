<%
	'aqui solo llega si se envia la variable (dtosf=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")
	
	select case modo 
		case "borra" 'Borrar dtos marcados
			queborro=split(request.form("dtoborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "DescuentosFechas WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "CodigoFechas=" & QueBorro(t) & " OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
			end if
			
		case "nuevo" 'Añadir
			'Añadir en DescuentosFechas
			Fini=request.form("dtofdesde")
			FFin=request.form("dtofhasta")
			dto=request.form("dtofdto")
			if not isdate(fini) or not isdate(ffin) then 'Fechas incorrectas
				response.write "<html><body><h3>Fechas Incorrectas</h3>"
				response.write "<br><br><input type='button' value='volver' onclick='javascript:window.history.back();'"
				response.write "</body></html>"
				response.End()
			end if
			finisql=year(fini) & "/" & month(fini) & "/" & day(fini)
			ffinsql=year(ffin) & "/" & month(ffin) & "/" & day(ffin)
			
			cs="INSERT INTO " & precrs & "DescuentosFechas (TipoHab,CodigoEsta,Desde,Hasta,Value) VALUES ("
			cs=cs & MiId & "," & est & ",CONVERT(DATETIME,'" & finisql & "', 102),"
			cs=cs & "CONVERT(DATETIME,'" & ffinsql & "', 102)" & "," & QuitarComa(dto)  & ")"
			base.execute cs
			
		case "actu"

			'Buscar la lista de ids de descuentosFechas
			cs="SELECT CodigoFechas FROM " & precrs & "DescuentosFechas WHERE TipoHab=" & MiId
			rs.open cs,base
			hayregis=false
			if not rs.eof then
				RegIds=rs.getrows
				hayregis=true
			end if
			rs.close
		
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					Fini=request.form("dtofdesde-" & RegIds(0,r))
					FFin=request.form("dtofhasta-" & RegIds(0,r))
					dto=request.form("dtofecha-" & RegIds(0,r))
					if not isdate(fini) or not isdate(ffin) then 'Fechas incorrectas
						response.write "<html><body><h3>Fechas Incorrectas</h3>"
						response.write "<br><br><input type='button' value='volver' onclick='javascript:window.history.back();'"
						response.write "</body></html>"
						response.End()
					end if
					finisql=year(fini) & "/" & month(fini) & "/" & day(fini)
					ffinsql=year(ffin) & "/" & month(ffin) & "/" & day(ffin)
				
					cs="UPDATE " & precrs & "DescuentosFechas SET "
					cs=cs & "Desde=CONVERT(DATETIME,'" & finisql & "', 102),"
					cs=cs & "Hasta=CONVERT(DATETIME,'" & ffinsql & "', 102),"
					cs=cs & "Value=" & QuitarComa(dto) & " "
					cs=cs & "WHERE CodigoFechas=" & RegIds(0,r)
					base.execute cs
				next	
			end if
			
	end select
			
%>