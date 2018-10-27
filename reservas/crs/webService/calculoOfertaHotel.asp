<%

atodo=0
ahabi=1
asuple=2
preciodiahabi=9999999
preciodiasuple=9999999
'sumaOferta=0
if HayOfertaFR or HayOfertaFE then
	
	for o=0 to ubound(RegLOfertas,2)
	'Noches minimas
	if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
		guena=false
		if HayOfertaFR then guena=true
		if HayOfertaFE AND (d>=RegLOfertas(OfFInicio,o) AND d<=RegLOfertas(OfFFin,o)) then guena=true
		if guena then 'Realizar la oferta
			'Ande se aplica
			select case clng(RegLOfertas(OfAplicar,o))
				case ahabi 'Aplicar en prec. habitacion
					'Pa noches gratis
					if preciodiahabi>(PrecioHabi-DtoHabi) then
						preciodiahabi=PrecioHabi-DtoHabi
					end if
					
					'Mirar si pone t. hab.
					if clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=clng(codiHabi) then 'Calcular
						'if adultosextra<>0 then
							'Cambio vte 
							'DtoHabi=0 'Quitar dto 3ª persona, hay oferta
						'end if
						'Comprobar que tipo de calculo
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
							if PrecioPerso then 'pelas por perso.
								pelasH=PrecioDia*adultos 'por ahora sólo cal. adultos
							else 'por hab
								pelasH=PrecioDia 'por habit.
							end if
							sumaOferta=sumaOferta+Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
						end if
						if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
							dife=0
							if PrecioPerso then 'pelas por perso.
								pelasH=PrecioDia*adultos 'por ahora sólo cal. adultos
								dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))*adultos) 'esoooo
							else 'por hab
								pelasH=PrecioDia 'por habit.
								dife=pelasH-cdbl(RegLOfertas(OfPrecio,o)) 'esoooo
							end if
							sumaOferta=sumaOferta+dife
						end if
					end if

				case asuple 'Aplicar en prec. suplemento
					'Pa noches gratis
					if preciodiasuple>(TotalSuples-DtoSuples) then
						preciodiasuple=TotalSuples-DtoSuples
					end if
				
					'Mirar si pone t. suplemento
					if clng(RegLOfertas(OfCodSuple,o))=0 OR clng(RegLOfertas(OfCodSuple,o))=clng(codsuple) then 'Calcular
						'Comprobar que tipo de calculo
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
							pelasH=PrecioSuples*adultos 'por ahora sólo cal. adultos
							sumaOferta=sumaOferta+Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
						end if
						if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
							dife=(PrecioSuples-cdbl(RegLOfertas(OfPrecio,o)))*adultos 'esoooo
							sumaOferta=sumaOferta+dife
						end if
					end if

				case atodo 'Aplicar todo
					'Pa noches gratis
					if preciodiahabi>(PrecioHabi-DtoHabi) then
						preciodiahabi=PrecioHabi-DtoHabi
					end if
					if preciodiasuple>(TotalSuples-DtoSuples) then
						preciodiasuple=TotalSuples-DtoSuples
					end if
					'response.write "Suple Hab:" & CSuples(dia) & "<br>"
					'response.write "Suple:" & RegLOfertas(OfCodSuple,o) & "<br>"
					'Mirar si pone es guena
					if (clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=Clng(codiHabi)) AND (clng(RegLOfertas(OfCodSuple,o))=0 OR clng(RegLOfertas(OfCodSuple,o))=clng(codsuple)) then 'Calcular
						'response.write "Todo:" & RegLOfertas(OfCodSuple,o) & "<br>"
						'if adultosextra<>0 then
							'cambio vte
							'DtoHabi=0 'Quitar dto 3ª persona, hay oferta
						'end if
						'Comprobar que tipo de calculo
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
							'Mirar dias marcador en la oferta
							midia=diasemana(Weekday(d,vbMonday))
							if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim("" & RegLOfertas(OfDias,o))=""  then
								pelasH=PrecioHabi-DtoHabi
								pelasS=TotalSuples-DtoSuples
								sumaOferta=sumaOferta+Redondear((pelasH+pelasS)*clng(RegLOfertas(OfDto,o))/100)
								'response.write sumaOferta & "<br>"
							end if
						end if
						if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
							dife=0
							'Mirar dias marcador en la oferta
							midia=diasemana(Weekday(d,vbMonday))
							if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then
								if PrecioPerso then 'pelas por perso.
									pelasH=PrecioDia*adultos 'por ahora sólo cal. adultos
									pelasH=PelasH+(PrecioSuples*adultos) 'por ahora sólo cal. adultos
									dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))*adultos) 'esoooo
								else 'por hab
									pelasH=PrecioDia 'por habit.
									pelasH=PelasH+PrecioSuples 'por ahora sólo cal. adultos
									dife=pelasH-cdbl(RegLOfertas(OfPrecio,o)) 'esoooo
								end if
								sumaOferta=sumaOferta+dife
							end if 'dias de la semana
						end if
					end if
			
			end select
	
			'Calculo noches gratis
			if RegLOfertas(OfNochesG,o)<>0 then
				if preciodiahabi<>9999999 then
					sumaOferta=preciodiahabi*RegLOfertas(OfNochesG,o)
				end if
				if preciodiasuple<>9999999 then
					sumaOferta=sumaOferta+(preciodiasuple*RegLOfertas(OfNochesG,o))
				end if
			end if
		end if 'guena

	end if 'las noches min.
	next 'ofertas
end if 'hayoferta

%>