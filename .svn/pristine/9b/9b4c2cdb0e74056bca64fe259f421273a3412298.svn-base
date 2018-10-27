<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga")
laid=paClng(request.QueryString("id"))
ide=paClng(request.QueryString("ide"))

%><!--#include file="actuSizeGraficos.asp"--><%

if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * "
	cs=cs & "FROM " & precrs & "SizeGraficos WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		ancho=rs("ancho")
		alto=rs("alto")
		prefijo=rs("prefijo")
		pancho=rs("proporcionancho")
		palto=rs("proporcionalto")
	end if
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
		document.f1.action="<%=MiPag%>?modo=nuevo&ide=<%=ide%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&ide=<%=ide%>&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">Tama&ntilde;o grafico</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right'>Ancho:</td>
		<td align='left'><input type='text' style='width:30px' maxlength='5' name='ancho' value='<%=ancho%>'></td>
    </tr>
	<tr><td align='right'>Alto:</td>
		<td align='left'><input type='text' style='width:30px' maxlength='5' name='alto' value='<%=alto%>'></td>
    </tr>
	<tr><td align='right'>Prefijo:</td>
		<td align='left'><input type='text' style='width:100px' maxlength='15' name='prefijo' value='<%=prefijo%>'></td>
    </tr>
	<tr><td align='right'>Mantiene ancho:</td>
		<td align='left'><input type="checkbox" style='border:none' name='pancho' value='1'<%if pancho then response.write " checked"%>></td>
    </tr>
	<tr><td align='right'>Mantiene alto:</td>
		<td align='left'><input type="checkbox" style='border:none' name='palto' value='1'<%if palto then response.write " checked"%>></td>
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
	document.f1.ancho.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
