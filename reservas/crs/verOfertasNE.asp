<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
empEd=paClng(request.Cookies("idEmpresa"))
recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=paClng(request.QueryString("p"))
est=paClng(request.QueryString("est"))

%><!--#include file="actuOfertasNE.asp"--><%
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Ofertas "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		titulo_es=rs("titulo_es")
		titulo_it=rs("titulo_it")
		titulo_en=rs("titulo_en")
		titulo_de=rs("titulo_de")
		titulo_fr=rs("titulo_fr")
		nombre_es=rs("texto1_es")
		nombre_it=rs("texto1_it")
		nombre_en=rs("texto1_en")
		nombre_de=rs("texto1_de")
		nombre_fr=rs("texto1_fr")
		fini=rs("fechainicio")
		ffin=rs("fechafin")
		fcaduca=rs("caduca")
		aplicar=rs("aplicaren")
		habi=rs("idhabitacion")
		suple=rs("codigosuple")
		colec=rs("colectivo")
		noches=rs("totalnoches")
		nochesgratis=rs("nochesgratis")
		dto=rs("dto")
		precio=rs("precio")
		faplicar=rs("fechareserva")
		diasemana=rs("diasSemana")
		destacada=rs("destacada")
		calcula=rs("calcula")
		activa=rs("activa")
		est=rs("CodigoEsta")
		foto1=rs("foto1")
	end if
	rs.close
end if

'Tabla de habitaciones
cs="SELECT Id,Nombre_es FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
hayhabis=false
rs.open cs,base
if not rs.eof then
	RegHabis=rs.getrows
	HCodi=0
	HNombre=1
	hayhabis=true
end if
rs.close

'Tabla de Suplementos
cs="SELECT Regimen.Id,Regimen.Nombre_es FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
cs=cs & " GROUP BY Regimen.Id,Regimen.Nombre_es"
haysuples=false
rs.open cs,base
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close

'Buscar los nombres colectivos de este hotel
cs="SELECT CodigoColec,Nombre_es FROM " & precrs & "Colectivos "
cs=cs & "WHERE CodigoEsta=" & est & " AND Nombre_es<>''"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['elFrame<%=ff%>'].location="ofertas.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>&p=<%=pag%>&est=<%=est%>&id=<%=laid%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>&p=<%=pag%>&est=<%=est%>&id=<%=laid%>";

	document.f1.submit();
}
function queAplica(){
	//Funcion para desactivar habit. o suple. si no se usa
	valor=document.f1.aplicar.value;

	switch(valor) {
		case "0": //Todos
		  document.f1.habi.options[0].text="Cualquiera";
		  document.f1.suple.options[0].text="Cualquiera";
		  document.f1.habi.value='0';
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=false;
		  break;

		case "1": //Habitacion
			if (document.f1.habi.value=="0"){
				  document.f1.habi.options[0].text="Cualquiera";
				  document.f1.habi.value='0';				  
				 }
		  document.f1.suple.options[0].text="No se usa";
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=true;
		  break;
	
		case "2": //Suplemento
		  document.f1.habi.options[0].text="No se usa";
		  document.f1.habi.value='0';
			if (document.f1.suple.value=="0"){
				  document.f1.suple.options[0].text="Cualquiera";
				  document.f1.suple.value='0';
				 }
		  document.f1.habi.disabled=true;
		  document.f1.suple.disabled=false;
		  break;
    }	
	

}

</script>

<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">OFERTA</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>"  enctype="multipart/form-data" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
		
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left'>Título Esp.:</td>
		<td align='left'>Título Ita.:</td>
		<td align='left'>Título Ing.:</td>
		<td align='left'>Título Ale.:</td>
		<td align='left'>Título Fr.:</td>
	</tr>
	<tr>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_es%>' name="titulo_es"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_it%>' name="titulo_it"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_en%>' name="titulo_en"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_de%>' name="titulo_de"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_fr%>' name="titulo_fr"></td>
	</tr>
	<tr><td align='left'>Nombre Esp.:</td>
		<td align='left'>Nombre Ita.:</td>
		<td align='left'>Nombre Ing.:</td>
		<td align='left'>Nombre Ale.:</td>
		<td align='left'>Nombre Fr.:</td>
	</tr>
	<tr>
	<td align='left'><textarea style="width:150px; height:100px" name='nombre_es'><%=nombre_es%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_it'><%=nombre_it%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_en'><%=nombre_en%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_de'><%=nombre_de%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_fr'><%=nombre_fr%></textarea></td>
	</tr>
	<tr>
		<td align='left' valign="top">Fecha Inicio: <input type="text" name="fini" value='<%=verFecha(fini)%>' style="width:75px" maxlength="12"><br/>
		Válida hasta: <input type="text" name="fcaduca" value='<%=verFecha(fcaduca)%>' style="width:75px;" maxlength="12"></td>
		<td align='left' valign="top">Fecha Fin: <input type="text" name="ffin" value='<%=verFecha(ffin)%>' style="width:75px" maxlength="12"></td>
		<td align="right">Días que se aplica.</td>
		<td colspan="2" align="left">
			<table border="0" width="100%" cellpadding="0" cellspacing="1">
			<tr><td>Lun</td>
				<td>Mar</td>
				<td>Mie</td>
				<td>Jue</td>
				<td>Vie</td>
				<td>Sab</td>
				<td>Dom</td>
			</tr>
			<tr><td><input type="checkbox" value="L" name='L' <%if instr(diasemana,"L")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="M" name='M' <%if instr(diasemana,"M")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="X" name='X' <%if instr(diasemana,"X")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="J" name='J' <%if instr(diasemana,"J")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="V" name='V' <%if instr(diasemana,"V")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="S" name='S' <%if instr(diasemana,"S")<>0 then response.write "checked"%>></td>
				<td><input type="checkbox" value="D" name='D' <%if instr(diasemana,"D")<>0 then response.write "checked"%>></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="5" align='left'>
		
		<table border='0' cellpadding="0" cellspacing="0">
			<tr>
				<td align='right'>Aplicar oferta en:</td>
				<td align='left' colspan="2">
					<select name="aplicar" onChange="javascript:queAplica();">
						<option value="0" <%if aplicar=0 then response.write "selected"%>>Todo</option>
						<option value="1" <%if aplicar=1 then response.write "selected"%>>Precio Habitación</option>
						<option value="2" <%if aplicar=2 then response.write "selected"%>>Precio Régimen</option>
					</select>
					(Determina en qué se aplica la oferta)
				</td>
				
			</tr>
			<tr>
				<td align='right'>Tipo Habitación:</td>
				<td align='left' colspan="2">
					<select name="habi">
						<option value="0">Cualquiera</option>
						<%if hayhabis then
							for h=0 to ubound(RegHabis,2)
								marca=""
								if RegHabis(HCodi,h)=clng(habi) then marca="selected"%>
								<option value="<%=RegHabis(HCodi,h)%>" <%=marca%>><%=RegHabis(HNombre,h)%></option>
							<%next
						end if%>
					</select>
					(Cualquier habitación o una en concreto)
				</td>
			</tr>
			<tr>
				<td align='right'>Régimen:</td>
				<td align='left' colspan="2">
					<select name="suple">
						<option value="0">Cualquiera</option>
						<%if haysuples then
							for h=0 to ubound(RegSuples,2)
								marca=""
								if RegSuples(SCodi,h)=suple then marca="selected"%>
								<option value="<%=RegSuples(SCodi,h)%>" <%=marca%>>
								<%
								response.write RegSuples(SNombre,h)
								'latempo=" (cualquiera)"
								'if haytempos then
								'	for t=0 to ubound(RegTempos,2)
									'	if RegTempos(TCodi,t)=RegSuples(STempo,h) then
										'	latempo=" (" & verFecha(RegTempos(TFIni,t)) & "-" & verFecha(RegTempos(TFFin,t)) & ")"
											'exit for
										'end if
									'next
								'end if
								'response.write latempo
								%>								
								</option>
							<%next
						end if%>
					</select>
					(Cualquier régimen o uno en concreto)
				</td>
			</tr>
			<input type="hidden" name='colectivo' value='0'>
			<tr>
				<td align='right'>Estancia Superior o igual a:</td>
				<td align='left' colspan="2">
					<input type="text" name="noches" size="3" maxlength="3" value="<%=noches%>">
					&nbsp;noches. (Realiza esta oferta cuando la estancia es superior o igual)
				</td>
			</tr>
			<tr>
				<td align='right'>La oferta es de:</td>
				<td align='left' colspan="2">
					<input type="text" name="dto" size="3" maxlength="3" value="<%=dto%>">&nbsp;%
					&nbsp;&nbsp;&nbsp;o&nbsp;
					<input type="text" name="precio" size="6" maxlength="7" value="<%=precio%>">&nbsp;&euro;
					&nbsp;&nbsp;o&nbsp;
					<input type="text" name="nochesgratis" size="3" maxlength="3" value="<%=nochesgratis%>">&nbsp;Noches gratis.
					&nbsp;&nbsp;&nbsp;&nbsp;
					(Sólo rellenar uno de los campos el resto dejarlo a cero).
				</td>
			</tr>
			<tr><td align="right">Destacada:</td>
				<td align="left"><input type="checkbox" value="1" name="destacada" <%if destacada then response.write "checked"%>></td>
				<td rowspan="3" style='padding-top:4px'><input type="file" id="foto1" name="foto1" style="height:20px">
				<br><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%if foto1<>"" then%>
							<img src='<%=rutafotos & "/" & foto1%>' height='45'>
							<%else%>
							<img src='img/tr.gif' height='45'>
							<%end if%>
							</td>
			</tr>
			<tr><td align="right">¿Realiza Cálculo?:</td>
				<td align="left"><input type="checkbox" value="1" name="calcula" <%if calcula then response.write "checked"%>></td>
			</tr>
			<tr><td align="right">Activa:</td>
				<td align="left"><input type="checkbox" value="1" name="activa" <%if activa then response.write "checked"%>></td>
			</tr>
		</table>
	</td></tr>
	<tr><td align='center' colspan='5'>
		<input id='boton' type='button' class="boton86" value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>	
		<input type='hidden' name='id' value='<%=laid%>'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"value="Cerrar" class="boton86" onClick="javascript:cerrar();" style='cursor:pointer'></td></tr>
</table>

	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.titulo_es.focus();
</script>
</body>
</html>