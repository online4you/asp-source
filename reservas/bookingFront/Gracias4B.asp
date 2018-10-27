<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
result=paClng(Request.QueryString("result"))

if result=0 then

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

codres=Request.QueryString("pszPurchorderNum")
cs="SELECT Establecimientos.Nombre as hotel,DatosHotel.Email,DatosHotel.Telefono "
cs=cs & "FROM (reservas INNER JOIN Establecimientos "
cs=cs & "ON Reservas.codigoesta=Establecimientos.codigoesta) INNER JOIN DatosHotel "
cs=cs & "ON Reservas.CodigoEsta=DatosHotel.CodigoEsta WHERE cod_res=" & codres
rs.open cs,base
if not rs.eof then
	emailHotel=rs("email")
	teleHhotel=rs("telefono")
end if
rs.close

set rs=nothing
base.close
set base=nothing

end if
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
		<% if result=0 then
				response.write objIdioma.getTraduccionHTML("i_gracias") &":<br/>"& emailHotel & "<br/>" & teleHhotel
			else
				response.write objIdioma.getTraduccionHTML("i_KO_gracias")
			end if
		%>
		   
        </p>
	</div>
	<!-- fin proceso -->

</div>
</body>
</html>
<%set objIdioma=nothing%>
