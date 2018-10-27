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

%><!--#include file="actuGrupo.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT GrupoCaracteristicas.Id,Nombre,Orden,Destacada,Idioma,Traduccion "
	cs=cs & "FROM " & precrs & "GrupoCaracteristicas GrupoCaracteristicas LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON GrupoCaracteristicas.Id=Traducciones.IdReferencia "
	cs=cs & "AND Tabla='GrupoCaracteristicas' AND Campo='Nombre' WHERE GrupoCaracteristicas.Id=" & laid
	rs.open cs,base
	if not rs.eof then
		do while not rs.eof
			TIdiomas(0)=rs("Nombre")
			destacada=rs("destacada")
			orden=rs("orden")
			for idi=1 to ubound(ListaIdiomas)
				if ListaIdiomas(idi)=rs("idioma") then 'este
					TIdiomas(idi)=rs("traduccion")
					exit for
				end if
			next 'idi
			
			rs.movenext
		loop
	end if 'eof
	rs.close
end if

'response.write "Id:" & laid & " - es:" & caracter
'for idi=1 to ubound(listaIdiomas)
'	response.write " - " & listaIdiomas(idi) & ":" & TIdiomas(idi)
'next

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
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_grupocaracter")%> -> <%=TIdiomas(0)%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
    <%for idi=0 to ubound(listaIdiomas)%>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>:</td>
		<td align='left'><input type='text' size='30' maxlength='75' name='nombre_<%=listaIdiomas(idi)%>' value='<%=TIdiomas(Idi)%>'></td>
	</tr>
    <%next 'idi%>
    <tr><td align='right'><%=objIdioma.getTraduccionHTML("i_ordenvisual")%>:</td>
		<td align='left'><input type='text' style='width:30px' maxlength='5' name='orden' value='<%=orden%>'></td>
	</tr>
    <tr><td align='right'><%=objIdioma.getTraduccionHTML("i_destacada")%>:</td>
		<td align='left'>
        <input type="checkbox" style='border:none' name='destacada' value='1'<%if destacada then response.write " checked"%>></td>
	</tr>
    <tr><td colspan="2"></td></tr>
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
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.nombre_<%=langPorDefecto%>.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
