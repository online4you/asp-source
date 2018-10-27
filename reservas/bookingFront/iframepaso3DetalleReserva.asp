<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<%
mostrarTotal=false

Fpago = 1 ' esta variable va a ser leida por "CR_datosHotel.asp" y nos va a indicar si se devolveran los datos de la forma de Pago 
temporada = request.querystring("temporada") 'esta variable es necesaria para CR_temporadaInfo.asp
	est=paClng(request.QueryString("idh"))
	fini=request.Form("fini")
	if (fini="") then fini=request.QueryString("fini")
	fini=cdate(fini)

	ffin=request.Form("ffin")
	if (ffin="") then ffin=request.QueryString("ffin")
	ffin=cdate(ffin)


	Noches=dateDiff("d",fini,ffin)
	datos=split(request.form,"&") 'tabla de campos para usar en los calculos de precios
	if (ubound(datos)=-1) then
		datos=split(request.QueryString,"&") 'tabla de campos para usar en los calculos de precios
	end if

%>
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_recogeHabis.asp"-->
<!--#include file="CR_calcuPrecios.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<!--#include file="CR_temporadaInfo.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="includes/cargaMonedas.asp"--><%

		  mostrarCalculo="style=""visibility: hidden; position:absolute; top:0;"""
          'mostrarCalculo=""

FLlegada=fini
FSalida=ffin
'Buscar si tiene ofertas s�lo informativas
cs="SELECT Ofertas.Id, IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion) AS Tradu FROM " & precrs & "Ofertas Ofertas LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND "
cs=cs & "Campo='Titulo' AND Idioma='" & lang & "' "
cs=cs & "WHERE Activa<>0 AND Calcula=0 AND Ofertas.CodigoEsta=" & idh & " AND Caduca>" & FechaMySQL(date)
cs=cs & " AND (CodigoPromocion IS NULL OR CodigoPromocion='')"
cs=cs & " AND (((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
cs=cs & "((" & FechaMySQL(FLlegada) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & FechaMySQL(FSalida-1) & " > FechaFin) OR (" & FechaMySQL(FLlegada) & " < FechaInicio AND "
cs=cs & "(" & FechaMySQL(FSalida-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
cs=cs & FechaMySQL(FLlegada) & " < FechaInicio AND " & FechaMySQL(FSalida-1) & " > FechaFin))"
'response.Write(cs & "<br>")
rs.open cs,base
hayInfo=false
if not rs.eof then
	hayInfo=true
	RegInfo=rs.getrows
	RInCodi = 0
	RInTitu = 1
end if
rs.close

'Comprobar complementos
'Array para los complementos
dim RegServi()

redim RegServi(5, 0)
SeCodi = 0
SeNombre = 1
SeCantidad = 2
SePelas = 3
SeColectivo = 4
SeDescuento = 5

nservi = -1
totalservi = 0


anteservi=0
if hayServis then
for s=0 to ubound(RegServis,2)
	if anteservi<>RegServis(SCodi,s) then
		linea=0
	else
		linea=linea+1
	end if
	'Comprobar si esta marcado
	servtmp=request.querystring("servi_" & RegServis(SCodi,s) & "_" & linea)
	if (servtmp="") then 
		servtmp=request.form("servi_" & RegServis(SCodi,s) & "_" & linea)
	end if
'response.Write("servtmp="  & servtmp & "<br>")
	if servtmp="1" then 'est� marcado
		cantidadtmp=request.querystring("cuantos_" & RegServis(SCodi,s) & "_" & linea)
		if (cantidadtmp="") then 
			cantidadtmp=request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea)
		end if
		cantidad = paClng(cantidadtmp)
		descuentotmp = request.querystring("importedescuento_" & RegServis(SCodi,s) & "_" & linea)
		if (descuentotmp="") then 
			descuentotmp=request.form("importedescuento_" & RegServis(SCodi,s) & "_" & linea)
		end if
		descuento = descuentotmp
		descuento = replace(descuento, ".", ",")
'response.Write("cuantos_" & RegServis(SCodi,s) & "_" & linea & "<br>")
'response.Write("request.form(cuantos_ RegServis(SCodi,s)  linea)="  & request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea)& "<br>")
'response.Write("cantidad="  & cantidad& "<br>")
		if cantidad > 0 then 
			nservi = nservi + 1
			redim preserve RegServi(5, nservi)
			RegServi(SeCodi, nservi) = RegServis(SCodi, s)
			RegServi(SeNombre, nservi) = RegServis(SNombre, s)
			RegServi(SeCantidad, nservi) = cantidad
			RegServi(SePelas, nservi) = RegServis(SPelas, s)					
			RegServi(SeDescuento, nservi) = descuento
			
			if RegServis(SCColec,s) <> 0 then
				RegServi(SeColectivo,nservi)="(" & RegServis(SColectivo,s) & ") "
			end if 'sccolec<>0

			totalservi = totalservi + (cantidad * RegServis(SPelas,s))			
			totalservi = totalservi - descuento
		end if 'cantidad>0
	end if

	anteservi = RegServis(SCodi,s)
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
cs="SELECT Id,Nombre,IdTipo FROM " & precrs & "Categorias"
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

displayPromo=" noPromo" 'por defecto no se ve
cpromo=request.querystring("cpromo")
if cpromo<>"" then 'buscar titulo oferta
	cs="SELECT Id,IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion)  AS Titulo "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND "
	cs=cs & "Campo='Titulo' AND Idioma='" & lang & "' "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & idh & " AND Caduca>" & FechaMySQL(date)
	cs=cs & " AND CodigoPromocion='" & cpromo & "'"
	rs.open cs,base
	if not rs.eof then
		npromo=rs("titulo")
	else
		npromo="Error Cod. Promocion"
	end if
	rs.close
	displayPromo=" displayPromo" 'para que se vea

else 'comprobar si se usa

	cs="SELECT Ofertas.Id,IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion)  AS Titulo "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND "
	cs=cs & "Campo='Titulo' AND Idioma='" & lang & "' "
	cs=cs & "WHERE Ofertas.Activa<>0 AND Ofertas.Calcula<>0 AND Ofertas.CodigoEsta=" & idh & " AND Ofertas.Caduca > " & FechaMySQL(date)
	cs=cs & " AND CodigoPromocion<>''"
	rs.open cs,base
	if not rs.eof then
		displayPromo=" displayPromo" 'para que se vea
	end if
	rs.close

end if 'cpromo
'displayPromo=" displayPromo" 'para que se vea

IF (request.Cookies("IdAgencia")<>"") and (request.Cookies("NomAgencia")<>"") THEN 'es agencia
 
 	cs="SELECT Id,Comision,Email,Sistema,Direccion,CP,Poblacion,Pais,Telefono "	
	cs=cs & "FROM " & precrs & "Agencias WHERE Id=" & request.Cookies("idagencia")
	rs.open cs,base
	dtocomis=0
	if not rs.eof then
	
		dtocomis=paDbl(rs("comision"))
		AG_Sistema=paClng(rs("Sistema"))
		AG_idagencia=rs("Id")
		direccion=rs("direccion")
		cp=rs("cp")
		poblacion=rs("poblacion")
		pais=rs("pais")
		telefono=rs("telefono")
		email=rs("email")
 
	end if
	rs.close
	lacomis=redondear((totalreserva+totalservi)*dtocomis/100)
END IF


'Busqueda en la base de datos las condiciones de reserva
cs="SELECT IF(ISNULL(traduc.Traduccion),CondicionesHotel.Texto,traduc.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "CondicionesHotel CondicionesHotel "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""CondicionesHotel"" And Campo = ""Texto"" And Idioma = """ & lang & """)  AS traduc ON CondicionesHotel.CodigoEsta = traduc.IdReferencia "
cs=cs & "WHERE CondicionesHotel.CodigoEsta=" & idh
'response.Write(cs & "<br>")

rs.open cs,base
if not rs.eof then
	condiHotel=rs("tradu")
end if
rs.close


'Forma pago del hotel
'Este dato lo recuperamos de CR_datosHotel.asp
tipoFPago = TPV_tipoPago
%>
<link rel="stylesheet" type="text/css" href="/templates/photel/css/template.css" />
<link href="<%=Front_url%>css/iframe.css" rel="stylesheet" type="text/css" />
<link href="<%=Front_url%>css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
<style type='text/css' media='screen'>@import url(/templates/photel/css/form.css);</style>

<div style="float: right;">
 <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
 	<img src="<%=mainUrl%>/templates/photel/images/close.png"/>
 </a>
</div>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" style="height: 30px;display: none;" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<div id='principalFrame' style="top: 20px; margin: 10; padding: 0;padding-top: 20px"> 
  <!--#include file="monedas.asp"-->
  <a href="http://booking.kubikcrs.com/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>"> 
  <h2 id="capaTitulo" <%=mostrarCalculo%>><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h2>
  </a> 
  <div class="resultado capaHotel"> 
    <%if fotoHotel<>"" then%>
    <div class="izq_resultado"> <a href="http://booking.kubikcrs.com/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>"> 
      <img width="120" src="<%=renombraFoto(fotoHotel,"Th_")%>" alt="<%=nombreHotel%>" style="margin-right:4px;" border="0"/></a> 
    </div>
    <!--izq_resultado-->
    <%end if%>
    <%if haySecciones then
			if RegSecciones(SecTexto,0)<>"" then%>
    <div class="der_resultado"> 
      <div class="textoHotel"><%=RegSecciones(SecTexto,0)%></div>
      <!--textohotel-->
    </div>
    <!--der_resultado-->
    <%end if
		end if 'haysecciones%>
  </div>
  <!-- resultado -->
  <div id='frameCabecera' <%=mostrarCalculo%>> 
    <form name='fb' method="post" >
      <!--#include file="CR_RecogeDatos.asp"-->
      <%if request.cookies("idAgencia")<>"" then
			response.write "<p><b>" & objIdioma.getTraduccionHTML("i_bienvenido") & " " & request.cookies("nomAgencia") & "</b></p>"
		end if 'agencia%>
      <div class="texto"> <%=objIdioma.getTraduccionHTML("i_fllegada") & ": <b>" & fini & "</b>"%><br/>
        <%=objIdioma.getTraduccionHTML("i_noches") & ": <b>" & dateDiff("d",fini,ffin) & "</b><br/>"%> 
      </div>
      <div class="texto"> <%=objIdioma.getTraduccionHTML("i_fsalida") & ": <b>" & ffin & "</b>"%> 
      </div>
      <br class="clear<%=displayPromo%>" />
      <div class="texto<%=displayPromo%>"> <span><%=objIdioma.getTraduccionHTML("i_codpromocion") & ": "%></span> 
        <span> 
        <input type="text" name="codpromo" id='codpromo' value="<%=cpromo%>" />
        <img id='espera_promo' src="img/espera.gif" width="16" height="16" class="esperaPromo"/> 
        <a class="botonPromo" href="javascript:cargaPromo();"><%=objIdioma.getTraduccionHTML("i_comprobar")%></a> 
        <span id='textopromo'><%=npromo%></span> </span> </div>
    </form>
  </div>
  <!--frameCabecera-->
  <form id='f1' name='f1' method="post">
    <!--#include file="CR_RecogeDatos.asp"-->
    <input type='hidden' name='estado' value='<%=estado%>'>
    <input type='hidden' name='porciento' value='<%=prepago%>'>
    <input type='hidden' name='importe' value='<%=totalreserva%>'>
    <input type='hidden' name='bruto' value='<%=brutoreserva%>'>
    <input type='hidden' name='moneda' value='<%=monedaHotel%>'>
    <input type='hidden' name='sumaofertas' value='<%=sumaofertas%>'>
    <%if hayofertas then
			for of=0 to ubound(codiOferta)%>
    <input type='hidden' name='codiOferta_<%=of%>' value='<%=codiOferta(of)%>'>
    <input type='hidden' name='textoOferta_<%=of%>' value='<%=textoOferta(of)%>'>
    <input type='hidden' name='pelasOferta_<%=of%>' value='<%=totalOferta(of)%>'>
    <%next
		end if%>
    <div id='contenidoFrame' style="top: 20px; margin: 10; padding: 0;"> 
      <div > 
	    <div style="border-top: 8px solid #178EB6;">
		<table id='Textoresumen' cellpadding="0" cellspacing="1" border="0" width="100%" align="center">
          <tr> 
            <th align="left" colspan="4" class="textoDatosPago">
				<div style="overflow:auto; font-size: 15px; padding: 15px;">
					<%=objIdioma.getTraduccionHTML("i_datosDelPago")%></th>
				</div>
          </tr>
		</table>
		</div>
<div class="navHorizontal" style="background-position:center top;height:2px; width:100%;"></div>
<div class="resumenReserva">
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
				totalhabi=totalHabi+(PrecioPlazas(d,h)-DtoHab(d,h)+TotalSuples(d,h)-DtoSuples(d,h))
			next 'd%>
          <input type="hidden" name='precioHab_<%=h%>' value="<%=totalHabi%>" />
          <tr> 
            <td align="left" class='coluHabi'><%=replace(Vnombreh(h),"�", "&oacute;") %></td>
            <td align="left" class='coluPlazas'> 
              <%nombrecolec=""
				if Vadultos(h)<>0 then nombrecolec="<span class='reservas_bold'>" & iadultos(h) & ":</span>&nbsp;" & Vadultos(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vbebes(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & objIdioma.getTraduccionHTML("i_bebes") & ":</span>&nbsp;" & Vbebes(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vninos1(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & ininos1(h) & ":</span>&nbsp;" & Vninos1(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				if Vninos2(h)<>0 then nombrecolec=nombrecolec & "<span class='reservas_bold'>" & ininos2(h) & ":</span>&nbsp;" & Vninos2(h) & "&nbsp;&nbsp;&nbsp;&nbsp;"
				response.write nombrecolec & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"%>
            </td>
            <td align="left" class='coluRegis'><%=replace(nomsuples(h),"�", "�")%></td>
            <td align="right" class='coluTotal'><%=formatNumber(totalHabi*elCambio,2) & sufijoMoneda%></td>
			<!--<td align="right" class='coluTotal'><%=formatNumber(request.Form("importe_" & h),2) & sufijoMoneda%></td>-->

          </tr>
		  <td align="left" colspan="4" class='coluHabi'>
		  <table id='resumen' cellpadding="0" cellspacing="1" border="0" width="100%" align="center">
			  <tr> 
				<th align="left" style="font-size: 10px;"><%=objIdioma.getTraduccionHTML("i_fecha")%></th>
				<th align="center" style="font-size: 10px;"><%=objIdioma.getTraduccionHTML("i_descuento")%>&nbsp;<%=objIdioma.getTraduccionHTML("i_habitacion")%></th> 
				<th align="center" style="font-size: 10px;"><%=objIdioma.getTraduccionHTML("i_descuento")%>&nbsp;<%=objIdioma.getTraduccionHTML("i_suplemento")%></th> 
				<th align="center" style="font-size: 10px;"><%=objIdioma.getTraduccionHTML("i_precio")%>&nbsp;<%=objIdioma.getTraduccionHTML("i_suplemento")%></th> 
				<th align="right" style="font-size: 10px;"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
			  </tr>
			  <%for hh=1 to noches %>
				  <tr> 
					<td align="left" class='coluPlazas'> <%=FechaRes(hh,h) %></td>
					<td align="center" class='coluPlazas'> <%=DtoHab(hh,h)%></td>
					<td align="center" class='coluPlazas'> <%=DtoSuples(hh,h)%></td>
					<td align="center" class='coluPlazas'> <%=TotalSuples(hh,h)%></td>
					<td align="right" class='coluPlazas'> <%=PrecioPlazas(hh,h)%></td>
				</tr>
			  <%next%>
			</td>
		  </tr>
		  <tr> 
			<td colspan="5"> <hr></td>
		  </tr>
          <%next%>
          <%if hayInfo then 'ofertas informativas no son c�lculos
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
           <tr> 
            <td colspan="4"><%=objIdioma.getTraduccionHTML("i_complementos")%></td>
          </tr>
          <%
			for se = 0 to ubound(RegServi, 2) %>
          <tr> 
            <td align="left" colspan="3" class='coluHabi'> <%=RegServi(SeNombre,se)%>&nbsp; 
              (<%=RegServi(SeColectivo,se) & RegServi(SeCantidad,se) & " x " & formatnumber(RegServi(SePelas,se)*elCambio,2)%>) 
            </td>
            <td align="right" class='coluTotal'> 
              <% 
						totservi = redondear(RegServi(SeCantidad, se) * RegServi(SePelas, se))
						response.write formatnumber(totservi * elCambio, 2) & sufijoMoneda
					%>
            </td>
          </tr>
          <%
				descuento = RegServi(SeDescuento, se)

				if descuento > 0 then
		%>
          <tr> 
            <td align="left" colspan="3" class='coluHabi'> </td>
            <td align="right" class='coluTotal'> - <%= descuento %> </td>
          </tr>
          <%
				end if
			next
		end if 'nservi
		%>
		
          <%
			if RegTempoInfo(TOferta, 0) = 1 then
		%>
           <tr> 
            <td align="left" colspan="4"> <strong><%=objIdioma.getTraduccionHTML("i_oferta_temporada")%>: 
              <%=RegTempoInfo(TTraduccion, 0) %></strong> </td>
          </tr>
          <%
			end if
		%>
          <tr> 
            <td align="left" colspan="2" class='coluHabi'><b><%=objIdioma.getTraduccionHTML("i_noches")%>:&nbsp;<%=noches%></b></td>
            <td align="right" class='coluRegi'><%=objIdioma.getTraduccionHTML("i_total")%></td>
            <td align="right" class='coluTotal'><%=formatnumber((totalreserva + totalServi)*elCambio,2) & sufijoMoneda%></td>
          </tr>
        </table>
</div> 
<div class="navHorizontal" style="background-position:center top;height:2px; width:100%;"></div>


<div class="desgloseReserva">
		<table id='desglose' cellpadding="0" cellspacing="0" border="0" width="100%" align="center" >
          <tr > 
            <td width="50%" align="left" style="border-right: 1px solid #919191;">&nbsp;
				
			</td>
            <td align="left"  class="textoDesglose">
				<table id='desglose' cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
         			<tr> 
            			<td align="left">
						&nbsp;<%=objIdioma.getTraduccionHTML("i_totalres")%>
						</td>
            			<td align="right">
						<div style="color: #F38A12"><%=formatnumber(totalreserva+totalservi,2)%>&nbsp;<%=monedaHotel%></div>
						</td>
					<tr> 
         			<tr> 
            			<td align="left">
						&nbsp;<%=objIdioma.getTraduccionHTML("i_prepago")%>
						</td>
            			<td align="right">
						<div style="color: #F38A12"><%=formatnumber(pelasprepago,2)%>&nbsp;<%=monedaHotel%></div>
						</td>
					<tr> 
         			<tr> 
            			<td align="left" style="border-bottom: 1px solid #919191;">
							<%if (split(Request.ServerVariables("SERVER_NAME"),".")(0)="bookvilla") then%>
								&nbsp;<%=objIdioma.getTraduccionHTML("i_pagopendiente")%>
							<%else%>
								&nbsp;<%=objIdioma.getTraduccionHTML("i_aLaLlegada")%>
							<%end if %>

						</td>
            			<td align="right" style="border-bottom: 1px solid #919191;">
						<div style="color: #F38A12"><%=formatnumber(totalreserva+totalservi-pelasprepago,2)%>&nbsp;<%=monedaHotel%></div>
						</td>
					<tr> 
				</table>
          	</td>
		 <tr> 
          <tr> 
            <td align="left" style="border-right: 1px solid #919191;">&nbsp;
			
          	</td>
            <td align="left"  >
				<br>&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
          	</td>
		 <tr> 

		</table>
 </div>

      </div>
    </div>
    <!--contenido-->
  </form>
</div>
<!-- principal -->
<div id="lblValues"></div>

<%
	set objIdioma = nothing
	
	'for ti = 0 to ubound(RegTempoInfo, 2)
		response.write "<!-- traduccion: " & RegTempoInfo(TTraduccion, 0) & "-->" & vbcrlf
	'next
%>