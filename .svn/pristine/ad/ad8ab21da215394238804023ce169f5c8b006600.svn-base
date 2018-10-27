<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

slp=paClng(request.QueryString("slp"))
if slp=0 then slp=1 'solapa 1 por defecto

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

todos=request.QueryString("todos")
any=request.QueryString("any")
if any="" then any=anyo
any=clng(any)
compara=paClng(request.QueryString("cp"))
if compara=0 then compara=any-1

%><!--#include file="estadistica/datosGAnyoPelas.asp"--><%
%><!--#include file="estadistica/datosGAnyoRes.asp"--><%

if todos="-1" then
	titulo="(" & objIdioma.getTraduccionHTML("i_ctodosloshoteles") & ")"
else
	for h=0 to ubound(RegHoteles,2)
		if RegHoteles(HCodi,h)=est then
			titulo=ucase(RegHoteles(HNombre,h))
		end if
	next
end if

set rs=nothing
base.close
set base=nothing

masquery="&any=" & any & "&cp=" & compara & "&slp=" & slp
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript">
var solapaActiva=<%=slp%>;
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
	elLeft=dameLeft(document.getElementById('solapa'+solapaActiva))+1; //ajustar a mano
	elAncho=document.getElementById('solapa'+solapaActiva).offsetWidth;
	elAlto=document.getElementById('solapa'+solapaActiva).offsetHeight;
	document.getElementById('lineaSolapa').style.top='22px';
	document.getElementById('lineaSolapa').style.left=elLeft+"px";
	document.getElementById('lineaSolapa').style.width=(elAncho-2)+"px";	
	document.getElementById('lineaSolapa').style.visibility='visible';
}

function comparaD(cp){
	window.location="<%=MiPag%>?est=<%=est%>&todos=<%=todos%>&any=<%=any%>&cp="+cp.value+"&slp="+solapaActiva;
}
function todosLosHoteles(){
	window.location='<%=MiPag%>?todos=-1&any=<%=any%>&cp=<%=compara%>&slp='+solapaActiva;
}
</script>
<style type="text/css">
#lineaSolapa {
	/*background-color:#330099;*/
}
.fichaCapa {
	position:absolute;
	z-index:10;
	top:0px;
	left:1px;
	overflow:hidden;
	margin:0px;
	background-color:#F2F2F2;
	width:798px;
	height:430px;
	border-top:1px solid #AAABA3;
}
</style>
<script language="javascript" type="text/javascript" src="/fusion/FusionCharts.js"></script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	<div style="padding:10px">
		<!--#include file="seleccionado.asp"-->
		<div style="float:right">
		<input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:todosLosHoteles();">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Compara con año: 
			<select name='compara' onchange="Javascript:comparaD(this);">
			<%
			for aa=year(date)-4 to year(date)
				marca=""
				if compara=aa then marca=" selected"%>
				<option value="<%=aa%>"<%=marca%>><%=aa%></option>
			<%next%>
			</select>
		</div>
	</div>
		<div id='centro' style="margin-top:10px;">
			<!--#include file="solapasGraficos.asp"-->
			
			<div id='contenido'>
				<div id='elFrame_1' name='elFrame_1' class='fichaCapa'>
					<!--#include file="estadistica/capaGAnyoPelas.asp"-->
				</div>
				<div id='elFrame_2' name='elFrame_2' class='fichaCapa'>
					<!--#include file="estadistica/capaGAnyoRes.asp"-->
				</div>
				<div id='elFrame_3' name='elFrame_3' class='fichaCapa'>
					<!--#include file="estadistica/capaGAnyoPelas.asp"-->
				</div>
				<div id='elFrame_4' name='elFrame_4' class='fichaCapa'>
					<!--#include file="estadistica/capaGAnyoPelas.asp"-->
				</div>
				<div id='elFrame_5' name='elFrame_5' class='fichaCapa'>
					<!--#include file="estadistica/capaGAnyoPelas.asp"-->
				</div>
			</div>
			<div id='lineaSolapa'></div>
			
		</div> <!-- centro -->

</div> <!-- iframePrincipal -->

<script language="javascript" type="text/javascript">
cambiaCapa(<%=slp%>);
</script>
</body>
</html>
