<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.QueryString("est"))

'Datos hotel
cs="SELECT Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	NHotel=Rs("nombre")
	estado=rs("estado")
end if
rs.close

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo
cs=cs & " ORDER BY FInicio"
rs.open cs,base
haytempos=flase
if not rs.eof then
	RegTempos=rs.getrows
	rs.close
	TCodi=0
	TFIni=1
	TFFin=2
	haytempos=true
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<html><body><h2>Tiene que crear primero las temporadas del Establecimiento</h2>" & vbcrlf
	response.write "<input type='button' value='Volver' onclick='javascript:window.location=" & chr(34) & "temporadas.asp?est=" & est & chr(34) & ";'>" & vbcrlf
	response.write "</body></html>"
	response.End()
end if

'Lista habitaciones
cs= "SELECT Id,Nombre_es "
cs=cs & "FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
cs=cs & " ORDER BY Orden,Id"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.getrows
	HCodi=0
	HNombre=1
	haylista=true
end if
rs.close

cs= "SELECT Id,Temporadas.FInicio,Temporadas.FFinal,Nombre_es,Preprebase,Preperhab,CodigoTemp "
cs=cs & "FROM (" & precrs & "TipoHabitaNombres TipoHabitaNombres INNER JOIN " & precrs & "TipoHabitaPrecios TipoHabitaPrecios "
cs=cs & "ON TipoHabitaNombres.Id=TipoHabitaPrecios.IdHabita) INNER JOIN Temporadas "
cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo
cs=cs & " ORDER BY Id,Temporadas.FInicio"
rs.Open cs, base
haylistaP=false
if not rs.eof then
	RegHabis=rs.GetRows
	RCodi=0
	RFIni=1
	RFFin=2
	RNombre=3
	RPelas=4
	RPHab=5
	RTempo=6
	haylistaP=true
end if
rs.close

'Precio Suplementos por temporadas
cs="SELECT RegimenHotel.Id,IdRegimen,Precio,"
cs=cs & "CodigoTempo,CodigoHab,Defecto,Nombre_es "
cs=cs & "FROM " & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel ON "
cs=cs & "Regimen.Id=RegimenHotel.IdRegimen "
cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
cs=cs & " ORDER BY IdRegimen,CodigoTempo"
rs.open cs,base
haysuplesT_L=false
if not rs.eof then
	RegSuplesT_L=rs.getrows
	STId_L=0
	STCodi_L=1
	STPelas_L=2
	STempo_L=3
	STHabi_L=4
	STDefecto_L=5
	STNombre_L=6
	haysuplesT_L=true
end if
rs.close

'Buscar los descuentos suplementos
cs="SELECT RegimenDtos.Id,IdRegimen,CodigoColec,Descuento,RegimenDtos.Precio,IdRegimenHotel,CodigoTempo "
cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "RegimenDtos RegimenDtos "
cs=cs & "ON RegimenHotel.Id=RegimenDtos.IdRegimenHotel "
cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
cs=cs & " ORDER BY RegimenDtos.Id"
rs.open cs,base
haydtossuples_L=false
if not rs.eof then
	RegDtosSuples_L=rs.getrows
	SDtoId_L=0
	SDtoCodi_L=1
	SDtoColec_L=2
	SDtoDto_L=3
	SDtoPrecio_L=4
	SDtoRegimenH_L=5
	SDtoTempo_L=6
	haydtossuples_L=true
end if
rs.close

'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,Nombre,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "ColectivosNomres ColectivosNomres "
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

'Dtos colectivos por habitacion y temporada, y establecimiento
cs="SELECT DescuentosColectivos.CodigoColec,Temporada,TipoHab,Prebase,Precio "
cs=cs & "FROM (" & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
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

set rs=nothing
base.close
set base=nothing
%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="cssimpre.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div class='titulo' align='left' style="width:740px; height:30px">
Tarifa de <%=NHotel%>&nbsp;
<%select case paClng(estado)
	case noventa
		response.write "(No venta)"
	case onrequest
		response.write "(On Request)"
	case online
		response.write "(On Line)"
end select%>
<br/>
<span class="subtitu"><%=verFecha(date)%></span>
</div>
<div align="left" style="width:770px;">
<!-- tabla -->
<table border="0" cellpadding="0" cellspacing="0" width='100%' align='left' class="borde">
	<tr>
	<th align='left' class="cabecera">Tipo Habitación</th>
	<th align='center' class="cabecera">Temporada</th>
	<th align='center' class="cabecera">Precio</th>
	<th align='center' class="cabecera">Dtos Colec.</th>
	<th align='left' class="cabecera" width="130">Suplementos</th>
	<th align='left' class="cabecera">Dtos Suplem.</th>
	</tr>
	<%if hayLista then
	mihabi=0
	for rr=0 to ubound(RegLista,2)
		laprime=true 'poner solo un nombre hab.%>
		<tr>
		  <td align="left" class='linea'>
			<%=RegLista(HNombre,rr)%>
	  	</td>
		<%if hayListaP then
		for r=0 to ubound(RegHabis,2)
			if RegHabis(RCodi,r)=RegLista(HCodi,rr) then 'esta toca
				if not laprime then 'la habitacion%>
					<tr><td>&nbsp;</td>
				<%end if
				laprime=false%>
				  <td align="center" class='linea'>
					<%=VerFecha(RegHabis(RFIni,r))%> - <%=VerFecha(RegHabis(RFFin,r))%>
				  </td>
				  <td align="right" class='linea'>
					<%=RegHabis(RPelas,r)%>&nbsp;&euro;
					<%if RegHabis(RPHab,r) then 'Precio por hab.%>
						&nbsp;x&nbsp;Hab.&nbsp;
						<%else%>
						&nbsp;x&nbsp;Pers.&nbsp;
					<%end if%>
				</td>
				  <td align="right" class='linea'>&nbsp;
				  <%if haydtos then 'poner los dtos colectivos
						for d=0 to ubound(RegDtos,2)
							'Busco los dtos de la temporada y habitacion
							if (RegDtos(DTempo,d)=RegHabis(RTempo,r) or RegDtos(DTempo,d)=0) and RegDtos(DHabi,d)=RegHabis(RCodi,r) then
								'response.write RegDtos(DCodi,d) & "<br>"
								'Busco el nombre del colectivo
								for c=0 to ubound(RegColec,2)
									if RegColec(CCodi,c)=RegDtos(DCodi,d) then 'Poner dto%>
										<%=RegColec(CNombre,c)%>: 
										<%if RegDtos(Ddto,d)<>0 then
											response.write RegDtos(DDto,d) & " %"
										else 'precio
											response.write RegDtos(DPrecio,d) & " €"
										end if%>
										<br>
									<%end if
								next
							end if
						next
				  end if%>
				  </td>
				  <td align="left" class='linea' colspan='2'>
				  <%if haysuplest_L then 'poner la tabla de suplementos%>
						<table class="sublinea">
						<%hayuno=false
						for st=0 to ubound(RegSuplesT_L,2)
							'Busco los suples de la habitacion y la temporada
							if (RegSuplesT_L(STHabi_L,st)=RegHabis(RCodi,r) or RegSuplesT_L(STHabi_L,st)=0) AND (RegSuplesT_L(STempo_L,st)=RegHabis(RTempo,r) or RegSuplesT_L(STempo_L,st)=0) then%>
								<tr><td align='left' width="130">
								<%'buscar nombre del suplemento
								for s=0 to ubound(RegSuples,2)
									if RegSuples(SCodi,s)=RegSuplesT_L(STCodi_L,st) then
										response.write RegSuples(SNombre,s) & ": "
									end if
								next %>
								<%=RegSuplesT_L(STPelas_L,st)%>&nbsp;&euro;
								</td>
								<td align='left'>
									<%'Busco los dtos
										if haydtosSuples_L then
										for sd=0 to ubound(RegDtosSuples_L,2)						
											if RegDtosSuples_L(SDtoRegimenH_L,sd)=RegSuplesT_L(STId_L,st) then
												'Busco el nombre del colectivo
												for c=0 to ubound(RegColec,2)
													if RegColec(CCodi,c)=RegDtosSuples_L(SDtoColec_L,sd) then 'Poner dto%>
														<%=RegColec(CNombre,c)%>: 
														<%if RegDtosSuples_L(SDtoDto_L,sd)<>0 then
															response.write RegDtosSuples_L(SDtoDto_L,sd) & " %<br>"
														else
															response.write RegDtosSuples_L(SDtoPrecio_L,sd) & " €<br>"
														end if%>
													<%end if
												next
											end if
										next
										end if%>
									</td></tr>
								<%end if
						next 'st suplementostempo%>
						</table>
				  <%end if%>
				  </td>
				  </tr>
				<%end if 'esa hab
			next 'r los precios
			end if 'listaP%>
			<tr><td colspan="6" class="borde">&nbsp;</td></tr>
		<%next 'rr hab
	end if%>
	
	</table>

</div>
</body>
</html>
