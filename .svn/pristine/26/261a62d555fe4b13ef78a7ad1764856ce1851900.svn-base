<%
	plazas=adultos+ninos1+ninos2
	PrecioHab(dia)=0
	PrecioPlazas(dia)=0

	'Precio hab del cupo	
	PrecioHab(dia)=RegPrecios(PPelas,prec)
	
	if not preperhab then 'precio por persona
		PrecioPlazas(dia)=redondear(PrecioHab(dia)*plazas)
		PrecioPerso(dia)=true
	else 'por hab.
		PrecioPlazas(dia)=redondear(PrecioHab(dia))
		PrecioPerso(dia)=false
	end if
	
	'Comprobar si hay oferta para el precio de la habitacion
	OfertaHab(dia)=0
	if hayOferta then
		for o=0 to ubound(RegLOfertas,2)
			if RegLOfertas(OfFInicio,o)<=FechaRes(dia) AND RegLOfertas(OfFFin,o)>=FechaRes(dia) then 'es del dia
			'Mirar dias marcador en la oferta (dia de la semana)
			midia=diasemana(Weekday(d,vbMonday))
			if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then 'buen día o está en blanco
							
			if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
				if RegLOfertas(OfAplicar,o)=ahabi and RegLOfertas(OfNochesG,o)=0 then 'or RegLOfertas(OfAplicar,o)=atodo then 'habitacion o todo
					if clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=clng(codhab) then 'Calcular
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
							pelasH=PrecioHab(dia)
							dife=Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
						else 'oferta precio fijo hab.
							dife=0
							pelasH=PrecioHab(dia) 
							dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))) 'esoooo
							'response.write ofertaHab(dia) & "<br>"
						end if 'la oferta
						codiOferta(dia)=RegLOfertas(OfId,o)
						OfertaHab(dia)=OfertaHab(dia)+dife
						textoOferta(dia)=RegLOfertas(OfTitulo,o)
						
						'registro ofertas
						for xx=0 to ubound(ListaOfertas,2)
							If listaOfertas(RIdOferta,xx)=RegLOfertas(OfId,o) then
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
			totalOferta(dia)=ofertaHab(dia)
		else 'por persona
			totalOferta(dia)=(ofertaHab(dia)*plazas)
			'response.write totalOferta(dia) & "<br>"
		end if
	end if 'hayOferta

%>