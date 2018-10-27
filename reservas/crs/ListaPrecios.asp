<!-- #Include File="../Connections/FunctionesVte.asp"-->
<!-- #Include File="../Connections/lang.asp"-->
<%
est=request.querystring("est")
if est="" then est=0

	'Variables de tipo servicio
	porpersona=0
	porreserva=1
	pordia=2
	porpersonaydia=3

set base=server.createobject("ADODB.Connection")
base.Open Conecta
Set rs = CreateObject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

cs="SELECT Nombre,PorCiento,Pers3,MinDias FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	NombreHotel=rs("Nombre")
	Prepago=rs("PorCiento")
	DtoExtra=rs("Pers3")
	MinDias=rs("MinDias")
	rs.close

	'Buscar tipo habitaciones
	cs="SELECT CodigoHab,Nombre FROM " & precrs & "TipoHabita TipoHabita INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "ON TipoHabita.CodigoHab=TipoHabitaNombres.TipoHabiIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & iditxt & "' ORDER BY CodigoHab"
	rs.open cs,base
	hayhabis=false
	if not rs.eof then 'Cargo la tabla
		RegHabis=rs.getRows
		HCodi=0
		HNombre=1
		hayhabis=true
	end if
	rs.close
	
	'Buscar temporadas
	cs="SELECT CodigoTemp,Nombre,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas INNER JOIN " & precrs & "TemporadasNomres TemporadasNomres "
	cs=cs & "ON Temporadas.CodigoTemp=TemporadasNomres.TempIdi "
	cs=cs & "WHERE CodigoEsta=" & est & "  AND Idioma='" & iditxt & "' ORDER BY FInicio"
	rs.open cs,base
	haytempos=false
	if not rs.eof then 'Carga en tabla
		haytempos=true
		RegTempos=rs.getRows
		TCodi=0
		TNombre=1
		TFIni=2
		TFFin=3
	end if
	rs.close
	
	'Buscar Nombres colectivos
	cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
	cs=cs & "ON Colectivos.CodigoColec=ColectivosNomres.ColectivoIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & iditxt & "' AND "
	cs=cs & "Nombre<>'' ORDER BY CodigoColec"
	rs.open cs,base
	if not rs.eof then
		RegColec=rs.GetRows
		CCodi=0
		CNombre=1
	end if
	rs.close
	ColColec=ubound(RegColec,2)+1 'Nº de columnas en nombres de colectivos
	
	'Buscar Dtos colectivos
	cs="SELECT Colectivos.CodigoColec,Temporada,TipoHab,Prebase FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
	cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec "
	cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY TipoHab"
	rs.open cs,base
	haydtocolec=false
	if not rs.eof then
		RegDtoColec=rs.GetRows
		CdtoCodi=0
		CDtoTempo=1
		CDtoHabi=2
		CDtoValor=3
		haydtocolec=true
	end if
	rs.close
	
	'Precios de las habitaciones 
	cs="SELECT TipoHabita,Nombre,Temporada,PrePreBase,PrePerHab "
	cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "ON TipoHabitaPrecios.TipoHabita=TipoHabitaNombres.TipoHabiIdi "
	'busco solo las habitaciones que tiene
	busco="("
	for h=0 to ubound(RegHabis,2)
		busco=busco & "TipoHabita=" & RegHabis(HCodi,h) & " OR "
	next 
	if busco<>"(" then busco=left(busco,len(busco)-3) 'Qiuto el OR
	cs=cs & "WHERE " & busco & ") AND Idioma='" & iditxt & "' ORDER BY TipoHabita"
	rs.open cs,base
	if not rs.eof then
		RegPvpHabi=rs.GetRows
		Hpvpcodi=0
		HPvpNombre=1
		HPvpTempo=2
		HPvpPrecio=3
		HPvpPorhab=4	
	end if
	rs.close

	'Buscar suplementos por habitacion
	haysuples=false
	cs="SELECT CodigoSuple,TipoHab,Precio,SuplementoNombres.Nombre as Suple "
	cs=cs & "FROM " & precrs & "Suplementos Suplementos INNER JOIN " & precrs & "SuplementoNombres SuplementoNombres "
	cs=cs & "ON Suplementos.CodigoSuple=SuplementoNombres.SuplementosIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND SuplementoNombres.Idioma='" & iditxt & "' "
	cs=cs & "AND (TipoHab=0 OR "
	'busco solo las habitaciones que tiene
	busco=""
	for h=0 to ubound(RegHabis,2)
		busco=busco & "TipoHab=" & RegHabis(HCodi,h) & " OR "
	next 
	if busco<>"" then busco=left(busco,len(busco)-3) 'Qiuto el OR
	cs=cs & busco & ") ORDER BY TipoHab,CodigoSuple"
	rs.open cs,base
	if not rs.eof then
		RegSuples=rs.GetRows
		SCodi=0
		SHabi=1
		SPrecio=2
		SNombre=3
		haysuples=true
	end if
	rs.close

	'Buscar dto suplementos por habitacion
	cs="SELECT Suplementos.CodigoSuple,TipoHab,CodigoColec,DescuentosSuple.CodigoTempo,Descuento "
	cs=cs & "FROM " & precrs & "Suplementos Suplementos INNER JOIN " & precrs & "DescuentosSuple DescuentosSuple "
	cs=cs & "ON Suplementos.CodigoSuple=DescuentosSuple.CodigoSuple "
	cs=cs & "WHERE CodigoEsta=" & est & " AND (TipoHab=0 OR " 
	'busco solo las habitaciones que tiene
	busco=""
	for h=0 to ubound(RegHabis,2)
		busco=busco & "TipoHab=" & RegHabis(HCodi,h) & " OR "
	next 
	if busco<>"" then busco=left(busco,len(busco)-3) 'Qiuto el OR
	cs=cs & busco & ") ORDER BY CodigoColec,TipoHab"
	rs.open cs,base
	haydtosuples=false
	if not rs.eof then
		RegDtoSuples=rs.GetRows
		SDtoCodi=0
		SDtoHabi=1
		SDtoColec=2
		SDtoTempo=3
		SDtoDto=4
		haydtosuples=true
	end if
	rs.close
	
	'Dtos ESpeciales por tipo Habitacion
	cs="SELECT Nombre,Desde,Hasta,Value FROM "
	cs=cs & "" & precrs & "DescuentosFechas DescuentosFechas INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres ON "
	cs=cs & "DescuentosFechas.TipoHab=TipoHabitaNombres.TipoHabiIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & iditxt & "' ORDER BY TipoHab "
	rs.open cs,base
	haydtoespe=false
	if not rs.eof then
		RegDtoEspe=rs.getrows
		ENombre=0
		EDesde=1
		EHasta=2
		EValor=3
		haydtoespe=true
	end if
	rs.close

	'Buscar Servicios 
	cs="SELECT Nombre,ServiciosTemporadas.Id,IdTemporada,"
	cs=cs & "IdColectivo,Tipo,Importe,ServiciosTemporadas.IDServicio "
	cs=cs & "FROM (" & precrs & "Servicios Servicios INNER JOIN " & precrs & "ServiciosNombres ServiciosNombres "
	cs=cs & "ON Servicios.id=ServiciosNombres.IdServicio) "
	cs=cs & "INNER JOIN ServiciosTemporadas ON "
	cs=cs & "Servicios.Id=ServiciosTemporadas.IdServicio "
	cs=cs & "WHERE Servicios.CodigoEsta=" & est & " AND "
	cs=cs & "idioma='" & iditxt & "'"
	rs.Open cs, base
	HayServicios=false
	if not rs.eof then 'poner la tabla 
		RegServis=rs.GetRows
		'Variables para la tabla RegServis
		SNomServi=0
		SId=1
		SIdTem=2
		SIdCol=3
		STipo=4
		SImpor=5
		SIdServi=6
		HayServicios=true
	end if
	rs.close
	
end if
set rs=nothing
base.close
set base=nothing

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Planeta-Web</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<STYLE type=text/css>.fondoindex {
	BACKGROUND-IMAGE: url(file:///C|/CLIENTES/THB/thb_web_actual/images/comunes/fondo_index.jpg); BACKGROUND-REPEAT: repeat
}
.thbwhite {
	COLOR: #ffffff; TEXT-DECORATION: underline
}
</STYLE>

<SCRIPT language=JavaScript>
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</SCRIPT>
<link href="global.css" rel="stylesheet" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR><style type="text/css">
<!--
body {
	background-color: #023962;
	color: #FFFFFF;
}
-->
</style></HEAD>
<BODY>
<div align='center' style='width:600; height:380; overflow:auto'>
<TABLE borderColor='#2c3c83' cellSpacing=0 cellPadding=0 width=500 align=center  border=0>
  <TR>
    <TD>
          <TABLE borderColor='#000000' cellSpacing=0 cellPadding=0 border=0>
              <TR> 
                <TD vAlign=top align='center'>
                    <TABLE cellSpacing=0 cellPadding=0 width=500  border=0>
                        <TR> 
                          <TD>
						  <TABLE cellSpacing=0 cellPadding=4 width=500 align=center 
                  border=0>
                                <TR> 
                                  <TD align='center' class='titulo'><%=NombreHotel%>
                                    <TABLE width=250 
                  border=0 align="center" cellPadding=0 cellSpacing=0>
                                        <TR>
                                          <TD>&nbsp;</TD>
                                          <TD><IMG height=1 
                        src="Protur Hotels - Hoteles y Apartamentos Mallorca - Vacaciones Mallorca_archivos/shim.gif" 
                        width=1></TD>
                                          <TD>&nbsp;</TD>
                                        </TR>
										<tr><td width="10">&nbsp;</TD>
										<td align='center' bgcolor="#FFCC00"><font size="2" color="#000000"><b><%=ap("precio")%>s</b></font></td>
										<td width="10">&nbsp;</TD>
										</tr>
                                        <TR>
                                          <TD width="10">&nbsp;</TD>
                                          <TD bgcolor="#FFCC00">
                                            <table width="541" border="0" cellspacing="0" cellpadding="2" align="center">
                                              <tr class="">
                                                <td colspan='3' class='filaimpar'></td>
                                                <td align="center" bgcolor='#F1F7E6'  style="color:#000000" colspan="<%=ColColec%>"><b><%=ap("descuentos")%></b></td>
                                              </tr>
											  <%'Precios Habitacion y su descuento%>
                                              <tr class='filaimpar'>
                                                <td align="left" class='filaimpar'><b><%=ap("fechas")%></b></td>
												<td align="left" class='filaimpar'><b><%=ap("tipohab")%></b></td>
                                                <td align="right" class='filaimpar'><b><%=ap("precio")%></b></td>
												<%for c=0 to ubound(RegColec,2)%>
													<td align='right' bgcolor='#F1F7E6' style='color:#000000'><b><%=RegColec(CNombre,c)%></b></td>
												<%next%>
                                              </tr>
											  <% 'Temporadas
											  for t=0 to ubound(RegTempos,2)
											  	if (t mod 2)=0 then
											  		fila="filapar"
												else
													fila="filaimpar"
												end if
												%>
												  <tr class='<%=fila%>'>
												  <td align='left' class='<%=fila%>'><%=VerFecha(Regtempos(TFIni,t))%> - 								  <%=VerFecha(regTempos(TFFin,t))%></td>
												 <td align='left' class='<%=fila%>'>
												 	<%for h=0 to ubound(RegPvpHabi,2)							  
														if RegPvpHabi(HPvpTempo,h)=RegTempos(TCodi,t) then
															response.write RegPvpHabi(HPvpNombre,h) & "<br>" & vbcrlf
														end if
													next%>
												</td>
												 <td align='right' class='<%=fila%>'>
											  		<%for h=0 to ubound(RegPvpHabi,2)
														if RegPvpHabi(HPvpTempo,h)=RegTempos(TCodi,t) then
															response.write formatnumber(RegPvpHabi(HPvpPrecio,h),2) & " &euro; "
															if RegPvpHabi(HPvpPorhab,h)=true then 'Precio por hab
																response.write ap("xhabi") & "<br>" & vbcrlf
															else
																response.write ap("xpersona") & "<br>" & vbcrlf
															end if
														end if
													next%>
												</td>
												<%for c=0 to ubound(RegColec,2)%>
													<td align='right' class='<%=fila%>'>
														<%
														for h=0 to ubound(RegHabis,2)
															habisincolec=true
															if haydtocolec then
																for cc=0 to ubound(RegDtoColec,2)
																
																if RegHabis(HCodi,h)=RegDtoColec(CDtoHabi,cc) and  RegDtoColec(CDtoCodi,cc)=RegColec(CCodi,c) and (RegDtoColec(CDtoTempo,cc)=RegTempos(TCodi,t) or RegDtoColec(CDtoTempo,cc)=0) then
																		habisincolec=false
																		response.write RegDtoColec(CDtoValor,cc) & "%<br>" & vbcrlf
																end if
																next 'Dtos Colectivos
															end if
															'Si la habitacion no tiene dto colectivo
															if habisincolec then response.write "<br>" & vbcrlf
														next 'FIn Hab%>
													</td>
												<%next 'Fi n colec %>
												  </tr>
											  <%next 'fin de tempo
											  if dtoextra<>0 then%>
											  <tr><td colspan='<%=ColColec+3%>' style="color:#000000">
											  <%=ap("dtocamasuple") & " " & dtoextra & "%"%>
											  </td></tr>
											  <%end if
											  'SUPLEMENTOS
											if haysuples then%>
											  <tr><td colspan='<%=ColColec+3%>' height='25'></td></tr>
											  <tr><td colspan='<%=ColColec+3%>' align='center'>
												<font size="2" color="#000000"><b><%=ap("suple")%></b></font></td>
											  </tr>
                                              <tr class="filaimpar">
                                                <td colspan='3'></td>
                                                <td align="center" colspan="<%=ColColec%>" bgcolor='#F1F7E6' style="color:#000000"><b><%=ap("descuentos")%></b></td>
                                              </tr>
                                              <tr class="filaimpar">
                                                <td align="left" class="filaimpar"><b><%=ap("tipohab")%></b></td>
												<td align="left" class="filaimpar"><b><%=ap("suple")%></b></td>
                                                <td align="right" class="filaimpar"><b><%=ap("precio")%></b></td>
												<%for c=0 to ubound(RegColec,2)%>
													<td align='right' bgcolor='#F1F7E6' style="color:#000000"><b><%=RegColec(CNombre,c)%></b></td>
												<%next%>
                                              </tr>
											  <%
											  	linea=0
												codihabi=RegSuples(SHabi,0) 
												  for s=0 to ubound(RegSuples,2)
													if codihabi<>RegSuples(SHabi,s) then
														linea=linea+1
													end if
													if (linea mod 2)=0 then
														fila="filapar"
													else
														fila="filaimpar"
													end if
													codiHabi=RegSuples(SHabi,s)
													%>
													  <tr class='<%=fila%>'>
													  <td align='left' class='<%=fila%>'>
													  <%if s>0 then
															if RegSuples(SHabi,s)<>RegSuples(SHabi,s-1) then
																for hab=0 to ubound(RegHabis,2)
																	if RegSuples(SHabi,s)=RegHabis(HCodi,hab) then
																	  response.write RegHabis(HNombre,hab)
																	 end if
																next
																if RegSuples(SHabi,s)=0 then 'Cualquier hab.
																	response.write ap("cualquierhabi")
																end if
															 end if
														 else
																for hab=0 to ubound(RegHabis,2)
																	if RegSuples(SHabi,s)=RegHabis(HCodi,hab) then
																	  response.write RegHabis(HNombre,hab)
																	 end if
																next
																if RegSuples(SHabi,s)=0 then 'Cualquier hab.
																	response.write ap("cualquierhabi")
																end if

														end if%>
													</td>
													  <td align='left' class='<%=fila%>'><%=RegSuples(SNombre,s)%></td>
													 <td align='right' class='<%=fila%>'><%=formatnumber(RegSuples(SPrecio,s),2)%> &euro;</td>
													<%for c=0 to ubound(RegColec,2)%>
														<td align='right' class='<%=fila%>'>
															<%
															if haydtosuples then
																for cc=0 to ubound(RegDtoSuples,2)
																	if RegSuples(SHabi,s)=RegDtoSuples(SDtoHabi,cc) and RegColec(CCodi,c)=RegDtoSuples(SDtoColec,cc) and RegSuples(SCodi,s)=RegDtoSuples(SDtoCodi,cc) then
																			response.write RegDtoSuples(SDtoDto,cc) & "%<br>" & vbcrlf
																	end if
																next 'Dtos Suplementos
															end if%>
														</td>
													<%next 'Fi colec%>
												  </tr>
												  <%next 'Fin suplementos
											end if 'Hay suples%>
											<%' Descuentos especiales
											if haydtoespe then %>
											<tr><td colspan='<%=ColColec+3%>' height='25'></td></tr>
											<tr><td colspan='<%=ColColec+3%>' align='center'>
											<font size="2" color="#000000"><b><%=ap("dtoespeciales")%></b></font></td></tr>
                                              <tr class='filaimpar'>
                                                <td align="left" class='filaimpar'><b><%=ap("TipoHab")%></b></td>
                                                <td align="center" class='filaimpar'><b><%=ap("fechas")%></b></td>
                                                <td align="center" class='filaimpar'>&nbsp;</td>
                                                <td align="center" class='filaimpar' colspan="<%=ColColec%>"><b><%=ap("descuentos")%></b></td>
                                              </tr>
											<%for e=0 to ubound(RegDtoEspe,2)
													if (e mod 2)=0 then
														fila="filapar"
													else
														fila="filaimpar"
													end if
											%>
												  <tr class='<%=fila%>'>
												  <td align='left' class='<%=fila%>'><%=RegDtoEspe(ENombre,e)%></td>
												  <td align='left' class='<%=fila%>'><%=VerFecha(RegDtoEspe(EDesde,e))%> - 								  <%=VerFecha(RegDtoEspe(EHasta,e))%></td>
												  <td>&nbsp;</td>
												 <td align='center' class='<%=fila%>' colspan="<%=ColColec%>"><%=RegDtoEspe(EValor,e)%>%</td>
												</tr>
											  <%next
											  end if 'Fin dto especial%>
											<%' Servicios
											if hayservicios then %>
											<tr><td colspan='<%=ColColec+3%>' height='25'></td></tr>
											<tr><td colspan='<%=ColColec+3%>' align='center'>
											<table align='center' width='100%' cellpadding="0" cellspacing="0" border="0">
											<tr><td colspan='5' align='center'>
											<font size="2" color="#000000"><b><%=ap("servicios")%></b></font></td></tr>
                                              <tr class='filaimpar'>
                                                <td align="left" class='filaimpar'><b><%=ap("servicios")%></b></td>
                                                <td align="center" class='filaimpar'><b><%=ap("fechas")%></b></td>
                                                <td align="center" class='filaimpar'><b><%=ap("colectivo")%></b></td>
                                                <td align="left" colspan='2' class='filaimpar'><b><%=ap("precio")%></b></td>
                                              </tr>
											  <%linea=0
												codiservi=RegServis(SIdServi,0) 
												  for s=0 to ubound(RegServis,2)
													if codiservi<>RegServis(SIdServi,s) then
														linea=linea+1
													end if
													if (linea mod 2)=0 then
														fila="filapar"
													else
														fila="filaimpar"
													end if
													codiservi=RegServis(SIdServi,s)
													%>
												  <tr class='<%=fila%>'>
												  <td align='left' class='<%=fila%>'>
													  <%if s>0 then
															if RegServis(SHabi,s)<>RegServis(SNomServi,s-1) then
																  response.write RegServis(SNomServi,s)
															 end if
														 else
															 response.write RegServis(SNomServi,s)
														end if%>
												</td>
												  <td align='center' class='<%=fila%>'>
												  <%if RegServis(SIdTem,s)<>0 then 'poner temporada
															for t=0 to ubound(RegTempos,2)
																if RegServis(SIdTem,s)=RegTempos(TCodi,t) then
																	response.write VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t)) & "<br>" & vbcrlf
																end if
															next
														else 'Cualquiera
															response.write ap("cualquierfecha")
														end if%>
													</td>
												  <td align='center' class='<%=fila%>'>
												  <%if RegServis(SIdCol,s)<>0 then 'poner colectivo
															for c=0 to ubound(RegColec,2)
																if RegServis(SIdCol,s)=RegColec(CCodi,c) then
																	response.write RegColec(CNombre,c) & "<br>"
																end if
															next
														else 'Cualquirea
															response.write ap("cualquiercolectivo")
														end if%>
												  </td>
												 <td align='right' class='<%=fila%>'><%=RegServis(SImpor,s)%>&euro;</td>
												 <td align='left' class='<%=fila%>'>
												 <%select case RegServis(STipo,s)
												 	case porpersona
														response.write ap("porpersona") 
												 	case porreserva
														response.write ap("porreserva") 
												 	case pordia
														response.write ap("pordia") 
												 	case porpersonaydia
														response.write ap("porpersonaydia") 
												 end select%>
												 </td>
												</tr>
											  <%next%>
											  </table>
											  </td></tr>
											  <%end if 'Fin Servicios%>

											 <tr><td colspan='<%=ColColec+3%>' height='25'></td></tr>
                                            </table>
                                            <br>
										  </TD>
                                          <TD width="10">&nbsp;</TD>
                                        </TR>
                                        <TR>
                                          <TD>&nbsp;</TD>
                                          <TD><IMG height=1 
                        src="Protur Hotels - Hoteles y Apartamentos Mallorca - Vacaciones Mallorca_archivos/shim.gif" 
                        width=1></TD>
                                          <TD>&nbsp;</TD>
                                        </TR>
                                    </TABLE>
								</TD>
                                </TR>
                            </TABLE></TD>
                        </TR>
                    </TABLE>
                  </TD>
              </TR>
          </TABLE>
	</TD></TR>
</TABLE>
</div>
</BODY>
</HTML>
