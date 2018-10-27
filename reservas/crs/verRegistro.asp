<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT Id,Registro.Nombre as elusu,Fecha,Proceso,Establecimientos.Nombre as elhotel "
	cs=cs & "FROM " & precrs & "Registro Registro LEFT JOIN " & precrs & "Establecimientos Establecimientos "
	cs=cs & "ON Registro.CodigoEsta=Establecimientos.CodigoEsta "
	cs=cs & "WHERE Id=" & laid
	'response.write cs
	rs.open cs,base
	if not rs.eof then
		elusu=rs("elusu")
		fecha=rs("fecha")
		proceso=rs("proceso")
		elhotel=rs("elhotel")
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
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">REGISTRO MOVIMIENTOS</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST"> 
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">

      <table width='100%' border='0' align='center' cellpadding="0" cellspacing="2">
      <tr>
			<td align='right'>Usuario:</td>
			<td align='left'><%=elusu%></td>
		</tr>
		  <tr>
			<td align='right'>Hotel:</td>
			<td align='left'><%="" & elhotel%></td>
		</tr>
		  <tr>
			<td align='right' valign="top">Proceso:</td>
			<td align='left' valign="top" height="60">
			<div style="overflow:auto; width:350px; height:185px"><%=proceso%></div></td>
		</tr>
      <tr>
        <td align='center' colspan='2'>
      <input name="button3" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
      </tr>
    </table>
	</td></tr>
</table>
</form>
</div>
</body>
</html>