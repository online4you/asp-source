<%
'oferta VIP en el regimen (intercambio regimen)
sumaRegimen=0

codtem=0
if haytempos then
for t=0 to ubound(RegTempos,2)
	if RegTempos(TFIni,t)<=laFecha and RegTempos(TFFin,t)>=laFecha then 'este es
		codtem=RegTempos(TCodi,t)
		exit for
	end if
next 'tempos
end if 'haytempos
	
'Buscar el correspondiente a la hab y la temporada
cs="SELECT Precio,RegimenHotel.Id "
cs=cs & "FROM RegimenHotel INNER JOIN Regimen "
cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
cs=cs & "WHERE IdRegimen=" & oferta_regimen & " AND RegimenHotel.CodigoEsta=" & est
cs=cs & " AND (Codigotempo=" & CodTem & " OR CodigoTempo=0) AND "
cs=cs & "(CodigoHab=" & codhab & " OR CodigoHab=0) AND Anyo=" & anyo
'response.write cs
rs2.open cs,base
if not rs2.eof then
	codsuple=rs2("Id")
	precioRegimen=redondear(rs2("precio"))
	sumaRegimen=redondear(rs2("precio")*plazas)
	haysuples=true
end if
rs2.close

'hace dto a los niños si son 3ª persona o si es precio hab por persona
'Los adultos hace descuento si es 3ª persona

losninos1=ninosextra1
if not precioperso(dia) then losninos1=ninos1 'en caso de ser precio habitacion			
losninos2=ninosextra2
if not precioperso(dia) then losninos2=ninos2 'en caso de ser precio habitacion			
losAd=adultosextra

'Calculo de dtos por suplementos
dtoRegimen=0
cs="SELECT Descuento,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM RegimenDtos "
cs=cs & "WHERE IdRegimenHotel=" & codsuple & " ORDER BY CodigoColec,DesdePlazas"
rs2.open cs,base
do while not rs2.eof
	select case rs2("CodigoColec")
		case colecninos1 'niños 1
			ninosextra=0
			if rs2("desdePlazas")=0 AND rs2("hastaPlazas")=0 then 'no usa el sistema de 2º niño
				ninosextra=losninos1					
			else
				if precioperso(dia) then '3ª persona
					if rs2("desdePlazas")<=ninosextra1 then
						cuantosninos=rs2("hastaPlazas")-rs2("desdePlazas")+1
						if cuantosNinos>=losninos1 then
							ninosextra=losninos1
						else
							ninosextra=losninos1-cuantosNinos
						end if 'cuantosNinos>0
					end if
				else 'por habitacion, se incluyen todos los ninos1
					if rs2("desdePlazas")<=ninos1 then
						cuantosninos=rs2("hastaPlazas")-rs2("desdePlazas")+1
						if cuantosNinos>=losninos1 then
							ninosextra=losninos1
						else
							ninosextra=losninos1-cuantosNinos
						end if 'cuantosNinos>0
					end if
				end if 'precioperso
			end if 'desdeplazas=0
			
			losninos1=losninos1-ninosextra 'quito los niños que ya se usan	
			if rs2("descuento")<>0 then 'porcentaje
				dtoRegimen=dtoRegimen+redondear(PrecioRegimen*ninosextra*rs2("descuento")/100)
			else
				dtoRegimen=dtoRegimen+((PrecioRegimen-rs2("precio"))*ninosextra)
			end if
		case colecninos2 'niños2
			ninosextra=0
			if rs2("desdePlazas")=0 AND rs2("hastaPlazas")=0 then 'no usa el sistema de 2º niño
				ninosextra=ninosextra2
				if not precioperso(dia) then ninosextra=ninos2 'en caso de ser precio habitacion
			else
				if precioperso(dia) then '3ª persona
					if rs2("desdePlazas")<=ninosextra2 then
						cuantosninos=rs2("hastaPlazas")-rs2("desdePlazas")+1
						if cuantosNinos>=ninosextra2 then
							ninosextra=ninosextra2
						else
							ninosextra=ninosextra2-cuantosNinos
						end if 'cuantosNinos>0
					end if
				else 'por habitacion, se incluyen todos los ninos1
					if rs2("desdePlazas")<=ninos2 then
						cuantosninos=rs2("hastaPlazas")-rs2("desdePlazas")+1
						if cuantosNinos>=ninos2 then
							ninosextra=ninos2
						else
							ninosextra=ninos2-cuantosNinos
						end if 'cuantosNinos>0
					end if
				end if 'precioperso
			end if 'desdeplazas=0
			
			if rs2("descuento")<>0 then 'porcentaje
				dtoRegimen=dtoRegimen+redondear(PrecioRegimen*ninosextra*rs2("descuento")/100)
			else
				dtoRegimen=dtoRegimen+((PrecioRegimen-rs2("precio"))*ninosextra)
			end if
		case colecadultos 'Adulto
			'sólo cuando 3ª persona
			if adultosextra>0 then
				adExtra=0
				if rs2("desdePlazas")=0 AND rs2("hastaPlazas")=0 then 'no usa el sistema de 2º niño
					adExtra=adultosextra
				else
					if rs2("desdePlazas")<=adultosextra then
						cuantosAd=rs2("hastaPlazas")-rs2("desdePlazas")+1
						if cuantosAd>=adultosextra then
							adExtra=adultosextra
						else
							adExtra=adultosextra-cuantosAd
						end if 'cuantosNinos>0
					end if
				end if 'desdeplazas=0
				if rs2("descuento")<>0 then 'porcentaje
					dtoRegimen=dtoRegimen+redondear(PrecioRegimen*adExtra*rs2("descuento")/100)
				else
					dtoRegimen=dtoRegimen+((PrecioRegimen-rs2("precio"))*adExtra)
				end if
			end if

	end select
	rs2.movenext
loop
rs2.close

sumaRegimen=sumaRegimen-dtoRegimen	
%>