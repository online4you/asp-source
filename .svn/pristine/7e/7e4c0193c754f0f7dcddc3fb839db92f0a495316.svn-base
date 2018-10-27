<%
'Busco tabla de ofertas del hotel de fecha estancia
cs="SELECT Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
cs=cs & "Dto,Precio,Titulo_" & lang & ",Texto1_" & lang & ",NochesGratis,DiasSemana FROM Ofertas "
cs=cs & "WHERE CodigoEsta=" & est & " AND FechaReserva=0 AND "
cs=cs & "((" & FechaMySQL(FIni) & " BETWEEN FechaInicio AND FechaFin) OR "
cs=cs & "(" & FechaMySQL(FFin-1) & " BETWEEN FechaInicio AND FechaFin) OR "
cs=cs & "(FechaInicio<" & FechaMySQL(fini) & " AND FechaFin>" & FechaMySQL(ffin-1) & ") OR "
cs=cs & "(" & FechaMySQL(FIni) & "<FechaInicio AND " & FechaMySQL(FFin) & ">FechaFin))"
response.write cs & "<br>"
hayOfertaFE=false
rs.open cs,base
if not rs.eof then
	RegLOfertas=rs.getrows
	OfId=0
	OfHabi=1
	OfAplicar=2
	OfCodSuple=3
	OfFInicio=4
	OfFFin=5
	OfNoches=6
	OfDto=7
	OfPrecio=8
	OfTitulo=9
	OfTexto=10
	OfNochesG=11
	OfDias=12
	hayOfertaFE=true
	response.write ubound(RegLOfertas,2) & "<br>"
end if
rs.close

'Buscar si tiene oferta para fecha reserva
'Busco tabla de ofertas del hotel de fecha estancia
cs="SELECT Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
cs=cs & "Dto,Precio,Titulo_" & lang & ",Texto1_" & lang & ",NochesGratis,DiasSemana FROM Ofertas "
cs=cs & "WHERE CodigoEsta=" & est & " AND FechaReserva<>0 AND "
cs=cs & "(" & FechaMySQL(date) & " BETWEEN FechaInicio AND FechaFin)"
rs.open cs,base
HayOfertaFR=false
if not rs.eof then
	RegLOfertas=rs.getrows
	OfId=0
	OfHabi=1
	OfAplicar=2
	OfCodSuple=3
	OfFInicio=4
	OfFFin=5
	OfNoches=6
	OfDto=7
	OfPrecio=8
	OfTitulo=9
	OfTexto=10
	OfNochesG=11
	OfDias=12
	hayOfertaFR=true
	hayOfertaFE=false 'Para que no busque mas
end if
rs.close
%>