<%
'Dtos en colectivos cama supletoria
dtoadulto=0
dtonino1=0
dtonino2=0
dto3perso=0
adultosextra=0
dtoHabi=0
if PrecioPerso then 'Calcular si el precio es por persona
	cs="SELECT PreBase,CodigoColec,Precio FROM DescuentosColectivos "
	cs=cs & "WHERE TipoHab=" & RegTipoHab(HabCodi,hab) & " AND (temporada=" & codtem & " OR temporada=0) AND Anyo=" & anyo
	'response.write cs & "<br><br/>"
	rs.open cs,base
	do while not rs.eof
		select case rs("CodigoColec")
			case colecadultos 'Adulto
				dtoadulto=rs("prebase")
				pelasadulto=rs("precio")
			case colecninos1 'niños 1
				dtonino1=rs("prebase")
				pelasnino1=rs("precio")
				if dtonino1=0 and pelasnino1=0 then 'es gratis
					pelasnino1=-1 '
				end if
				'response.write dtonino1 & "<br>"
			case colecninos2 'niños2
				dtonino2=rs("prebase")
				pelasnino2=rs("precio")
				if dtonino2=0 and pelasnino2=0 then 'es gratis
					pelasnino2=-1 '
				end if
		end select
		rs.movenext
	loop
	rs.close
	
	'Buscar dtos 3 persona o plaza extra
	'Buscar plazas normales en esta habitacion y porcentaje dto del hotel
	nextras=0
	'capnormal=Regtipohab(HabNormal,hab) 'se carga en preciohabi.asp
	
	'Calculo de cuantas personas hay extras 
	nextras=plazas-capnormal
	if nextras>0 then 'hay personas extras
		'Comprobar si hay ninos como 3ª persona
		if ninos1>0 and (dtonino1<>0 or pelasnino1<>0) then 'Aplicar descuento
			if ninos1>nextras then 'Hay mas ninos 
				ninosextra1=nextras
			else
				ninosextra1=ninos1
			end if
			if dtonino1<>0 then 'porcentaje
				'Quito redondeo
				dto3perso=dto3perso+redondear((PrecioDia*dtonino1/100)*ninosextra1)
			else 'precio
				if pelasnino1=-1 then 'gratis
					PrecioHabi=PrecioHabi-redondear(PrecioDia*ninosextra1)
				else						
					dife=redondear((PrecioDia-pelasnino1)*ninosextra1)
					PrecioHabi=PrecioHabi-dife
				end if '-1
			end if				
			nextras=nextras-ninosextra1 'Quitar los que se ha aplicado dto
		end if
		if ninos2>0 and (dtonino2<>0 or pelasnino2<>0) then 'Aplicar descuento
			if ninos2>nextras then 'Hay mas ninos 
				ninosextra2=nextras
			else
				ninosextra2=ninos2
			end if
			if dtonino2<>0 then 'porcentaje
				dto3perso=dto3perso+redondear((PrecioDia*dtonino2/100)*ninosextra2)
			else 'precio
				if pelasnino2=-1 then 'gratis
					PrecioHabi=PrecioHabi-redondear(PrecioDia*ninosextra2)
				else						
					dife=redondear((PrecioDia-pelasnino2)*ninosextra2)
					PrecioHabi=PrecioHabi-dife
				end if '-1
			end if
			nextras=nextras-ninosextra2 'Quitar los que se ha aplicado dto
		end if
		'Comprobar si hay adultos como 3ª persona
		if adultos>0 and (dtoadulto<>0 or pelasadulto<>0) then 'Aplicar descuento
			if adultos>nextras then 'Hay mas adltos 
				adultosextra=nextras
			else
				adultosextra=adultos
			end if
			if dtoadulto<>0 then 'porcentaje
				dto3perso=dto3perso+redondear((PrecioDia*dtoadulto/100)*adultosextra)
			else 'precio
				dife=(PrecioDia-pelasadulto)*adultosextra
				PrecioHabi=PrecioHabi-dife
			end if
			nextras=nextras-adultosextra 'Quitar los que se ha aplicado dto
		end if
	end if 'extras

end if	 'precio por persona
DtoHabi=dto3perso
%>