<%
	on error resume next
	plazas = adultos + ninos1 + ninos2
	PrecioHab(dia) = 0
	PrecioPlazas(dia) = 0
	'response.write dia & "<br>"
	'Precio hab del cupo	
	PrecioHab(dia) = RegPrecios(PPelas,prec)
	
	'Datos habitacion
	cs = "SELECT Preperhab, "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) Nombre, "
	cs = cs & "ParaCapNormal, prePago "
	cs = cs & "FROM (" & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs = cs & "ON TipoHabitaPrecios.IdHabita = TipoHabitaNombres.Id) "
	cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' and Idioma='" & lang & "' "
	cs = cs & "WHERE IdHabita=" & codhab & " AND Temporada=" & CodTem

	'response.write "<--" & cs & "-->" & vbcrlf
	'response.write (cs & "<br>")

	rs.open cs,base
	if not rs.eof then 'Esa temporada
		capnormal = rs("paracapnormal")
		preperhab = rs("Preperhab")
		nombrehabi = rs("nombre")
		prepagoHabi = rs("prePago")
	end if
	rs.close
	if not preperhab then 'precio por persona
		PrecioPlazas(dia) = redondear(PrecioHab(dia) * plazas)
		PrecioPerso(dia) = true
	else 'por hab.
		PrecioPlazas(dia) = redondear(PrecioHab(dia))
		PrecioPerso(dia) = false
	end if
	
	cs = "SELECT * "
	cs = cs & " FROM " & precrs & "Temporadas "
	cs = cs & "WHERE CodigoEsta=" & est
	cs = cs & " AND " & FechaMySQL(FLlegada+dia-1) & " BETWEEN FInicio AND FFinal "
	rs.open cs,base
	'response.write cs & "<br/>"
	
	if not rs.eof then 'Tenemos cod. temporada
		if (IsNumeric(rs.Fields("Prepago"))) then
			PrepagoDia(dia)=rs.Fields("Prepago")
		else
			haytemposDia = false
		end if
	else
		haytemposDia = false
	end if
	rs.close

	
'PrecioPlazas(dia)=PrecioPlazas(dia)+10

	'response.Write("PrecioPlazas(dia)=" & PrecioPlazas(dia) & "<br>")
	'response.Write("PrecioPerso(dia)=" & PrecioPerso(dia) & "<br>")
	'Comprobar si hay oferta para el precio de la habitacion
	OfertaHab(dia) = 0
	OfertaHabPct(dia) = 0
	'response.Write("hayOferta=" & hayOferta & "<br>")
	if hayOferta then	
		for o = 0 to ubound(RegLOfertas, 2)
			'response.Write("ubound(RegLOfertas, 2)=" & ubound(RegLOfertas, 2) & "<br>")
			if RegLOfertas(OfFInicio,o) <= FechaRes(dia) AND RegLOfertas(OfFFin,o)>=FechaRes(dia) then 'es del dia
			'Mirar dias marcador en la oferta (dia de la semana)
			midia=diasemana(Weekday(d,vbMonday))
			'response.Write("instr(RegLOfertas(OfDias,o),midia)=" & instr(RegLOfertas(OfDias,o),midia) & "<br>")
			
			if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then 'buen día o está en blanco
			'response.Write("RegLOfertas(OfNoches,o))=" & RegLOfertas(OfNoches,o) & "<br>")
			if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
				'response.Write("RegLOfertas(OfAplicar,o)=" & RegLOfertas(OfAplicar,o) & "<br>")
				'response.Write("OfAplicar=" & OfAplicar & "<br>")
				'response.Write("ahabi=" & ahabi & "<br>")
				'response.Write("RegLOfertas(OfNochesG,o)=" & RegLOfertas(OfNochesG,o) & "<br>")
				if RegLOfertas(OfAplicar,o)=ahabi and RegLOfertas(OfNochesG,o)=0 then 'or RegLOfertas(OfAplicar,o)=atodo then 'habitacion o todo
					if clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=clng(codhab) then 'Calcular				
						
						'response.Write("clng(RegLOfertas(OfDto,o))=" & clng(RegLOfertas(OfDto,o)) & "<br>")
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
						
							pelasH=PrecioHab(dia)
							dife=Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)														
							OfertaHabPct(dia) = RegLOfertas(OfDto, o)
						else 'oferta precio fijo hab.
							dife=0
							pelasH=PrecioHab(dia) 
							dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))) 'esoooo
							'response.write ofertaHab(dia) & "<br>"
						end if 'la oferta

						codiOferta(dia) = RegLOfertas(OfId, o)
						OfertaHab(dia) = OfertaHab(dia) + dife
						textoOferta(dia) = RegLOfertas(OfTitulo, o)
						
						'registro ofertas
						for xx=0 to ubound(ListaOfertas,2)
							If listaOfertas(RIdOferta, xx)=RegLOfertas(OfId,o) then
								if not preperhab then dife=dife*plazas 'oferta por persona
								listaOfertas(RPelasOferta,o)=listaOfertas(RPelasOferta,o)+dife
							end if
						next 'xx 
						
					end if 'es valida esa habitacion
				end if 'hab o todo
			end if 'suficientes noches
			end if 'dia de la semana
			end if 'de estas fecha
		next 'o
		if preperhab then 'por hab
			totalOferta(dia) = ofertaHab(dia)
		else 'por persona
			totalOferta(dia) = (ofertaHab(dia) * plazas)
			'response.write totalOferta(dia) & "<br>"
		end if
	end if 'hayOferta

%>