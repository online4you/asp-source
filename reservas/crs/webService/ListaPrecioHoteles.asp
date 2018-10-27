<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Parametros para el buscador
lang=request.querystring("lang")
est=clng("0" & request.querystring("est"))
bnombre=ControlAcentos(quitarApos(request.querystring("nh")))
tipoa=clng("0" & request.querystring("ta"))
tservicio=clng("0" & request.querystring("ts"))
THabi=clng("0" & request.querystring("th"))
TCate=clng("0" & request.querystring("ca"))
TRegimen=clng("0" & request.querystring("tr"))
Tzona=clng("0" & request.querystring("zona"))
adultos=clng("0" & request.querystring("ad"))
ninos=clng("0" & request.querystring("ni"))
ninos1=ninos 'para los calculos
plazas=adultos+ninos
fini="" & request.querystring("fini")
ffin="" & request.querystring("ffin")

if not isdate(fini) or not isdate(ffin) then
	errormsg="Fecha no válida"
end if
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
	
	busco="WHERE Estado<>" & noventa & " AND "
	if est<>0 then busco=busco & "ConsultaHoteles.CodigoEsta=" & est & " AND "
	if tipoa<>0 then busco=busco & "TipoAlojamiento=" & tipoa & " AND "
	if tservicio<>0 then busco=busco & "IdTipo=" & tservicio & " AND "
	if TCate<>0 then busco=busco & "Categoria=" & TCate & " AND "
	if TRegimen<>0 then busco=busco & "IdRegimen=" & TRegimen & " AND Anyo=" & anyo & " AND "
	if Tzona<>0 then busco=busco & "Zona=" & tzona & " AND "
	if bnombre<>"" then busco=busco & "Nombre LIKE '%" & bnombre & "%' AND "
	'Quitar el "and" ultimo
	busco=left(busco,len(busco)-5)

	cs="SELECT ConsultaHoteles.CodigoEsta,Nombre,Categoria,Zona,TipoAlojamiento,"
	'cs=cs & "Texto1_" & lang & ",Estado"
	cs=cs & "Estado"
	if TRegimen<>0 then
		cs=cs & ",RegimenHotel.Id, Regimen.Nombre_" & lang
	end if
	cs=cs & " FROM " & precrs & "ConsultaHoteles ConsultaHoteles "
	if TRegimen<>0 then 'tambien filtra por regimen
		cs=cs & "INNER JOIN (" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen ON RegimenHotel.IdRegimen=Regimen.Id) "
		cs=cs & "ON ConsultaHoteles.CodigoEsta=RegimenHotel.CodigoEsta "
	end if
	cs=cs & busco
	cs=cs & " ORDER BY ConsultaHoteles.CodigoEsta"
	rs.Open cs, base
	hayhotel=false
	if not rs.eof then
		RegHotel=rs.getrows
		HoCodi=0
		HoNombre=1
		HoCate=2
		HoZona=3
		'HoFoto=4
		HoTipoa=4
		'HoTexto=5
		Hoestado=5
		HoIdRegi=6
		HoNomRegi=7
		hayhotel=true
	end if
	rs.close
	
	if not hayhotel then
		errormsg="No encontrados"
	end if
	if errormsg="" then 'no hay error
		
		'Tabla tipos alojamiento
		cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "TipoAlojamiento"
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
		cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "Categorias"
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
		cs="SELECT Id,ParaCapNormal,ParaCapMax,Nombre_" & lang & ",CodigoEsta  FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "WHERE ParaCapMax>=" & (adultos+ninos) & " AND ParaCapMin<=" & (adultos+ninos) & " AND "
		cs=cs & "ParaAdultMin<=" & adultos & " AND ParaAdultMax>=" & adultos & " AND ParaNiMax>=" & ninos
		if THabi<>0 then 'tipo habitacion
			cs=cs & " AND TipoHabita=" & THabi
		end if
		'response.write cs & "<br/>"
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
			'response.write "N Habi:" & ubound(RegTipoHab,2) & "<br>"
		end if
		rs.close
		
		'Busco todas las temporadas
		cs="SELECT CodigoTemp,CodigoEsta,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
		cs=cs & "WHERE Release<=" & release & " AND Minimo<=" & noches
		cs=cs & " AND ((" & FechaMySQL(fini) & " BETWEEN FInicio AND FFinal) OR ("
		cs=cs & FechaMySQL(ffin-1) & " BETWEEN FInicio AND FFinal) OR "
		cs=cs & "(FInicio>" & FechaMySQL(fini) & " AND FFinal<" & FechaMySQL(ffin-1) & ") OR "
		cs=cs & "(FInicio<" & FechaMySQL(fini) & " AND FFinal>" & FechaMySQL(ffin-1) & "))"
		cs=cs & "ORDER BY CodigoEsta,FInicio"
		rs.open cs,base
		'response.write cs & "<br><br>"
		haytempos=false
		if not rs.eof then 'Tenemos cod. temporadas
			RegTempos=rs.getrows
			RTCodi=0
			RTEsta=1
			RTIni=2
			RTFin=3
			haytempos=true
			'response.Write "hayTempo" & "<br>"
		end if
		rs.close
		
		%><!--#include file="CalculoPrecios.asp"--><%
		
		set rs=nothing
		base.close
		set base=nothing

		miorden=-1	
		if nlista>-1 then 'Ha encontrado alguna
			'Ordenar por precios
			SortArray Lista,LTotal
			
			'Crear una lista para agrupar por hotel
			dim ListaN()
			redim ListaN(ubound(Lista,1),ubound(Lista,2))
			listahotel=""
			for l=0 to ubound(Lista,2)
				if instr(listaHotel,"-" & lista(LHotel,l) & "-")=0 then 'no está en la lista
					listahotel=listahotel & "-" & Lista(LHotel,l) & "-"
					miorden=miorden+1
					ListaN(LHotel,miorden)=Lista(LHotel,l)
					ListaN(LNHabi,miorden)=Lista(LNHabi,l)
					ListaN(LNRegimen,miorden)=Lista(LNRegimen,l)
					ListaN(LPelas,miorden)=Lista(LPelas,l)
					ListaN(LCHabi,miorden)=Lista(LCHabi,l)
					ListaN(LCRegi,miorden)=Lista(LCRegi,l)
					ListaN(LOferta,miorden)=Lista(LOferta,l)
					ListaN(LTotal,miorden)=Lista(LTotal,l)
					
					'buscar del mismo hotel a no ser que sea la ultima
					if l<ubound(Lista,2) then
						for ll=l+1 to ubound(Lista,2)
							if Lista(LHotel,l)=Lista(LHotel,ll) then 'es el mismo hotel
								miorden=miorden+1
								ListaN(LHotel,miorden)=Lista(LHotel,ll)
								ListaN(LNHabi,miorden)=Lista(LNHabi,ll)
								ListaN(LNRegimen,miorden)=Lista(LNRegimen,ll)
								ListaN(LPelas,miorden)=Lista(LPelas,ll)
								ListaN(LCHabi,miorden)=Lista(LCHabi,ll)
								ListaN(LCRegi,miorden)=Lista(LCRegi,ll)
								ListaN(LOferta,miorden)=Lista(LOferta,ll)
								ListaN(LTotal,miorden)=Lista(LTotal,ll)
							end if 'mismo hotel
						next 'll
					
					end if 'no es ultima
				end if 'no ta
				
				'response.write "Hotel: " & Lista(LHotel,l) & "<br/>"
			next 'l
			
		end if 'nlista

		
		

	end if
		
	
	
	'Generar XML
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<data>" & vbcrlf
	if miorden>-1 then 'hay registros, generar html
		antehotel=-1
		for l=0 to ubound(ListaN,2)
			if antehotel<>ListaN(LHotel,l) then 'Cambio de hotel, buscar datos
				response.write "<hotel>" & vbcrlf
				response.write vbtab & "<codigo>" & ListaN(LHotel,l) & "</codigo>" & vbcrlf
				if hayhotel then
				for h=0 to ubound(RegHotel,2)
					if RegHotel(HoCodi,h)=ListaN(LHotel,l) then 'este
						response.write vbtab & "<nombre>" & RegHotel(HoNombre,h) & "</nombre>" & vbcrlf
						response.write vbtab & "<tipo>" & RegHotel(HoTipoa,h)
						'Buscar Tipo
						if haytipoa then
						for t=0 to ubound(RegTipoA,2)
							if RegTipoA(RTCodi,t)=RegHotel(HoTipoa,h) then
								response.write "-" & RegTipoA(RTNombre,t)
								exit for
							end if
						next 't
						end if 'haytipoa
						response.write "</tipo>" & vbcrlf
						response.write vbtab & "<categoria>" & RegHotel(HoCate,h)
						'Buscar Categoria
						if haycate then
						for t=0 to ubound(RegCate,2)
							if RegCate(RCCodi,t)=RegHotel(HoCate,h) then
								response.write "-" & RegCate(RCNombre,t)
								exit for
							end if
						next 't
						end if 'haytipoa
						response.write "</categoria>" & vbcrlf
						response.write vbtab & "<estado>" & RegHotel(HoEstado,h) & "</estado>" & vbcrlf
						response.write vbtab & "<zona>" & RegHotel(HoZona,h) & "</zona>" & vbcrlf
						response.write vbtab & "<urlfoto>http://www.planetaweb.es/reservas/" & rutafotos & "/Th_" & RegHotel(HoFoto,h) & "</urlfoto>" & vbcrlf
						response.write vbtab & "<descripcion>" & server.HTMLEncode("" & RegHotel(HoTexto,h)) & "</descripcion>" & vbcrlf
						exit for
					end if
				next 'h
				end if 'hayhotel
				antehotel=ListaN(LHotel,l)
			end if 'otro hotel
			
			'Datos habitacion
			response.write vbtab & "<habitacion>" & vbcrlf
			response.write vbtab & vbtab & "<codhab>" & ListaN(LCHabi,l) & "</codhab>" & vbcrlf
			response.write vbtab & vbtab & "<nombrehab>" & ListaN(LNHabi,l) & "</nombrehab>" & vbcrlf
			response.write vbtab & vbtab & "<codregi>" & ListaN(LCRegi,l) & "</codregi>" & vbcrlf
			response.write vbtab & vbtab & "<regimen>" & ListaN(LNRegimen,l) & "</regimen>" & vbcrlf
			response.write vbtab & vbtab & "<importe>" & ListaN(LPelas,l) & "</importe>" & vbcrlf
			response.write vbtab & vbtab & "<oferta>" & ListaN(LOferta,l) & "</oferta>" & vbcrlf
			response.write vbtab & "</habitacion>" & vbcrlf

			'Comprobar si cambia hotel
			if l<ubound(ListaN,2) then
				if ListaN(LHotel,l+1)<>antehotel then response.write "</hotel>" & vbcrlf
			end if 'l<ubound(lista)

			
		next 'h
		response.write "</hotel>" & vbcrlf
		
	end if 'miorden>-1
	response.Write "</data>"

	
	
else
	response.write errormsg
end if

%>