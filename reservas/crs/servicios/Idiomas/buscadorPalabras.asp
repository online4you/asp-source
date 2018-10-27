<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="claseIdioma.asp"-->
<%
elCharSet="iso-8859-1"
elCodePage="1252" 'por defecto
'encoding de la pagina
response.Charset=elCharSet 'las traducciones del administrador en ISO-8859-1
session.CodePage=elCodePage

tipo=request.QueryString("tipo")
if tipo="web" then rutaXML=server_path & "reservas/bookingFront/IdiomaXML/"

lang="es"
set objIdioma_es = new clsIdioma 'español
lang="en"
set objIdioma_en = new clsIdioma 'ingles

pasalir=0
busco=request.QueryString("busco")
ff=request.QueryString("ff") 'id del frame de la ventana
recarga=request.QueryString("recarga") 'id del frame de la ventana anterior

Lista=objIdioma_es.buscaTraduccion(busco) 'array con los registros
haylista=true
if isArrayVacio(Lista) then haylista=false
LEti=0
LTradu=1
LDetalle=2
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
function elIntro(oEvento){
     var iAscii;
     if (oEvento.keyCode)
         iAscii = oEvento.keyCode;
     else if (oEvento.which)
         iAscii = oEvento.which;

     if (iAscii == 13) otraMas();
}
function otraMas(){
	busco=document.getElementById('buscar').value;
	window.location="<%=MiPag%>?busco="+busco+"&ff=<%=ff%>&tipo=<%=tipo%>&recarga=<%=recarga%>";
}
function verFicha(valores){
	top.<%=recarga%>.cargaPalabra(valores);
	//cerrar();
}
</script>
<body class="laFicha">
<div id='capaFicha' style="height:410px;">
    <div class="tituloFicha" id='tituloFicha'>
        <div class="nombreFicha">BUSCANDO: <%=busco%></div>
        <div class="laX" id='laX'></div>
        <img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
    </div>
	<div style="padding-left:10px; line-height:15px; margin-top:5px;">
		<input type="text" name="buscar" id='buscar' value="<%=busco%>" style="width:200px;" maxlength="50" onKeyDown="javascript:elIntro(event);">
		<input type="button" class="boton86" value="Buscar" onClick="javascript:otraMas();" style="margin:0px;">
	</div>
	<div style="position:absolute; top:52px; height:310px; width:580px; left:7px; overflow-x:hidden; overflow-y:scroll;">
		<table border="0" cellpadding="0" cellspacing="1" align="center" style="width:562px; overflow:hidden">
			<tr><th colspan='4' class="tituloTabla" align="center">Traducciones, <b>resultados de b&uacute;squeda: <%if haylista then response.write ubound(Lista,2)+1 else response.write "0"%></b></th></tr>
			<tr>
				<th class="colu_par" align="center">Etiqueta</th>
				<th class="colu_impar" align="left">Traducci&oacute;n Esp.</th>
				<th class="colu_par" align="left">Traducci&oacute;n Ing.</th>
				<th class="colu_impar" align="left">Detalle</th>
			 </tr>
			<%if haylista then
				function laColu(esa)
					if esa=0 then
						laColu=estilo
					else
						laColu=estilo & esa
					end if
				end function
			for R=0 to Ubound(Lista,2)
				if (R mod 2)<>0 then
					estilo="fila_par"
				else
					estilo="fila_impar"
				end if
				elvalor=Lista(LEti,r) & ";" & Lista(LTradu,r)%>
				<tr>
				<td align="center" class='<%=laColu(0)%>'>
				  <a href='javascript:verFicha("<%=elvalor%>");' class="enlaceLista"><%=Lista(LEti,r)%></a>
				</td>			
				<td align="left" class='<%=laColu(1)%>'>
				  <a href='javascript:verFicha("<%=elvalor%>");' class="enlaceLista">
				  <%=mid(Lista(LTradu,r),1,40)%></a>
				</td>
				<td align="left" class='<%=laColu(0)%>'>
				  <a href='javascript:verFicha("<%=elvalor%>");' class="enlaceLista">
				  <%=mid(objIdioma_en.getTraduccionHTML(Lista(LEti,r)),1,40)%></a>
				</td>
				<td align="left" class='<%=laColu(1)%>'>
				  <a href='javascript:verFicha("<%=elvalor%>");' class="enlaceLista">
				  <%=mid(Lista(LDetalle,r),1,40)%></a>
				</td>
			  </tr>
		<%next
		end if%>
			
		</table>
	</div> 
	<div align="center" style="position:absolute; top:362px; width:580px">
	<input name="button3" type="button" onClick="javascript:cerrar()" value="Cerrar" class="boton86">
	</div>

	
</div> <!-- capaFicha -->
<script language="javascript" type="text/javascript">
	document.getElementById('buscar').focus();
</script>
<!--#include file="pieTraduccion.asp"-->
</body>
</html>
