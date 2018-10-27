<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_cargaPrecios.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="includes/cargaMonedas.asp"--><%

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

function ponCategoria(esa)
	ponCategoria=""
	'separa por el - por si tiene el codigo y el nombre
	codcate=split(esa,"-")
	for ct=0 to ubound(codcate)
		if haycate then
		for cc=0 to ubound(RegCate,2)
			if RegCate(CaCodi,cc)=paClng(codcate(ct)) then 'es este codigo
				if RegCate(CaTipo,cc)=estrella then 'hoteles
					estilo="stars stars-" & left(RegCate(CaNombre,cc),1) 'nº de estrellas
				else 'llaves apartamento
					estilo="keys keys-" & left(RegCate(CaNombre,cc),1) 'nº de llaves
				end if
				ponCategoria=estilo
				exit for
			end if 'este
		next
		end if 'hayCate
	next 'lcate

end function

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
<!--[if IE]> 
<link href="css/iframe.css" rel="stylesheet" type="text/css" />
<link href="css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
<![endif]-->
<script language="javascript" type="text/javascript" src="js/eventosIFrame.js"></script>
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
    <p><%=(ubound(Lista,2)+1) & " " & objIdioma.getTraduccionHTML("i_encontrohotel2")%></p>
    <%else%>
    <p><%=objIdioma.getTraduccionHTML("i_noencontrados2")%></p>
	<%end if%>
    <div id='frameCabecera'>
    	<form name="fb" method="post" action="<%=MiPag%>?ide=<%=idEmpresa%>&amp;lang=<%=lang%>&amp;pr=paso1">
    	<%if request.cookies("idAgencia")<>"" then
			response.write "<p><b>" & objIdioma.getTraduccionHTML("i_bienvenido") & " " & request.cookies("nomAgencia") & "</b></p>"
		end if 'agencia%>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fllegada") & ": "%>
            <a id='afini' href="javascript:abreCalendarFrame('fini');"><%=fini%></a>
            <input type="hidden" name="fini" id='fini' value="<%=fini%>" /><br/>
            <%=objIdioma.getTraduccionHTML("i_noches") & ": <b>" & dateDiff("d",fini,ffin) & "</b><br>"%>
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
            <br/>
		</div>
		<div class="texto">
			<%=objIdioma.getTraduccionHTML("i_fsalida") & ": "%>
            <a id='affin' href="javascript:abreCalendarFrame('ffin');"><%=ffin%></a>
            <input type="hidden" name="ffin" id='ffin' value="<%=ffin%>" /><br/>
            <br/>
            <p style="float:left"><%=objIdioma.getTraduccionHTML("i_ninos")%>:&nbsp;</p>
            <div id='ninos' class='capa_lista' style="float:left">
                <span class='titulo_lista'><%=ninos%></span>
                <div id='listaNinos' class="lista">
                <%for h=0 to 4%>
                   <a href="javascript:ponNinos(<%=h%>);"><%=h%></a>
                <%next%>
                </div>
                <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
            </div> <!--ninos-->
		</div>
        <p class="texto">
        	<a class="boton" href="javascript:enviaBusca();"><%=objIdioma.getTraduccionHTML("i_buscar")%></a>
        </p>
        </form>
        <iframe name="verCalendario" id='verCalendario' class="capaIframe" frameborder="0"></iframe>
		<script language="javascript" type="text/javascript" src="js/buscador.js"></script>
    </div> <!--frameCabecera-->
    
    <div id='contenidoFrame'>
    <%if nlista>-1 then 'hay resultados
	for h=0 to ubound(Lista,2)%>
		<div class="resultado">
        	<div class="izq_resultado">
			<%if Lista(LFoto,h)<>"" then%>
            	<a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>">
                <img width="120" src="<%=Lista(LFoto,h)%>" alt="<%=Lista(LNombre,h)%>" style="margin-right:4px;" border="0"/></a>
            <%end if%>
            </div> <!--izq_resultado-->
            <div class="der_resultado">
            	<h3><a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>">
				<%=Lista(LNombre,h)%><span class='<%=ponCategoria(Lista(LCate,h))%>'></span></a></h3>
                <div class="textoHotel">
                	<%=Lista(LDescri,h)%>                
                </div> <!--textohotel-->
            </div> <!--der_resultado-->
			<div class='habisHotel'>
                <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,h)%>" class="col_habi">
                    <span class="iconoHabi">&nbsp;</span>&nbsp;<%=Lista(LHabi,h)%>
                    <%if Lista(LRegi,h)<>"" then response.write " - " & Lista(LRegi,h)
                    pelasOferta=paDbl(Lista(LOferta,h))
                    pelas=paDbl(Lista(LPelas,h))-pelasOferta
                    'response.write pelas & " - " & pelasOferta & "<br>"
                    if pelasOferta<>0 then response.write " (" & objIdioma.getTraduccionHTML("i_oferta") & ")"
                    %>
                </a>
                <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,h)%>" class="col_reserva"><%=objIdioma.getTraduccionHTML("i_reservar")%></a>
                <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,h)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,h)%>" class="col_precio">
                <b><%=formatnumber(pelas*elCambio,2) & sufijoMoneda%></b></a>
                <br class='clear' />
                <%ultihotel=Lista(LCodi,h)
                for t=h+1 to ubound(Lista,2)
                    if Lista(LCodi,t)=ultihotel then 'es el mismo%>
                    <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,t)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,t)%>" class="col_habi">
                    <span class="iconoHabi">&nbsp;</span>&nbsp;<%=Lista(LHabi,t)%>
                    <%if Lista(LRegi,h)<>"" then response.write " - " & Lista(LRegi,t)
                    pelasOferta=paDbl(Lista(LOferta,t))
                    pelas=paDbl(Lista(LPelas,t))-pelasOferta
                    'response.write pelas & " - " & pelasOferta & "<br>"
                    if pelasOferta<>0 then response.write " (" & objIdioma.getTraduccionHTML("i_oferta") & ")"
                    %>
                    </a>
                    <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,t)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,t)%>" class="col_reserva"><%=objIdioma.getTraduccionHTML("i_reservar")%></a>
                    <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=Lista(LCodi,t)%>&amp;lang=<%=lang%>&amp;fini=<%=fini%>&amp;ffin=<%=ffin%>&amp;ad=<%=adultos%>&amp;ni=<%=ninos%>&amp;th=<%=Lista(LCHabi,t)%>" class="col_precio">
                    <b><%=formatnumber(pelas*elCambio,2) & sufijoMoneda%></b></a>
                    <br class='clear' />
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
