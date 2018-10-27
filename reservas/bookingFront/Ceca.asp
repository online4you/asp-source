<%tipoVenta=2 'on line

'comprobar que no venga de otro sitio
servidor=lcase("" & request.ServerVariables("HTTP_REFERER"))
if instr(servidor,"booking.kubikcrs.com")=0 then 'se estan colando
	response.write "Operacion no autorizada"
	response.End()	
end if

%>
<!--#include file="includes/funciones.asp"-->
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
		if request.form("servi_" & RegServis(SCodi,s) & "_" & linea)="1" then 'está marcado
			cantidad=paClng(request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea))
			'response.write cantidad & " " & RegServis(SNombre,s) & "<br>"
			if cantidad>0 then 
				cs="INSERT INTO ReservaServicio (CodReserva,IdServicio,Cuantas,Pelas,Tarifa,IdColectivo) VALUES ("
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
		if trim(codioferta(o))<>"" then
			cs="INSERT INTO OfertasReserva (IdOferta,IdReserva,Importe) VALUES ("
			cs=cs & codioferta(o) & "," & codres & "," & quitarComa(sumaoferta(o)) & ")"
			base.execute cs
		end if
	next 'o
	

	'Poner la reserva como confirmada mientras esté de pruebas
	cs="UPDATE Reservas SET Activa=1 WHERE Cod_Res=" & codres
	base.execute cs

	base.close
	set base=nothing

end if 'codres<>0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
</head>
<body>
<p>
    Guardada reserva <%=codres%> del establecimiento <%=nombreHotel%>
    <br/>
    Conexi&oacute;n con el TPV del banco.
</p>
</body>
</html>

