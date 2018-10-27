<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.QueryString("est")) 'el hotel
lang=request.QueryString(" lang")

'Buscar tipo hab. y nombre
cs="SELECT TipoHabitaNombres.Id,IF (ISNULL(Traduccion),nombre,Traduccion) AS Tradu,ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,"
cs=cs & "ParaCapNormal,CunaOcupa,ParaAdultMin FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est & " ORDER BY orden"
'response.write "cs : " & cs & "<br>"
rs.Open cs, base
hayhabis=false
if not rs.eof then
	RegHabis=rs.GetRows
	'Variables para la tabla Habitaciones
	HaCodi=0
	HaNombre=1
	HaCapMax=2
	HaCapMin=3
	HaAduMax=4
	HaNinMax=5
	HaCapNormal=6
	HaCunaOcupa=7
	HaAduMin=8
	hayhabis=true
end if
rs.close

		
if est<>0 then 'seguimos no hay fallos
	'General XML de respuesta
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<data>" & vbcrlf
	response.write vbtab & "<codigohotel>" & est & "</codigohotel>" & vbcrlf
	if hayhabis then
		for h=0 to ubound(RegHabis,2)
			'Fotos de la habitacion
			'cs="SELECT Foto FROM FotosHabitacion WHERE IdHabitacion=" & RegHabis(HaCodi,h) & " ORDER BY Orden,Id"
			'rs.open cs,base
			'lasfotos=""
			'do while not rs.eof
			'	lasfotos=lasfotos & "http://admin.kubikcrs.com" & rutaFotos & server.HTMLEncode(rs("foto")) & ";"
			'	rs.movenext
			'loop
			'rs.close
			
			'Textos de la habitacion
			cs="SELECT IF (ISNULL(Traduccion),Texto,Traduccion) AS Tradu FROM " & precrs & "HabitacionesHotel HabitacionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
			cs=cs & "ON HabitacionesHotel.IdHabitacion=Traducciones.IdReferencia AND Tabla='HabitacionesHotel' AND "
			cs=cs & "Campo='Texto' AND Idioma='" & lang & "' "
			cs=cs & "WHERE IdHabitacion=" & RegHabis(HaCodi,h)
			eltexto=""
			rs.open cs,base
			if not rs.eof then
				eltexto=server.HTMLEncode("" & rs("Tradu"))
			end if
			rs.close
		
			response.write vbtab & "<habitacion>" & vbcrlf
			response.write vbtab & vbtab & "<codhab>" & RegHabis(HaCodi,h) & "</codhab>" & vbcrlf
			response.write vbtab & vbtab & "<nomhab>" & server.HTMLEncode(RegHabis(HaNombre,h)) & "</nomhab>" & vbcrlf
			response.write vbtab & vbtab & "<fotos>" & lasfotos & "</fotos>" & vbcrlf
			response.write vbtab & vbtab & "<descripcion>" & eltexto & "</descripcion>" & vbcrlf
			response.write vbtab & vbtab & "<capmax>" & RegHabis(HaCapMax,h) & "</capmax>" & vbcrlf
			response.write vbtab & vbtab & "<capmin>" & RegHabis(HaCapMin,h) & "</capmin>" & vbcrlf
			response.write vbtab & vbtab & "<capnormal>" & RegHabis(HaCapNormal,h) & "</capnormal>" & vbcrlf
			response.write vbtab & vbtab & "<adultmax>" & RegHabis(HaAduMax,h) & "</adultmax>" & vbcrlf
			response.write vbtab & vbtab & "<adultmin>" & RegHabis(HaAduMin,h) & "</adultmin>" & vbcrlf
			response.write vbtab & vbtab & "<ninmax>" & RegHabis(HaNinMax,h) & "</ninmax>" & vbcrlf
			response.write vbtab & vbtab & "<cunaocupa>" & clng(RegHabis(HaCunaOcupa,h)) & "</cunaocupa>" & vbcrlf
			response.write vbtab & "</habitacion>" & vbcrlf
		next 'h
	end if 'hayhabis
	response.write "</data>"
end if 'otro errormsg

set rs=nothing
base.close
set base=nothing
%>