<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="../js/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="../js/moverFrames.js"></script>
</head>
<body>
<div>
	<div style="float:left; width:193px; overflow:hidden; margin-top:92px;"><!--#include file="botonera.asp"--></div>
	<div id='centro'>
		<div id='solapas'></div>
		<div id='contenido'></div>
	</div>
</div>
<div id='capaFrames'></div>
<iframe id='paCookies' name="paCookies" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<script language="javascript" type="text/javascript">
	//carga por defecto
	<%if paClng(request.Cookies("nivelCR"))=TAgencia then%>
		creaFrame("reservas_agencias.asp?lang=<%=lang%>","Reservas");
	<%else%>
		creaFrame("fichas.asp?lang=<%=lang%>","Agencias");
	<%end if%>
</script>
<%set objIdioma=nothing%>
</body>
</html>