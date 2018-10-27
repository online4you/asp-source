
<div id='logo'>&nbsp;</div>
<div id="botonera">
	<div id="imgIzqBotonera"></div>
	<div id='dentroBotonera'>
		<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_agencias"))%></div>
		<%if paClng(request.Cookies("nivelCR"))<>TAgencia then 'o nes agencia%>
		<a href='javascript:creaFrame("fichas.asp?lang=<%=lang%>","Agencias");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_agencias")%></div></a>
		<%end if '%>
		<a href='javascript:creaFrame("reservas_agencias.asp?lang=<%=lang%>","Reservas");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_listareservas")%></div></a>
		<div style="height:10px; overflow:hidden"></div>
		<%if paClng(request.Cookies("nivelCR"))=TAgencia then%>
		<a href='../index.asp?salir=Si' ><div style="margin-top:1px;" class='fila_menu'><%=objIdioma.getTraduccionHTML("i_cerrarsesion")%></div></a>
		<%else%>
		<a href='../inicio.asp' ><div style="margin-top:1px;" class='fila_menu'><%=objIdioma.getTraduccionHTML("i_menuanterior")%></div></a>
		<%end if%>
	</div>
</div>
<div id='capilla'></div> <!--capa para texto alternativo-->
