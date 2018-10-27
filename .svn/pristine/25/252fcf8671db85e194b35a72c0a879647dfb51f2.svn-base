					<%					
					if hayIdioma then
						'Generar XML del grafico
						elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_reservasanyo") & " " & any & "' decimalPrecision='1' showPercentageValues='1' showNames='1' showValues='1' showPercentageInLabel='1' pieYScale='45' pieBorderAlpha='40' pieFillAlpha='70' pieSliceDepth='15' pieRadius='100' decimalSeparator='.' thousandSeparator=',' formatnumber='1' bgColor='DCDCDC' numberSuffix='%25'>"

						for r=0 to ubound(RegIdioma,2)
							'valor=quitarComa(formatNumber(RegIdioma(MPelasIdi,r)/totalIdioma*100,1))
							valor=RegIdioma(MPelasIdi,r)
							elxml=elxml & "<set value='" & valor & "' "
							select case lcase(RegIdioma(MIdioma,r))
								case "es"
									eseIdioma=objIdioma.getTraduccion("i_espanol")
									color=colorEspanol
								case "en"
									eseIdioma=objIdioma.getTraduccion("i_ingles")
									color=colorIngles
								case "de"
									eseIdioma=objIdioma.getTraduccion("i_aleman")
									color=colorAleman
								case "fr"
									eseIdioma=objIdioma.getTraduccion("i_frances")
									color=colorFrances
								case "it"
									eseIdioma=objIdioma.getTraduccion("i_italiano")
									color=colorItaliano
							end select
							elxml=elxml & "name='" & eseIdioma & "' color='" & color & "'/>"
						next
						
						elxml=elxml & "</graph>"
						'response.write elxml
						if hayIdioma_A then
						'Generar XML del grafico
						elxml2="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_reservasanyo") & " " & compara & "' decimalPrecision='1' showPercentageValues='1' showNames='1' showValues='1' showPercentageInLabel='1' pieYScale='45' pieBorderAlpha='40' pieFillAlpha='70' pieSliceDepth='15' pieRadius='100' decimalSeparator='.' thousandSeparator=',' formatnumber='1' bgColor='DCDCDC'>"

						for r=0 to ubound(RegIdioma_A,2)
							'valor=quitarComa(formatNumber(RegIdioma_A(MPelasIdi_A,r)/totalIdioma_A*100,1))
							valor=RegIdioma_A(MPelasIdi_A,r)
							elxml2=elxml2 & "<set value='" & valor & "' "
							select case lcase(RegIdioma_A(MIdioma_A,r))
								case "es"
									eseIdioma=objIdioma.getTraduccion("i_espanol")
									color=colorEspanol
								case "en"
									eseIdioma=objIdioma.getTraduccion("i_ingles")
									color=colorIngles
								case "de"
									eseIdioma=objIdioma.getTraduccion("i_aleman")
									color=colorAleman
								case "fr"
									eseIdioma=objIdioma.getTraduccion("i_frances")
									color=colorFrances
								case "it"
									eseIdioma=objIdioma.getTraduccion("i_italiano")
									color=colorItaliano
							end select
							elxml2=elxml2 & "name='" & eseIdioma & "' color='" & color & "'/>"
						next
						elxml2=elxml2 & "</graph>"
						end if 'hayIdioma_A
						
						if hayIdioma then%>
						<div id="PelasDiv" align="center" style="margin-top:20px; margin-left:10px; float:left; height:200px"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_Pie3D.swf", "Reservas", "380", "200");
						   chart.setDataXML("<%=elxml%>");		   
						   chart.render("PelasDiv");
						</script>
						<%end if
						if hayIdioma_A then%>
						<div id="PelasDiv2" align="center" style="margin-top:20px; margin-left:10px; float:left; height:200px"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_Pie3D.swf", "Reservas2", "380", "200");
						   chart.setDataXML("<%=elxml2%>");		   
						   chart.render("PelasDiv2");
						</script>
						<%end if%>
					<%end if 'hay datos
					
					if hayMesIdioma then
						'Generar XML del grafico
						losmeses="<categories>"
						for m=1 to 12
							losmeses=losmeses & "<category name='"& ucase1(nombremesAbrev(m)) & "' HoverText='" & ucase1(nombremes(m)) & "'/>"
						next
						losmeses=losmeses & "</categories>"
						elxml="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_confirmadaspormes") & " " & any & "' yAxisName='" & objIdioma.getTraduccion("i_nreservas") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2' rotateNames='1' showvalues='0'>"
						elxml=elxml & losmeses
						elIdi="XX"
						for r=0 to ubound(RegMesIdioma,2)
							if elIdi<>RegMesIdioma(MMIdioma,r) then 'empieza serie
								select case lcase(RegMesIdioma(MMIdioma,r))
								case "es"
									eseIdioma=objIdioma.getTraduccion("i_espanol")
									color=colorEspanol
								case "en"
									eseIdioma=objIdioma.getTraduccion("i_ingles")
									color=colorIngles
								case "de"
									eseIdioma=objIdioma.getTraduccion("i_aleman")
									color=colorAleman
								case "fr"
									eseIdioma=objIdioma.getTraduccion("i_frances")
									color=colorFrances
								case "it"
									eseIdioma=objIdioma.getTraduccion("i_italiano")
									color=colorItaliano
								end select
								if r<>0 then cierre="</dataset>" else cierre=""
								elxml=elxml & cierre & "<dataset seriesname='" & eseIdioma & "' color='" & color & "' showValue='1' alpha='100' anchorAlpha='0' lineThickness='2'>"
								elMes=1
							end if 'empieza serie
							for m=elMes to 12
								if RegMesIdioma(MMesIdi,r)=m then
									valor=RegMesIdioma(MMPelasIdi,r)
									elxml=elxml & "<set value='" & valor & "' />"
									elMes=m+1
									exit for
								else
									elxml=elxml & "<set value='0' />"
								end if 'no hay este mes
							next

							elIdi=RegMesIdioma(MMIdioma,r)
							'elxml=elxml & "</dataset>"
						next 'regMesIdioma
						elxml=elxml & "</dataset>"
						elxml=elxml & "</graph>"
						'response.write elxml
						
						if hayMesIdioma_A then
							elxml2="<graph caption='" & titulo & "' subcaption='" & objIdioma.getTraduccion("i_confirmadaspormes") & " " & compara & "' yAxisName='" & objIdioma.getTraduccion("i_nreservas") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2' rotateNames='1' showvalues='0'>"
							elxml2=elxml2 & losmeses
							elIdi="XX"
							for r=0 to ubound(RegMesIdioma_A,2)
								if elIdi<>RegMesIdioma_A(MMIdioma_A,r) then 'empieza serie
									select case lcase(RegMesIdioma_A(MMIdioma_A,r))
									case "es"
										eseIdioma=objIdioma.getTraduccion("i_espanol")
										color=colorEspanol
									case "en"
										eseIdioma=objIdioma.getTraduccion("i_ingles")
										color=colorIngles
									case "de"
										eseIdioma=objIdioma.getTraduccion("i_aleman")
										color=colorAleman
									case "fr"
										eseIdioma=objIdioma.getTraduccion("i_frances")
										color=colorFrances
									case "it"
										eseIdioma=objIdioma.getTraduccion("i_italiano")
										color=colorItaliano
									end select
									if r<>0 then cierre="</dataset>" else cierre=""
									elxml2=elxml2 & cierre & "<dataset seriesname='" & eseIdioma & "' color='" & color & "' showValue='1' alpha='100' anchorAlpha='0' lineThickness='2'>"
									elMes=1
								end if 'empieza serie
								for m=elMes to 12
									if RegMesIdioma_A(MMesIdi_A,r)=m then
										valor=RegMesIdioma_A(MMPelasIdi_A,r)
										elxml2=elxml2 & "<set value='" & valor & "' />"
										elMes=m+1
										exit for
									else
										elxml2=elxml2 & "<set value='0' />"
									end if 'no hay este mes
								next
	
								elIdi=RegMesIdioma_A(MMIdioma_A,r)
								'elxml=elxml & "</dataset>"
							next 'regMesIdioma
							elxml2=elxml2 & "</dataset></graph>"

						end if 'haymesIdioma_a
					
					end if
					if hayMesIdioma then%>
						<div id="PelasDivs" align="center" style="margin-top:20px; margin-left:10px; float:left; height:260px"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_MSLine.swf", "Reservas", "380", "260");
						   chart.setDataXML("<%=elxml%>");		   
						   chart.render("PelasDivs");
						</script>
					<%end if%>
					<%if hayMesIdioma_A then%>
						<div id="PelasDivd" align="center" style="margin-top:20px; margin-left:10px; float:left; height:260px"></div>
						<script type="text/javascript">
						   var chart = new FusionCharts("fusion/FCF_MSLine.swf", "Reservas", "380", "260");
						   chart.setDataXML("<%=elxml2%>");		   
						   chart.render("PelasDivd");
						</script>
					<%end if%>