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
lang=request.QueryString("lang")

'datos hotel
cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel ON "
cs=cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta WHERE DatosHotel.CodigoEsta=" & est
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
	cs="SELECT Id,nombre_" & lang & ",ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,"
	cs=cs & "ParaCapNormal,CunaOcupa,ParaAdultMin FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY orden"
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
		hayhabis=true
	end if
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
		cs="SELECT RegimenHotel.Id,Nombre_" & lang & ",CodigoHab,Defecto "
		cs=cs & "FROM " & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel "
		cs=cs & "ON Regimen.Id=RegimenHotel.IdRegimen "
		cs=cs & "WHERE CodigoEsta=" & est
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
			haysuples=true
		end if
		rs.close
	
		'Cargar colectivos de ese hotel
		cs="SELECT CodigoColec,Nombre_" & lang &",Orde FROM " & precrs & "Colectivos Colectivos "
		cs=cs & " WHERE nombre_"& lang & "<>'' AND "
		cs=cs & " CodigoEsta=" & est & " ORDER BY orde"
		'response.write "cs: " & cs & "<br>"
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
			
		'Buscar por tipo habitacion los cupos y la ocupacion
		for h=0 to ubound(RegHabis,2)
			for diavte=fechai to fechaf
				'Buscar cupo en esa fecha
				cupo=0
				'Comprobar que tenga cupo
				cs="SELECT Cupo FROM Cupos "
				cs=cs & "WHERE CodigoHab=" & RegHabis(HaCodi,h) & " AND "
				cs=cs & "Dia=" & FechaMySQL(diavte)
				rs.open cs,base 
				if not rs.eof then
					cupo=rs("cupo")
				end if
				rs.close
				if cupo<1 then 'no hay cupo
					exit for 'siguiente habitacion
				end if
				
				'Busco la ocupacion
				ocu=0
				cs="SELECT SUM(CuantasHabis) as TotalHabis "
				cs=cs & "FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "Reservas Reservas "
				cs=cs & "ON TipoReserva.IdReserva=Reservas.Cod_res "
				cs=cs & "WHERE Activa<>0 AND "
				cs=cs & "IdTipoHabitacion=" & RegHabis(HaCodi,h) & " AND ("
				cs=cs & FechaMySQL(diavte) & ">=FechaInicio AND "
				cs=cs & FechaMySQL(diavte) & "<FechaFinal)"
				rs.open cs,base
				if not rs.eof then
					ocu=clng("0" & rs("TotalHabis")) 'Nº de hab. ocupadas
				end if
				rs.close
				if cupo<=ocu then 'no ni ha
					cupo=0
					exit for 'siguiente habitacion
				end if
			
			next 'diavte (fecha)
			if cupo>0 then 'hay disponible
				redim preserve CodigoHabis(Ubound(CodigoHabis)+1)
				redim preserve CupoHabis(Ubound(CupoHabis)+1)
				CodigoHabis(Ubound(CodigoHabis))=RegHabis(HaCodi,h)
				CupoHabis(Ubound(CupoHabis))=cupo
				haycodigohabis=true
			end if
		
		next 'h (habitaciones)
	
	end if 'codtem<>0
	
	set rs=nothing
	base.close
	set base=nothing
	
	if errormsg="" then 'seguimos no hay fallos
		'General XML de respuesta
		response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
		response.write "<data>" & vbcrlf
		response.write "<codigo>" & est & "</codigo>" & vbcrlf
		response.write "<hotel>" & nhotel & "</hotel>" & vbcrlf
		response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
		response.write "<zona>" & zona & "</zona>" & vbcrlf
		response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
		response.write "<estado>" & estado & "</estado>" & vbcrlf
		'Poner colectivos
		for c=0 TO ubound(RegColec,2)
			response.write "<colectivo>" & vbcrlf
			response.write "<codcolec>" & RegColec(CCodi,c) & "</codcolec>" & vbcrlf
			response.write "<nomcolec>" & RegColec(CNombre,c) & "</nomcolec>" & vbcrlf
			response.write "<ordencolec>" & RegColec(COrden,c) & "</ordencolec>" & vbcrlf
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
					response.write "<habitacion>" & vbcrlf
					response.write "<codhab>" & RegHabis(HaCodi,h) & "</codhab>" & vbcrlf
					response.write "<nomhab>" & RegHabis(HaNombre,h) & "</nomhab>" & vbcrlf
					response.write "<capmax>" & RegHabis(HaCapMax,h) & "</capmax>" & vbcrlf
					response.write "<capmin>" & RegHabis(HaCapMin,h) & "</capmin>" & vbcrlf
					response.write "<capnormal>" & RegHabis(HaCapNormal,h) & "</capnormal>" & vbcrlf
					response.write "<adultmax>" & RegHabis(HaAduMax,h) & "</adultmax>" & vbcrlf
					response.write "<adultmin>" & RegHabis(HaAduMin,h) & "</adultmin>" & vbcrlf
					response.write "<ninmax>" & RegHabis(HaNinMax,h) & "</ninmax>" & vbcrlf
					response.write "<cunaocupa>" & clng(RegHabis(HaCunaOcupa,h)) & "</cunaocupa>" & vbcrlf
					response.write "<cupo>" & cupo & "</cupo>" & vbcrlf
					'Regimen
					if haysuples then
						for r=0 to ubound(RegSuples,2)
							if RegSuples(SHabi,r)=0 OR RegSuples(SHabi,r)=RegHabis(HaCodi,h) then
								response.write "<regimen>" & vbcrlf
								response.write "<codregimen>" & RegSuples(SCodi,r) & "</codregimen>" & vbcrlf
								response.write "<nomregimen>" & RegSuples(SNombre,r) & "</nomregimen>" & vbcrlf
								response.write "<pordefecto>" & clng(RegSuples(SDefecto,r)) & "</pordefecto>" & vbcrlf
								response.write "</regimen>" & vbcrlf
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
%>