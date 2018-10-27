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

laid=paClng(request.QueryString("id"))
idh=paClng(request.QueryString("idh"))

cs="SELECT Seccion FROM " & precrs & "SeccionesHotel WHERE Id=" & laid
rs.open cs,base
if not rs.eof then
	nombreSeccion=rs("seccion")
end if
rs.close


set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.cerrar();
}
<%if pasalir=1 then%>
	cerrar();
<%end if%>

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
<body class="laFicha">
    <div id='centro' style="margin-top:10px;">
        <div id='solapasNew' style="width:965px">
            <div id='solapaN1' class='laSolapaOverNew' onclick='javascript:cambiaCapa(1);'>
            <%=objIdioma.getTraduccionHTML("i_textoseccion")%></div>
            <div id='solapaN2' class='laSolapaNew' onclick='javascript:cambiaCapa(2);'>
            <%=objIdioma.getTraduccionHTML("i_fotoseccion")%></div>
            <p style="margin-top:5px; font-weight:bold">&nbsp;--> <%=nombreSeccion%></p>
        </div> <!-- solapas -->
        <div id='contenidoNew'>
            <iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="datosSeccionHotel.asp?ids=<%=laid%>&idh=<%=idh%>" class="frameConte SubsizeAlojamiento" style="display:block"></iframe>
            <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="fotosSeccionHotel.asp?ids=<%=laid%>&idh=<%=idh%>" class="frameConte SubsizeAlojamiento"></iframe>
        </div> <!-- contenido -->
    </div> <!-- centro -->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
