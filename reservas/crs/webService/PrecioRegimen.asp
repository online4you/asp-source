<%
'Suplementos
'on error resume next
PrecioSuples(dia)=0
TotalSuples(dia)=0
OfertaRegimen(dia)=0
OfertaRegimenPct(dia)=0
'response.Write( "codsuple=" & codsuple & "<br>")
'response.Write( "idregi=" & idregi & "<br>")
if codsuple<>0 or idregi<>0 then 'Buscar el codigo para poner el precio
	if idregi<>0 then 'ya viene con el codigo general de regimen

		idregimen = idregi
		'Buscar el correspondiente a la hab y la temporada
		cs="SELECT Precio,RegimenHotel.Id,IF(ISNULL(traduc.Traduccion),Regimen.Nombre,traduc.Traduccion) AS Nombre  "
		cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
		cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
		cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Ofertas"" And Campo = ""Titulo"" And Idioma = """ & lang & """)  AS traduc ON Regimen.Id = traduc.IdReferencia  "
		cs=cs & "WHERE IdRegimen=" & idregimen & " AND RegimenHotel.CodigoEsta=" & est
		cs=cs & " AND (Codigotempo=" & CodTem & " OR CodigoTempo=0) AND "
		cs=cs & "(CodigoHab=" & codhab & " OR CodigoHab=0) AND Anyo=" & anyo
		'response.Write(cs & "<br>")
		rs.open cs,base
		if not rs.eof then
			codsuple=rs("Id")
			nombreSuple=rs("nombre")
			PrecioSuples(dia)=redondear(rs("precio"))
			TotalSuples(dia)=redondear(rs("precio")*plazas)
			haysuples=true
		end if
		rs.close
	
	else
		'Busco el regimen general del marcado, por problemas con las temporadas
		cs="SELECT IdRegimen FROM " & precrs & "RegimenHotel WHERE Id=" & codsuple
		rs.open cs,base
		if not rs.eof then
			idregimen = rs("idregimen")
			rs.close
			'Buscar el correspondiente a la hab y la temporada
			cs = "SELECT Precio,RegimenHotel.Id,IF(ISNULL(traduc.Traduccion),Regimen.Nombre,traduc.Traduccion) AS Nombre "
			cs = cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
			cs = cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
			cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Ofertas"" And Campo = ""Titulo"" And Idioma = """ & lang & """)  AS traduc ON Regimen.Id = traduc.IdReferencia  "
			cs = cs & "WHERE IdRegimen=" & idregimen & " AND RegimenHotel.CodigoEsta=" & est
			cs = cs & " AND (Codigotempo=" & CodTem & " OR CodigoTempo=0) AND "
			cs = cs & "(CodigoHab=" & codhab & " OR CodigoHab=0) AND Anyo=" & anyo
			'response.Write(cs & "<br>")
			rs.open cs,base
			if not rs.eof then
				codsuple = rs("Id")
				nombreSuple = rs("nombre")
				PrecioSuples(dia) = redondear(rs("precio"))
				TotalSuples(dia) = redondear(rs("precio")*plazas)
				haysuples = true
			end if
			rs.close
	
		else
			rs.close
		end if
	end if 'idregi<>0
	
	'Comprobar si hay oferta para el precio del regimen
	if hayOferta then
		for o=0 to ubound(RegLOfertas,2)
			if RegLOfertas(OfFInicio,o)<=FechaRes(dia) AND RegLOfertas(OfFFin,o)>=FechaRes(dia) then 'es del dia
			'Mirar dias marcador en la oferta (dia de la semana)
			midia=diasemana(Weekday(d,vbMonday))
			if instr(RegLOfertas(OfDias,o),midia)<>0 OR trim(RegLOfertas(OfDias,o))=""  then 'buen día o está en blanco
			
			if clng(RegLOfertas(OfNoches,o))=0 or clng(RegLOfertas(OfNoches,o))<=clng(noches) then 'si tiene noches
				if RegLOfertas(OfAplicar,o)=asuple and RegLOfertas(OfNochesG,o)=0 then 'or RegLOfertas(OfAplicar,o)=atodo then 'regimen o todo
					if clng(RegLOfertas(OfCodSuple,o))=0 OR clng(RegLOfertas(OfCodSuple,o))=idRegimen then 'Calcular
						if clng(RegLOfertas(OfDto,o))<>0 then 'por %
							pelasH=PrecioSuples(dia) * adultos
							dife=Redondear(pelasH*clng(RegLOfertas(OfDto,o))/100)							
							'response.write ofertaRegimen(dia) & "<br/>"
						else 'oferta precio fijo hab.
							dife = 0
							pelasH = PrecioSuples(dia)
							dife=(pelasH-(paDbl(RegLOfertas(OfPrecio,o))))*adultos 'esoooo
							'response.write ofertaHab(dia) & "<br>"
						end if 'la oferta
						codiOferta(dia)=RegLOfertas(OfId,o)
						OfertaRegimen(dia)=OfertaRegimen(dia)+dife
						textoOferta(dia)=RegLOfertas(OfTitulo,o)
						OfertaRegimenPct(dia) = RegLOfertas(OfDto, o)
						
						'registro ofertas
						for xx=0 to ubound(ListaOfertas,2)
							If listaOfertas(RIdOferta,xx)=RegLOfertas(OfId,o) then
								listaOfertas(RPelasOferta,o)=listaOfertas(RPelasOferta,o)+dife
							end if
						next 'xx 						
						
					end if 'es valida esa habitacion
				end if 'hab o todo
			end if 'suficientes noches
			end if 'dia de la semana
			end if 'es de ese día
		next 'o
		totalOferta(dia)=totalOferta(dia)+(ofertaRegimen(dia)*plazas)
	end if 'hayOferta


end if
%>