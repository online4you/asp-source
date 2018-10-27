<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

dim TIdiomas() 'texto traduccion

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga")
laid=paClng(request.QueryString("id"))
est=paClng(request.QueryString("idh"))

%><!--#include file="actuSeccion.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT SeccionesHotel.Id,Seccion,Orden,Idioma,Traduccion "
	cs=cs & "FROM " & precrs & "SeccionesHotel SeccionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON SeccionesHotel.Id=Traducciones.IdReferencia "
	cs=cs & "AND Tabla='SeccionesHotel' AND Campo='Seccion' WHERE SeccionesHotel.Id=" & laid
	rs.open cs,base
	 
	do while not rs.eof
		Nombre_es=rs("seccion")
		orden=rs("orden")
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=rs("idioma") then 'este
				TIdiomas(idi)=rs("traduccion")
				exit for
			end if
		next 'idi
		
		rs.movenext
	loop
	rs.close
end if

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
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	url=top.frames['<%=recarga%>'].location;
	top.frames['<%=recarga%>'].location=url; //para que no pida confirmacion
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&idh=<%=est%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&idh=<%=est%>&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_seccion")%> -> <%=Nombre_es%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_seccion")%>:</td>
		<td align='left'><input type='text' size='30' maxlength='75' name='nombre_<%=langPorDefecto%>' value='<%=Nombre_es%>'></td></tr>
    <%for idi=1 to ubound(listaIdiomas)%>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>:</td>
		<td align='left'><input type='text' size='30' maxlength='75' name='nombre_<%=listaIdiomas(idi)%>' value='<%=TIdiomas(Idi)%>'></td>
	</tr>
    <%next 'idi%>
    <tr><td align="right"><%=objIdioma.getTraduccionHTML("i_orden")%>:</td>
    	<td><input type='text' style='width:30px' maxlength='5' name='orden' value='<%=orden%>'>
        </td>
    </tr>
	<tr><td align='center' colspan='2'>
	<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>"></table>

	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.nombre_<%=langPorDefecto%>.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
