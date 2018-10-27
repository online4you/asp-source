<style type="text/css">
<!--
.noactivo {
	background-image:url(img/Fondoboton_off.gif);
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: none;
	height:17;
	width:110;
}
.activo {
	background-image:url(img/Fondoboton_on.gif);
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: none;
	height:17;
	width:110;
}
-->
</style>
<div align='center'>
<img src="img/transparent.gif" width='100' height='50'>
<table border='0' cellpadding="0" cellspacing="0" width='110'>
<tr>
	<td align='center' class='noactivo'>
	<a id='b0' href='TiposHotel.asp?est=<%=est%>' class='noactivo'>Tipos Alojamiento</a>
	</td>
</tr>
<tr>
	<td id='b0b' align='center' class='noactivo'>
	<a href='Categorias.asp?est=<%=est%>' class='noactivo'>Categorías</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b1' href='Zonas.asp?est=<%=est%>' class='noactivo'>Zonas</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b1b' href='TiposHabitacion.asp?est=<%=est%>' class='noactivo'>Tipos Habitación</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b2' href='Alojamientos.asp?est=<%=est%>' class='noactivo'>Alojamientos</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b3' href='Temporadas.asp?est=<%=est%>' class='noactivo'>Temporadas</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b4' href='Colectivos.asp?est=<%=est%>' class='noactivo'>Colectivos</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b4b' href='Suplementos.asp?est=<%=est%>' class='noactivo'>Suplementos</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b5' href='Habitaciones.asp?est=<%=est%>' class='noactivo'>Habitaciones</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b5b' href='ofertas.asp?est=<%=est%>' class='noactivo'>Ofertas</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b6' href='Servicios.asp?est=<%=est%>' class='noactivo'>Servicios</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b6b' href='ListaReservas.asp?est=<%=est%>' class='noactivo'>Lista Reservas</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<a id='b6b' href='EstadisticaMes.asp?est=<%=est%>' class='noactivo'>Estadísticas</a>
	</td>
</tr>
<tr>
	<td align='center' class='noactivo'>
	<%if busco="" then 'Administrador %>
		<a id='bb' href='index.asp' class='noactivo'>Salir</a>
<%else%>
		<a id='bb' href='index.asp' class='noactivo'>Salir</a>
<%end if%>
	</td>
</tr>
</table>
</div>
<%
'Compruebo la solapa activa
split_name=split(MiPag,"/")
if ubound(split_name)=-1 then 'No hay ruta
	NombrePagina=MiPag
else
	NombrePagina=split_name(ubound(split_name)) 'Esto es para coger solo el nombre de la pagina
end if
'response.write "Pag: " & nombrepagina & "<br>"
NombrePagina="zonas.asp"
response.write "<script language='JavaScript'>"
select case ucase(NombrePagina)
	case "TIPOSHOTEL.ASP"
		response.write "document.getElementById('b0').background='img/fondoboton_on.gif';"
	case "CATEGORIAS.ASP"
		response.write "document.getElementById('b0b').style.backgroundImage='img/fondoboton_on.gif';"
	case "ZONAS.ASP"
		response.write "document.getElementById('b1').style.backgroundImage='img/fondoboton_on.gif';"
	case "TIPOSHABITACION.ASP"
		response.write "document.getElementById('b1b').background='img/fondoboton_on.gif';"
	case "ALOJAMIENTOS.ASP"
		response.write "document.getElementById('b2').background='img/fondoboton_on.gif';"
	case "TEMPORADAS.ASP"
		response.write "document.getElementById('b3').background='img/fondoboton_on.gif';"
	case "COLECTIVOS.ASP"
		response.write "document.getElementById('b4').background='img/fondoboton_on.gif';"
	case "SUPLEMENTOS.ASP"
		response.write "document.getElementById('b4b').background='img/fondoboton_on.gif';"
	case "HABITACIONES.ASP"
		response.write "document.getElementById('b5').background='img/fondoboton_on.gif';"
	case "OFERTAS.ASP"
		response.write "document.getElementById('b5b').background='img/fondoboton_on.gif';"
	case "SERVICIOS.ASP"
		response.write "document.getElementById('b6').background='img/fondoboton_on.gif';"
	case "LISTARESERVAS.ASP"
		response.write "document.getElementById('b6b').background='img/fondoboton_on.gif';"
	case "ESTADISTICAMES.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"
	case "ESTADISTICAANY.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"
	case "ESTADISTICAMESOCU.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"
	case "ESTADISTICAMESEUROS.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"
	case "ESTADISTICAANYEUROS.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"
	case "ESTADISTICAMESHABI.ASP"
		response.write "document.getElementById('b7').background='img/fondoboton_on.gif';"

end select
response.write "</script>"
%>
