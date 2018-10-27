<%
'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,Nombre,Orde FROM Colectivos LEFT JOIN ColectivosNomres "
cs=cs & "ON Colectivos.COdigoColec=ColectivosNomres.ColectivoIdi "
cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' AND Nombre<>''"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
end if
rs.close

'Suplementos
cs="SELECT Id,Nombre_es "
cs=cs & "FROM Regimen "
cs=cs & "ORDER BY Id"
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close

'Precio Suplementos por temporadas
cs="SELECT RegimenHotel.Id,IdRegimen,Precio,"
cs=cs & "CodigoTempo,CodigoHab,Defecto,Nombre_es "
cs=cs & "FROM Regimen INNER JOIN RegimenHotel ON "
cs=cs & "Regimen.Id=RegimenHotel.IdRegimen "
cs=cs & "WHERE CodigoEsta=" & est & " AND (CodigoHab=0 OR CodigoHab=" & laid & ") AND Anyo=" & anyo
cs=cs & " ORDER BY IdRegimen,CodigoTempo"
rs.open cs,base
haysuplesT=false
if not rs.eof then
	RegSuplesT=rs.getrows
	STId=0
	STCodi=1
	STPelas=2
	STempo=3
	STHabi=4
	STDefecto=5
	STNombre=6
	haysuplesT=true
end if
rs.close

'Buscar los descuentos suplementos
cs="SELECT RegimenDtos.Id,IdRegimen,CodigoColec,Descuento,RegimenDtos.Precio,IdRegimenHotel,CodigoTempo "
cs=cs & "FROM RegimenHotel INNER JOIN RegimenDtos "
cs=cs & "ON RegimenHotel.Id=RegimenDtos.IdRegimenHotel "
cs=cs & "WHERE CodigoEsta=" & est & " AND (CodigoHab=0 OR CodigoHab=" & laid & ") AND Anyo=" & anyo
cs=cs & " ORDER BY RegimenDtos.Id"
rs.open cs,base
haydtossuples=false
if not rs.eof then
	RegDtosSuples=rs.getrows
	SDtoId=0
	SDtoCodi=1
	SDtoColec=2
	SDtoDto=3
	SDtoPrecio=4
	SDtoRegimenH=5
	SDtoTempo=6
	haydtossuples=true
end if
rs.close


'Dtos colectivos por habitacion y temporada, y establecimiento
cs="SELECT DescuentosColectivos.CodigoColec,Temporada,TipoHab,Prebase,Precio "
cs=cs & "FROM (Colectivos INNER JOIN DescuentosColectivos "
cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec) "
cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
rs.open cs,base
haydtos=false
if not rs.eof then
	RegDtos=rs.getrows
	DCodi=0
	DTempo=1
	DHabi=2
	Ddto=3
	DPrecio=4
	haydtos=true
end if
rs.close
%>

