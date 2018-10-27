<!--#include file="constantes.asp"-->
<!--#include file="validoUser.asp"-->
<!--#include file="datosAcceso.asp"-->

<%
fg_ip= request.ServerVariables("REMOTE_ADDR") 'IP client
fg_ownerPWP="95.39.27.2" 'IP Planeta Palma
fg_ownerPWB="78.83.92.75" 'IP Planeta Bulgaria

sub responsedebug (CommentText)
	if (debugcode=1) then response.write CommentText + "<br>"
end sub 

'para visualizar textos solo desde nuestra IP (response.write cs)
sub responseLog(CommentText)
	if (fg_ip=fg_ownerPWP or fg_ip=fg_ownerPWB or adminBoss) then
		response.write CommentText
	end if
end sub

esPlaneta=false
if (fg_ip=fg_ownerPWP or fg_ip=fg_ownerPWB or adminBoss) then esPlaneta=true

'function registrosZona()
'	registrosZona=null
'	dim nzona
'	dim RegZonas()
'	nzonas=-1
'	
'	sub estructuraZonas(IdPadre,nivel)
'		set rsZ=server.createobject("ADODB.Recordset")
'		rsZ.CursorLocation = adUseServer
'		rsZ.CursorType=adOpenForwardOnly
'		rsZ.LockType=adLockReadOnly
'		
'		cs="SELECT Id,Zona,IdPadre "
'		cs=cs & "FROM Zonas "
'		cs=cs & "WHERE IdPadre=" & idpadre	
'		cs=cs & " ORDER BY Zona"
'		'response.write cs
'		rsZ.open cs,base
'		do while not rsZ.eof
'			nzona=nzona+1
'			redim preserve RegZonas(3,nzona)
'			RegZonas(0,nzona)=rsZ("Id")
'			RegZonas(1,nzona)=rsZ("Zona")
'			RegZonas(2,nzona)=rsZ("IdPadre")
'			RegZonas(3,nzona)=nivel
'			estructuraZonas rsZ("Id"),nivel+1
'			
'			rsZ.movenext
'		loop
'		rsZ.close
'		set rsZ=nothing
'	end Sub
'	estructuraZonas 0,0 'todas
'	if nzona>-1 then registrosZona=RegZonas
'end function 'registrosZonas

class clsListadoZonas
	private nzona
	private RegZonas()
	
	Private Sub Class_Initialize()
		nzona=-1
	end sub 'initialize
	
	private sub estructuraZonas(IdPadre,nivel,idioma)
		set rsZ=server.createobject("ADODB.Recordset")
		rsZ.CursorLocation = adUseServer
		rsZ.CursorType=adOpenForwardOnly
		rsZ.LockType=adLockReadOnly
		
		'cs="SELECT Id,is_null(fnGetTraduccion('Zonas','Zona',Id,'" & idioma & "'),Zona) AS Tradu,IdPadre "
		'cs=cs & "FROM Zonas "
		'cs=cs & "WHERE IdPadre=" & idpadre	
		'cs=cs & " ORDER BY Zona"
		
		
		cs="SELECT Zonas.Id, IF(ISNULL(traduc.Traduccion),Zonas.Zona,traduc.Traduccion) AS Tradu, Zonas.IdPadre "
		cs=cs & "FROM " & precrs & "Zonas Zonas LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Zonas"" And Campo = ""Zona"" And Idioma = """ & idioma & """)  AS traduc ON Zonas.Id = traduc.IdReferencia "
		cs=cs & "WHERE IdPadre=" & idpadre	
		cs=cs & " ORDER BY Zonas.Zona "

		'response.write cs
		rsZ.open cs,base
		do while not rsZ.eof
			nzona=nzona+1
			redim preserve RegZonas(3,nzona)
			RegZonas(0,nzona)=rsZ("Id")
			RegZonas(1,nzona)=rsZ("Tradu")
			RegZonas(2,nzona)=rsZ("IdPadre")
			RegZonas(3,nzona)=nivel
			estructuraZonas rsZ("Id"),nivel+1,idioma
			
			rsZ.movenext
		loop
		rsZ.close
		set rsZ=nothing
	end Sub
	
	public function cargaListaZonas(idpadre,nivel,idioma)
		estructuraZonas IdPadre,nivel,idioma
		if nzona>-1 then
			cargaListaZonas=RegZonas
		else
			cargaListaZonas=null
		end if
	end function 'cargaListaZonas
	
end class

function laColu(esa) 'funcion para hacer cada columna con diferente estilo
	if esa=0 then
		laColu=estilo
	else
		laColu=estilo & esa
	end if
end function

'Para saber si ese fichero está en el servidor
function existeFichero(ese) 
	existeFichero=false
	mifiche=ese
	if instr(mifiche,"/")<>0 then 'es ruta web
		mifiche=server.MapPath(mifiche)
	end if 'rutaweb
	set FileSys = Server.CreateObject("Scripting.FileSystemObject") 
	existeFichero=FileSys.FileExists(mifiche)	
	set FileSys=nothing
end function

'const SMTP_Server="mail.prinsotel.es"  
'const Login_Cuenta="formulario@prinsotel.es"  
'const Clave_Cuenta="planetaweb" 
'const remite_Cuenta="formulario@prinsotel.es"

'Los coge de los datos del cliente

function sendEmailTo(para,asunto,remite,mensaje)
	Set Mail = Server.CreateObject("Persits.MailSender")
 	Mail.RegKey="22816-93416-57285" 'registro del componente
	Mail.Host = SMTP_Server
	Mail.From = remite_Cuenta
    Mail.AddReplyTo remite
	Mail.Username = Login_Cuenta
	Mail.Password = Clave_Cuenta
	Mail.AddAddress para
	Mail.Subject = asunto
	'response.write "smtp:" & smtp_server & ", remite:" & remite_cuenta & ", user:" & login_cuenta & ", pwd:" & clave_cuenta & ", para:" & para & ", replyto:" & remite & "<br/>"
	Mail.Body = mensaje 
	Mail.IsHTML = true
  	On Error Resume Next
	Mail.send
	If err.number<>0 then
		sendEmailTo=err.description
	End if
	on error goto 0
	set mail=nothing
end function


'paver si el array est vacio osea cagada
function isArrayVacio(elarray)
	isArrayVacio=true
	on error resume next
	x=ubound(elarray)
	if err.number=0 then 'no hay error, tiene elementos
		isArrayVacio=false
	end if
	on error goto 0
end function

function busca_en_array(elArray,loBusco) 'devuelve true si est
	busca_en_array=false
	if not isArrayVacio(elArray) then
		for r=0 to ubound(elArray)
			if paClng(elArray(r))=loBusco then 'encontrado
				busca_en_array=true
				exit for
			end if
		next 'r
	end if
end function 'busca_en_array

esAdmin=false
if hotelboss="0" then esAdmin=true 'Solo modifica el administrador

if not esAdmin then 'Usuario con hotel
	buscoHoteles="WHERE "
	buenos=split(hotelboss,";")
	for b=0 to ubound(buenos)
		if isnumeric(buenos(b)) then
			buscoHoteles=buscoHoteles & "Establecimientos.CodigoEsta=" & buenos(b) & " OR "
		end if
	next
	buscoHoteles=left(buscoHoteles,len(buscoHoteles)-4)
else
	buscoHoteles="" 'es administrado saca todos los hoteles
end if



'Admin general
'adminBoss=false
'if request.Cookies("adminBoss")="1" then adminBoss=true

'Saber nombre nivel
function nombreNivel(elnivel)
	select case elnivel
		case TAdmin
			response.write "Administrador"
		case TRecepcion
			response.write "Recepci&oacute;n"
		case TComercial
			response.write "Comercial"
		case TRelacion
			response.write "Rel. P&uacute;blicas"
		case TAgencia
			response.write "Agencia"
	end select
end function



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
			palnumero = replace(palnumero, ".", ",")
			paDbl=cdbl(palnumero)
		end if
	end if
end function

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


function laExtension(mifichero)
	laExtension=""
	'Buscar extension
	if trim(mifichero)<>"" then
		ficheExt=Split(mifichero,".")
		if ubound(ficheExt)>=0 then laExtension=ficheExt(ubound(ficheExt))
	end if
end function

function esGrafico(elFiche) 'true en caso de ser un fichero grafico
	esGrafico=false
	select case lcase(laExtension(elFiche))
		case "gif","png","jpg","jpeg","bmp"
			esGrafico=true
	end select
end function

Function transformaURL(laURL)
	laURL=lcase(laURL) 'paso a minusculas
	Dim regEx
	Set regEx=New RegExp ' Crea una expresión regular. 
	regEx.Global=true   
	regEx.Pattern="[áâàä]" 'Establece el modelo.    
	resultado=regEx.Replace(laURL,"a") 'Realiza el reemplazo
	regEx.Pattern="[éêèë]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"e") 'Realiza el reemplazo
	regEx.Pattern="[íïìî]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"i") 'Realiza el reemplazo
	regEx.Pattern="[óöòô]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"o") 'Realiza el reemplazo
	regEx.Pattern="[úüùû]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"u") 'Realiza el reemplazo
	regEx.Pattern="[ñ]"
	resultado=regEx.Replace(resultado,"n") 'Realiza el reemplazo
	regEx.Pattern="[ç]"
	resultado=regEx.Replace(resultado,"c") 'Realiza el reemplazo
	regEx.Pattern="[ß]"
	resultado=regEx.Replace(resultado,"b") 'Realiza el reemplazo
	regEx.Pattern="[\s|""|'|´|&|?|¿|@|*|%|$|+|!|¡|º|ª|\|(|)]"
	resultado=regEx.Replace(resultado,"_") 'Realiza el reemplazo
	set regEx = nothing
	transformaURL=resultado
End Function


session.Timeout=60


'if mysqlBD then 'es mysql
	'Driver={MySQL ODBC 5.1 Driver};Server=myServerAddress;Port=3306;Option=131072;Stmt=; Database=myDataBase;Uid=myUsername;Pwd=myPassword;
	Conecta="Driver={MySQL ODBC 5.1 Driver};Server=" & conexBD & ";Database=" & nombreBD & ";Uid=" & userBD & ";Pwd=" & pwdBD 
'else 'sql Server
	'Conecta = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=" & userBD & ";pwd=" & pwdBD & ";Initial Catalog=" & nombreBD & ";Data Source=" & conexBD
'end if 'mysql

'Conecta = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\gpuigros\Desktop\Joomla\Aplicaciones\CRS\HotelHoteles.accdb;Persist Security Info=False;"


'Cambiar apostrofe por acento, para datos en SQL
function QuitarApos(eso)
	QuitarApos=replace(eso,"'","&#39;")
end function

'Buscar en sql palabras con acentos
function ControlAcentos(palabrat)
	Dim x,tempo,letra,vocal,lacadena
	lacadena=palabrat
	tempo=""
	letra=""
	vocal=false
	For x= 1 to Len(lacadena)
		letra = Mid(lacadena,x,1)
		vocal=false					
		Select case LCase(letra)
			case "a"
				tempo=tempo & "[a]"
				vocal=true
			case "e"
				tempo=tempo & "[e]"
				vocal=true
			case "i"
				tempo=tempo & "[i]"
				vocal=true
			case "o"
				tempo=tempo & "[o]"
				vocal=true
			case "u"
				tempo=tempo & "[u]"
				vocal=true
		End Select
		if not vocal then
			tempo=tempo & letra
		end if				
	next
	ControlAcentos=tempo
	'response.write tempo & "<br>"
end function

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

function VerFechaHora(cuala)
	if not isdate(cuala) then
		VerFecha=""
	else
		dia=right("0"&day(cuala),2) 'Por si acaso
		mes=right("0"&month(cuala),2) 'Por si acaso
		VerFechaHora=dia & "/" & mes & "/" & right(year(cuala),2) & " - " & right("0"&hour(cuala),2) & ":" & right("0"&minute(cuala),2)
	end if
end function

Function QuitarComa(numero)
	if not isnumeric(numero) then
		QuitarComa="0"
	else
		'numero=cdbl(numero)
		QuitarComa=replace(numero, ",", ".")
	end if
end function

Function QuitarComaMiles(numero)
	if not isnumeric(numero) then
		QuitarComaMiles="0"
	else
		'numero=cdbl(numero)
		QuitarComaMiles=replace(numero,",",".")
	end if
	'Comprobar que quitarComa no haya devuelto dos puntos (separador de miles y decimal)
	lospuntos=0
	for nn=1 to len(QuitarComaMiles)
		if mid(QuitarComaMiles,nn,1)="." then lospuntos=lospuntos+1
	next
	if lospuntos=2 then 'hay un separador de miles
		QuitarComaMiles=replace(QuitarComaMiles,".","",1,1) 'solo reemplaza un punto
	end if

end function

 ' Primera letra en maysculas
function ucase1(ca)
  ucase1=ucase(left(ca,1))&lcase(mid(ca,2))
end function

function FechaSQLServer(lafecha)
	if isdate(lafecha) then
		dim ldia,lmes,lano
		lmes=month(lafecha)
		ldia=day(lafecha)
		lano=year(lafecha)	
		FechaSQLServer="CONVERT(DATETIME,'" & lano & "-" & lmes & "-" & ldia & "',102)"
	else
		FechaSQLServer="null"
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

'Funcion aadida Vicente para rendondeo a 2 decimales
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

Private Function HTMLDecode(byVal encodedstring)
	Dim tmp, i
	tmp = encodedstring
	tmp = Replace( tmp, "&quot;", chr(34) )
	tmp = Replace( tmp, "&lt;"  , chr(60) )
	tmp = Replace( tmp, "&gt;"  , chr(62) )
	tmp = Replace( tmp, "&amp;" , chr(38) )
	tmp = Replace( tmp, "&nbsp;", chr(32) )
	tmp = Replace( tmp, "&#971;", "" )
	tmp = Replace( tmp, "&#946;", "" )
	For i = 1 to 255
		tmp = Replace( tmp, "&#" & i & ";", chr( i ) )
	Next
	HTMLDecode = tmp
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

if adminBoss then
	'Tabla empresas
	set base=server.createobject("ADODB.Connection")
	'response.Write(ConectaMDB)
	base.Open ConectaMDB
	set rs=server.createobject("ADODB.Recordset")
	rs.CursorLocation = adUseServer
	rs.CursorType=adOpenForwardOnly
	rs.LockType=adLockReadOnly
	
	cs="SELECT Id,Nombre FROM " & precrsgen & "empresas ORDER BY Nombre"
	rs.open cs,base
	hayempre=false
	if not rs.eof then
		RegEmpre=rs.getrows
		EmCodi=0
		EmNombre=1
		hayempre=true
	end if
	rs.close
	
	set rs=nothing
	base.close
	set base=nothing
end if 'adminBoss

%>
<!--#include file="controlRegistro.asp"-->
<!--#include file="tablaAccesos.asp"-->

