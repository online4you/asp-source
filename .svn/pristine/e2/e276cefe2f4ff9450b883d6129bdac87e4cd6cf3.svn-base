<%
'poner los iconos de la categoria hotel
function ponCategoria(esa)
	ponCategoria=""
	'separa por el - por si tiene el codigo y el nombre
	codcate=split(esa,"-")
	for ct=0 to ubound(codcate)
		if haycate then
		for cc=0 to ubound(RegCate,2)
			if RegCate(CaCodi,cc)=paClng(codcate(ct)) then 'es este codigo
				if RegCate(CaTipo,cc)=estrella then 'hoteles
					estilo="stars stars-" & left(RegCate(CaNombre,cc),1) 'nº de estrellas
				else 'llaves apartamento
					estilo="keys keys-" & left(RegCate(CaNombre,cc),1) 'nº de llaves
				end if
				ponCategoria=estilo
				exit for
			end if 'este
		next
		end if 'hayCate
	next 'lcate
end function

'Funcion para numero aleat. de la cabecera
function DameNumero(Mini,Maxi)
	Randomize
	DameNumero=int((Maxi-Mini+1)*rnd+Mini)	
end function


'BD de los datos centralizados
'ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=jupiter.planeta-web.com"
ConectaMDB = "Driver={MySQL ODBC 5.1 Driver};Server=ddbb.online4youhotels.com;Database=" & split(Request.ServerVariables("SERVER_NAME"),".")(0) & ";Uid=reservas;Pwd=O4u7612;"


if (split(Request.ServerVariables("SERVER_NAME"),".")(0)="bookvilla") then
	xmlURL="http://www.book-villa.com/reservas/crs/webservice/"
	xmlURL="http://bookvilla.book-villa.com/reservas/crs/webservice/"
elseif (split(Request.ServerVariables("SERVER_NAME"),".")(0)="online4youhotels") then
	xmlURL="http://online4youhotels.online4youhotels.com/reservas/crs/webservice/"
end if 

'Variables de tipo servicio
porpersona=0
porreserva=1
pordia=2
porpersonaydia=3
porhabitacion=4
	
Es_IE=false
If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"MSIE") then Es_IE=true

fg_ip= request.ServerVariables("REMOTE_ADDR") 'IP client
fg_ownerPWP="95.39.27.2" 'IP Planeta Palma
fg_ownerPWB="78.83.92.75" 'IP Planeta Bulgaria

esPlaneta=false 'IP de planeta
if (fg_ip=fg_ownerPWP or fg_ip=fg_ownerPWB) then esPlaneta=true

sub responseLog(CommentText)
	if (fg_ip=fg_ownerPWP or fg_ip=fg_ownerPWB) then
		response.write CommentText
	end if
end sub

function SortArray(varArray,ordenElemento,valorOrden)
	cuantos=ubound(varArray,2)
	valorOrden=lcase(valorOrden)
	if valorOrden="" or valorOrden="asc" then 'ascendente
		For i=cuantos To 0 Step -1
			MaxVal = varArray(ordenElemento,i) 'valor que se ordena
			MaxIndex = i
			For j = 0 To i
				If varArray(ordenElemento,j)>MaxVal Then '
					MaxVal = varArray(ordenElemento,j)
					MaxIndex = j
				End If
			Next
	
			If MaxIndex <> i Then 'intercambio de posicion
				for t=0 to ubound(varArray,1)
					cambio=varArray(t,i)
					varArray(t,i)=varArray(t,MaxIndex)
					varArray(t,MaxIndex)=cambio
				next
			End If
		Next
	else 'descendente
		For i=0 To cuantos
			MaxVal = varArray(ordenElemento,i) 'valor que se ordena
			MaxIndex = i
			For j = cuantos To i step -1
				If varArray(ordenElemento,j)>MaxVal Then '
					MaxVal = varArray(ordenElemento,j)
					MaxIndex = j
				End If
			Next
	
			If MaxIndex <> i Then 'intercambio de posicion
				for t=0 to ubound(varArray,1)
					cambio=varArray(t,i)
					varArray(t,i)=varArray(t,MaxIndex)
					varArray(t,MaxIndex)=cambio
				next
			End If
		Next
	end if 'valorOrden
end function

'las variable de smtpserver, logincuenta,clavecuenta y remitente los coge de los datos de la empresa
function sendEmailTo(para,asunto,remite,mensaje,adjunto)
	Set Mail= CreateObject("CDO.Message") 
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") =SMTPServer
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60    
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") =LoginCuenta
	Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") =ClaveCuenta
	
	Mail.Configuration.Fields.Update
	'End remote SMTP server configuration section== 
	Mail.To = para
	Mail.Subject = asunto
	Mail.From = remitente
	Mail.ReplyTo = remite
	'adjuntos
	if adjunto<>"" then
		Mail.AddAttachment Server.MapPath(rutaAdjuntos) & "\" & adjunto
	end if 'adjunto<>""
	on error resume next
	Mail.HTMLBody = mensaje    
	Mail.Send  
	if err.number<>0 then
		sendEmailTo=err.description
		'response.write errorcorreo & "<br>"
	end if
	set Mail=nothing
	on error goto 0
	
	if adjunto<>"" then
		set FSO = server.createobject("Scripting.FileSystemObject")
		if (FSO.FileExists(server.MapPath(rutaAdjuntos) & "\" & adjunto)) Then
			FSO.DeleteFile(server.MapPath(rutaAdjuntos) & "\" & adjunto)            
		end if
		set FSO=nothing
	end if 'adjunto
end function

function sendPEMail_old(para,asunto,remite,mensaje,adjunto)
	sendPEMail="" 'por defecto
	Set Mail=Server.CreateObject("Persits.MailSender") 
	Mail.RegKey="22816-93416-57285" 'registro del componente
	Mail.Host=SMTPServer
	Mail.Port=25
	Mail.From=remitente
	Mail.Username=LoginCuenta
	Mail.Password=ClaveCuenta
	Mail.AddAddress para
	Mail.AddReplyTo remite
	Mail.Subject=asunto
	Mail.Body=mensaje
	Mail.IsHTML=true
	Mail.Queue=true
	'adjuntos
	if adjunto<>"" then
		Mail.AddAttachment Server.MapPath(rutaAdjuntos) & "\" & adjunto
	end if 'adjunto<>""
	On Error Resume Next
	Mail.send
	if err<>0 then
		sendPEMail=err.description
	end if
	set Mail=nothing
	on error goto 0
	
	'InsertLog 8989,"Error: " & err.number & " - " & err.description & ", Server: " & SMTPserver & ", Login:" & LoginCuenta & ", Clave:" & ClaveCuenta & ", From:" & remitente & ", Para:" & para & ", Responder a:" & remite & ", Asunto:" & asunto
	
	if adjunto<>"" then 'eliminar adjunto
		set FSO = server.createobject("Scripting.FileSystemObject")
		if (FSO.FileExists(server.MapPath(rutaAdjuntos) & "\" & adjunto)) Then
			FSO.DeleteFile(server.MapPath(rutaAdjuntos) & "\" & adjunto)            
		end if
		set FSO=nothing
	end if 'adjunto
end function 'persist mailsender



function SaltoLinea(mitexto2)
	if isnull(mitexto2)=true then
		SaltoLinea=""
	else
		SaltoLinea=replace(mitexto2,chr(10),"")
		SaltoLinea=replace(saltoLinea,chr(13),"<br>")
	end if
end function

'Pasar cadena a long
function paClng(palnumero)
	paClng=0
	if not isnull(palnumero) then
		if isnumeric(palnumero) then
			paClng=clng(palnumero)
		end if
	end if
end function

'Pasar cadena a Double
function paDbl(palnumero)
	paDbl=0
	if not isnull(palnumero) then
		if isnumeric(palnumero) then
			paDbl=cdbl(palnumero)
		end if
	end if
end function

'Estado del hotel
const noventa=0
const onrequest=1
const online=2

'Clases categoria hotels
const nada=0
const estrella=1
const llave=2

'Variable del nombre de la pagina
MiPag=request.servervariables("SCRIPT_NAME")

session.Timeout=60

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2

function VerFecha(cuala)
	if not isdate(cuala) then
		VerFecha=""
	else
		if day(cuala)<10 then 'lo pongo con dos digitos
			dia="0" & day(cuala)
			dia=right(dia,2) 'Por si acaso
		else
			dia=day(cuala)
		end if
		if month(cuala)<10 then 'lo pongo con dos digitos
			mes="0" & month(cuala)
			mes=right(mes,2) 'Por si acaso
		else
			mes=month(cuala)
		end if
		
		VerFecha=dia & "/" & mes & "/" & right(year(cuala),2)
	end if
end function

'Cambiar apostrofe por acento, para datos en SQL
function QuitarApos(eso)
	QuitarApos=replace(eso,"'","")
end function

Function QuitarComa(numero) 'para usar en instrucciones SQL
	if not isnumeric(numero) then
		QuitarComa="0"
	else
		if clng(numero)>999 then 'puede tener separador de miles
			'en este servidor el separador decimal es "."
			QuitarComar=replace(numero,".","")
		end if
		QuitarComa=replace(numero,",",".")
	end if
end function

 ' Primera letra en maysculas
function ucase1(ca)
  ucase1=ucase(left(ca,1))&lcase(mid(ca,2))
end function

function FechaSQLServer(lafecha)
'	if isdate(lafecha) then
'		dim ldia,lmes,lano
'		lmes=month(lafecha)
'		ldia=day(lafecha)
'		lano=year(lafecha)	
'		FechaSQLServer="CONVERT(DATETIME,'" & lano & "-" & lmes & "-" & ldia & "',102)"
'	else
'		FechaSQLServer="null"
'	end if
	if isdate(lafecha) then
		dim ldia,lmes,lano
		lmes=month(lafecha)
		ldia=day(lafecha)
		lano=year(lafecha)	
		FechaSQLServer="'" & lano & "-" & lmes & "-" & ldia & "'"
	else
		FechaSQLServer="'null'"
	end if
end function

'Poner fecha en formato MySQL 
function FechaMySQL(lafecha)
	if isdate(lafecha) then
		dim ldia,lmes,lano
		lmes=month(lafecha)
		ldia=day(lafecha)
		lano=year(lafecha)	
		FechaMySQL="'" & lano & "-" & lmes & "-" & ldia & "'"
	else
		FechaMySQL="'null'"
	end if
end function

'Funcion añadida Vicente para rendondeo a 2 decimales
Function Redondear(dNumero)
    Dim lMultiplicador,iDecimales
    Dim dRetorno
    'Antes se pasaba el valor de iDecimales para hacerlo por otros decimales
    'If iDecimales > 9 Then iDecimales = 9
	iDecimales=2
    lMultiplicador = 10 ^ iDecimales
    dRetorno = CDbl(CLng(dNumero * lMultiplicador)) / lMultiplicador
    
    Redondear = dRetorno
End Function

'Mas mierda de funcion para textos
function transformaHTML(lacadena)
	palabro=lacadena
	if isnull(palabro) then palabro=""
	palabro=trim(palabro)
	'Temporalmente poner los <br>
	'palabro=replace(palabro,chr(13),"<br/>")
	palabro=server.HTMLEncode(palabro) 'pasar a codigos 
	'Cambiar los codigo de "&lt; y &gt;" a su codigo texto "< >"
	palabro=replace(palabro,"&lt;","<")
	palabro=replace(palabro,"&gt;",">")
	palabro=replace(palabro,"&amp;","&") 'cosas del ampersan
	palabro=replace(palabro,"&quot;","""")
	transformaHTML=palabro
end function 'transformaHTML

'Funcion para sacar el nombre del fichero a una ruta web
Function SoloElFicheroWeb(Todo)
	dim p,ult
	ult=0
	p=instr(1,todo,"/") 'La primera \
	do while p<>0
		ult=p
		p=instr(p+1,todo,"/")
	loop
	if ult<>0 then
		SoloElFicheroWeb=mid(todo,ult+1)
	else
		SoloElFicheroWeb=Todo
	end if
End Function

'Funcion para sacar el nombre del fichero a una ruta entera
Function SoloElFichero(Todo)
	dim p,ult
	ult=0
	p=instr(1,todo,"\") 'La primera \
	do while p<>0
		ult=p
		p=instr(p+1,todo,"\")
	loop
	if ult<>0 then
		SoloElFichero=mid(todo,ult+1)
	else
		SoloElFichero=Todo
	end if
End Function

'funcion para usar fotos thumbnails en vez de la original
function renombraFoto(laFoto,elPrefijo)
	miFoto=soloElFicheroWeb(laFoto) 'quita la ruta web del fichero
	laRuta=replace(laFoto,miFoto,"")
	'Por ahora
	laRuta=replace(laRuta,"http://admin.kubikcrs.com","")
	'poner prefijo si no lo tiene
	if instr(lcase(miFoto),lcase(elPrefijo))<>0 then 'ya tiene prefijo
		renombraFoto=laRuta & miFoto
	else 'poner prefijo
		renombraFoto=laRuta & elPrefijo & miFoto
	end if
end function

%>