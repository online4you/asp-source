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

	'Busco tabla de ofertas del hotel de fecha estancia
	cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
	cs=cs & "Dto,Precio,ISNULL(dbo.fnGetTraduccion('Ofertas','Titulo',Id,'" & lang & "'),Titulo) AS Titulo,ISNULL(dbo.fnGetTraduccion('Ofertas','Texto',Id,'" & lang & "'),Texto) AS Texto,NochesGratis,DiasSemana,Calcula "
	cs=cs & "FROM Ofertas "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est & " AND Caduca>" & FechaMySQL(date)
	cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
	cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
	cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & FechaMySQL(FSalida-1) & ">FechaFin) OR (" & FechaMySQL(FLlegada) & "<FechaInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
	cs=cs & FechaMySQL(FLlegada) & "<FechaInicio AND " & FechaMySQL(FSalida-1) & ">FechaFin))"
	response.write cs 
	rs.open cs,base
	if not rs.eof then
		RegLOfertas=rs.getrows
		hayOferta=true
		'response.write ubound(RegLOfertas,2) & "<br>"
	end if
	rs.close

else 'hay promocion

	'Busco tabla de ofertas del hotel de fecha estancia
	cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
	cs=cs & "Dto,Precio,Titulo,Texto,NochesGratis,DiasSemana,Calcula,Traduccion,Campo "
	cs=cs & "FROM Ofertas LEFT JOIN Traducciones "
	cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND Idioma='" & lang & "' "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est & " AND Caduca>" & FechaMySQL(date)
	cs=cs & " AND CodigoPromocion='" & cpromo & "'"
	cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
	cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
	cs=cs & FechaMySQL(FSalida-1) & ">FechaFin) OR (" & FechaMySQL(FLlegada) & "<FechaInicio AND "
	cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
	cs=cs & FechaMySQL(FLlegada) & "<FechaInicio AND " & FechaMySQL(FSalida-1) & ">FechaFin))"
	hayOferta=false
	rs.open cs,base
	if not rs.eof then
		RegTemp=rs.getrows
		anterior=0
		for r=0 to ubound(RegTemp,2)
			if anterior<>RegTemp(OfId,r) then 'oferta diferente
				n_Ofertas=n_Ofertas+1
				redim preserve RegLOfertas(13,n_Ofertas)
				for c=0 to 13 'los campos
					RegLOfertas(c,n_Ofertas)=RegTemp(c,r)
				next
			end if
			if RegTemp(15,r)="Titulo" and ("" & RegTemp(14,r))<>"" then RegLOfertas(OfTitulo,n_Ofertas)=RegTemp(14,r)
			if RegTemp(15,r)="Texto" and ("" & RegTemp(14,r))<>"" then RegLOfertas(OfTexto,n_Ofertas)=RegTemp(14,r)

			anterior=RegTemp(OfId,r)
		next
		hayOferta=true
		'response.write ubound(RegLOfertas,2) & "<br>"
	end if
	rs.close

	if not hayOferta then 'el codigo no es valido, poner las ofertas normales
	
		'Busco tabla de ofertas del hotel de fecha estancia
		cs="SELECT Ofertas.Id,IdHabitacion,AplicarEn,CodigoSuple,FechaInicio,FechaFin,TotalNoches,"
		cs=cs & "Dto,Precio,Titulo,Texto,NochesGratis,DiasSemana,Calcula,Traduccion,Campo "
		cs=cs & "FROM Ofertas LEFT JOIN Traducciones "
		cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' "
		cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est & " AND Caduca>" & FechaMySQL(date)
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
			RegTemp=rs.getrows
			anterior=0
			for r=0 to ubound(RegTemp,2)
				if anterior<>RegTemp(OfId,r) then 'oferta diferente
					n_Ofertas=n_Ofertas+1
					redim preserve RegLOfertas(13,n_Ofertas)
					for c=0 to 13 'los campos
						RegLOfertas(c,n_Ofertas)=RegTemp(c,r)
					next
				end if
				if RegTemp(15,r)="Titulo" then RegLOfertas(OfTitulo,n_Ofertas)=RegTemp(14,r)
				if RegTemp(15,r)="Texto" then RegLOfertas(OfTexto,n_Ofertas)=RegTemp(14,r)
	
				anterior=RegTemp(OfId,r)
			next
			hayOferta=true
			'response.write ubound(RegLOfertas,2) & "<br>"
		end if
		rs.close
	
	
	end if 'not hayOferta


end if 'promocion
'
atodo=0
ahabi=1
asuple=2

'carga registro oferta
if hayOferta then
	redim listaOfertas(3,ubound(RegLOfertas,2))
	for o=0 to ubound(RegLOfertas,2)
		listaOfertas(RIdOferta,o)=RegLOfertas(OfId,o)
		listaOfertas(RNomOferta,o)=RegLOfertas(OfTitulo,o)
		listaOfertas(RCalculaOferta,o)=RegLOfertas(OfCalcula,o)
		listaOfertas(RPelasOferta,o)=0
	next
end if 'hayOferta

%>