                        <div class="eligeHabi confoto">
                            <span class='tituHabi'><%=objIdioma.getTraduccionHTML("i_habitacion")%>&nbsp;<%=hh%>:</span>
                            <div id='sHabi_<%=hh%>' class='capa_lista'>
                                <span class='titulo_lista'><%=nombreHabi%></span>
                                <div id='listaHabis_<%=hh%>' class="lista">
                                <%if hayhabis then
                                for h=0 to ubound(RegHabis,2)%>
                                    <a href="javascript:datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>);palFrame(<%=hh%>);">
                                    <%=RegHabis(HaNombre,h)%></a>
                                <%next
                                end if 'hayhabis%>
                                </div>
                                <input type="hidden" name="habi_<%=hh%>" id="habi_<%=hh%>" value='<%=thab%>' />
                                <input type="hidden" name="nombrehabi_<%=hh%>" id='nombrehabi_<%=hh%>' value="<%=nombreHabi%>">
                            </div> <!--sHabi_-->

                            <span class='tituHabi'>
                            &nbsp;&nbsp;&nbsp;&nbsp;<%=objIdioma.getTraduccionHTML("i_regimen")%>:</span>
                            <div id='sRegi_<%=hh%>' class='capa_lista'>
                                <span class='titulo_lista'><%=nombreRegi%></span>
                                <div id='listaRegis_<%=hh%>' class="lista"></div>
                                <input type="hidden" name="SU_<%=hh%>" id="SU_<%=hh%>" value='<%=tReg%>' />
                                <input type="hidden" name="nombresuple_<%=hh%>" id='nombresuple_<%=hh%>' value="<%=nombreRegi%>">
                            </div> <!--sRegi_-->
                        </div>
                        <div class="habiHotel">
                            <div class="fotosHabi" id='fotohabi_<%=hh%>'></div>   
                            <div class="textoHabi procreserva" id="textohabi_<%=hh%>" style="width:350px; height:130px;"></div>
                        </div> <!-- habihotel-->
                        
                        <div class="columna_izq">
                            <%for t=0 to ubound(RegColec,2)%>
                            <div class="eligePlazas">
                                <span class='tituColec'><%=RegColec(CNombre,t)%>:</span>
                                <div id="sColec<%=RegColec(COrden,t)%>_<%=hh%>" class="capa_lista size40">
                                    <span class='titulo_lista'>0</span>
                                    <div id='listaColec<%=RegColec(COrden,t)%>_<%=hh%>' class="lista"></div>
                                    <input type="hidden" name="HC<%=RegColec(COrden,t)%>_<%=hh%>" value="" />
                                    <input type="hidden" name="nombreHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CNombre,t)%>">
                                	<input type="hidden" name="codigoHC<%=RegColec(COrden,t)%>_<%=hh%>" value="<%=RegColec(CCodi,t)%>">
                                </div> <!--sColec-->
                            </div>
                                <%'Incluir los bebes al final
                                if t=ubound(RegColec,2) then 'Pongo bebes %>
                                <div class="eligePlazas divninos">
                                	<span class='tituColec'><%=objIdioma.getTraduccionHTML("i_bebes")%>:</span>
									<div id='sColecbebes_<%=hh%>' class='capa_lista size40'>
                                        <span class='titulo_lista'>0</span>
                                        <div id='listaBebes_<%=hh%>' class="lista">
                                        <%for p=0 to 2%>
                                        	<a href="javascript:cambiaPlazas(<%=hh%>,<%=p%>,'bebes');"><%=p%></a>
                                        <%next%>
                                        </div>
                                        <input type="hidden" name="HCbebes_<%=hh%>" value="0">
                                    </div> <!--sBebes_-->
                                </div>
                                <%end if%>
                            <%next%>
                        </div>
                        
                        <div class="columna_der flotaDer">
                            <span class="reservas_bold">
                            <%=objIdioma.getTraduccionHTML("i_total")%>:</span>&nbsp;
                            <img id='espera_<%=hh%>' src="img/espera.gif" width="16" height="16" class="espera"/>
                            <span id='verimporte_<%=hh%>'></span>&nbsp;
                            <input type="hidden" id='importe_<%=hh%>' name="importe_<%=hh%>">
                        </div>
                        

