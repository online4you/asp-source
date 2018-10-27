<!--#include file="includes/FunGestion.asp"-->
<%
set base2=server.createobject("ADODB.Connection")
base2.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

laid=request.QueryString("id")
busco=request.QueryString("buscoh")
if busco="" then busco=request.Form("buscoh")

'Tabla de Hoteles
cs="SELECT CodigoEsta,Nombre FROM Establecimientos "
if busco<>"" then
	cs=cs & "WHERE Nombre LIKE '%" & busco & "%'"
end if
cs=cs & " ORDER BY Nombre"
rs.open cs,base2
hayhotel=false
if not rs.eof then
	RegHotel=rs.getrows
	HCodi=0
	HNombre=1
	hayhotel=true
end if
rs.close

set rs=nothing
base2.close
set base2=nothing
%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	encogeCapa(parent.document.getElementById('verBHotel'));
	parent.document.getElementById('verBHotel').style.visibility='hidden';
}
function buscaHotel(){
	document.f1.submit();
}
function cargaHotel(ese){
	top.document.getElementById('verFicha').src="verUsuario.asp?id=<%=laid%>&bh="+ese;
	cerrar();
}
function elIntro(oEvento){
     var iAscii;
     if (oEvento.keyCode)
         iAscii = oEvento.keyCode;
     else if (oEvento.which)
         iAscii = oEvento.which;

     if (iAscii == 13) buscaHotel();
}
</script>
<body class='laFicha'>
<form name='f1' action="<%=MiPag%>?id=<%=laid%>" method="POST">
<div class="tituloFicha" onmousedown="pulsada(top.document.getElementById('verBHotel'))" onmouseup="javascript:top.liberaCapa();" onDblClick="javascript:cambiaForma();">
	<div class="nombreFicha">BUSCAR HOTEL</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div style="clear:both; margin-top:10px;">
<input name="buscoh" type="text" maxlength="50" style="width:200px; float:left;" onKeyPress="javascript:elIntro(event);" value="<%=busco%>">
<input type="button" value="Buscar hotel" style="float:left; margin-left:10px; margin-top:0px;" onClick="javascript:buscaHotel();" class="boton145">
</div>
<div id='cajaFicha' style="height:235px;">
	<div style="clear:both">
		<div style="float:left; width:50px;" class="colu_impar" align="right">Codigo&nbsp;</div>
		<div style="float:left; margin-left:5px; width:260px;" class="colu_par">&nbsp;Establecimiento</div>
	</div>
<%if hayhotel then
	for h=0 to ubound(RegHotel,2)
		if (h mod 2)=0 then
			estilo="fila_par"
		else 
			estilo="fila_impar"
		end if%>
	<div style="clear:both">
		<div style="float:left; width:50px;" class='<%=laColu(0)%>' align="right"><%=RegHotel(HCodi,h)%>&nbsp;</div>
		<div style="float:left; margin-left:5px; width:260px;" class='<%=laColu(1)%>'>
		<a href="javascript:cargaHotel(<%=RegHotel(HCodi,h)%>);">&nbsp;<%=RegHotel(HNombre,h)%></a></div>
	</div>
	<%next
else
	response.write "<div>Hoteles no encontrados en esa búsqueda</div>"
end if%>
</div>
</form>
<script language="javascript" type="text/javascript">
	document.f1.buscoh.focus();
</script>
</body>
</html>