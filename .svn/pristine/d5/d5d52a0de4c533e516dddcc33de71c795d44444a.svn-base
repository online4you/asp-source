<%
'hace dto a los niños si son 3ª persona o si es precio hab por persona
'Los adultos hace descuento si es 3ª persona

losninos1=ninosextra1
if not precioperso(dia) then losninos1=ninos1 'en caso de ser precio habitacion			
losninos2=ninosextra2
if not precioperso(dia) then losninos2=ninos2 'en caso de ser precio habitacion			
losAd=adultosextra

'Calculo de dtos por suplementos
dtoSuples(dia)=0
cs="SELECT Descuento,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM RegimenDtos "
cs=cs & "WHERE IdRegimenHotel=" & codsuple & " ORDER BY CodigoColec,DesdePlazas"
rs.open cs,base
do while not rs.eof
	select case rs("CodigoColec")
		case colecninos1 'niños 1
			ninosextra=0
			if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
				ninosextra=losninos1					
			else
				if precioperso(dia) then '3ª persona
					if rs("desdePlazas")<=ninosextra1 then
						cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosNinos>=losninos1 then
							ninosextra=losninos1
						else
							ninosextra=losninos1-cuantosNinos
						end if 'cuantosNinos>0
					end if
				else 'por habitacion, se incluyen todos los ninos1
					if rs("desdePlazas")<=ninos1 then
						cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosNinos>=losninos1 then
							ninosextra=losninos1
						else
							ninosextra=losninos1-cuantosNinos
						end if 'cuantosNinos>0
					end if
				end if 'precioperso
			end if 'desdeplazas=0
			
			losninos1=losninos1-ninosextra 'quito los niños que ya se usan	
			if rs("descuento")<>0 then 'porcentaje
				dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs("descuento")/100)
			else
				dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*ninosextra)
			end if
		case colecninos2 'niños2
			ninosextra=0
			if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
				ninosextra=ninosextra2
				if not precioperso(dia) then ninosextra=ninos2 'en caso de ser precio habitacion
			else
				if precioperso(dia) then '3ª persona
					if rs("desdePlazas")<=ninosextra2 then
						cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosNinos>=ninosextra2 then
							ninosextra=ninosextra2
						else
							ninosextra=ninosextra2-cuantosNinos
						end if 'cuantosNinos>0
					end if
				else 'por habitacion, se incluyen todos los ninos1
					if rs("desdePlazas")<=ninos2 then
						cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosNinos>=ninos2 then
							ninosextra=ninos2
						else
							ninosextra=ninos2-cuantosNinos
						end if 'cuantosNinos>0
					end if
				end if 'precioperso
			end if 'desdeplazas=0
			
			if rs("descuento")<>0 then 'porcentaje
				dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs("descuento")/100)
			else
				dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*ninosextra)
			end if
		case colecadultos 'Adulto
			'sólo cuando 3ª persona
			if adultosextra>0 then
				adExtra=0
				if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
					adExtra=adultosextra
				else
					if rs("desdePlazas")<=adultosextra then
						cuantosAd=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosAd>=adultosextra then
							adExtra=adultosextra
						else
							adExtra=adultosextra-cuantosAd
						end if 'cuantosNinos>0
					end if
				end if 'desdeplazas=0
				if rs("descuento")<>0 then 'porcentaje
					dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*adExtra*rs("descuento")/100)
				else
					dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*adExtra)
				end if
			end if

	end select
	rs.movenext
loop
rs.close
%>