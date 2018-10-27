<%
	sumaNueva = 0

	nuevaOfer=-1

	set rs2=server.createobject("ADODB.Recordset")
	rs2.CursorLocation = adUseServer
	rs2.CursorType=adOpenForwardOnly
	rs2.LockType=adLockReadOnly

	'Busco tabla de ofertas VIP 
	cs="SELECT OfertasVIP.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
	cs=cs & "Dto,Precio,ISNULL(dbo.fnGetTraduccion('OfertasVIP','Titulo',Id,'" & lang & "'),Titulo) AS Tradu,DiasSemana,"
	cs=cs & "Hoteles,OfertaRegimen "
	cs=cs & "FROM OfertasVIP "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Caduca>" & FechaMySQL(date)
	cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
	cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
	cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & FechaMySQL(FSalida-1) & ">FechaFin) OR (" & FechaMySQL(FLlegada) & "<FechaInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
	cs=cs & FechaMySQL(FLlegada) & "<FechaInicio AND " & FechaMySQL(FSalida-1) & ">FechaFin)) "
	cs=cs & "ORDER BY OfertaRegimen DESC"
	'response.write cs
	rs.open cs,base
	
	do while not rs.eof
		'Buscar precio de los ultimos dia
		dia=0
		'if ide=82 then
			sumaNueva=0
		'end if
		if instr(rs("hoteles"),est & ", ")<>0 then 'está ese hotel
		if paClng(rs("totalNoches"))=0 or paClng(rs("totalNoches"))<=paClng(noches) then 'si tiene noches
			for lafecha=FLlegada to FSalida-1
				dia=dia+1
				
				if rs("fechaInicio")<=lafecha AND rs("fechaFin")>=lafecha then 'es del dia
				'Mirar dias marcador en la oferta (dia de la semana)
				midia=diasemana(Weekday(d,vbMonday))
				if instr(rs("diasSemana"),midia)<>0 OR trim(rs("diasSemana"))=""  then 'buen día o está en blanco
					ofertaDia=0
					select case paClng(rs("AplicarEn"))
						case atodo
							pelasDia=PrecioPlazas(dia)-DtoHab(dia)+TotalSuples(dia)-dtoSuples(dia)-totalOferta(dia)
							ofertaDia=redondear(pelasDia*rs("dto")/100)
							sumaNueva=sumaNueva+ofertaDia
					
						case asuple
							'response.write "Regimen: " & idregimen
							if (paClng(rs("codigoSuple"))=0 OR rs("codigoSuple")=idregimen) then 'hay oferta en este regimen
								
								if rs("ofertaRegimen")=0 then 'no hay intercambio de regimen
									if paClng(rs("dto"))<>0 then 'por %
										pelasH=PrecioSuples(dia)*adultos
										ofertaDia=Redondear(pelasH*paDbl(rs("dto"))/100)
										'response.write ofertaRegimen(dia) & "<br/>"
									else 'oferta precio fijo hab.
										pelasH=PrecioSuples(dia)
										ofertaDia=(pelasH-(paDdbl(rs("precio"))))*adultos 'esoooo
										'response.write ofertaHab(dia) & "<br>"
									end if 'la oferta
									
								else 'cambio precio por otro regimen
									sumaRegimen=0
									oferta_regimen=rs("ofertaRegimen")
									%><!--#include file="ofertaRegimenVIP.asp"--><%
									if sumaRegimen<>0 then
										ofertaDia=(TotalSuples(dia)-dtoSuples(dia))-sumaRegimen
									end if
								end if 'no hay cambio regimen
						
							end if '=codsuple
							sumaNueva = sumaNueva + ofertaDia
							
						
					end select
					codiOferta(dia)=rs("Id")
					totalOferta(dia)=totalOferta(dia)+ofertaDia
					textoOferta(dia)=rs("tradu")
				
				end if 'dia de la semana
				end if 'es del dia
				
			next 'noches
		end if 'suficientes noches
		end if 'está ese hotel
		
		if sumaNueva <> 0 then
		'se ha comentado este if porque no estaba haciendo el desglose correctamente
			'if (ide=82 and not hayOferta) Or (ide <> 82 and hayOferta) then
				'nuevaOfer = ubound(listaOfertas, 2) + 1
			'	nuevaOfer = 0
			'else
				nuevaOfer = nuevaOfer + 1
			'end if
			
			'redim preserve listaOfertas(3, nuevaOfer)
			
			'listaOfertas(RIdOferta,nuevaOfer) = rs("id")
			'listaOfertas(RNomOferta,nuevaOfer) = rs("tradu")
			'listaOfertas(RCalculaOferta,nuevaOfer) = -1
			'listaOfertas(RPelasOferta,nuevaOfer) = sumaNueva
		
			
			redim preserve listaOfertasAmigo(3, nuevaOfer)
			
			listaOfertasAmigo(RIdOferta,nuevaOfer) = rs("id")
			listaOfertasAmigo(RNomOferta,nuevaOfer) = rs("tradu")
			listaOfertasAmigo(RCalculaOferta,nuevaOfer) = -1
			listaOfertasAmigo(RPelasOferta,nuevaOfer) = sumaNueva			
		end if
		rs.movenext
	loop
	rs.close
	
	set rs2=nothing
%>