<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

ConectaGSys="Provider=SQLOLEDB.1;Persist Security Info=True;User ID=WebUser;pwd=P1AN3TAweb;Initial Catalog=globalsys;Data Source=localhost"

set baseGsys=server.createobject("ADODB.Connection")
set rsg=server.createobject("ADODB.Recordset")
rsg.CursorLocation = adUseServer
rsg.CursorType=adOpenForwardOnly
rsg.LockType=adLockReadOnly
baseGsys.Open ConectaGSys

'Parametros para el buscador
lang=request.querystring("lang")
tservicio=request.querystring("ts")
orden=request.querystring("orden")

if errormsg="" then 'sigo buscando

	cs="SELECT ConsultaHoteles.CodigoEsta,ConsultaHoteles.Nombre,ConsultaHoteles.Categoria,ConsultaHoteles.Zona,"
	cs=cs & "ConsultaHoteles.TipoAlojamiento,Estado,Foto,"
	cs=cs & "ISNULL([dbo].[ GetMinimumPrice](DatosHotel.CodigoEsta,SYSDATETIME(),DATEADD(month,6,SYSDATETIME())),0) as MinPrice, Visitas, Orde "
	cs=cs & "FROM (ConsultaHoteles INNER JOIN DatosHotel "
	cs=cs & "ON ConsultaHoteles.CodigoEsta=DatosHotel.CodigoEsta) "
	cs=cs & "WHERE Estado<>" & noventa
	if tservicio<>"" and tservicio<>"0" then 
		lservi=split(tservicio,"-")
		cs=cs & " AND DatosHotel.CodigoEsta IN ( SELECT CodigoEsta From CaracteristicasHotel "
		cs=cs & " Where CaracteristicasHotel.IdCaracter IN("
		for hh=0 to ubound(lservi)
			cs=cs & lservi(hh) & ", "
		next
		cs=left(cs,len(cs)-2) & ")) "
	end if 'tservicio
	cs=cs & " ORDER BY "
	If(orden = "price") Then
		cs=cs & "MinPrice ASC,Categoria DESC,"
	ElseIf (orden = "price2") Then
		cs=cs & "MinPrice DESC,Categoria DESC,"
	ElseIf (orden = "category") Then
		cs=cs & "Categoria DESC,MinPrice ASC,"
	ElseIf (orden = "category2") Then
		cs=cs & "Categoria ASC,MinPrice ASC,"
	End If
	cs=cs & " ConsultaHoteles.CodigoEsta"
	
	'response.write cs
	
	rs.Open cs, base
	hayhotel=false
	if not rs.eof then
		RegHotel=rs.getrows
		HoCodi=0
		HoNombre=1
		HoCate=2
		HoZona=3
		HoTipoa=4
		Hoestado=5
		HoFoto=6
		HoMinPrice=7
		HoVisitas=8
		HoOrden=9
		hayhotel=true
	end if
	rs.close
	
	if not hayhotel then
		errormsg="No encontrados"
		response.write errormsg
	end if
	if errormsg="" then 'no hay error
		
		'Tabla tipos alojamiento
		cs="SELECT TipoAlojamiento.Id,ISNULL(Traduccion,Nombre) AS Nombre FROM TipoAlojamiento LEFT JOIN Traducciones "
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
		cs="SELECT Categorias.Id,ISNULL(Traduccion,Nombre) AS Nombre FROM Categorias LEFT JOIN Traducciones "
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
		
		'Tabla de tipos habitaciones (que entren los adultos y niños indicados)
		cs="SELECT TipoHabitaNombres.Id,ParaCapNormal,ParaCapMax,ISNULL(Traduccion,Nombre) AS Nombre,"
		cs=cs & "TipoHabitaNombres.CodigoEsta "
		cs=cs & "FROM TipoHabitaNombres LEFT JOIN Traducciones "
		cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "

		'response.write cs & "<br/>"
		haytipohab=false
		rs.open cs,base
		if not rs.eof then
			Regtipohab=rs.getrows
			HabCodi=0
			HabNormal=1
			HabMax=2
			HabNombre=3
			HabHotel=4
			haytipohab=true
			'response.write "N Habi:" & ubound(RegTipoHab,2) & "<br>"
		end if
		rs.close
		
		'Generar XML
		response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
		response.write "<data>" & vbcrlf
		if miorden>-1 then 'hay registros, generar html
			antehotel=-1
			nhoteles=0
			if hayhotel then
				for h=0 to ubound(RegHotel,2)
					if antehotel<>RegHotel(HoCodi,h) then 'Cambio de hotel, buscar datos
						antehotel=RegHotel(HoCodi,h)
						nhoteles=nhoteles+1
						response.write "<hotel>" & vbcrlf
						response.write vbtab & "<codigo>" & RegHotel(HoCodi,h) & "</codigo>" & vbcrlf
						response.write vbtab & "<nombre>" & server.HTMLEncode(RegHotel(HoNombre,h)) & "</nombre>" & vbcrlf
						response.write vbtab & "<tipo>" & RegHotel(HoTipoa,h) & "</tipo>" & vbcrlf
						response.write vbtab & "<nombreTipo>"
						'Buscar Tipo
						if haytipoa then
							for t=0 to ubound(RegTipoA,2)
								if RegTipoA(RTCodi,t)=RegHotel(HoTipoa,h) then
									response.write server.HTMLEncode(RegTipoA(RTNombre,t))
									Exit For
								end if
							next 't
						end if 'haytipoa
						response.write "</nombreTipo>" & vbcrlf
						response.write vbtab & "<categoria>" & RegHotel(HoCate,h) & "</categoria>" & vbcrlf
						'Buscar Categoria
						response.write vbtab & "<nombreCategoria>"
						if haycate then
							for t=0 to ubound(RegCate,2)
								if RegCate(RCCodi,t)=RegHotel(HoCate,h) then
									response.write server.HTMLEncode(RegCate(RCNombre,t))
									exit for
								end if
							next 't
						end if 'haytipoa
						response.write "</nombreCategoria>" & vbcrlf
						response.write vbtab & "<estado>" & RegHotel(HoEstado,h) & "</estado>" & vbcrlf
						response.write vbtab & "<minprice>" & RegHotel(HoMinPrice,h) & "</minprice>" & vbcrlf
						response.write vbtab & "<orden>" & RegHotel(HoOrden,h) & "</orden>" & vbcrlf
						response.write vbtab & "<visitas>" & RegHotel(HoVisitas,h) & "</visitas>" & vbcrlf
						response.write vbtab & "<zona>" & RegHotel(HoZona,h) & "</zona>" & vbcrlf
						response.write vbtab & "<urlfoto>" & server.HTMLEncode(RegHotel(HoFoto,h)) & "</urlfoto>" & vbcrlf
						response.write vbtab & "<descripcion>"
						'Buscar si tiene texto
						if con_cms then
							cs="SELECT ISNULL(Traduccion,Texto) AS Texto "
							cs=cs & "FROM (TextosHotel INNER JOIN SeccionesHotel "
							cs=cs & "ON TextosHotel.IdSeccion=SeccionesHotel.Id) LEFT JOIN Traducciones "
							cs=cs & "ON TextosHotel.Id=Traducciones.IdReferencia AND Tabla='TextosHotel' "
							cs=cs & "AND Campo='Texto' AND Idioma='" & lang & "' "
							cs=cs & "WHERE TextosHotel.CodigoEsta=" & RegHotel(HoCodi,h)
							cs=cs & " ORDER BY SeccionesHotel.Orden"
							rs.open cs,base
							if not rs.eof then
								response.write server.HTMLEncode("" & rs("texto"))
							end if
							rs.close
						end if 'con_cms
						response.write "</descripcion>" & vbcrlf
						response.write "</hotel>" & vbcrlf
					end if
				next 'h
			end if 'hayhotel
			
		end if 'miorden>-1
		response.Write "<resultados>" & nhoteles & "</resultados>" & vbcrlf
		response.Write "</data>"

	end if 'errormsg
	
	
else
	response.write "<data><resultados>0</resultados><error>"&errormsg&"</error></data>"
end if

set rs=nothing
base.close
set base=nothing

set rsg=nothing
baseGsys.close
set baseGsys=nothing

%>