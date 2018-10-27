<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

%>
<!--#include file="actuTarifa.asp"-->

<%
laid=request.QueryString("id")
if laid<>"" then 'Busco el registro para modificar
	cs="SELECT * FROM Tarifas "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre_es=rs("nombre_es")
		nombre_it=rs("nombre_it")
		nombre_en=rs("nombre_en")
		nombre_de=rs("nombre_de")
		nombre_fr=rs("nombre_fr")
	end if
	rs.close

else 'añadir nueva
	
	'tabla de tarifas existentes
	cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "Tarifas"
	rs.open cs,base
	haytarifas=false
	if not rs.eof then
		RegTarifas=rs.getrows
		TCodi=0
		TNombre=1
		haytarifas=true
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
	/*encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';*/
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['elFrame<%=ff%>'].location="Tarifas.asp";
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
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_tarifa")%> -> <%=nombre_es%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right' width="110"><%=objIdioma.getTraduccionHTML("i_nombre_esp")%>:</td>
		<td align='left'><input type='text' style='width:280px;' maxlength='50' name='nombre_es' value='<%=nombre_es%>'></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_nombre_ita")%>:</td>
		<td align='left'><input type='text' style='width:280px;' maxlength='50' name='nombre_it' value='<%=nombre_it%>'></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_nombre_ing")%>:</td>
		<td align='left'><input type='text' style='width:280px;' maxlength='50' name='nombre_en' value='<%=nombre_en%>'></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_nombre_ale")%>:</td>
		<td align='left'><input type='text' style='width:280px;' maxlength='50' name='nombre_de' value='<%=nombre_de%>'></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_nombre_fra")%>:</td>
		<td align='left'><input type='text' style='width:280px;' maxlength='50' name='nombre_fr' value='<%=nombre_fr%>'></td></tr>
	<%if laid="" then 'esta haciendo una nueva%>
	<tr><td colspan='2' height="10"></td></tr>
	<tr><td align='right'></td>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_textonuevatarifa")%></td></tr>
	<tr><td align='right'></td>
		<td align='left'>
		<select name="laTarifa">
		<%if haytarifas then
		for t=0 to ubound(RegTarifas,2)%>
		<option value="<%=RegTarifas(TCodi,t)%>"><%=RegTarifas(TNombre,t)%></option>
		<%next
		end if%>
		</select>
		</td></tr>
	<tr><td align='right'></td>
		<td align='left'><input type="text" style="width:30px" value="0" name="margen"/> % sobre la tarifa (valor negativo descuenta sobre la tarifa)
		</td></tr>
	<%end if%>
	<tr><td colspan='2' height="10"></td></tr>
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
	<%if laid="" then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.nombre_es.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
