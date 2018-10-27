<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=paClng(request.QueryString("p"))

%><!--#include file="actuOfertaVIP.asp"--><%

laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "OfertasVIP "
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
	end if
	rs.close
end if

'Tabla de habitaciones
cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "TipoHabita "
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
cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "Regimen "
haysuples=false
rs.open cs,base
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
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
	top.frames['elFrame<%=ff%>'].location="ofertasVIP.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>&p=<%=pag%>&est=<%=est%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>&p=<%=pag%>&est=<%=est%>";

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

<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_oferta")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
		
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left'><%=objIdioma.getTraduccionHTML("i_titulo_esp")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_titulo_ita")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_titulo_ing")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_titulo_ale")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_titulo_fra")%>:</td>
	</tr>
	<tr>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_es%>' name="titulo_es"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_it%>' name="titulo_it"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_en%>' name="titulo_en"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_de%>' name="titulo_de"></td>
	<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=titulo_fr%>' name="titulo_fr"></td>
	</tr>
	<tr><td align='left'><%=objIdioma.getTraduccionHTML("i_texto_esp")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_texto_ita")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_texto_ing")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_texto_ale")%>:</td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_texto_fra")%>:</td>
	</tr>
	<tr>
	<td align='left'><textarea style="width:150px; height:100px" name='nombre_es'><%=nombre_es%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_it'><%=nombre_it%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_en'><%=nombre_en%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_de'><%=nombre_de%></textarea></td>
		<td align='left'><textarea style="width:150px; height:100px" name='nombre_fr'><%=nombre_fr%></textarea></td>
	</tr>
	<tr>
		<td align='left' valign="top"><%=objIdioma.getTraduccionHTML("i_fechainicio")%>: <input type="text" name="fini" value='<%=verFecha(fini)%>' style="width:75px" maxlength="12"><br/>
		<%=objIdioma.getTraduccionHTML("i_fcaduca")%>: <input type="text" name="fcaduca" value='<%=verFecha(fcaduca)%>' style="width:75px;" maxlength="12"></td>
		<td align='left' valign="top"><%=objIdioma.getTraduccionHTML("i_fechafinal")%>: <input type="text" name="ffin" value='<%=verFecha(ffin)%>' style="width:75px" maxlength="12"></td>
		<td align="right"></td>
		<td colspan="2" align="left">
		</td>
	</tr>
	<tr>
		<td colspan="5" align='left'>
		
		<table border='0' cellpadding="0" cellspacing="0">
			<input type="hidden" name='colectivo' value='0'>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_estanciasuperior")%>:</td>
				<td align='left'>
					<input type="text" name="noches" size="3" maxlength="3" value="<%=noches%>">
					&nbsp;<%=objIdioma.getTraduccionHTML("i_noches")%>. (<%=objIdioma.getTraduccionHTML("i_realizaoferta")%>)
				</td>
			</tr>
			<tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_laofertaes")%>:</td>
				<td align='left'>
					<input type="text" name="dto" size="3" maxlength="3" value="<%=dto%>">&nbsp;%
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
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.titulo_es.focus();
</script>
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>