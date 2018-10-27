<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"--> 
<!--#include file="CR_cargaPrecios.asp"-->
<!--'#include file="CR_extrasHotel.asp"-->
<!--#include file="CR_cargaRegimenesGrupo.asp"-->

<!--#include file="calculoSuplementosExtra.asp"-->

<%set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType = adOpenForwardOnly
rs.LockType = adLockReadOnly


if request.QueryString("fini") <> "" then
	fini = request.QueryString("fini")
	ffin = request.QueryString("ffin")
end if

%><!--#include file="includes/cargaMonedas.asp"--><%

'categorias
cs="SELECT Id, Nombre, IdTipo FROM Categorias"
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

'Promociones
displayPromo=" noPromo" 'por defecto no se ve

cpromo=request.form("cpromo")
if cpromo<>"" then 'buscar titulo oferta
	cs="SELECT Id,ISNULL(dbo.fnGetTraduccion('Ofertas','Titulo',Id,'" & lang & "'),Titulo) AS Titulo "
	cs=cs & "FROM Ofertas "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & idh & " AND Caduca>" & fechaSQLServer(date)
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

	cs="SELECT Id,ISNULL(dbo.fnGetTraduccion('Ofertas','Titulo',Id,'" & lang & "'),Titulo) AS Titulo "
	cs=cs & "FROM Ofertas "
	cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND CodigoEsta=" & idh & " AND Caduca>" & fechaSQLServer(date)
	cs=cs & " AND CodigoPromocion<>''"
	rs.open cs,base
	if not rs.eof then
		displayPromo=" displayPromo" 'para que se vea
	end if
	rs.close

end if 'cpromo
'displayPromo=" displayPromo" 'para que se vea

if request.cookies("idAgencia")="" then 'comprobar
	idagencia=paClng(request.QueryString("idagencia"))
	if idagencia=0 then idagencia=paClng(request.Form("idagencia"))
	if idagencia<>0 then 'buscar datos
		cs="SELECT Nombre FROM Agencias WHERE Id=" & idagencia
		rs.open cs,base
		if not rs.eof then
			response.Cookies("idAgencia")=idagencia
			response.Cookies("nomAgencia")=rs("nombre")
		end if
		rs.close	
	end if 'idagencia<>0
end if 'request.Cookies(idgencia)

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
<script language="javascript" type="text/javascript">
function recalculo(ese,nombreRegi,hotel,habi) {
	$("#titulo_"+hotel+"_"+habi).html(nombreRegi);
	$("#espera_"+hotel+"_"+habi).css("display",'block');
	url="Frame_recalculo.asp?ide=<%=idEmpresa%>&est="+hotel+"&fini=<%=fini%>&ffin=<%=ffin%>&th="+habi+"&tr="+ese+"&ad=<%=adultos%>&ni1=<%=ninos%>&promo=<%=cpromo%>&moneda=<%=coin%>&lang=<%=lang%>";
	$("#precio_"+hotel+"_"+habi).load(url,'',function(){
	   $("#espera_"+hotel+"_"+habi).css("display",'none');
	 });
}
function cargaPromo() {
	cpromo=$("#cpromo").val();
	$("#espera_promo").css("display",'block');
	url="cargaPromocion.asp?ide=<%=idEmpresa%>&est=<%=idh%>&fini=<%=fini%>&ffin=<%=ffin%>&lang=<%=lang%>";
	$("#textopromo").load(url,'',function(){
	   $("#espera_promo").css("display",'none');
	 });
}
</script>
</head>
<body>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<input type="hidden" id='moneda' name="moneda" value="<%=coin%>" />
<div id='principalFrame'>
	<!--#include file="monedas.asp"-->
	<h2 id="capaTitulo"><%=objIdioma.getTraduccionHTML("i_resultadobusqueda")%></h2>
    <%if nlista>-1 then%>
    <p><%=nResultados & " " & objIdioma.getTraduccionHTML("i_encontrohotel2")%></p>
    <%else%>
    <p><%=objIdioma.getTraduccionHTML("i_noencontrados2")%></p>
	<%end if%>
    <div id='frameCabecera'>
    	<form name="fb" method="post" action="<%=MiPag%>?ide=<%=idEmpresa%>&amp;lang=<%=lang%>&amp;pr=paso1">
       	<input type="hidden" name="idEmpresa" id='idEmpresa' value="<%=idEmpresa%>" />
        <%if request.cookies("idAgencia")<>"" then
			response.write "<p><b>" & objIdioma.getTraduccionHTML("i_bienvenido") & " " & request.cookies("nomAgencia") & "</b></p>"
		end if 'agencia%>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fllegada") & ": "%>
            <a id='afini' href="javascript:abreCalendarFrame('fini');"><%=fini%></a>
            <input type="hidden" name="fini" id='fini' value="<%=fini%>" /><br/>
            <%nochesMin=objIdioma.getTraduccionHTML("i_nomin3y4")%>
            
            <%=objIdioma.getTraduccionHTML("i_noches") & ": <b>" & dateDiff("d",fini,ffin) & "</b>" & nochesMin & "<br />"					            %>
			<% if idEmpresa <> 94 then%>
				<!--código de BCM-->
                <p style="float:left"><%=objIdioma.getTraduccionHTML("i_adultos")%>:&nbsp;</p>
             
                <div id='adultos' class='capa_lista' style="float:left">
                    <span class='titulo_lista'><%=adultos%></span>
                    <div id='listaAdultos' class="lista">
                    <%for h=1 to 6%>
                       <a href="javascript:ponAdultos(<%=h%>);"><%=h%></a>
                    <%next%>
                    </div>
                    <input type="hidden" name="ad" id="ad" value='<%=adultos%>' />
                </div> <!--adultos-->
            <%end if%>
            <br/>
		</div>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fsalida") & ": "%>
            <a id='affin' href="javascript:abreCalendarFrame('ffin');"><%=ffin%></a>
            <input type="hidden" name="ffin" id='ffin' value="<%=ffin%>" /><br/>
            <br/>
             <%if admiteninos then %>
            <p style="float:left"><%=objIdioma.getTraduccionHTML("i_ninos")%>:&nbsp;</p>
            <div id='ninos' class='capa_lista' style="float:left">
                <span class='titulo_lista'><%=ninos%></span>
                <div id='listaNinos' class="lista">
                <%for h=0 to 4%>
                   <a href="javascript:ponNinos(<%=h%>);"><%=h%></a>
                <%next%>
                    <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
                </div>
                <%Else %> 
                   <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
           <%End if %>  
           <!--ninos-->
		</div>
        <br class="clear<%=displayPromo%>" />
        <div class="texto<%=displayPromo%>">
        	<%=objIdioma.getTraduccionHTML("i_codpromocion") & ": "%>
            <input type="text" name="cpromo" id='cpromo' value="<%=cpromo%>" /><span id='textopromo'></span>
            <input type="hidden" name="npromo" id='npromo' value="<%=npromo%>" />
        </div>
        <p class="texto">
        	<a class="boton" href="javascript:enviaBusca();"><%=objIdioma.getTraduccionHTML("i_buscar")%></a>
        </p>
        </form>
        <iframe name="verCalendario" id='verCalendario' src="vacio.html" class="capaIframe" frameborder="0"></iframe>
		<script language="javascript" type="text/javascript" src="js/buscador.js"></script>
    </div> <!--frameCabecera-->
    
    <div id='contenidoFrame'>
    <%if nlista>-1 then 'hay resultados
	for h=0 to ubound(Lista,2)%>
		<div class="resultado">
			<%if Lista(LFoto,h)<>"" then%>
            <div class="izq_resultado">
            	<a href="http://booking.kubikcrs.com/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>">
                <img width="120" src="<%=renombraFoto(Lista(LFoto,h),"Th_")%>" alt="<%=Lista(LNombre,h)%>" style="margin-right:4px;" border="0"/></a>
			</div> <!--izq_resultado-->
            <%end if%>
            <div class="der_resultado">
            	<h3><a href="http://booking.kubikcrs.com/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>">
				<%=Lista(LNombre,h)%><span class='<%=ponCategoria(Lista(LCate,h))%>'></span></a></h3>
                <div class="textoHotel">
                	<%=Lista(LDescri,h)%>                
                </div> <!--textohotel-->
          
            </div> <!--der_resultado-->
            
			<div class='habisHotel'>
             <%if idEmpresa = 94 then%>
                <div class="col_habi">
                 	<%=objIdioma.getTraduccionHTML("i_diasminimos")%>&nbsp;<%=Lista(LHDiasMin,h)%>
                </div>
                <div class="clear"></div>
            <%end if%>
            	<%
					ultihotel = Lista(LCodi, h)
					
					ofertatem = paDbl(Lista(LOfertaTem, t))
					
                	for t = h to ubound(Lista, 2)
						if Lista(LCodi, t) = ultihotel then 'es el mismo
				%>
                            <div class="col_habi">
                                <span class="iconoHabi">&nbsp;</span>&nbsp;<%=Lista(LHabi,t)%>&nbsp;
                                 <%'if Lista(LRegi,h)<>"" then response.write " - " & Lista(LRegi,h)
                                pelasOferta = paDbl(Lista(LOferta, t))
                                pelas = paDbl(Lista(LPelas, t)) - pelasOferta
								
								if pelasOferta <> 0 or ofertatem = 1 then 
                                    response.write "(" & objIdioma.getTraduccionHTML("i_oferta") & ")&nbsp;"
                                end if
                                %>
                            </div>
                
                            <div id='regi_<%=Lista(LCodi,t)%>_<%=Lista(LCHabi,t)%>' class='capa_lista'>
                                <span id='titulo_<%=Lista(LCodi,t)%>_<%=Lista(LCHabi,t)%>' class='titulo_lista'>
                                <%=Lista(LRegi,h)%></span>
                                <div id='listaHabi_<%=Lista(LCodi,t)%>_<%=Lista(LCHabi,t)%>' class="lista">
                                <%if haySuples then
                                for ss=0 to ubound(RegSuples,2)
                                    if RegSuples(SHotel,ss) = paClng(Lista(LCodi,t)) then 'es de este hotel
                                    if RegSuples(SHabi,ss) = 0 or RegSuples(SHabi,ss) = paClng(Lista(LCHabi,t)) then																		'
								%>
                                    <a href="javascript:recalculo(<%=RegSuples(SIdRegi,ss)%>,'<%=RegSuples(SNombre,ss)%>',<%=Lista(LCodi,t)%>,<%=Lista(LCHabi,t)%>);">
                                    <%=RegSuples(SNombre, ss)%></a>
                                    <%end if 'esa habi
                                    end if 'de ese hotel
                                next
                                end if 'haySuple %>
                                </div>
                            </div> <!--regimen-->
                
                <a id='enlace_<%=Lista(LCodi,t)%>_<%=Lista(LCHabi,t)%>' href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,t)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,t)%>" class="col_reserva"><%=objIdioma.getTraduccionHTML("i_reservar")%></a>
                <a id='precio_<%=Lista(LCodi,t)%>_<%=Lista(LCHabi,t)%>' href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,t)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,t)%>" class="col_precio">
                <b><%=formatnumber(pelas * elCambio, 2) & sufijoMoneda %></b></a>
                <img id='espera_<%= Lista(LCodi,t) %>_<%= Lista(LCHabi,t) %>' src="img/espera.gif" width="16" height="16" class="floatRight" />
               
                <br class='clear' />
                 <%if idEmpresa=94 then%>
                	<p><strong><%=objIdioma.getTraduccionHTML("i_entradasincluidas")%></strong></p>
				<%end if%>
                    <%else 'cambia hotel
                        exit for
                    end if 'mismo hotel
                next 't
                h=t-1 'pa que siga%>
            </div> <!--habisHotel-->

        </div> <!-- resultado -->
    <%next
	end if 'nlista>-1 %>
    </div> <!--contenido-->
</div> <!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>
