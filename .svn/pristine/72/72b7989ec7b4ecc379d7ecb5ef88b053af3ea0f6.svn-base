					<%
					ultDia=31
					do while not isdate(ultDia & "/" & mes & "/" & any)
						ultDia=ultDia-1
					loop
					
					losmeses="<categories>"
					for m=1 to ultDia
						fecha=cdate(m & "/" & mes & "/" & any)
						losmeses=losmeses & "<category name='" & ucase1(diascortos(WeekDay(fecha,vbmonday))) & "' HoverText='" & ucase1(diaslargos(WeekDay(fecha,vbmonday))) & " " & m & "'/>"
					next
					losmeses=losmeses & "</categories>"
					
					if hayestemes then
						'Generar XML del grafico
						elxml="<graph caption='" & titulo & "' subcaption='' xAxisName='" & objIdioma.getTraduccion("i_reservasconfirmadasmes") & " " & ucase(nombremes(mes)) & " " & any & " = " & formatnumber(totalnReservas,0) & "' yAxisName='" & objIdioma.getTraduccion("i_nreservas") & "' decimalPrecision='0' formatNumberScale='0' bgColor='DCDCDC' canvasBgColor='F0E7C3' canvasBaseColor='E7BD06' decimalSeparator=',' thousandSeparator='.' formatnumber='1' chartRightMargin='2'>"
						elxml=elxml & losmeses
						'response.write elxml
						'Mes actual
						elxml=elxml & "<dataset seriesname='" & ucase1(nombremes(mes)) & " " & any & "' color='95BAF2'>"
						for m=1 to ultDia
							valor=0
							fecha=cdate(m & "/" & mes & "/" & any)
							for r=0 to ubound(RegMes,2)
								if RegMes(MDia,r)=m then
									valor=quitarComa(redondear(RegMes(MPelas,r)))
									exit for
								end if
							next
							color="95BAF2"
							if weekday(fecha)=vbsaturday OR weekday(fecha)=vbsunday then color="002AFF"
							elxml=elxml & "<set value='" & valor & "' color='" & color & "'/>"
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
