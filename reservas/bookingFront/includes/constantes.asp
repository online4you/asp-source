<%
langPorDefecto="es"
precrsgen="jos_crsgen_"
precrs="jos_crs_"

constCodEmpresa=98

relative_url="/reservas/CRS/"
relativeFront_url="/reservas/bookingFront/"
if (split(Request.ServerVariables("SERVER_NAME"),".")(0)="bookvilla") then
	mainUrl="http://www.book-villa.com"
elseif (split(Request.ServerVariables("SERVER_NAME"),".")(0)="online4youhotels") then
	mainUrl="http://www.online4youhotels.com"
end if 

Front_url=  mainUrl & relativeFront_url
server_path="C:\ASP\"
'carpeta del XML traducciones
rutaXMLIdioma="idiomaXML/"

key_googlemap="ABQIAAAA5HtCtsdXDjN6siIvj3IkpxSFdWORbeINMojXKQi-ASISzlrnrBRBqKFYsBaY2mR8_Rmy8Uu9bxV4bg"

'Datos correo

'formas de pago
fp_verificacion=0 'formulario con verificacion de tarjeta
fp_onrequest=1 'formulario on request
fp_ceca=2 'tpv de ceca
fp_sermepa=3 'tpv de sermepa, servired, la caixa
fp_4b=4 'tpv de 4b (santander)
fp_bbva=5 'tpv del bbva

'Variables de tipo servicio
porpersona=0
porreserva=1
pordia=2
porpersonaydia=3
porhabitacion=4


%>