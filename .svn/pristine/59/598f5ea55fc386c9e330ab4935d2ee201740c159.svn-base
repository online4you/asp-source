<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_recogeHabis.asp"-->
<!--#include file="CR_calcuPrecios.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="includes/cargaMonedas.asp"--><%

'Buscar si tiene ofertas sólo informativas
cs="SELECT Ofertas.Id,ISNULL(Traduccion,Titulo) AS Tradu FROM Ofertas LEFT JOIN Traducciones "
cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND "
cs=cs & "Campo='Titulo' AND Idioma='" & lang & "' "
cs=cs & "WHERE Activa<>0 AND Calcula=0 AND Ofertas.CodigoEsta=" & est & " AND Caduca>" & fechaSQLServer(date)
cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
cs=cs & " AND (((" & fechaSQLServer(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & "(" & fechaSQLServer(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
cs=cs & "((" & fechaSQLServer(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & fechaSQLServer(FSalida-1) & ">FechaFin) OR (" & fechaSQLServer(FLlegada) & "<FechaInicio AND "
cs=cs & "(" & fechaSQLServer(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
cs=cs & fechaSQLServer(FLlegada) & "<FechaInicio AND " & fechaSQLServer(FSalida-1) & ">FechaFin))"
rs.open cs,base
hayInfo=false
if not rs.eof then
	hayInfo=true
	RegInfo=rs.getrows
	RInCodi=0
	RInTitu=1
end if
rs.close

'Comprobar complementos
'Array para los complementos
dim RegServi()
redim RegServi(4,0)
SeCodi=0
SeNombre=1
SeCantidad=2
SePelas=3
SeColectivo=4
nservi=-1
totalservi=0

anteservi=0
if hayServis then
for s=0 to ubound(RegServis,2)
	if anteservi<>RegServis(SCodi,s) then
		linea=0
	else
		linea=linea+1
	end if
	'Comprobar si esta marcado
	if request.form("servi_" & RegServis(SCodi,s) & "_" & linea)="1" then 'está marcado
		cantidad=paClng(request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea))
		'response.write cantidad & " " & RegServis(SNombre,s) & "<br>"
		if cantidad>0 then 
			nservi=nservi+1
			redim preserve RegServi(4,nservi)
			RegServi(SeCodi,nservi)=RegServis(SCodi,s)
			RegServi(SeNombre,nservi)=RegServis(SNombre,s)
			RegServi(SeCantidad,nservi)=cantidad
			RegServi(SePelas,nservi)=RegServis(SPelas,s)
			if RegServis(SCColec,s)<>0 then
				RegServi(SeColectivo,nservi)="(" & RegServis(SColectivo,s) & ") "
			end if 'sccolec<>0
			totalservi=totalservi+(cantidad*RegServis(SPelas,s))
		end if 'cantidad>0
		
		
		
	end if

	anteservi=RegServis(SCodi,s)
next 's
end if 'hayServis


sumaExtras=0
if hayextras then
end if
'Calculo del importe de prepago
brutoreserva=redondear(totalbruto+sumaExtras)
totalreserva=brutoreserva
sumaOfertas=0
if hayofertas then
	for o=0 to ubound(codiOferta)
		sumaOfertas=sumaOfertas+totalOferta(o)
		'response.write totalOferta(o) & "<br>"
	next
end if
totalreserva=totalreserva-sumaOfertas

pelasprepago=redondear(totalreserva*prepago/100)

'categorias
cs="SELECT Id,Nombre,IdTipo FROM Categorias"
rs.open cs,base
haycate=false
if not rs.eof then
	RegCate=rs.getrows
	CaCodi=0
	CaNombre=1
	CaTipo=2
	haycate=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
<link href="css/iframe.css" rel="stylesheet" type="text/css" />
<link href="css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/eventosIFrame.js"></script>
<script language="JavaScript" type="text/javascript">
function comprueba(){
	if ((document.f1.ape.value.length==0)||(document.f1.nom.value.length==0)) {
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	/*
	if (document.f1.loc.value=="" || document.f1.prov.value==""){
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	if (document.f1.tel.value==""){
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	if (document.f1.pais.value==" Seleccione"){
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	*/
	if (document.f1.email.value.search(/^[^@]+@([a-zA-Z0-9-_\-]+\.)+[a-zA-Z]+$/)<0) {
		alert('<%=objIdioma.getTraduccion("i_badmail")%>');
		return false;
	}
	if (document.f1.email.value==""){
		alert('<%=objIdioma.getTraduccion("i_badmail")%>');
		return false;
	}
	if (document.f1.email.value!=document.f1.email2.value){
		alert('<%=objIdioma.getTraduccion("i_badmail")%>');
		return false;
	}
	if (!document.f1.acepto.checked){
		alert('<%=quitarApos(objIdioma.getTraduccion("i_noacepta"))%>');
		return false;
	}
	return true;
}

function Pago() {
	if (comprueba()){
		document.f1.action="ceca.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>";
		document.f1.target='_blank';
		document.f1.submit(); 
	}
}
function Manda() {
	if (comprueba()){
		document.f1.action="default.asp?hotel=onrequest&est=<%=est%>&lang=<%=lang%>";
		document.f1.submit();
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////
function PagaProf() {
	if (comprueba()){
		document.f1.action="ceca.asp?est=<%=est%>&lang=<%=lang%>";
		document.f1.target='_blank';
		document.f1.submit();
	}
}
function MandaProf() {
	if (comprueba()){
		document.f1.action="default.asp?hotel=onrequest&est=<%=est%>&lang=<%=lang%>";
		document.f1.submit();
	}
}
function NoAsignado() {
	 alert('Forma de pago no asiganda por el sistema');
}

////////////////////////////////////////////////////////////////////////////////////////////////

var minimo="<%=pelasprepago%>";
var maximo="<%=totalreserva%>";
function elPrepago(eso) {
	if (eso.value=="min"){
		document.f1.prepago.value=minimo;
		pelas=<%=replace(redondear(pelasprepago),",",".")%>;
	}
	if (eso.value=="max"){
		document.f1.prepago.value=maximo;
		pelas=<%=replace(redondear(totalreserva),",",".")%>;
	}

}
</script>
</head>
<body>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<div id='principalFrame'>
	<!--#include file="monedas.asp"-->
	<h2 id="capaTitulo"><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h2>
    <div class="resultado capaHotel">
        <%if fotoHotel<>"" then%>
       	<div class="izq_resultado">
            <a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>">
            <img width="120" src="<%=fotoHotel%>" alt="<%=nombreHotel%>" style="margin-right:4px;" border="0"/></a>
        </div> <!--izq_resultado-->
        <%end if%>
        <%if haySecciones then
			if RegSecciones(SecTexto,0)<>"" then%>
            <div class="der_resultado">
                <div class="textoHotel"><%=RegSecciones(SecTexto,0)%></div> <!--textohotel-->
            </div> <!--der_resultado-->
           	<%end if
		end if 'haysecciones%>
    </div> <!-- resultado -->

	<form name='f1' method="post">
		<!--#include file="CR_RecogeDatos.asp"-->
		<input type='hidden' name='estado' value='<%=estado%>'>
		<input type='hidden' name='porciento' value='<%=prepago%>'>
		<input type='hidden' name='importe' value='<%=totalreserva%>'>
		<input type='hidden' name='bruto' value='<%=brutoreserva%>'>
		<input type='hidden' name='moneda' value='<%=monedaHotel%>'>
		<%if hayofertas then%>
			<input type='hidden' name='sumaofertas' value='<%=sumaofertas%>'>
			<input type='hidden' name='codiofertas' value='<%=COferta%>'>
			<input type='hidden' name='textofertas' value='<%=TOferta%>'>
		<%end if%>

    <div id='frameCabecera'>
    	<%if request.cookies("idAgencia")<>"" then
			response.write "<p><b>" & objIdioma.getTraduccionHTML("i_bienvenido") & " " & request.cookies("nomAgencia") & "</b></p>"
		end if 'agencia%>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fllegada") & ": <b>" & fini & "</b>"%><br/>
            <%=objIdioma.getTraduccionHTML("i_noches") & ": <b>" & dateDiff("d",fini,ffin) & "</b><br/>"%>
		</div>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fsalida") & ": <b>" & ffin & "</b>"%>
		</div>
    </div> <!--frameCabecera-->
    
    <div id='contenidoFrame'>
		<table id='resumen' cellpadding="0" cellspacing="1" border="0" width="100%" align="center">
        <tr>
        	<th align="left"><%=objIdioma.getTraduccionHTML("i_tipohab")%></th>
            <th align="left"><%=objIdioma.getTraduccionHTML("i_plazas")%></th>
            <th align="left"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
            <th align="right"><%=objIdioma.getTraduccionHTML("i_total")%></th>
        </tr>
        <%for h=1 to cuantas
			totalHabi=0
			for d=1 to noches 'suma todas las noches
				totalhabi=totalHabi+(PrecioPlazas(d,h)-DtoHab(d,h)+TotalSuples(d,h))
			next 'd%>
            <input type="hidden" name='precioHab_<%=h%>' value="<%=totalHabi%>" />
        <tr>
        	<td align="left" class='coluHabi'><%=Vnombreh(h)%></td>
            <td align="left" class='coluPlazas'>
            	<%nombrecolec=""
				if Vadultos(h)<>0 then nombrecolec="<span class='reservas_bold'>" & iadultos(h) & ":</span>&nbsp;" & Vadultos(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vbebes(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & objIdioma.getTraduccionHTML("i_bebes") & ":</span>&nbsp;" & Vbebes(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vninos1(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & ininos1(h) & ":</span>&nbsp;" & Vninos1(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vninos2(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & ininos2(h) & ":</span>&nbsp;" & Vninos2(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				response.write nombrecolec & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"%>
            </td>
            <td align="left" class='coluRegi'><%=nomsuples(h)%></td>
            <td align="right" class='coluTotal'><%=formatNumber(totalHabi*elCambio,2) & sufijoMoneda%></td>
        </tr>
		<%next%>
        <%if hayInfo then 'ofertas informativas no son cálculos
			for o=0 to ubound(RegInfo,2)%>
            <tr>
                <td align="left" colspan='4' class='coluHabi'><%=RegInfo(RInTitu,o)%></td>
             </tr>
			<%next 'oferta informativa%>
		<%end if 'infos%>
        <%if hayofertas then
			for o=0 to ubound(codiOferta)%>
            <tr>
				<td align="left" colspan="3" class='coluHabi'><b><%=textoOferta(o)%></b></td>
                <td align="right" class='coluTotal'><%=formatnumber(totalOferta(o)*(-1)*elCambio,2) & sufijoMoneda%></td>
			</tr>
			<%next 'oferta
		end if
        if nservi>-1 then 'hay complementos marcados%>
        <tr><td colspan="4"><%=objIdioma.getTraduccionHTML("i_complementos")%></td></tr>
		<%for se=0 to ubound(RegServi,2)%>
        	<tr>
            	<td align="left" colspan="3" class='coluHabi'>
					<%=RegServi(SeNombre,se)%>&nbsp;
                    (<%=RegServi(SeColectivo,se) & RegServi(SeCantidad,se) & " x " & formatnumber(RegServi(SePelas,se)*elCambio,2)%>)
                </td>
                <td align="right" class='coluTotal'>
                	<%totservi=redondear(RegServi(SeCantidad,se)*RegServi(SePelas,se))
					response.write formatnumber(totservi*elCambio,2) & sufijoMoneda%>
                </td>
            </tr>
		<%next
		end if 'nservi%>
        <tr>
			<td align="left" colspan="2" class='coluHabi'><b><%=objIdioma.getTraduccionHTML("i_noches")%>:&nbsp;<%=noches%></b></td>
            <td align="right" class='coluRegi'><%=objIdioma.getTraduccionHTML("i_total")%></td>
            <td align="right" class='coluTotal'><%=formatnumber((totalreserva+totalServi)*elCambio,2) & sufijoMoneda%></td>
		</tr>
        </table>
        
        <table id='datosPersonales' cellpadding="0" cellspacing="1" border="0" align="center">
		<tr>
		  <td align="left" colspan='2' class="colu1"><span><%=objIdioma.getTraduccionHTML("i_rellenaformulario")%></span></td>
		</tr>
		<tr><td colspan="2" height="5"></td></tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_apellidos")%>*:</td>
		  <td>
			<input type="text" name="ape" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_nombre")%>*:</td>
		  <td>
			<input type="text" name="nom" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
		  <td>
			<input type="text" name="dir" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_localidad")%>:</td>
		  <td>
			<input type="text" name="loc" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_provincia")%>:</td>
		  <td>
			<input type="text" name="prov" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_pais")%>:</td>
		  <td>
          	<input type="text" name="pais" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_cp")%>:</td>
		  <td>
			<input type="text" name="cp" style="width:70px;" maxlength="5" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_telefono")%>*:</td>
		  <td>
			<input type="text" name="tel" style="width:240px;" maxlength="25" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1">EMail*:</td>
		  <td>
			<input type="text" name="email" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_confirmaemail")%>*:</td>
		  <td>
			<input type="text" name="email2" style="width:240px;" maxlength="50" class="combo5">
		  </td>
		</tr>
		<tr>
		  <td align="right" valign="top" class="colu1"><%=objIdioma.getTraduccionHTML("i_comentarios")%>:</td>
		  <td valign="top">
			<textarea name="com" style="width:240px; height:80px;" class="combo5"></textarea>
		  </td>
		</tr>
		<tr>
			<td class="colu1">&nbsp;</td>
			<td align="left">
			<input type='checkbox' name='informacion' value='-1'  style='border:none' checked>
			&nbsp;<%=objIdioma.getTraduccionHTML("i_acepto")%><br/>
			<input type='checkbox' name='acepto' value='-1'  style='border:none'>
			&nbsp;<%=objIdioma.getTraduccionHTML("i_aceptoprivacidad")%>
			</td>
		</tr>
		<tr><td class="colu1"></td>
			<td align='left'><b><%=objIdioma.getTraduccionHTML("i_obliga")%></b></td></tr>
            
			<%if estado=online then 'solo en online%>
            <tr>
              <td align="right" class="colu1"><b><%=objIdioma.getTraduccionHTML("i_totalres")%>:</b></td>
              <td align="left"><input name="totalres" type="text" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">&nbsp;<%=monedaHotel%>
              <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber((totalreserva+totalservi)*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
             <br/>
              *&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
              </td>
             </tr>
            <tr>
                <td class="colu1"></td>
                <td align="left">
                <input type="radio" name="cuanto" value="min" onclick="javascript:elPrepago(this);" checked>
                &nbsp;<b><%=objIdioma.getTraduccionHTML("i_pagoprepago1") & " " & porciento & objIdioma.getTraduccionHTML("i_pagoprepago2")%></b><br/>
                <input type="radio" name="cuanto" value="max" onclick="javascript:elPrepago(this);">
                &nbsp;<b><%=objIdioma.getTraduccionHTML("i_pagototal")%></b>
                </td>
            </tr>
            <tr>
              <td align="right" class="colu1"><b><%=objIdioma.getTraduccionHTML("i_prepago")%>:</b></td>
              <td align="left"><input name="prepago" type="text" value="<%=formatnumber(pelasprepago,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">&nbsp;<%=monedaHotel%>
              <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber(pelasprepago*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
              </td>
             </tr>
             <tr><td colspan="2" height="10"></td></tr>
             <tr>
                <td class="colu1">&nbsp;</td>
                <td>
                <%=objIdioma.getTraduccionHTML("i_textoreserva") & " " & porciento & objIdioma.getTraduccionHTML("i_textoreserva2")%></td>
            </tr>
        <%else 'pa onrequest%>
            <tr>
                <td align="right" class="colu1" valign="top"><b><%=objIdioma.getTraduccionHTML("i_totalpresu")%>:</b></td>
                <td align="left">
                <input name="totalres" type="text" value="<%=formatnumber(totalreserva+totalservi,2)%>" size="10" maxlength="8" readonly class="combo5" style="width: 70px;">&nbsp;<%=monedaHotel%>
                <%if monedaHotel<>coin then 'poner el cambio
					response.write "<br>Aprox. <b>" & formatnumber((totalreserva+totalservi)*elCambio,2) & sufijoMoneda & "</b>"
					response.write " (1 " & monedaHotel & " = " & elCambio & " " & coin & ")"
				end if 'modenahotel<>coin%>
                
                <br/>*&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
              <input name="prepago" type="hidden" value="<%=formatnumber(totalreserva+totalservi,2)%>">
              </td>
             </tr>
             <tr><td colspan="2" height="10"></td></tr>
             <tr>
                <td class="colu1">&nbsp;</td>
                <td><%=objIdioma.getTraduccionHTML("i_textopresu")%></td>
            </tr>    
        <%end if%>
		 <tr><td colspan='2' height="10"></td></tr>
        </table> <!--datosPersonales-->
        
        <div id='pieReserva'>
            <a href="javascript:window.history.back();" class="boton" style="float:left"><%=objIdioma.getTraduccionHTML("i_anterior")%></a>
            <a href="javascript:Pago();" class="boton" style="float:right;">
			<%=objIdioma.getTraduccionHTML("i_reservar")%></a>
        </div>
        <br class="clear" />

    </div> <!--contenido-->
    </form>
</div> <!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>
