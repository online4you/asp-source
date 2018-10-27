<%
localConnection=true
%>
<!--#include file="datosEmpresa.asp"-->
<%
set base = server.createobject("ADODB.Connection")
base.Open Conecta
set rs = server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType = adOpenForwardOnly
rs.LockType = adLockReadOnly

lang = request.QueryString("lang")
est = paClng(request.QueryString("est"))
fini = cdate(request.QueryString("fini"))
ffin = cdate(request.QueryString("ffin"))
ids = paClng(request.QueryString("ids"))
tarifa = paClng(request.QueryString("tarifa"))
if tarifa = 0 then tarifa = 1

cs = "SELECT Id, "
cs=cs & "IF(ISNULL(traduc.Traduccion),ServiciosExtras.Nombre,traduc.Traduccion) AS Titulo,  "
cs=cs & "IF(ISNULL(traduc.Traduccion),ServiciosExtras.Texto,traduc.Traduccion) AS Descri,  "
cs=cs & " url "
cs = cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Traducciones.Tabla = ""ServiciosExtras"" And Traducciones.Campo = ""Nombre"" And Traducciones.Idioma = """ & lang & """)  AS traduc ON ServiciosExtras.Id = traduc.IdReferencia  "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones2 WHERE Traducciones2.Tabla = ""ServiciosExtras"" And Traducciones2.Campo = ""Texto"" And Traducciones2.Idioma = """ & lang & """)  AS traduc2 ON ServiciosExtras.Id = traduc2.IdReferencia  "
cs = cs & "WHERE Activo<>0 AND (CodigoEsta=0 OR CodigoEsta=" & est & ")"
if ids <> 0 then
	cs = cs & "AND Id=" & ids
end if 'ids
cs = cs & " ORDER BY Orden,Id"

'response.write cs & vbcrlf & vbcrlf
 
rs.open cs, base
hayservis = false
if not rs.eof then
	RegServis = rs.getrows
	SId = 0
	STitu = 1
	SDescri = 2
	SURL = 3
	hayservis = true
end if
'i=0
'do while not rs.eof 
'	i=i+1
'	rs.movenext
'loop
'rs.movefirst
'ReDim RegServis(4,i)
'i=0
'do while not rs.eof 
'	i=i+1
	'redim preserve RegServis(4,i)
'	RegServis(SId,i)=rs(SId)
'	RegServis(STitu,i)=rs(STitu)
'	RegServis(SDescri,i)=rs(SDescri)
'	RegServis(SURL,i)=rs(SURL)
'	hayservis = true
'	rs.movenext
'loop
rs.close
'response.write hayservis & vbcrlf & vbcrlf
if hayservis then
	'Generar XML de respuesta
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<data>" & vbcrlf
	anteservi = 0
	'response.write ubound(RegServis, 2) & vbcrlf & vbcrlf
	for s = 0 to ubound(RegServis, 2)
		'Buscar si tiene precio
		cs = "SELECT ServiciosPrecios.*, "
		cs=cs & "IF(ISNULL(traduc.Traduccion),Colectivos.Nombre,traduc.Traduccion) AS Colectivo , Orde   "
		cs = cs & "FROM " & precrs & "ServiciosPrecios ServiciosPrecios LEFT JOIN " & precrs & "Colectivos Colectivos "
		cs = cs & "ON ServiciosPrecios.IdColectivo=Colectivos.CodigoColec "
		cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Traducciones.Tabla = ""Colectivos"" And Traducciones.Campo = ""Nombre"" And Traducciones.Idioma = """ & lang & """)  AS traduc ON Colectivos.CodigoColec = traduc.IdReferencia  "
		cs = cs & "WHERE IdServicio=" & RegServis(SId,s) & " AND ("
		cs = cs & FechaMySQL(fini) & " BETWEEN FechaInicio AND FechaFinal"
		cs = cs & " OR FechaInicio BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin)
		cs = cs & ")"
		
		'response.write cs & vbcrlf
		
		rs.open cs,base
		if not rs.eof then
		
			response.write "<servicio>" & vbcrlf
			response.write vbtab & "<id>" & RegServis(SId,s) & "</id>" & vbcrlf
			response.write vbtab & "<titulo>" & server.HTMLEncode(RegServis(STitu,s)) & "</titulo>" & vbcrlf
			response.write vbtab & "<descripcion>" & server.HTMLEncode(RegServis(SDescri,s)) & "</descripcion>" & vbcrlf
			response.write vbtab & "<url>" & RegServis(SURL,s) & "</url>" & vbcrlf
			
			response.write vbtab & "<precios>" & vbcrlf
			
			do while not rs.eof 
				response.write vbtab & vbtab & "<precio>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<fechaInicio>" & rs("fechaInicio") & "</fechaInicio>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<fechaFinal>" & rs("fechaFinal") & "</fechaFinal>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<colectivo>" & rs("IdColectivo") & ";" & server.HTMLEncode("" & rs("colectivo")) & ";" & rs("orde") & "</colectivo>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<tipo>" & rs("tipo") & "</tipo>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<importe>" & rs("importe") & "</importe>" & vbcrlf
				
				obliga = 0
				if rs("obligatorio") then
					obliga = 1
				end if
				
				'response.write vbtab & vbtab & vbtab & "<obligado>" & paclng(rs("obligatorio")) & "</obligado>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<obligado>" & obliga & "</obligado>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<regimen>" & rs("regimen") & "</regimen>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<habitaciones>" & rs("habitaciones") & "</habitaciones>" & vbcrlf
				
				oferta = 0
				if idEmpresa = 98 then
					if rs("incluirenoferta") then
						oferta = 1
					end if
				end if
								
				response.write vbtab & vbtab & vbtab & "<oferta>" & oferta & "</oferta>" & vbcrlf
				response.write vbtab & vbtab & "</precio>" & vbcrlf
				rs.movenext			
			loop
			response.write vbtab & "</precios>" & vbcrlf
			rs.close
			
			response.write vbtab & "<fotos>" & vbcrlf
			'Buscar fotos
			cs="SELECT Foto FROM " & precrs & "ServiciosFotos ServiciosFotos WHERE IdServicio=" & RegServis(SId,s)
			rs.open cs,base
			if not rs.eof then
				do while not rs.eof
					response.write vbtab & vbtab & "<foto>http://admin.kubikcrs.com" & rutafotos & server.HTMLEncode(rs("foto")) & "</foto>" & vbcrlf
					rs.movenext
				loop
			else
				response.write vbtab & vbtab & "<foto></foto>" & vbcrlf
			end if
			rs.close
			response.write vbtab & "</fotos>" & vbcrlf
	
			response.write "</servicio>" & vbcrlf
		else
			rs.close
		end if 'sin precios
	next
	response.write "</data>"

else 'no hay
	response.write "No hay servicios extras" & vbcrlf
end if 'hayservis

set rs=nothing
base.close
set base=nothing
%>