<%
dim Lista()
LHotel=0
LNHabi=1
LNRegimen=2
LPelas=3
LCHabi=4
LCRegi=5
LOferta=6
LTotal=7

nlista=-1

tinicio=0 'valor de la tempo
anthotel=-1
for h=0 to ubound(RegHotel,2)
	est=RegHotel(HoCodi,h)
	if est<>anthotel then 'sólo si es diferente hotel
	
		'Buscar que el hotel tenga temporada
		tieneTempo=false
		if haytempos then
			for t=0 to ubound(RegTempos,2)
				if RegTempos(RTEsta,t)=est then
					tieneTempo=true
					exit for
				end if
			next
		end if
	
		'comprobar si tiene ese regimen el hotel
		tieneregimen=false
		if TRegimen<>0 then
			cs="SELECT Id FROM RegimenHotel WHERE CodigoEsta=" & est & " AND IdRegimen=" & TRegimen & " AND Anyo=" & anyo
			rs.open cs,base
			if not rs.eof then
				tieneregimen=true
			end if
			rs.close
		else 'no se busca
			tieneregimen=true 'es gueno
		end if	
	
		if tieneTempo and tieneregimen then 'Seguimos
			
			if haytipohab then 
				'response.write RegHotel(HoNombre,h) & "<br>"
				'Buscar los colectivos de ese hotel
				cs="SELECT CodigoColec,Orde FROM Colectivos "
				cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY orde"
				'response.write "cs: " & cs & "<br>"
				rs.open cs,base
				do while not rs.eof
					select case rs("orde")
						case 0 'adultos
							colecadultos=rs("CodigoColec")
						case 1 'ninos1
							colecninos1=rs("CodigoColec")
						case 2 'ninos2
							colecninos2=rs("CodigoColec")
					end select
					rs.movenext
				loop
				rs.close
	
				for hab=0 to ubound(RegTipoHab,2)
					'response.write "RegTipoHab(HabHotel,hab):" & RegTipoHab(HabHotel,hab) & "<br>"
					if est=RegTipoHab(HabHotel,hab) then 'esta hab es de este hotel (guena)
						'Comprobar si la habitacion tiene el regimen solicitado
						buenRegimen=true
						if TRegimen<>0 then
							'Buscar el correspondiente a la hab 
							cs="SELECT Id FROM RegimenHotel "
							cs=cs & "WHERE IdRegimen=" & TRegimen & " AND CodigoEsta=" & est & " AND "
							cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) AND Anyo=" & anyo
							'response.write cs & "<br>"
							rs.open cs,base
							if not rs.eof then
								elRegimen=rs("id")
							else 'no hay regimen
								buenRegimen=false								
							end if
							rs.close
							
						else 'buscar regimen por defecto
						
							cs="SELECT Id FROM RegimenHotel "
							cs=cs & "WHERE Defecto<>0 AND CodigoEsta=" & est & " AND "
							cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) AND Anyo=" & anyo
							rs.open cs,base
							if not rs.eof then
								elRegimen=rs("id")
							else 'no hay regimen
								buenRegimen=false
							end if
							rs.close
						end if
						
						%><!--#include file="tieneCupo.asp"--><%
						'response.write "Cupo:" & tieneCupo & "<br>"
						if tieneCupo and buenRegimen then 'seguir calculando
							precioCalculo=0
							nombrehabi=Regtipohab(HabNombre,hab)
							codiHabi=Regtipohab(HabCodi,hab)
							sumaOferta=0
							
							'llamar al modulo de precios habitacion
							parametros="calcuPrecioHabi.asp?ide=" & IdEmpresa & "&est=" & est & "&lang=" & lang & "&fini=" & fini & "&ffin=" & ffin 
							parametros=parametros & "&codhab=" & codihabi & "&ad=" & adultos & "&ni1=" & ninos
							parametros=parametros & "&ni2=0&codsup=" & elRegimen
							'response.write parametros & "<br>"
							
							Set objDom = Server.CreateObject("Microsoft.XMLDOM")
							objDom.async = false
							objDom.validateOnParse = false
							objDom.setProperty "ServerHTTPRequest", true
							if objDom.Load("http://www.planetaweb.es/reservas/webservice/" & parametros) then
						
								For Each objItem in objDom.documentElement.SelectNodes("/data")
									'Datos del hotel
									total=objItem.SelectSingleNode("totalbruto").text
									if isnumeric(total) then
										precioCalculo=paDbl(total)
									end if
									
									'ofertas
									For Each eso in objDom.documentElement.SelectNodes("/data/oferta")
										pelas=paDbl(eso.SelectSingleNode("totaloferta").text)
										sumaOferta=sumaOferta+pelas
									next
									
									For Each esto in objDom.documentElement.SelectNodes("/data/reserva")
										NombreSuple=esto.SelectSingleNode("nomsuple").text
									next 'la reserva
									
								next 'each
							
							end if	
							
							Set objDom = Nothing
							Set objItem = Nothing


							'crear lista
							precioCalculo=redondear(precioCalculo)
							nlista=nlista+1 
							redim preserve Lista(7,nlista)
							
							Lista(LHotel,nlista)=est
							Lista(LNHabi,nlista)=nombrehabi
							Lista(LNRegimen,nlista)=nombresuple
							Lista(LPelas,nlista)=precioCalculo
							Lista(LCHabi,nlista)=codiHabi
							Lista(LCRegi,nlista)=elRegimen
							Lista(LOferta,nlista)=sumaOferta
							Lista(LTotal,nlista)=(precioCalculo-sumaOferta)
							'response.write nombreHabi & "<br>"
						end if 'tieneCupo
						
					end if 'esa hab es de ese hotel
					
				next 'las habis
			end if 'haytipoHab
	
		end if 'tieneTempo
	end if 'diferente hotel
	anthotel=est
next 'Hotel
%>