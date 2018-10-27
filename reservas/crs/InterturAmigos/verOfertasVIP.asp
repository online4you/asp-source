<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../fechasCalendario.asp"-->
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

function estaHotel(cadena,hotel)
	busco=hotel & ", "
	if instr(cadena,busco)<>0 then
		estaHotel=true
	else
		estaHotel=false
	end if
end function

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))

%><!--#include file="actuOfertasVIP.asp"--><%
%><!--#include file="../monedaHotel.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
redim TexIdiomas(ubound(ListaIdiomas))
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT OfertasVIP.*,Idioma,Traduccion,Campo "
	cs=cs & "FROM " & precrs & "OfertasVIP OfertasVIP LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON OfertasVIP.Id=Traducciones.IdReferencia AND Tabla='OfertasVIP' "
	cs=cs & "WHERE OfertasVIP.Id=" & laid
	rs.open cs,base
	do while not rs.eof
		titulo=rs("titulo")
		texto=rs("texto")
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
		codpromocion=rs("CodigoPromocion")
		hoteles=rs("hoteles")
		ofertaSuple=rs("ofertaRegimen")
		
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

'Tabla de Suplementos
cs="SELECT Regimen.Id,ISNULL(Traduccion,Nombre) AS Tradu "
cs=cs & "FROM " & precrs & "Regimen Regimen LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "ORDER BY Regimen.Id"
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
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&est=<%=est%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&est=<%=est%>&recarga=<%=recarga%>";

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
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="post">
<input type="hidden" value="0" name="habi">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
		
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left' colspan="5"><%=objIdioma.getTraduccionHTML("i_promocion")%>:
		&nbsp;<input type="text" maxlength="25" style="width:100px" value='<%=codpromocion%>' name="codpromocion">
		&nbsp;<%=objIdioma.getTraduccionHTML("i_textopromocion")%>
		</td>
    <tr>
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
			<table cellpadding="0" cellspacing="0">
            <tr><td>
			<%=objIdioma.getTraduccionHTML("i_fechainicio")%>: <input type="text" name="fini" value='<%=verFecha(fini)%>' style="width:70px" maxlength="12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
            <%=objIdioma.getTraduccionHTML("i_fechafinal")%>: <input type="text" name="ffin" value='<%=verFecha(ffin)%>' style="width:70px" maxlength="12"><br/>
            <%=objIdioma.getTraduccionHTML("i_fcaduca")%>: <input type="text" name="fcaduca" value='<%=verFecha(fcaduca)%>' style="width:70px;" maxlength="12"></td>
            <td align='left' valign="top" width="50">&nbsp;</td>
            <td align="right"><%=objIdioma.getTraduccionHTML("i_diasaplica")%>.</td>
            <td align="left">
                <table border="0" width="100%" cellpadding="0" cellspacing="1">
                <tr><td><%=diascortos(1)%></td>
                    <td><%=diascortos(2)%></td>
                    <td><%=diascortos(3)%></td>
                    <td><%=diascortos(4)%></td>
                    <td><%=diascortos(5)%></td>
                    <td><%=diascortos(6)%></td>
                    <td><%=diascortos(7)%></td>
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
            </tr></table>
        
        </td>
	</tr>
	<tr>
		<td colspan="5" align='left'>
		
		<table border='0' cellpadding="0" cellspacing="0" style="float:left; width:540px">
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
				<td align='right'>Oferta régimen:</td>
				<td align='left'>
					<select name="ofertasuple">
						<option value="0">No se usa</option>
						<%if haysuples then
							for h=0 to ubound(RegSuples,2)
								marca=""
								if RegSuples(SCodi,h)=ofertasuple then marca=" selected"%>
								<option value="<%=RegSuples(SCodi,h)%>"<%=marca%>><%=RegSuples(SNombre,h)%></option>
							<%next
						end if%>
					</select>
					(oferta el regimen de arriba con el precio de este) 
				</td>
			</tr>
			<tr>
				<td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_laofertaes")%>:</td>
				<td align='left'>
					<input type="text" name="dto" size="6" maxlength="6" value="<%=dto%>">&nbsp;%
					&nbsp;&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_o")%>&nbsp;
					<input type="text" name="precio" size="6" maxlength="7" value="<%=precio%>"><%=monedaHotel%>
					&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_o")%>&nbsp;
					<input type="text" name="nochesgratis" size="3" maxlength="3" value="<%=nochesgratis%>">&nbsp;<%=objIdioma.getTraduccionHTML("i_nochesgratis")%>.<br/>
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
        <div style="float:right; width:250px; height:160px; overflow:hidden; border:1px solid #333">
        	<p class="tituloFicha" style="margin:0px; height:20px">HOTELES A LOS QUE SE APLICA</p>
            <div style="overflow-y:scroll; overflow-x:hidden; height:135px">
            <%if hayhoteles then
            for h=0 to ubound(RegHoteles,2)%>
            <input type="checkbox" name="hoteles" value="<%=RegHoteles(HCodi,h)%>"<%if estaHotel(hoteles,RegHoteles(HCodi,h)) then response.write " checked"%>><%=RegHoteles(HNombre,h)%><br>
            <%next
            end if%>
            </div>
       </div>
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
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.titulo_<%=langPorDefecto%>.focus();
</script>
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>