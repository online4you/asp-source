<%
localConnection=true
%>
<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel
lang=request.QueryString(" lang")
Fpago= paclng(request.QueryString("FPago"))

'/////////////////////////////////////////////////////////////////////////////////////////////////////////////
' esta condicion es para standarizar la forma de pago; si la varible viene a "1" le pasamos los datos del TPW.
muesta_FPago = False
if Fpago=1 then 
	muesta_FPago = true
	'hacemos la consulta a la base de datos de donde recogemos los datos del TPV
	cs="SELECT * "
	cs=cs & "FROM " & precrs & "FPagoHotel "
	cs=cs & "WHERE CodigoEsta=" & est
	rs.open cs,base
	if not rs.eof then
	  tipoFPago=paClng(rs("tipoFPago"))
	  codcomercio=rs("codcomercio")
	  terminal=rs("terminal")
	  clave=rs("clave")
	  clavexor=rs("clavexor")
	  produccion=paClng(rs("produccion"))
	  acquirerBIN="" & rs("acquirerBIN")
	end if
	rs.close
	
	'if Ucase(produccion) = "TRUE" then
'		produccion = 1
'	else
'		produccion = 0
'	end if
end if 

' end if Fpago=1 then
'////////////////////////////////////////////////////////////////////////////////////////////////////////////

cs="SELECT Establecimientos.Nombre,Email,Direccion,cp,Poblacion,Telefono,Fax,Zona,URL,Estado,"
cs=cs & "Porciento,MinDias,DiasAnulacion,TipoAlojamiento,Categoria,CodigoISO,Foto "
cs=cs & "FROM (" & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) LEFT JOIN " & precrs & "TiposMoneda TiposMoneda "
cs=cs & "ON Establecimientos.Moneda=TiposMoneda.Id "
cs=cs & "WHERE Establecimientos.CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nombre=rs("nombre")
	email=rs("email")
	dire=rs("direccion")
	cp=rs("cp")
	pobla=rs("poblacion")
	tele=rs("telefono")
	fax=rs("fax")
	zona=rs("zona")
	estado=rs("estado")
	url=rs("url")
	prepago=rs("porciento")
	diasmin=rs("mindias")
	tipoh=rs("tipoalojamiento")
	categoria=rs("categoria")
	diasanul=rs("diasanulacion")
	moneda=rs("codigoISO")
	foto="" & rs("foto")
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<center><h2>Hotel no encontrado</h2></center>"
	response.End()
end if
rs.close

'Tabla tipos alojamiento
cs="SELECT TipoAlojamiento.Id,IF(ISNULL(Traduccion),Nombre,Traduccion)  AS Nombre FROM " & precrs & "TipoAlojamiento TipoAlojamiento LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoAlojamiento.Id=Traducciones.IdReferencia AND Tabla='TipoAlojamiento' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
rs.open cs,base
haytipoa=false
if not rs.eof then
	RegTipoA=rs.getrows
	RTCodi=0
	RTNombre=1
	haytipoa=true
end if
rs.close

'Tabla categorias
cs="SELECT Categorias.Id,IF(ISNULL(Traduccion),Nombre,Traduccion) AS Nombre FROM " & precrs & "Categorias Categorias LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Categorias.Id=Traducciones.IdReferencia AND Tabla='Categorias' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "'"
rs.open cs,base
haycate=false
if not rs.eof then
	RegCate=rs.getrows
	RCCodi=0
	RCNombre=1
	haycate=true
end if
rs.close

if con_googlemaps then 'buscar punto

	cs="SELECT laX,laY,Zoom,ISNULL(Traduccion,Texto) AS Tradu,Icono "
	cs=cs & "FROM " & precrs & "GMapsHotel GMapsHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON GMapsHotel.Id=Traducciones.IdReferencia "
	cs=cs & "AND Tabla='GMapsHotel' AND Campo='Texto' AND Idioma='" & lang & "' "
	cs=cs & "WHERE GMapsHotel.CodigoEsta=" & est
	rs.open cs,base
	hayGpunto=false
	if not rs.eof then
		GMx=rs("laX")
		GMy=rs("laY")
		Zoom=rs("zoom")
		Texto=rs("Tradu")
		Icono=rs("Icono")
	end if
	rs.close

end if

if con_cms then 'buscar secciones y contenidos
	cs="SELECT SeccionesHotel.Id,ISNULL(Traduccion,Seccion) AS Tradu "
	cs=cs & "FROM " & precrs & "SeccionesHotel SeccionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON SeccionesHotel.Id=Traducciones.IdReferencia AND Tabla='SeccionesHotel' AND "
	cs=cs & "Campo='Seccion' AND Idioma='" & lang & "' "
	cs=cs & "WHERE SeccionesHotel.CodigoEsta=" & est & " ORDER BY Orden"
	rs.open cs,base
	haySecci=false
	if not rs.eof then
		RegSecci=rs.getrows
		SCodi=0
		STitulo=1
		haySecci=true
	end if
	rs.close
	
	'Textos y fotos
	cs="SELECT TextosHotel.IdSeccion,ISNULL(Traduccion,Texto) AS Tradu,Foto "
	cs=cs & "FROM (" & precrs & "TextosHotel TextosHotel LEFT JOIN " & precrs & "FotosHotel FotosHotel "
	cs=cs & "ON TextosHotel.IdSeccion=FotosHotel.IdSeccion) LEFT JOIN Traducciones "
	cs=cs & "ON TextosHotel.Id=Traducciones.IdReferencia AND Tabla='TextosHotel' AND "
	cs=cs & "Campo='Texto' AND Idioma='" & lang & "' "
	cs=cs & "WHERE TextosHotel.CodigoEsta=" & est & " ORDER BY TextosHotel.IdSeccion"
	rs.open cs,base
	hayTextoSecci=false
	if not rs.eof then
		RegTSecci=rs.getrows
		STCodi=0
		STTexto=1
		STFoto=2
		hayTextoSecci=true	
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
response.write "<hotel>" & server.HTMLEncode(nombre) & "</hotel>" & vbcrlf
response.write "<prepago>" & prepago & "</prepago>" & vbcrlf
response.write "<email>" & email & "</email>" & vbcrlf
response.write "<direccion>" & server.HTMLEncode("" & dire) & "</direccion>" & vbcrlf
response.write "<cp>" & cp & "</cp>" & vbcrlf
response.write "<poblacion>" & server.HTMLEncode("" & pobla) & "</poblacion>" & vbcrlf
response.write "<telefono>" & tele & "</telefono>" & vbcrlf
response.write "<fax>" & fax & "</fax>" & vbcrlf
response.write "<categoria>" & categoria
'Buscar Categoria
if haycate then
for t=0 to ubound(RegCate,2)
	if RegCate(RCCodi,t)=categoria then
		response.write "-" & server.HTMLEncode(RegCate(RCNombre,t))
		exit for
	end if
next 't
end if 'haytipoa
response.write "</categoria>" & vbcrlf
response.write "<zona>" & zona & "</zona>" & vbcrlf
response.write "<tipoaloja>" & tipoh
'Buscar Tipo
if haytipoa then
for t=0 to ubound(RegTipoA,2)
	if RegTipoA(RTCodi,t)=tipoh then
		response.write "-" & server.HTMLEncode(RegTipoA(RTNombre,t))
		exit for
	end if
next 't
end if 'haytipoa
response.write "</tipoaloja>" & vbcrlf
response.write "<estado>" & estado & "</estado>" & vbcrlf
response.write "<moneda>" & moneda & "</moneda>" & vbcrlf
if foto<>"" then
	lafoto="http://admin.kubikcrs.com" & rutafotos & foto
else
	lafoto=""
end if
response.write "<foto>" & server.HTMLEncode(lafoto) & "</foto>" & vbcrlf
response.write "<googlemap>" & vbcrlf
response.write vbtab & "<valor_X>" & GMx & "</valor_X>" & vbcrlf
response.write vbtab & "<valor_Y>" & GMy & "</valor_Y>" & vbcrlf
response.write vbtab & "<zoom>" & zoom & "</zoom>" & vbcrlf
response.write vbtab & "<texto>" & server.HTMLEncode(texto) & "</texto>" & vbcrlf
response.write vbtab & "<icono>" & server.HTMLEncode(icono) & "</icono>" & vbcrlf
response.write "</googlemap>" & vbcrlf
if con_cms and haySecci then
	response.write "<contenidos>" & vbcrlf
	for s=0 to ubound(RegSecci,2)
		response.write vbtab & "<seccion>" & vbcrlf
		response.write vbtab & vbtab & "<titulo>" & server.HTMLEncode(RegSecci(STitulo,s)) & "</titulo>" & vbcrlf
		primera=true
		lafoto=""
		texto=""
		if hayTextoSecci then
		for t=0 to ubound(RegTSecci,2)
			if RegTSecci(TSCodi,t)=RegSecci(SCodi,s) then 'esta seccion
				if primera then 
					texto=RegTSecci(STTexto,t)
					primera=false
				end if
				if RegTSecci(STFoto,t)<>"" then
					lafoto=lafoto & "http://admin.kubikcrs.com" & rutafotos & RegTSecci(STFoto,t) & ";"
				end if
			end if
		next 't
		end if 'hayTextoSecci
		response.write vbtab & vbtab & "<descripcion>" & server.HTMLEncode(texto) & "</descripcion>" & vbcrlf
		if lafoto<>"" then lafoto=left(lafoto,len(lafoto)-1)
		response.write vbtab & vbtab & "<fotos>" & server.HTMLEncode(lafoto) & "</fotos>" & vbcrlf
		response.write vbtab & "</seccion>" & vbcrlf
	next
	response.write "</contenidos>" & vbcrlf
end if 'con_cms
if muesta_FPago then
	response.write "<FPago>" & vbcrlf
	response.write vbtab & "<tipoFpago>" & tipoFPago & "</tipoFpago>" & vbcrlf
	response.write vbtab & "<codComercio>" & codcomercio & "</codComercio>" & vbcrlf
	response.write vbtab & "<acquirerBIN>" & acquirerBIN & "</acquirerBIN>" & vbcrlf
	response.write vbtab & "<terminal>" & terminal & "</terminal>" & vbcrlf
	response.write vbtab & "<clave>" & clave & " </clave>" & vbcrlf
	response.write vbtab & "<clavexor>" & clavexor & "</clavexor>" & vbcrlf
 	response.write vbtab & "<produccion>" & produccion & "</produccion>" & vbcrlf
	response.write "</FPago>" & vbcrlf
end if

response.write "</data>"
%>