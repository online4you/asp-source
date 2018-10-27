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

ide = paClng(request.QueryString("ide")) 'la empresa
est = paClng(request.QueryString("est")) 'el hotel

'datos hotel
cs = "SELECT DatosHotel.CodigoEsta,Establecimientos.Nombre,Estado,Categoria,TipoAlojamiento,Zona,PorCiento,CodigoISO "
cs = cs & "FROM (" & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel ON "
cs = cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) LEFT JOIN " & precrs & "TiposMoneda TiposMoneda "
cs = cs & "ON Establecimientos.Moneda=TiposMoneda.Id "
cs = cs & "WHERE DatosHotel.CodigoEsta=" & est
rs.Open cs, base
if not rs.eof then
	'Variables para la tabla RegHoteles
	nhotel="" & rs("Nombre")
	estado=paClng(rs("estado"))
	categoria=rs("categoria")
	tipoaloja=rs("tipoalojamiento")
	zona=rs("zona")
	prepago=rs("porciento")
	moneda=rs("CodigoISO")
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<center><h2>Hotel no encontrado</h2></center>"
	response.End()
end if
rs.close

FLlegada=cdate(request.QueryString("fini"))
FSalida=cdate(request.QueryString("ffin"))
anyo=year(FLlegada)
noches=FSalida-FLlegada
lang=request.QueryString("lang")
numHabs=request.QueryString("numHabs")
'Datos la habitacion
codhab=paClng(request.QueryString("codhab"))
adultos=paClng(request.QueryString("ad"))
ninos1=paClng(request.QueryString("ni1"))
ninos2=paClng(request.QueryString("ni2"))
codsuple=paClng(request.QueryString("codsup"))
idregi=paClng(request.QueryString("idregi"))
codigovip=request.QueryString("codigovip")
'Response.Write "<!--" & ide & "-" & est & "-" & FLlegada & "-" & FSalida & "-" & anyo & "-" & codhab & "-->"
tarifa=paClng(request.QueryString("tarifa"))
if tarifa=0 then tarifa=1 'por defecto

cpromo=request.QueryString("promo") 'oferta de promocion

'Array de las lineas de reserva
dim PrecioHab(),Preciosuples(),TotalSuples(),PrecioPlazas(),DtoHab(),DtoSuples()
dim FechaRes(),PrecioPerso()
dim OfertaHab(),OfertaRegimen()
dim TotalOferta(),CodiOferta(),TextoOferta()
dim TotalExtras()
dim dtoExtras()
dim PrepagoDia()
redim preserve TotalExtras(noches)
redim preserve dtoExtras(noches)
porCientoOferta=0
redim preserve PrecioHab(noches)
redim preserve PrecioPerso(noches)
redim preserve FechaRes(noches)
redim preserve PrecioSuples(noches)
redim preserve PrecioPlazas(noches)
redim preserve DtoHab(noches)
redim preserve DtoSuples(noches)
redim preserve TotalSuples(noches)
redim preserve OfertaHab(noches)
redim preserve OfertaRegimen(noches)
redim preserve totalOferta(noches)
redim preserve codiOferta(noches)
redim preserve textoOferta(noches)
redim preserve PrepagoDia(noches)

dim listaOfertas()
dim listaOfertasAmigo()
RIdOferta=0
RNomOferta=1
RCalculaOferta=2
RPelasOferta=3
RDto = 4

%><!--#include file="tieneCupoNew.asp"--><%

if tieneCupo then 'sigo con los otros datos 

	'Fotos de la habitacion
	cs = "SELECT Foto FROM " & precrs & "FotosHabitacion WHERE IdHabitacion=" & codhab & " ORDER BY Orden,Id"
	rs.open cs,base
	lasfotos=""
	do while not rs.eof
		lasfotos=lasfotos & rs("foto") & ";"
		rs.movenext
	loop
	rs.close
	
	'Textos de la habitacion
	cs = "SELECT IF(ISNULL(traduc.Traduccion),HabitacionesHotel.Texto,traduc.Traduccion) AS Tradu "
	cs = cs & "FROM " & precrs & "HabitacionesHotel HabitacionesHotel "
	cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""HabitacionesHotel"" And Campo = ""Texto"" And Idioma = """ & lang & """)  AS traduc ON HabitacionesHotel.CodigoEsta = traduc.IdReferencia  "
	cs = cs & "WHERE IdHabitacion=" & codhab
	rs.open cs,base
	if not rs.eof then
		eltexto=server.HTMLEncode("" & rs("tradu"))
	end if
	rs.close
	
	'Buscar los colectivos de este hotel
	cs = "SELECT CodigoColec,Orde FROM " & precrs & "Colectivos "
	cs = cs & "WHERE CodigoEsta=" & est & " ORDER BY orde"
	'response.write "cs: " & cs & "<br>"
	colecadultos=0
	colecninos1=0
	colecninos2=0
	rs.open cs,base
	do while not rs.eof
		if rs("orde")=0 then colecadultos=rs("CodigoColec") 'codigo adultos
		if rs("orde")=1 then colecninos1=rs("CodigoColec") 'codigo ninos1
		if rs("orde")=2 then colecninos2=rs("CodigoColec") 'codigo ninos2
		rs.movenext
	loop
	rs.close
	
	'dias semana
	dim diasemana(7)
	diasemana(1) = "L"
	diasemana(2) = "M"
	diasemana(3) = "X"
	diasemana(4) = "J"
	diasemana(5) = "V"
	diasemana(6) = "S"
	diasemana(7) = "D"
	
	
	'Buscado cod. temporada
	cs = "SELECT CodigoTemp, FInicio, FFinal"

	if ide = 98 then
		cs = cs & ", Oferta"
	end if
	
	cs = cs & " FROM " & precrs & "Temporadas "
	cs = cs & "WHERE CodigoEsta=" & est
	cs = cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FInicio AND FFinal) AND "
	cs = cs & "(" & FechaMySQL(FSalida - 1) & " BETWEEN FInicio AND FFinal)) OR "
	cs = cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FInicio AND FFinal) AND "
	cs = cs & FechaMySQL(FSalida - 1) & " > FFinal) OR (" & FechaMySQL(FLlegada) & " < FInicio AND "
	cs = cs & "(" & FechaMySQL(FSalida - 1) & " BETWEEN FInicio AND FFinal)) OR ("
	cs = cs & FechaMySQL(FLlegada) & " < FInicio AND " & FechaMySQL(FSalida - 1) & " > FFinal))"

	rs.open cs,base
	'response.write cs & "<br/>"
	haytempos = false
	if not rs.eof then 'Tenemos cod. temporada
		RegTempos = rs.getrows
		TCodi = 0
		TFIni = 1
		TFFin = 2
		TOferta = 3
		
		haytempos = true
		'for t=0 to ubound(RegTempos,2)
		'	response.write RegTempos(TCodi,t) & " - " & RegTempos(TFIni,t) & " - " & RegTempos(TFFin,t) & "<br>"
		'next
	end if
	rs.close
	
	'tabla precios cupo
	cs = "SELECT Dia,Precio,DiasMinimos,ReleaseHab,Estado FROM " & precrs & "Cupos WHERE CodigoHab=" & codhab & " AND ("
	cs = cs & "Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1) & ") ORDER BY Dia"
	'response.Write(cs & "<br>")
	rs.open cs,base
	hayprecios=false
	if not rs.eof then
		RegPrecios=rs.getrows
		PDia=0
		PPelas=1
		PMinimos=2
		PRelease=3
		PEstadoHab=4
		hayprecios=true
	end if
	rs.close
	'valores
	estadoHab="OL"
	release="OK"
	diasMinimos="OK"
	
	anteriorTempo=-1
	sumabruto = 0
	idRegimen = 0 'por defecto
	dia=0 'dias de reserva
	precioValido=true
	if hayprecios then
	
		%><!--#include file="tieneOfertaNew.asp"--><%
		if hayOferta then
			%><!--#include file="CalculaOfertaNoches.asp"--><%
		end if
		haytemposDia = true
		PrepagoDiaTot=0
		for prec = 0 to ubound(RegPrecios, 2)
			dia = dia + 1 'dias de reserva
			d = RegPrecios(PDia, prec)
			FechaRes(dia) = d 'Dia de la reserva
			anyo = year(d)
			
			%><!--#include file="calcuTemporada2.asp"--><%

			if calcular then 
				%><!--#include file="controlEstado.asp"--><%
				%><!--#include file="precioHabiNew.asp"--><%
				%><!--#include file="Dto3Persona.asp"--><%
				%><!--#include file="PrecioRegimen.asp"--><%
				%><!--#include file="DtosRegimen.asp"--><%
				'Comprobar si hay oferta para el precio total reserva

				if hayOferta then
					%><!--#include file="CalculaOferta.asp"--><%
				end if 'hayOferta
			else 'no hay temporada definida
				precioValido=false
				exit for
			end if
		next 'dia

		'comprobar si tiene oferta de noches gratis
		if hayOferta then
			%><!--#include file="CalculaOfertaNoches.asp"--><%
		end if
		'comprobar si tiene oferta de cliente VIP
		
		if codigoVIP <> "" then
			%><!--#include file="CalculaOfertaVIP.asp"--><%
		end if
					
		%><!--#include file="PrecioExtras.asp"--><%

	end if 'hayprecios
	
	'Importe reserva
	SumaHabi = 0
	SumaSuple = 0
	SumaDto3 = 0
	SumaDtoSuple = 0
	SumaExtras = 0
	if precioValido then
		PrepagoDiaTot=0
		for d = 1 to noches
			'response.Write("<br> PrecioPlazas(d)=" &  PrecioPlazas(d))	
			'response.Write("<br> TotalExtras(d)=" &  TotalExtras(d))	
			'PrecioPlazas(d)=PrecioPlazas(d) + TotalExtras(d)
			'response.Write("<br> PrecioPlazas(d)=" &  PrecioPlazas(d))
			'response.Write("<br>")
			if (haytemposDia=true) then
				PrepagoDiaTot = PrepagoDiaTot + PrepagoDia(dia)
			end if
			sumaHabi = sumaHabi + PrecioPlazas(d) 
			sumaDto3 = sumaDto3 + DtoHab(d)
			sumaSuple = sumaSuple + TotalSuples(d)
			sumaDtoSuple = sumaDtoSuple + dtoSuples(d)
			SumaExtras = SumaExtras + TotalExtras(d) 
			'SumaExtras = SumaExtras + TotalExtras(d) - dtoExtras(d)
		next
		if (haytemposDia=true) then
			PrepagoDiaTot = PrepagoDiaTot / dia
			PrepagoDiaTot=redondear(PrepagoDiaTot)
		end if
		
		'response.Write("<br>SumaHabi=" & SumaHabi)	
		'response.Write("<br>SumaSuple=" & SumaSuple)	
		'response.Write("<br>SumaDto3=" & SumaDto3)	
		'response.Write("<br>SumaDtoSuple=" & SumaDtoSuple)	
		'response.Write("<br>SumaDtoExtras=" & SumaDtoExtras)	
		'response.Write("<br>SumaExtras=" & SumaExtras)	
		sumaBruto = SumaHabi + SumaSuple - (SumaDto3 + SumaDtoSuple) 'Total Bruto reserva
		'sumaBruto = SumaHabi + SumaSuple 'Total Bruto reserva
	end if 'precioValido

else 'no tiene cupo
	estadoHab = "NV"
	sumabruto = 0
end if 'tieneCupo

set rs = nothing
base.close
set base = nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
response.write "<hotel>" & server.HTMLEncode(nhotel) & "</hotel>" & vbcrlf
response.write "<moneda>" & moneda & "</moneda>" & vbcrlf
response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
response.write "<zona>" & zona & "</zona>" & vbcrlf
response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
response.write "<estado>" & estado & "</estado>" & vbcrlf
response.write "<prepago>" & prepago & "</prepago>" & vbcrlf
response.write "<prepagoTemp>" & PrepagoDiaTot & "</prepagoTemp>" & vbcrlf
response.write "<totalbruto>" & sumabruto & "</totalbruto>" & vbcrlf
response.write "<netoextras>" & SumaExtras & "</netoextras>" & vbcrlf
response.write "<estadohabitacion>" & estadohab & "</estadohabitacion>" & vbcrlf
response.write "<diasminimos>" & diasMinimos & "</diasminimos>" & vbcrlf
response.write "<release>" & release & "</release>" & vbcrlf
response.write "<prepagoHab>" & prepagoHabi & "</prepagoHab>" & vbcrlf

if ide = 98 then
	response.write "<ofertatem>" & ofertatem & "</ofertatem>" & vbcrlf
end if

'Ofertas

if not isArrayVacio(ListaOfertas) then

	for xx = 0 to ubound(ListaOfertas, 2)		
		response.write "<oferta>" & vbcrlf	
		response.write vbtab & "<codioferta>" & listaOfertas(RIdOferta,xx) & "</codioferta>" & vbcrlf
		response.write vbtab & "<textooferta>" & server.HTMLEncode(listaOfertas(RNomOferta,xx)) & "</textooferta>" & vbcrlf
		response.write vbtab & "<calculaoferta>" & paClng(listaOfertas(RCalculaOferta,xx)) & "</calculaoferta>" & vbcrlf
		response.write vbtab & "<totaloferta>" & listaOfertas(RPelasOferta,xx) & "</totaloferta>" & vbcrlf
		response.write vbtab & "<descuento>" & listaOfertas(RDto, xx) & "</descuento>" & vbcrlf	
		response.write "</oferta>" & vbcrlf	
	next
end if

if not isArrayVacio(ListaOfertasAmigo) then
	for xx = 0 to ubound(ListaOfertasAmigo, 2)		
		response.write "<oferta>" & vbcrlf	
		response.write vbtab & "<codioferta>" & ListaOfertasAmigo(RIdOferta,xx) & "</codioferta>" & vbcrlf
		response.write vbtab & "<textooferta>" & server.HTMLEncode(ListaOfertasAmigo(RNomOferta,xx)) & "</textooferta>" & vbcrlf
		response.write vbtab & "<calculaoferta>" & paClng(ListaOfertasAmigo(RCalculaOferta,xx)) & "</calculaoferta>" & vbcrlf
		response.write vbtab & "<totaloferta>" & ListaOfertasAmigo(RPelasOferta,xx) & "</totaloferta>" & vbcrlf
		response.write "</oferta>" & vbcrlf	
	next
end if

for d = 1 to noches
	response.write "<reserva>" & vbcrlf
	response.write vbtab & "<dia>" & fechaRes(d) & "</dia>" & vbcrlf
	response.write vbtab & "<codhab>" & codhab & "</codhab>" & vbcrlf
	response.write vbtab & "<nomhab>" & server.HTMLEncode(nombrehabi) & "</nomhab>" & vbcrlf
	response.write vbtab & "<fotos>" & server.HTMLEncode(lasfotos) & "</fotos>" & vbcrlf
	response.write vbtab & "<descripcion>" & eltexto & "</descripcion>" & vbcrlf
	response.write vbtab & "<preciohab>" & precioPlazas(d) & "</preciohab>" & vbcrlf
	response.write vbtab & "<dtohab>" & dtohab(d) & "</dtohab>" & vbcrlf
	response.write vbtab & "<nomsuple>" & server.HTMLEncode(nombresuple) & "</nomsuple>" & vbcrlf
	response.write vbtab & "<preciosuple>" & totalSuples(d) & "</preciosuple>" & vbcrlf
	response.write vbtab & "<dtosuple>" & dtoSuples(d) & "</dtosuple>" & vbcrlf
	response.write vbtab & "<prepagoDiaTemp>" & PrepagoDia(d) & "</prepagoDiaTemp>" & vbcrlf
	response.write "</reserva>" & vbcrlf
next
response.write "</data>"



%>