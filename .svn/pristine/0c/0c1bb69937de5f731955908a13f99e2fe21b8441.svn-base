<%tipoVenta=2 'on line

'comprobar que no venga de otro sitio
servidor=lcase("" & request.ServerVariables("HTTP_REFERER"))
if instr(servidor,"booking.kubikcrs.com")=0 then 'se estan colando
	response.write "Operacion no autorizada"
	response.End()	
end if

%>
<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_recogeHabis.asp"-->
<!--#include file="CR_GrabaDatosBD.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

if codres<>0 then 'mirar los servicios extras
	set base=server.createobject("ADODB.Connection")
	base.Open Conecta
	
	'Recoger datos de la tarjeta
	tipotarjeta=request.form("tipotarjeta")
	numerotarjeta=request.form("numerotarjeta")
	codigoseguridad=request.form("codigoseguridad")
	fechacadu=request.form("mescadu") & "/" & request.form("anyocadu")
	
	
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
				cs="INSERT INTO ReservaServicio (CodReserva,IdServicio,Cuantas,Pelas,Tarifa,IdColectivo) VALUES ("
				cs=cs & codres & "," & RegServis(SCodi,s) & "," & cantidad
				cs=cs & "," & quitarComa(RegServis(SPelas,s)) & ",1," & RegServis(SCColec,s) & ")"
				base.execute cs
			end if 'cantidad>0
		end if
	
		anteservi=RegServis(SCodi,s)
	next 's
	end if 'hayServis


	'grabar si tiene ofertas de reserva
	codioferta=split(request.form("codiofertas"),"-")
	sumaoferta=split(request.form("sumaofertas"),"-")
	for o=0 to ubound(codioferta)
		if trim(codioferta(o))<>"" then
			cs="INSERT INTO OfertasReserva (IdOferta,IdReserva,Importe) VALUES ("
			cs=cs & codioferta(o) & "," & codres & "," & quitarComa(sumaoferta(o)) & ")"
			base.execute cs
		end if
	next 'o
	

	'Poner la reserva como confirmada 
	%><!--#include file="CR_confirmaReserva.asp"--><%
	'response.write xmlURL & parametros & "<br>"
	%><!--#include file="enviaReserva.asp"--><%
	
	base.close
	set base=nothing
	
	

end if 'codres<>0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
<link href="css/iframe.css" rel="stylesheet" type="text/css" />
<link href="css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/eventosIFrame.js"></script>
</head>
<body>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<div id='principalFrame'>
	<a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>">
	<h2 id="capaTitulo"><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h2>
    </a>
    <div class="resultado capaHotel">
        <%if fotoHotel<>"" then%>
       	<div class="izq_resultado">
            <a href="fichaHotel.asp?ide=<%=idEmpresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>">
            <img width="120" src="<%=renombraFoto(fotoHotel,"Th_")%>" alt="<%=nombreHotel%>" style="margin-right:4px;" border="0"/></a>
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
    
    <div id='contenidoFrame'>
    	<p><b><%=objIdioma.getTraduccionHTML("i_gracias") & " " & empresa & " (" & "<a href='mailto:" & remitente & "'>" & remitente & "</a>)"%></b></p>
    </div> <!--contenidoFrame -->

</div> <!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>


