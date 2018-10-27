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

recarga=request.QueryString("recarga") 'id del frame flotante
laid=paClng(request.QueryString("id"))
est=paClng(request.QueryString("est"))

'Busca nombre hotel
cs="SELECT Nombre FROM " & precrs & "TipoHabitaNombres WHERE Id=" & laid
rs.open cs,base
if not rs.eof then
	nombreHabi=rs("nombre")
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
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	recargaFrame('<%=recarga%>');
	top.quitaFlota(self.name);
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
<div id='tituloFicha' class="tituloFicha">
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_habitacion"))%> -> <%=nombreHabi%></div>
	<div id='laX' class="laX"></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="18" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div id='secciones' style="height:620px;">
	<%if laid<>0 then 'solo cuando ya está de alta, se ve la ficha entera%>
    	<div id='centro' style="margin-top:10px;">
        	<div id='solapasNew'>
			<!--Descomentar para solapas -->
				<!--<div id='solapaN1' class='laSolapaOverNew' onclick='javascript:cambiaCapa(1);'>
				<%=objIdioma.getTraduccionHTML("i_precios")%></div>
				<div id='solapaN2' class='laSolapaNew' onclick='javascript:cambiaCapa(2);'>
				<%=objIdioma.getTraduccionHTML("i_textosfotos")%></div>-->
			</div> <!-- solapas -->
			<div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosHabitacion.asp?idh=<%=laid%>&est=<%=est%>" class="frameConte sizeHabitacion" style="display:block"></iframe>
                <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="verCMSHabitacion.asp?idh=<%=laid%>&est=<%=est%>" class="frameConte sizeHabitacion"></iframe>
			</div> <!-- contenido -->
			
		</div> <!-- centro -->
  <%else 'para añadir%>
  
  		      <div id='solapasNew' style="margin-top:10px;">
				<div id='solapaN1' class='laSolapaOverNew'>
				<%=objIdioma.getTraduccionHTML("i_precios")%></div>
				<div id='solapaN2' class='laSolapaNew_nueva'>
				<%=objIdioma.getTraduccionHTML("i_textosfotos")%></div>
			</div> <!-- solapas -->
			<div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosHabitacion.asp?idh=<%=laid%>&est=<%=est%>" class="frameConte sizeHabitacion" style="display:block"></iframe>
			</div> <!-- contenido -->

	<%end if%>

</div> <!-- secciones -->
<script type="text/javascript">
	mialto=parseInt(document.body.offsetHeight,10);
	//alert(self.name);
	<%if esPlaneta then%>
	//alert(mialto);
	//if (es_IE) mialto=mialto+2;
	top.document.getElementById(self.name).style.height=(mialto+52)+"px";
	<%end if%>
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>