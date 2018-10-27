	<%if hayOfertas then%>	
        <div id="capaOfertas">
            <p class="tituloCapa"><%=objIdioma.getTraduccionHTML("i_ofertas")%></p>
            <%
			ante=0
			for o=0 to ubound(RegOfertas,2)%>
				<p>
				<%if ante<>RegOfertas(OHotel,o) then 'cambia hotel
					'Busca nombre hotel
					for h=0 to ubound(RegHoteles,2)
						if RegHoteles(HCodi,h)=RegOfertas(OHotel,o) then
							response.write "<b>" & RegHoteles(HNombre,h) & "</b><br />"
							exit for
						end if
					next 'h
				end if 'ante%>
				<%=RegOfertas(OFini,o) & " - " & RegOfertas(OFFin,o)%><br/>
                <%=RegOfertas(OTitulo,o)%>
                </p>
				<%ante=RegOfertas(OHotel,o)
			next 'o%>            
		  	<br class="clear" />
      </div> <!--capaOfertas-->
	<%end if%>