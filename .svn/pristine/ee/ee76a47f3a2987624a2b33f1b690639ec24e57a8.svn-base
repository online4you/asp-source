<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")

tipoh="0"
laid=clng("0" & request.QueryString("id"))

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

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
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
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

'Buscar OBS
cs="SELECT Obs FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	lasObs="" & rs("obs")
end if
rs.close

%><!--#include file="datosHabitacion.asp"--><%

set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="css.css" rel="stylesheet" type="text/css">
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript" src="js/funciones.js"></script>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	palIframe(document.getElementById("verHabitacion"),930,580,0,0,"verFichaHabitacion.asp?id=0&est=<%=est%>");
}
function verFicha(id){
	palIframe(document.getElementById("verHabitacion"),930,580,0,0,"verFichaHabitacion.asp?id="+id+"&est=<%=est%>");
}
var ultimoFrame;
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0">
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="800">
	<tr><td align='left'>
	* Este listado de Habitaciones depende del establecimiento seleccionado en la parte de arriba.
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nueva Habitación&nbsp;'><input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='&nbsp;Parón general ventas&nbsp;' onclick="javascript:document.getElementById('panelparon').style.visibility='visible';">	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">HABITACIONES</div></td></tr>
  <tr><td class="tdTabla">
	<!-- tabla -->

<table border="0" cellpadding="0" cellspacing="0" width='800' align='center'>
	<tr class='cabetabla'>
	 <th>&nbsp;</th>
	<th align='left' class="colu_par">Tipo Habitación</th>
	<th align='left' class="colu_par">Temporada</th>
	<th colspan='2' align='center'>Precio</th>
	<th align='center'>Dtos Colec.</th>
	<th align='left' class="colu_par">Suplementos</th>
	<th align='left' class="colu_par">Dtos Suplem.</th>
	</tr>
	<%if hayLista then
	mihabi=0
	for rr=0 to ubound(RegLista,2)
		laprime=true 'poner solo un nombre hab.%>
		<tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
			<input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(HCodi,rr)%>">
		  </td>
		  <td align="left" class='<%=laColu(0)%>' >
			<a href='javascript:verFicha(<%=RegLista(HCodi,rr)%>);'><%=RegLista(HNombre,rr)%></a>
	  	</td>
		<%if hayListaP then
		for r=0 to ubound(RegHabis,2)
			if RegHabis(RCodi,r)=RegLista(HCodi,rr) then 'esta toca
				if not laprime then 'la habitacion%>
					<tr><td>&nbsp;</td><td>&nbsp;</td>
				<%end if
				laprime=false%>
				  <td align="left" class='<%=laColu(0)%>' >
					<%=VerFecha(RegHabis(RFIni,r))%> - <%=VerFecha(RegHabis(RFFin,r))%>
				  </td>
				  <td align="right" class='<%=laColu(0)%>' width="50">
					<%=RegHabis(RPelas,r)%>&nbsp;&euro;
				  </td>
				  <td align="left" class='<%=laColu(0)%>' width='50'>
					<%if RegHabis(RPHab,r) then 'Precio por hab.%>
							&nbsp;x&nbsp;Hab.
							<%else%>
							&nbsp;x&nbsp;Pers.
							<%end if%>
					</td>
				  <td align="right" class='<%=laColu(0)%>' >
				  <%if haydtos then 'poner los dtos colectivos
						hayuno=false
						for d=0 to ubound(RegDtos,2)
							'Busco los dtos de la temporada y habitacion
							if (RegDtos(DTempo,d)=RegHabis(RTempo,r) or RegDtos(DTempo,d)=0) and RegDtos(DHabi,d)=RegHabis(RCodi,r) then
								'response.write RegDtos(DCodi,d) & "<br>"
								'Busco el nombre del colectivo
								for c=0 to ubound(RegColec,2)
									if RegColec(CCodi,c)=RegDtos(DCodi,d) then 'Poner dto
										hayuno=true%>
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
						if not hayuno then response.write "&nbsp;"
				  end if%>
				  </td>
				  <td align="left" class='<%=laColu(0)%>' colspan='2'>
				  <%if haysuplest then 'poner la tabla de suplementos%>
						<table>
						<%hayuno=false
						for st=0 to ubound(RegSuplesT,2)
							'Busco los suples de la habitacion y la temporada
							if (RegSuplesT(STHabi,st)=RegHabis(RCodi,r) or RegSuplesT(STHabi,st)=0) AND (RegSuplesT(STempo,st)=RegHabis(RTempo,r) or RegSuplesT(STempo,st)=0) then%>
								<tr><td align='left'>
								<%'buscar nombre del suplemento
								for s=0 to ubound(RegSuples,2)
									if RegSuples(SCodi,s)=RegSuplesT(STCodi,st) then
										response.write RegSuples(SNombre,s) & ": "
									end if
								next %>
								<%=RegSuplesT(STPelas,st)%>&nbsp;&euro;
								</td>
								<td align='left'>
									<%'Busco los dtos
										if haydtosSuples then
										for sd=0 to ubound(RegDtosSuples,2)						
											if RegDtosSuples(SDtoRegimenH,sd)=RegSuplesT(STId,st) then
												'Busco el nombre del colectivo
												for c=0 to ubound(RegColec,2)
													if RegColec(CCodi,c)=RegDtosSuples(SDtoColec,sd) then 'Poner dto%>
														<%=RegColec(CNombre,c)%>: 
														<%if RegDtosSuples(SDtoDto,sd)<>0 then
															response.write RegDtosSuples(SDtoDto,sd) & " %<br>"
														else
															response.write RegDtosSuples(SDtoPrecio,sd) & " €<br>"
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
			end if 'listaP
		next 'rr hab
	end if%>
	
	<tr><td height='25' colspan='7'></tr>
	</table>

	</td></tr>
</table>


</td></tr>
</table>
<iframe id='verHabitacion' name='verHabitacion' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verDtosHabitacion' name='verDtosHabitacion' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
