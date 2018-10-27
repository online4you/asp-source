<% if codres<>0 then 'va bien
	' Esta condicion es para saber si el TPV esta en modo pruebas o si ya esta online, 
	' este valor los sacamos de "CR_datosHotel.asp" 
	if TPV_produccion = 0 then 'Modulo en simulacion
		laurl="https://tpv2.4b.es/simulador/teargral.exe"
	else 'Modulo en Modo Real
		laurl="https://tpv.4b.es/tpvv/teargral.exe"
	end if
	
	'responseLog("TPV_codComercio: " & TPV_codComercio & " codres: " & codres)
	%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<HTML>
    	<HEAD>
        	<TITLE><%= nombreHotel%></TITLE>
        </HEAD>
        <BODY>
      
            <form name="fo" method="post" action="<%=laurl%>">
              <input name="ref" type="hidden" id="ref" value="<%=codres%>">
              <input name="cla" type="hidden" id="cla" value="<%=TPV_codComercio%>">
              <input name="lang" type="hidden" id="lang" value="<%=lang%>">
            </form>
            <script>
				//alert("laurl: <%=laurl%>");
				//alert("codres: <%=codres%>");
				//alert("TPV_codComercio: <%=TPV_codComercio%>");
				//alert("lang: <%=lang%>");
              	document.forms.fo.submit();
            </script>   
		</BODY>
	</HTML>

<%else 'ha habido un problema al crear la prereserva

	'Generar copia del voucher y enviar al cliente
%>

    <html>
    <head><title><%=nombreHotel%></title>
    </head>
    <body bgcolor='white'>	
        <p align="center">
        <%if msgError<>"" then
            response.write msgError
        else
            response.write objIdioma.getTraduccionHTML("cr_KO")
        end if 'msgError%>
        </p>
    </body>
    </html>
    
<% end if 'error crear prereserva
set objIdioma=nothing%>

