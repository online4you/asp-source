<%
Function xmlRuta(idioma)'funcion que nos devuelve la ruta con el archivo idioma
  	 xmlRuta = Server.MapPath("../IdiomaXML/idioma_"+idioma+".xml")
End function 
'---------------------------------------------------------------------------------------------------------------------------
Function objetoXMLCargar(idioma)'Creamos el objetoCarga XML  
     Set objetoXMLCargar = Server.CreateObject("Microsoft.XMLDOM")
	 objetoXMLCargar.async = False
     objetoXMLCargar.Load(xmlRuta(idioma)) 
End function 
'---------------------------------------------------------------------------------------------------------------------------
Function nodoBase(idioma)' el nodo base  es el que nos va a servir para recorrer sus hijos dentro del mismo
    set nodoBase = objetoXMLCargar(idioma).DocumentElement.selectSingleNode("contents") 
End Function 
'---------------------------------------------------------------------------------------------------------------------------
Function cantReg(idioma)' contador de elementos dentro del nodo base de cada idioma
  cantReg = nodoBase(idioma).ChildNodes.length 
End Function
'---------------------------------------------------------------------------------------------------------------------------
Function VerDetalles(idioma,id)' ver detalles funcion que nos devuelve los detalles de cada idioma con su respectivo id
   	 set xmlcontent = nodoBase(idioma).ChildNodes.item((id)-1)
 	 VerDetalles = xmlcontent.ChildNodes.item(3).text
	 'set xmlcontent = nothing
End function
'---------------------------------------------------------------------------------------------------------------------------
 Function VerAbreviado(idioma,id)' ver detalles funcion que nos devuelve los detalles de cada idioma con su respectivo id
   	 set xmlcontent = nodoBase(idioma).ChildNodes.item((id)-1)
 	 VerAbreviado = xmlcontent.ChildNodes.item(2).text
	 'set xmlcontent = nothing
End function
'---------------------------------------------------------------------------------------------------------------------------
Function intID(idioma)'si es un nuevo registro se incrementa el ID para el mismo
			if objetoXMLCargar(idioma).childnodes(0).childnodes(1).hasChildNodes then
			  intID = objetoXMLCargar(idioma).childnodes(0).childnodes(1).childnodes(_
			  objetoXMLCargar(idioma).childnodes(0).childnodes(1).childnodes.length -1).childnodes(0).text + 1
			  else
			   intID = 0
			  end if
end Function
 '---------------------------------------------------------------------------------------------------------------------------
 Function NuevoRegistro (idioma,id,titulo,abreviado,detalle)
   
    Set objeto = objetoXMLCargar(idioma)
	
 	Set objXMLv = objeto.createElement("Content")

    objXMLv.appendChild(objeto.createElement("ID"))  
  	objXMLv.appendChild(objeto.createElement("nombreVariable")) 
    objXMLv.appendChild(objeto.createElement("traduccion")) 
  	objXMLv.appendChild(objeto.createElement("detalles")) 
  
 	objXMLv.childNodes(0).text = id & vbCr
	objXMLv.childNodes(1).text = titulo & vbCr
	objXMLv.childNodes(2).text = abreviado	& vbCr
	objXMLv.childNodes(3).text = detalle & vbCr
    
     objeto.documentElement.childnodes(1).appendChild(objXMLv.cloneNode(true))
	 objeto.save(xmlRuta(idioma))
  
 End Function
'---------------------------------------------------------------------------------------------------------------------------
Function modDetalles(idioma,id,titulo,abreviado,detalle) 
    
	Set objeto = objetoXMLCargar(idioma)
  	Set objXMLv = objeto.createElement("Content")
    objXMLv.appendChild(objeto.createElement("ID"))
  	objXMLv.appendChild(objeto.createElement("nombreVariable"))
    objXMLv.appendChild(objeto.createElement("traduccion"))
  	objXMLv.appendChild(objeto.createElement("detalles"))
  
 	objXMLv.childNodes(0).text = id
	objXMLv.childNodes(1).text = titulo
	objXMLv.childNodes(2).text = abreviado	
	objXMLv.childNodes(3).text = detalle
 	
	Set objXMLvOld = objeto.childnodes(0).childnodes(1).childnodes((id)-1)
	objeto.documentElement.childnodes(1).replaceChild objXMLv, objXMLvOld
  
	 objeto.save(xmlRuta(idioma))

end function 
'---------------------------------------------------------------------------------------------------------------------------
  Function eliminaRegistro(idioma,id)
 	Set objeto = objetoXMLCargar(idioma)
     set remove = _
        objeto.childnodes(0).childnodes(1).childnodes(id)
        objeto.childnodes(0).childnodes(1).removeChild(remove)
	    objeto.save(xmlRuta(idioma))
  end function
'---------------------------------------------------------------------------------------------------------------------------
 Function listarSeleccion(idioma,Tipobuscar,parametro)
 nohayregistros=false
 totalDeRegistros=cantReg(idioma)
 
    select case Tipobuscar
 					  	
		case"todo"
	                 for i = 0 to totalDeRegistros - 1 
			            set xmlcontent = nodoBase(idioma).ChildNodes.item(i)%>
						<tr bgcolor="f0f0f0"  align="center"> <div  align="center">
						  
    <td bgcolor="#FFFFFF"  >
	   <table width="6%" border="0">
  <tr valign="middle">
    <td height="23"><a class="links" href="javascript:ABorrar(<%=i%>);"><img src="img/tacho.jpg" alt="Eliminar" width="17" height="21" border="0"></a></td>
    <td>&nbsp;</td>
    <td><a href=javascript:nueva_ventana('VerDetalles.asp?id=<%= i+1%>&modo=EDITAR&titulo=<%=xmlcontent.ChildNodes.item(1).text%>',550,650,0) ><img src="img/editar.jpg" width="17" alt="Editar" height="19" border="0"></a> 
    </td>
  </tr>
</table>

 </td>
						  <td><div class="tituloMedioChico"><%= xmlcontent.ChildNodes.item(0).text%></div></td>
						  <td> <img src="img/<%=idioma%>.png" alt="<%=idioma%>" width="13" height="9"  border="0"></td>
						  <td><div class="tituloMedioChico"><%= Cortar(xmlcontent.ChildNodes.item(1).text, 10)%> </div></td>
						  <td><div class="tituloMedioChico"><%= Cortar(xmlcontent.ChildNodes.item(2).text, 10)%></div></td>
						</div></tr>
						 <tr bgcolor="#f0f0f0"> 
							  <td height="1" colspan="5"> </td>
					     </tr>
				<%nohayregistros=true
				
				next
			case"titulo"
			
			 for i = 0 to totalDeRegistros - 1 
			            set xmlcontent = nodoBase(idioma).ChildNodes.item(i) 
		             if (ucase(parametro)) = (ucase(xmlcontent.ChildNodes.item(1).text)) then
			        %>
						<tr bgcolor="f0f0f0"  align="center">  
 							<td bgcolor="#FFFFFF"  >
							   <table width="6%" border="0">
						  <tr valign="middle">
							<td height="23"><a class="links" href="javascript:ABorrar(<%=i%>);"><img src="img/tacho.jpg" alt="Eliminar" width="17" height="21" border="0"></a></td>
							<td>&nbsp;</td>
							<td><a href=javascript:nueva_ventana('VerDetalles.asp?id=<%=i+1%>&modo=EDITAR&titulo=<%=xmlcontent.ChildNodes.item(1).text%>',550,650,0) ><img src="img/editar.jpg" alt="Editar" width="17" height="19" border="0"></a> 
							</td>
						  </tr>
						</table>
 						 </td>
 						  <td><div class="tituloMedioChico"><%= xmlcontent.ChildNodes.item(0).text%></div></td>
						  <td> <img src="img/<%=idioma%>.png" alt="<%=idioma%>" width="13" height="9"  border="0"></td>
						  <td><div class="tituloMedioChico"><%= Cortar(xmlcontent.ChildNodes.item(1).text, 10)%> </div></td>
						  <td><div class="tituloMedioChico"><%= Cortar(xmlcontent.ChildNodes.item(2).text, 10)%></div></td>
						 </tr>
		                <tr  bordercolor="#f0f0f0"> 
							  <td height="1" colspan="5"> </td>
					   </tr>
					  <%  	
					end if
					nohayregistros=true	  
				 next
     end select
	if Not(nohayregistros) then
	  %><script>alert ("No hay registros almacenados")</script><%
	end if
 End function
'---------------------------------------------------------------------------------------------------------------------------
 Function Cortar (str, longitud)
' Corta una cadena 'str' a la longitud especificada. Corta por la izda
if Len(str) => longitud+4 then
	Cortar=Left(str, longitud)&"..."
else
	Cortar=str
end if

End Function ' Cortar
'---------------------------------------------------------------------------------------------------------------------------
Function existe(idioma,parametro)
encontro= 0
totalDeRegistros=cantReg(idioma)
			 for i = 0 to totalDeRegistros - 1 
			            set xmlcontent = nodoBase(idioma).ChildNodes.item(i) 
		             if (ucase(parametro)) = (ucase(xmlcontent.ChildNodes.item(1).text)) then
					         encontro= 1
							 exit for
 				     end if  
             next  
 		if encontro = 1 Then
		 existe="true"
		End If 	
		 
 End function
'---------------------------------------------------------------------------------------------------------------------------
 Function titulos(idioma)
   totalDeRegistros=cantReg(idioma)
  		   for i = 0 to totalDeRegistros - 1 
		        set xmlcontent = nodoBase(idioma).ChildNodes.item(i)
				 %><option value="<%=(xmlcontent.ChildNodes.item(1).text)%>"><%=(xmlcontent.ChildNodes.item(1).text)%></option>	<%  
            next
 End function 
'---------------------------------------------------------------------------------------------------------------------------
'function dameNombre(idioma,nombre)
 'totalDeRegistros=NroRegistros(idioma)
 ' for i = 0 to totalDeRegistros - 1 
		 ' set xmlcontent = nodoPrincipal(idioma).ChildNodes.item(i) 
 				' If (nombre = xmlcontent.ChildNodes.item(1).text) then
					       ' dameNombre=xmlcontent.ChildNodes.item(2).text 
				'end if  
     'next  
' End function


%>