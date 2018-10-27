	<div id='capaIdioma'>
        <div id='idiomas' class='capa_lista'>
            <span class='titulo_lista'><%=objIdioma.getTraduccionHTML("i_idioma_" & lang)%></span>
            <div id='listaIdiomas' class="lista">
            <%for i=0 to ubound(ListaIdiomas)%>
               <a href="javascript:cambiaIdioma('<%=listaIdiomas(i)%>');">
			   <%=objIdioma.getTraduccionHTML("i_idioma_" & ListaIdiomas(i))%></a>
            <%next 'hayIdiomas%>
            </div> <!--lista-->
        </div> <!--idiomas-->
	</div> <!-- capadioma -->
