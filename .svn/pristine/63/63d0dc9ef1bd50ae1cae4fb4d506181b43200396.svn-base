<!--#include file="../includes/FunGestion.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="../includes/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="../includes/moverFrames.js"></script>
</head>
<body>
<div>
	<div style="float:left; width:193px; overflow:hidden; margin-top:92px;"><!--#include file="botonera.asp"--></div>
	<div id='centro'>
		<div id='solapas'></div>
		<div id='contenido'>
			<%'lista de iframes por ahora dejaremos 10
			for t=1 to 7%>
				<iframe id='elFrame<%=t%>' name='elFrame<%=t%>' frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='fichaIframe'></iframe>
			<%next%>
		</div>
		<div id='lineaSolapa'></div>
	</div>
</div>
<div id='capaFrames'>
	<%'lista de ventanitas iframes flotantes por ahora 10
	for t=1 to 10%>
	<iframe id='verFicha<%=t%>' name="verFicha<%=t%>" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
	<%next%>
</div>
<div id='chivato'></div>
<iframe id='verCalendario' name="verCalendario" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<script language="javascript" type="text/javascript">
	//carga por defecto
	cargaFrame("fichas.asp","Fichas VIP");
</script>
</body>
</html>