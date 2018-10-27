<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang=request.QueryString("lang")
if(lang = "") then 
	lang="es" 
end if
est=paClng(request.QueryString("est"))
FLlegada=cdate(request.Querystring("fini"))
FSalida=cdate(request.Querystring("ffin"))

Noches=FSalida-FLlegada

'Datos cliente de la reserva
tratamiento=cdbl(request.QueryString("tratamiento"))
nombre=request.QueryString("nombre")
apellidos=request.QueryString("apellido")
pais=request.QueryString("pais")
codpais=request.QueryString("codpais")
telefono=request.QueryString("telf")
email=request.QueryString("email")
obs=request.QueryString("observaciones")
importe=cdbl(request.QueryString("precioTotal"))
PrePago=cdbl(request.QueryString("precioOnLine"))
bruto=cdbl(request.QueryString("precioAlojamiento"))
codigoVIP=request.QueryString("codigoVIP")
if codigoVIP = "" Then codigoVIP = "0"
idagencia=request.QueryString("idagencia")
if idagencia = "" Then idagencia = "0"

confirmada=cdbl(request.QueryString("confirmada"))

tipoventa=cdbl(request.QueryString("tv"))
if tipoventa = "" Then tipoventa = "0"

strSeleccion = request.QueryString("strSeleccion")

'Crear la reserva
cs="INSERT INTO " & precrs & "Reservas (CodigoEsta,FechaIni,FechaFin,NumDias,Importe,ImportePag,"
cs=cs & "Activa,Comentarios,Idi,Servicios,CodOferta,PelasOferta,FechaReserva,CodAgencia,TipoVentaAgencia,"
cs=cs & "CodigoVIP,TipoVenta) VALUES (" & est & ","
cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & "," & Noches & ","
cs=cs & replace(importe,",",".") & "," & replace(PrePago,",",".") & ",0,'" & obs & "','"
cs=cs & lang & "','','','',"
cs=cs & FechaMySQL(date) & "," & idagencia & ",0,'" & codigoVIP & "'," & tipoventa & ")"
'response.write cs
base.execute cs

'Buscar la ultima reserva creada
cs="SELECT MAX(cod_res) as ultima FROM " & precrs & "Reservas"
rs.open cs,base
if not rs.eof then
	codres=rs("ultima")
end if
rs.close		

'Comprobar las ofertas
if codiOfertas<>"" then
	listaOfertas=split(codiOfertas,"-")
	pelaOfertas=split(sumaOfertas,"-")
	for r=0 to ubound(listaOfertas)
		if trim(listaOfertas(r))<>"" then 'hay codigo
			pelillas=paDbl(pelaOfertas(r))
			cs="INSERT INTO " & precrs & "OfertasReserva (IdOferta,IdReserva,Importe)	VALUES ("
			cs=cs & listaOfertas(r) & "," & codres & "," & quitarComa(pelillas) & ")"
			base.execute cs
		end if
	next 'r

end if 'codiOfertas<>""

%>
<% ' !--#include file="RecogeHabis.asp"-- %>
<%
Dim strSel
strSel = Split(strSeleccion, "###")
Dim iLin
iLin = 0
Dim codTipHab
codTipHab = ""
Dim precioTotal
precioTotal = 0

Dim estadoHab
estadoHab = 0

dim habisArr(),adultosArr(),bebesArr(),ninos1Arr()
dim codsuplesArr(),HImporteArr()
dim colecadultosArr(),colecninos1Arr()

dim IdOferta(),NomOferta(),PelasOferta()

Dim nh
nh = 0
For Each linea In strSel
	nh = nh + 1
	iLin = iLin + 1
	Dim strLineaArrB
	strLineaArrB = Split(linea, " / ")
	Dim strLineaArrG
	strLineaArrG = Split(Replace(strLineaArrB(0) & strLineaArrB(2), " -  - ", " - "), " - ")
	Dim codHotLinea
	codHotLinea = strLineaArrG(0)
	Dim codHabLinea
	codHabLinea = strLineaArrG(1)
	Dim codRegLinea
	codRegLinea = strLineaArrG(2)
	Dim persoLinea
	persoLinea = Split(strLineaArrB(1), " - ")
	Dim adultosLinea
	adultosLinea = Replace(Replace(persoLinea(0), " ad: ", "")," ", "")
	Dim ninosLinea
	ninosLinea = Replace(Replace(persoLinea(1), " ni: ", "")," ", "")
	Dim bebesLinea
	bebesLinea = Replace(Replace(persoLinea(2), " be: ", "")," ", "")
	estadoHab = Replace(strLineaArrG(3), " " , "")
	If estadoHab <> 0 Then
		If estadoHabs <> 1 Then
			estadoHabs = estadoHab
		End If
		
		parametros="precioHabitacion.asp?ide="&idCR&"&est=" & idh & "&lang=" & lang & "&fini=" & fini & "&ffin=" & ffin
		parametros=parametros & "&codhab=" & th & "&ad=" & adultos & "&ni1=" & ninos1
		parametros=parametros & "&ni2=0&idregi=" & tr & "&codigovip=" & session("codigovip") '"&idregi=" & tr
		'response.write "<a href=""" &rutaCRS & parametros & """>Link</a><br />"
				
		nofer=-1
		
		Set objDom = Server.CreateObject("Microsoft.XMLDOM")
		objDom.async = false
		objDom.validateOnParse = false
		objDom.setProperty "ServerHTTPRequest", true
		if objDom.Load(rutaCRS & parametros) then		
			For Each objItem in objDom.documentElement.SelectNodes("/data")
				monedaHotel=objItem.SelectSingleNode("moneda").text
				total=objItem.SelectSingleNode("totalbruto").text
				if isnumeric(total) then
					laspelas=cdbl(total)
				end if
				estado=objItem.SelectSingleNode("estadohabitacion").text
				release=paClng(objItem.SelectSingleNode("release").text)
				diasminimos=paClng(objItem.SelectSingleNode("diasminimos").text)
				'mirar oferta
				sumaOfertas=0
				on error resume next
				For Each ojete in objDom.documentElement.SelectNodes("/data/oferta")
					nofer=nofer+1
					redim preserve IdOferta(nofer)
					redim preserve NomOferta(nofer)
					redim preserve PelasOferta(nofer)
					pelillas=paDbl(ojete.SelectSingleNode("totaloferta").text)
					sumaOfertas=sumaOfertas+pelillas
					IdOferta(nofer)=ojete.SelectSingleNode("codioferta").text
					NomOferta(nofer)=ojete.SelectSingleNode("textooferta").text
					PelasOferta(nofer)=pelillas
				next 'las ofertas
				on error goto 0
			next 'each
		end if	
		
		redim preserve habisArr(nh)
		redim preserve cuantashArr(nh)
		redim preserve adultosArr(nh)
		redim preserve bebesArr(nh)
		redim preserve ninos1Arr(nh)
		redim preserve codsuplesArr(nh)
		redim preserve colecadultosArr(nh)
		redim preserve colecninos1Arr(nh)
		redim preserve HImporteArr(nh)	
	
		'Buscar los datos
		codigohab=paClng(codHabLinea)
		habisArr(nh)=codigohab
		adultosArr(nh)=paClng(adultosLinea)
		bebesArr(nh)=paClng(bebesLinea)
		ninos1Arr(nh)=paClng(ninosLinea)
		codsuplesArr(nh)=codRegLinea
		HImporteArr(nh)=laspelas-sumaOfertas
	End If
Next
'Añadir los datos a la tabla TipoReserva
for h=1 to ubound(habisArr)

	'Insertar los datos
	cs="INSERT INTO " & precrs & "TipoReserva (IdReserva,IdTipoHabitacion,CodigoEsta,CuantasHabis,"
	cs=cs & "FechaInicio,FechaFinal,FechaReserva,NumAdultos,NumBebes,NumNinos1,NumNinos2,Suplementos,Importe) VALUES ("
	cs=cs & codres & "," & habisArr(h) & "," & est & ",1,"
	cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
	cs=cs & FechaMySQL(date) & ","
	cs=cs & adultosArr(h) & "," & bebesArr(h) & "," 
	cs=cs & ninos1Arr(h) & ",0,'" & codsuplesArr(h) & "'," & quitarComa(HImporteArr(h)) & ")"
	
	'response.write "TReserva: " & cs & "<br>"
	'response.End()
	base.execute cs
next

'comprobar si es cliente VIP
if codigoVIP<>"" And codigoVIP <> "0" then 'actualiza ficha

	cs="UPDATE " & precrs & "Fichas SET Apellidos='" & apellidos & "',"
	cs=cs & "Nombre='" & nombre & "',"
	cs=cs & "Telefono='" & telefono & "',"
	cs=cs & "Fax='" & fax & "',"
	cs=cs & "Direccion='" & direccion & "',"
	cs=cs & "EMail='" & email & "',"
	cs=cs & "CP='" & cp & "',"
	cs=cs & "Poblacion='" & poblacion & "',"
	cs=cs & "Provincia='" & provincia & "',"
	cs=cs & "Pais='" & codpais & "',"
	cs=cs & "NombrePais='" & pais & "',"
	cs=cs & "FechaLlegada=" & FechaMySQL(FLlegada) & ","
	cs=cs & "FechaSalida=" & FechaMySQL(FSalida) & ","
	cs=cs & "FechaAlta=" & FechaMySQL(date) & ","
	cs=cs & "Hotel=" & est & ","
	cs=cs & "CodReserva=" & codres & ","
	cs=cs & "Servicios='" & servicios & "',"
	cs=cs & "IdiomaWeb='" & lang & "',"
	cs=cs & "Informacion=0, "
	cs=cs & "Tratamiento="&tratamiento
	cs=cs & " WHERE CodigoVIP='" & codigoVIP & "'"
	base.execute cs
	
	'Busca la id de la ficha
	cs="SELECT Id FROM " & precrs & "Fichas WHERE CodigoVIP='" & codigoVIP & "'"
	rs.open cs,base
	if not rs.eof then 'Ya existe ese email
		esaId=rs("Id")
	end if
	rs.close

else 'resto de casos

'	if repite_email<>0 or repiteMail then 'siempre crear ficha, se puede repetir email
'		
'		'Añadir los datos personales la ficha recepcionista
'		cs="INSERT INTO Fichas (Apellidos,Nombre,Telefono,Fax,Direccion,cp,Poblacion,Provincia,NombrePais,"
'		cs=cs & "EMail,FechaLlegada,FechaSalida,FechaAlta,Hotel,CodReserva,Servicios,IdiomaWeb,"
'		cs=cs & "Informacion,Confirmado) VALUES ('" & apellidos& "','" & nombre & "','"
'		cs=cs & telefono & "','" & fax & "','" & direccion & "','" & cp & "','" & poblacion & "','"
'		cs=cs & provincia & "','" & pais & "','" & email & "',"
'		cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
'		cs=cs & FechaMySQL(date) & ","
'		cs=cs & est & "," & codres & ",'"
'		cs=cs & servicios & "','" & lang & "'," & info & "," & confirmada & ")"
'		'response.write "ficha: " & cs & "<br>"
'		base.execute cs
'		'Buscar la Ult. Id
'		cs="SELECT MAX(Id) as Ultima FROM Fichas"
'		rs.open cs,base
'		if not rs.eof then
'			esaId=paClng(rs("Ultima"))
'		end if
'		rs.close
'	
'	else 'comprobar email

		'Comprobar que no exista ese email
		cs="SELECT Id FROM " & precrs & "Fichas WHERE EMail='" & email & "'"
		rs.open cs,base
		if not rs.eof and email<>"" then 'Ya existe ese email
			esaId=rs("Id")
			rs.close
			'Actualizar
			cs="UPDATE " & precrs & "Fichas SET Apellidos='" & apellidos & "',"
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Telefono='" & telefono & "',"
			cs=cs & "Fax='',"
			cs=cs & "Direccion='',"
			cs=cs & "CP='',"
			cs=cs & "Poblacion='',"
			cs=cs & "Provincia='',"
			cs=cs & "Pais='" & codpais & "',"
			cs=cs & "NombrePais='" & pais & "',"
			cs=cs & "FechaLlegada=" & FechaMySQL(FLlegada) & ","
			cs=cs & "FechaSalida=" & FechaMySQL(FSalida) & ","
			cs=cs & "FechaAlta=" & FechaMySQL(date) & ","
			cs=cs & "Hotel=" & est & ","
			cs=cs & "CodReserva=" & codres & ","
			cs=cs & "Servicios='',"
			cs=cs & "IdiomaWeb='" & lang & "',"
			cs=cs & "Informacion=0,"
			cs=cs & "Confirmado=0, "
			cs=cs & "Tratamiento="&tratamiento
			cs=cs & " WHERE Id=" & esaId
			'response.write cs
			base.execute cs
		
		else 'insertar
			rs.close
			'Añadir los datos personales la ficha recepcionista
			cs="INSERT INTO " & precrs & "Fichas (Apellidos,Nombre,Telefono,Fax,Direccion,cp,Poblacion,Provincia,Pais,NombrePais,"
			cs=cs & "EMail,FechaLlegada,FechaSalida,FechaAlta,Hotel,CodReserva,Servicios,IdiomaWeb,"
			cs=cs & "Informacion,Confirmado,Tratamiento) VALUES ('" & apellidos& "','" & nombre & "','"
			cs=cs & telefono & "','','','','','"
			cs=cs & "','" & codpais & "','" & pais & "','" & email & "',"
			cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
			cs=cs & FechaMySQL(date) & ","
			cs=cs & est & "," & codres & ",'"
			cs=cs & "','" & lang & "',0," & confirmada & ","&tratamiento&")"
			'response.write "ficha: " & cs & "<br>"
			base.execute cs
			'Buscar la Ult. Id
			cs="SELECT MAX(Id) as Ultima FROM " & precrs & "Fichas"
			rs.open cs,base
			if not rs.eof then
				esaId=paClng(rs("Ultima"))
			end if
			rs.close
			
		end if 'eof
		
'	end if 'repite_email

end if 'codigoVIP<>''

'actualizar la reserva con la ficha cliente
cs="UPDATE Reservas SET IdCliente=" & esaId & " WHERE cod_res=" & codres
base.execute cs

'datos hotel
cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,PID,PID2 "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel ON "
cs=cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta WHERE DatosHotel.CodigoEsta=" & est
rs.Open cs, base
if not rs.eof then
	'Variables para la tabla RegHoteles
	nhotel="" & rs("Nombre")
	estado=paClng(rs("estado"))
	categoria=rs("categoria")
	PID=rs("PID")
	PID2=rs("PID2")
end if
rs.close


set rs=nothing
base.close
set base=nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
response.write "<hotel>" & server.HTMLEncode(nhotel) & "</hotel>" & vbcrlf
response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
response.write "<zona>" & zona & "</zona>" & vbcrlf
response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
response.write "<estado>" & estado & "</estado>" & vbcrlf
response.write "<codres>" & codres & "</codres>" & vbcrlf
response.write "<prepago>" & PrePago & "</prepago>" & vbcrlf
response.write "<totalreserva>" & importe & "</totalreserva>" & vbcrlf
response.write "<pid>" & pid & "</pid>" & vbcrlf
response.write "<clave>" & pid2& "</clave>" & vbcrlf
response.write "</data>"
%>