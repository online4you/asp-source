<%
precrsgen="jos_crsgen_"
precrs="jos_crs_"

set base=server.createobject("ADODB.Connection")
ConectaMDBServer="bbdd.online4youhotels.com"
connexionLocal=request.Form("connexionLocal")
if (connexionLocal="") then
	connexionLocal=request.QueryString("connexionLocal")
end if
if (connexionLocal="true") then
	ConectaMDBServer="127.0.0.1"
end if
if (localConnection=true) then
	ConectaMDBServer="127.0.0.1"
end if

ConectaMDB = "Driver={MySQL ODBC 5.1 Driver};Server="& ConectaMDBServer &";Database=" & split(Request.ServerVariables("SERVER_NAME"),".")(0) & ";Uid=reservas;Pwd=O4u7612;"

base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if paClng(idEmpresa)=0 then
	idEmpresa=paClng(request.QueryString("ide")) 'la empresa hotelera
	if idEmpresa=0 then paClng(request.form("ide")) 
end if
servidor=lcase("" & request.ServerVariables("HTTP_HOST"))
lang=lcase(request.QueryString("lang"))

if idEmpresa=0 then idEmpresa=constCodEmpresa 'esta es la empresa de pruebas Kubik

'valores por defecto
multiTarifa=false
laTarifa=1 'Tarifa General
elCharSet="UTF-8" 'por defecto
elCodePage="65001" 'por defecto

cs="SELECT * "
cs=cs & "FROM " & precrsgen & "empresas "
cs=cs & "WHERE Id=" & idEmpresa

rs.open cs,base
if not rs.eof then
	conexBD="" & rs("ConexionBD")
	nombreBD="" & rs("NombreBD")
	userBD="" & rs("userBD")
	pwdBD="" & rs("PwdBD")
	modulosPW="" & rs("Modulos")
	rutaFotos="" & rs("rutaFotos")
	'rutafotos="http://admin.kubikcrs.com" & rutafotos
	rutaDocu="" & rs("rutaDocu")
	'rutaDocu="http://admin.kubikcrs.com" & rutaDocu
	Empresa="" & rs("Nombre")
	smtpserver="" & rs("SMTPServer")
	logincuenta="" & rs("LoginCuenta")
	clavecuenta="" & rs("pwdCuenta")
	remitente="" & rs("remiteCuenta")
	conCMS=rs("CMS")
	conGoogleMaps=rs("GoogleMaps")
	elCharSet="" & rs("CharSet") 'encoding pagina
	if elCharSet="" then elCharSet="UTF-8" 'por defecto
	if ucase(elCharSet)="ISO-8859-1" then elCodePage="1252"
	
	multiTarifa=rs("multiTarifa")
	xGoogleMaps=rs("xDefaultMaps")
	yGoogleMaps=rs("yDefaultMaps")
	zoomGoogleMaps=rs("zoomDefaultMaps")
	admiteninos=rs("admiteninos")
	
	langPorDefecto="es"
	Idiomas=trim("" & rs("Idiomas"))

	'Tabla de idiomas
	if Idiomas="" then 
		Idiomas="es, en" 
	end if 'por defecto
	if right(idiomas,1)="," then 
		idiomas=left(idiomas,len(idiomas)-1) 
	end if
	ListaIdiomas=split(Idiomas,", ")
	
	
	if ubound(listaIdiomas)>0 then 
		langPorDefecto=listaIdiomas(0) 'la primera es el idioma principal
	end if
	

end if
rs.close

'Comprobar si tienen diferentes tamaños de fotos
cs="SELECT Ancho,Alto,Prefijo,ProporcionAncho FROM " & precrsgen & "sizegraficos WHERE IdEmpresa=" & idEmpresa
rs.open cs,base
haySize=false
if not rs.eof then
	RegSize=rs.getrows
	RegAncho=0
	RegAlto=1
	RegPrefi=2
	RegPAncho=3
	haySize=true
end if
rs.close

'Comprobar si viene id usuario
idUser=paClng(request.QueryString("iduser"))
if idUser=0 then idUser=paClng(session("idUser"))
buscoHoteles="" 'saca todos los hoteles
listaH=""
if idUser<>0 then 'buscar sus hoteles
	cs = "SELECT CodigoEsta FROM " & precrsgen & "permisosporesta "
	cs=cs & "WHERE IdUsuario=" & idUser
	'response.Write(cs)
	rs.Open cs,base
	'Cargar los hoyteles que tiene, el adminst. no tiene hoteles espec.
	if not rs.eof then
		do while not rs.eof
			listaH=listaH & rs("CodigoEsta") & "-"
			rs.MoveNext
		loop

		listaH=left(listaH,len(listaH)-1)
		buscoHoteles="("
		buenos=split(listaH,"-")
		for b=0 to ubound(buenos)
			if isnumeric(buenos(b)) then
				buscoHoteles=buscoHoteles & "Establecimientos.CodigoEsta=" & buenos(b) & " OR "
			end if
		next
		buscoHoteles=left(buscoHoteles,len(buscoHoteles)-4) & ")"
	end if 'eof
	rs.close
	'response.write "Lista:"&buscoHoteles&"<br>"
end if 'idUser

session("idUser")=idUser
			

set rs=nothing
base.close
set base=nothing

'encoding de la pagina
session.CodePage=elCodePage
response.Charset=elCharSet

'Conexion SQL Server de la empresa
connexionLocal=request.Form("connexionLocal")
if (connexionLocal="") then
	connexionLocal=request.QueryString("connexionLocal")
end if
if (connexionLocal="true") then
	conexBD="127.0.0.1"
end if
if (localConnection=true) then
	conexBD="127.0.0.1"
end if
Conecta = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=" & userBD & ";pwd=" & pwdBD & ";Initial Catalog=" & nombreBD & ";Data Source=" & conexBD
Conecta = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\gpuigros\Desktop\Joomla\Aplicaciones\CRS\HotelHoteles.accdb;Persist Security Info=False;"
Conecta="Driver={MySQL ODBC 5.1 Driver};Server=" & conexBD & ";Database=" & nombreBD & ";Uid=" & userBD & ";Pwd=" & pwdBD 



%>
