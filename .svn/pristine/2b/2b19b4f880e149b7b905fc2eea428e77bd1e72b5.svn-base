<%
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
OfCalcula=13
hayOferta=false
n_ofertas=-1


if cpromo="" then 'no hay promocion 

	data=FechaMySQL(date)
	sortidamenys1=FechaMySQL(FSalida-1)
	arribada=FechaMySQL(FLlegada)


	'Busco tabla de ofertas del hotel de fecha estancia
	cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
	cs=cs & "Dto,Precio, "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion) Titulo, "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),Ofertas.Texto,Traducciones.Traduccion) Texto, "
	cs=cs & "NochesGratis,DiasSemana,Calcula "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas'  and Idioma='es' "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est
	cs=cs & " AND (TotalNoches<>0 OR Dto<>0 OR Precio<>0) "
	cs=cs & " AND (" & noches & " >= TotalNoches) "
	cs=cs & " AND (" & arribada & "> DATE_ADD(CURDATE(), INTERVAL Ofertas.DiasAdelanto DAY)) "
	cs=cs & " AND ((" & idregi & " = CodigoSuple) OR (CodigoSuple=0)) "
	cs=cs & " AND (" & data & " BETWEEN Valida AND Caduca) "
	cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
	cs=cs & " AND (((" & arribada & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & "(" & sortidamenys1 & " BETWEEN FechaInicio AND FechaFin)) OR "
	cs=cs & "((" & arribada & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & sortidamenys1 & " > FechaFin) OR (" & arribada & " < FechaInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) "
	cs=cs & "OR (" & arribada & " < FechaInicio AND " & sortidamenys1 & " > FechaFin))"

	
	
    
    'response.Write(cs & "<br>")
    'response.Write(idregi & "<br>")
    'response.Write(idRegimen & "<br>")
    'response.Write(data & "<br>")
    'response.Write(arribada & "<br>")
    'response.Write(sortidamenys1 & "<br>")
	
	rs.open cs,base
	if not rs.eof then
		RegLOfertas=rs.getrows
		hayOferta = true
	end if
	rs.close

else 'hay promocion
	'Busco tabla de ofertas del hotel de fecha estancia
	cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
	cs=cs & "Dto,Precio, "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion) Titulo, "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),Ofertas.Texto,Traducciones.Traduccion) Texto, "
	cs=cs & "NochesGratis,DiasSemana,Calcula "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas'  and Idioma='es' "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est
	cs=cs & " AND (" & FechaMySQL(date) & " BETWEEN Valida AND Caduca)"
	cs=cs & " AND CodigoPromocion='" & cpromo & "'"
	cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
	cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & FechaMySQL(FSalida-1) & " > FechaFin) OR (" & FechaMySQL(FLlegada) & " < FechaInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
	cs=cs & FechaMySQL(FLlegada) & " < FechaInicio AND " & FechaMySQL(FSalida-1) & " > FechaFin))"

	hayOferta=false
	'response.Write(cs & "<br>")
	rs.open cs,base
	if not rs.eof then
		RegLOfertas=rs.getrows
		hayOferta=true
	end if
	rs.close

	if not hayOferta then 'el codigo no es valido, poner las ofertas normales
	
		'Busco tabla de ofertas del hotel de fecha estancia
		cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
		cs=cs & "Dto,Precio,ISNULL(dbo.fnGetTraduccion('Ofertas','Titulo',Id,'" & lang & "'),Titulo) AS Titulo,ISNULL(dbo.fnGetTraduccion('Ofertas','Texto',Id,'" & lang & "'),Texto) AS Texto,NochesGratis,DiasSemana,Calcula "
		cs=cs & "FROM Ofertas "
		cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est
		cs=cs & " AND (" & FechaMySQL(date) & " BETWEEN Valida AND Caduca)"
		cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
		cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
		cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
		cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
		cs=cs & FechaMySQL(FSalida-1) & ">FechaFin) OR (" & FechaMySQL(FLlegada) & "<FechaInicio AND "
		cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
		cs=cs & FechaMySQL(FLlegada) & "<FechaInicio AND " & FechaMySQL(FSalida-1) & ">FechaFin))"
		
		hayOferta=false
		
		rs.open cs,base
		if not rs.eof then
			RegLOfertas=rs.getrows
			hayOferta=true
		end if
		
		rs.close
	
	
	end if 'not hayOferta


end if 'promocion



atodo=0
ahabi=1
asuple=2

'carga registro oferta
if hayOferta then
	redim listaOfertas(4, ubound(RegLOfertas,2))
	for o=0 to ubound(RegLOfertas,2)
		listaOfertas(RIdOferta, o)=RegLOfertas(OfId,o)
		listaOfertas(RNomOferta, o)=RegLOfertas(OfTitulo,o)
		listaOfertas(RCalculaOferta, o)=RegLOfertas(OfCalcula,o)
		listaOfertas(RPelasOferta, o)=0
		listaOfertas(RDto, o) = RegLOfertas(OfDto, o)
	next
end if 'hayOferta

%>