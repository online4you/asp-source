<%
ofertaDia=0
totalDiasHabiles=ubound(RegPrecios, 2)+1-numDiasGratis
'response.write "<!--"
'response.Write("hayOfertaNoche=" & hayOfertaNoche & "<br>")
'response.Write("numDiasGratis=" & numDiasGratis & "<br>")
'response.Write("ubound(RegPrecios, 2)=" & ubound(RegPrecios, 2)+1 & "<br>")
'response.Write("totalDiasHabiles=" & totalDiasHabiles & "<br>")
'response.Write("ubound(RegLOfertas,2)=" & ubound(RegLOfertas,2) & "<br>")

for o=0 to ubound(RegLOfertas,2)
	if RegLOfertas(OfFInicio,o)<=FechaRes(dia) AND RegLOfertas(OfFFin,o)>=FechaRes(dia) then 'es del dia
	'Mirar dias marcador en la oferta (dia de la semana)
	midia=diasemana(Weekday(d,vbMonday))
	if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then 'buen día o está en blanco
	'response.Write("clng(RegLOfertas(OfNoches,o))=" & clng(RegLOfertas(OfNoches,o)) & "<br>")
	'response.Write("clng(noches)=" & clng(noches) & "<br>")
	if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
		'response.Write("RegLOfertas(OfAplicar,o)=" & RegLOfertas(OfAplicar,o) & "<br>")
		'response.Write("atodo=" & atodo & "<br>")
		'response.Write("RegLOfertas(OfNochesG,o)=" & RegLOfertas(OfNochesG,o) & "<br>")
		if RegLOfertas(OfAplicar,o)=atodo and RegLOfertas(OfNochesG,o)=0 then 'a todo
			'response.write "PrecioPlazas(dia)=" & PrecioPlazas(dia) & "<br>"
			'response.write "DtoHab(dia)=" & DtoHab(dia) & "<br>"
			'response.write "TotalSuples(dia)=" & TotalSuples(dia) & "<br>"
			'response.write "dtoSuples(dia)=" & dtoSuples(dia) & "<br>"
			
			pelasDia=PrecioPlazas(dia)-DtoHab(dia)+TotalSuples(dia)-dtoSuples(dia)
			pelasDia=pelasDia-totalOferta(dia)
			'response.write "pelasDia=" & pelasDia & "<br>"
			
			
			
			'response.write dia & "<br>"
			if (not hayOfertaNoche or dia<=totalDiasHabiles  ) then
			
			'response.write pelasDia & "<br>"
			'Solo hacer la oferta si coincide tipo hab y suplemento
			'response.Write("pelasDia=" & pelasDia & "<br>")
			'response.Write("RegLOfertas(OfHabi,o)=" & RegLOfertas(OfHabi,o) & "<br>")
			'response.Write("codhab=" & codhab & "<br>")
			'response.Write("RegLOfertas(OfCodSuple,o)=" & RegLOfertas(OfCodSuple,o) & "<br>")
			'response.Write("RegLOfertas(OfCodSuple,o))=" & RegLOfertas(OfCodSuple,o) & "<br>")
			'response.Write("idRegimen=" & idRegimen & "<br>")
			if (RegLOfertas(OfHabi,o)=0 OR RegLOfertas(OfHabi,o)=clng(codhab)) AND (RegLOfertas(OfCodSuple,o)=0 OR RegLOfertas(OfCodSuple,o)=idRegimen) then 'calcular
				'response.Write("idRegimen=" & idRegimen & "<br>")
				'response.Write("clng(RegLOfertas(OfDto,o))=" & clng(RegLOfertas(OfDto,o)) & "<br>")
				if clng(RegLOfertas(OfDto,o))<>0 then 'por %
					ofertaDia=Redondear(pelasDia*RegLOfertas(OfDto,o)/100)
					porCientoOferta=clng(RegLOfertas(OfDto,o))

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
			end if
		end if 'todo
	end if 'suficientes noches
	end if 'dia de la semana
	end if 'es del dia
next 'o
'response.write "-->"
%>