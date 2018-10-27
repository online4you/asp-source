					<%
					losmeses="<categories>"
					for m=1 to 12
						losmeses=losmeses & "<category name='"& ucase1(nombremesAbrev(m)) & "' HoverText='" & ucase1(nombremes(m)) & "'/>"
					next
					losmeses=losmeses & "</categories>"
					
					if hayestemesP then
						'Generar XML del grafico
						elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_importespormes") & "' xAxisName='" & ucase(objIdioma.getTraduccion("i_totalimporteanyo")) & " " & any & ": " & formatnumber(totalIReservas,0) & " €' yAxisName='" & objIdioma.getTraduccion("i_importe") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2'>"
						elxml=elxml & losmeses
						'response.write elxml
						if hayestemesP_A then 'compara otro año
							elxml=elxml & "<dataset seriesname='" & objIdioma.getTraduccion("i_anyo") & " " & compara & "' color='AC9FD6'>"
							for m=1 to 12
								valor=0
								for r=0 to ubound(RegMesP_A,2)
									if RegMesP_A(MFechaP_A,r)=m then
										valor=quitarComa(redondear(RegMesP_A(MPelasP_A,r)))
										exit for
									end if
								next
								elxml=elxml & "<set value='" & valor & "'/>"
							next 'los meses			
							elxml=elxml & "</dataset>"
						end if	'hayestemesP_A
						'Año actual
						elxml=elxml & "<dataset seriesname='" & objIdioma.getTraduccion("i_anyo") & " " & any & "' color='DF6C01'>"
						for m=1 to 12
							valor=0
							for r=0 to ubound(RegMesP,2)
								if RegMesP(MFechaP,r)=m then
									valor=quitarComa(redondear(RegMesP(MPelasP,r)))
									exit for
								end if
							next
							elxml=elxml & "<set value='" & valor & "'/>"
						next 'los meses
						elxml=elxml & "</dataset>"
						elxml=elxml & "</graph>"
						'response.write elxml
						%>
						<script language="javascript" type="text/javascript">
						function grabaCSV(){
							document.getElementById('paCSV').src="csv_GAnyoPelas.asp?todos=<%=todos%>&any=<%=any%>&cp=<%=compara%>";
						}
						</script>
						<iframe id='paCSV' name="paCSV" frameborder='0' hspace='0' vspace='0' src='vacio.htm' class='ficha'></iframe>
						<input type='button' class="boton145Excel" value='<%=objIdioma.getTraduccion("i_exportacsv")%>' onclick="javascript:grabaCSV();" style="margin-top:20px; margin-left:15px;">
						<div id="PelasDiv" align="center" style="margin-top:0px;"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_MSColumn3D.swf", "Importes", "770", "400");
						   chart.setDataXML("<%=elxml%>");		   
						   chart.render("PelasDiv");
						</script>
					
					<%end if 'hay datos%>
