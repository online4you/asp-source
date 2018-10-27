<%
precrsgen="jos_crsgen_"
adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2

'ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=localhost"
'ConectaMDB = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\gpuigros\Desktop\Joomla\Aplicaciones\CRS\CRS_general.accdb;Persist Security Info=False;"
ConectaMDB = "Driver={MySQL ODBC 5.1 Driver};Server=ddbb.online4youhotels.com;Database=" & split(Request.ServerVariables("SERVER_NAME"),".")(0) & ";Uid=reservas;Pwd=O4u7612;"

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if idempresa="" then IdEmpresa=paClng(request.Cookies("IdEmpresa"))
adminBoss=false
'modulo MultiTarifa
multiTarifa=false
laTarifa=1 'Tarifa General
'elCharSet="UTF-8" 'por defecto
'elCodePage="65001" 'por defecto

elCharSet="ISO-8859-1" 'por defecto
elCodePage="1252" 'por defecto

'Datos de la empresa
cs="SELECT * FROM " & precrsgen & "empresas empresas "
cs=cs & "WHERE empresas.Id=" & IdEmpresa
'response.write(cs & "<br/>")
rs.open cs,base
if not rs.eof then
	conexBD="" & rs("ConexionBD")
	if rs("MySQL") then	mysqlBD=true
	userBD="" & rs("userBD")
	nombreBD="" & rs("nombreBD")
	pwdBD="" & rs("PwdBD")
	modulosCR="" & rs("Modulos")
	hojaestilos="" & rs("hojaEstilos")
	metaTitulo="" & rs("MetaTitulo")
	rutaFotos=trim("" & rs("rutafotos"))
	if right(rutaFotos,1)<>"/" then rutafotos=rutafotos & "/"
	rutaDocu=trim("" & rs("rutadocu"))
	if right(rutaDocu,1)<>"/" then rutaDocu=rutaDocu & "/"
	empresa="" & rs("Nombre")
	SMTP_Server="" & rs("smtpServer")
	remite_Cuenta="" & rs("remiteCuenta")
	Login_Cuenta="" & rs("LoginCuenta")
	Clave_Cuenta="" & rs("PWDCuenta")
	multiTarifa=rs("MultiTarifa")
	Idiomas=trim("" & rs("Idiomas"))
	con_cms=rs("cms") 'gestor contenidos
	con_googlemaps=rs("googlemaps") 'google Maps
	xDefaultMaps=rs("xDefaultMaps") 'pos X google Maps
	yDefaultMaps=rs("yDefaultMaps") 'pos Y google Maps
	zoomDefaultMaps=rs("zoomDefaultMaps") 'zoom google Maps
	elCharSet="" & rs("CharSet") 'encoding pagina
	if elCharSet="" then elCharSet="UTF-8" 'por defecto
	if ucase(elCharSet)="ISO-8859-1" then elCodePage="1252" 
	if IdEmpresa=0 then
		adminBoss=true
		mysqlBD=false
	end if
	rs.close

	langPorDefecto="es"
	maxLangListado=5 'nº maximo de idiomas en el listado
	'Tabla de idiomas
	if Idiomas="" then Idiomas="es, en, de, fr" 'por defecto
	if right(idiomas,1)="," then idiomas=left(idiomas,len(idiomas)-1)
	ListaIdiomas=split(Idiomas,", ")
	if ubound(listaIdiomas)>0 then langPorDefecto=listaIdiomas(0) 'la primera es el idioma principal

	hotelboss="0"		
	cs = "SELECT CodigoEsta FROM " & precrsgen & "permisosporesta "
	cs=cs & "WHERE IdUsuario=" & request.Cookies("IDCR")
	rs.Open cs,base
	'Cargar los hoyteles que tiene, el adminst. no tiene hoteles espec.
	listaH=""
	do while not rs.eof
		listaH=listaH & rs("CodigoEsta") & ";"
		rs.MoveNext
	loop
	if not rs.eof then 'quitar el ;
		listaH=left(listaH,len(listaH)-1)
	end if
	if adminBoss then listaH="0"
	if listaH="" then listaH="0"
	hotelboss=listaH
	rs.close

else
	rs.close
	'response.write "<center><h4>Usuario no correcto, tendrá que volver a entrar su clave<br><br>" & vbcrlf
	'response.write "<a href='index.asp?salir=Si'>Volver</a></h4></center>"
	'response.End()
	
	'es administrador
end if

'encoding de la pagina
session.CodePage=elCodePage
response.Charset=elCharSet
	
'Buscar si el usuario es Administrador Principal
cs="SELECT Id FROM " & precrsgen & "usuarios WHERE Id=" & request.Cookies("IDCR") & " AND Nivel=0 AND IdEmpresa=0"
rs.open cs,base
if not rs.eof then
	adminBoss=true
end if
rs.close


set rs=nothing
base.close
set base=nothing

%>