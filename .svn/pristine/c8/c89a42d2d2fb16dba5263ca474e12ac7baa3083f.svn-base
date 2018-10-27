<%
est=clng(request.QueryString("idh"))
FLlegada=cdate(request.form("fini"))
FSalida=cdate(request.form("ffin"))
fini=FLlegada
ffin=FSalida

response.Write(request.form)
response.End()

NHotel=request.Form("nhotel") 'nombre hotel
logo=request.Form("logo") 'Logo hotel
Noches=FSalida-FLlegada

'Datos cliente de la reserva
nombre=quitarApos(request.form("nom"))
apellidos=quitarApos(request.form("ape"))
telefono=quitarApos(request.form("tel"))
email=quitarApos(request.form("email"))
email2=quitarApos(request.form("email2"))
obs=quitarApos(request.form("com"))

checkFactura=quitarApos(request.form("checkFactura"))
factCifNif=quitarApos(request.form("factCifNif"))
factCP=quitarApos(request.form("factCP"))
factDir=quitarApos(request.form("factDir"))
factLoc=quitarApos(request.form("factLoc"))
factProv=quitarApos(request.form("factProv"))
factEmail=quitarApos(request.form("factEmail"))

checkPersonaContacto=quitarApos(request.form("checkPersonaContacto"))
apeContact=quitarApos(request.form("apeContact"))
nomContact=quitarApos(request.form("nomContact"))
tipoDocu=quitarApos(request.form("tipoDocu"))
tipoDocuId=quitarApos(request.form("tipoDocuId"))
documento=quitarApos(request.form("documento"))


deseoRecibirOfertas=quitarApos(request.form("deseoRecibirOfertas"))
acepto=quitarApos(request.form("acepto"))



importe=cdbl(request.form("totalres"))
PrePago=cdbl(request.form("prepago"))
bruto=cdbl(request.form("bruto"))
codiofertas=request.form("codiofertas")
sumaofertas=request.form("sumaofertas")
info=request.form("informacion")
if info="" then info="0"
codcancel=""
servicios=request.form("servicios")
'Agencia
idagencia=paClng(request.form("idagencia"))
fpago=paClng(request.Form("fpago"))
'Permitir repetir email en las fichas
repite_email=paClng(request.form("repite_email"))


parametros="grabaReserva.asp?ide=" & idEmpresa & "&est=" & est & "& lang=" & lang & "&fini=" & FLlegada & "&ffin=" & FSalida 
parametros=parametros & "&nom=" & server.URLEncode(nombre) & "&ape=" & server.URLEncode(apellidos)
parametros=parametros & "&tel=" & telefono
parametros=parametros & "&email=" & email
parametros=parametros & "&email2=" & email2
parametros=parametros & "&com=" & server.URLEncode(com)
parametros=parametros & "&checkFactura=" & checkFactura
parametros=parametros & "&factCifNif=" & factCifNif
parametros=parametros & "&factCP=" & factCP
parametros=parametros & "&factDir=" & server.URLEncode(factDir)
parametros=parametros & "&factLoc=" & server.URLEncode(factLoc)
parametros=parametros & "&factProv=" & server.URLEncode(factProv)
parametros=parametros & "&factEmail=" & factEmail
parametros=parametros & "&checkPersonaContacto=" & checkPersonaContacto
parametros=parametros & "&apeContact=" & apeContact
parametros=parametros & "&nomContact=" & server.URLEncode(nomContact)
parametros=parametros & "&tipoDocu=" & tipoDocu
parametros=parametros & "&tipoDocuId=" & tipoDocuId
parametros=parametros & "&documento=" & documento
parametros=parametros & "&deseoRecibirOfertas=" & deseoRecibirOfertas
parametros=parametros & "&acepto=" & acepto
parametros=parametros & "&informacion=" & info

parametros=parametros & "&totalres=" & redondear(importe) 
parametros=parametros & "&prepago=" & redondear(prepago) 
parametros=parametros & "&bruto=" & redondear(bruto)
parametros=parametros & "&codiofertas=" & codiofertas 
parametros=parametros & "&sumaofertas=" & sumaofertas 
parametros=parametros & "&informacion=" & info
parametros=parametros & "&tv=" & tipoventa 
parametros=parametros & "&idage=" & idagencia 
parametros=parametros & "&fpago=" & fpago
parametros=parametros & "&remail=" & repite_email

'responselog "parametros"&parametros 
'if esplaneta then
'	response.End()
'end if 
'Añadir los datos a la tabla TipoReserva
parametros=parametros & "&cuantas=" & cuantas
'response.write "Cuantas: " & cuantas
for h=1 to ubound(Vhabis)
	parametros=parametros & "&habi-" & h & "=" & Vhabis(h)
	parametros=parametros & "&adultos-" & h & "=" & Vadultos(h)
	parametros=parametros & "&ninos1-" & h & "=" & Vninos1(h)
	parametros=parametros & "&ninos2-" & h & "=" & Vninos2(h)
	parametros=parametros & "&bebes-" & h & "=" & Vbebes(h)
	parametros=parametros & "&suple-" & h & "=" & codsuples(h)
	parametros=parametros & "&importe-" & h & "=" & redondear(VImporte(h))
next

'response.write parametros & "<br><br>"
'response.End()

codres=0
Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
if objDom.Load(xmlURL & parametros) then

	For Each objItem in objDom.documentElement.SelectNodes("/data")
		'Datos del hotel
		nhotel=objItem.SelectSingleNode("hotel").text
		estado=objItem.SelectSingleNode("estado").text
		total=objItem.SelectSingleNode("totalreserva").text
		if isnumeric(total) then
			totalbruto=totalbruto+cdbl(total)
		end if
		prepago=objItem.SelectSingleNode("prepago").text
		if isnumeric(prepago) then
			prepago=cdbl(prepago)
		else
			prepago=0
		end if
		codres=paClng(objItem.SelectSingleNode("codres").text)
		pid=objItem.SelectSingleNode("pid").text
		clave=objItem.SelectSingleNode("clave").text
		
	next 'each

	'response.write "Reserva: " & codres & " --> " & totalbruto & "<br>"

else
	 ' No se ha cargado el documento.
	
		' Obtenga el objeto ParseError
		Set xPE = objDom.parseError
		
		strErrText = "aYour XML Document failed to load due the following error.<br>"
		strErrText =strErrText & "Error #: " & xPE.errorCode & ": " & xPE.reason & "<br>"
		strErrText =strErrText & "Line #: " & xPE.Line & "<br>"
		strErrText =strErrText & "Line Position: " & xPE.linepos & "<br>"
		strErrText =strErrText & "Position In File: " & xPE.filepos & "<br>"
		strErrText =strErrText & "Source Text: " & xPE.srcText & "<br>"
		strErrText =strErrText & "Document URL: " & xPE.url & "<br>"
		response.write strErrText
end if	

Set objDom = Nothing
Set objItem = Nothing

set base=server.createobject("ADODB.Connection")
base.Open Conecta

'grabar las ofertas 
if codres<>0 then 'buscar ofertas
	for o=0 to 10 'busco hasta 10 ofertas
		codiOferta=paClng(request.form("codiOferta_" & o))
		if codiOferta=0 then exit for
		pelasOferta=paDbl(request.form("pelasOferta_" & o))
		cs="INSERT INTO " & precrs & "OfertasReserva(IdOferta,IdReserva,Importe) VALUES (" & codiOferta & "," & codres & ","
		cs=cs & quitarComa(pelasOferta) & ")"
		base.execute cs
	next 'o
end if 'codres<>0

base.close
set base=nothing
%>