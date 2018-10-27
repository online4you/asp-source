<%
'hace dto a los niños si son 3º persona y es precio hab por persona
if precioperso(dia) then '
	losninos1=ninosextra1
	losninos2=ninosextra2
else 'precio por hab
	losninos1=ninos1
	losninos2=ninos2
end if

'Calculo de dtos por suplementos
dtoSuples(dia)=0
cs="SELECT Descuento,CodigoColec,Precio FROM RegimenDtos "
cs=cs & "WHERE IdRegimenHotel=" & codsuple
rs.open cs,base
do while not rs.eof
	select case rs("CodigoColec")
		case colecadultos 'Adulto
			'sólo cuando 3ª persona
			if adultosextra>0 then
				if rs("descuento")<>0 then 'porcentaje
					dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*adultosextra*rs("descuento")/100)
				else
					dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*adultosextra)
				end if
			end if
		case colecninos1 'niños 1
			'sólo cuando 3ª persona
			if rs("descuento")<>0 then 'porcentaje
				'dtoSuples(dia)=dtoSuples(dia)+redondear(PrecioSuples(dia)*ninos1*rs("descuento")/100)
				dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*losninos1*rs("descuento")/100)
				
			else
				'dtoSuples(dia)=dtoSuples(dia)+((PrecioSuples(dia)-rs("precio"))*ninos1)
				dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*losninos1)
			end if
		case colecninos2 'niños2
			'sólo cuando 3ª persona
			if rs("descuento")<>0 then 'porcentaje
				'dtoSuples(dia)=dtoSuples(dia)+redondear(PrecioSuples(dia)*ninos2*rs("descuento")/100)
				dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*losninos2*rs("descuento")/100)
			else
				'dtoSuples(dia)=dtoSuples(dia)+((PrecioSuples(dia)-rs("precio"))*ninos2)
				dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*losninos2)
			end if
	end select
	rs.movenext
loop
rs.close
%>