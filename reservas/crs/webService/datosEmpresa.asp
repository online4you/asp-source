<!--#include file="funciones.asp"-->
<%
ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=localhost"
ConectaMDBServer="ddbb.online4youhotels.com"
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

precrsgen="jos_crsgen_"
precrs="jos_crs_"

server.ScriptTimeout=100

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

idEmpresa=request.QueryString("ide") 'la empresa

cs="SELECT * "
cs=cs & "FROM " & precrsgen & "empresas "
cs=cs & "WHERE Id=" & idEmpresa
'response.write(cs)
rs.open cs,base
if not rs.eof then
	conexBD="" & rs("ConexionBD")
	nombreBD="" & rs("nombreBD")
	userBD="" & rs("userBD")
	pwdBD="" & rs("PwdBD")
	modulosPW="" & rs("Modulos")
	rutaFotos="" & rs("rutaFotos")
	if right(rutaFotos,1)<>"/" then rutafotos=rutafotos & "/"
	rutaDocu="" & rs("rutaDocu")
	if right(rutaDocu,1)<>"/" then rutaDocu=rutaDocu & "/"
	Empresa="" & rs("Nombre")
	SMTP_Server="" & rs("smtpServer")
	remite_Cuenta="" & rs("remiteCuenta")
	Login_Cuenta="" & rs("LoginCuenta")
	Clave_Cuenta="" & rs("PWDCuenta")
	multiTarifa=rs("MultiTarifa")
	repiteMail=rs("repiteMail") 'Repite email
	con_cms=rs("cms") 'gestor contenidos
	con_googlemaps=rs("googlemaps") 'google Maps
	xDefaultMaps=rs("xDefaultMaps") 'pos X google Maps
	yDefaultMaps=rs("yDefaultMaps") 'pos Y google Maps
	zoomDefaultMaps=rs("zoomDefaultMaps") 'zoom google Maps
	elCharSet="" & rs("CharSet") 'encoding pagina
	if elCharSet="" then elCharSet="UTF-8" 'por defecto
	if ucase(elCharSet)="ISO-8859-1" then elCodePage="1252" 
end if
rs.close

base.close
set base=nothing
set rs=nothing





'Conexion SQL Server
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
Conecta="Driver={MySQL ODBC 5.1 Driver};Server=" & conexBD & ";Database=" & nombreBD & ";Uid=" & userBD & ";Pwd=" & pwdBD 

'response.Write Conecta

%>