<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript">
var solapaActiva=0;
function cambiaCapa(esa){
	if (solapaActiva!=0) {
		document.getElementById("elFrame_"+solapaActiva).style.zIndex=10;
		document.getElementById("elFrame_"+esa).style.zIndex=20;
		activaSolapa(esa);
	} else {
		document.getElementById("elFrame_"+esa).style.zIndex=20;
		activaSolapa(esa);
	}
}

function activaSolapa(cuala){
	//la anterior
	if (solapaActiva!=0)
		document.getElementById("solapa"+solapaActiva).className="laSolapa";

	document.getElementById("solapa"+cuala).className="laSolapaOver";
	solapaActiva=cuala;
	
	//LINEA SOLAPA
	elLeft=dameLeft(document.getElementById('solapa'+solapaActiva))-191; //191px del menu izq
	elAncho=document.getElementById('solapa'+solapaActiva).offsetWidth;
	elAlto=document.getElementById('solapa'+solapaActiva).offsetHeight;
	document.getElementById('lineaSolapa').style.top='22px';
	document.getElementById('lineaSolapa').style.left=elLeft+"px";
	document.getElementById('lineaSolapa').style.width=(elAncho-2)+"px";	
	document.getElementById('lineaSolapa').style.visibility='visible';
}

</script>
<style type="text/css">
.fichaCapa {
	position:absolute;
	z-index:10;
	top:0px;
	overflow:hidden;
	margin:0px;
	background-color:#F2F2F2;
	width:770px;
	height:520px;
	/*border:1px solid #ff0000;*/
}
</style>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>

		<div id='centro'>
			<div id='solapas'>
				<div id='solapa1' class='laSolapa' onclick='javascript:cambiaCapa(1);'>
				<div class='tituSolapa'>Por Importes</div></div>
				<div id='solapa2' class='laSolapa' onclick='javascript:cambiaCapa(2);'>
				<div class='tituSolapa'>Por Nº Reservas</div></div>
				<div id='solapa3' class='laSolapa' onclick='javascript:cambiaCapa(3);'>
				<div class='tituSolapa'>Por Idiomas</div></div>
				<div id='solapa4' class='laSolapa' onclick='javascript:cambiaCapa(4);'>
				<div class='tituSolapa'>Estancia media</div></div>
				<div id='solapa5' class='laSolapa' onclick='javascript:cambiaCapa(5);'>
				<div class='tituSolapa'>Importe medio</div></div>
			</div>
			<div id='contenido'>
				<iframe id='elFrame_1' name='elFrame_1' frameborder='0' hspace='0' vspace='0' src='EstadisticaGAnyPelas.asp?est=<%=est%>' class='fichaCapa'></iframe>
				<iframe id='elFrame_2' name='elFrame_2' frameborder='0' hspace='0' vspace='0' src='' class='fichaCapa'></iframe>
				<iframe id='elFrame_3' name='elFrame_3' frameborder='0' hspace='0' vspace='0' src='' class='fichaCapa'></iframe>
				<iframe id='elFrame_4' name='elFrame_4' frameborder='0' hspace='0' vspace='0' src='' class='fichaCapa'></iframe>
				<iframe id='elFrame_5' name='elFrame_5' frameborder='0' hspace='0' vspace='0' src='' class='fichaCapa'></iframe>
			</div>
			<div id='lineaSolapa'></div>
			
		</div> <!-- centro -->

</div> <!-- iframePrincipal -->

<script language="javascript" type="text/javascript">
cambiaCapa(1);
</script>
</body>
</html>
