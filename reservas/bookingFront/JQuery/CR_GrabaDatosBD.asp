<%
est=clng(request.QueryString("idh"))
FLlegada=cdate(request.form("fini"))
FSalida=cdate(request.form("ffin"))
fini=FLlegada
ffin=FSalida

NHotel=request.Form("nhotel") 'nombre hotel
logo=request.Form("logo") 'Logo hotel
Noches=FSalida-FLlegada

'Datos cliente de la reserva
nombre=quitarApos(request.form("nom"))
apellidos=quitarApos(request.form("ape"))
direccion=quitarApos(request.form("dir"))
cp=quitarApos(request.form("cp"))
poblacion=quitarApos(request.form("loc"))
provincia=quitarApos(request.form("prov"))
pais=quitarApos(request.form("pais"))
telefono=quitarApos(request.form("tel"))
movil=quitarApos(request.form("telmovil"))
fax=quitarApos(request.form("fax"))
email=quitarApos(request.form("email"))
obs=quitarApos(request.form("com"))
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


parametros="grabaReserva.asp?ide=" & idEmpresa & "&est=" & est & "&lang=" & lang & "&fini=" & FLlegada & "&ffin=" & FSalida 
parametros=parametros & "&nom=" & server.URLEncode(nombre) & "&ape=" & server.URLEncode(apellidos) & "&dir=" & server.URLEncode(direccion) & "&cp=" & cp
parametros=parametros & "&loc=" & server.URLEncode(poblacion) & "&prov=" & server.URLEncode(provincia) & "&pais=" & server.URLEncode(pais) & "&tel=" & telefono
parametros=parametros & "&telmovil=" & movil & "&fax=" & fax & "&email=" & email & "&com=" & server.URLEncode(obs)
parametros=parametros & "&totalres=" & importe & "&prepago=" & prepago & "&bruto=" & bruto
parametros=parametros & "&codiofertas=" & codiofertas & "&sumaofertas=" & sumaofertas & "&informacion=" & info
parametros=parametros & "&tv=" & tipoventa & "&idage=" & idagencia & "&fpago=" & fpago
parametros=parametros & "&remail=" & repite_email

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
next

'response.write parametros & "<br><br>"
'response.End()

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
		codres=objItem.SelectSingleNode("codres").text
		pid=objItem.SelectSingleNode("pid").text
		clave=objItem.SelectSingleNode("clave").text
		
	next 'each

	'response.write "Reserva: " & codres & " --> " & totalbruto & "<br>"

else
	 ' No se ha cargado el documento.
	
		' Obtenga el objeto ParseError
		Set xPE = objDom.parseError
		
		strErrText = "Your XML Document failed to load due the following error.<br>"
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

%>