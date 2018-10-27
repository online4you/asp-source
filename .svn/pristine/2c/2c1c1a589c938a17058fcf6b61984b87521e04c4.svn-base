<!--#include file="datosEmpresa.asp"-->
<%
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Parametros para el buscador
orden = request.querystring("orden") 
ide = request.querystring("ide") 
lang=request.querystring(" lang")
est=paClng(request.querystring("est"))
hoteles=request.querystring("hoteles") 'puede ser un array 
bnombre=ControlAcentos(quitarApos(request.querystring("nh")))
tipoa=paClng(request.querystring("ta"))
tservicio=request.querystring("ts") 'puede ser un array 
THabi=paClng(request.querystring("th"))
TCate=paClng(request.querystring("ca"))
TRegimen=paClng(request.querystring("tr"))
Tzona=paClng(request.querystring("zona"))
adultos=paClng(request.querystring("ad"))
ninos=paClng(request.querystring(" ni"))
ninos2=paClng(request.querystring(" ni2"))
bebes=paClng(request.querystring("bebes"))
ninos1=ninos 'para los calculos
'ninos2=0 'para los calculos
plazas=adultos+ninos1+ninos2+bebes
'response.Write(plazas & "<br>")
tarifa=paClng(request.QueryString("tarifa"))
if tarifa=0 then tarifa=1 'por defecto

fini="" & request.querystring("fini")
ffin="" & request.querystring("ffin")

if not isdate(fini) or not isdate(ffin) then
	errormsg="Fecha no válida"
end if

codigovip=request.querystring("codigovip")
cpromo=request.querystring("promo")

if errormsg="" then 'sigo buscando
	fini=cdate(fini)
	ffin=cdate(ffin)
	anyo=year(fini)
	noches=ffin-fini
	release=fini-date()

	'dias semana
	dim diasemana(7)
	diasemana(1)="L"
	diasemana(2)="M"
	diasemana(3)="X"
	diasemana(4)="J"
	diasemana(5)="V"
	diasemana(6)="S"
	diasemana(7)="D"
	
	busco="WHERE ConsultaHoteles.Estado<>" & noventa & " AND "
	if est<>0 then busco=busco & "ConsultaHoteles.CodigoEsta=" & est & " AND "
	if tipoa<>0 then busco=busco & "ConsultaHoteles.TipoAlojamiento=" & tipoa & " AND "
	if TCate<>0 then busco=busco & "Categoria=" & TCate & " AND "
	if TRegimen<>0 then busco=busco & "IdRegimen=" & TRegimen & " AND Anyo=" & anyo & " AND "
	if Tzona<>0 then busco=busco & " (hgcat.id=" & tzona & " OR hgcat.parent_id=" & tzona & ") AND " 
	if bnombre<>"" then busco=busco & "Nombre LIKE '%" & bnombre & "%' AND "
	if hoteles<>"" and est=0 then 'busco solo en el array
		lhotel=split(hoteles,"-")
		busco=busco & "("
		for hh=0 to ubound(lhotel)
			busco=busco & "ConsultaHoteles.hg_CodigoEsta=" & lhotel(hh) & " OR "
		next
		busco=left(busco,len(busco)-4) & ") AND "
	end if
	if tservicio<>"" and tservicio<>"0" then 
		lservi=split(tservicio,"-")
		busco=busco & "("
		for hh=0 to ubound(lservi)
			busco=busco & "IdCaracter=" & lservi(hh) & " OR "
		next
		busco=left(busco,len(busco)-4) & ") AND "
	end if 'tservicio
	
	'Quitar el "and" ultimo
	busco=left(busco,len(busco)-5)

	cs="SELECT ConsultaHoteles.CodigoEsta, ConsultaHoteles.Nombre, ConsultaHoteles.Categoria, ConsultaHoteles.Zona,"
	cs = cs & "ConsultaHoteles.TipoAlojamiento, ConsultaHoteles.Estado, '' AS Foto, ConsultaHoteles.Moneda"
	
	if TRegimen<>0 then
		cs = cs & ",RegimenHotel.Id, IF(ISNULL(Traduccion),Regimen.Nombre,Traduccion) AS elRegimen"
	end if
	if ide = 94 then
		cs= cs & " , max(Cupos.diasMinimos) DM "
	end if	
	
	'cs = cs & ",hgcats.catid "
	
	cs=cs & " FROM ( " 
	cs=cs & "(SELECT Establecimientos.CodigoEsta, Establecimientos.Nombre, Establecimientos.Estado, Establecimientos.Moneda, DatosHotel.Poblacion, DatosHotel.Zona, DatosHotel.TipoAlojamiento, DatosHotel.Categoria, Establecimientos.Orde, Establecimientos.hg_CodigoEsta " 
	cs=cs & "FROM " & precrs & "Establecimientos Establecimientos INNER JOIN " 
	cs=cs & "" & precrs & "DatosHotel DatosHotel ON Establecimientos.CodigoEsta = DatosHotel.CodigoEsta " 
	cs=cs & ") ConsultaHoteles "
	cs=cs & " inner join jos_hg_cats_item_relations hgcats on hgcats.itemid=ConsultaHoteles.hg_CodigoEsta "
	cs=cs & " inner join jos_hg_categories hgcat on hgcats.catid=hgcat.id "
	cs=cs & " INNER JOIN " & precrs & "DatosHotel DatosHotel "
	cs=cs & "ON ConsultaHoteles.CodigoEsta=DatosHotel.CodigoEsta) "
	if TRegimen<>0 then 'tambien filtra por regimen
		cs=cs & "INNER JOIN ((" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen ON RegimenHotel.IdRegimen=Regimen.Id) "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "') ON ConsultaHoteles.CodigoEsta=RegimenHotel.CodigoEsta "
	end if
	if tservicio<>"" then 'busca por caracteristicas
		cs =cs & "LEFT JOIN " & precrs & "CaracteristicasHotel CaracteristicasHotel "
		cs =cs & "ON ConsultaHoteles.CodigoEsta=CaracteristicasHotel.CodigoEsta "
	end if 'tservicio<>""
	if ide = 94 then
		cs = cs & " inner join " & precrs & "Cupos Cupos on ConsultaHoteles.CodigoEsta = Cupos.CodigoEsta "
	end if
	cs=cs & busco
	if ide = 94 then
		cs = cs & " GROUP BY ConsultaHoteles.CodigoEsta, ConsultaHoteles.Nombre, ConsultaHoteles.Categoria, ConsultaHoteles.Zona, "
		cs = cs & " ConsultaHoteles.TipoAlojamiento, ConsultaHoteles.Estado, DatosHotel.Foto, ConsultaHoteles.Moneda "
	end if
	
	cs=cs & " ORDER BY ConsultaHoteles.CodigoEsta"
	
	'JAVI
	'varjaviaux = cs
	dim varjaviaux, varjaviaux2, varjaviaux3, varjaviaux4, varjaviaux5, varjaviaux6
	varjaviaux = cs
	
	mycs=cs
	'response.Write(cs & "<br>")
	rs.Open cs, base
	'response.write(cs)
	hayhotel=false
	if not rs.eof then
		RegHotel=rs.getrows
		HoCodi=0
		HoNombre=1
		HoCate=2
		HoZona=3
		HoTipoa=4
		Hoestado=5
		HoFoto=6
		HoMoneda=7
		if TRegimen<>0 then
		HoIdRegi=8
		HoNomRegi=9
		end if
		if ide = 94 and TRegimen<>0 then
		HoNumMinD=10
		elseif ide = 94 then 
		HoNumMinD=8
		end if
		hayhotel=true
		
	end if
	rs.close
	
	if not hayhotel then
		errormsg="No encontrados"
		response.write errormsg
	end if
	if errormsg="" then 'no hay error

		'Tabla Monedas
		cs="SELECT Id,CodigoISO "
		cs=cs & "FROM " & precrs & "TiposMoneda"
		'JAVI
		varjaviaux2 = cs
		rs.open cs,base
		hayTMonedas=false
		if not rs.eof then
			RegTMonedas=rs.getrows
			TMCodi=0
			TMNombre=1
			hayTMonedas=true
			
		end if
		rs.close
		
		'Tabla tipos alojamiento
		cs="SELECT TipoAlojamiento.Id,IF(ISNULL(Traducciones.Traduccion),TipoAlojamiento.Nombre,Traducciones.Traduccion) Nombre FROM " & precrs & "TipoAlojamiento TipoAlojamiento LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON TipoAlojamiento.Id=Traducciones.IdReferencia AND Tabla='TipoAlojamiento' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
		varjaviaux3 = cs 'JAVI
		'response.Write(cs & "<br>")
		rs.open cs,base
		haytipoa=false
		if not rs.eof then
			RegTipoA=rs.getrows
			RTCodi=0
			RTNombre=1
			haytipoa=true
			
		end if
		rs.close

		'Tabla categorias
		cs="SELECT Categorias.Id,IF(ISNULL(Traducciones.Traduccion),Categorias.Nombre,Traducciones.Traduccion) Nombre FROM " & precrs & "Categorias Categorias LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Categorias.Id=Traducciones.IdReferencia AND Tabla='Categorias' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
		varjaviaux4 = cs 'JAVI
		'response.Write(cs & "<br>")
		rs.open cs,base
		
		haycate=false
		if not rs.eof then
			RegCate=rs.getrows
			RCCodi=0
			RCNombre=1
			haycate=true
			
		end if
		rs.close
		
		'Tabla de tipos habitaciones (que entren los adultos y niños indicados)
		cs="SELECT TipoHabitaNombres.Id,ParaCapNormal,ParaCapMax,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) Nombre,"
		cs=cs & "TipoHabitaNombres.CodigoEsta "
		cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
		cs=cs & "WHERE ParaCapMax>=" & (adultos+ninos+ninos2) & " AND ParaCapMin<=" & (adultos+ninos+ninos2) & " AND "
		cs=cs & "ParaAdultMin<=" & adultos & " AND ParaAdultMax>=" & adultos & " AND ParaNiMax>=" & ninos+ninos2
		if THabi<>0 then 'tipo habitacion
			cs=cs & " AND TipoHabitacion=" & THabi
		end if
		'JAVI
		varjaviaux5 = cs
		'response.write(cs)
		haytipohab=false
		rs.open cs,base
		if not rs.eof then
			Regtipohab=rs.getrows
			HabCodi=0
			HabNormal=1
			HabMax=2
			HabNombre=3
			HabHotel=4
			haytipohab=true
		end if
		rs.close
		%><!--#include file="CalculoPreciosCupoSinPrecios.asp"--><%

		miorden=-1	
		if nlista>-1 then 'Ha encontrado alguna

			'Crear una lista para agrupar por hotel
			dim ListaN()
			redim ListaN(ubound(Lista, 1), ubound(Lista, 2))
			listahotel=""
			for l=0 to ubound(Lista, 2)
				if instr(listaHotel,"-" & lista(LHotel,l) & "-") = 0 then 'no está en la lista
					listahotel = listahotel & "-" & Lista(LHotel, l) & "-"
					miorden = miorden + 1
					ListaN(LHotel,miorden) = Lista(LHotel, l)
					ListaN(LNHabi,miorden) = Lista(LNHabi, l)
					ListaN(LNRegimen,miorden) = Lista(LNRegimen, l)
					ListaN(LPelas,miorden) = Lista(LPelas, l)
					ListaN(LCHabi,miorden) = Lista(LCHabi, l)
					ListaN(LCRegi,miorden) = Lista(LCRegi, l)
					ListaN(LOferta,miorden) = Lista(LOferta, l)
					ListaN(LTotal,miorden) = Lista(LTotal, l)
					ListaN(LEstadoH,miorden) = Lista(LEstadoH, l)
					ListaN(LOfertaTem,miorden) = Lista(LOfertaTem, l)
					ListaN(LOfertasPct, miorden) = Lista(LOfertasPct, l)
					
					'buscar del mismo hotel a no ser que sea la ultima
					if l < ubound(Lista, 2) then
						for ll = l + 1 to ubound(Lista, 2)
							if Lista(LHotel,l) = Lista(LHotel, ll) then 'es el mismo hotel
								miorden = miorden + 1
								ListaN(LHotel,miorden) = Lista(LHotel, ll)
								ListaN(LNHabi,miorden) = Lista(LNHabi, ll)
								ListaN(LNRegimen,miorden) = Lista(LNRegimen, ll)
								ListaN(LPelas,miorden) = Lista(LPelas, ll)
								ListaN(LCHabi,miorden) = Lista(LCHabi, ll)
								ListaN(LCRegi,miorden) = Lista(LCRegi, ll)
								ListaN(LOferta,miorden) = Lista(LOferta, ll)
								ListaN(LOfertasPct, miorden) = Lista(LOfertasPct, ll)
								ListaN(LTotal,miorden) = Lista(LTotal, ll)
								ListaN(LEstadoH,miorden) = Lista(LEstadoH, ll)
							end if 'mismo hotel
						next 'll
					end if 'no es ultima
				end if 'no ta
				
				'response.write "Hotel: " & Lista(LHotel,l) & "<br/>"
			next 'l			
		end if 'nlista

	'Generar XML
	
	response.write "<data>" & vbcrlf
	if miorden>-1 then 'hay registros, generar html
		antehotel=-1
		nhoteles=0
		for l=0 to ubound(ListaN,2)
			if antehotel<>ListaN(LHotel,l) then 'Cambio de hotel, buscar datos
				nhoteles=nhoteles+1
				response.write "<hotel>" & vbcrlf
				response.write vbtab & "<codigo>" & ListaN(LHotel,l) & "</codigo>" & vbcrlf
				if hayhotel then
				for h = 0 to ubound(RegHotel,2)
					if RegHotel(HoCodi,h)=ListaN(LHotel,l) then 'este
						response.write vbtab & "<nombre>" & server.HTMLEncode(RegHotel(HoNombre,h)) & "</nombre>" & vbcrlf
						response.write vbtab & "<tipo>" & RegHotel(HoTipoa,h) & "</tipo>" & vbcrlf
						response.write vbtab & "<nombreTipo>"
						'Buscar Tipo
						if haytipoa then
						for t=0 to ubound(RegTipoA,2)
							if RegTipoA(RTCodi,t)=RegHotel(HoTipoa,h) then
								response.write server.HTMLEncode(RegTipoA(RTNombre,t))
								exit for
							end if
						next 't
						end if 'haytipoa
						response.write "</nombreTipo>" & vbcrlf
						if ide = 94 then
							response.write vbtab & "<diasMin>" & RegHotel(HoNumMinD,h) & "</diasMin>" & vbcrlf
						end if	
						response.write vbtab & "<categoria>" & RegHotel(HoCate,h) & "</categoria>" & vbcrlf
						'Buscar Categoria
						if haycate then
						for t=0 to ubound(RegCate,2)
							if RegCate(RCCodi,t)=RegHotel(HoCate,h) then
								response.write vbtab & "<nombreCategoria>" & server.HTMLEncode(RegCate(RCNombre,t)) & "</nombreCategoria>" & vbcrlf
								exit for
							end if
						next 't
						end if 'haytipoa
						response.write vbtab & "<moneda>"
						'Buscar Moneda
						if hayTMonedas then
						for t=0 to ubound(RegTMonedas,2)
							if RegTMonedas(TMCodi,t)=RegHotel(HoMoneda,h) then
								response.write server.HTMLEncode(RegTMonedas(TMNombre,t))
								exit for
							end if
						next 't
						end if 'haymoneda
						response.write "</moneda>" & vbcrlf
						response.write vbtab & "<estado>" & RegHotel(HoEstado,h) & "</estado>" & vbcrlf
						response.write vbtab & "<zona>" & RegHotel(HoZona,h) & "</zona>" & vbcrlf
						if RegHotel(HoFoto,h)<>"" then
							lafoto="http://admin.kubikcrs.com" & rutafotos & RegHotel(HoFoto,h)
						else
							lafoto=""
						end if
						response.write vbtab & "<urlfoto>" & server.HTMLEncode(lafoto) & "</urlfoto>" & vbcrlf
						response.write vbtab & "<descripcion>"
						'Buscar si tiene texto
						if con_cms then
							cs="SELECT ISNULL(Traduccion,Texto) AS Texto "
							cs=cs & "FROM (" & precrs & "TextosHotel TextosHotel INNER JOIN " & precrs & "SeccionesHotel SeccionesHotel "
							cs=cs & "ON TextosHotel.IdSeccion=SeccionesHotel.Id) LEFT JOIN Traducciones "
							cs=cs & "ON TextosHotel.Id=Traducciones.IdReferencia AND Tabla='TextosHotel' "
							cs=cs & "AND Campo='Texto' AND Idioma='" & lang & "' "
							cs=cs & "WHERE TextosHotel.CodigoEsta=" & RegHotel(HoCodi,h)
							cs=cs & " ORDER BY SeccionesHotel.Orden"
							rs.open cs,base
							if not rs.eof then
								response.write server.HTMLEncode("" & rs("texto"))
							end if
							rs.close
							'JAVI
							varjaviaux6 = cs
						end if 'con_cms
						response.write "</descripcion>" & vbcrlf
						response.write "<ofertatem>" & ListaN(LOfertaTem, l) & "</ofertatem>" & vbcrlf
						response.write "<temporada>" & ListaN(LTemporada, l) & "</temporada>" & vbcrlf
						exit for
					end if
				next 'h
				end if 'hayhotel
				antehotel = ListaN(LHotel,l)
			end if 'otro hotel
			
			'Datos habitacion
			response.write vbtab & "<habitacion>" & vbcrlf			
			response.write vbtab & vbtab & "<codhab>" & ListaN(LCHabi,l) & "</codhab>" & vbcrlf
			response.write vbtab & vbtab & "<nombrehab>" & server.HTMLEncode(ListaN(LNHabi,l)) & "</nombrehab>" & vbcrlf
			response.write vbtab & vbtab & "<codregi>" & ListaN(LCRegi,l) & "</codregi>" & vbcrlf
			response.write vbtab & vbtab & "<regimen>" & server.HTMLEncode(ListaN(LNRegimen,l)) & "</regimen>" & vbcrlf
			response.write vbtab & vbtab & "<importe>" & ListaN(LPelas,l) & "</importe>" & vbcrlf
			response.write vbtab & vbtab & "<oferta>" & ListaN(LOferta,l) & "</oferta>" & vbcrlf
			response.write vbtab & vbtab & "<ofertaspct>" & ListaN(LOfertasPct, l) & "</ofertaspct>" & vbcrlf
			response.write vbtab & vbtab & "<estadohabitacion>" & ListaN(LEstadoH, l) & "</estadohabitacion>" & vbcrlf
			response.write vbtab & "</habitacion>" & vbcrlf

			'Comprobar si cambia hotel
			if l<ubound(ListaN,2) then
				if ListaN(LHotel,l+1)<>antehotel then response.write "</hotel>" & vbcrlf
			end if 'l<ubound(lista)

			
		next 'h
		response.write "</hotel>" & vbcrlf
		
	end if 'miorden>-1
	response.Write "<resultados>" & nhoteles & "</resultados>" & vbcrlf
	response.Write "<log1>" & server.HTMLEncode(varjaviaux) & "</log1>" & vbcrlf
	response.Write "<log2>" & server.HTMLEncode(varjaviaux2) & "</log2>" & vbcrlf
	response.Write "<log3>" & server.HTMLEncode(varjaviaux3) & "</log3>" & vbcrlf
	response.Write "<log4>" & server.HTMLEncode(varjaviaux4) & "</log4>" & vbcrlf
	response.Write "<log5>" & server.HTMLEncode(varjaviaux5) & "</log5>" & vbcrlf
	response.Write "<log6>" & server.HTMLEncode(varjaviaux6) & "</log6>" & vbcrlf
	response.Write "</data>"
	end if 'errormsg
else
	response.write errormsg
end if

set rs=nothing
base.close
set base=nothing


%>