<%
'Busco tabla de ofertas del hotel de fecha estancia
cs="SELECT Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
cs=cs & "Dto,Precio,Titulo_" & lang & ",Texto1_" & lang & ",NochesGratis,DiasSemana FROM Ofertas "
cs=cs & "WHERE CodigoEsta=" & est & " AND FechaReserva=0 AND "
cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) OR "
cs=cs & "(" & FechaMySQL(FSalida) & " BETWEEN FechaInicio AND FechaFin) OR "
cs=cs & "(" & FechaMySQL(FLlegada) & "<FechaInicio AND " & FechaMySQL(FSalida) & ">FechaFin))"
hayOfertaFE=false
rs.open cs,base
if not rs.eof then
	RegLOfertas=rs.getrows
	OfId=0
	OfHabi=1
	OfAplicar=2
	OfCodSuple=3
	OfFInicio=4
	OfFFin=5
	OfNoches=6
	OfDto=7
	OfPrecio=8
	OfTitulo=9
	OfTexto=10
	OfNochesG=11
	OfDias=12
	hayOfertaFE=true
	'response.write ubound(RegLOfertas,2) & "<br>"
end if
rs.close

'Buscar si tiene oferta para fecha reserva
'Busco tabla de ofertas del hotel de fecha estancia
cs="SELECT Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
cs=cs & "Dto,Precio,Titulo_" & lang & ",Texto1_" & lang & ",NochesGratis,DiasSemana FROM Ofertas "
cs=cs & "WHERE CodigoEsta=" & est & " AND FechaReserva<>0 AND "
cs=cs & "(" & FechaMySQL(date) & " BETWEEN FechaInicio AND FechaFin)"
rs.open cs,base
HayOfertaFR=false
if not rs.eof then
	RegLOfertas=rs.getrows
	OfId=0
	OfHabi=1
	OfAplicar=2
	OfCodSuple=3
	OfFInicio=4
	OfFFin=5
	OfNoches=6
	OfDto=7
	OfPrecio=8
	OfTitulo=9
	OfTexto=10
	OfNochesG=11
	OfDias=12
	hayOfertaFR=true
	hayOfertaFE=false 'Para que no busque mas
end if
rs.close

'dias semana
dim diasemana(7)
diasemana(1)="L"
diasemana(2)="M"
diasemana(3)="X"
diasemana(4)="J"
diasemana(5)="V"
diasemana(6)="S"
diasemana(7)="D"

dim TotalOferta(),CodiOferta(),TextoOferta()
atodo=0
ahabi=1
asuple=2
preciodiahabi=9999999
preciodiasuple=9999999
if HayOfertaFR or HayOfertaFE then
	redim TotalOferta(ubound(RegLOfertas,2))
	redim codiOferta(ubound(RegLOfertas,2))
	redim textoOferta(ubound(RegLOfertas,2))
	for o=0 to ubound(RegLOfertas,2)
	sumaOferta=0
	'Noches minimas
	if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
		dia=0
		for d=FLlegada to FSalida-1
			'Comprobar dia
			dia=dia+1
			guena=false
			if HayOfertaFR then guena=true
			if HayOfertaFE AND (d>=RegLOfertas(OfFInicio,o) AND d<=RegLOfertas(OfFFin,o)) then guena=true
			if guena then 'Realizar la oferta
				'Ande se aplica
				select case clng(RegLOfertas(OfAplicar,o))
					case ahabi 'Aplicar en prec. habitacion
						'Pa noches gratis
						if preciodiahabi>(PrecioPLazas(dia)-DtoHab(dia)) then
							preciodiahabi=PrecioPLazas(dia)-DtoHab(dia)
						end if
						
						'Mirar si pone t. hab.
						if clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=clng(codhab) then 'Calcular
							'if adultosextra<>0 then
								'Cambio vte 
								'DtoHab(dia)=0 'Quitar dto 3ª persona, hay oferta
							'end if
							'Comprobar que tipo de calculo
							if clng(RegLOfertas(OfDto,o))<>0 then 'por %
								if PrecioPerso(dia) then 'pelas por perso.
									pelasH=PrecioHab(dia)*adultos 'por ahora sólo cal. adultos
								else 'por hab
									pelasH=PrecioHab(dia) 'por habit.
								end if
								sumaOferta=sumaOferta+Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
							end if
							if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
								dife=0
								if PrecioPerso(dia) then 'pelas por perso.
									pelasH=PrecioHab(dia)*adultos 'por ahora sólo cal. adultos
									dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))*adultos) 'esoooo
								else 'por hab
									pelasH=PrecioHab(dia) 'por habit.
									dife=pelasH-cdbl(RegLOfertas(OfPrecio,o)) 'esoooo
								end if
								sumaOferta=sumaOferta+dife
							end if
						end if

					case asuple 'Aplicar en prec. suplemento
						'Pa noches gratis
						if preciodiasuple>(TotalSuples(dia)-DtoSuples(dia)) then
							preciodiasuple=TotalSuples(dia)-DtoSuples(dia)
						end if
					
						'Mirar si pone t. suplemento
						if clng(RegLOfertas(OfCodSuple,o))=0 OR clng(RegLOfertas(OfCodSuple,o))=clng(codsuple) then 'Calcular
							'Comprobar que tipo de calculo
							if clng(RegLOfertas(OfDto,o))<>0 then 'por %
								pelasH=PrecioSuples(dia)*adultos 'por ahora sólo cal. adultos
								sumaOferta=sumaOferta+Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)
							end if
							if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
								dife=(PrecioSuples(dia)-cdbl(RegLOfertas(OfPrecio,o)))*adultos 'esoooo
								sumaOferta=sumaOferta+dife
							end if
						end if

					case atodo 'Aplicar todo
						'Pa noches gratis
						if preciodiahabi>(PrecioPLazas(dia)-DtoHab(dia)) then
							preciodiahabi=PrecioPLazas(dia)-DtoHab(dia)
						end if
						if preciodiasuple>(TotalSuples(dia)-DtoSuples(dia)) then
							preciodiasuple=TotalSuples(dia)-DtoSuples(dia)
						end if
						'response.write "Suple Hab:" & CSuples(dia) & "<br>"
						'response.write "Suple:" & RegLOfertas(OfCodSuple,o) & "<br>"
						'Mirar si pone es guena
						if (clng(RegLOfertas(OfHabi,o))=0 OR clng(RegLOfertas(OfHabi,o))=Clng(codhab)) AND (clng(RegLOfertas(OfCodSuple,o))=0 OR clng(RegLOfertas(OfCodSuple,o))=clng(codsuple)) then 'Calcular
							'response.write "Todo:" & RegLOfertas(OfCodSuple,o) & "<br>"
							'if adultosextra<>0 then
								'cambio vte
								'DtoHab(dia)=0 'Quitar dto 3ª persona, hay oferta
							'end if
							'Comprobar que tipo de calculo
							if clng(RegLOfertas(OfDto,o))<>0 then 'por %
								'Mirar dias marcador en la oferta
								midia=diasemana(Weekday(d,vbMonday))
								if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim("" & RegLOfertas(OfDias,o))=""  then
									pelasH=PrecioPLazas(dia)-DtoHab(dia)
									pelasS=TotalSuples(dia)-DtoSuples(dia)
									sumaOferta=sumaOferta+Redondear((pelasH+pelasS)*clng(RegLOfertas(OfDto,o))/100)
									'response.write sumaOferta & "<br>"
								end if
							end if
							if cdbl(RegLOfertas(OfPrecio,o))<>0 then 'por precio fijo
								dife=0
								'Mirar dias marcador en la oferta
								midia=diasemana(Weekday(d,vbMonday))
								if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then
									if PrecioPerso(dia) then 'pelas por perso.
										pelasH=PrecioHab(dia)*adultos 'por ahora sólo cal. adultos
										pelasH=PelasH+(PrecioSuples(dia)*adultos) 'por ahora sólo cal. adultos
										dife=pelasH-(cdbl(RegLOfertas(OfPrecio,o))*adultos) 'esoooo
									else 'por hab
										pelasH=PrecioHab(dia) 'por habit.
										pelasH=PelasH+PrecioSuples(dia) 'por ahora sólo cal. adultos
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
		next 'dia
	end if 'las noches min.
	totalOferta(o)=sumaOferta
	codiOferta(o)=RegLOfertas(OfId,o)
	textoOferta(o)=RegLOfertas(OfTitulo,o)
	next 'ofertas
end if 'hayoferta
%>