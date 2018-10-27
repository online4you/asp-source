<%
class clsAcceso
	private acesoXML
	private xmlFichero
	
	Private Sub Class_Initialize()
		xmlFichero=Server.MapPath(rutaXML & "Acceso_" & IdUsu & ".xml")
		Set accesoXML = Server.CreateObject("Microsoft.XMLDOM")
		accesoXML.async=false
		if not accesoXML.Load(xmlFichero) then 'no existe, lo creamos
			'Crear XML
			Set objRaiz = accesoXML.createElement("datos")
			accesoXML.appendChild objRaiz
			'Cabecera
			Set objCabecera = accesoXML.createProcessingInstruction("xml","version='1.0' encoding='ISO-8859-1'")
			'agregamos la cabecera antes del elemento raiz
			accesoXML.insertBefore objCabecera, accesoXML.childNodes(0)
			
			accesoXML.save xmlFichero
			set objRaiz=nothing
			set objCabecera=nothing
		end if
	  
    End Sub 'Class_Initialize
	'-----------------------------------------------------------------------------------------------------------
	   
    Private Sub Class_Terminate()
      Set accesoXML = Nothing
    End Sub 'Class_Terminate
	'-----------------------------------------------------------------------------------------------------------
	
	'Funcion para buscar la traduccion
	public Function getTraduccion(eti)
		set resul=accesoXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		getTraduccion=resul.selectSingleNode("traduccion").text 'traduccion
		if err.number<>0 then 'no encontrada
			getTraduccion=""
		end if 'errir
		set resul=nothing
		on error goto 0
	end function 'getTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	'Funcion para buscar el detalle
	public Function getDetalle(eti)
		set resul=accesoXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		getDetalle=resul.selectSingleNode("detalle").text 'detalle
		if err.number<>0 then 'no encontrada
			getDetalle=""
		end if 'error
		set resul=nothing
		on error goto 0
	end function 'getDetalle
	
	'---------------------------------------------------------------------------------------------------------------------------
	'funcion para actualizar datos de traduccion
	public Sub setTraduccion(eti,traduccion,detalle)
		
		set resul=accesoXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		getTraduccion=resul.selectSingleNode("traduccion").text 'traduccion
		if err.number<>0 then 'no encontrada
			getTraduccion=""
		end if 'errir
		set resul=nothing
		on error goto 0
	end Sub 'setTraduccion

	'---------------------------------------------------------------------------------------------------------------------------
	'Funcion para eliminar traduccion
	public Sub borraTraduccion(eti)
		set resul=accesoXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		eso=resul.selectSingleNode("etiqueta").text 'etiqueta
		if err.number=0 then 'encontrada
			on error goto 0
			accesoXML.childnodes(1).removeChild(resul)
			accesoXML.save xmlFichero
			set resul=nothing
		end if 'error
		on error goto 0
	end Sub 'borraTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	'funcion de lista de registros
	public function listaTraduccion()
		dim listaI()
		nlista=-1
		For Each objItem in accesoXML.documentElement.SelectNodes("/datos/traducciones")
			nlista=nlista+1
			redim preserve listaI(2,nlista)
			listaI(0,nlista)=objItem.SelectSingleNode("etiqueta").text
			listaI(1,nlista)=objItem.SelectSingleNode("traduccion").text
			listaI(2,nlista)=objItem.SelectSingleNode("detalle").text
		next 'lista registros
		listaTraduccion=listaI
	end function 'listaTraduccion

	'---------------------------------------------------------------------------------------------------------------------------
	public Sub actuTraduccion(etiqueta,traduccion,detalle)
		set resul=accesoXML.selectSingleNode("/datos/traducciones[etiqueta='" & etiqueta & "']")
		on error resume next
		eso=resul.selectSingleNode("traduccion").text 'traduccion
		if err.number<>0 then 'no está, añadimos
			on error goto 0
			Set objNuevo = accesoXML.createElement("traducciones")
			accesoXML.childNodes(1).appendChild objNuevo
			set objOtro=accesoXML.createElement("etiqueta")
			objNuevo.appendChild objOtro
			set objOtro=accesoXML.createElement("traduccion")
			objNuevo.appendChild objOtro
			set objOtro=accesoXML.createElement("detalle")
			objNuevo.appendChild objOtro
		  
			objNuevo.SelectSingleNode("etiqueta").text = etiqueta
			objNuevo.SelectSingleNode("traduccion").text = traduccion
			objNuevo.SelectSingleNode("detalle").text = detalle
			'Inserto como primer registro
			accesoXML.childNodes(1).insertBefore objNuevo, accesoXML.childNodes(1).childNodes(0)
			accesoXML.save xmlFichero
			
			set objOtro=nothing
			set objNuevo=nothing
		else 'ya está
			
			resul.SelectSingleNode("etiqueta").text = etiqueta
			resul.SelectSingleNode("traduccion").text = traduccion
			resul.SelectSingleNode("detalle").text = detalle
			
			accesoXML.save xmlFichero
			set resul=nothing
			
		end if 'error
		on error goto 0
		
	end sub 'actuTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	public Function nRegistros()' contador de elementos dentro del nodo base de cada idioma
		set nodoBase = accesoXML.DocumentElement.selectSingleNode("traducciones")
		on error resume next
	  	nRegistros= nodoBase.ChildNodes.length 
		if err.number<>0 then 'no hay nada
			nRegistros=0
		end if 'error
		set nodoBase=nothing
		on error goto 0
	End Function 'nRegistros
	
	'---------------------------------------------------------------------------------------------------------------------------
	'funcion para buscador de traduccion
	public function buscaTraduccion(esoBusco)
		dim listaI()
		nlista=-1
		For Each objItem in accesoXML.documentElement.SelectNodes("/datos/traducciones")
			if instr(lcase("" & objItem.SelectSingleNode("traduccion").text),lcase(esoBusco))<>0 then 'esta es guena
				nlista=nlista+1
				redim preserve listaI(2,nlista)
				listaI(0,nlista)=objItem.SelectSingleNode("etiqueta").text
				listaI(1,nlista)=objItem.SelectSingleNode("traduccion").text
				listaI(2,nlista)=objItem.SelectSingleNode("detalle").text
			end if
		next 'lista registros
		buscaTraduccion=listaI
	end function 'buscaTraduccion
	'---------------------------------------------------------------------------------------------------------------------------
	
end class 'clsIdioma



%>