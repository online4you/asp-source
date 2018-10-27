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

slp=5 'solapa por idioma

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

todos=request.QueryString("todos")
any=paClng(request.QueryString("any"))
if any=0 then any=anyo
compara=paClng(request.QueryString("cp"))
if compara=0 then compara=any-1
tipof=request.QueryString("tipof")
if tipof="" then tipof="fr" 'fecha reserva

%><!--#include file="estadistica/datosGAnyoIdioma.asp"--><%

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

masquery="&any=" & any & "&cp=" & compara & "&tipof=" & tipof & "&slp=" & slp
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<!--#include file="scriptEstadisticas.asp"-->
<script language="javascript" type="text/javascript" src="/fusion/FusionCharts.js"></script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte' style="margin:0px; padding:0px;"> 
    <div> 
      <!--#include file="seleccionado.asp"-->
      <!--#include file="filtroestadistica.asp"-->
    </div>
    <div id='centro' style="margin-top:10px; clear:both"> 
      <!--#include file="solapasGraficos.asp"-->
      <div id='contenido'> 
        <!--#include file="estadistica/capaGAnyoIdioma.asp"-->
      </div>
    </div>
    <!-- centro -->
  </div>
  <!-- iframePrincipal -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
