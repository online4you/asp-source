<%
tipoa=request.querystring("tipoa")
cate=request.querystring("cate")
zona=request.querystring("zona")
lang=request.querystring("lang")
fechai=request.querystring("fechai")
fechaf=request.querystring("fechaf")
adultos=request.querystring("adultos")
ninos=request.form("ninos")
datos="lang=" & lang & "&tipoa=" & tipoa & "&cate=" & cate & "&zona=" & zona & "&fechai=" & fechai
datos=datos & "&fechaf=" & fechaf & "&adultos=" & adultos & "&ninos=" & ninos
 
fichero="http://www.hotel-reserved.com/admincala/BuscarPrecios.asp?" & datos
'response.write(fichero)
'fichero="http://admin.globalsys.info/clientes/VisitCalaMillor/prueba.xml"

Set objDom = Server.CreateObject("Microsoft.XMLDOM")   
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
objDom.load(fichero)
 
if objDom.load(fichero) then
	response.write("true")
else
	response.write("false")
end if
Set objDom = Nothing
%>