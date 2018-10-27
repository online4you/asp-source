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

'Busca nombre hotel
cs="SELECT Nombre FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & laid
rs.open cs,base
if not rs.eof then
	nombreHotel=rs("nombre")
end if
rs.close

'Secciones del hotel
cs="SELECT Id,Seccion,Orden FROM " & precrs & "SeccionesHotel "
cs=cs & "WHERE CodigoEsta=" & laid & " ORDER BY Orden"
rs.open cs,base
haySecci=false
if not rs.eof then
	RegSecci=rs.GetRows
	RsCodi=0
	RsNombre=1
	RsOrden=2
	haySecci=true
end if
rs.close

'Comprobar si hay caracteristicas de alta
cs="SELECT Id FROM " & precrs & "Caracteristicas limit 1 "
rs.open cs,base
hayCaracter=false
if not rs.eof then
	hayCaracter=true
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
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner el iframe flotante a cerrar
	top.quitaFlota(self.name);
}

function gestionSecciones(){
	SetCookie("cambioSecci","0",null,"/"); //para controlar si cambia datos
	top.creaFlotante("seccionesHotel.asp?idh=<%=laid%>&recarga="+self.name,470,280,0,0);
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
	//alert(frames["frame"+cuala].estaVisible());
	if (cuala==2) { //google Maps
		setTimeout('frames["frame'+cuala+'"].centra()',500);
	}
}

</script>
<body class="laFicha">
<div id='tituloFicha' class="tituloFicha">
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_alojamiento"))%> -> <%=nombreHotel%></div>
	<div id='laX' class="laX"></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="18" height="17" class="Minimizar" alt="Minimizar" />
</div>
<!--CAMBIADO JAVI PARA AMPLIAR EL ALTO DE LA PESTAÑA GOOGLE MAPS POR INCIDENCIA BABELOO AUNQUE AFECTA A TODO-->
<div id='secciones' style="height:610px;">
	<%if laid<>0 then 'solo cuando ya está de alta, se ve la ficha entera%>
    	<%if miNivel<TComercial then 'con acceso%>
	<a href="javascript:gestionSecciones();" class="enlaceLista" style="margin-top:0px; float:right">
	<b><%=objIdioma.getTraduccionHTML("i_gestionsecciones")%>&nbsp;</b></a>
    	<%end if 'miNivel%>
    	<div id='centro' style="margin-top:10px;">
        	<div id='solapasNew'>
				<div id='solapaN1' class='laSolapaOverNew' onclick='javascript:cambiaCapa(1);'>
				<%=objIdioma.getTraduccionHTML("i_datoshotel")%></div>
                <%if miNivel<TComercial then 'con acceso%>
                <%if con_googlemaps then 'pos eso%>
				<div id='solapaN2' class='laSolapaNew' onclick='javascript:cambiaCapa(2);'>
				Google Maps</div>
                <%end if 'googlemaps
				if hayCaracter then 'caracteristicas%>
				<div id='solapaN3' class='laSolapaNew' onclick='javascript:cambiaCapa(3);'>
				<%=objIdioma.getTraduccionHTML("i_caracter")%></div>
                <%end if 'hayCaracter%>
				<%if haySecci then
				for s=0 to ubound(RegSecci,2)%>
                <div id='solapaN<%=s+4%>' class='laSolapaNew' onclick='javascript:cambiaCapa(<%=s+4%>);'>
				<%=RegSecci(RsNombre,s)%></div>
				<%next
				end if%>
                <%end if 'miNivel%>
			</div> <!-- solapas -->
			<div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosHotel.asp?idh=<%=laid%>&recarga=<%=recarga%>" class="frameConte sizeAlojamiento" style="display:block"></iframe>
                <%if miNivel<TComercial then 'con acceso%>
                <%if con_googlemaps then%>
                <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="verMapaGoogle.asp?idh=<%=laid%>" class="frameConte sizeAlojamiento"></iframe>
                <%end if 'googlemaps
				if hayCaracter then %>
                <iframe id='frame3' name='frame3' frameborder="0" hspace="0" vspace="0" src="verCaracterHotel.asp?idh=<%=laid%>" class="frameConte sizeAlojamiento"></iframe>
                <%end if 'haycaracter%>
                <%if haySecci then
                for s=0 to ubound(RegSecci,2)%>
                    <iframe id='frame<%=s+4%>' name='frame<%=s+4%>' frameborder="0" hspace="0" vspace="0" src="verSeccionHotel.asp?id=<%=RegSecci(RsCodi,s)%>&idh=<%=laid%>" class="frameConte sizeAlojamiento"></iframe>
                <%next
                end if%>
                <%end if 'miNivel%>
			</div> <!-- contenido -->
			
		</div> <!-- centro -->
  <%else 'para añadir%>
  
  		   <!--   <div id='solapasNew' style="margin-top:20px;">
				<div id='solapaN1' class='laSolapaOverNew'>
				<%=objIdioma.getTraduccionHTML("i_datoshotel")%></div>
                <%if con_googlemaps then 'pos eso%>
				<div id='solapaN2' class='laSolapaNew_nueva'>
				Google Maps</div>
                <%end if 'googlemaps
				if hayCaracter then 'caracteristicas%>
				<div id='solapaN3' class='laSolapaNew_nueva'>
				<%=objIdioma.getTraduccionHTML("i_caracter")%></div>
                <%end if 'hayCaracter%>
			</div> --><!-- solapas -->
			<!-- <div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosHotel.asp?id=<%=laid%>&recarga=<%=recarga%>" class="frameConte sizeAlojamiento" style="display:block"></iframe>
			</div> --><!-- contenido -->

	<%end if%>

</div> <!-- secciones -->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>