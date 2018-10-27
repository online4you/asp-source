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

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

todos=request.QueryString("todos")
any=paClng(request.QueryString("any"))
if any=0 then any=anyo
mes=paClng(request.QueryString("mes"))
if mes=0 then mes=month(date)
tipof=request.QueryString("tipof")
if tipof="" then tipof="fr" 'fecha reserva

%><!--#include file="estadistica/datosGMesRes.asp"--><%

if todos="-1" then
	titulo="(" & objIdioma.getTraduccionHTML("i_ctodosloshoteles") & ")"
else
	for h=0 to ubound(RegHoteles,2)
		if RegHoteles(HCodi,h)=est then
			titulo=ucase(RegHoteles(HNombre,h))
		end if
	next
end if

'Buscar moneda
'cs="SELECT CodigoISO,Abreviado FROM TiposMoneda "
'if todos="-1" then 'todos
'	cs=cs & "WHERE PorDefecto<>0"
'else
'	cs=cs & "INNER JOIN Establecimientos ON TiposMoneda.Id=Establecimientos.Moneda "
'	cs=cs & "WHERE CodigoEsta=" & est
'end if
'rs.open cs,base
'if not rs.eof then
'	moneda=rs("codigoISO")
'	tmoneda=rs("abreviado")
'end if
'rs.close

set rs=nothing
base.close
set base=nothing

masquery="&any=" & any & "&mes=" & mes & "&tipof=" & tipof
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<!--#include file="scriptEstadisticas.asp"-->
<script language="javascript" type="text/javascript" src="/fusion/FusionCharts.js"></script>
<script language="javascript" type="text/javascript">
function cambiaMes(ese) {
	window.location='<%=MiPag%>?est=<%=est%>&todos=<%=todos%>&any=<%=any%>&tipof=<%=tipof%>&mes='+ese.value;
}
</script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
    
  <div id='iframeConte' style="margin:0px; padding:0px;"> 
    <div style="margin:10px;"> 
      <!--#include file="seleccionado.asp"-->
      <div style="float:right; height:25px; margin-right:10px"> <%=objIdioma.getTraduccionHTML("i_estadisticapor")%> 
        <select name="tipofecha" onchange="javascript:cambiaTipoF(this);">
          <option value="fr"<%if tipof="fr" then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_fechareserva")%></option>
          <option value="fe"<%if tipof="fe" then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_fechaentrada")%></option>
        </select>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:todosLosHoteles();">
      </div>
    </div>
    <div id='centro' style="margin-top:10px; clear:both"> 
      <center>
        <%=objIdioma.getTraduccionHTML("i_mes")%>: 
        <select name="elmes" id='elmes' onChange="javascript:cambiaMes(this);">
          <%for m=1 to 12
				marca=""
				if m=mes then marca=" selected"%>
          <option value="<%=m%>"<%=marca%>><%=nombremes(m) & " " & anyo%></option>
          <%next 'm%>
        </select>
      </center>
      <div id='contenido'> 
        <!--#include file="estadistica/capaGMesRes.asp"-->
      </div>
      <fieldset id='resumen' class="cajaCampos">
      <legend><%=objIdioma.getTraduccionHTML("i_resumenmes")%>&nbsp;<%=nombreMes(mes) & " " & anyo%></legend>
      <p><%=objIdioma.getTraduccionHTML("i_importespormes")%></p>
      <p><%=formatnumber(totalimporte,2) & " " & tmoneda%></p>
      <p><%=objIdioma.getTraduccionHTML("i_totalreservasmes")%></p>
      <p><%=totalnReservas%></p>
      <p><%=objIdioma.getTraduccionHTML("i_porestanciamedia")%></p>
      <p><%=totalestanciamedia & " " & objIdioma.getTraduccionHTML("i_dias")%></p>
      <p><%=objIdioma.getTraduccionHTML("i_porimportemedio")%></p>
      <p><%=formatnumber(totalimportemedio,2) & " " & tmoneda%></p>
      </fieldset>
    </div>
    <!-- centro -->
  </div>
  <!-- inframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
