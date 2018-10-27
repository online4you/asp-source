<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

laid=paClng(request.QueryString("idh")) 'id habitacion
est=paClng(request.QueryString("est"))

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript">
function cerrar(){
	parent.cerrar();
}
var solapaActiva=1;
function cambiaCapa(esa){
	activaSolapa(esa);
}

function activaSolapa(cuala){
	//la anterior
	if (solapaActiva!=0) {
		$("solapaN"+solapaActiva).className="laSolapaNew";
		$("frame"+solapaActiva).style.display='none';
	}
	$("solapaN"+cuala).className="laSolapaOverNew";
	$("frame"+cuala).style.display='block';
	solapaActiva=cuala;
	
}
</script>
</head>
<body class="laFicha">
    <div id='solapasNew2' style="margin-top:10px;">
        <div id='solapaN1' class="laSolapaOverNew" onClick="javascript:cambiaCapa(1);">
        <%=objIdioma.getTraduccionHTML("i_texto")%></div>
        <div id='solapaN2' class="laSolapaNew" onClick="javascript:cambiaCapa(2);">
        <%=objIdioma.getTraduccionHTML("i_fotos")%></div>
    </div>

  <div id='contenidoNew'> 
    <iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verTextosHabitacion.asp?idh=<%=laid%>&est=<%=est%>" class="frameConte sizeHabitacion" style="display:block; width:976px; height:520px"></iframe>
    <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="verFotosHabitacion.asp?idh=<%=laid%>&est=<%=est%>" class="frameConte sizeHabitacion" style="width:976px; height:520px"></iframe>
  </div>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
