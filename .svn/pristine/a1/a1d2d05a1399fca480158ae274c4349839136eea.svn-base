<div id='logo'>&nbsp;</div>
<div id="botonera">
	<div id="imgIzqBotonera"></div>
	<div id='dentroBotonera'>
		<div class="titulo_menu">INTERTUR AMIGOS</div>
		<a href='javascript:creaFrame("fichas.asp?est=<%=est%>","Fichas VIP");'>
		<div class='fila_menu'>Fichas Amigos</div></a>
		<a href='javascript:creaFrame("visitas.asp","Visitas");'>
		<div class='fila_menu'>Visitas</div></a>
        <%if paClng(request.Cookies("nivelCR"))<>TRelacion then 'rel. publicas %>
		<a href='javascript:creaFrame("ofertasVIP.asp","Ofertas VIP");'>
		<div class='fila_menu'>Ofertas Amigos</div></a>
		<a href='javascript:creaFrame("../rvirtual/emarketing.asp","Enviar EMails");'>
		<div class='fila_menu'>Enviar EMails</div></a>
		<a href='javascript:creaFrame("../rvirtual/ListaEnviados.asp?bt=VIP","Enviados");'>
		<div class='fila_menu'>Emails Enviados</div></a>
        <%end if 'Rel. publicas %>
		<div style="height:10px; overflow:hidden"></div>
        <%if esAdmin then 'Administrador %>
			<a href='../inicio.asp' ><div style="margin-top:1px;" class='fila_menu'>Menu anterior</div></a>
		<%else%>
			<a href="../index.asp?salir=Si"><div style="margin-top:1px;" class='fila_menu'>Cerrar sesión</div></a>
		<%end if%>
	</div>
</div>
<div id='capilla'></div> <!--capa para texto alternativo-->
