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

recarga=request.QueryString("recarga") 'id del frame de la ventana

laid=paClng("0" & request.QueryString("idh")) 'id habitacion
es=paClng(request.QueryString("est"))

'Buscar habitacion
cs="SELECT Nombre FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres WHERE Id=" & laid
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
</head>
<script language="javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
function cambiaSolapa(esa){
	//Poner todas a normal
	for (x=1;x<=2;x++){
		document.getElementById("sola"+x).className='laSolapa2';
		document.getElementById("frame"+x).style.visibility='hidden';
		document.getElementById("frame"+x).style.zIndex=5;
	}
	//Activa
	document.getElementById("sola"+esa).className='laSolapaOver2';
	document.getElementById("frame"+esa).style.visibility='visible';
	document.getElementById("frame"+esa).style.zIndex=10;
}

//cargaPrimera
//cambiaSolapa(1);	
</script>
<body class="laFicha">
	<div class="tituloFicha" id='tituloFicha'>
		<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_textohabitacion")%> -> <%=nombreHabi%></div>
		<div class="laX" id='laX'></div>
		<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
	</div>
	
<div style="position:relative; height:22px; width:auto; margin-top:5px;"> 
  <div id='solapas'> 
    <div id='sola1' class="laSolapa2" onClick="javascript:cambiaSolapa(1);" style="margin-left:0px"><%=objIdioma.getTraduccionHTML("i_texto")%></div>
    <div id='sola2' class="laSolapa2" onClick="javascript:cambiaSolapa(2);"><%=objIdioma.getTraduccionHTML("i_fotos")%></div>
  </div>
  <div id='lineaSolapa2'></div>
</div>		
  <div id='zonaFrames'> 
    <iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="verTextosHabitacion.asp?idh=<%=laid%>" class="elFrame" style="height:420px;"></iframe>
    <iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="verFotosHabitacion.asp?idh=<%=laid%>" class="elFrame" style="height:420px;"></iframe>
  </div>
	

<script language="javascript" type="text/javascript">
	cambiaSolapa(1);
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
