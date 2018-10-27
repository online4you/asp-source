<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_cargaHabitaciones.asp"-->
<%'responseLog(xmlURL & parametros & "<br>")%>
<!--#include file="CR_extrasHotel.asp"-->
<%
	SId = SCodi

set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

'Valores por defecto
adultos=paClng(request.querystring("ad"))
if adultos=0 then adultos=paClng(request.Form("ad"))
if adultos=0 then adultos=2 'por defecto
ninos=paClng(request.querystring(" ni"))
if ninos=0 then ninos=paClng(request.Form("ni"))
thab=paClng(request.querystring("th"))
tReg=paClng(request.querystring("tr"))
cpromo=request.querystring("promo")
if cpromo="" then cpromo=request.Form("cpromo")

if idEmpresa= 94 and idh=1 then 'idh=1 es el código del hotel martinique de BCM (idEmpresa=94)
	nochesMinimas=objIdioma.getTraduccionHTML("i_nominmartinique") + "<br />"
else
	nochesMinimas=objIdioma.getTraduccionHTML("i_nochesminimas") + "<br />"
end if

temporada = request.querystring("tem")

'fini = request.form("fini")
'ffin = request.form("ffin")

'response.write fini & " - " & ffin

'Nombre habitacion elegida
if thab=0 then 
	if hayhabis then 
		nombreHabi=RegHabis(HaNombre,0) 'coge la primera
		tHab=RegHabis(HaCodi,0) 'coge la primera
	end if
else
	if hayhabis then
	for h=0 to ubound(RegHabis,2)
		if thab=RegHabis(HaCodi,h) then
			nombreHabi=RegHabis(HaNombre,h)
			exit for
		end if
	next 'h
	end if 'hayhabis
end if 'thab=0

'Nombre regimen elegido
if tReg=0 then 
	if haySuples then 
		for h=0 to ubound(RegSuples,2)
		if RegSuples(SDefecto,h) then
			nombreRegi=RegSuples(SNombre,h) 'coge por defecto
			tReg=RegSuples(SIdRegi,h) 'coge por defecto
			exit for
		end if
		next 'h
	end if
else
	if haySuples then
	for h=0 to ubound(RegSuples,2)
		if tReg=RegSuples(SIdRegi,h) then
			nombreRegi=RegSuples(SNombre,h)
			exit for
		end if
	next 'h
	end if 'hayhabis
end if 'thab=0

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="includes/cargaMonedas.asp"--><%

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


'Promociones
displayPromo=" noPromo" 'por defecto no se ve

cpromo=request.form("cpromo")
if cpromo<>"" then 'buscar titulo oferta
	cs="SELECT Id,IF(ISNULL(traduc.Traduccion),Ofertas.Titulo,traduc.Traduccion) AS Titulo "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Ofertas"" And Campo = ""Titulo"" And Idioma = """ & lang & """)  AS traduc ON Ofertas.Id = traduc.IdReferencia  "
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

	cs="SELECT Id,IF(ISNULL(traduc.Traduccion),Ofertas.Titulo,traduc.Traduccion) AS Titulo "
	cs=cs & "FROM " & precrs & "Ofertas Ofertas "
	cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Ofertas"" And Campo = ""Titulo"" And Idioma = """ & lang & """)  AS traduc ON Ofertas.Id = traduc.IdReferencia  "
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
response.Write "admininos=new Array ();" & vbcrlf
response.Write "fotohabi=new Array ();" & vbcrlf
response.Write "textohabi=new Array ();" & vbcrlf
if hayhabis then
	for h=0 to ubound(RegHabis,2)
		response.Write "maxcap[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCapMax,h) & ";" & vbcrlf
		response.Write "maxadul[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaAduMax,h) & ";" & vbcrlf
		response.Write "minadul[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaAduMin,h) & ";" & vbcrlf
		response.Write "maxnin[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaNinMax,h) & ";" & vbcrlf
		response.Write "mincap[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCapMin,h) & ";" & vbcrlf
		response.Write "nombrehabi[" & RegHabis(HaCodi,h)  & "] ='" & RegHabis(HaNombre,h) & "';" & vbcrlf
		response.Write "cupohabi[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCupo,h) & ";" & vbcrlf
		response.Write "cunaocupa[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaCunaOcupa,h) & ";" & vbcrlf
		 if Not(admiteninos) then  'la empresa no admite ninios
		   response.Write "admininos[" & RegHabis(HaCodi,h)  & "] =0;" & vbcrlf
		  else
		   response.Write "admininos[" & RegHabis(HaCodi,h)  & "] =" & RegHabis(HaAdmiNinos,h) & ";" & vbcrlf
		 end if 
		response.Write "fotohabi[" & RegHabis(HaCodi,h)  & "] ='" & replace(RegHabis(HaFotos,h),"http://www.online4you.es/reservas/crs/fotos","http://www.online4you.es/reservas/bookingFront/fotos") & "';" & vbcrlf
		response.Write "textohabi[" & RegHabis(HaCodi,h)  & "] ='" & SaltoLinea(RegHabis(HaTextos,h)) & "';" & vbcrlf
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
		return false;
	}
	
	//Busco adultos y niños de ese tipo de habitacion
	son=SumaPlazas(cuala);
	maxi=parseInt(maxcap[codiHab]);
	if (son>maxi){
		alert('<%=objIdioma.getTraduccion("i_plazasmaximas")%>'+maxi);
		return false;
	}else{
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

function cambiaPlazas(cuala, plazas, orden)
{
	plazasAnterior=eval("document.f1.HC"+orden+"_"+cuala+".value");
	eval("document.f1.HC"+orden+"_"+cuala+".value="+plazas); //plazas nuevas
	
	if (CompruebaMax(cuala,plazas)) {
		//actualizar select
		var lista=$("#sColec"+orden+"_"+cuala+" span.titulo_lista");
		for (i=0;i<lista.length;i++)
			lista[i].innerHTML=plazas; //poner la seleccion en el select
		
		eval("document.f1.HC"+orden+"_"+cuala+".value="+plazas);
		palFrame(cuala);
	}else{
		eval("document.f1.HC"+orden+"_"+cuala+".value="+plazasAnterior); //volver a las anteriores
	}
	
	<% if hayservis then %>
		cargaServi();
	<% end if %>
}

function cambiaRegi(cuala,codiRegi) {
	//buscar nombre suple
	nombreRegi=""
	for (s=0;s<suplecodi.length;s++){
		if (suplecodi[s]==codiRegi){
			nombreRegi=suplenombre[s];
			break;
		}
	}

	var lista=$("#sRegi_"+cuala+" span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=nombreRegi; //poner la seleccion en el select
	
	eval("document.f1.SU_"+cuala+".value="+codiRegi);
	eval("document.f1.nombresuple_"+cuala+".value='"+nombreRegi+"'");
	palFrame(cuala);
	
	<% if hayservis then %>
		cargaServi();
	<% end if %>
}
function datosHabi(cuala,codiHab){
	//buscar nombre habitacion
	var lista=$("#sHabi_"+cuala+" span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=nombrehabi[codiHab]; //poner la seleccion en el select
	
	eval("document.f1.habi_"+cuala+".value="+codiHab);
	eval("document.f1.nombrehabi_"+cuala+".value='"+nombrehabi[codiHab]+"'");
	
	
	//Texto habitacion
	$('#textohabi_'+cuala).html(textohabi[codiHab]);
	//Fotos de la habitacion

	/*fotoshtml='';
	lfotos=fotohabi[codiHab].split(";");
	if (lfotos.length>0) {
		fotoshtml="<img id='fhabi_"+cuala+"' src='"+lfotos[0]+"' class='fotoHabitacion' />";
		fotoshtml=fotoshtml+"<p class='ahabi'>";
		for (fot=0;fot<lfotos.length;fot++) {
			if (lfotos[fot]!='') {
			fotoshtml=fotoshtml+"<a id='fhabi_"+cuala+"-"+fot+"' href=javascript:cargaFotoHabi('"+lfotos[fot]+"','fhabi_"+cuala+"') class='thumbnailHabi'>";
			fotoshtml=fotoshtml+(fot+1)+"</a>&nbsp;";
			}
		}
		fotoshtml=fotoshtml+"</p>";
		$('#fotohabi_'+cuala).html(fotoshtml);
	}*/
	
	//buscar los suplementos de esa habitación
	//borrar los enlaces actuales del select regimen
	$('#listaRegis_'+cuala).html('');
	codigosuple='';
	nombresuple='';
	for (s=0;s<suplecodi.length;s++){
		if (suplehabi[s]==0 || suplehabi[s]==codiHab){
			//añadir los enlaces a la capa
			newEnlace="<a href='javascript:cambiaRegi("+cuala+","+suplecodi[s]+")'>"+suplenombre[s]+"</a>";
			$('#listaRegis_'+cuala).append(newEnlace);
			//carga primer suplemento o el marcado
			if (codigosuple=='') { 
				codigosuple=suplecodi[s];
				nombresuple=suplenombre[s];
			}
		}
	}
	$("#sRegi_"+cuala+" span.titulo_lista").html(nombresuple); //poner la seleccion en el select
	$("#SU_"+cuala).val(codigosuple);
	$("#nombresuple_"+cuala).val(nombresuple);


	//plazas máximas de esa habitación
	//Adultos Max
	$('#listaColec0_'+cuala).html('');
	//alert('minadul[codiHab]='+minadul[codiHab]);
	for (linea=minadul[codiHab];linea<=maxadul[codiHab];linea++){
		//añadir los enlaces a la capa
		newEnlace="<a href=javascript:cambiaPlazas("+cuala+","+linea+",'0')>"+linea+"</a>";
		//alert('newEnlace='+newEnlace);
		$('#listaColec0_'+cuala).append(newEnlace);
	}
	if (<%=adultos%>>=minadul[codiHab] && <%=adultos%><=maxadul[codiHab])
		nplazas=<%=adultos%>;
	else
		nplazas=minadul[codiHab];
	
	var lista=$("#sColec0_"+cuala+" span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=nplazas; //poner la seleccion en el select
	eval("document.f1.HC0_"+cuala+".value="+nplazas);
	
	//ocultar bebes si no hacen falta
	if (admininos[codiHab]==0)
		$(".divninos").css("display","none");
	else
		$(".divninos").css("display","block");
	
	//Niños 1 hasta MaxNiños
	if (HayObjeto("HC1_"+cuala)){
		
		$('#listaColec1_'+cuala).html('');
		for (linea=0;linea<=maxnin[codiHab];linea++){
			//añadir los enlaces a la capa
			newEnlace="<a href=javascript:cambiaPlazas("+cuala+","+linea+",'1')>"+linea+"</a>";
			$('#listaColec1_'+cuala).append(newEnlace);
		}
		
		nplazas=<%=ninos%>;
		if (<%=ninos%>>maxnin[codiHab] || <%=(adultos+ninos)%>>maxcap[codiHab])
			nplazas=0;

		var lista=$("#sColec1_"+cuala+" span.titulo_lista");
		for (i=0;i<lista.length;i++)
			lista[i].innerHTML=nplazas; //poner la seleccion en el select
		eval("document.f1.HC1_"+cuala+".value="+nplazas);
		
	} //hay niños 1
	
	
	//Niños 2 hasta MaxNiños
	if (HayObjeto("HC2_"+cuala)){
		$('#listaColec2_'+cuala).html('');
		for (linea=0;linea<=maxnin[codiHab];linea++){
			//añadir los enlaces a la capa
			newEnlace="<a href=javascript:cambiaPlazas("+cuala+","+linea+",'2')>"+linea+"</a>";
			$('#listaColec2_'+cuala).append(newEnlace);
		}
		nplazas=0;
		var lista=$("#sColec2_"+cuala+" span.titulo_lista");
		for (i=0;i<lista.length;i++)
			lista[i].innerHTML=0; //poner la seleccion en el select
		eval("document.f1.HC2_"+cuala+".value=0");
	} //hay niños 2
	
	<% if hayservis then %>
		cargaServi();
	<% end if %>
}

function verHabis(son){
	//son=parseInt(document.f1.cuantas.value,10);
	for (x=1;x<=4;x++) {
		if (x<=son) {
			$("#habita_"+x).css('display','block');
			palFrame(x);
		} else
			$("#habita_"+x).css('display','none');
	}
	var lista=$("#cuantasH span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=son; //poner la seleccion en el select
	document.f1.cuantas.value=son; //actualiza input
	//setTimeout("ajustaIFrame()",200); //el IE es así de cachondo (lento de cojones)
	
	<%if hayservis then 'recalcula%>
		cargaServi();
	<%end if%>
	
	//ajustar iframe padre si tiene
	/*if (parent.controlAlto()) {
		//alert("Ta");
	}*/
}

function verifica(){
	//Verificar minima ocupacion de las habitaciones
	cuantas=parseInt(document.f1.cuantas.value,10);
	guena=true;
	for (h=1;h<=cuantas;h++){
		//comprobar capacidades
		mihabi=parseInt(eval("document.f1.habi_"+h+".value"),10);
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
		//traspaso al otro formulario
		document.f1.fini.value=document.fb.fini.value;
		document.f1.ffin.value=document.fb.ffin.value;
		
		document.f1.action='http://www.online4you.es/reservas/bookingFront/paso3.asp?ide=<%=IdEmpresa%>&idh=<%=idh%>&lang=<%=lang%>';
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

	url="Frame_calculoHabi.asp?fr="+quehabi+"&ide=<%=idEmpresa%>&est=<%=idh%>&fini=<%=fini%>&ffin=<%=ffin%>&th="+th+"&tr="+tr+"&ad="+ad+"&ni1="+ni1+"&ni2="+ni2+"&be="+be+"&promo="+cpromo+"&moneda=<%=coin%>&lang=<%=lang%>";
	<%if esPlaneta then%>
	//alert(url);
	
	<%end if%>
	$('#espera_'+quehabi).css('visibility','visible');
	$("#verimporte_"+quehabi).load(url,'',function(){
	   $('#espera_'+quehabi).css('visibility','hidden');
	 }); 
}

function cargaPromo() {
	cpromo=$("#codpromo").val();
	$("#espera_promo").css("visibility",'visible');
	url="cargaPromocion.asp?ide=<%=idEmpresa%>&est=<%=idh%>&cpromo="+cpromo+"&fini=<%=fini%>&ffin=<%=ffin%>&lang=<%=lang%>";
	$("#textopromo").load(url,'',function(){
	   $("#espera_promo").css("visibility",'hidden');
	   son=$("#cuantas").val();
	   verHabis(son);
	 });
}
</script>
</head>
<body>
<iframe name="paProcesos" id='paProcesos' src="vacio.html" class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<input type="hidden" id='moneda' name="moneda" value="<%=coin%>" />
<input type="hidden" name="ofertaActiva" id="ofertaActiva" value="0" />
<div id='principalFrame'> 
  <!--#include file="monedas.asp"-->
  <a href="http://www.online4you.es/reservas/bookingFront/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>"> 
  <h2 id="capaTitulo"><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h2>
  </a> 
  <div class="resultado capaHotel"> 
    <%if fotoHotel<>"" then%>
    <div class="izq_resultado"> <a href="http://www.online4you.es/reservas/bookingFront/fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>"> 
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
  <div id='frameCabecera'> 
    <form name="fb" method="post" action="<%=MiPag%>?ide=<%=idEmpresa%>&amp;lang=<%=lang%>&amp;idh=<%=idh%>&amp;th=<%=tHab%>&amp;tr=<%=tReg%>">
      <input type="hidden" name="idEmpresa" id='idEmpresa' value="<%=idEmpresa%>" />
      <%if request.cookies("idAgencia")<>"" then
			response.write "<p><b>" & objIdioma.getTraduccionHTML("i_bienvenido") & " " & request.cookies("nomAgencia") & "</b></p>"
		end if 'agencia%>
      <div class="texto"> <%=objIdioma.getTraduccionHTML("i_fllegada") & ": "%> 
        <a id='afini' href="javascript:abreCalendarFrame('fini');"><%=fini%></a> 
        <input type="hidden" name="fini" id='fini' value="<%=fini%>" />
        <br/>
        <%=objIdioma.getTraduccionHTML("i_noches") & ": <b>" & dateDiff("d",fini,ffin) & "</b>" & nochesMinimas %> 
        <%if idEmpresa <> 94 then%>
        <p style="float:left"><%=objIdioma.getTraduccionHTML("i_adultos")%>:&nbsp;</p>
        <div id='adultos' class='capa_lista' style="float:left"> <span class='titulo_lista'><%=adultos%></span> 
          <div id='listaAdultos' class="lista"> 
            <%for h=1 to 6%>
            <a href="javascript:ponAdultos(<%=h%>);"><%=h%></a> 
            <%next%>
          </div>
          <input type="hidden" name="ad" id="ad" value='<%=adultos%>' />
        </div>
        <!--adultos-->
        <%end if%>
        <br/>
      </div>
      <div class="texto"> <%=objIdioma.getTraduccionHTML("i_fsalida") & ": "%> 
        <a id='affin' href="javascript:abreCalendarFrame('ffin');"><%=ffin%></a> 
        <input type="hidden" name="ffin" id='ffin' value="<%=ffin%>" />
        <br/>
        <br/>
        <%if admiteninos then %>
        <p style="float:left"><%=objIdioma.getTraduccionHTML("i_ninos")%>:&nbsp;</p>
        <div id='ninos' class='capa_lista' style="float:left"> <span class='titulo_lista'><%=ninos%></span> 
          <div id='listaNinos' class="lista"> 
            <%for h=0 to 4%>
            <a href="javascript:ponNinos(<%=h%>);"><%=h%></a> 
            <%next%>
          </div>
          <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
        </div>
        <%Else %>
        <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
        <%End if %>
        <!--ninos-->
      </div>
      <p class="texto"> <a class="boton" href="javascript:enviaBusca();"><%=objIdioma.getTraduccionHTML("i_buscar")%></a> 
      </p>
      <br class="clear<%=displayPromo%>" />
      <div class="texto<%=displayPromo%>"> <span><%=objIdioma.getTraduccionHTML("i_codpromocion") & ": "%></span> 
        <span> 
        <input type="text" name="codpromo" id='codpromo' value="<%=cpromo%>" />
        <img id='espera_promo' src="img/espera.gif" width="16" height="16" class="esperaPromo"/> 
        <a class="botonPromo" href="javascript:cargaPromo();"><%=objIdioma.getTraduccionHTML("i_comprobar")%></a> 
        <span id='textopromo'></span> </span> </div>
      <input type="hidden" name="cpromo" id='cpromo' value='<%=cpromo%>'/>
      <input type="hidden" name="npromo" id="npromo" value='<%=npromo%>'/>
    </form>
    <iframe name="verCalendario" id='verCalendario' class="capaIframe" frameborder="0"></iframe>
    <script language="javascript" type="text/javascript" src="js/buscador.js"></script>
  </div>
  <!--frameCabecera-->
  <div id='contenidoFrame'> 
    <form name='f1' method="post">
      <input type='hidden' name='nhotel' value='<%=nhotel%>'>
      <input type="hidden" name="H_1" value=''>
      <input type="hidden" name="idagencia" value='<%=request.Cookies("IdAgencia")%>'/>
      <input type="hidden" name="nomagencia" value='<%=request.Cookies("NomAgencia")%>'/>
      <input type="hidden" name="cpromo" id='cpromo' value='<%=cpromo%>'/>
      <input type="hidden" name="npromo" id="npromo" value='<%=npromo%>'/>
      <input type="hidden" name="fini" value="<%=fini%>" />
      <input type="hidden" name="ffin" value="<%=ffin%>" />
      <input type="hidden" name="temporada" value="<%= temporada %>" />
      <%if errormsg="" then 'no hay fallos, seguimos%>
      <div id="nHabitaciones"> <span class="nhabis"><%=objIdioma.getTraduccionHTML("i_nhabitacion")%>:</span> 
        <div id='cuantasH' class='capa_lista'> <span class='titulo_lista'>1</span> 
          <div id='listaCuantas' class="lista"> 
            <%for h=1 to 4%>
            <a href="javascript:verHabis(<%=h%>);"><%=h%></a> 
            <%next%>
          </div>
          <input type="hidden" name="cuantas" id="cuantas" value='1' />
        </div>
        <!--ninos-->
        <p><%=objIdioma.getTraduccionHTML("i_ayudanueva")%></p>
      </div>
      <!-- nHabitaciones -->
      <div id='tipoHabi'> 
        <%for hh=1 to 4%>
        <div id='habita_<%=hh%>' class="lahabi"> 
          <%if RegHabis(HaFotos,0)<>"" AND RegHabis(HaTextos,0)<>"" then 'fotos y textos %>
          <!--#include file="habiFotosTextos.asp"-->
          <%else 'sin fotos %>
          <div><b><%=objIdioma.getTraduccionHTML("i_tipohab")%> - <%=hh%></b></div>
          <div class='columna_izq'> 
            <div class="eligeHabi"> <span class='tituHabi'><%=objIdioma.getTraduccionHTML("i_tipohab")%>:</span> 
              <div id='sHabi_<%=hh%>' class='capa_lista'> <span class='titulo_lista'><%=nombreHabi%></span> 
                <div id='listaHabis_<%=hh%>' class="lista"> 
                  <%if hayhabis then
                                    for h=0 to ubound(RegHabis,2)%>
                  <a href="javascript:datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>);palFrame(<%=hh%>);"> 
                  <%=RegHabis(HaNombre,h)%></a> 
                  <%next
                                	end if 'hayhabis%>
                </div>
                <input type="hidden" name="habi_<%=hh%>" id="habi_<%=hh%>" value='<%=thab%>' />
                <input type="hidden" name="nombrehabi_<%=hh%>" id='nombrehabi_<%=hh%>' value="<%=nombreHabi%>">
              </div>
              <!--sHabi_-->
            </div>
            <div class="eligeHabi"> <span class='tituHabi'><%=objIdioma.getTraduccionHTML("i_regimen")%>:</span> 
              <div id='sRegi_<%=hh%>' class='capa_lista'> <span class='titulo_lista'><%=nombreRegi%></span> 
                <div id='listaRegis_<%=hh%>' class="lista"></div>
                <input type="hidden" name="SU_<%=hh%>" id="SU_<%=hh%>" value='<%=tReg%>' />
                <input type="hidden" name="nombresuple_<%=hh%>" id='nombresuple_<%=hh%>' value="<%=nombreRegi%>">
              </div>
              <!--sRegi_-->
            </div>
            <span class="reservas_bold"> <%=objIdioma.getTraduccionHTML("i_total")%>:</span>&nbsp; 
            <span id='verimporte_<%=hh%>'></span>&nbsp; 
            <%if idEmpresa=94 then%>
            <p><strong><%=objIdioma.getTraduccionHTML("i_entradasincluidas")%></strong></p>
            <%end if%>
            <img id='espera_<%=hh%>' src="img/espera.gif" width="16" height="16" class="espera"/> 
            <input type="hidden" id='importe_<%=hh%>' name="importe_<%=hh%>">
            <input type="hidden" id='descuentopct_<%=hh%>' name="descuentopct_<%=hh%>">
          </div>
          <div class="columna_der"> 
            <%for t=0 to ubound(RegColec,2)%>
            <div class="eligePlazas"> <span class='tituHabi'><%=RegColec(CNombre,t)%>:</span> 
              <div id='sColec<%=RegColec(COrden,t)%>_<%=hh%>' class='capa_lista size40'> 
                <span class='titulo_lista'>0</span> 
                <div id='listaColec<%=RegColec(COrden,t)%>_<%=hh%>' class="lista"></div>
                <input type="hidden" name="HC<%=RegColec(COrden,t)%>_<%=hh%>"  value="" />
                <input type="hidden" name="nombreHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CNombre,t)%>">
                <input type="hidden" name="codigoHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CCodi,t)%>">
              </div>
              <!--sColec-->
            </div>
            <%'Incluir los bebes al final
                                if t=ubound(RegColec,2) then 'Pongo bebes %>
            <div class="eligePlazas divninos"> <span class='tituHabi'><%=objIdioma.getTraduccionHTML("i_bebes")%>:</span> 
              <div id='sColecbebes_<%=hh%>' class='capa_lista size40'> <span class='titulo_lista'>0</span> 
                <div id='listaBebes_<%=hh%>' class="lista"> 
                  <%for p=0 to 2%>
                  <a href="javascript:cambiaPlazas(<%=hh%>,<%=p%>,'bebes');"><%=p%></a> 
                  <%next%>
                </div>
                <input type="hidden" name="HCbebes_<%=hh%>" value="0">
              </div>
              <!--sBebes_-->
            </div>
            <%end if%>
            <%next%>
          </div>
          <%end if 'fotos y textos %>
        </div>
        <!-- laHabi -->
        <%next 'nhabis%>
      </div>
      <!-- tipoHabi -->
      <!--#include file="capa_servicios.asp"-->
      *&nbsp;<%=objIdioma.getTraduccionHTML("i_impuestos")%> 
      <div id='pieReserva'> <a href="javascript:window.history.back();" class="boton" style="float:left"><%=objIdioma.getTraduccionHTML("i_anterior")%></a> 
        <a href="javascript:verifica();" class="boton" style="float:right;"><%=objIdioma.getTraduccionHTML("i_siguiente")%></a> 
      </div>
      <br class="clear" />
      <script language="javascript" type="text/javascript">
					//Carga los suplementos en las habis
					for (x=1;x<=4;x++)
						datosHabi(x,<%=tHab%>);
					verHabis(1);
					
					function cargaFotoHabi(esa,eso){
						$("#"+eso).attr("src",esa);
					}
					//fotosHabitacion();
				</script>
      <%end if 'errormsg=""%>
    </form>
  </div>
  <!--contenido-->
</div>
<!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>
