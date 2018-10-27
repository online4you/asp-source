	<%
	precioExtras=0
	incluidoEnOferta=false
	
	cs = "SELECT ServiciosExtras.Id, "
	cs=cs & "IF(ISNULL(traduc.Traduccion),ServiciosExtras.Nombre,traduc.Traduccion) AS Titulo,  "
	cs=cs & "IF(ISNULL(traduc.Traduccion),ServiciosExtras.Texto,traduc.Traduccion) AS Descri,  "
	cs=cs & "url  "
	cs = cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras "
	cs = cs & "inner join jos_crs_ServiciosPrecios ServiciosPrecios on ServiciosPrecios.IdServicio=ServiciosExtras.Id "
	cs= cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Traducciones.Tabla = ""ServiciosExtras"" And Traducciones.Campo = ""Nombre"" And Traducciones.Idioma = """ & lang & """)  AS traduc ON ServiciosExtras.Id = traduc.IdReferencia  "
	cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones2 WHERE Traducciones2.Tabla = ""ServiciosExtras"" And Traducciones2.Campo = ""Texto"" And Traducciones2.Idioma = """ & lang & """)  AS traduc2 ON ServiciosExtras.Id = traduc2.IdReferencia  "
	cs = cs & "WHERE Activo<>0 AND (CodigoEsta=0 OR CodigoEsta=" & est & ") "
	cs = cs & "and instr(Habitaciones, '" & codhab & "')!=0 "
	if ids <> 0 then
		cs = cs & "AND Id=" & ids
	end if 'ids
	cs = cs & " group by "
	cs = cs & " ServiciosExtras.Id, "
	cs = cs & " IF(ISNULL(traduc.Traduccion),ServiciosExtras.Nombre,traduc.Traduccion) ,  "
	cs = cs & " IF(ISNULL(traduc.Traduccion),ServiciosExtras.Texto,traduc.Traduccion) ,  url "
	cs = cs & " ORDER BY Orden,Id"
	'response.write cs & "<br><br><br>"
	'response.write "<!--" & cs & "-->"
	rs.open cs, base
	hayservis = false
	if not rs.eof then
		RegServis = rs.getrows
		SId = 0
		STitu = 1
		SDescri = 2
		SURL = 3
		hayservis = true
	end if
	rs.close
	
	for noche = 1 to noches
		TotalExtras(noche)=0
	next
	if hayservis then
		'Generar XML de respuesta
		anteservi = 0
		'response.write ("ubound(RegServis, 2)=" & ubound(RegServis, 2) & "<br>")
		for ss = 0 to ubound(RegServis, 2)
			precioExtras=0
			for noche = 1 to noches
				'Buscar si tiene precio
				cs = "SELECT ServiciosPrecios.*, "
				cs = cs & "IF(ISNULL(traduc.Traduccion),Colectivos.Nombre,traduc.Traduccion) AS Colectivo , Orde   "
				cs = cs & "FROM " & precrs & "ServiciosPrecios ServiciosPrecios LEFT JOIN " & precrs & "Colectivos Colectivos "
				cs = cs & "ON ServiciosPrecios.IdColectivo=Colectivos.CodigoColec "
				cs = cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Traducciones.Tabla = ""Colectivos"" And Traducciones.Campo = ""Nombre"" And Traducciones.Idioma = """ & lang & """)  AS traduc ON Colectivos.CodigoColec = traduc.IdReferencia  "
				
				cs = cs & "WHERE IdServicio=" & RegServis(SId,ss) & " AND ("
				cs = cs & FechaMySQL(FLlegada+(noche-1)) & " BETWEEN FechaInicio AND FechaFinal"
				cs = cs & " OR FechaInicio BETWEEN " & FechaMySQL(FLlegada+(noche-1)) & " AND " & FechaMySQL(FLlegada+(noche-1))
				cs = cs & ") "
				cs = cs & "and instr(Regimen, '" & idRegimen & "')!=0 "
				cs = cs & "and instr(Habitaciones, '" & codhab & "')!=0 "
				
				'response.write("<!--" & vbcrlf)
				'response.write cs & "<br><br><br>" & vbcrlf
				'response.write("hab==" & codhab & "<br>" & vbcrlf)
				'response.write("regimen==" & idRegimen & "<br>" & vbcrlf)

				rs.open cs,base
				'response.write("rs.eof==" & rs.eof & "<br>" & vbcrlf)
				'response.write("-->" & vbcrlf)				
				do while not rs.eof
					'response.write("<!--" & vbcrlf)
					'response.write("noches=" & noches & "<br>"& vbcrlf)
					'response.write("noche=" & noche & "<br>"& vbcrlf)
					'response.write("plazas=" & plazas & "<br>"& vbcrlf)
					'response.write("precioExtras=" & precioExtras & "<br>"& vbcrlf)
					'response.write("rs(Tipo=" & rs("Tipo") & "<br>"& vbcrlf)
					'response.write("rs(importe=" & rs("importe") & "<br>"& vbcrlf)
					'response.write("Obligatorio==" & rs("Obligatorio") & "<br>" & vbcrlf)
					'response.write("porCientoOferta==" & porCientoOferta & "<br>" & vbcrlf)
					'response.write("colecadultos==" & colecadultos & "<br>" & vbcrlf)
					'response.write("IdColectivo==" & rs("IdColectivo") & "<br>" & vbcrlf)
					'response.write("-->" & vbcrlf)
					if (rs("IdColectivo")=colecadultos or rs("IdColectivo")=0) then
						if (rs("Obligatorio")=1) then
							if (rs("Tipo")=4) then 'x habitacion / dia
								precioExtras=redondear((rs("importe")*numHabs))
							elseif  (rs("Tipo")=0)  then 'x persona / Dia
								precioExtras=redondear((rs("importe")*adultos))
							end if
							if (porCientoOferta<>0 and rs("IncluirEnOferta")=1) then
								dtoExtras(noche) = precioExtras*(porCientoOferta/100)
								precioExtras=redondear(precioExtras - (precioExtras*(porCientoOferta/100)))
							end if
						end if
					elseif (rs("IdColectivo")=colecninos1 or rs("IdColectivo")=0) then
						if (rs("Obligatorio")=1) then
							if (rs("Tipo")=4) then 'x habitacion / dia
								precioExtras=redondear((rs("importe")*numHabs))
							elseif  (rs("Tipo")=0)  then 'x persona / Dia
								precioExtras=redondear((rs("importe")*ninos1))
							end if
							if (porCientoOferta<>0 and rs("IncluirEnOferta")=1) then
								dtoExtras(noche) = precioExtras*(porCientoOferta/100)
								precioExtras=redondear(precioExtras - (precioExtras*(porCientoOferta/100)))
							end if
						end if					
					elseif (rs("IdColectivo")=colecninos2 or rs("IdColectivo")=0) then
						if (rs("Obligatorio")=1) then
							if (rs("Tipo")=4) then 'x habitacion / dia
								precioExtras=redondear((rs("importe")*numHabs))
							elseif  (rs("Tipo")=0)  then 'x persona / Dia
								precioExtras=redondear((rs("importe")*ninos2))
							end if
							if (porCientoOferta<>0 and rs("IncluirEnOferta")=1) then
								dtoExtras(noche) = precioExtras*(porCientoOferta/100)
								precioExtras=redondear(precioExtras - (precioExtras*(porCientoOferta/100)))
							end if
						end if					
					end if
					rs.moveNext
					TotalExtras(noche)=TotalExtras(noche) + precioExtras
				loop
			rs.close
			
			'response.write("<!--TotalExtras(noche)==" & TotalExtras(noche) & "<br>" & vbcrlf )
			'TotalExtras(noche)=0
			next
			
		next
	end if
	'response.write("TotalExtras(noche) final==" & TotalExtras(noche) & "<br>")
%>