<!--#include file="datosEmpresa.asp"-->
<%
Response.Write "<Time> Inicio: " & Now & " </Time><br>"



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
	Response.Write "<Time> cs1: " & Now & " </Time><br>"
	rs.Open cs, base
	Response.Write "<Time> cs1 end : " & Now & " </Time><br>"
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
		Response.Write "<Time> cs2: " & Now & " </Time><br>"
		rs.open cs,base
		Response.Write "<Time> cs2 end : " & Now & " </Time><br>"
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
		Response.Write "<Time> cs3: " & Now & " </Time><br>"
		rs.open cs,base
		Response.Write "<Time> cs3: end " & Now & " </Time><br>"
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
		Response.Write "<Time> cs4: " & Now & " </Time><br>"
		rs.open cs,base
		Response.Write "<Time> cs4 end : " & Now & " </Time><br>"
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
		Response.Write "<Time> CalculoPreciosCupo: " & Now & " </Time><br>"
		%><!--#include file="CalculoPreciosCupo.asp"--><%
		Response.Write "<Time> CalculoPreciosCupo: end  " & Now & " </Time><br>"

		miorden=-1	
Response.Write "<Time> Lista ordenada : " & Now & " </Time><br>"
		if nlista>-1 then 'Ha encontrado alguna
			'Ordenar por precios
			if (orden="" or orden="desc") then
				'response.Write("orden=desc<br>")
				SortArrayDesc Lista,LTotal
			else
				'response.Write("orden=asc<br>")
				SortArray Lista,LTotal
			end if
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
	'cs = "delete from jos_crs_ResultadosTMP"
	'base.execute cs
Response.Write "<Time> Exes: " & Now & " </Time><br>"

	if miorden>-1 then 'hay registros, generar html
		antehotel=-1
		nhoteles=1
		seeeionid=request.QueryString("sessionID")
		numHab=request.QueryString("numHab")
		minAnterior=0
		codHotel=""
		for l=0 to ubound(ListaN,2) 
			if codHotel<>ListaN(LHotel,l) and l<>0 then
				response.write "<!-- Execute: " & cs & "-->"
				minAnterior=0
				nhoteles=nhoteles+1
				base.execute cs
				response.write vbtab & vbcrlf & vbcrlf & vbcrlf & "<!--codigoHotel:" & ListaN(LHotel,l) & "-->" & vbcrlf
			end if
			minimporte=ListaN(LPelas,l)-ListaN(LOferta,l)
			if (minAnterior=0 or minAnterior>ListaN(LPelas,l)-ListaN(LOferta,l)) then 
				cs = "INSERT INTO " & precrs & "ResultadosTMP (Id, seeeionid, Hab,codhab, importe, ofertatem, oferta, ofertaspct, total) VALUES ("
				cs = cs & ListaN(LHotel,l) & ", '" & seeeionid & "', '" &numHab & "', '" &ListaN(LCHabi,l) & "', '" & ListaN(LPelas,l) & "', '" & ListaN(LTemporada, l) & "',"
				cs = cs &  "'" & ListaN(LOferta,l) & "', '" & ListaN(LOfertasPct, l) & "', '" & replace(("" & ListaN(LPelas,l)-ListaN(LOferta,l)),",",".") & "') " 
				response.write "<!--" & cs & "-->"
			end if
			response.write vbtab & "<!--codigoHabi:" & ListaN(LCHabi,l) & "-->" & vbcrlf
			minAnterior=minimporte
			codHotel=ListaN(LHotel,l)
		next 
		response.write "<!-- Execute: " & cs & "-->"
		minAnterior=0
		base.execute cs

Response.Write "<Time>Fin: " & Now & "</Time><br>"

	end if 'miorden>-1
	response.Write "<resultados>" & nhoteles & "</resultados>" & vbcrlf
	end if 'errormsg
else
	response.write errormsg
end if

set rs=nothing
base.close
set base=nothing


%>