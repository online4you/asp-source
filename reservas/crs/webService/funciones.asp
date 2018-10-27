<%
'Cambiar apostrofe por acento, para datos en SQL
function QuitarApos(eso)
	QuitarApos=replace(eso,"'","´")
end function

'Cambiar apostrofe por acento, para datos en SQL
function QuitarComa(eso)
	QuitarComa=replace(eso,",",".")
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
				tempo=tempo & "[aáà]"
				vocal=true
			case "e"
				tempo=tempo & "[eéè]"
				vocal=true
			case "i"
				tempo=tempo & "[iíì]"
				vocal=true
			case "o"
				tempo=tempo & "[oóò]"
				vocal=true
			case "u"
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

function FechaCompleta(cuala)
	if not isdate(cuala) then
		FechaCompleta=""
	else
		dia=right("0" & day(cuala),2)
		mes=right("0" & month(cuala),2)
		FechaCompleta=dia & "/" & mes & "/" & year(cuala)
	end if
end function

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

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2

'Estado del hotel
const noventa=0
const onrequest=1
const online=2

FUNCTION SortArray(varArray,ordenElemento)
	cuantos=ubound(varArray,2)
	For i=cuantos To 0 Step -1
		MaxVal = varArray(ordenElemento,i) 'valor que se ordena
		MaxIndex = i
		For j = 0 To i
			If varArray(ordenElemento,j)>MaxVal Then '
				MaxVal = varArray(ordenElemento,j)
				MaxIndex = j
			End If
		Next

		If MaxIndex < i Then 'intercambio de posicion
			for t=0 to ubound(varArray,1)
				cambio=varArray(t,i)
				varArray(t,i)=varArray(t,MaxIndex)
				varArray(t,MaxIndex)=cambio
			next
		End If
	Next
END FUNCTION

function SortArrayDesc(varArray,ordenElemento)
	cuantos=ubound(varArray,2)
	'response.Write("valorOrden=" & valorOrden & "<br>")
	'response.Write("ordenElemento=" & ordenElemento & "<br>")
	'response.Write("ubound(varArray,2)=" &ubound(varArray,2)& "<br>")
	valorOrden=lcase(valorOrden)
	For i=0 To cuantos
		MaxVal = varArray(ordenElemento,i) 'valor que se ordena
		'response.Write("MaxVal=" & MaxVal & "<br>")

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
%>