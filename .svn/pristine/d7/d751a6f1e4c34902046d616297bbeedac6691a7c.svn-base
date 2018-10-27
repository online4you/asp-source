<%
'hace dto a los niños si son 3ª persona o si es precio hab por persona
'Los adultos hace descuento si es 3ª persona

losninos1=ninosextra1
if not precioperso(dia) then losninos1=ninos1 'en caso de ser precio habitacion			
losninos2=ninosextra2
if not precioperso(dia) then losninos2=ninos2 'en caso de ser precio habitacion			
losAd=adultosextra
cuantosNinos1=0
'Calculo de dtos por suplementos
dtoSuples(dia)=0
cs="SELECT Descuento,CodigoColec,Precio,DesdePlazas,HastaPlazas FROM " & precrs & "RegimenDtos RegimenDtos "
cs=cs & "WHERE IdRegimenHotel=" & codsuple & " ORDER BY CodigoColec,DesdePlazas"
'response.Write(cs & "<br>")
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
							'ninosextra=losninos1-cuantosNinos
							ninosextra=cuantosNinos
						end if 'cuantosNinos>0
					end if
				else 'por habitacion, se incluyen todos los ninos1
					if rs("desdePlazas")<=ninos1 then
						cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosNinos>=losninos1 then
							ninosextra=losninos1
						else
							'ninosextra=losninos1-cuantosNinos
							ninosextra=cuantosNinos
						end if 'cuantosNinos>0
					end if
				end if 'precioperso
			end if 'desdeplazas=0
			
			losninos1=losninos1-ninosextra 'quito los niños que ya se usan	
			
			cuantosNinos1=cuantosNinos1+ninosextra
			if rs("descuento")<>0 then 'porcentaje
				dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs("descuento")/100)
			else
				if (PrecioSuples(dia)>rs("precio")) then 
					dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*ninosextra)
				end if 
			end if
			
		case colecadultos 'Adulto
			'sólo cuando 3ª persona

			if adultosextra>0 then
				adExtra=0
				'response.Write("adultosextra=" & adultosextra & "<br>")
			
			'response.Write("rs(desdePlazas)=" & rs("desdePlazas") & "<br>")
			'response.Write("rs(hastaPlazas)=" & rs("hastaPlazas") & "<br>")			

				if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
					adExtra=adultosextra
				else
					if rs("desdePlazas")<=adultosextra then
						cuantosAd=rs("hastaPlazas")-rs("desdePlazas")+1
						if cuantosAd>=adultosextra then
							adExtra=adultosextra
						else
							'adExtra=adultosextra-cuantosAd
							adExtra=cuantosAd
						end if 'cuantosNinos>0
					end if
				end if 'desdeplazas=0
				'response.Write("adExtra=" & adExtra & "<br>")
				'response.Write("descuento=" & rs("descuento") & "<br>")
				'response.Write("dtoSuples(dia)=" &dtoSuples(dia) & "<br>")
				if rs("descuento")<>0 then 'porcentaje
					dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*adExtra*rs("descuento")/100)
					'response.Write("(PrecioSuples(dia)-ofertaRegimen(dia))*adExtra*rs(4descuento4)/100=" &(PrecioSuples(dia)-ofertaRegimen(dia))*adExtra*rs("descuento")/100 & "<br>")

				else
					if (PrecioSuples(dia)>rs("precio")) then 
						dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*adExtra)
					end if
				end if
				
				
			end if

	end select
	rs.movenext
loop
rs.close

'response.Write("<br><br><br><br><br><br><br>Ninos 2:<br><br>")
losninos2=0
rs.open cs,base
do while not rs.eof
	select case rs("CodigoColec")
		case colecninos2 'niños2
			ninosextra=0
			if (rs("desdePlazas")>cuantosNinos1) then
				if rs("desdePlazas")=0 AND rs("hastaPlazas")=0 then 'no usa el sistema de 2º niño
					ninosextra=ninosextra2
					'if not precioperso(dia) then ninosextra=ninos2 'en caso de ser precio habitacion
				else
						if precioperso(dia) then '3ª persona
							if rs("desdePlazas")<=(ninosextra2+cuantosNinos1) then
								cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
								'response.Write("cuantosninos=" &cuantosninos& "<br>")
								'response.Write("ninosextra2=" &ninosextra2& "<br>")
								'response.Write("cuantosNinos1=" &cuantosNinos1& "<br>")
								if cuantosNinos>=(ninosextra2+cuantosNinos1) then
									ninosextra=ninosextra2-losninos2
								else
									'ninosextra=ninosextra2-cuantosNinos
									ninosextra=cuantosNinos
								end if 'cuantosNinos>0
							end if
						else 'por habitacion, se incluyen todos los ninos1
							if rs("desdePlazas")<=(ninos2+cuantosNinos1) then
								cuantosninos=rs("hastaPlazas")-rs("desdePlazas")+1
								if cuantosNinos>=(ninos2+cuantosNinos1) then
									ninosextra=ninos2-losninos2
								else
									'ninosextra=ninos2-cuantosNinos
									ninosextra=cuantosNinos
								end if 'cuantosNinos>0
							end if
						end if 'precioperso
					end if 'desdeplazas=0
					
					losninos2=losninos2+ninosextra 'quito los niños que ya se usan	

					if rs("descuento")<>0 then 'porcentaje
						dtoSuples(dia)=dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs("descuento")/100)
					else
						if (PrecioSuples(dia)>rs("precio")) then 
							dtoSuples(dia)=dtoSuples(dia)+(((PrecioSuples(dia)-ofertaRegimen(dia))-rs("precio"))*ninosextra)
						end if
					end if
				
				'response.Write("dia=" &dia & "<br>")
				'response.Write("rs(CodigoColec)=" &rs("CodigoColec") & "<br>")
				'response.Write("rs(desdePlazas)=" &rs("desdePlazas") & "<br>")
				'response.Write("rs(hastaPlazas)=" &rs("hastaPlazas") & "<br>")
				'response.Write("ninosextra=" &ninosextra & "<br>")
				'response.Write("ninosextra1=" &ninosextra1 & "<br>")
				'response.Write("ninosextra2=" &ninosextra2 & "<br>")
				'response.Write("cuantosNinos1=" &cuantosNinos1 & "<br>")
				'response.Write("rs(descuento)=" & rs("descuento")& "<br>")
				'response.Write("dtoSuples(dia)=" &dtoSuples(dia) & "<br>")
				'response.Write("PrecioSuples(dia)=" &PrecioSuples(dia) & "<br>")
				'response.Write("ofertaRegimen(dia)=" &ofertaRegimen(dia) & "<br>")
				'response.Write("adExtra=" &adExtra & "<br>")
				'response.Write("rs(precio)=" &rs("precio") & "<br>")
				'response.Write("dtoSuples(dia)+redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs(descuento)/100)="& redondear((PrecioSuples(dia)-ofertaRegimen(dia))*ninosextra*rs("descuento")/100) &"<br>")
				'response.Write("<br>")
			end if
				
	end select
	rs.movenext
loop
rs.close
%>