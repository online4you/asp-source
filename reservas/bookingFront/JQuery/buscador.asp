      <form name="fb" method="post" action="<%=MiPag%>?ide=<%=idEmpresa%>&amp;lang=<%=lang%>&amp;pr=paso1">
        <div id="capaBuscador">
            <p class="tituloCapa"><%=objIdioma.getTraduccionHTML("i_buscadispo")%></p>
		<%
		if hayhoteles then
		if ubound(RegHoteles,2)>0 then 'hay varios%>
			<%if ubound(RegZonas,2)>0 then 'hay varios%>
            <p><%=objIdioma.getTraduccionHTML("i_zona")%></p>
            <div id='zonas' class='capa_lista'>
                <span class='titulo_lista'><%=nombreZona%></span>
                <div id='listaZonas' class="lista">
                <a href="javascript:cambiaZona(0,'<%=objIdioma.getTraduccionHTML("i_todas")%>');">
                <%=objIdioma.getTraduccionHTML("i_todas")%></a>
                <%for z=0 to ubound(RegZonas,2)%>
                   <a href="javascript:cambiaZona(<%=RegZonas(ZCodi,z)%>,'<%=RegZonas(ZNombre,z)%>');">
				   <%=RegZonas(ZNombre,z)%></a>
                <%next 'hayzonas%>
                </div>
                <input type="hidden" name="bzona" id="bzona" value='<%=idz%>' />
            </div> <!--zonas-->
            <%end if 'zonas%>
            <%if ubound(RegTipos,2)>0 then 'hay varios%>
            <p><%=objIdioma.getTraduccionHTML("i_tipoalojamiento")%></p>
            <div id='tipos' class='capa_lista'>
                <span class='titulo_lista'><%=nombreTipo%></span>
                <div id='listaTipos' class="lista">
                <a href="javascript:cambiaTipo(0,'<%=objIdioma.getTraduccionHTML("i_todos")%>');">
                <%=objIdioma.getTraduccionHTML("i_todos")%></a>
                <%for tt=0 to ubound(RegTipos,2)%>
                   <a href="javascript:cambiaTipo(<%=RegTipos(TId,tt)%>,'<%=RegTipos(TTradu,tt)%>');">
				   <%=RegTipos(TTradu,tt)%></a>
                <%next 'haytipos%>
                </div>
                <input type="hidden" name="btipo" id="btipo" value='<%=tipoa%>' />
            </div> <!--zonas-->
            <%end if 'tipos%>
            <p><%=objIdioma.getTraduccionHTML("i_hotel")%></p>
            <div id='hoteles' class='capa_lista'>
                <span class='titulo_lista'><%=nombreHotel%></span>
                <div id='listaHoteles' class="lista">
                <a href="javascript:cambiaHotel(0,'<%=objIdioma.getTraduccionHTML("i_todos")%>');">
				<%=objIdioma.getTraduccionHTML("i_todos")%></a>
                <%if hayHoteles then
                for h=0 to ubound(RegHoteles,2)
					if idz=RegHoteles(HZona,h) OR idz=0 then%>
                   <a href="javascript:cambiaHotel(<%=RegHoteles(HCodi,h)%>,'<%=RegHoteles(HNombre,h)%>');"><%=RegHoteles(HNombre,h)%></a>
                   <%end if
                next
                end if 'hayhoteles%>
                </div>
                <input type="hidden" name="bhotel" id="bhotel" value='<%=idh%>' />
            </div> <!--hoteles-->
		<%end if 'tiene varios hoteles
	end if 'hayhoteles%>
            
          	<p class="flotante fechaIni"><%=objIdioma.getTraduccionHTML("i_fllegada")%><br />
            <a id='afini' href="javascript:abreCalendar('fini');"><%=fini%></a>
            <input type="hidden" name="fini" id='fini' value="<%=fini%>" />
			</p>
            
            <p class='flotante fechaFin'><%=objIdioma.getTraduccionHTML("i_fsalida")%><br/>
            <a id='affin' href="javascript:abreCalendar('ffin');"><%=ffin%></a>
            <input type="hidden" name="ffin" id='ffin' value="<%=ffin%>" />
            </p>
			<br class="clear" />
            <div class="flotante">
                <p><%=objIdioma.getTraduccionHTML("i_adultos")%></p>
                <div id='adultos' class='capa_lista'>
                    <span class='titulo_lista'><%=adultos%></span>
                    <div id='listaAdultos' class="lista">
                    <%for h=1 to 6%>
                       <a href="javascript:ponAdultos(<%=h%>);"><%=h%></a>
                    <%next%>
                    </div>
                    <input type="hidden" name="ad" id="ad" value='<%=adultos%>' />
                </div> <!--adultos-->
    		</div>
            <div class='flotante'>
                <p><%=objIdioma.getTraduccionHTML("i_ninos")%></p>
                <div id='ninos' class='capa_lista'>
                    <span class='titulo_lista'><%=ninos%></span>
                    <div id='listaNinos' class="lista">
                    <%for h=0 to 4%>
                       <a href="javascript:ponNinos(<%=h%>);"><%=h%></a>
                    <%next%>
                    </div>
                    <input type="hidden" name="ni" id="ni" value='<%=ninos%>' />
                </div> <!--ninos-->
            </div>
            <span>&nbsp;(<%=objIdioma.getTraduccionHTML("i_porhabitacion")%>)</span>
            <%if hayCaracter then%>
            <br class="clear" />
            <p><%=objIdioma.getTraduccionHTML("i_filtropor")%></p>
            <%for c=0 to ubound(RegCaracter,2)%>
            <span><input type="checkbox" name="ts" value="<%=RegCaracter(RcCodi,c)%>" /><%=RegCaracter(RcNombre,c)%></span>            <%next 'c
            end if 'hayCaracter %>
			<center>
			<a class="boton" href="javascript:enviaBusca();"><%=objIdioma.getTraduccionHTML("i_buscar")%></a>
            </center>
		  	<br class="clear" />
      </div> <!--reservas-->
    </form>
    <iframe name="verCalendario" id='verCalendario' class="capaIframe" frameborder="0"></iframe>
	<script language="javascript" type="text/javascript" src="js/buscador.js"></script>
