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
LEstadoH=8
LOfertaTem = 9
LOfertasPct=10
nlista=-1

'Array de las lineas de precios
dim PrecioHab(),Preciosuples(),TotalSuples(),PrecioPlazas(),DtoHab(),DtoSuples()
dim FechaRes(),PrecioPerso()
dim OfertaHab(),OfertaRegimen(),OfertaHabPct(),OfertaRegimenPct()
dim TotalOferta(),CodiOferta(),TextoOferta()

anthotel=-1

for h=0 to ubound(RegHotel,2)
	est=RegHotel(HoCodi,h)
	if est<>anthotel then 'sólo si es diferente hotel
		anyo=year(fini) 'año inicial
		'comprobar si tiene ese regimen el hotel
		tieneregimen=false
		if TRegimen<>0 then
			cs="SELECT Id FROM RegimenHotel WHERE CodigoEsta=" & est & " AND IdRegimen=" & TRegimen & " AND Anyo=" & anyo		
			'response.write(cs)
			rs.open cs,base
			if not rs.eof then
				tieneregimen=true
			end if
			rs.close
		else 'no se busca
			tieneregimen=true 'es gueno
		end if	
	
		if tieneregimen then 'Seguimos
			
			if haytipohab then 
				for hab=0 to ubound(RegTipoHab,2)
					if est=RegTipoHab(HabHotel,hab) then 'esta hab es de este hotel (guena)
						'Comprobar si la habitacion tiene el regimen solicitado
						buenRegimen=true
						if TRegimen<>0 then
							'Buscar el correspondiente a la hab 
							cs="SELECT Id FROM RegimenHotel "
							cs=cs & "WHERE IdRegimen=" & TRegimen & " AND CodigoEsta=" & est & " AND "
							cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) "
							cs=cs & " AND Anyo=" & anyo
							
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
								elRegimen = rs("id")
							else 'no hay regimen
								buenRegimen=false
							end if
							rs.close
							
							if not buenRegimen then 'cargo por defecto el primero
								cs="SELECT TOP 1 Id FROM RegimenHotel "
								cs=cs & "WHERE CodigoEsta=" & est & " AND "
								cs=cs & "(CodigoHab=" & RegTipoHab(HabCodi,hab) & " OR CodigoHab=0) AND Anyo=" & anyo
								cs=cs & " ORDER BY IdRegimen"

								rs.open cs,base
								if not rs.eof then
									elRegimen=rs("id")
								else 'no hay regimen
									buenRegimen=false
								end if
								rs.close	
							end if 'buenregimen
						end if 'tregimen
						
						tieneCupo=true 'cambio el control de cupo al calculo precio habitacion
						
						'response.write "Cupo:" & tieneCupo & "<br>"
						if tieneCupo and buenRegimen then 'seguir calculando
							precioCalculo=0
							nombrehabi=Regtipohab(HabNombre,hab)
							codiHabi=Regtipohab(HabCodi,hab)
							sumaOferta=0
							ofertasPct=""
							
							'llamar al modulo de precios habitacion
							%><!--#include file="IncludePrecioHabitacion.asp"--><%
							
						  'Datos del hotel
						  precioCalculo=sumaBruto
						  estadoHabi=estadoHab
						  releaseHabi=release
						  'ofertas
						  sumaOferta=sumaOferta
						  ofertasPct=ofertasPct
						  NombreSuple=nombreSuple
									

							if estadoHabi<>"NV" AND releaseHabi="OK" then 'no venta o no hay problema de release
								'crear lista
								precioCalculo=redondear(precioCalculo)
								nlista=nlista+1 
								redim preserve Lista(10, nlista)
								
								Lista(LHotel, nlista) = est
								Lista(LNHabi, nlista) = nombrehabi
								Lista(LNRegimen, nlista) = nombresuple
								Lista(LPelas, nlista) = precioCalculo
								Lista(LCHabi, nlista) = codiHabi
								Lista(LCRegi, nlista) = elRegimen
								Lista(LOferta, nlista) = sumaOferta
								Lista(LTotal, nlista) = precioCalculo - sumaOferta
								Lista(LEstadoH, nlista) = estadoHabi
								Lista(LOfertaTem, nlista) = ofertatem
								Lista(LOfertasPct, nLista) = ofertasPct
								
							end if 'no venta
							
						
						end if 'tieneCupo
						
					end if 'esa hab es de ese hotel
					
				next 'las habis
			end if 'haytipoHab
	
		end if 'tieneTempo
	end if 'diferente hotel
	anthotel=est
	'response.write "Hotel: " & est & "<br>"
	'response.Flush()
	'response.End()

next 'Hotel

%>