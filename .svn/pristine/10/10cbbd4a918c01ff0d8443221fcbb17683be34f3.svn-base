<%
rutaXML="/reservas/CRS/IdiomaXML/"

class clsIdioma
	private idiomaXML
	private xmlFichero
	
	Private Sub Class_Initialize()

		if InStr(1,rutaXML,"C:\ASP\",1)<>0 then
			xmlFichero=rutaXML & "idioma_"+lang+".xml"
		else
			xmlFichero=Server.MapPath(rutaXML & "idioma_"+lang+".xml")
		end if
		
		Set idiomaXML = Server.CreateObject("Microsoft.XMLDOM")
		idiomaXML.async=false
		'response.Write(xmlFichero)
		if not idiomaXML.Load(xmlFichero) then 'no existe, lo creamos
			'Crear XML
			'Set objRaiz = idiomaXML.createElement("datos")
			'idiomaXML.appendChild objRaiz
			'Cabecera
			'Set objCabecera = idiomaXML.createProcessingInstruction("xml","version='1.0' encoding='ISO-8859-1'")
			'agregamos la cabecera antes del elemento raiz
			'idiomaXML.insertBefore objCabecera, idiomaXML.childNodes(0)
			
			'idiomaXML.save xmlFichero
			'set objRaiz=nothing
			'set objCabecera=nothing
		end if
	  
    End Sub 'Class_Initialize
	'-----------------------------------------------------------------------------------------------------------
	   
    Private Sub Class_Terminate()
      Set idiomaXML = Nothing
    End Sub 'Class_Terminate
	'-----------------------------------------------------------------------------------------------------------
	
	'Funcion para buscar la traduccion
	public Function getTraduccion(eti)
		set resul=idiomaXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		getTraduccion=resul.selectSingleNode("traduccion").text 'traduccion
		if err.number<>0 then 'no encontrada
			getTraduccion=""
		end if 'errir
		set resul=nothing
		on error goto 0
	end function 'getTraduccion
	
	'Funcion para buscar la traduccion y devuelve en html encode
	public Function getTraduccionHTML(eti)
		resul=getTraduccion(eti)
		getTraduccionHTML=transformaHTML(resul) 'traduccion
	end function 'getTraduccionHTML
	
	'------------------------------------------------------------------------------------------------------------------------
	'Mas mierda de funcion para textos
	private function transformaHTML(lacadena)
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

	'---------------------------------------------------------------------------------------------------------------------------
	'Funcion para buscar el detalle
	public Function getDetalle(eti)
		set resul=idiomaXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
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
		
		set resul=idiomaXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
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
		set resul=idiomaXML.selectSingleNode("/datos/traducciones[etiqueta='" & eti & "']")
		on error resume next
		eso=resul.selectSingleNode("etiqueta").text 'etiqueta
		if err.number=0 then 'encontrada
			on error goto 0
			idiomaXML.childnodes(1).removeChild(resul)
			idiomaXML.save xmlFichero
			set resul=nothing
		end if 'error
		on error goto 0
	end Sub 'borraTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	'funcion de lista de registros
	public function listaTraduccion()
		dim listaI()
		nlista=-1
		For Each objItem in idiomaXML.documentElement.SelectNodes("/datos/traducciones")
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
		set resul=idiomaXML.selectSingleNode("/datos/traducciones[etiqueta='" & etiqueta & "']")
		on error resume next
		eso=resul.selectSingleNode("traduccion").text 'traduccion
		if err.number<>0 then 'no está, añadimos
			on error goto 0
			Set objNuevo = idiomaXML.createElement("traducciones")
			idiomaXML.childNodes(1).appendChild objNuevo
			set objOtro=idiomaXML.createElement("etiqueta")
			objNuevo.appendChild objOtro
			set objOtro=idiomaXML.createElement("traduccion")
			objNuevo.appendChild objOtro
			set objOtro=idiomaXML.createElement("detalle")
			objNuevo.appendChild objOtro
		  
			objNuevo.SelectSingleNode("etiqueta").text = etiqueta
			objNuevo.SelectSingleNode("traduccion").text = traduccion
			objNuevo.SelectSingleNode("detalle").text = detalle
			'Inserto como primer registro
			idiomaXML.childNodes(1).insertBefore objNuevo, idiomaXML.childNodes(1).childNodes(0)
			idiomaXML.save xmlFichero
			
			set objOtro=nothing
			set objNuevo=nothing
		else 'ya está
			
			resul.SelectSingleNode("etiqueta").text = etiqueta
			resul.SelectSingleNode("traduccion").text = traduccion
			resul.SelectSingleNode("detalle").text = detalle
			
			idiomaXML.save xmlFichero
			set resul=nothing
			
		end if 'error
		on error goto 0
		
	end sub 'actuTraduccion
	
	'---------------------------------------------------------------------------------------------------------------------------
	public Function nRegistros()' contador de elementos dentro del nodo base de cada idioma
		set nodoBase = idiomaXML.DocumentElement.selectSingleNode("traducciones")
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
		For Each objItem in idiomaXML.documentElement.SelectNodes("/datos/traducciones")
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