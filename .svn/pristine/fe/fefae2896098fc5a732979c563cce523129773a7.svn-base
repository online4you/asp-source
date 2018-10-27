<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

ConectaGSys="Provider=SQLOLEDB.1;Persist Security Info=True;User ID=WebUser;pwd=P1AN3TAweb;Initial Catalog=globalsys;Data Source=localhost"

set baseGsys=server.createobject("ADODB.Connection")
set rsg=server.createobject("ADODB.Recordset")
rsg.CursorLocation = adUseServer
rsg.CursorType=adOpenForwardOnly
rsg.LockType=adLockReadOnly
baseGsys.Open ConectaGSys

'Parametros para el buscador
lang=request.querystring("lang")
est=paClng(request.querystring("est"))
hoteles=request.querystring("hoteles") 'puede ser un array 
bnombre=ControlAcentos(quitarApos(request.querystring("nh")))
tipoa=request.querystring("ta") 'modificado x David(Bizzit).. puede ser un array, separado por ','
tservicio=request.querystring("ts") 'puede ser un array, separado por ','
THabi=paClng(request.querystring("th"))
TCate=paClng(request.querystring("ca"))
TRegimen=paClng(request.querystring("tr"))
Tzona=request.querystring("zona")'modificado x David(Bizzit).. puede ser un array, separado por '-'
TDestino=request.querystring("dest")'añadido x David(Bizzit).. puede ser un array, separado por '-'
adultos=paClng(request.querystring("ad"))
ninos=paClng(request.querystring("ni"))
ninos1=ninos 'para los calculos
ninos2=0 'para los calculos
plazas=adultos+ninos1+ninos2

tarifa=paClng(request.QueryString("tarifa"))
if tarifa=0 then tarifa=1 'por defecto

fini="" & request.querystring("fini")
ffin="" & request.querystring("ffin")

if not isdate(fini) or not isdate(ffin) then
	errormsg="Fecha no válida"
end if

codigovip=request.querystring("codigovip")
cpromo=request.querystring("promo")

orden=request.QueryString("orden")

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
	
	'modificado x David(Bizzit).. búsqueda por varios tipos de alojamiento.
	if tipoa<>"" and tipoa<>"0" then
		busco=busco & "ConsultaHoteles.TipoAlojamiento in ("& Replace(tipoa,"-",", ") & ") AND "
	end if
	'fin modificado David.
	
	if TCate<>0 then busco=busco & "Categoria=" & TCate & " AND "
	if TRegimen<>0 then busco=busco & "IdRegimen=" & TRegimen & " AND Anyo=" & anyo & " AND "

	'modificado x David(Bizzit).. búsqueda por varias zonas.
	if TDestino<>"" and TDestino<>"0" then
	    ldestinos=split(TDestino,"-")
		vdestinos=ldestinos(0)
		for hh=1 to ubound(ldestinos)
			vdestinos=vdestinos & "," & ldestinos(hh)
		next
				
      	codigosZonas = GET_ZONE_POR_DESTINO(vdestinos)
      	'response.Write("codigosZonas: " & codigosZona)
	  
	end if
	   
	'Funcion que recibe un Codigo de destino, y devuelve los codigos de zonas separados por guion alto
	FUNCTION GET_ZONE_POR_DESTINO(pDestinos)
		sql="select ciudad_prop FROM productos where idPadre in ("& pDestinos & ")"
		'response.Write(sql)
		
		rsg.open sql , baseGsys
		IF NOT(rsg.eof) THEN    
        	REG_Destino=rsg.getrows
       		Di_idproducto=0
 		END IF
 		rsg.close      

 		Dim codigosZonas
		codigosZonas = ""
      
 		FOR d=0 TO UBOUND(REG_Destino,2)
			if(codigosZonas <> "") then 
				codigosZonas = codigosZonas & ","
			end if
       		codigosZonas = codigosZonas & REG_Destino(IdProducto,d)
 		NEXT

 		GET_ZONE_POR_DESTINO=codigosZonas
 	END FUNCTION
	
	if codigosZonas<>"" and codigosZonas<>"0" then
		busco=busco & "DatosHotel.Zona in (" & Replace(codigosZonas,"-",",") & ") AND "
	end if
	'fin modificado David.
	
	if bnombre<>"" then busco=busco & "Nombre LIKE '%" & bnombre & "%' AND "
	if hoteles<>"" and est=0 then 'busco solo en el array
		lhotel=split(hoteles,"-")
		busco=busco & "("
		for hh=0 to ubound(lhotel)
			busco=busco & "ConsultaHoteles.CodigoEsta=" & lhotel(hh) & " OR "
		next
		busco=left(busco,len(busco)-4) & ") AND "
	end if
	if tservicio<>"" and tservicio<>"0" then 
		busco=busco & " DatosHotel.CodigoEsta IN (SELECT CodigoEsta From CaracteristicasHotel "
		busco=busco & " Where CaracteristicasHotel.IdCaracter IN(" & tservicio & ")) AND "
	end if 'tservicio
	
	'Quitar el "and" ultimo
	busco=left(busco,len(busco)-5)

	cs="SELECT ConsultaHoteles.CodigoEsta,ConsultaHoteles.Nombre,ConsultaHoteles.Categoria,ConsultaHoteles.Zona,"
	cs=cs & "ConsultaHoteles.TipoAlojamiento,Estado,Foto"
	if TRegimen<>0 then
		cs=cs & ",RegimenHotel.Id, ISNULL(Traduccion,Regimen.Nombre) AS elRegimen"
	end if
	cs=cs & ",ISNULL([dbo].[ GetMinimumPrice](DatosHotel.CodigoEsta,SYSDATETIME(),DATEADD(month,6,SYSDATETIME())),0) as MinPrice, Visitas, Orde FROM (ConsultaHoteles INNER JOIN DatosHotel "
	cs=cs & "ON ConsultaHoteles.CodigoEsta=DatosHotel.CodigoEsta) "
	if TRegimen<>0 then 'tambien filtra por regimen
		cs=cs & "INNER JOIN ((RegimenHotel INNER JOIN Regimen ON RegimenHotel.IdRegimen=Regimen.Id) "
		cs=cs & "LEFT JOIN Traducciones ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "') ON ConsultaHoteles.CodigoEsta=RegimenHotel.CodigoEsta "
	end if
	cs=cs & busco
	cs=cs & " ORDER BY "
	ordenado=false
	If(orden = "price") Then
		ordenado=true
		cs=cs & "MinPrice ASC,Categoria DESC,"
	ElseIf (orden = "price2") Then
		ordenado=true
		cs=cs & "MinPrice DESC,Categoria DESC,"
	ElseIf (orden = "category") Then
		ordenado=true
		cs=cs & "Categoria DESC,MinPrice ASC,"
	ElseIf (orden = "category2") Then
		ordenado=true
		cs=cs & "Categoria ASC,MinPrice ASC,"
	End If
	cs=cs & " ConsultaHoteles.CodigoEsta"
	
	'response.write cs
	
	rs.Open cs, base
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
		HoMinPrice=7
		HoVisitas=8
		HoOrden=9
		hayhotel=true
	end if
	rs.close
	
	if not hayhotel then
		errormsg="No encontrados"
		response.write errormsg
	end if
	if errormsg="" then 'no hay error
		
		'Tabla tipos alojamiento
		cs="SELECT TipoAlojamiento.Id,ISNULL(Traduccion,Nombre) AS Nombre FROM TipoAlojamiento LEFT JOIN Traducciones "
		cs=cs & "ON TipoAlojamiento.Id=Traducciones.IdReferencia AND Tabla='TipoAlojamiento' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
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
		cs="SELECT Categorias.Id,ISNULL(Traduccion,Nombre) AS Nombre FROM Categorias LEFT JOIN Traducciones "
		cs=cs & "ON Categorias.Id=Traducciones.IdReferencia AND Tabla='Categorias' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
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
		cs="SELECT TipoHabitaNombres.Id,ParaCapNormal,ParaCapMax,ISNULL(Traduccion,Nombre) AS Nombre,"
		cs=cs & "TipoHabitaNombres.CodigoEsta "
		cs=cs & "FROM TipoHabitaNombres LEFT JOIN Traducciones "
		cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
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
		
		%><!--#include file="CalculoPreciosCupo.asp"--><%
		

		miorden=-1	
		if nlista>-1 then 'Ha encontrado alguna
			If Not(ordenado) Then
				'Ordenar por precios
				SortArray Lista,LTotal
			End If
			
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
					ListaN(LEstadoH,miorden)=Lista(LEstadoH,l)
					
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
								ListaN(LEstadoH,miorden)=Lista(LEstadoH,ll)
							end if 'mismo hotel
						next 'll
					
					end if 'no es ultima
				end if 'no ta
				
				'response.write "Hotel: " & Lista(LHotel,l) & "<br/>"
			next 'l
			
		end if 'nlista



	'Generar XML
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
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
				for h=0 to ubound(RegHotel,2)
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
						response.write vbtab & "<categoria>" & RegHotel(HoCate,h) & "</categoria>" & vbcrlf
						'Buscar Categoria
						response.write vbtab & "<nombreCategoria>"
						if haycate then
						for t=0 to ubound(RegCate,2)
							if RegCate(RCCodi,t)=RegHotel(HoCate,h) then
								response.write server.HTMLEncode(RegCate(RCNombre,t))
								exit for
							end if
						next 't
						end if 'haytipoa
						response.write "</nombreCategoria>" & vbcrlf
						response.write vbtab & "<estado>" & RegHotel(HoEstado,h) & "</estado>" & vbcrlf
						response.write vbtab & "<minprice>" & RegHotel(HoMinPrice,h) & "</minprice>" & vbcrlf
						response.write vbtab & "<orden>" & RegHotel(HoOrden,h) & "</orden>" & vbcrlf
						response.write vbtab & "<visitas>" & RegHotel(HoVisitas,h) & "</visitas>" & vbcrlf
						response.write vbtab & "<zona>" & RegHotel(HoZona,h) & "</zona>" & vbcrlf
						response.write vbtab & "<urlfoto>" & server.HTMLEncode(RegHotel(HoFoto,h)) & "</urlfoto>" & vbcrlf
						response.write vbtab & "<descripcion>"
						'Buscar si tiene texto
						if con_cms then
							cs="SELECT ISNULL(Traduccion,Texto) AS Texto "
							cs=cs & "FROM (TextosHotel INNER JOIN SeccionesHotel "
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
						end if 'con_cms
						response.write "</descripcion>" & vbcrlf
						exit for
					end if
				next 'h
				end if 'hayhotel
				antehotel=ListaN(LHotel,l)
			end if 'otro hotel
			
			'Datos habitacion
			response.write vbtab & "<habitacion>" & vbcrlf
			response.write vbtab & vbtab & "<codhab>" & ListaN(LCHabi,l) & "</codhab>" & vbcrlf
			response.write vbtab & vbtab & "<nombrehab>" & server.HTMLEncode(ListaN(LNHabi,l)) & "</nombrehab>" & vbcrlf
			response.write vbtab & vbtab & "<codregi>" & ListaN(LCRegi,l) & "</codregi>" & vbcrlf
			response.write vbtab & vbtab & "<regimen>" & server.HTMLEncode(ListaN(LNRegimen,l)) & "</regimen>" & vbcrlf
			response.write vbtab & vbtab & "<importe>" & ListaN(LPelas,l) & "</importe>" & vbcrlf
			response.write vbtab & vbtab & "<oferta>" & ListaN(LOferta,l) & "</oferta>" & vbcrlf
			response.write vbtab & vbtab & "<estadohabitacion>" & ListaN(LEstadoH,l) & "</estadohabitacion>" & vbcrlf
			response.write vbtab & "</habitacion>" & vbcrlf

			'Comprobar si cambia hotel
			if l<ubound(ListaN,2) then
				if ListaN(LHotel,l+1)<>antehotel then response.write "</hotel>" & vbcrlf
			end if 'l<ubound(lista)

			
		next 'h
		response.write "</hotel>" & vbcrlf
		
	end if 'miorden>-1
	response.Write "<resultados>" & nhoteles & "</resultados>" & vbcrlf
	response.Write "</data>"

	end if 'errormsg
	
	
else
	response.write errormsg
end if

set rs=nothing
base.close
set base=nothing

set rsg=nothing
baseGsys.close
set baseGsys=nothing

%>