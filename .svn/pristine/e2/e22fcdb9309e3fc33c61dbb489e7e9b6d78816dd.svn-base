<%
if request.form <> "" and request.QueryString("modo") <> "" then 'Actualizar
	modo = request.QueryString("modo")
	MiId = request.form("id")
	temporada = request.form("temporada")
	colectivo = request.form("colectivo")
	finicio = request.form("finicio")
	ffinal = request.form("ffinal")
	importe = request.form("importe")
	elanyo = paClng(request.form("elanyo"))
	tipo = request.form("tipo")
	regimen = request.form("regimen")
	habitaciones = request.form("habitaciones")
	obligatorio = request.form("obligatorio")
	
	if idEmpresa = 98 then
		incluirloenoferta = request.form("incluirloenoferta")
	end if
	
	if obligatorio <> 1 then obligatorio = 0
	if incluirloenoferta <> 1 then incluirloenoferta = 0
	
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="WHERE "
				for t=0 to ubound(queborro)
					cs=cs & "Id=" & trim(queborro(t)) & " OR "
				next
				if right(cs,4) = " OR " then 'Quitar el ultimo operador
					cs = left(cs,len(cs)-4)
				end if	
				'Borrar precios servicios
				base.execute "DELETE FROM " & precrs & "ServiciosPrecios " & cs
			end if
			
		case "nuevo" 'Añadir
			cs = "INSERT INTO " & precrs & "ServiciosPrecios (IdServicio,FechaInicio,FechaFinal,IdColectivo,Importe,Tipo,"
			cs = cs & "Obligatorio,Regimen,Habitaciones"

			' Algunas empresas tienen esta característica
			if idEmpresa = 98 then 			
				cs = cs & ",IncluirEnOferta"
			end if

			cs = cs & ") VALUES ("
			cs = cs & ids & "," & FechaMySQL(finicio) & "," & FechaMySQL(ffinal) & "," & colectivo & "," 
			cs = cs & quitarComa(importe) & "," & tipo & "," & obligatorio & ",'" & regimen & "','" & habitaciones & "'" 
			
			' Algunas empresas tienen esta característica
			if idEmpresa = 98 then 
				cs = cs & "," & incluirloenoferta
			end if
			
			cs = cs & ")"
			
			base.execute cs
		
		case "actu"
			cs = "UPDATE " & precrs & "ServiciosPrecios SET "
			cs = cs & "FechaInicio=" & FechaMySQL(finicio) & ","
			cs = cs & "FechaFinal=" & FechaMySQL(ffinal) & ","
			cs = cs & "IdColectivo=" & colectivo & ","
			cs = cs & "Importe=" & quitarComa(importe) & ","
			cs = cs & "Tipo=" & tipo & ","
			cs = cs & "Obligatorio=" & obligatorio & ","
			cs = cs & "Regimen='" & regimen & "',"
			cs = cs & "Habitaciones='" & habitaciones & "'"

			' Algunas empresas tienen esta característica
			if idEmpresa = 98 then 
				cs = cs & ",IncluirEnOferta=" & incluirloenoferta
			end if
			
			cs = cs & " WHERE Id=" & MiId
			'response.write "cs: " & cs & "<br>"
			base.execute cs
	end select
	controlRegistro(cs) 'guarda seguimiento
	pasalir=1
end if
%>