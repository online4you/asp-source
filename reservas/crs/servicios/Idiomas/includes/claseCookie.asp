<%
rutaCookieXML=relative_url & "IdiomaXML/"
'Pasar cadena a long
function paClng(palnumero)
	paClng=0
	if not isnull(palnumero) then
		if isnumeric(palnumero) then
			paClng=clng(palnumero)
		end if
	end if
end function

class clsCookie
	private cookieXML
	private xmlFichero
	
	Private Sub Class_Initialize()
		IdTra=paClng(request.Cookies("IDCR")) 'id del usuario
		'response.write rutaCookieXML & "cookies_" & IdTra & ".xml"
		xmlFichero=Server.MapPath(rutaCookieXML & "cookies_" & IdTra & ".xml")
		Set cookieXML = Server.CreateObject("Microsoft.XMLDOM")
		cookieXML.async=false
		if not cookieXML.Load(xmlFichero) then 'no existe, lo creamos
			'Crear XML
			Set objRaiz = cookieXML.createElement("datos")
			cookieXML.appendChild objRaiz
			'Cabecera
			Set objCabecera = cookieXML.createProcessingInstruction("xml","version='1.0' encoding='ISO-8859-1'")
			'agregamos la cabecera antes del elemento raiz
			cookieXML.insertBefore objCabecera, cookieXML.childNodes(0)
			
			cookieXML.save xmlFichero
			set objRaiz=nothing
			set objCabecera=nothing
		end if
	  
    End Sub 'Class_Initialize
	'-----------------------------------------------------------------------------------------------------------
	   
    Private Sub Class_Terminate()
      Set cookieXML = Nothing
    End Sub 'Class_Terminate
	'-----------------------------------------------------------------------------------------------------------
	
	'Funcion para buscar la cookie
	public Function getCookie(eti)
		set resul=cookieXML.selectSingleNode("/datos/cookies[etiqueta='" & eti & "']")
		on error resume next
		getCookie=resul.selectSingleNode("valor").text 'valor cookie
		if err.number<>0 then 'no encontrada
			getCookie=""
		end if 'errir
		set resul=nothing
		on error goto 0
	end function 'getCookie
	
	'---------------------------------------------------------------------------------------------

	'Funcion para eliminar traduccion
	public Sub borraCookie(eti)
		set resul=cookieXML.selectSingleNode("/datos/cookies[etiqueta='" & eti & "']")
		on error resume next
		eso=resul.selectSingleNode("etiqueta").text 'etiqueta
		if err.number=0 then 'encontrada
			on error goto 0
			cookieXML.childnodes(1).removeChild(resul)
			cookieXML.save xmlFichero
			set resul=nothing
		end if 'error
		on error goto 0
	end Sub 'borraTraduccion
	
'---------------------------------------------------------------------------------------------------------------------------

	'funcion de lista de registros
	public function listaCookie()
		dim listaI()
		nlista=-1
		For Each objItem in cookieXML.documentElement.SelectNodes("/datos/cookies")
			nlista=nlista+1
			redim preserve listaI(1,nlista)
			listaI(0,nlista)=objItem.SelectSingleNode("etiqueta").text
			listaI(1,nlista)=objItem.SelectSingleNode("valor").text
		next 'lista registros
		listaCookie=listaI
	end function 'listaTraduccion

	'---------------------------------------------------------------------------------------------------------------------------
	public Sub setCookie(etiqueta,valor)
		set resul=cookieXML.selectSingleNode("/datos/cookies[etiqueta='" & etiqueta & "']")
		on error resume next
		eso=resul.selectSingleNode("valor").text 'traduccion
		if err.number<>0 then 'no está, añadimos
			on error goto 0
			Set objNuevo = cookieXML.createElement("cookies")
			cookieXML.childNodes(1).appendChild objNuevo
			set objOtro=cookieXML.createElement("etiqueta")
			objNuevo.appendChild objOtro
			set objOtro=cookieXML.createElement("valor")
			objNuevo.appendChild objOtro
			'response.write "Valor:" & valor
			if isnull(valor) then valor=""
			objNuevo.SelectSingleNode("etiqueta").text = etiqueta
			objNuevo.SelectSingleNode("valor").text = valor

			'Inserto como primer registro
			cookieXML.childNodes(1).insertBefore objNuevo, cookieXML.childNodes(1).childNodes(0)
			cookieXML.save xmlFichero
			
			set objOtro=nothing
			set objNuevo=nothing
		else 'ya está
			on error goto 0
			resul.SelectSingleNode("etiqueta").text = etiqueta
			resul.SelectSingleNode("valor").text = valor
			
			cookieXML.save xmlFichero
			set resul=nothing
			
		end if 'error
		
		
	end sub 'actuTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	public Function nRegistros()' contador de elementos
		set nodoBase = cookieXML.DocumentElement.selectSingleNode("cookies")
		on error resume next
	  	nRegistros= nodoBase.ChildNodes.length 
		if err.number<>0 then 'no hay nada
			nRegistros=0
		end if 'error
		set nodoBase=nothing
		on error goto 0
	End Function 'nRegistros
	
	'---------------------------------------------------------------------------------------------------------------------------
	
end class 'clsCookie

%>