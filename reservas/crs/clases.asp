<!--#include file="includes/FunGestion.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="includes/losFrames.js"></script>

</head>
<body>
<input type="button" value="carga frame" onClick="carga();">
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="capaIframe"></iframe>
<script language="javascript">
function carga(){
	miImg=new Image();
	miFrame= new Object();
	//miFrame= new Iframe();
	miFrame.name="xoco";
	alert(miFrame.name);
	alert(miFrame.typeof);
	miFrame.src="http://www.google.com";
	//miFrame.style.visibility='visible';

}
</script>

</body>
</html>