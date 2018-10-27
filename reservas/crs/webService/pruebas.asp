<%

            Set objDom = Server.CreateObject("MSXML2.ServerXMLHTTP")
						objDom.SetTimeouts 40000,40000,40000,40000
							
						objDom.open "GET", "http://www.planetaweb.es/reservas/webservice/precioHabitacion.asp?ide=27&est=17&fini=14/10/08&ffin=19/10/08&ad=2&codhab=40&codsup=1&lang=es",false
							
						objDom.send
							
						response.write objDom.responseText
						Set objDom = Nothing
							
							
							
%>							