<%		if idEmpresa=82 then
			campoNombre="Nombre"
		else
			campoNombre="Nombre_" & lang 
		end if
		campoNombre="Nombre"

		plazas=adultos+ninos1+ninos2
		PrecioHab(dia)=0
		PrecioPlazas(dia)=0
		cs="SELECT Preprebase,Preperhab," & campoNombre & ",ParaCapNormal "
		cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "ON TipoHabitaPrecios.IdHabita=TipoHabitaNombres.Id "
		cs=cs & "WHERE IdHabita=" & codhab & " AND Temporada=" & CodTem
		'response.write cs
		rs.open cs,base
		if not rs.eof then 'Esa temporada
			capnormal=rs("paracapnormal")
			PrecioHab(dia)=rs("Preprebase")
			preperhab=rs("Preperhab")
			nombrehabi=rs(campoNombre)
			if not preperhab then 'precio por persona
				PrecioPlazas(dia)=PrecioHab(dia)*plazas
				PrecioPerso(dia)=true
			else 'por hab.
				PrecioPlazas(dia)=PrecioHab(dia)
				PrecioPerso(dia)=false
			end if
		end if
		rs.close
		
		'Comprobar si hay oferta para el precio de la habitacion
		OfertaHab(dia)=0
		if hayOferta then
			for o=0 to ubound(RegLOfertas,2)
				if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
					if RegLOfertas(OfAplicar,o)=ahabi then 'or RegLOfertas(OfAplicar,o)=atodo then 'habitacion o todo
						if clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=clng(codhab) then 'Calcular
							if clng(RegLOfertas(OfDto,o))<>0 then 'por %
								pelasH=PrecioHab(dia)
								OfertaHab(dia)=OfertaHab(dia)+Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
							else 'oferta precio fijo hab.
								dife=0
								pelasH=PrecioHab(dia) 
								dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))) 'esoooo
								OfertaHab(dia)=OfertaHab(dia)+dife
								'response.write ofertaHab(dia) & "<br>"
							end if 'la oferta
							codiOferta(dia)=RegLOfertas(OfId,o)
							if preperhab then 'por hab
								totalOferta(dia)=totalOferta(dia)+ofertaHab(dia)
							else 'por persona
								totalOferta(dia)=totalOferta(dia)+(ofertaHab(dia)*plazas)
							end if
							textoOferta(dia)=RegLOfertas(OfTitulo,o)
							'response.write textoOferta(dia) & "<br>"
						end if 'es valida esa habitacion
					end if 'hab o todo
				end if 'suficientes noches
			next 'o
		end if 'hayOferta

%>