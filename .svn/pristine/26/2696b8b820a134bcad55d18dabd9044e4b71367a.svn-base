<%
'hace dto a los niños si son 3º persona y es precio hab por persona
if PrecioPerso then '
	losninos1=ninosextra1
	losninos2=ninosextra2
else 'precio por hab
	losninos1=ninos1
	losninos2=ninos2
end if

'Calculo de dtos por suplementos
dtoSuples=0
if codsuple<>0 then 'hay suple
	cs="SELECT Descuento,CodigoColec,Precio FROM RegimenDtos "
	cs=cs & "WHERE IdRegimenHotel=" & codsuple
	rs.open cs,base
	do while not rs.eof
		select case rs("CodigoColec")
			case colecadultos 'Adulto
				'sólo cuando 3ª persona
				if rs("descuento")<>0 then 'porcentaje
					dtoSuples=dtoSuples+redondear(PrecioSuples*adultosextra*rs("descuento")/100)
				else
					dtoSuples=dtoSuples+redondear((PrecioSuples-rs("precio"))*adultosextra)
				end if
			case colecninos1 'niños 1
				'sólo cuando 3ª persona
				if rs("descuento")<>0 then 'porcentaje
					'dtoSuples=dtoSuples+redondear(PrecioSuples*ninos1*rs("descuento")/100)
					dtoSuples=dtoSuples+redondear(PrecioSuples*losninos1*rs("descuento")/100)
				else
					'dtoSuples=dtoSuples+redondear((PrecioSuples-rs("precio"))*ninos1)
					dtoSuples=dtoSuples+redondear((PrecioSuples-rs("precio"))*losninos1)
				end if
			case colecninos2 'niños2
				'sólo cuando 3ª persona
				if rs("descuento")<>0 then 'porcentaje
					'dtoSuples=dtoSuples+redondear(PrecioSuples*ninos2*rs("descuento")/100)
					dtoSuples=dtoSuples+redondear(PrecioSuples*losninos2*rs("descuento")/100)
				else
					'dtoSuples=dtoSuples+redondear((PrecioSuples-rs("precio"))*ninos2)
					dtoSuples=dtoSuples+redondear((PrecioSuples-rs("precio"))*losninos2)
				end if
		end select
		rs.movenext
	loop
	rs.close
end if 'codsuple
%>