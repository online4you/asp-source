<!--#include file="../includes/FunGestion.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="<%=relative_url%>/js/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>/js/moverFrames.js"></script>
</head>
<body>
<div>
	<div style="float:left; width:193px; overflow:hidden; margin-top:92px;"><!--#include file="botonera.asp"--></div>
	<div id='centro'>
		<div id='solapas'></div>
		<div id='contenido'></div>
		<div id='lineaSolapa'></div>
	</div>
</div>
<div id='capaFrames'></div>
<div id='chivato'></div>
<iframe id='verCalendario' name="verCalendario" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<iframe id='paCookies' name="paCookies" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<script language="javascript" type="text/javascript">
	//carga por defecto
	creaFrame("listaClientes.asp","Clientes");
</script>
</body>
</html>