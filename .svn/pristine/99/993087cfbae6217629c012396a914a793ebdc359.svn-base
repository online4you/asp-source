<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY FInicio"
rs.open cs,base
if not rs.eof then
	RegTempos=rs.getrows
	rs.close
	TCodi=0
	TFIni=1
	TFFin=2
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<html><body><h2>Tiene que crear primero las temporadas del Establecimiento</h2>" & vbcrlf
	response.write "<input type='button' value='Volver' onclick='javascript:window.history.back();'>" & vbcrlf
	response.write "</body></html>"
end if



laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT CodigoHab,ParaCapMax,ParaCapMin,ParaCapNormal,ParaAdultMax,ParaNiMax,"
	cs=cs & "cupocant,cupodesde,cupohasta,nombre,idioma,orden "
	cs=cs & "FROM " & precrs & "TipoHabita TipoHabita INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "ON TipoHabita.CodigoHab=TipoHabitaNombres.TipoHabiIdi "
	cs=cs & "WHERE CodigoHab=" & laid
	rs.open cs,base
	do while not rs.eof
		capmax=rs("ParaCapMax")
		capmin=rs("ParaCapMin")
		capnormal=rs("ParaCapNormal")
		adultmax=rs("ParaAdultMax")
		ninmax=rs("ParaNiMax")
		cupo=rs("cupocant")
		cdesde=rs("cupodesde")
		chasta=rs("cupohasta")
		orden=rs("orden")
		for i=1 to ubound(Idioma)
			if idioma(i)=rs("idioma") then 'Este es el idioma
				LosValores(i)=rs("nombre")
			end if
		next
		rs.movenext
	loop
	rs.close
	
	'Buscar dtos po fecha
	cs="SELECT CodigoFechas,Desde,Hasta,Value FROM " & precrs & "DescuentosFechas DescuentosFechas "
	cs=cs & "WHERE TipoHab=" & laid
	rs.open cs,base
	haydtosfechas=false
	if not rs.eof then
		RegDtosFechas=rs.getrows
		DFCodi=0
		DFDesde=1
		DFHasta=2
		DFValor=3
		haydtosfechas=true
	end if
	rs.close
end if

iditxt=request.QueryString("lng")
if iditxt="" then iditxt="es"

'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
cs=cs & "ON Colectivos.COdigoColec=ColectivosNomres.ColectivoIdi "
cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & iditxt & "'"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
end if
rs.close

'Suplementos por habitacion y establecimiento
cs="SELECT Suplementos.CodigoSuple,TipoHab,Precio,Nombre,CodigoTempo "
cs=cs & "FROM (" & precrs & "Suplementos Suplementos INNER JOIN " & precrs & "SuplementoNombres SuplementoNombres ON "
cs=cs & "Suplementos.CodigoSuple=SuplementoNombres.SuplementosIdi) "
cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & iditxt & "' ORDER BY TipoHab"
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SHabi=1
	SPelas=2
	SNombre=3
	STempo=4
	haysuples=true
end if
rs.close


'Dtos de Suplementos por habitacion y establecimiento
cs="SELECT Suplementos.CodigoSuple,CodigoColec,Descuento,TipoHab "
cs=cs & "FROM (" & precrs & "Suplementos Suplementos INNER JOIN " & precrs & "DescuentosSuple DescuentosSuple "
cs=cs & "ON Suplementos.CodigoSuple=DescuentosSuple.CodigoSuple) "
cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY Suplementos.CodigoSuple"
rs.open cs,base
haydtossuples=false
if not rs.eof then
	RegDtosSuples=rs.getrows
	SDtoCodi=0
	SDtoColec=1
	SDtoDto=2
	SDtoHabi=3
	haydtossuples=true
end if
rs.close

'Precios por habitacion temporada y establecimiento
cs= "SELECT CodigoHab,Preprebase,Preperhab,Temporada "
cs=cs & "FROM (" & precrs & "TipoHabita TipoHabita INNER JOIN " & precrs & "TipoHabitaPrecios TipoHabitaPrecios "
cs=cs & "ON TipoHabita.CodigoHab=TipoHabitaPrecios.TipoHabita) "
cs=cs & "WHERE TipoHabita.CodigoEsta=" & est & " ORDER BY CodigoHab"
rs.open cs,base
hayprecios=false
if not rs.eof then
	RegPrecios=rs.getrows
	PCodi=0
	'PFIni=1
'	PFFin=2
	PPrecio=1
	PPorH=2
	PTempo=3
	hayprecios=true
end if
rs.close

'Dtos colectivos por habitacion y temporada, y establecimiento
cs="SELECT Colectivos.CodigoColec,Temporada,TipoHab,Prebase "
cs=cs & "FROM (" & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec) "
cs=cs & "WHERE CodigoEsta=" & est
rs.open cs,base
haydtos=false
if not rs.eof then
	RegDtos=rs.getrows
	DCodi=0
	DTempo=1
	DHabi=2
	Ddto=3
	haydtos=true
end if
rs.close


'Lista de registros
cs= "SELECT CodigoHab,Temporadas.FInicio,Temporadas.FFinal,Nombre,Preprebase,Preperhab,CodigoTemp "
cs=cs & "FROM (" & precrs & "TipoHabita TipoHabita INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
cs=cs & "ON TipoHabita.CodigoHab=TipoHabitaNombres.TipoHabiIdi) INNER JOIN ("
cs=cs & "TipoHabitaPrecios INNER JOIN Temporadas ON "
cs=cs & "TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp) ON "
cs=cs & "TipoHabita.CodigoHab=TipoHabitaPrecios.TipoHabita "
cs=cs & "WHERE TipoHabita.CodigoEsta=" & est & " AND Idioma='" & iditxt & "' "
cs=cs & "ORDER BY CodigoHab,Temporadas.FInicio"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RFIni=1
	RFFin=2
	RNombre=3
	RPelas=4
	RPHab=5
	RTempo=6
	haylista=true
end if
rs.close
set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="JScript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}

function Mandar(){
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	document.f1.submit();
}

function Modificar(){
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu";

	document.f1.submit();
}
function enBlanco(){
	document.f1.fechainicio.value="";
	document.f1.fechafinal.value="";
	<%for q=1 to ubound(QueNombre)
		response.write "document.f1." & QueNombre(q) & ".value='';" & vbcrlf
	next%>
	document.all.boton.value=" Añadir ";
	document.f1.id.value="";
	document.all.panel.style.visibility='visible';
	document.f1.fechainicio.focus();
}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr><td align='left'>
	* Este listado de Habitaciones depende del establecimiento seleccionado en la parte de arriba.
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nueva Temporada&nbsp;'><input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>
	</td></tr>
	</table>
<table border="0" cellpadding="0" cellspacing="0" width='650' align='center'>
	<tr class='cabetabla'>
	 <th>Borrar</th>
	<th align='left' class="colu_par">Tipo Habitación</th>
	<th align='left' class="colu_par">Temporada</th>
	<th colspan='2' align='center'>Precio</th>
	<th align='center'>Dtos Colec.</th>
	<th align='left' class="colu_par">Suplementos</th>
	<th align='left' class="colu_par">Dtos Suplem.</th>
	</tr>
	<%if hayLista then
	mihabi=0
	for r=0 to ubound(RegLista,2)
		if mihabi<>RegLista(RCodi,r) then 'Otro tipo de habitacion%>
			<tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
				<input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
			  </td>
			  <td align="left" class='<%=laColu(0)%>' >
				<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a>
			  </td>
		<%else 'la misma habiatciom%>	
			<tr><td>&nbsp;</td><td>&nbsp;</td>
		<%end if%>
		  <td align="left" class='<%=laColu(0)%>' >
			<%=VerFecha(RegLista(RFIni,r))%> - <%=VerFecha(RegLista(RFFin,r))%>
		  </td>
		  <td align="right" class='<%=laColu(0)%>' width="50">
			<%=RegLista(RPelas,r)%>&nbsp;&euro;
		  </td>
		  <td align="left" class='<%=laColu(0)%>' width='50'>
			<%if RegLista(RPHab,r) then 'Precio por hab.%>
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
					if RegDtos(DTempo,d)=RegLista(RTempo,r) and RegDtos(DHabi,d)=RegLista(RCodi,r) then
						'Busco el nombre del colectivo
						for c=0 to ubound(RegColec,2)
							if RegColec(CCodi,c)=RegDtos(DCodi,d) then 'Poner dto
								hayuno=true%>
								<%=RegColec(CNombre,c)%>: <%=RegDtos(Ddto,d)%> %<br>
							<%end if
						next
					end if
				next
				if not hayuno then response.write "&nbsp;"
		  end if%>
		  </td>
		  <td align="left" class='<%=laColu(0)%>' colspan='2'>
		  <%if haysuples then 'poner la tabla de suplementos%>
		  		<table>
				<%hayuno=false
				for s=0 to ubound(RegSuples,2)
					'Busco los dtos de la habitacion
					if RegSuples(SHabi,s)=RegLista(RCodi,r) then%>
						<tr><td align='left'>
						<%=RegSuples(SNombre,s)%>: <%=RegSuples(SPelas,s)%>&nbsp;&euro;
						</td>
						<td align='left'>
						<%'Busco los dtos
							for sd=0 to ubound(RegDtosSuples,2)						
								if RegDtosSuples(SDtoCodi,sd)=RegSuples(SCodi,s) then
									'Busco el nombre del colectivo
									for c=0 to ubound(RegColec,2)
										if RegColec(CCodi,c)=RegDtosSuples(SDtoColec,sd) then 'Poner dto%>
											<%=RegColec(CNombre,c)%>: <%=RegDtosSuples(SDtoDto,sd)%> %<br>
										<%end if
									next
								end if
							next%>
						</td></tr>
					<%end if
				next%>
				</table>
		  <%end if%>
		  </td>
		  </tr>
		<%mihabi=RegLista(RCodi,r)
		'Separar en caso de que cambe de habitacoin
		if r<ubound(RegLista,2) then
			'Comprobar si cambia
			if mihabi<>RegLista(RCodi,r+1) then%>
				<tr><td height='10' colspan='7'></tr>
			<%end if
		end if
	next 'por habitacion
	end if%>
	
	<tr><td height='25' colspan='7'></tr>
	</table>
	
</td></tr>
</table>
</form>
<div id='panel' style='position:absolute; z-index:10; top:20px; left:50px; width:730; height:450; visibility:hidden; overflow:hidden' class='panel'>
<table align='center' width='730' border='0' cellpadding="0" cellspacing="2">
<tr><td height='20' align='center'><b>Tipo Habitación</b></td></tr>
<tr><td align='center'>
<form name='f2' method="post">
	<table width='100%' border='0' cellspacing='0' bgcolor="#FFCC99">
		<tr>
		<%for i=1 to ubound(idioma) 'poner los nombres y los inputs%>
		<td align='left'><%=DescriNombre(i)%></td>
		<%next%>
		</tr><tr>
		<%for i=1 to ubound(idioma) 'poner los nombres y los inputs%>	
			<td align='left'><input type='text' size='25' maxlength='75' name='<%=QueNombre(i)%>' value='<%=LosValores(i)%>'></td>
		<%next%>
		</tr>
		<tr>
		<td align='left'>Cap. Mínima
		<input type='text' size='2' maxlength="5" name='capmin' value='<%=capmin%>'></td>		
		<td align='left'>Cap. Normal
		<input type='text' size='2' maxlength="5" name='capnormal' value='<%=capnormal%>'></td>		
		<td align='left'>Cap. Máxima
		<input type='text' size='2' maxlength="5" name='capmax' value='<%=capmax%>'></td>		
		<td align='left'>Adult. Máximo
		<input type='text' size='2' maxlength="5" name='adultmax' value='<%=adultmax%>'></td>		
		<td align='left'>Niños Máximo
		<input type='text' size='2' maxlength="5" name='ninmax' value='<%=ninmax%>'></td>		
		</tr>
		<tr>
		<td align='left'>Orden Visualización
		<select name='orden'>
			<option value='0'>0</option>
			<option value='1'>1</option>
			<option value='2'>2</option>
			<option value='3'>3</option>
			<option value='4'>4</option>
			<option value='5'>5</option>
		</select>
		</td>
		<td align='left'>
		Cupo <input type='text' name='cupo' maxlength="5" size="5" value="<%=cupo%>"></td>
		<td align='left'>
		Desde <input type='text' name='cdesde' maxlength="10" size="12" value="<%=cdesde%>"></td>
		<td align='left'>
		Hasta <input type='text' name='chasta' maxlength="10" size="12" value="<%=chasta%>"></td>
		<td>
		<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>	
		<input type='hidden' name='id' value='<%=laid%>'>
		</td></tr>
	</table>
</form> <%' FORM 2%>
	<%' PRECIOS Y DTOS POR COLECTIVOS%>
	<table border='0' width="100%" cellspacing="2">
	<tr>
	<td align='center' valign='top'  bgcolor="#FFCC99">
	<form name='f3' method="post">
		<%' TABLA DE PRECIOS%>
		<div style='width:230; height:120; overflow:auto'>
		<table width='100%' border='1' cellspacing="0">
		<tr class='cabetabla'>
		<th colspan='3' align='center'>PRECIOS</th>
		</tr>
		<tr class='cabetabla'>
		<th align='left' class="colu_par">Temporada</th>
		<th align='center' colspan='2'>Precio</th>
		</tr>
		<%if hayPrecios then
			for p=0 to ubound(RegPrecios,2)
				if RegPrecios(PCodi,p)=laid then 'Hay precio de esa habitacion%>
					<tr><td align='left'>
					<%=VerFecha(RegPrecios(PFini,p)) & " - " & VerFecha(RegPrecios(PFFin,p))%>
					</td>
					<td align='right'>
					<input type='text' size='4' maxlength="8" name='precio' value='<%=formatnumber(RegPrecios(PPrecio,p),2)%>' style='height:13'></td>
					<td align='left'>
					<%if RegPrecios(PporH,p) then 'Precio por hab.%>
						&nbsp;x&nbsp;Hab.
					<%else%>
						&nbsp;x&nbsp;Pers.
					<%end if%>
					</td>
					</tr>
				<%end if
			next
		end if%>
		<tr><td colspan='3' align='left'>
			<input id='boton' type='button' value='Actualizar' style='cursor:pointer'>
		</td></tr>
		</table>
		</div>
	</form>
	</td>
	<TD align='center' valign='top'  bgcolor="#FFCC99">
		<%' TABLA DE DTOS POR COLECTIVOS%>
		<div style='width:250; height:120; overflow:auto'>
		<table width='100%' border='1' cellspacing="0">
		<tr class='cabetabla'>
		<th colspan='4' align='center'>DTO POR COLECTIVOS</th>
		</tr>
		<tr class='cabetabla'>
		<th align='center'>&nbsp;</th>
		<th align='left' class="colu_par">Temporada</th>
		<th align='center'>Colectivo</th>
		<th align='center'>Dto</th>
		</tr>
		<%if hayPrecios then
			for p=0 to ubound(RegPrecios,2)
				if RegPrecios(PCodi,p)=laid then
					for d=0 to ubound(RegDtos,2)
						if RegDtos(Dtempo,d)=RegPrecios(PTempo,p) and RegDtos(DHabi,d)=laid then 'misma temporada y esa habitacion%>
							<tr><td align='center'>
							<input type='checkbox' name='aborrar' value='<%=RegDtos(DCodi,d)%>'  style='height:13;border: 0px; width:13'>
							</td>
							<td align='left'>
							<%=VerFecha(RegPrecios(PFini,p)) & " - " & VerFecha(RegPrecios(PFFin,p))%>
							</td>
							<td align='right'>
							<%for c=0 to ubound(RegColec,2)'Buscar nombres colectivos
									if RegDtos(DCodi,d)=RegColec(CCodi,c) then%>
										<%=RegColec(CNombre,c)%>
									<%end if
							next%>
							</td>
							<td align='right'><%=RegDtos(DDto,d)%>&nbsp;%</td>
							</tr>
						<%end if
					next 'regdtos
				end if
			next 'RegPrecios
		end if%>
		</table>	
		</div>	
		<input type="button" value='Añadir'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value='Borrar Marcadas'>
	</TD>
	<TD align='center' valign='top' bgcolor="#FFCC99">
		<%' TABLA DE DTOS POR FECHA%>
		<div style='width:200; height:120; overflow:auto'>
		<table width='100%' border='1' cellspacing="0">
		<tr class='cabetabla'>
		<th colspan='4' align='center'>DTO POR FECHAS</th>
		</tr>
		<tr class='cabetabla'>
		<th align='center'>&nbsp;</th>
		<th align='left' class="colu_par">Inicio</th>
		<th align='left' class="colu_par">Fin</th>
		<th align='center'>Dto</th>
		</tr>
		<%if haydtosfechas then
			for f=0 to ubound(RegDtosFechas,2)%>
			<tr><td align='center'>
			<input type='checkbox' name='aborrar' value='<%=RegDtosFechas(DFCodi,f)%>'  style='height:13;border: 0px; width:13'>
			</td>
			<td align='left'>
			<%=VerFecha(RegDtosFechas(DFDesde,f))%>
			</td>
			<td align='left'>
			<%=VerFecha(RegDtosFechas(DFHasta,f))%>
			</td>
			<td align='right'><%=RegDtosFechas(DFValor,f)%>&nbsp;%</td>
			</tr>
			<%next
		end if%>
		</table>
		</div>
		<input type="button" value='Añadir'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value='Borrar Marcadas'>	</td>
	</tr>
	<tr><td align='center'   bgcolor="#FFCC99">
		<%' TABLA DE PRECIOS%>
		<div style='width:230; height:120; overflow:auto'>
		<table width='100%' border='1' cellspacing="0">
		<tr class='cabetabla'>
		<th colspan='3' align='center'>SUPLEMENTOS</th>
		</tr>
		<tr class='cabetabla'>
		<TH align='center'>&nbsp;</TH>
		<th align='left' class="colu_par">Suplemento</th>
		<th align='Right'>Precio</th>
		</tr>
		<%if haysuples then
				for s=0 to ubound(RegSuples,2)
					if RegSuples(SHabi,s)=laid then 'Es de esta habitacion%>
					<tr><td align='center'>
					<input type='checkbox' name='aborrar' value='<%=RegSuples(SCodi,s)%>'  style='height:13;border: 0px; width:13'>
					</td>
					<td align='left'><%=RegSuples(SNombre,s)%></td>
					<td align='right'>
					<%=formatnumber(RegSuples(SPelas,s),2)%>&nbsp;&euro;
					</td>
					</tr>
					<%end if
				next
		end if%>
		</table>
		</div>
	</td>	
	</tr>
	</table>
	
	
	
	
	
	
	
</td></tr>		
<tr><td height="10"></td></tr>
<tr><td align='center'>
	<input type="button" value="Cerrar" onClick="javascript:document.all.panel.style.visibility='hidden';" style='cursor:pointer'></td></tr>
</table>
</div>
<script language="JavaScript">
	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.all.panel.style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.all.panel.style.width)/2); //Pos. izquierda
	document.all.panel.style.top=30;
	document.all.panel.style.left=l;
	<%if laid<>0 then 'Visualizar panel
			response.write "document.all.panel.style.visibility='visible';" & bvcrlf
		end if	
	%>
</script>
</body>
</html>
