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
adultosextra=adultos-capnormal
if adultosextra<0 then adultosextra=0
	
'Calculo de cuantas personas hay extras 
plazasextras=plazas-capnormal
if plazasextras>0 then 'hay personas extras
	'determinar los extras a que colectivo pertenecen
	if ninos1>plazasextras then 'Hay mas ninos 
		ninosextra1=plazasextras
	else
		ninosextra1=ninos1
	end if
	plazasextras=plazasextras-ninosextra1
	if ninos2>plazasextras then 'Hay mas ninos 
		ninosextra2=plazasextras
	else
		ninosextra2=ninos2
	end if
	plazasextras=plazasextras-ninosextra2
	if adultos>plazasextras then 'Hay mas adultos 
		adultosextra=plazasextras
	else
		adultosextra=adultos
	end if
							
	if PrecioPerso(dia) then 'Calcular si el precio es por persona
		cs="SELECT PreBase,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM DescuentosColectivos "
		cs=cs & "WHERE TipoHab=" & codhab & " AND (temporada=" & codtem & " OR temporada=0) AND Anyo=" & anyo
		'response.write cs & "<br><br/>"
		rs.open cs,base
		losninos1=ninosextra1
		losninos2=ninosextra2
		losAd=adultosextra
		do while not rs.eof
			if rs("prebase")<>0 or rs("precio")<>0 then 'comprobar 
				select case rs("CodigoColec")
					case colecninos1 'niños 1
						if ninos1>0 and losninos1>0 then
							dto=rs("prebase")
							pelas=rs("precio")
							ninosextra=0
							if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
								ninosextra=ninosextra1
							else
								if rs("desdePlazas")<=ninosextra1 then
									cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
									if cuantosNinos>=losninos1 then
										ninosextra=losninos1
									else
										ninosextra=losninos1-cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							losninos1=losninos1-ninosextra 'quito los niños que ya se usan
							if dto<>0 then 'porcentaje
								'Quito redondeo
								dto3perso=dto3perso+redondear(((PrecioHab(dia)-OfertaHab(dia))*dto/100)*ninosextra)
							else 'precio
								dife=redondear((PrecioHab(dia)-pelas)*ninosextra)
								PrecioPlazas(dia)=PrecioPlazas(dia)-dife
								'Si tiene oferta quitar de la oferta, este tiene precio fijo
								if hayoferta then
									totalOferta(dia)=totalOferta(dia)-(ofertaHab(dia)*ninosextra)
								end if
							end if 'dto<>0

						end if 'ninos1>0
						'response.write dtonino1 & "<br>"
					case colecninos2 'niños2
						if ninos2>0 and losninos2>0 then
							dto=rs("prebase")
							pelas=rs("precio")
							ninosextra=0
							if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
								ninosextra=ninosextra2
							else
								if rs("desdePlazas")<=ninosextra2 then
									cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
									if cuantosNinos>=losninos2 then
										ninosextra=losninos2
									else
										ninosextra=losninos2-cuantosNinos
									end if 'cuantosNinos>0
								end if
							end if 'desdeplazas=0
							losninos2=losninos2-ninosextra 'quito los niños que ya se usan
							if dto<>0 then 'porcentaje
								'Quito redondeo
								dto3perso=dto3perso+redondear(((PrecioHab(dia)-OfertaHab(dia))*dto/100)*ninosextra)
							else 'precio
								dife=redondear((PrecioHab(dia)-pelas)*ninosextra)
								PrecioPlazas(dia)=PrecioPlazas(dia)-dife
								'Si tiene oferta quitar de la oferta, este tiene precio fijo
								if hayoferta then
									totalOferta(dia)=totalOferta(dia)-(ofertaHab(dia)*ninosextra)
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
										adExtra=losAd-cuantosAd
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
			end if 'hay dto o precio
			rs.movenext
		loop
		rs.close
		
	end if	 'precio por persona

end if 'hayextras
DtoHab(dia)=dto3perso
%>