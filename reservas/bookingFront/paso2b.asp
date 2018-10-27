<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_cargaHabitaciones.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

'Valores por defecto
adultos=paClng(request.querystring("ad"))
if adultos=0 then adultos=paClng(request.Form("ad"))
ninos=paClng(request.querystring("ni"))
if ninos=0 then ninos=paClng(request.Form("ni"))
thab=paClng(request.querystring("th"))
tReg=paClng(request.querystring("tr"))
cpromo=request.querystring("promo")

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
<%
'Tablas de max plaza en habitacion
response.Write "<script language='javascript' type='text/javascript'>" & vbcrlf
response.Write "maxcap=new Array ();" & vbcrlf
response.Write "maxadul=new Array ();" & vbcrlf
response.Write "minadul=new Array ();" & vbcrlf
response.Write "maxnin=new Array ();" & vbcrlf
response.Write "mincap=new Array ();" & vbcrlf
response.Write "nombrehabi=new Array ();" & vbcrlf
response.Write "cupohabi=new Array ();" & vbcrlf
response.Write "sumacupo=new Array ();" & vbcrlf
response.Write "cunaocupa=new Array ();" & vbcrlf
if hayhabis then
	for h=0 to ubound(RegHabis,2)
		response.Write "maxcap[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCapMax,h) & ";" & vbcrlf
		response.Write "maxadul[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaAduMax,h) & ";" & vbcrlf
		response.Write "minadul[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaAduMin,h) & ";" & vbcrlf
		response.Write "maxnin[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaNinMax,h) & ";" & vbcrlf
		response.Write "mincap[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCapMin,h) & ";" & vbcrlf
		response.Write "nombrehabi[" & RegHabis(HaCodi,h)  & "] ='" & RegHabis(HaNombre,h) & "';" & vbcrlf
		response.Write "cupohabi[" & RegHabis(HaCodi,h)  & "] ='" & RegHabis(HaCupo,h) & "';" & vbcrlf
		response.Write "cunaocupa[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCunaOcupa,h) & ";" & vbcrlf
	next
end if
response.Write vbcrlf & "suplehabi=new Array ();" & vbcrlf
response.Write "suplecodi=new Array ();" & vbcrlf
response.Write "supleinclu=new Array ();" & vbcrlf
response.Write "suplenombre=new Array ();" & vbcrlf
if haysuples then
	for s=0 to ubound(RegSuples,2)
		response.Write "suplehabi[" & s & "] =" & RegSuples(SHabi,s) & ";" & vbcrlf
		response.Write "suplecodi[" & s & "] =" & RegSuples(SCodi,s) & ";" & vbcrlf
		response.Write "supleinclu[" & s & "] =" & abs(RegSuples(SDefecto,s)) & ";" & vbcrlf
		response.Write "suplenombre[" & s & "] ='" & RegSuples(SNombre,s) & "';" & vbcrlf
	next
end if
response.Write "</script>" & vbcrlf
%>
<script language="JavaScript" type="text/javascript">
var codiHab=0; //codigo hab.
var lacuala=0; //nº de habitacion
var sumaBack=0; //para controlar el volver atras
function HayObjeto(este){
	//Comprobar si un objeto existe
	//lo utilizo para saber si está el tipo de colectivo
	for (t=0;t<document.f1.length;t++){
		if (document.f1[t].name==este)
			return true;
	}
	return false;
}

function SumaPlazas(habi){
	//Busco adultos y niños de ese tipo de habitacion
	var suma;
	suma=0;
	//Buscar en la form todos los del tipo colectivos
	if (HayObjeto("HC0_"+habi))
		suma=parseInt(eval('document.f1.HC0_'+habi+'.value'));
	if (HayObjeto("HC1_"+habi))
		suma=suma+parseInt(eval('document.f1.HC1_'+habi+'.value'));
	if (HayObjeto("HC2_"+habi))
		suma=suma+parseInt(eval('document.f1.HC2_'+habi+'.value'));
	if (cunaocupa[codiHab]){
		if (HayObjeto("HCbebes_"+habi))
			suma=suma+parseInt(eval('document.f1.HCbebes_'+habi+'.value'));
	}
	return suma;
}

function compruebaMinAdul(habi){
	//Busco adultos para comprobar el minimo
	var suma;
	suma=0;
	if (HayObjeto("HC0_"+habi))
		suma=parseInt(eval('document.f1.HC0_'+habi+'.value'));
	
	losminis=parseInt(minadul[codiHab]);
	if (suma<losminis){
		alert(losminis+' <%=objIdioma.getTraduccion("i_adultosminimos")%>');
		return false;
	}
	return true;
}
function CompruebaMax(cuala,erSelect){
	//Comprobar capacidad
	codiHab=parseInt(eval("document.f1.habi_"+cuala+".value"),10);
	//Ocupacion mínima de adultos
	if (!compruebaMinAdul(cuala)){
		erSelect.value='0'; //dejo cantidad a cero
		palFrame(cuala);
		return false;
	}
	
	//Busco adultos y niños de ese tipo de habitacion
	son=SumaPlazas(cuala);
	maxi=parseInt(maxcap[codiHab]);
	if (son>maxi){
		alert('<%=objIdioma.getTraduccion("i_plazasmaximas")%>'+maxi);
		erSelect.value='0'; //dejo cantidad a cero
		palFrame(cuala);
		return false;
	}else{
		palFrame(cuala);
		return true;
	}
}
function CompruebaMin(cuala){
	//Busco adultos y niños de ese tipo de habitacion
	son=SumaPlazas(cuala);
	//Comprobar capacidad
	codiHab=parseInt(eval("document.f1.habi_"+cuala+".value"));
	mini=parseInt(mincap[codiHab]);
	
	if (son<mini){
		alert('<%=objIdioma.getTraduccion("i_plazasminimas")%>'+" ("+nombrehabi[codiHab]+") "+mini+" pax.");
		return false;
	}else{
		return true;
	}
}

function datosHabi(cuala){
	codiHab=parseInt(eval("document.f1.habi_"+cuala+".value"));
	//buscar los suplementos de esa habitación
	eval("document.f1.SU_"+cuala+".length=0"); //vacia
	linea=-1;
	for (s=0;s<suplecodi.length;s++){
		if (suplehabi[s]==0 || suplehabi[s]==codiHab){
			linea++;
			<%if tReg<>0 then %>
				if (suplecodi[s]==<%=tReg%>)
					marcar="defaultSelected";
				else
					marcar="";
			<%else%>
				if (supleinclu[s]==1)
					marcar="defaultSelected";
				else
					marcar="";
			<%end if%>
			var selOpcion=new Option(suplenombre[s],suplecodi[s],marcar); 
			eval("document.f1.SU_"+cuala+".options[linea]=selOpcion");
			if (marcar!="")
				eval("document.f1.SU_"+cuala+".options[linea].selected=true");

		}
	}
	
	//plazas máximas de esa habitación
	//Adultos Max
	eval("document.f1.HC0_"+cuala+".length=1"); //dejo el 0
	for (linea=1;linea<=maxadul[codiHab];linea++){
		<%if adultos<>0 then %>
			if (linea==<%=adultos%>)
				marcar="defaultSelected";
			else
				marcar="";
		<%else%>
			if (mincap[codiHab]==linea)
				marcar="defaultSelected";
			else
				marcar="";
		<%end if%>
		var selOpcion=new Option(linea,linea,marcar); 
		eval("document.f1.HC0_"+cuala+".options[linea]=selOpcion");
		if (marcar!="") //pal explorer
			eval("document.f1.HC0_"+cuala+".options[linea].selected=true");
	}
	//Niños 1 Max
	if (HayObjeto("HC1_"+cuala)){
		eval("document.f1.HC1_"+cuala+".length=1"); //dejo el 0
		for (linea=1;linea<=maxnin[codiHab];linea++){
			marcar="";
			<%if ninos<>0 then %>
				if (linea==<%=ninos%>)
					marcar="defaultSelected";
			<%end if%>
			var selOpcion=new Option(linea,linea,marcar); 
			eval("document.f1.HC1_"+cuala+".options[linea]=selOpcion");
			if (marcar!="") //pal explorer
				eval("document.f1.HC1_"+cuala+".options[linea].selected=true");
		}
	}
	//Niños 2 Max
	if (HayObjeto("HC2_"+cuala)){
		eval("document.f1.HC2_"+cuala+".length=1"); //dejo el 0
		for (linea=1;linea<=maxnin[codiHab];linea++){
			var selOpcion=new Option(linea,linea); 
			eval("document.f1.HC2_"+cuala+".options[linea]=selOpcion");
		}
	}
}

function verHabis(){
	son=parseInt(document.f1.cuantas.value,10);
	for (x=1;x<=4;x++) {
		if (x<=son) {
			$("habita_"+x).style.display='block';
			palFrame(x);
		} else
			$("habita_"+x).style.display='none';
	}
	setTimeout("ajustaIFrame()",200); //el IE es así de cachondo (lento de cojones)
}

function verifica(){
	//Verificar minima ocupacion de las habitaciones
	cuantas=parseInt(document.f1.cuantas.value);
	guena=true;
	for (h=1;h<=cuantas;h++){
		//comprobar capacidades
		mihabi=parseInt(eval("document.f1.habi_"+h+".value"));
		son=SumaPlazas(h);
		maxi=parseInt(maxcap[mihabi]);
		if (son>maxi){
			alert('<%=objIdioma.getTraduccion("i_plazasmaximas")%>'+" ("+nombrehabi[mihabi]+") "+maxi+" pax.");
			guena=false;
		}
	
		if (!CompruebaMin(h))
			guena=false;
		if (eval("document.f1.importe_"+h+".value=='0'")){
			alert('<%=objIdioma.getTraduccion("i_nodisponibles")%>');
			guena=false;
		}
	}
	if (!compruebaCupo())
		guena=false;
		
	if (guena){
		//Pasar nombres a los hidden
		for (h=1;h<=cuantas;h++){
			eval("document.f1.nombrehabi_"+h+".value=document.f1.habi_"+h+".options[document.f1.habi_"+h+".selectedIndex].text");
			eval("document.f1.nombresuple_"+h+".value=document.f1.SU_"+h+".options[document.f1.SU_"+h+".selectedIndex].text");
		}
		//traspaso al otro formulario
		document.f1.fini.value=document.fb.fini.value;
		document.f1.ffin.value=document.fb.ffin.value;
		
		document.f1.action='paso3.asp?ide=<%=IdEmpresa%>&idh=<%=idh%>&lang=<%=lang%>';
		document.f1.submit();
	}
}

function compruebaCupo(){
	//Mirar todas las habitaciones
	cuantas=parseInt(document.f1.cuantas.value);
	//Poner a cero la suma cupos
	<%if hayhabis then
		for h=0 to ubound(RegHabis,2)%>
		sumacupo[<%=RegHabis(HaCodi,h)%>]=0;
		<%next
	end if%>
	//sumar	
	for (h=1;h<=cuantas;h++){
		sumacupo[parseInt(eval("document.f1.habi_"+h+".value"),10)]++;
	}
	<%if hayhabis then
		for h=0 to ubound(RegHabis,2)%>
			if (sumacupo[<%=RegHabis(HaCodi,h)%>]>cupohabi[<%=RegHabis(HaCodi,h)%>]){
				alert(nombrehabi[<%=RegHabis(HaCodi,h)%>]+"\n"+cupohabi[<%=RegHabis(HaCodi,h)%>]+" <%=objIdioma.getTraduccion("i_disponibles")%>.");
				return false;
			}
		<%next
	end if%>
	return true;
}

function palFrame(quehabi){
	lacuala=quehabi;
	//Pasa los valores al frame para hacer los calculos
	ad=0;
	ni1=0;
	ni2=0;
	be=0;
	tr=eval("document.f1.SU_"+quehabi+".value");
	th=eval("document.f1.habi_"+quehabi+".value");
	cpromo=document.f1.cpromo.value;
	if (HayObjeto("HC0_"+quehabi))
		ad=parseInt(eval('document.f1.HC0_'+quehabi+'.value'));
	if (HayObjeto("HC1_"+quehabi))
		ni1=parseInt(eval('document.f1.HC1_'+quehabi+'.value'));
	if (HayObjeto("HC2_"+quehabi))
		ni2=parseInt(eval('document.f1.HC2_'+quehabi+'.value'));
	if (HayObjeto("HCbebes_"+quehabi))
		be=parseInt(eval('document.f1.HCbebes_'+quehabi+'.value'));	

	$('eseframe_'+quehabi).src="Frame_calculoHabi2.asp?fr="+quehabi+"&ide=<%=idEmpresa%>&est=<%=idh%>&fini=<%=fini%>&ffin=<%=ffin%>&th="+th+"&tr="+tr+"&ad="+ad+"&ni1="+ni1+"&ni2="+ni2+"&be="+be+"&promo="+cpromo+"&moneda=<%=coin%>&lang=<%=lang%>";
	//alert($('eseframe_'+quehabi).src);
	$('espera_'+lacuala).style.visibility='visible';
	sumaBack++;
}

function paTras() {
	window.history.go(-sumaBack);
}
function quitaEspera(esa){
	$('espera_'+esa).style.visibility='hidden';
}

function enviaPromo(){
	valor=document.f1.promocode.value;
	$('paProcesos').src="cargaPromocion.asp?est=<%=est%>&pr="+valor+"&lang=<%=lang%>&fllegada=<%=fini%>&fsalida=<%=ffin%>";
	//alert($('paProcesos').src);
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
	<h2 id="capaTitulo"><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h2>
    <div class="resultado capaHotel">
        <div class="izq_resultado">
        <%if fotoHotel<>"" then%>
            <a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>">
            <img width="120" src="<%=fotoHotel%>" alt="<%=nombreHotel%>" style="margin-right:4px;" border="0"/></a>
        <%end if%>
        </div> <!--izq_resultado-->
        <div class="der_resultado">
            <div class="textoHotel">
            	<%if haySecciones then 'texto primer registro
					response.write RegSecciones(SecTexto,0)
				end if%>
            </div> <!--textohotel-->
        </div> <!--der_resultado-->
    </div> <!-- resultado -->

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
		<form name='f1' method="post">
			<input type='hidden' name='nhotel' value='<%=nhotel%>'>
			<input type="hidden" name="H_1" value=''>
			<input type="hidden" name="idagencia" value='<%=request.Cookies("IdAgencia")%>'/>
			<input type="hidden" name="nomagencia" value='<%=request.Cookies("NomAgencia")%>'/>
            <input type="hidden" name="cpromo" value=''/>
            <input type="hidden" name="fini" value="<%=fini%>" />
            <input type="hidden" name="ffin" value="<%=ffin%>" />
        
        	<%if errormsg="" then 'no hay fallos, seguimos%>
	                <div id="nHabitaciones">
                        <span class="reservas_bold"><%=objIdioma.getTraduccionHTML("i_nhabitacion")%>:</span>&nbsp;
                        <select name="cuantas" onChange="javascript:verHabis();" class="cuadro_texto_reservas" style="width:35px">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                        <p><%=objIdioma.getTraduccionHTML("i_ayudanueva")%></p>
                    </div> <!-- nHabitaciones -->
                <div id='tipoHabi'>
                <%for hh=1 to 4%>
                    <div id='habita_<%=hh%>' class="lahabi">
                    	<div><b><%=objIdioma.getTraduccionHTML("i_tipohab")%> - <%=hh%></b></div>
                        <div style="float: left; padding-top:5px; ">
                            <p>
                            <span class="reservas_bold"><%=objIdioma.getTraduccionHTML("i_tipohab")%>:</span>&nbsp;
                            <select name='habi_<%=hh%>' onChange="javascript:datosHabi(<%=hh%>);palFrame(<%=hh%>);" class="cuadro_texto_reservas" style="width:auto">
                                <%if hayhabis then
                                    for h=0 to ubound(RegHabis,2)
                                        marca=""
                                        if clng(RegHabis(HaCodi,h))=thab then marca=" selected"%>
                                        <option value="<%=RegHabis(HaCodi,h)%>"<%=marca%>><%=RegHabis(HaNombre,h)%></option>
                                    <%next
                                end if 'hayhabis%>
                            </select>
                            <input type="hidden" name="nombrehabi_<%=hh%>">
                            </p>
                            <p>
                                <span class="reservas_bold"><%=objIdioma.getTraduccionHTML("i_regimen")%>:</span>&nbsp;
                                <select name="SU_<%=hh%>" class="cuadro_texto_reservas" onChange="javascript:palFrame(<%=hh%>);">
                                </select>
                                <input type="hidden" name="nombresuple_<%=hh%>"><br/>
                                <span class="reservas_bold">
                                <%=objIdioma.getTraduccionHTML("i_total")%>:</span>&nbsp;
                                <span id='verimporte_<%=hh%>'></span>&nbsp;
                                <img id='espera_<%=hh%>' src="img/espera.gif" width="16" height="16" class="espera"/>
                                <input type="hidden" id='importe_<%=hh%>' name="importe_<%=hh%>">
                            </p>
                        </div>
                        <div style="float: left; width:140px; margin-left:50px; padding-top:5px;">
                            <%for t=0 to ubound(RegColec,2)%>
                                <div style="clear:both">
                                <span class="reservas_bold" style="float:left"><%=RegColec(CNombre,t)%>:</span>
                                <select name='HC<%=RegColec(COrden,t)%>_<%=hh%>' onChange="javascript:CompruebaMax(<%=hh%>,this);" style="width:35px; float:right" class="cuadro_texto_reservas">
                                    <option value='0'>0</option>
                                </select>
                                <input type="hidden" name="nombreHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CNombre,t)%>">
                                <input type="hidden" name="codigoHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CCodi,t)%>">
                                </div>
                                <%'Incluir los bebes al final
                                if t=ubound(RegColec,2) then 'Pongo bebes %>
                                    <div style="clear:both">
                                    <span class="reservas_bold" style="float:left"><%=objIdioma.getTraduccionHTML("i_bebes")%>:</span>
                                    <select name='HCbebes_<%=hh%>' style="width:35px; float:right" class="cuadro_texto_reservas" onChange="javascript:CompruebaMax(<%=hh%>,this);">
                                    <%for p=0 to 2%>
                                        <option value='<%=p%>'><%=p%></option>
                                    <%next%>
                                    </select>
                                    <input type="hidden" name="nombreHCBebes_<%=hh%>">
                                    </div>
                                <%end if%>
                            <%next%>
                        </div>
                    </div> <!-- laHabi -->
                    <%next 'nhabis%>
                </div> <!-- tipoHabi -->
				<!--#include file="capa_servicios.asp"-->
				*&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%>
				<div id='pieReserva'>
					<a href="javascript:paTras();" class="boton" style="float:left"><%=objIdioma.getTraduccionHTML("i_anterior")%></a>
					<a href="javascript:verifica();" class="boton" style="float:right;"><%=objIdioma.getTraduccionHTML("i_siguiente")%></a>
				</div>
                <br class="clear" />
				
				<!-- para calculos -->
				<iframe id='eseframe_1' src="" class='capaIframe' onload='javascript:quitaEspera(1);'></iframe>
				<iframe id='eseframe_2' src="" class='capaIframe' onload='javascript:quitaEspera(2);'></iframe>
				<iframe id='eseframe_3' src="" class='capaIframe' onload='javascript:quitaEspera(3);'></iframe>
				<iframe id='eseframe_4' src="" class='capaIframe' onload='javascript:quitaEspera(4);'></iframe>

				<script language="javascript" type="text/javascript">
					//Carga los suplementos en las habis
					datosHabi(1);
					datosHabi(2);
					datosHabi(3);
					datosHabi(4);
					verHabis();
					//palFrame(1);
				</script>

			<%end if 'errormsg=""%>

        </form>
    </div> <!--contenido-->
</div> <!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>
