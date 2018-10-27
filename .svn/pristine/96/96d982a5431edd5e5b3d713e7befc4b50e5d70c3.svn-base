<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

est= request.QueryString("est")
response.write codres

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><%= nombreHotel%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<DIV align="center">
	<!-- proceso -->
	<div id='reservas' style='width:500px'>
    <img src="plantillasCorreo/img/<%=idEmpresa%>.gif" border='0' alt=''/>
		<p class="tituloWebBook" style="padding:20px;">
		<% 
			response.write objIdioma.getTraduccionHTML("i_gracias") &":<br/><a href='mailto:"& emailHotel & ">"& emailHotel & "<br/>" & teleHhotel & "</a>"
		%>
		</p>
	</div>
	<!-- fin proceso -->

</div>
</body>
</html>
