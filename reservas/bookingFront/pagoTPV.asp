<%tipoVenta=2 'on line
Fpago=1
'comprobar que no venga de otro sitio
servidor=lcase("" & request.ServerVariables("HTTP_X_FORWARDED_HOST"))
'servidorChrome=lcase("" & request.ServerVariables("HTTP_ORIGIN"))
'For Each var in Request.ServerVariables
' 	Response.Write(var & " " & Request(var) & "<br>")
'Next

		hotel=true
		online4=true
		'if instr(servidor,"bookvillas")=0 and instr(servidorChrome,"bookvillas")=0 then 'se estan colando
		if instr(servidor,"book-villa")=0 then 'se estan colando
			hotel=false
		end if
		'if instr(servidor,"online4you")=0 and instr(servidorChrome,"online4you")=0 then 'se estan colando
		if instr(servidor,"online4you")=0 then 'se estan colando
			online4=false	
		end if
		acceso=(online4 or hotel)
		if (not acceso) then 'se estan colando
			response.write "Operacion no autorizada"
			response.End()	
		end if
%>
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_recogeHabis.asp"-->
<!--#include file="CR_GrabaDatosBD.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<%

if codres<>0 then 'mirar los servicios extras
	set base=server.createobject("ADODB.Connection")
	base.Open Conecta
	
	anteservi=0
	if hayServis then
	for s=0 to ubound(RegServis,2)
		if anteservi<>RegServis(SCodi,s) then
			linea=0
		else
			linea=linea+1
		end if
		'Comprobar si esta marcado
		if request.form("servi_" & RegServis(SCodi,s) & "_" & linea)="1" then 'est� marcado
			cantidad=paClng(request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea))
			'response.write cantidad & " " & RegServis(SNombre,s) & "<br>"
			if cantidad>0 then 
				cs="INSERT INTO " & precrs & "ReservaServicio (CodReserva,IdServicio,Cuantas,Pelas,Tarifa,IdColectivo) VALUES ("
				cs=cs & codres & "," & RegServis(SCodi,s) & "," & cantidad
				cs=cs & "," & quitarComa(RegServis(SPelas,s)) & ",1," & RegServis(SCColec,s) & ")"
				base.execute cs
			end if 'cantidad>0
		end if
	
		anteservi=RegServis(SCodi,s)
	next 's
	end if 'hayServis


	'grabar si tiene ofertas de reserva
	codioferta=split(request.form("codiofertas"),"-")
	sumaoferta=split(request.form("sumaofertas"),"-")
	for o=0 to ubound(codioferta)
		if trim(codioferta(o))<>"" and trim(codioferta(o))<>"0" and trim(codioferta(o))<>"1" and trim(codioferta(o))<>"-1" then
			if (o<=ubound(sumaoferta)) then
				cs="INSERT INTO " & precrs & "OfertasReserva (IdOferta,IdReserva,Importe) VALUES ("
				cs=cs & codioferta(o) & "," & codres & "," & quitarComa(sumaoferta(o)) & ")"
				base.execute cs
			end if
		end if
	next 'o
	

	'Poner la reserva como confirmada mientras est� de pruebas
	'cs="UPDATE Reservas SET Activa=1 WHERE Cod_Res=" & codres
	'base.execute cs

	
	'Poner la url
	cs="UPDATE " & precrs & "Reservas SET url='"& Request.ServerVariables("server_name") & "' WHERE Cod_Res=" & codres
	base.execute cs
	
	
	base.close
	set base=nothing

end if 'codres<>0
	
	select case (TPV_tipoPago) 
		  Case 1 ' TPV CECA %>
			<!--#include file="TPV_Ceca_snapshot.asp"-->
         <%   
		 Case 2 ' TPV Sermepa %>
			<!--#include file="TPV_Sermepa.asp"-->
		<% 	
		Case 3 ' TPV 4B %>
			<!--#include file="TPV_4B.asp"-->
		<%	
		 Case 4 'TPV BBVA %>
			<!--# include file="TPV_BBVA.asp"-->
    <%        
	end select
%>