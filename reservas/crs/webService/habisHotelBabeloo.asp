<!--#include file="datosEmpresa.asp"-->
<%
errormsg = ""
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
fechaini=request.QueryString("fini")
fechafin=request.QueryString("ffin")
lang=request.QueryString("lang")

tarifa=paClng(request.QueryString("tarifa"))
if tarifa=0 then tarifa=1 'por defecto

'datos hotel
cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona,ISNULL(NumeroHabitaciones,0) 'numerohabitaciones' "
cs=cs & "FROM Establecimientos LEFT JOIN DatosHotel ON "
cs=cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta LEFT JOIN DatosHotelBabeloo ON "
cs=cs & "DatosHotel.CodigoEsta = DatosHotelBabeloo.CodigoEsta WHERE DatosHotel.CodigoEsta=" & est

rs.Open cs, base
if not rs.eof then
	'Variables para la tabla RegHoteles
	nhotel="" & rs("Nombre")
	estado=paClng(rs("estado"))
	categoria=rs("categoria")
	tipoaloja=rs("tipoalojamiento")
	zona=rs("zona")
	numhabs=rs("numerohabitaciones")
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	errormsg="<center><h2>Hotel no encontrado</h2></center>"
end if
rs.close

if errormsg="" then 'seguimos

	'Buscar tipo hab. y nombre
	cs="SELECT TipoHabitaNombres.Id,isnull(dbo.fnGetTraduccion('TipoHabitaNombres','nombre',TipoHabitaNombres.id,'" & lang & "'),nombre) as Tradu,"
	cs=cs & "ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,"
	cs=cs & "ParaCapNormal,CunaOcupa,ParaAdultMin,"
    cs=cs & "isnull(dbo.fnGetTraduccion('HabitacionesHotel','Texto',HabitacionesHotel.IdHabitacion,'" & lang & "'),isnull(HabitacionesHotel.Texto,'')), "
	cs=cs & "(Select isNull((CASE Min(Cupos.Estado) WHEN 0 THEN 0 ELSE MAX(Cupos.Estado) End),0) "
	cs=cs & "From Cupos Where Cupos.CodigoHab=HabitacionesHotel.IdHabitacion AND Cupos.CodigoEsta=HabitacionesHotel.CodigoEsta "
	cs=cs & "AND Cupos.Dia Between '"&fechaini&"' And '"&fechafin&"') 'Estado', "
	cs=cs & "(Select isNull(max(Cupos.Release),0) From Cupos Where Cupos.CodigoHab=HabitacionesHotel.IdHabitacion "
	cs=cs & " AND Cupos.CodigoEsta=HabitacionesHotel.CodigoEsta AND Cupos.Dia Between '"&fechaini&"' And '"&fechafin&"') 'Release', "
	cs=cs& "dbo.[GetRoomMinimumPrice](TipoHabitaNombres.CodigoEsta,HabitacionesHotel.IdHabitacion,'"&fechaini&"','"&fechafin&"') 'PrecioMin' "
	cs=cs & "FROM TipoHabitaNombres "
	cs=cs & "left join HabitacionesHotel "
	cs=cs & "on HabitacionesHotel.IdHabitacion=TipoHabitaNombres.Id AND HabitacionesHotel.CodigoEsta=TipoHabitaNombres.CodigoEsta "
	cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est & " ORDER BY orden"
	
	'response.write "cs : " & cs & "<br>"
	rs.Open cs, base
	hayhabis=false
	if not rs.eof then
		RegHabis=rs.GetRows
		'Variables para la tabla Habitaciones
		HaCodi=0
		HaNombre=1
		HaCapMax=2
		HaCapMin=3
		HaAduMax=4
		HaNinMax=5
		HaCapNormal=6
		HaCunaOcupa=7
		HaAduMin=8
		HaDesc=9
		HaEstado=10
		HaRelease=11
		HaPrecioMin=12
		hayhabis=true
	end if
	rs.close
		
	anyo=year(fechaini)
	cs="SELECT RegimenHotel.Id,isnull(dbo.fnGetTraduccion('Regimen','nombre',Regimen.id,'" & lang & "'),nombre) as Tradu,"
	cs=cs & "CodigoHab,Defecto,IdRegimen "
	cs=cs & "FROM (Regimen INNER JOIN RegimenHotel "
	cs=cs & "ON Regimen.Id=RegimenHotel.IdRegimen) "
	cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo
	cs=cs & " ORDER BY RegimenHotel.Defecto DESC, Regimen.Id"

	rs.Open cs, base
	haysuples=false
	if not rs.eof then
		RegSuples=rs.GetRows
		'Variables para la tabla Habitaciones
		SCodi=0
		SNombre=1
		SHabi=2
		SDefecto=3
		SIdRegimen=4
		haysuples=true
	end if
	rs.close
	
	'Buscar fotos hab.
	cs="SELECT FotosHabitacion.Id,FotosHabitacion.IdHabitacion,FotosHabitacion.Orden,FotosHabitacion.Foto "
	cs=cs & "FROM FotosHabitacion INNER JOIN HabitacionesHotel "
	cs=cs & "on HabitacionesHotel.IdHabitacion = FotosHabitacion.IdHabitacion "
	cs=cs & "where HabitacionesHotel.CodigoEsta = " & est & " ORDER BY FotosHabitacion.Orden"
	
	'response.write "cs : " & cs & "<br>"
	rs.Open cs, base
	hayfotos=false
	if not rs.eof then
		RegFotos=rs.GetRows
		'Variables para la tabla Habitaciones
		FoId=0
		FoIdHab=1
		FoOrden=2
		FoFoto=3
		hayfotos=true
	end if
	rs.close

	'Cargar colectivos de ese hotel
	cs="SELECT CodigoColec,ISNULL(Traduccion,Nombre) AS Tradu,Orde "
	cs=cs & "FROM Colectivos LEFT JOIN Traducciones "
	cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE ISNULL(Traduccion,Nombre)<>'' AND "
	cs=cs & "Colectivos.CodigoEsta=" & est & " ORDER BY orde"
	'response.write "cs: " & cs & "<br>"
	rs.open cs,base
	Dim hayColec
	hayColec = false
	if not rs.eof then
		RegColec=rs.GetRows
		CCodi=0
		CNombre=1
		COrden=2
		hayColec = true
	end if
	rs.close
	
	dim CodigoHabis()
	haycodigohabis=false
	redim preserve CodigoHabis(0)
	redim preserve CupoHabis(0)
	FechaI=CDate(FechaIni)
	FechaF=CDate(FechaFin)-1
	FLlegada=cdate(FechaIni)
	FSalida=cdate(FechaFin)
	noches=FSalida-FLlegada
		
	'Buscar por tipo habitacion los cupos y la ocupacion
	if hayhabis then
		for iHabitacion=0 to ubound(RegHabis,2)
			for diavte=fechai to fechaf
				
				'Buscar cupo en esa fecha
				codhab=RegHabis(HaCodi,iHabitacion)
				elCupo=0
				%><!--#include file="tieneCupoNew.asp"--><%
				if not tieneCupo then				
					exit for 'siguiente habitacion
				end if
			
			next 'diavte (fecha)
			if elCupo>0 then 'hay disponible
				redim preserve CodigoHabis(Ubound(CodigoHabis)+1)
				redim preserve CupoHabis(Ubound(CupoHabis)+1)
				CodigoHabis(Ubound(CodigoHabis))=RegHabis(HaCodi,iHabitacion)
				CupoHabis(Ubound(CupoHabis))=elCupo
				haycodigohabis=true
			end if
		
		next 'h (habitaciones)
	end If	
end if 'codtem<>0

set rs=nothing
base.close
set base=nothing

if errormsg="" then 'seguimos no hay fallos
	'General XML de respuesta
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<data>" & vbcrlf
	response.write vbtab & "<codigo>" & est & "</codigo>" & vbcrlf
	response.write vbtab & "<hotel>" & server.HTMLEncode(nhotel) & "</hotel>" & vbcrlf
	response.write vbtab & "<categoria>" & categoria & "</categoria>" & vbcrlf
	response.write vbtab & "<zona>" & zona & "</zona>" & vbcrlf
	response.write vbtab & "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
	response.write vbtab & "<estado>" & estado & "</estado>" & vbcrlf
	'Poner colectivos
	If hayColec Then
		For c=0 To UBound(RegColec,2)
			response.write vbtab & "<colectivo>" & vbcrlf
			response.write vbtab & vbtab & "<codcolec>" & RegColec(CCodi,c) & "</codcolec>" & vbcrlf
			response.write vbtab & vbtab & "<nomcolec>" & server.HTMLEncode(RegColec(CNombre,c)) & "</nomcolec>" & vbcrlf
			response.write vbtab & vbtab & "<ordencolec>" & RegColec(COrden,c) & "</ordencolec>" & vbcrlf
			response.write vbtab & "</colectivo>" & vbcrlf
		next 
	end if 'colec
	if hayhabis then
		for h=0 to ubound(RegHabis,2)
			gueno=false
			cupo=0
			if haycodigohabis then 'poner solo las habitaciones con cupo
				for cu=1 to ubound(CodigoHabis)
					if CodigoHabis(cu)=RegHabis(HaCodi,h) then
						cupo=CupoHabis(cu)
						
						exit for
					end if
				next 'cupos
			end if
			
			gueno=true 'Se fuerza para que incluya habitaciones sin cupo
			if gueno then 'seguimos porque tiene cupo
				response.write vbtab & "<habitacion>" & vbcrlf
				response.write vbtab & vbtab & "<codhab>" & RegHabis(HaCodi,h) & "</codhab>" & vbcrlf
				response.write vbtab & vbtab & "<nomhab>" & server.HTMLEncode(RegHabis(HaNombre,h)) & "</nomhab>" & vbcrlf
				response.write vbtab & vbtab & "<capmax>" & RegHabis(HaCapMax,h) & "</capmax>" & vbcrlf
				response.write vbtab & vbtab & "<capmin>" & RegHabis(HaCapMin,h) & "</capmin>" & vbcrlf
				response.write vbtab & vbtab & "<capnormal>" & RegHabis(HaCapNormal,h) & "</capnormal>" & vbcrlf
				response.write vbtab & vbtab & "<adultmax>" & RegHabis(HaAduMax,h) & "</adultmax>" & vbcrlf
				response.write vbtab & vbtab & "<adultmin>" & RegHabis(HaAduMin,h) & "</adultmin>" & vbcrlf
				response.write vbtab & vbtab & "<ninmax>" & RegHabis(HaNinMax,h) & "</ninmax>" & vbcrlf
				response.write vbtab & vbtab & "<cunaocupa>" & clng(RegHabis(HaCunaOcupa,h)) & "</cunaocupa>" & vbcrlf
				response.write vbtab & vbtab & "<descripcion>" & server.HTMLEncode(RegHabis(HaDesc,h)) & "</descripcion>" & vbcrlf
				response.write vbtab & vbtab & "<cupo>" & cupo & "</cupo>" & vbcrlf
				'Regimen
				if haysuples then
					for r=0 to ubound(RegSuples,2)
						if RegSuples(SHabi,r)=0 OR RegSuples(SHabi,r)=RegHabis(HaCodi,h) then
							response.write vbtab & vbtab & "<regimen>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<codregimen>" & RegSuples(SCodi,r) & "</codregimen>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<nomregimen>" & server.HTMLEncode(RegSuples(SNombre,r)) & "</nomregimen>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<pordefecto>" & clng(RegSuples(SDefecto,r)) & "</pordefecto>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<idregimen>" & clng(RegSuples(SIdRegimen,r)) & "</idregimen>" & vbcrlf
							response.write vbtab & vbtab & "</regimen>" & vbcrlf
						end if 'es suple de la habi
					next 'r
				end if
				'Foto
				if hayfotos then
					for r=0 to ubound(RegFotos,2)
						if RegFotos(FoIdHab,r)=0 OR RegFotos(FoIdHab,r)=RegHabis(HaCodi,h) then
							response.write vbtab & vbtab & "<foto>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<idfoto>" & RegFotos(FoId,r) & "</idfoto>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<foto>" & server.HTMLEncode(RegFotos(FoFoto,r)) & "</foto>" & vbcrlf
							response.write vbtab & vbtab & vbtab & "<orden>" & clng(RegFotos(FoOrden,r)) & "</orden>" & vbcrlf
							response.write vbtab & vbtab & "</foto>" & vbcrlf
						end if 'es foto de la habi
					next 'r
				end if
				response.write vbtab & vbtab & "<estado>" & clng(RegHabis(HaEstado,h)) & "</estado>" & vbcrlf
				response.write vbtab & vbtab & "<release>" & clng(RegHabis(HaRelease,h)) & "</release>" & vbcrlf
				response.write vbtab & vbtab & "<precioMin>" & RegHabis(HaPrecioMin,h) & "</precioMin>" & vbcrlf
				response.write vbtab & "</habitacion>" & vbcrlf
			end if 'gueno
		next 'h
	end if 'hayhabis
	response.write vbtab & "<numhabs>" & numhabs & "</numhabs>" & vbcrlf
	response.write "</data>"
		
end if 'errormsg=""
%>