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

recarga=request.QueryString("recarga") 'id del frame de la ventana

%><!--#include file="actuTiposMoneda.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
laid=request.QueryString("id")
if laid<>"" then 'Busco el registro para modificar
	cs="SELECT TiposMoneda.Id,Nombre,Orden,CodigoISO,PorDefecto,Idioma,Traduccion FROM " & precrs & "TiposMoneda TiposMoneda LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON TiposMoneda.Id=Traducciones.IdReferencia "
	cs=cs & "AND Tabla='TiposMoneda' AND Campo='Nombre' WHERE TiposMoneda.Id=" & laid
	rs.open cs,base
	do while not rs.eof
		TIdiomas(0)=rs("nombre")
		orden=rs("orden")
		codiso=rs("codigoISO")
		pdefecto=rs("PorDefecto")
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
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esta ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_moneda")%> -> <%=nombre_es%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="post">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_codigoiso")%>:</td>
		<td align='left'><input type='text' size='3' maxlength='3' name='codiso' value='<%=codiso%>'></td></tr>
    <%for idi=0 to ubound(listaIdiomas)%>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>:</td>
		<td align='left'><input type='text' size='30' maxlength='75' name='nombre_<%=listaIdiomas(idi)%>' value='<%=TIdiomas(Idi)%>'></td>
	</tr>
    <%next 'idi%>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_orden")%>:</td>
		<td align='left'><input type='text' size='3' maxlength='3' name='orden' value='<%=orden%>'></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_pordefecto")%>:</td>
		<td align='left'><input type='checkbox' name='pdefecto' value='1'<%if pdefecto then response.write " checked"%>></td></tr>
	<tr><td align='center' colspan='2'>
	<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>">
    </td></tr>    
    </table>

	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid="" then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.codiso.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
