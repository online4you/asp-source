<%
If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"MSIE") then
	ie=true
Else
	ie=false	
End If

function elIcono(mifichero)
	'Buscar extension
	if trim(mifichero)<>"" then
		if UBound(Split(mifichero, ".", -1, 1))=0 then Ext=""
		if UBound(Split(mifichero, ".", -1, 1))>0 then Ext=Split(miFichero, ".", -1, 1)(1)
		select case ucase(Ext)
			case "DOC":elIcono="icono/iconoTexto.gif"
			case "JPG","GIF","BMP","TIFF","PNG":elIcono="icono/iconoJPG.gif"
			case "XLS":elIcono="icono/iconoXLS.gif"
			case "PDF":elIcono="icono/iconoPDF.gif"
			case "ZIP","RAR","ACE":elIcono="icono/iconoZip.gif"
			case else
				elIcono="icono/iconoCarpeta.gif"
		end select
	else
		elIcono="icono/iconoCarpeta.gif"
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

'constantes de las fotos

'Rutas en el servidor
const rutaFotos="/serprosport/Fotos/"
const rutaDocus="/serprosport/Ficheros/"


'Variable del nombre de la pagina
MiPag=request.servervariables("SCRIPT_NAME")

'Flechas
FlechaLeft="<img src='img/flechaIzq.gif' width='9' height='8' border='0'/>"
FlechaRight="<img src='img/flechaDer.gif' width='9' height='8' border='0'/>"
FlechaUp="<font FACE=WingDings size='2'>" & chr(241) & "</font>"
FlechaDown="<font FACE=WingDings size='2'>" & chr(242) & "</font>"

session.Timeout=40

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2

ConectaMDB= "provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=D:\XVRT\planetaweb.es\data\serprosport.mdb"

'Cambiar apostrofe por acento, para datos en SQL
function QuitarApos(eso)
	if not isnull(eso) then
		QuitarApos=replace(eso,"'","´")
	else
		QuitarApos=""
	end if
end function

function PonerApos(texto)
	if not isnull(texto) then
		PonerApos=replace(texto,"´","'")
	else
		PonerApos=""
	end if
end function

'Poner fecha en formato SQL pal Access
function FechaSQL(lafecha)
	if isdate(lafecha) then
		dim ldia,lmes,lano
		lmes=month(lafecha)
		ldia=day(lafecha)
		lano=year(lafecha)	
		FechaSQL="#" & lmes & "/" & ldia & "/" & lano & "#"
	else
		FechaSQL="null"
	end if
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
			case "a","á","à"
				tempo=tempo & "[aáà]"
				vocal=true
			case "e","é","è"
				tempo=tempo & "[eéè]"
				vocal=true
			case "i","í","ì"
				tempo=tempo & "[iíì]"
				vocal=true
			case "o","ó","ò"
				tempo=tempo & "[oóò]"
				vocal=true
			case "u","ú","ù"
				tempo=tempo & "[uúù]"
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

Function QuitarComa(numero)
	Response.Write("Quitar coma de: " & numero)

	if not isnumeric(numero) then
		QuitarComa="0"
	else
		'numero=cdbl(numero)
		if numero>999 then 'quitar separador de miles
			numero=replace(numero, ".", "")
		end if
		QuitarComa=replace(numero, ",", ".")
	end if
end function

 ' Primera letra en mayúsculas
function ucase1(ca)
  ucase1=ucase(left(ca,1))&mid(ca,2)
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

%>
