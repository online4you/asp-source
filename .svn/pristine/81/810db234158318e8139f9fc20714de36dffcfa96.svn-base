<%
localConnection=true
%>
<!--#include file="datosEmpresa.asp"-->
<%

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
fechaini=request.QueryString("fini")
fechafin=request.QueryString("ffin")
lang=request.QueryString(" lang")

tarifa=paClng(request.QueryString("tarifa"))
if tarifa=0 then tarifa=1 'por defecto

'datos hotel
cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel ON "
cs=cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta WHERE DatosHotel.CodigoEsta=" & est
'response.write (cs & "<br>")
rs.Open cs, base
if not rs.eof then
	'Variables para la tabla RegHoteles
	nhotel="" & rs("Nombre")
	estado=paClng(rs("estado"))
	categoria=rs("categoria")
	tipoaloja=rs("tipoalojamiento")
	zona=rs("zona")
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
	cs="SELECT TipoHabitaNombres.Id,IF(ISNULL(Traduccion),nombre,Traduccion) as Tradu,ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,"
	cs=cs & "ParaCapNormal,CunaOcupa,ParaAdultMin,AdmiteNinos "
	cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
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
		HaAdmiNinos=9
		hayhabis=true
	end if
	
	'response.write "ParaCapMax: " & rs(0) & "<br>"
	rs.close
	cs="SELECT CodigoTemp,Minimo FROM " & precrs & "Temporadas Temporadas "
	cs=cs & "WHERE CodigoEsta=" & est
	cs=cs & " AND (FInicio<=" & FechaMySQL(fechaini)& " AND "
	cs=cs & "FFinal>=" & FechaMySQL(fechaini) & ")"
	rs.open cs,base
	codtem=0
	if not rs.eof then 'Tenemos cod. temporada
		codtem=rs("CodigoTemp")
	end if
	rs.close
	if codtem=0 then 'Jodio
		errormsg="Error Fechas"
	else 'la guena
	
		anyo=year(fechaini)
		cs="SELECT RegimenHotel.Id,IF(ISNULL(Traduccion),nombre,Traduccion) AS Tradu,CodigoHab,Defecto,IdRegimen "
		cs=cs & "FROM (" & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel "
		cs=cs & "ON Regimen.Id=RegimenHotel.IdRegimen) LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
		cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est
		cs=cs & " AND (CodigoTempo=" & codtem & " OR CodigoTempo=0) AND Anyo=" & anyo
		cs=cs & " ORDER BY Regimen.Id"
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
		'response.write "cs: " & cs & "<br>"
		
		'Cargar colectivos de ese hotel
		cs="SELECT CodigoColec,IF(ISNULL(Traduccion),nombre,Traduccion) AS Tradu,Orde "
		cs=cs & "FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
		cs=cs & "WHERE IF(ISNULL(Traduccion),nombre,Traduccion)<>'' AND "
		cs=cs & "Colectivos.CodigoEsta=" & est & " ORDER BY orde"
		
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.GetRows
			CCodi=0
			CNombre=1
			COrden=2
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
		for h=0 to ubound(RegHabis,2)
			for diavte=fechai to fechaf
				
				'Buscar cupo en esa fecha
				codhab=RegHabis(HaCodi,h)
				elCupo=0
				%><!--#include file="tieneCupoNew.asp"--><%
				'response.write "elCupo: " & elCupo & "<br>"
				if not tieneCupo then				
					exit for 'siguiente habitacion
				end if
				
				'response.end
			next 'diavte (fecha)
			
			if elCupo>0 then 'hay disponible
				redim preserve CodigoHabis(Ubound(CodigoHabis)+1)
				redim preserve CupoHabis(Ubound(CupoHabis)+1)
				CodigoHabis(Ubound(CodigoHabis))=RegHabis(HaCodi,h)
				CupoHabis(Ubound(CupoHabis))=elCupo
				haycodigohabis=true
			end if
		
		next 'h (habitaciones)
	
	end if 'codtem<>0
	

	if errormsg="" then 'seguimos no hay fallos
		'General XML de respuesta
		response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
		response.write "<data>" & vbcrlf
		response.write "<codigo>" & est & "</codigo>" & vbcrlf
		response.write "<hotel>" & server.HTMLEncode(nhotel) & "</hotel>" & vbcrlf
		response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
		response.write "<zona>" & zona & "</zona>" & vbcrlf
		response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
		response.write "<estado>" & estado & "</estado>" & vbcrlf
		'Poner colectivos
		for c=0 TO ubound(RegColec,2)
			response.write "<colectivo>" & vbcrlf
			response.write vbtab & "<codcolec>" & RegColec(CCodi,c) & "</codcolec>" & vbcrlf
			response.write vbtab & "<nomcolec>" & server.HTMLEncode(RegColec(CNombre,c)) & "</nomcolec>" & vbcrlf
			response.write vbtab & "<ordencolec>" & RegColec(COrden,c) & "</ordencolec>" & vbcrlf
			response.write "</colectivo>" & vbcrlf
		next 'colec
		if hayhabis then
			for h=0 to ubound(RegHabis,2)
				gueno=false
						
				if haycodigohabis then 'poner solo las habitaciones con cupo
					for cu=1 to ubound(CodigoHabis)
						if CodigoHabis(cu)=RegHabis(HaCodi,h) then
							cupo=CupoHabis(cu)
							gueno=true
							exit for
						end if
					next 'cupos
				end if
				if gueno then 'seguimos porque tiene cupo
				
					'Fotos de la habitacion
					cs="SELECT Foto FROM " & precrs & "FotosHabitacion FotosHabitacion WHERE IdHabitacion=" & RegHabis(HaCodi,h) & " ORDER BY Orden,Id"
					
					
					rs.open cs,base
					lasfotos=""
					do while not rs.eof
						lasfotos=lasfotos & "http://admin.kubikcrs.com" & rutaFotos & server.HTMLEncode(rs("foto")) & ";"
						rs.movenext
					loop
					rs.close
					
					'Textos de la habitacion
					cs="SELECT IF(ISNULL(Traduccion),texto,Traduccion) AS Tradu FROM " & precrs & "HabitacionesHotel HabitacionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
					cs=cs & "ON HabitacionesHotel.IdHabitacion=Traducciones.IdReferencia AND Tabla='HabitacionesHotel' AND "
					cs=cs & "Campo='Texto' AND Idioma='" & lang & "' "
					cs=cs & "WHERE IdHabitacion=" & RegHabis(HaCodi,h)
					
					rs.open cs,base
					eltexto=""
					if not rs.eof then
						eltexto=server.HTMLEncode("" & rs("Tradu"))
					end if
					rs.close
					
					
					
					response.write "<habitacion>" & vbcrlf
					response.write vbtab & "<codhab>" & RegHabis(HaCodi,h) & "</codhab>" & vbcrlf
					response.write vbtab & "<nomhab>" & server.HTMLEncode(RegHabis(HaNombre,h)) & "</nomhab>" & vbcrlf
					response.write vbtab & "<fotos>" & lasfotos & "</fotos>" & vbcrlf
					response.write vbtab & "<descripcion>" & eltexto & "</descripcion>" & vbcrlf
					response.write vbtab & "<capmax>" & RegHabis(HaCapMax,h) & "</capmax>" & vbcrlf
					response.write vbtab & "<capmin>" & RegHabis(HaCapMin,h) & "</capmin>" & vbcrlf
					response.write vbtab & "<capnormal>" & RegHabis(HaCapNormal,h) & "</capnormal>" & vbcrlf
					response.write vbtab & "<adultmax>" & RegHabis(HaAduMax,h) & "</adultmax>" & vbcrlf
					response.write vbtab & "<adultmin>" & RegHabis(HaAduMin,h) & "</adultmin>" & vbcrlf
					response.write vbtab & "<ninmax>" & RegHabis(HaNinMax,h) & "</ninmax>" & vbcrlf
					response.write vbtab & "<cunaocupa>" & paClng(RegHabis(HaCunaOcupa,h)) & "</cunaocupa>" & vbcrlf
					response.write vbtab & "<admiteninos>" & paClng(RegHabis(HaAdmiNinos,h)) & "</admiteninos>" & vbcrlf
					response.write vbtab & "<cupo>" & cupo & "</cupo>" & vbcrlf
					'Regimen
					if haysuples then
						for r=0 to ubound(RegSuples,2)
							if RegSuples(SHabi,r)=0 OR RegSuples(SHabi,r)=RegHabis(HaCodi,h) then
								response.write vbtab & "<regimen>" & vbcrlf
								response.write vbtab & vbtab & "<codregimen>" & RegSuples(SCodi,r) & "</codregimen>" & vbcrlf
								response.write vbtab & vbtab & "<nomregimen>" & server.HTMLEncode(RegSuples(SNombre,r)) & "</nomregimen>" & vbcrlf
								response.write vbtab & vbtab & "<pordefecto>" & clng(RegSuples(SDefecto,r)) & "</pordefecto>" & vbcrlf
								response.write vbtab & vbtab & "<idregimen>" & clng(RegSuples(SIdRegimen,r)) & "</idregimen>" & vbcrlf
								response.write vbtab & "</regimen>" & vbcrlf
							end if 'es suple de la habi
						next 'r
					end if
					response.write "</habitacion>" & vbcrlf
				end if 'gueno
			next 'h
		end if 'hayhabis
		response.write "</data>"
	end if 'otro errormsg
		
end if 'errormsg=""

set rs=nothing
base.close
set base=nothing

%>