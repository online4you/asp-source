<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
fini=request.QueryString("fini")
ffin=request.QueryString("ffin")

cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona,Moneda "
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
	moneda=rs("moneda")
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<center><h2>Hotel no encontrado</h2></center>"
	response.End()
end if
rs.close

if isdate(fini) then
	fechallegada=cdate(fini)
else
	fechallegada=date
end if

'Buscar la temporada de reserva
cs="SELECT Release,Minimo FROM " & precrs & "Temporadas WHERE CodigoEsta=" & est & " AND "
cs=cs & "(FInicio<=" & FechaMySQL(fechallegada) & " AND FFinal>=" & FechaMySQL(fechallegada) & ")"
rs.open cs,base
release=0
if not rs.eof then
	release=rs("release")
	if rs("minimo")>0 then MinDias=rs("Minimo")
	rs.close
else
	rs.close
	'Buscar la primera temporada
	cs="SELECT Release,FInicio,Minimo FROM " & precrs & "Temporadas WHERE CodigoEsta=" & est & " AND "
	cs=cs & "FInicio>" & FechaMySQL(fechallegada) & " ORDER BY FInicio"
	rs.open cs,base
	if not rs.eof then
		release=rs("release")
		fini=rs("FInicio")
		if rs("minimo")>0 then MinDias=rs("Minimo")
	end if
	rs.close
	'Fechas por defecto
	if fini<>"" then 'hay alguna temporada 
		if (fini-date)<release then 
			fechallegada=date+release
		else '
			fechallegada=fini
		end if

	else 'está cerrado
		errorfecha="Hotel Cerrado"
	end if
end if

if errorfecha="" then 'no hay errores
	if datediff("d",date,fechallegada)<release then 'comprueba la release
		fechallegada=date+release
	end if
	if isdate(ffin) then
		fechasalida=ffin
	else
		fechasalida=fechallegada+MinDias
	end if
	frelease=date+release
	
	'Cargar tabla de temporadas a partir de la frelease
	cs="SELECT FInicio,FFinal,Release,Minimo FROM " & precrs & "Temporadas WHERE CodigoEsta=" & est & " AND "
	cs=cs & "FFinal>" & FechaMySQL(frelease) & " ORDER BY FInicio"
	rs.open cs,base
	haytempos=false
	if not rs.eof then
		RegTempos=rs.getrows
		TFIni=0
		TFFin=1
		TRelease=2
		TMindias=3
		haytempos=true
	end if
	rs.close
	
end if

set rs=nothing
base.close
set base=nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
response.write "<hotel>" & nhotel & "</hotel>" & vbcrlf
response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
response.write "<zona>" & zona & "</zona>" & vbcrlf
response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
response.write "<estado>" & estado & "</estado>" & vbcrlf
response.write "<finicio>" & fechallegada & "</finicio>" & vbcrlf
response.write "<ffinal>" & fechasalida & "</ffinal>" & vbcrlf
response.write "<frelease>" & frelease & "</frelease>" & vbcrlf
response.write "<release>" & release & "</release>" & vbcrlf
response.write "<mindias>" & mindias & "</mindias>" & vbcrlf
if haytempos then
	for t=0 to ubound(RegTempos,2)
		response.write "<temporada>" & vbcrlf
		response.Write vbtab & "<inicio>" & RegTempos(TFIni,t) & "</inicio>" & vbcrlf
		response.Write vbtab & "<fin>" & RegTempos(TFFin,t) & "</fin>" & vbcrlf
		response.Write vbtab & "<release>" & RegTempos(TRelease,t) & "</release>" & vbcrlf
		response.Write vbtab & "<minimo>" & RegTempos(TMindias,t) & "</minimo>" & vbcrlf
		response.write "</temporada>" & vbcrlf
	next
end if
response.write "</data>"
%>