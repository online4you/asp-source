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
<!--#include file="CR_extrasHotel.asp"-->
<!--#include file="CR_calcuPrecios.asp"-->

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
pelasprepago=pelasprepagoHab

'response.write "<!-- totalreserva= " & totalreserva & " -- " & sumaOfertas & "-->"
'response.write "<!-- prepago= " & prepago  & "-->"
'response.write "<!-- pelasprepago= " & pelasprepago  & "-->"


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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="/templates/photel/css/template.css" />
<!--#include file="includes/metasCabecera.asp"-->
<link href="<%=Front_url%>css/iframe.css" rel="stylesheet" type="text/css" />
<link href="<%=Front_url%>css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
<style type='text/css' media='screen'>@import url(/templates/photel/css/form.css);</style>

<script language="javascript" type="text/javascript" src="<%=Front_url%>js/eventosIFrame.js"></script>
<script language = "Javascript">
/**
 * DHTML phone number validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 9;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function trim(s)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not a whitespace, append to returnString.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (c != " ") returnString += c;
    }
    return returnString;
}
function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(strPhone){
var bracket=3
strPhone=trim(strPhone)
if(strPhone.indexOf("+")>1) return false
if(strPhone.indexOf("-")!=-1)bracket=bracket+1
if(strPhone.indexOf("(")!=-1 && strPhone.indexOf("(")>bracket)return false
var brchr=strPhone.indexOf("(")
if(strPhone.indexOf("(")!=-1 && strPhone.charAt(brchr+2)!=")")return false
if(strPhone.indexOf("(")==-1 && strPhone.indexOf(")")!=-1)return false
s=stripCharsInBag(strPhone,validWorldPhoneChars);
return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function ValidateTel(telObj){
	var Phone=telObj
	
	if ((Phone.value==null)||(Phone.value=="")){
		//alert("Please Enter your Phone Number")
		Phone.focus()
		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		//alert("Please Enter a Valid Phone Number")
		Phone.value=""
		Phone.focus()
		return false
	}
	return true
 }
</script>

<script language="JavaScript" type="text/javascript">
function comprueba(){

	if ((document.f1.ape.value.length==0)||(document.f1.nom.value.length==0)) {
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	if ((document.f1.tel.value.length==0) || ValidateTel(document.f1.tel)==false) {
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	if ((document.f1.email.value.length==0) || (document.f1.email2.value.length==0) ) {
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	if ((document.f1.checkFacturaS.checked==true)  ) {
		if ((document.f1.factNombre.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factCifNif.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factCP.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factDir.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factLoc.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factProv.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.factEmail.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		
	}
	if ((document.f1.checkPersonaContactoS.checked==true)  ) {
		if ((document.f1.apeContact.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.nomContact.value.length==0)  ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
		if ((document.f1.telContact.value.length==0) || ValidateTel(document.f1.telContact)==false ) {
			alert('<%=objIdioma.getTraduccion("i_obliga")%>');
			return false;
		}
	}
	if ((document.f1.documento.value.length==0)  ) {
		alert('<%=objIdioma.getTraduccion("i_obliga")%>');
		return false;
	}
	
	
	if ((chaeckNIF==false)  ) {
		return false;
	}
	
	if (isEmailOK(document.f1.email)) {
		return false;
	}
	if (isEmailOK(document.f1.email2)) {
		return false;
	}
	if (isEmailOK(document.f1.factEmail)) {
		return false;
	}

	if (!document.f1.informacionS.checked){
		alert('<%=quitarApos(objIdioma.getTraduccion("i_noacepta"))%>');
		return false;
	}
	if (!document.f1.aceptoS.checked){
		alert('<%=quitarApos(objIdioma.getTraduccion("i_noacepta"))%>');
		return false;
	}
	
	return true;
}
    function goToPago(act)
    {
        var str = "<form name='f1' method='post' target='_self' action='" + act + "'>";
        var elem = document.getElementById('f1').elements;
		for(var i = 0; i < elem.length; i++)
        {
            //str += "<input type='" + elem[i].type + "' ";
            if (elem[i].type=="text" || elem[i].type=="hidden" ){
				str += "<input type='hidden' ";
    	        str += "name='" + elem[i].name + "' ";
        	    str += "value='" + elem[i].value + "'>";
            	str += "<br>\n";
			}
        } 
		str += "</form>";
		var vent=window.open("", '_blank', 'toolbar=no,location=no,directories=no,resizable=yes,scrollbars=no');
		vent.document.write(str); 
		vent.document.f1.submit();
    }
    function goToPagoTransfer(act)
    {
        var str = "<form name='f1' method='post' target='_self' action='" + act + "'>";
        var elem = document.getElementById('f1').elements;
		for(var i = 0; i < elem.length; i++)
        {
            //str += "<input type='" + elem[i].type + "' ";
            if (elem[i].type=="text" || elem[i].type=="hidden" ){
				//str += elem[i].name + " :";
				str += "<input type='hidden' ";
    	        str += "name='" + elem[i].name + "' ";
        	    str += "value='" + elem[i].value + "'>";
            	str += "<br>\n";
			}
        } 
		str += "</form>";
		var vent=window.open("", '_blank', 'toolbar=no,location=no,directories=no,resizable=yes,scrollbars=no');
		//var vent=window.open("", '_blank', '');
		vent.document.write(str); 
		vent.document.f1.submit();
    }

function Pago() {
	if (comprueba()){
		//document.f1.action="pagoTPV.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>&fpago=1";
		//document.f1.target='_blank';
		//document.f1.submit(); 
		if(document.getElementById('credit').checked==true){
			document.getElementById('typeOfPaymentID').value='1';
			goToPago("pagoTPV.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>&fpago=1");
		}
		else {
			document.getElementById('typeOfPaymentID').value='2';
			goToPagoTransfer("pagoTransfer.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>&fpago=1");
		}

	}
}
function Verifica() {
	if (comprueba()){
		if (CheckCardNumber(document.f1)) {
			document.f1.action="verifica.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>";
			document.f1.submit(); 
		}
	}
}
function Manda() {
	if (comprueba()){
		document.f1.action="onrequest.asp?ide=<%=idempresa%>&idh=<%=idh%>&lang=<%=lang%>";
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
var maximo="<%=totalreserva+TotalServi%>";
function elPrepago(eso) {
	if (eso.value=="min"){
		document.f1.prepago.value=minimo;
		pelas=<%=replace(redondear(pelasprepago),",",".")%>;
	}
	if (eso.value=="max"){
		document.f1.prepago.value=maximo;
		pelas=<%= replace(redondear(totalreserva + totalServi),",",".")%>;
	}

}

function MuestraCondiciones(div){
	laCapa=document.getElementById(div);
	//centrarCapa(laCapa,$("#"+div).width(),$("#"+div).height(),0,0);
	var capa = laCapa.style.display;

	if (capa == "block")
		 laCapa.style.display="none";
	else
		laCapa.style.display="block";
}

function cargaPromo() {
	cpromo=$("#codpromo").val();
	$("#espera_promo").css("visibility",'visible');
	url="cargaPromocion.asp?ide=<%=idEmpresa%>&est=<%=idh%>&cpromo="+cpromo+"&fini=<%=fini%>&ffin=<%=ffin%>&lang=<%=lang%>";
	$("#textopromo").load(url,'',function(){
	   $("#espera_promo").css("visibility",'hidden');
	   document.fb.submit();
	 });
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
    <%
	codigosVoucher=""
	if hayofertas then	
			for of=0 to ubound(codiOferta)
				codigosVoucher=codigosVoucher & codiOferta(of) & "-"
				%>
				<input type='hidden' name='codiOferta_<%=of%>' value='<%=codiOferta(of)%>'>
				<input type='hidden' name='textoOferta_<%=of%>' value='<%=textoOferta(of)%>'>
				<input type='hidden' name='pelasOferta_<%=of%>' value='<%=totalOferta(of)%>'>
			<%next%>
			
		<%end if
		codigosVoucher=codigosVoucher & ofertatem & "-"
		codigosVoucher = Left(codigosVoucher, Len(codigosVoucher)-1)
		if (codigosVoucher ="0") then 
			codigosVoucher=""
		end if
		%>
		<input type='hidden' name='codiofertas' value='<%=codigosVoucher%>'>
    <div id='contenidoFrame'> 
      <div class="listaPhotel" >
	    <div style="border-top: 8px solid #178EB6;">
		<table id='Textoresumen' cellpadding="0" cellspacing="1" border="0" width="100%" align="center">
          <tr> 
            <th align="left" colspan="4" class="textoDatosPago">
				<div style="overflow:auto; font-size: 15px; padding: 15px;">
					<%=objIdioma.getTraduccionHTML("i_datosDelPago")%>
				</div>
				</th>
          </tr>
		</table>
		</div>

<div class="navHorizontal" style="background-position:center top;height:2px; width:100%;"></div>
<div >
        <table id='resumen' style="margin-top:0px;" cellpadding="0" cellspacing="0" border="0" width="100%" align="center">

		  <tr> 
            <th align="left" style="font-size: 11px;"><%=objIdioma.getTraduccionHTML("i_tipohab")%></th>
            <th align="left" style="font-size: 11px;"><%=objIdioma.getTraduccionHTML("i_plazas")%></th>
            <th align="left" style="font-size: 11px;"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
            <th align="right" style="font-size: 11px;"><%=objIdioma.getTraduccionHTML("i_total")%></th>
          </tr>
          <%for h=1 to cuantas
			totalHabi=0
			for d=1 to noches 'suma todas las noches
				totalhabi=totalHabi+(PrecioPlazas(d,h)-DtoHab(d,h)+TotalSuples(d,h)-DtoSuples(d,h))
				prepagoHabInput=prepagoHabArr(d,h)
			next 'd%>
          <input type="hidden" name='precioHab_<%=h%>' value="<%=totalHabi%>" />
          <input type="hidden" name='prepagoHab_<%=h%>' value="<%=prepagoHabInput%>" />
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
            <td align="left" class='coluRegi'><%=replace(nomsuples(h),"�", "&oacute;")%></td>
            <!--<td align="right" class='coluTotal'><%=formatNumber(totalHabi*elCambio,2) & sufijoMoneda%></td>-->
			<!--<td align="right" class='coluTotal'><%=formatNumber(request.Form("importe_" & h),2) & sufijoMoneda%></td>-->
			<td align="right" class='coluTotal'>&nbsp;</td>

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
     <!--     <tr> 
            <td align="left" colspan="3" class='coluHabi'><b><%=textoOferta(o)%></b></td>
            <td align="right" class='coluTotal'><%=formatnumber(totalOferta(o)*(-1)*elCambio,2) & sufijoMoneda%></td>
          </tr>-->
          <%next 'oferta
		end if
        %><!--<%
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
		-->
          <%
			if RegTempoInfo(TOferta, 0) = 1 then
		%>
     <!--      <tr> 
            <td align="left" colspan="4"> <strong><%=objIdioma.getTraduccionHTML("i_oferta_temporada")%>: 
              <%=RegTempoInfo(TTraduccion, 0) %></strong> </td>
          </tr>-->
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

<div class="desgloseReserva" style="width: 100%">
		<table id='desglose' cellpadding="0" cellspacing="0" border="0" width="100%" align="center" >
          <tr > 
            <td align="left" style="border-right: 1px solid #919191;">
				<a href="javascript: OpenDesglose('<%=mainUrl%>/reservas/bookingFront/iframepaso3DetalleReserva.asp?ide=<%=idEmpresa%>&idh=<%=idh%>& lang=<%=lang%>');" style="color: #178EB6;"><%=objIdioma.getTraduccionHTML("i_verDesglose")%></a>
          	</td>
            <td align="left"  class="textoDesglose">
				<table id='desglose' cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
         			<tr> 
            			<td align="left">
						&nbsp;<%=objIdioma.getTraduccionHTML("i_totalres")%>
						</td>
            			<td align="left">
						<div style="color: #F38A12"><%=formatnumber(totalreserva+totalservi,2)%>&nbsp;<%=monedaHotel%></div>
						</td>
					<tr> 
         			<tr> 
            			<td align="left">
						&nbsp;<%=objIdioma.getTraduccionHTML("i_prepago")%>
						</td>
            			<td align="left">
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
            			<td align="left" style="border-bottom: 1px solid #919191;">
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
<div class="infoReserva" style="width: 100%">
<%=objIdioma.getTraduccionHTML("i_infoReserva")%>
<br>
<span style="color: #F38A12"><%=objIdioma.getTraduccionHTML("i_formapago")%>:&nbsp;</span><%=objIdioma.getTraduccionHTML("i_formasDePago")%>
</div>
      </div>
      <table id='datosPersonales' cellpadding="0" cellspacing="1" border="0" align="center"  width="100%" style="text-align: left; border: 2px solid #B5D5DC;">
                <tr> 
            <td align="left" colspan="2" class="textoDatosPago">
				<div style="overflow:auto; font-size: 15px; padding: 15px;">
					<%=objIdioma.getTraduccionHTML("i_datosPersonales")%>
				</div>
				</td>
          </tr>

	    <tr> 
          <td align="left" colspan='2' class="colu1" ><span><%=objIdioma.getTraduccionHTML("i_rellenaformulario")%></span></td>
        </tr>
        <tr> 
          <td colspan="2" height="5"></td>
        </tr>
        <%if request.Cookies("idagencia")="" then 'no es agencia %>
                <tr> 
          <td colspan="2">
				  <table cellpadding="0" cellspacing="1" border="0" align="center" width="100%" style="text-align: left;">

		<tr> 
          <td align="right" class="colu1" style="width: 225px;"><%=objIdioma.getTraduccionHTML("i_apellidos")%>*:</td>
          <td> <input type="text" name="ape" id="ape" style="width:240px;" maxlength="50" class="combo5"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_nombre")%>*:</td>
          <td> <input type="text" name="nom" id="nom" style="width:240px;" maxlength="50" class="combo5"> 
          </td>
        </tr>
		<tr> 
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_tipoDocu")%>*:</td>
		  <td> 
				<div id='tipoDocuDiv' class='capa_lista' style="width: 100px;"> <span id="cifNif" class='titulo_listaNaranja' style="color: #000000;"><%=objIdioma.getTraduccionHTML("i_nif")%></span> 
					<div id='listaRegis_tipoDocu' class="lista"> <a href='javascript:cambiaCifNif("1","<%=objIdioma.getTraduccionHTML("i_nif")%>")'><%=objIdioma.getTraduccionHTML("i_nif")%></a> 
					  <a href='javascript:cambiaCifNif("2","<%=objIdioma.getTraduccionHTML("i_namePasaporte")%>")'><%=objIdioma.getTraduccionHTML("i_namePasaporte")%></a> 
					  <a href='javascript:cambiaCifNif("3","<%=objIdioma.getTraduccionHTML("i_otros")%>")'><%=objIdioma.getTraduccionHTML("i_otros")%></a> 
					</div>
					<input type="hidden" name="tipoDocu" id="tipoDocu" value='NIF' />
					<input type="hidden" name="tipoDocuId" id="tipoDocuId" value='1' />
				  </div>
		  </td>
		</tr>
		<tr> 
		  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_documento")%>*:</td>
		  <td> <input type="text" name="documento" id="documento" style="width:240px;" maxlength="50" class="combo5" onBlur="chaeckNIF(this);"> 
		  </td>
		</tr>
        <!--
		<%else 'es agencia %>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_apellidoscliente")%>*:</td>
          <td> <input type="text" name="ape" style="width:240px;" maxlength="50" class="combo5"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_nombrecliente")%>*:</td>
          <td> <input type="text" name="nom" style="width:240px;" maxlength="50" class="combo5"> 
          </td>
        </tr>
        <tr> 
          <td colspan="2" height="10"></td>
        </tr>
        <%end if 'agencia %>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
          <td> <input type="text" name="dir" style="width:240px;" maxlength="50" class="combo5" value="<%=direccion%>"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_localidad")%>:</td>
          <td> <input type="text" name="loc" style="width:240px;" maxlength="50" class="combo5" value="<%=poblacion%>"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_provincia")%>:</td>
          <td> <input type="text" name="prov" style="width:240px;" maxlength="50" class="combo5" value="<%=provincia%>"> 
          </td>
        </tr>
        <tr> 
          <%if idEmpresa <> 94 then%>
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_pais")%>:</td>
          <%else%>
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_passport")%>:</td>
          <%end if%>
          <td> <input type="text" name="pais" style="width:240px;" maxlength="50" class="combo5" value="<%=pais%>"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_cp")%>:</td>
          <td> <input type="text" name="cp" style="width:70px;" maxlength="5" class="combo5" value="<%=cp%>"> 
          </td>
        </tr>-->
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_telefono")%>*:</td>
          <td> <input type="text" name="tel" id="tel" style="width:240px;" maxlength="25" class="combo5" value="<%=telefono%>"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1">EMail*:</td>
          <td> <input type="text" name="email" id="email"  style="width:240px;" maxlength="50" class="combo5" value="<%=email%>" onBlur="isEmailOK(this);"> 
          </td>
        </tr>
        <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_confirmaemail")%>*:</td>
          <td> <input type="text" name="email2" id="email2" style="width:240px;" maxlength="50" class="combo5" value="<%=email%>" onBlur="isEmailOK(this);"> 
          </td>
        </tr>
       <!-- <tr> 
          <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_horallegada")%>:</td>
          <td> <input type="text" name="horallegada" style="width:240px;" maxlength="50" class="combo5"> 
          </td>
        </tr>-->
        <tr> 
          <td align="right" valign="top" class="colu1"><%=objIdioma.getTraduccionHTML("i_comentarios")%>:</td>
          <td valign="top"> 
		  <textarea name="com" id="com" style="width:240px; height:80px;" class="combo5" onblur="javascript: document.getElementById('com2').value=this.value"></textarea> 
		  <input type="hidden" name="com2" id="com2" value=""> 
          </td>
        </tr>
		</table>
		</td>
		</tr>
		<%if estado=online AND estadoHab="OL" then 'solo en online hotel y habitacion OL
        	
            if TPV_tipoPago=0 then 'verificador tarjeta%>
        <!--#include file="total_Verifica.asp"-->
        <%else 'tpv %>
        <!--#include file="total_TPV.asp"-->
        <%end if
			            
        else 'hotel onrequest o habitacion OR %>
        <!--#include file="total_Request.asp"-->
        <%end if%>
		
        <tr> 
          <td class="colu1" colspan="2">
		  	<input title="muestraOcultaFactura();setCheck(document.getElementById('checkFacturaS'),document.getElementById('checkFactura'));" class="styled"  type='checkbox' id='checkFacturaS' name='checkFacturaS' value='1'  style='border:none' >
		  	<input type='hidden' id='checkFactura' name='checkFactura' value='0'  >
		  	<%=objIdioma.getTraduccionHTML("i_deseoFactura")%>  
		</td>
        </tr>
        <tr> 
          <td colspan="2">

		  <div id="factura" style="visibility: visible; position:relative; top:0;height: 200px;"> 
				  <table cellpadding="0" cellspacing="1" border="0" align="center" width="100%" style="text-align: left;">
					<tr> 
					  <td align="right" class="colu1" style="width: 225px;"><%=objIdioma.getTraduccionHTML("i_razonSocial")%>*:</td>
					  <td> <input type="text" name="factNombre" id="factNombre" style="width:240px;" maxlength="50" class="combo5"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_CifNif")%>*:</td>
					  <td> <input type="text" name="factCifNif" id="factCifNif" style="width:240px;" maxlength="50" class="combo5"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_cp")%>*:</td>
					  <td> <input type="text" name="factCP"  id="factCP"  style="width:70px;" maxlength="5" class="combo5" value="<%=cp%>"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_direccion")%>*:</td>
					  <td> <input type="text" name="factDir" id="factDir" style="width:240px;" maxlength="50" class="combo5" value="<%=direccion%>"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_localidad")%>*:</td>
					  <td> <input type="text" name="factLoc" id="factLoc" style="width:240px;" maxlength="50" class="combo5" value="<%=poblacion%>"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_provincia")%>*:</td>
					  <td> <input type="text" name="factProv" id="factProv" style="width:240px;" maxlength="50" class="combo5" value="<%=provincia%>"> 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_emailFactura")%>*:</td>
					  <td> <input type="text" name="factEmail" id="factEmail" style="width:240px;" maxlength="50" class="combo5" onBlur="isEmailOK(this);"> 
					  </td>
					</tr>
				</table>
			</div>
			&nbsp;
		  </td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2">
		  	<input title="muestraPersonaDecontacto();setCheck(document.getElementById('checkPersonaContactoS'),document.getElementById('checkPersonaContacto'));" class="styled"  type='checkbox' id='checkPersonaContactoS' name='checkPersonaContactoS' value='1'  style='border:none' >
		  	<input type='hidden' id='checkPersonaContacto' name='checkPersonaContacto' value='0'  >
		  <%=objIdioma.getTraduccionHTML("i_personaContacto")%>  
		  </td>
        </tr>
        <tr> 
          <td colspan="2">
		  	<div id="personaContacto" style="visibility: visible; position:relative; top:0;height: 100px;"> 
				  <table cellpadding="0" cellspacing="1" border="0" align="center" width="100%" style="text-align: left;">
					<tr> 
					  <td align="right" class="colu1" style="width: 225px;"><%=objIdioma.getTraduccionHTML("i_apellidos")%>*:</td>
					  <td> <input type="text" name="apeContact" id="apeContact" style="width:240px;" maxlength="50" class="combo5" > 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_nombre")%>*:</td>
					  <td> <input type="text" name="nomContact" id="nomContact" style="width:240px;" maxlength="50" class="combo5" > 
					  </td>
					</tr>
					<tr> 
					  <td align="right" class="colu1"><%=objIdioma.getTraduccionHTML("i_telefono")%>*:</td>
					  <td> <input type="text" name="telContact" id="telContact" style="width:240px;" maxlength="25" class="combo5" value="<%=telefonoContact%>"> 
					  </td>
					</tr>
				</table>
			</div>
		  </td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2" >
		  	<input title="setCheck(document.getElementById('deseoRecibirOfertasS'),document.getElementById('deseoRecibirOfertas'))"  class="styled"  type='checkbox' id='deseoRecibirOfertasS' name='deseoRecibirOfertasS' value='1'  style='border:none' checked>
			<input type='hidden' id='deseoRecibirOfertas' name='deseoRecibirOfertas' value='1' >
		  	<%=objIdioma.getTraduccionHTML("i_deseoRecibirOfertas")%>  
		  </td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2" style="line-height: 24px;">
		  
		  <input title="setCheck(document.getElementById('informacionS'),document.getElementById('informacion'))"  class="styled"  type='checkbox' name='informacionS' id='informacionS' value='1'  style='border:none' checked> 
		  <input type='hidden' id='informacion' name='informacion' value='1' >
               <%if condiHotel="" then 'no hay condiciones%>
				<a href="<%=mainUrl%>/index2.php?option=com_content&view=article&id=2&lang=<%=lang%>" target="_blank"><%=objIdioma.getTraduccionHTML("i_acepto")%></a>
			<%else 'poner enlace %>
            <a href="javascript:MuestraCondiciones('condiciones')"> <%=objIdioma.getTraduccionHTML("i_acepto")%></a> 
            <%end if 'condiHotel %>
            <div class="condiciones" id="condiciones" style="display:none"> 
              <div id="cabecera" class="cabeceraCondiciones" onClick="javascripts:MuestraCondiciones('condiciones')">
               <%=objIdioma.getTraduccionHTML("i_condiciones")%> <img src="img/laX.jpg" width="15" height="18" /></div>
              <div id="textoCondiciones" class="textoCondiciones"><%=condiHotel%></div>
            </div>
            <br/> 
			<input title="setCheck(document.getElementById('aceptoS'),document.getElementById('acepto'))"  class="styled"  type='checkbox' name='aceptoS' id='aceptoS' value='1'  style='border:none'> 
			<input type='hidden' id='acepto' name='acepto' value='0' >
            <a href="<%=mainUrl%>/index2.php?option=com_content&view=article&id=6&lang=<%=lang%>" target="_blank"><%=objIdioma.getTraduccionHTML("i_aceptoprivacidad")%></a> </td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2" style="line-height: 24px;">
		  	<%=objIdioma.getTraduccionHTML("i_formapago")%>:
			</td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2" style="line-height: 24px;">
		  	<input class="styled" type="radio"  name='typeOfPayment' id='credit' value='1'  style='border:none' checked> 
			<%=objIdioma.getTraduccionHTML("i_tarjetacredito")%>
			</td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2" style="line-height: 24px;">
  		  	<%if(fini>now()+2) then%>
				<input class="styled" type="radio"  name='typeOfPayment' id='transfer' value='2'  style='border:none'> 
			<%end if%>
			<%=objIdioma.getTraduccionHTML("i_transferencia")%>
				<input type="hidden"  name='typeOfPaymentID' id='typeOfPaymentID' value='1'  >
			</td>
        </tr>
        <tr> 
          <td class="colu1" colspan="2">
		  <b><%=objIdioma.getTraduccionHTML("i_obliga")%></b>
		  </td>
        </tr>
        <tr> 
          <td colspan="2" height='10'></td>
        </tr>
      </table>
      <!--datosPersonales-->
      <div id='pieReserva'> 
        <!--<a href="javascript:window.history.back();" class="boton" style="float:left"><%=objIdioma.getTraduccionHTML("i_anterior")%></a> -->
        <%if estado=online AND estadoHab="OL"  then 'solo en online hotel y habitacion OL
            if TPV_tipoPago=0 then 'verificador tarjeta%>
        <button type="button" class="botonReserva" onClick="javascript:Verifica();">reservar</button>
        <!--<a href="javascript:Verifica();" class="boton" style="float:right;"> <%=objIdioma.getTraduccionHTML("i_reservar")%></a>-->
        <%else 'tpv %>
        <button type="button" class="botonReserva" onClick="javascript:Pago();">reservar</button>
        <!--<a href="javascript:Pago();" class="boton" style="float:right;"> <%=objIdioma.getTraduccionHTML("i_reservar")%></a> -->
        <%end if
        else 'hotel onrequest o habitacion OR %>
        <button type="button" class="botonReserva" onClick="javascript:Manda();">reservar</button>
        <!--<a href="javascript:Manda();" class="boton" style="float:right;"> <%=objIdioma.getTraduccionHTML("i_enviar")%></a> -->
        <%end if%>
      </div>
      <br class="clear" />
    </div>
    <!--contenido-->
	<input type="hidden" name="repite_email" id="repite_email" value='1' />
  </form>
</div>
<!-- principal -->
<div id="lblValues"></div>




</body>
</html>
<script language="JavaScript" type="text/javascript">
	function setCheck(checkObj,hiddenObj){
		if (checkObj.checked==true){
			hiddenObj.value='1';}
		else {
			hiddenObj.value='0';}
	}
	function muestraOcultaFactura(){
		 if (document.getElementById('checkFacturaS').checked==true){
		 	 document.getElementById('factura').style.position="relative";
			 document.getElementById('factura').style.visibility="visible";
			 document.getElementById('factura').style.display="block";
		} else {
			 document.getElementById('factura').style.visibility="hidden";
			 document.getElementById('factura').style.display="none";
			 document.getElementById('factura').style.position="absolute";
		}
		if (parent.location != window.location) {
			eval("parent.autoResize('iframeResultados');");
		}

		 
	}
muestraOcultaFactura();
	function muestraPersonaDecontacto(){
		 if (document.getElementById('checkPersonaContactoS').checked==true){
			document.getElementById('personaContacto').style.position="relative";
			 document.getElementById('personaContacto').style.visibility="visible";
			 document.getElementById('personaContacto').style.display="block";
		} else {
			 document.getElementById('personaContacto').style.visibility="hidden";
			 document.getElementById('personaContacto').style.display="none";
			 document.getElementById('personaContacto').style.position="absolute";
		}
		if (parent.location != window.location) {
			eval("parent.autoResize('iframeResultados');");
		}
	 
	}
muestraPersonaDecontacto();
	function cambiaCifNif(idTxt, txt){
		 setText(document.getElementById('cifNif'), txt);
		 document.getElementById('tipoDocu').value=txt;
		 document.getElementById('tipoDocuId').value=idTxt;
		 chaeckNIF(document.getElementById('documento'));
	 
	}
function setText(n,txt)
{
  if('textContent' in n) {
    n.textContent=txt;
  } else if('innerText' in n) {
    n.innerText=txt;
  } else {
    // Call a custom collecting function, throw an error, something like that.
  }
}
function isEmailOK(email){
	if (validateEmail(email.value)==false){
		if (email.value!=''){
			alert('<%=objIdioma.getTraduccionHTML("i_mailIncorrecto")%>');
			}
		email.value='';
	}
}
function chaeckNIF(nif){
	if ( document.getElementById('tipoDocuId').value=='1' && '<%=lang%>'=='es'){
		if (nif.value!=''){
			if (nifOK(nif.value)==false){
				if (nif.value!=''){
					alert('<%=objIdioma.getTraduccionHTML("I_NIFIncorrecto")%>');
				}
				nif.value='';
			}
		}
	}
}

	function OpenDesglose(action){
		if (parent.location != window.location) {
			eval("parent.goToDetais('" + action + "');");
		}
	}

$().ready(function() {
		if (parent.location != window.location) {
			eval("setTimeout('parent.reDimension()',100);");
		}

});

</script>
<script type="text/javascript" src="/templates/photel/custom/js/custom.js"></script>
<script type="text/javascript" src="/templates/photel/custom/js/custom-form-elements.js"></script>
<%
	set objIdioma = nothing
	
	'for ti = 0 to ubound(RegTempoInfo, 2)
		response.write "<!-- traduccion: " & RegTempoInfo(TTraduccion, 0) & "-->" & vbcrlf
	'next
%>