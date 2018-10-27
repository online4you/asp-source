<%
debugcode=0
precrsgen="jos_crsgen_"
precrs="jos_crs_"

relative_url="/reservas/CRS/"
server_path="C:\ASP\"



'BD de los datos centralizados
'ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=jupiter.planeta-web.com"
ConectaMDB = "Driver={MySQL ODBC 5.1 Driver};Server=ddbb.online4youhotels.com;Database=" & split(Request.ServerVariables("SERVER_NAME"),".")(0) & ";Uid=reservas;Pwd=O4u7612;"

RegPorPag=15 'por defecto registros por pagina

lang=lcase("" & request.QueryString("lang"))
if lang="" then lang=request.Cookies("lang")
if lang="" then lang="es"
sqltail="_" & lang
if lang="es" then sqltail="" 'espaol no usa coletilla en algunos campos
response.Cookies("lang")=lang

'Tipos moneda
tm_euro=0
tm_dolar=1

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
	
If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"MSIE") then
	es_ie=true
Else
	es_ie=false	
End If

'Año			
anyo=paClng(request.Cookies("anyo"))
if anyo=0 then anyo=year(date)

'Tarifa
laTarifa=paclng(request.Cookies("tarifa"))
if laTarifa=0 then laTarifa=1 'tarifa General

'antes mdulos
mod_estandar=1
mod_recepcion=2
mod_ofertas=3
mod_class=4
mod_agencias=5
mod_yield=6

'valores de los banners
 PagTodas=0
 PagHome=1
 PagInterior=2

 PosDerecha=0
 PosCentro=1
 PosArriba=2

'antes de las fotos
 fotoancho=600 'foto grande
 th_ficha=350 'foto de la ficha en petit
 th_galeria=100 'foto en la galeria
 th_home=141 'foto en la home

'Rutas en el servidor
 rutahoteles="/Hoteles"
' rutaFotos="/Fotos/"
'rutaFotos=request.Cookies("rutaFotos")
'rutaDocu=request.Cookies("rutaDocu")
' rutaBanners="/Banners/"

'Estado del hotel
 noventa=0
 onrequest=1
 online=2

'Clases categoria hotels
 nada=0
 estrella=1
 llave=2

est=request.QueryString("est")

'Variable del nombre de la pagina
MiPag=request.servervariables("SCRIPT_NAME")

'Flechas
FlechaLeft="<img src='/img/flechaIzq.gif' width='9' height='8' border='0'/>"
FlechaRight="<img src='/img/flechaDer.gif' width='9' height='8' border='0'/>"
FlechaUp="<font FACE=WingDings size='2'>" & chr(241) & "</font>"
FlechaDown="<font FACE=WingDings size='2'>" & chr(242) & "</font>"

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2

%>