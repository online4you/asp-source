<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuFicha.asp"--><%

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
laid=paClng(request.QueryString("id"))
if laid<>0 then 
	'Buscar datos cliente
	cs="SELECT * FROM " & precrs & "Fichas WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		tele=rs("telefono")
		email=rs("email")
		movil=rs("movil")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		cp=rs("cp")
		pais=rs("Pais")
		codigoVIP=rs("codigoVIP")
		obs=rs("observaciones")
		publicidad=rs("informacion")
		fechanac=rs("fechanac")
		idiomaweb=rs("IdiomaWeb")
		fechaAlta=rs("fechaalta")
		activo=rs("activo")
		beneficiario1=rs("beneficiario1")
		tfamilia1=rs("tfamilia1")
		fechanac1=rs("fechanac1")
		beneficiario2=rs("beneficiario2")
		tfamilia2=rs("tfamilia2")
		fechanac2=rs("fechanac2")
		beneficiario3=rs("beneficiario3")
		tfamilia3=rs("tfamilia3")
		fechanac3=rs("fechanac3")
	end if
	rs.close

else 'busco el nuevo registro

	cs="SELECT MAX(CONVERT(int,CodigoVIP)) AS Ulti FROM " & precrs & "Fichas"
	rs.open cs,base
	if not rs.eof then
		codigoVIP=paClng(rs("ulti"))+1
	end if
	rs.close
	
end if

	
set rs=nothing
base.close
set base=nothing

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla Paises
cs="SELECT IdCountry,CountryName FROM " & precrs & "tbl_Paises WHERE IdLanguage='es'"
rs.open cs,base
haypais=false
if not rs.eof then
	RegPais=rs.getrows
	PCodi=0
	PNombre=1
	hayPais=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="fichas.asp?p=<%=pag%>";
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
	//alert(frames["frame"+cuala].estaVisible());
	if (cuala==2) { //google Maps
		setTimeout('frames["frame'+cuala+'"].centra()',500);
	}
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">FICHA AMIGO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div id='secciones' style="height:470px;">
	<%if laid<>0 then 'solo cuando ya está de alta, se ve la ficha entera%>
    	<div id='centro' style="margin-top:10px;">
        	<div id='solapasNew' style="width:690px;">
				<div id='solapaN1' class='laSolapaOverNew' onclick='javascript:cambiaCapa(1);'>
				Datos Ficha Amigo</div>
				<div id='solapaN2' class='laSolapaNew' onclick='javascript:cambiaCapa(2);'>
				Visitas Amigo</div>
			</div> <!-- solapas -->
			<div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosFicha.asp?id=<%=laid%>&recarga=<%=recarga%>" class="frameConte" style="display:block; width:690px; height:420px;"></iframe>
                <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="" class="frameConte" style="width:690px; height:420px;"></iframe>
                <script type="text/javascript">
				document.getElementById("frame2").src="verVisitasAmigo.asp?id=<%=laid%>&recarga="+self.name;
				</script>
			</div> <!-- contenido -->
			
		</div> <!-- centro -->
  <%else 'para añadir%>
  
  		      <div id='solapasNew' style="width:690px; margin-top:10px;">
				<div id='solapaN1' class='laSolapaOverNew'>Datos Ficha Amigo</div>
				<div id='solapaN2' class='laSolapaNew_nueva'>Visitas Amigo</div>
			</div> <!-- solapas -->
			<div id='contenidoNew'>
				<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verDatosFicha.asp?id=<%=laid%>&recarga=<%=recarga%>" class="frameConte" style="display:block; width:690px; height:420px;"></iframe>
			</div> <!-- contenido -->

	<%end if%>

</div> <!-- secciones -->
</body>
</html>
