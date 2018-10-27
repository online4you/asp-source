<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_datosHabitaciones.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Caracteristicas del hotel
cs="SELECT ISNULL(Traduccion,Caracteristica) as Tradu,Icono "
cs=cs & "FROM (Caracteristicas INNER JOIN CaracteristicasHotel "
cs=cs & "ON Caracteristicas.Id=CaracteristicasHotel.IdCaracter) LEFT JOIN Traducciones "
cs=cs & "ON Caracteristicas.Id=Traducciones.IdReferencia AND Tabla='Caracteristicas' AND "
cs=cs & "Campo='Caracteristica' AND Idioma='" & lang & "' "
cs=cs & "WHERE CaracteristicasHotel.CodigoEsta=" & idh & " ORDER BY Orden"
rs.open cs,base
haycaracter=false
if not rs.eof then
	RegCaracter=rs.getrows
	RcNombre=0
	RcIcono=1
	hayCaracter=true
end if
rs.close

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
</head>
<body>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<input type="hidden" id='idh' name="idh" value="<%=idh%>" />
<input type="hidden" id='moneda' name="moneda" value="<%=coin%>" />
<div id='principalFrame'>
	<h1 id="capaTitulo"><%=nombreHotel%><span class='<%=ponCategoria(categoriaHotel)%>'></span></h1>
    <div id='contenidoFrame'>
       	<%if fotohotel<>"" then 'poner fotos%>
		<div id='fotosHotel'>
        	<img id='fotoPrincipal' src="<%=fotoHotel%>" width="274" border="0" alt="<%=nombreHotel%>" />
            <%if haysecciones then
			nfotos=0 'cada tres fotos se pone una capa
			primera=true
			for s=0 to ubound(RegSecciones,2)
				if RegSecciones(SecFotos,s)<>"" then 'separar las fotos
					lfotos=split(RegSecciones(SecFotos,s),";")
					for ff=0 to ubound(lfotos)
						if trim(lfotos(ff))<>"" then
							if nfotos=0 then 'abrir capa%>
							<div class='coluFoto'>
								<%if primera then 'primera foto %>
								<a href="<%=fotoHotel%>" class="thumbnail">
								<img class="thumbnail_foto" src="<%=renombraFoto(fotoHotel,"Th_")%>" alt="<%=nombreHotel%>" /></a>
								<%nfotos=nfotos+1
								primera=false
								end if 'primera foto%>
							<%end if 'nfotos=0							
							nfotos=nfotos+1%>
							<a href="<%=lfotos(ff)%>" class="thumbnail">
							<img class="thumbnail_foto" src="<%=renombraFoto(lfotos(ff),"Th_")%>" alt="<%=nombreHotel%>" /></a>
							<%if nfotos=3 then 'max. por columna
								nfotos=0%>
							</div> <!--coluFoto-->
							<%end if 'nfotos=3
						end if 'hayfoto
					next 'ff
					if nfotos<>3 and nfotos<>0 then 'cerrar div
						response.write "</div>"
					end if
										
				end if 'hayfotos
			next 's
			end if 'haySecciones%>
        </div> <!--fotosHotel-->
        <%end if 'fotoHotel<>"" %>
        <p class="linea"><%=direHotel%><br />
        <%=cpHotel & " " & poblaHotel%></p>
	<%if haysecciones then
        for s=0 to ubound(RegSecciones,2)
		if RegSecciones(SecTexto,s)<>"" then%>
        <div class="contenidoHotel">
        	<h2><%=RegSecciones(SecTitulo,s)%></h2>
            <div><%=RegSecciones(SecTexto,s)%></div>
        </div> <!--contenidoHotel-->
        <%end if
		next 's
    end if 'haySecciones%>
    <%if hayMapa then%>
    	<!--#include file="mapaHotel.asp"-->
    <%end if 'hayMapa%>    
    <%if hayCaracter then%>
	    <div class="contenidoHotel">
        	<h2><%=objIdioma.getTraduccionHTML("i_servicios")%></h2>
            <%for s=0 to ubound(RegCaracter,2)%>
            <p class="servicios">
            	<img src="<%=rutafotos & RegCaracter(RcIcono,s)%>" width="22" height="22" />
                <%=RegCaracter(RcNombre,s)%>
            </p>
            <%next 'caracter%>   
    	</div> <!--contenidoHotel-->
    <%end if 'hayCaracter%>    
    <%if hayhabis then%>
	    <div class="contenidoHotel">
        	<h2><%=objIdioma.getTraduccionHTML("i_habitaciones")%></h2>
            <%for h=0 to ubound(RegHabis,2)%>
            <div class="habiHotel">
            	<%if RegHabis(HaFotos,h)<>"" then 'poner fotos hab.
					lfotos=split(RegHabis(HaFotos,h),";")%>
					<img src="<%=lfotos(0)%>" width="274" class='fotoHabitacion' alt="<%=nombreHotel%>" />
				<%end if 'hayfotos%>
                <div class="textoHabi">
                	<b><%=RegHabis(HaNombre,h)%></b><br />
					<%=RegHabis(HaTexto,h)%>
                </div>
            </div> <!-- habihotel-->
            <a href="paso2.asp?ide=<%=idempresa%>&amp;idh=<%=idh%>&amp;lang=<%=lang%>&amp;th=<%=RegHabis(HaCodi,h)%>" class="col_reserva"><%=objIdioma.getTraduccionHTML("i_reservar")%></a>
            <%next 'habitac%>   
    	</div> <!--contenidoHotel-->
    <%end if 'hayHabis%>    
    </div> <!--contenidoFrame-->
    <script language="javascript" type="text/javascript" src="js/eventosHotel.js"></script>
</div> <!-- principalFrame -->
<%set objIdioma=nothing%>
</body>
</html>
