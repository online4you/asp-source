<%
ofertaDia=0
for o=0 to ubound(RegLOfertas,2)
	if RegLOfertas(OfFInicio,o)<=FechaRes(dia) AND RegLOfertas(OfFFin,o)>=FechaRes(dia) then 'es del dia
	'Mirar dias marcador en la oferta (dia de la semana)
	midia=diasemana(Weekday(d,vbMonday))
	if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then 'buen día o está en blanco
	
	if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
		if RegLOfertas(OfAplicar,o)=atodo and RegLOfertas(OfNochesG,o)=0 then 'a todo
			pelasDia=PrecioPlazas(dia)-DtoHab(dia)+TotalSuples(dia)-dtoSuples(dia)
			'response.write pelasDia & "<br>"
			'Solo hacer la oferta si coincide tipo hab y suplemento
			if (RegLOfertas(OfHabi,o)=0 OR RegLOfertas(OfHabi,o)=clng(codhab)) AND (RegLOfertas(OfCodSuple,o)=0 OR RegLOfertas(OfCodSuple,o)=idRegimen) then 'calcular
				'response.write IdRegimen & "<br>"
				if clng(RegLOfertas(OfDto,o))<>0 then 'por %
					ofertaDia=Redondear(pelasDia*RegLOfertas(OfDto,o)/100)
				else 'oferta precio fijo por día
					dife=0
					'dife=pelasDia-(cdbl(RegLOfertas(OfPrecio,o))*plazas) 'esoooo
					dife=pelasDia-cdbl(RegLOfertas(OfPrecio,o)) 'esooooss
					'response.write dife & "<br>"
					ofertaDia=dife
					'response.write ofertaHab(dia) & "<br>"
				end if 'la oferta
				codiOferta(dia)=RegLOfertas(OfId,o)
				totalOferta(dia)=totalOferta(dia)+ofertaDia
				'response.write totalOferta(dia) & "<br>"
				textoOferta(dia)=RegLOfertas(OfTitulo,o)
				
				'registro ofertas
				for xx=0 to ubound(ListaOfertas,2)
					If listaOfertas(RIdOferta,xx)=RegLOfertas(OfId,o) then
						listaOfertas(RPelasOferta,o)=listaOfertas(RPelasOferta,o)+ofertaDia
					end if
				next 'xx 	
				
				
			end if 'es válida
		end if 'todo
	end if 'suficientes noches
	end if 'dia de la semana
	end if 'es del dia
next 'o

%>