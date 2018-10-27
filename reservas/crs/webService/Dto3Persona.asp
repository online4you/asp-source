<%
'Dtos en colectivos cama supletoria
dto3perso=0
adultosextra=0
ninosextra1=0
ninosextra2=0
dtoHab(dia)=0

'Buscar dtos 3 persona o plaza extra
'capnormal=Regtipohab(HabNormal,hab) 'se carga en preciohabi.asp

'comprobar capacidad extra de adultos por si hay dto en regimen
adultosextra = adultos-capnormal
if adultosextra < 0 then adultosextra = 0
'Calculo de cuantas personas hay extras 
plazasextras = plazas - capnormal

if plazasextras > 0 then 'hay personas extras
	'determinar los extras a que colectivo pertenecen	
	if ninos1 > plazasextras then 'Hay mas ninos
		ninosextra1 = plazasextras
	else
		ninosextra1 = ninos1
	end if
	
	plazasextras = plazasextras - ninosextra1
	
	if ninos2 > plazasextras then 'Hay mas ninos 
		ninosextra2 = plazasextras
	else
		ninosextra2 = ninos2
	end if
	
	plazasextras = plazasextras - ninosextra2

	if adultos > plazasextras then 'Hay mas adultos 
		adultosextra = plazasextras
	else
		adultosextra = adultos
	end if
	
	'response.write PrecioPerso(dia) & "<br><br/>"
	if PrecioPerso(dia) then 'Calcular si el precio es por persona
		cs = "SELECT PreBase,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM " & precrs & "DescuentosColectivos DescuentosColectivos "
		cs = cs & "WHERE TipoHab=" & codhab & " AND (temporada=" & codtem & " OR temporada=0) AND Anyo=" & anyo
		cs = cs & " ORDER BY DesdePlazas ASC"
		'response.write cs & "<br><br/>"
		
		rs.open cs, base
		losninos1 = ninosextra1
		losninos2 = ninosextra2
		losAd = adultosextra
		
				

		do while not rs.eof
			if rs("prebase") <> 0 or rs("precio") <> 0 then 'comprobar 
				select case rs("CodigoColec")
					case colecninos1 'niños 1
						if ninos1 > 0 and losninos1 > 0 then
							dto = rs("prebase")
							pelas = rs("precio")
							ninosextra = 0
							
							if rs("desdePlazas") = 0 AND rs("hastaPlazas") = 0 then 'no usa el sistema de 2º niño
								ninosextra = ninosextra1
							else
								if rs("desdePlazas") <= ninosextra1 then
									cuantosninos = rs("hastaPlazas") - rs("desdePlazas") + 1

									if cuantosNinos >= losninos1 then
										ninosextra = losninos1
									else
										'ninosextra = losninos1 - cuantosNinos
										ninosextra = cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0

							losninos1 = losninos1 - ninosextra 'quito los niños que ya se usan

							if dto <> 0 then 'porcentaje
								'Quito redondeo
								dto3perso = dto3perso + redondear(((PrecioHab(dia) - OfertaHab(dia)) * dto / 100) *ninosextra)
							else 'precio
								dife = redondear((PrecioHab(dia) - pelas) * ninosextra)
								PrecioPlazas(dia) = PrecioPlazas(dia) - dife
								'Si tiene oferta quitar de la oferta, este tiene precio fijo
								if hayoferta then
									totalOferta(dia) = totalOferta(dia) - (ofertaHab(dia) * ninosextra)
								end if
							end if 'dto<>0
						end if 'ninos1>0
						'response.write dtonino1 & "<br>"
						
					case colecninos2 'niños2
							'OJO!!!!
						'response.write "<!--" & chr(13)
						'response.write "ninosextra1=" & ninosextra1 & chr(13)
						'response.write "rs(desdePlazas)=" & rs("desdePlazas") & chr(13)
						'response.write "ninos2=" & ninos2 & chr(13)
						'response.write "losninos2=" & losninos2 & chr(13)
						'response.write "dto=" & dto & chr(13)
						'response.write "-->" & chr(13)
						
						if ninos2 > 0 and losninos2 > 0 and (rs("desdePlazas")>ninosextra1 or (rs("desdePlazas") = 0 AND rs("hastaPlazas") = 0)) then
							'Modificación and rs("desdePlazas")>ninosextra1 04/06/2012 para que los ninos2 se tengan en 
							'cuenta segun el cómputo total de la habitación
							
							dto = rs("prebase")
							pelas = rs("precio")
							ninosextra = 0
						
							
							'response.write "<!--" & chr(13)
							'response.write "ninosextra1=" & ninosextra1 & chr(13)
							'response.write "rs(desdePlazas)=" & rs("desdePlazas") & chr(13)
							'response.write "losninos2=" & losninos2 & chr(13)
							'response.write "dto=" & dto & chr(13)
							'response.write "-->" & chr(13)

										
							if rs("desdePlazas") = 0 AND rs("hastaPlazas") = 0 then 'no usa el sistema de 2º niño
								ninosextra = ninosextra2
							else
								'OJO!!!!
								if rs("desdePlazas") <= (ninosextra2+ninosextra1) then
									'Modificación (ninosextra2+ninosextra1) por ninosextra2 04/06/2012 para que los ninos2 se tengan en 
									'cuenta segun el cómputo total de la habitación
									cuantosninos = rs("hastaPlazas") - rs("desdePlazas") + 1
									if cuantosNinos >= losninos2 then
										ninosextra = losninos2
									else
										'ninosextra=losninos2-cuantosNinos
										ninosextra = cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							
							losninos2 = losninos2 - ninosextra 'quito los niños que ya se usan
							
							if dto <> 0 then 'porcentaje
								'Quito redondeo
								dto3perso = dto3perso+redondear(((PrecioHab(dia) - OfertaHab(dia)) * dto / 100) *ninosextra)
							else 'precio
								dife = redondear((PrecioHab(dia) - pelas) * ninosextra)
								PrecioPlazas(dia) = PrecioPlazas(dia) - dife
								
								'Si tiene oferta quitar de la oferta, este tiene precio fijo
								if hayoferta then
									totalOferta(dia) = totalOferta(dia) - (ofertaHab(dia) * ninosextra)
								end if
							end if 'dto<>0
							
						end if 'ninos1>0

					case colecadultos 'Adulto
						if losAd>0 then 'Hay adultos extras
							dto=rs("prebase")
							pelas=rs("precio")
							adExtra=0
							if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
								adExtra=adultosextra
							else
								if rs("desdePlazas")<=adultosextra then
									cuantosAd=rs("hastaPlazas")-rs("desdePlazas")+1
									if cuantosAd>=losAd then
										adExtra=losAd
									else
										'adExtra=losAd-cuantosAd
										adExtra=cuantosAd
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							losAd=losAd-adExtra 'quito los adultos que ya se usan
							if dto<>0 then 'porcentaje
								'Quito redondeo
								dto3perso=dto3perso+redondear(((PrecioHab(dia)-OfertaHab(dia))*dto/100)*adExtra)
							else 'precio
								dife=redondear((PrecioHab(dia)-pelas)*adExtra)
								PrecioPlazas(dia)=PrecioPlazas(dia)-dife
							end if 'dto<>0
						end if 'adultosextra						
				end select 
								'response.Write("rs(CodigoColec)=" & rs("CodigoColec") & "<br>")
								'response.Write("dto3perso=" &dto3perso & "<br>")
								'response.Write("PrecioHab(dia)=" &PrecioHab(dia) & "<br>")
								'response.Write("OfertaHab(dia)=" & OfertaHab(dia) & "<br>")
								'response.Write("dto=" & dto & "<br>")
								'response.Write("ninosextra=" & ninosextra & "<br>")
								'response.Write("PrecioPlazas(dia)" & PrecioPlazas(dia) & "<br>")

			end if 'hay dto o precio
			rs.movenext
		loop
		rs.close
		
	else	 	'end precio por persona
				'precio por habitacion
		cs = "SELECT PreBase,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM " & precrs & "DescuentosColectivos DescuentosColectivos "
		cs = cs & "WHERE TipoHab=" & codhab & " AND (temporada=" & codtem & " OR temporada=0) AND Anyo=" & anyo
		cs = cs & " ORDER BY DesdePlazas ASC"
		'response.write cs & "<br><br/>"
		
		rs.open cs, base
		losninos1 = ninosextra1
		losninos2 = ninosextra2
		losAd = adultosextra

		do while not rs.eof
			if rs("precio") <> 0 then 'comprobar 
				select case rs("CodigoColec")
					case colecninos1 'niños 1
						if ninos1 > 0 and losninos1 > 0 then
							'dto = rs("prebase")
							pelas = rs("precio")
							ninosextra = 0
							
							if rs("desdePlazas") = 0 AND rs("hastaPlazas") = 0 then 'no usa el sistema de 2º niño
								ninosextra = ninosextra1
							else
								if rs("desdePlazas") <= ninosextra1 then
									cuantosninos = rs("hastaPlazas") - rs("desdePlazas") + 1

									if cuantosNinos >= losninos1 then
										ninosextra = losninos1
									else
										'ninosextra = losninos1 - cuantosNinos
										ninosextra = cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0

							losninos1 = losninos1 - ninosextra 'quito los niños que ya se usan
							PrecioPlazas(dia)=PrecioPlazas(dia)+(pelas*ninosextra)
							
						end if 'ninos1>0
						'response.write dtonino1 & "<br>"
						
					case colecninos2 'niños2
						if ninos2 > 0 and losninos2 > 0 then
							'dto = rs("prebase")
							pelas = rs("precio")
							ninosextra = 0
							if rs("desdePlazas") = 0 AND rs("hastaPlazas") = 0 then 'no usa el sistema de 2º niño
								ninosextra = ninosextra2
							else
								if rs("desdePlazas") <= ninosextra2 then
									cuantosninos = rs("hastaPlazas") - rs("desdePlazas") + 1

									if cuantosNinos >= losninos2 then
										ninosextra = losninos2
									else
										'ninosextra=losninos2-cuantosNinos
										ninosextra = cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							
							losninos2 = losninos2 - ninosextra 'quito los niños que ya se usan
							PrecioPlazas(dia)=PrecioPlazas(dia)+(pelas*ninosextra)
						end if 'ninos1>0

					case colecadultos 'Adulto
						if losAd>0 then 'Hay adultos extras
							'dto=rs("prebase")
							pelas=rs("precio")
							adExtra=0
							if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
								adExtra=adultosextra
							else
								if rs("desdePlazas")<=adultosextra then
									cuantosAd=rs("hastaPlazas")-rs("desdePlazas")+1
									if cuantosAd>=losAd then
										adExtra=losAd
									else
										'adExtra=losAd-cuantosAd
										adExtra=cuantosAd
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							losAd=losAd-adExtra 'quito los adultos que ya se usan
							PrecioPlazas(dia)=PrecioPlazas(dia)+(pelas*adExtra)
						end if 'adultosextra						
				end select 
								'response.Write("rs(CodigoColec)=" & rs("CodigoColec") & "<br>")
								'response.Write("dto3perso=" &dto3perso & "<br>")
								'response.Write("PrecioHab(dia)=" &PrecioHab(dia) & "<br>")
								'response.Write("OfertaHab(dia)=" & OfertaHab(dia) & "<br>")
								'response.Write("dto=" & dto & "<br>")
								'response.Write("ninosextra=" & ninosextra & "<br>")
								'response.Write("PrecioPlazas(dia)" & PrecioPlazas(dia) & "<br>")

			end if 'hay dto o precio
			rs.movenext
		loop
		rs.close
		
	end if	 'end precio por habitacion
end if 'hayextras
DtoHab(dia)=dto3perso
%>