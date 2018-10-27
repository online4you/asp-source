<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
'response.write conecta
base.Open ConectaMDB

'SubModulos de Hotel
cs="SELECT modulos.Id,Modulo"&sqltail& ",NombreBoton,aplicaciones.Programa "
cs=cs & "FROM " & precrsgen & "modulos modulos INNER JOIN " & precrsgen & "aplicaciones aplicaciones ON modulos.Id=aplicaciones.IdModulo "
cs=cs & "WHERE Menu<>0 AND ModuloSuperior=1 " 'gestion hotel
cs=cs & "ORDER BY modulos.Orden,aplicaciones.Orden"
rs.open cs,base
haysubmodulos=false
if not rs.eof then
	RegSubModulos=rs.getrows
	SId=0
	SModulo=1
	SBoton=2
	SPrograma=3
	haySubModulos=true
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
<script language="javascript" type="text/javascript" src="js/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="js/moverFrames.js"></script>
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
<div id='chivato'></div>
<iframe id='verCalendario' name="verCalendario" frameborder='0' hspace='0' vspace='0' src='vacio.htm' class='ficha'></iframe>
<iframe id='paCookies' name="paCookies" frameborder='0' hspace='0' vspace='0' src='vacio.htm' class='ficha'></iframe>
<iframe id='paProcesos' name="paProcesos" frameborder='0' hspace='0' vspace='0' src='vacio.htm' class='ficha'></iframe>
<script language="javascript" type="text/javascript">
	//carga por defecto
	creaFrame("alojamientos.asp?lang=<%=lang%>",'<%=objIdioma.getTraduccionHTML("i_alojamientos")%>');
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>