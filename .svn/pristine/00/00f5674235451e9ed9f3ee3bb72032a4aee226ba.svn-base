<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

modulos=modulosCR
'Solo busca modulos del primer nivel
cs="SELECT Id,Modulo" & sqltail & ",Programa FROM " & precrsgen & "modulos WHERE Menu<>0 AND ModuloSuperior=0 "
cs=cs & "ORDER BY Orden"
haymodulos=false
rs.open cs,base
if not rs.eof then
	RegModulos=rs.getrows
	MCodi=0
	MModulo=1
	MPrograma=2
	haymodulos=true
	'response.write cs
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
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/moverFrames.js"></script>
</head>
<body>
<div>
	<div style="float:left; width:193px; overflow:hidden; margin-top:92px;"><!--#include file="menuGlo.asp"--></div>
	
  <div id='centro' style="float:left; margin-top:5px; margin-left:-1px; position:relative;"> 
    <div id='solapas'></div>
    <div id='contenido'></div>
  </div>
</div>
<div id='capaFrames'></div>
<iframe id='paCookies' name="paCookies" frameborder='0' hspace='0' vspace='0' src='vacio.htm' class='ficha'></iframe>
<script language="javascript" type="text/javascript">
	//carga por defecto
	<%if adminboss then%>
	creaFrame("empresas.asp?lang=<%=lang%>","empresas")
	<%else%>
	creaFrame("usuariosF.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_usuarios")%>");
	<%end if%>
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
<script language="javascript" type="text/javascript">
<%
if (request.Cookies("IDCR")="7") then
	response.Write("iR(""cr.asp"");")
end if
%>
</script>