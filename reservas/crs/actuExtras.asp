<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")

	modo=request.QueryString("modo")
	if modo<>"borra" then
		fini=request.form("fechainicio")
		ffin=request.form("fechafinal")
		if not isdate(fini) or not isdate(ffin) then 'Fechas incorrectas
			response.write "<html><body><h2>Fechas Incorrectas</h2>"
			response.write "<br><br><input type='button' value='volver' onclick='javascript:window.history.back();'"
			response.write "</body></html>"
			response.End()
		end if
		extra_es=quitarApos(request.form("extra_es"))
		extra_it=quitarApos(request.form("extra_it"))
		extra_en=quitarApos(request.form("extra_en"))
		extra_de=quitarApos(request.form("extra_de"))
		extra_fr=quitarApos(request.form("extra_fr"))
		importe=quitarcoma(request.form("importe"))
		if importe="" then importe=0
		descuento=quitarcoma(request.form("descuento"))
		if descuento="" then descuento=0
		colectivo=request.form("colectivo")
		if colectivo="" then colectivo=0
		porpersona=request.form("porpersona")
		if porpersona="" then porpersona=0
		tiposuple=request.form("tiposuple")
		tipohabi=request.form("tipohabi")
	end if	

	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "Extras WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "nuevo" 'Añadir
			cs="INSERT INTO " & precrs & "Extras (CodigoEsta,FInicio,FFinal,"
			cs=cs & "Extra_es,Extra_it,Extra_en,Extra_de,Extra_fr,"
			cs=cs & "porPersona,Importe,Colectivo,Descuento,TipoSuple,TipoHabi) VALUES ("
			cs=cs & est & "," & FechaMySQL(Fini) & "," & FechaMySQL(FFin) & ",'"
			cs=cs & extra_es & "','" & extra_it & "','" & extra_en & "','" & extra_de & "','"
			cs=cs & extra_fr & "'," & porpersona & "," & importe & ","
			cs=cs & colectivo & "," & descuento & ",'" & tiposuple & "','" & tipohabi & "')"
			response.write(cs)
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			MiId=request.form("id")
			cs="UPDATE " & precrs & "Extras SET "
			cs=cs & "FInicio=" & FechaMySQL(fini) & ","
			cs=cs & "FFinal=" & FechaMySQL(ffin) & ","
			cs=cs & "Extra_es='" & extra_es & "',"
			cs=cs & "Extra_it='" & extra_it & "',"
			cs=cs & "Extra_en='" & extra_en & "',"
			cs=cs & "Extra_de='" & extra_de & "',"
			cs=cs & "Extra_fr='" & extra_fr & "',"
			cs=cs & "Importe=" & importe & ","
			cs=cs & "Colectivo=" & colectivo & ","
			cs=cs & "Descuento=" & descuento & ","
			cs=cs & "porPersona=" & porpersona & ","
			cs=cs & "TipoSuple='" & tiposuple & "',"
			cs=cs & "TipoHabi='" & tipohabi & "' "
			cs=cs & "WHERE Id=" & MiId
			'response.write "cs: " & cs & "<br>"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
	pasalir=1

end if

%>