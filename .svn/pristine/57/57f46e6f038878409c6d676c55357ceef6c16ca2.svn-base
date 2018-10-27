					<%
					losmeses="<categories>"
					for m=1 to 12
						losmeses=losmeses & "<category name='"& ucase1(nombremesAbrev(m)) & "' HoverText='" & ucase1(nombremes(m)) & "'/>"
					next
					losmeses=losmeses & "</categories>"
					
					if hayestemes then
						'Generar XML del grafico
						elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_confirmadaspormes") & "' xAxisName='" & ucase(objIdioma.getTraduccion("i_reservasconfirmadasanyo")) & " " & any & ": " & formatnumber(totalnReservas,0) & " €' yAxisName='" & objIdioma.getTraduccion("i_nreservas") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2'>"
						elxml=elxml & losmeses
						'response.write elxml
						if hayestemes_A then 'compara otro año
							elxml=elxml & "<dataset seriesname='" & objIdioma.getTraduccion("i_anyo") & " " & compara & "' color='AC9FD6'>"
							for m=1 to 12
								valor=0
								for r=0 to ubound(RegMes_A,2)
									if RegMes_A(MFecha_A,r)=m then
										valor=quitarComa(redondear(RegMes_A(MPelas_A,r)))
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
							for r=0 to ubound(RegMes,2)
								if RegMes(MFecha,r)=m then
									valor=quitarComa(redondear(RegMes(MPelas,r)))
									exit for
								end if
							next
							elxml=elxml & "<set value='" & valor & "'/>"
						next 'los meses
						elxml=elxml & "</dataset>"
						elxml=elxml & "</graph>"
						'response.write elxml
						%>
						<div id="PelasDiv" align="center" style="margin-top:20px;"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_MSColumn3D.swf", "Reservas", "770", "400");
						   chart.setDataXML("<%=elxml%>");		   
						   chart.render("PelasDiv");
						</script>
					
					<%end if 'hay datos%>
