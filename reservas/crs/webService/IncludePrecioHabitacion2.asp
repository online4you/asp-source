<%
redim PrecioHab(noches)
redim PrecioPerso(noches)
redim FechaRes(noches)
redim PrecioSuples(noches)
redim PrecioPlazas(noches)
redim DtoHab(noches)
redim DtoSuples(noches)
redim TotalSuples(noches)
redim OfertaHab(noches)
redim OfertaRegimen(noches)
redim totalOferta(noches)
redim codiOferta(noches)
redim textoOferta(noches)

FLlegada=fini
FSalida=ffin

noches=FSalida-FLlegada
codhab=codihabi
codsuple=elRegimen
idregi=0 'por defecto

%><!--#include file="tieneCupoNew2.asp"--><%

if tieneCupo then 'sigo con los otros datos 

	'Buscar los colectivos de este hotel
	cs="SELECT CodigoColec,Orde FROM Colectivos "
	cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY orde"
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
	
	'Buscado cod. temporada
	cs="SELECT CodigoTemp,FInicio,FFinal FROM Temporadas "
	cs=cs & "WHERE CodigoEsta=" & est
	cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FInicio AND FFinal) AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FInicio AND FFinal)) OR "
	cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FInicio AND FFinal) AND "
	cs=cs & FechaMySQL(FSalida-1) & ">FFinal) OR (" & FechaMySQL(FLlegada) & "<FInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FInicio AND FFinal)) OR ("
	cs=cs & FechaMySQL(FLlegada) & "<FInicio AND " & FechaMySQL(FSalida-1) & ">FFinal))"
	rs.open cs,base
	'response.write cs & "<br/>"
	haytempos=false
	if not rs.eof then 'Tenemos cod. temporada
		RegTempos=rs.getrows
		TCodi=0
		TFIni=1
		TFFin=2
		haytempos=true
		'for t=0 to ubound(RegTempos,2)
		'	response.write RegTempos(TCodi,t) & " - " & RegTempos(TFIni,t) & " - " & RegTempos(TFFin,t) & "<br>"
		'next
	end if
	rs.close
	
	'tabla precios cupo
	cs="SELECT Dia,Precio,DiasMinimos,Release,Estado FROM Cupos WHERE CodigoHab=" & codhab & " AND ("
	cs=cs & "Dia BETWEEN " & FechaMySQL(FLlegada) & " AND " & FechaMySQL(FSalida-1) & ") ORDER BY Dia"
	'response.write cs
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
	sumabruto=0
	idRegimen=0 'por defecto
	dia=0 'dias de reserva
	precioValido=true
	if hayprecios then
		
		%><!--#include file="tieneOfertaNew.asp"--><%
		
		for prec=0 to ubound(RegPrecios,2)
			dia=dia+1 'dias de reserva
			d=RegPrecios(PDia,prec)
			FechaRes(dia)=d 'Dia de la reserva
			anyo=year(d)
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
		if codigoVIP<>"" then
			%><!--#include file="CalculaOfertaVIP.asp"--><%
		end if

	end if 'hayprecios
	
	'Importe reserva
	SumaHabi=0
	SumaSuple=0
	SumaDto3=0
	SumaDtoSuple=0
	if precioValido then
		for d=1 to noches
			sumaHabi=sumaHabi+PrecioPlazas(d)
			sumaDto3=sumaDto3+DtoHab(d)
			sumaSuple=sumaSuple+TotalSuples(d)
			sumaDtoSuple=sumaDtoSuple+dtoSuples(d)
		next
		sumaBruto=SumaHabi+SumaSuple-(SumaDto3+SumaDtoSuple) 'Total Bruto reserva
	end if 'precioValido

else 'no tiene cupo
	estadoHab="NV"
	sumabruto=0
end if 'tieneCupo

'Ofertas
sumaOferta=0
for d=1 to noches
	if codiOferta(d)<>"" then 'hay algo
		sumaOferta=sumaOferta+totalOferta(d)
	end if
next

%>