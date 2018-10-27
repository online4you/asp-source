<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
dim TIdiomas() 'titulo traduccion
dim TexIdiomas() 'texto traduccion

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))

%><!--#include file="actuOfertas.asp"--><%
%><!--#include file="monedaHotel.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
redim TexIdiomas(ubound(ListaIdiomas))
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Ofertas.*,Idioma,Traduccion,Campo "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' "
	cs=cs & "WHERE Ofertas.Id=" & laid
	rs.open cs,base
	do while not rs.eof
		titulo=rs("titulo")
		texto=rs("texto")
		fini=rs("fechainicio")
		ffin=rs("fechafin")
		fcaduca=rs("caduca")
		fvalida=rs("valida")
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
		codpromocion=rs("CodigoPromocion")
		CodigoOferta=rs("CodigoOferta")
		diasAntelacion=rs("diasAdelanto")
		foto="" & rs("foto1")
		
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=rs("idioma") then 'este
				if rs("campo")="Titulo" then TIdiomas(idi)=rs("traduccion") 'titulos
				if rs("campo")="Texto" then TexIdiomas(idi)=rs("traduccion") 'texto
			end if
		next 'idi
		TIdiomas(0)=titulo 'langPorDefecto
		TexIdiomas(0)=Texto 'langPorDefecto
		rs.movenext
	loop
	rs.close
end if

'Lista habitaciones
cs= "SELECT TipoHabitaNombres.Id,IF(ISNULL(traduc.Traduccion),TipoHabitaNombres.Nombre,traduc.Traduccion) Tradu "
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TipoHabitaNombres"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TipoHabitaNombres.Id = traduc.IdReferencia  "
cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est
cs=cs & " ORDER BY Orden,TipoHabitaNombres.Id"
rs.open cs,base
hayhabis=false
if not rs.eof then
	RegHabis=rs.getrows
	HaCodi=0
	HaNombre=1
	hayhabis=true
end if
rs.close

'Tabla de Suplementos
cs="SELECT Regimen.Id,IF(ISNULL(traduc.Traduccion),Regimen.Nombre,traduc.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Regimen"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON Regimen.Id = traduc.IdReferencia  "
cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo
cs=cs & " GROUP BY Regimen.Id,IF(ISNULL(traduc.Traduccion),Regimen.Nombre,traduc.Traduccion)"
'response.write cs
haysuples=false
rs.open cs,base
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close

'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) as Tradu,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND "
cs=cs & "Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
end if
rs.close

set rs=nothing
base.close
set base=nothing

'calcula ancho del textarea
maxAncho=810 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>3 then 'hay mas de cinco y sólo pongo 5 idiomas por fila
	anchoColu=paClng(anchoDispo/5)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 and msgerror="" then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if
if msgerror<>"" then%>
alert("<%=msgerror%>");
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>";
	document.getElementById('est').value="<%=est%>";
	document.getElementById('recarga').value="<%=recarga%>";
	if (document.f1.id.value=="0")
		document.getElementById('modo').value="nuevo";
	else
		document.getElementById('modo').value="actu";

	document.f1.submit();
}
function queAplica(){
	//Funcion para desactivar habit. o suple. si no se usa
	valor=document.f1.aplicar.value;

	switch(valor) {
		case "0": //Todos
		  document.f1.habi.options[0].text='<%=objIdioma.getTraduccionHTML("i_cualquiera")%>';
		  document.f1.suple.options[0].text='<%=objIdioma.getTraduccionHTML("i_cualquiera")%>';
		  document.f1.habi.value='0';
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=false;
		  break;

		case "1": //Habitacion
			if (document.f1.habi.value=="0"){
				  document.f1.habi.options[0].text='<%=objIdioma.getTraduccionHTML("i_cualquiera")%>';
				  document.f1.habi.value='0';				  
				 }
		  document.f1.suple.options[0].text='<%=objIdioma.getTraduccionHTML("i_noseusa")%>';
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=true;
		  break;
	
		case "2": //Suplemento
		  document.f1.habi.options[0].text='<%=objIdioma.getTraduccionHTML("i_noseusa")%>';
		  document.f1.habi.value='0';
			if (document.f1.suple.value=="0"){
				  document.f1.suple.options[0].text='<%=objIdioma.getTraduccionHTML("i_cualquiera")%>';
				  document.f1.suple.value='0';
				 }
		  document.f1.habi.disabled=true;
		  document.f1.suple.disabled=false;
		  break;
    }	
	

}

</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_oferta")%> -> <%=TIdiomas(0)%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="get" enctype="multipart/form-data">
		<input type="hidden" name="modo" id="modo">
		<input type="hidden" name="est" id="est">
		<input type="hidden" name="recarga" id="recarga">
		<div style="visibility:hidden; position:absolute;">
		<%=objIdioma.getTraduccionHTML("i_promocion")%>:
		&nbsp;<input type="text" maxlength="25" style="width:100px" value='<%=codpromocion%>' name="codpromocion">
		&nbsp;<%=objIdioma.getTraduccionHTML("i_textopromocion")%>
		</div>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
		
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left' colspan="5">

		<%=objIdioma.getTraduccionHTML("i_promocion")%>:
		&nbsp;<input type="text" maxlength="25" style="width:100px" value='<%=CodigoOferta%>' name="CodigoOferta">

		</td>
    </tr>
    <tr>
    <%
	colu=1
	maxColu=5
	for idi=0 to ubound(listaIdiomas)
		titulo=TIdiomas(Idi)%>
		<td align='left'>
        <%=objIdioma.getTraduccionHTML("i_titulo_" & listaIdiomas(idi))%>:<br/>
        <input type="text" maxlength="75" style="width:<%=anchoColu%>px" value='<%=titulo%>' name="titulo_<%=listaIdiomas(idi)%>">
        </td>
        <%colu=colu+1
		if colu>maxColu then
			response.write "</tr><tr>"
			colu=1
		end if
    next 'idi%>
    </tr>
    <tr>
    <%
	colu=1
	maxColu=5
	for idi=0 to ubound(listaIdiomas)
		texto=TexIdiomas(Idi)%>
		<td align='left'>
        <%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_<%=listaIdiomas(idi)%>',680,450);"><br/>
        <textarea style="width:<%=anchoColu%>px; height:100px" name='texto_<%=listaIdiomas(idi)%>' id='texto_<%=listaIdiomas(idi)%>'><%=texto%></textarea>
        </td>
        <%colu=colu+1
		if colu>maxColu then
			response.write "</tr><tr>"
			colu=1
		end if
    next 'idi%>
    </tr>
	<tr>
		<td align='left' valign="top" colspan="5">
			<table cellpadding="0" cellspacing="0" width="100%">
            <tr><td colspan="3">
            	<table cellpadding="0" cellspacing="1" border="0">
                <tr><td align="left"><%=objIdioma.getTraduccionHTML("i_fechainicio")%>:</td>
                	<td align="left">
                    <input type="text" name="fini" value='<%=verFecha(fini)%>' style="width:60px" maxlength="12"></td>
                    <td width="10"></td>
                    <td align="left"><%=objIdioma.getTraduccionHTML("i_fechafinal")%>:</td>
                    <td align="left">
                    <input type="text" name="ffin" value='<%=verFecha(ffin)%>' style="width:60px" maxlength="12">
                    &nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_fechaestancia")%>
                    </td>
                </tr>
                <tr>
                	<td align="left"><%=objIdioma.getTraduccionHTML("i_fvalida")%>:</td>
                    <td align="left">
                    <input type="text" name="fvalida" value='<%=verFecha(fvalida)%>' style="width:60px;" maxlength="12"></td>
                    <td width="10"></td>
                    <td align="left"><%=objIdioma.getTraduccionHTML("i_fcaduca")%>:</td>
                    <td align="left">
                    <input type="text" name="fcaduca" value='<%=verFecha(fcaduca)%>' style="width:60px;" maxlength="12">
                    &nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_fechareserva")%>
                    </td>
                </tr></table>
            </td>
            <td align="right">
                <table border="0" cellpadding="0" cellspacing="1">
                <tr><td rowspan="2" align="right"><%=objIdioma.getTraduccionHTML("i_diasaplica")%>.</td>
                	<td><%=diascortos(1)%></td>
                    <td><%=diascortos(2)%></td>
                    <td><%=diascortos(3)%></td>
                    <td><%=diascortos(4)%></td>
                    <td><%=diascortos(5)%></td>
                    <td><%=diascortos(6)%></td>
                    <td><%=diascortos(7)%></td>
                    <td width="8">&nbsp;</td>
                </tr>
                <tr><td><input type="checkbox" value="L" name='L' <%if instr(diasemana,"L")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="M" name='M' <%if instr(diasemana,"M")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="X" name='X' <%if instr(diasemana,"X")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="J" name='J' <%if instr(diasemana,"J")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="V" name='V' <%if instr(diasemana,"V")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="S" name='S' <%if instr(diasemana,"S")<>0 then response.write "checked"%>></td>
                    <td><input type="checkbox" value="D" name='D' <%if instr(diasemana,"D")<>0 then response.write "checked"%>></td>
                    <td width="8">&nbsp;</td>
                </tr>
                </table>
            </td>
            </tr></table>
        
        </td>
	</tr>
	<tr>
		<td colspan="5" align='left'>
		
		<table border='0' cellpadding="0" cellspacing="0">
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_aplicaoferta")%>:</td>
				<td align='left'>
					<select name="aplicar" onChange="javascript:queAplica();">
						<option value="0" <%if aplicar=0 then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_todo")%></option>
						<option value="1" <%if aplicar=1 then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_preciohabi")%></option>
						<option value="2" <%if aplicar=2 then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_regimen")%></option>
					</select>
					(<%=objIdioma.getTraduccionHTML("i_textoaplicaroferta")%>)
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_tipohab")%>:</td>
				<td align='left'>
					<select name="habi">
						<option value="0"><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
						<%if hayhabis then
							for h=0 to ubound(RegHabis,2)
								marca=""
								if RegHabis(HaCodi,h)=clng(habi) then marca="selected"%>
								<option value="<%=RegHabis(HaCodi,h)%>" <%=marca%>><%=RegHabis(HaNombre,h)%></option>
							<%next
						end if%>
					</select>
					(<%=objIdioma.getTraduccionHTML("i_cualquierhabitacion")%>)
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_regimen")%>:</td>
				<td align='left'>
					<select name="suple">
						<option value="0"><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
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
					(<%=objIdioma.getTraduccionHTML("i_cualquierregimen")%>)
				</td>
			</tr>
			<input type="hidden" name='colectivo' value='0'>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_estanciasuperior")%>:</td>
				<td align='left'>
					<input type="text" name="noches" size="3" maxlength="3" value="<%=noches%>">
					&nbsp;<%=objIdioma.getTraduccionHTML("i_noches")%>. (<%=objIdioma.getTraduccionHTML("i_realizaoferta")%>)
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_diasAntelacion")%>:</td>
				<td align='left'>
					<input type="text" name="diasAdelanto" size="3" maxlength="3" value="<%=diasAntelacion%>">
					&nbsp;<%=objIdioma.getTraduccionHTML("i_dias")%>.
				</td>
			</tr>
			<tr>
				<td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_laofertaes")%>:</td>
				<td align='left'>
					<input type="text" name="dto" size="6" maxlength="6" value="<%=dto%>">&nbsp;%
					&nbsp;&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_o")%>&nbsp;
					<input type="text" name="precio" size="6" maxlength="7" value="<%=precio%>"><%=monedaHotel%>
					&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_o")%>&nbsp;
					<input type="text" name="nochesgratis" size="3" maxlength="3" value="<%=nochesgratis%>">&nbsp;<%=objIdioma.getTraduccionHTML("i_nochesgratis")%>.
					<br>
					(<%=objIdioma.getTraduccionHTML("i_rellenarcampo")%>).
				</td>
			</tr>
			<tr><td align="right"><%=objIdioma.getTraduccionHTML("i_destacada")%>:</td>
				<td align="left"><input type="checkbox" value="1" name="destacada" <%if destacada then response.write "checked"%>></td>
			</tr>
			<tr><td align="right"><%=objIdioma.getTraduccionHTML("i_realizacalculo")%>:</td>
				<td align="left"><input type="checkbox" value="1" name="calcula" <%if calcula then response.write "checked"%>></td>
			</tr>
			<tr><td align="right"><%=objIdioma.getTraduccionHTML("i_activa")%>:</td>
				<td align="left"><input type="checkbox" value="1" name="activa" <%if activa then response.write "checked"%>></td>
			</tr>
		</table>
	</td></tr>
	<tr><td align='center' colspan='5'>
		<input id='boton' type='button' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" style='cursor:pointer'>	
		<input type='hidden' name='id' value='<%=laid%>'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();" style='cursor:pointer'></td></tr>
</table>

	</td>
  </tr>
</table>
<%if con_cms then %>
<div style="position:absolute; top:270px; right:15px; width:250px; height:auto; border:1px solid #999999" align="center">
    <%if foto<>"" then lafoto=rutaFotos & foto else lafoto="img/tr.gif"%>
    <img id='lafoto_0' border='1' src="<%=lafoto%>" style="max-width:200px; max-height:140px; margin-top:5px;"/><br/>
    <br/>
    <input name='foto_0' type="file" size='30' style='width:200px; height:17px;<%if miNivel>=TComercial then response.write "display:none"%>'>
    <br/><br>
</div>
<%end if%>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.titulo_<%=langPorDefecto%>.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
<!--<%=url%>-->