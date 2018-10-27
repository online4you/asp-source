<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.QueryString("est"))
FLlegada=cdate(request.Querystring("fini"))
FSalida=cdate(request.Querystring("ffin"))

NHotel=request.Querystring("nhotel") 'nombre hotel
Noches=FSalida-FLlegada

'Datos cliente de la reserva
nombre=QuitarApos(request.Querystring("nom"))
apellidos=QuitarApos(request.Querystring("ape"))
direccion=QuitarApos(request.Querystring("dir"))
cp=QuitarApos(request.Querystring("cp"))
poblacion=QuitarApos(request.Querystring("loc"))
provincia=QuitarApos(request.Querystring("prov"))
pais=QuitarApos(request.Querystring("pais"))
telefono=QuitarApos(request.Querystring("tel"))
movil=QuitarApos(request.Querystring("telmovil"))
hllegada=QuitarApos(request.Querystring("hllegada"))
fax=QuitarApos(request.Querystring("fax"))
email=QuitarApos(request.Querystring("email"))
observaciones=QuitarApos(request.Querystring("com"))
importe=paDbl(request.Querystring("totalres"))
PrePago=paDbl(request.Querystring("prepago"))
bruto=paDbl(request.Querystring("bruto"))
codiofertas=request.Querystring("codiofertas")
sumaofertas=request.Querystring("sumaofertas")
lang=request.Querystring("lang")
tipoventa=paClng(request.Querystring("tv"))
codigoVIP=request.Querystring("codigovip")
confirmada=paClng(request.Querystring("confirmada"))
repite_email=paClng(request.Querystring("remail"))
nifcliente = QuitarApos(request.Querystring("nifcliente"))

info=request.Querystring("informacion")
if info="" then info="0"
servicios=request.Querystring("servicios")

'Agencia
idagencia=paClng(request.Querystring("idage"))
if idagencia<>0 then repiteMail=true
fpago=paClng(request.Querystring("fpago"))


'Crear la reserva
cs="INSERT INTO " & precrs & "Reservas (CodigoEsta,FechaIni,FechaFin,NumDias,Importe,ImportePag,"
cs=cs & "Activa,Comentarios,Idi,Servicios,CodOferta,PelasOferta,FechaReserva,CodAgencia,TipoVentaAgencia,"
cs=cs & "CodigoVIP,TipoVenta,HoraLlegada, nifcliente) VALUES (" & est & ","
cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & "," & noches & ","
cs=cs & replace(importe,",",".") & "," & replace(PrePago,",",".") & "," & confirmada & ",'" & observaciones & "','"
cs=cs & lang & "','" & servicios & "','" & codiofertas & "','" & sumaofertas & "',"
cs=cs & FechaMySQL(date) & "," & idagencia & "," & fpago & ",'" & codigoVIP & "',"
cs=cs & tipoventa & ",'" & hllegada & "','" & nifcliente & "')"
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

%><!--#include file="RecogeHabis.asp"--><%

'Añadir los datos a la tabla TipoReserva
for h=1 to ubound(habis)

	'Insertar los datos
	cs="INSERT INTO " & precrs & "TipoReserva (IdReserva,IdTipoHabitacion,CodigoEsta,CuantasHabis,"
	cs=cs & "FechaInicio,FechaFinal,FechaReserva,NumAdultos,NumBebes,NumNinos1,NumNinos2,Suplementos,Importe) VALUES ("
	cs=cs & codres & "," & habis(h) & "," & est & ",1,"
	cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
	cs=cs & FechaMySQL(date) & ","
	cs=cs & adultos(h) & "," & bebes(h) & "," 
	cs=cs & ninos1(h) & "," & ninos2(h) & ",'" & codsuples(h) & "'," & quitarComa(HImporte(h)) & ")"
	
	'response.write "TReserva: " & cs & "<br>"
	'response.End()
	base.execute cs
next

'comprobar si es cliente VIP
if codigoVIP<>"" then 'actualiza ficha

	cs="UPDATE " & precrs & "Fichas SET Apellidos='" & apellidos & "',"
	cs=cs & "Nombre='" & nombre & "',"
	cs=cs & "Telefono='" & telefono & "',"
	cs=cs & "Fax='" & fax & "',"
	cs=cs & "Direccion='" & direccion & "',"
	cs=cs & "EMail='" & email & "',"
	cs=cs & "CP='" & cp & "',"
	cs=cs & "Poblacion='" & poblacion & "',"
	cs=cs & "Provincia='" & provincia & "',"
	cs=cs & "NombrePais='" & pais & "',"
	cs=cs & "FechaLlegada=" & FechaMySQL(FLlegada) & ","
	cs=cs & "FechaSalida=" & FechaMySQL(FSalida) & ","
	cs=cs & "FechaAlta=" & FechaMySQL(date) & ","
	cs=cs & "Hotel=" & est & ","
	cs=cs & "CodReserva=" & codres & ","
	cs=cs & "Servicios='" & servicios & "',"
	cs=cs & "IdiomaWeb='" & lang & "',"
	cs=cs & "Informacion=" & info & " "
	cs=cs & "WHERE CodigoVIP='" & codigoVIP & "'"
	base.execute cs
	
	'Busca la id de la ficha
	cs="SELECT Id FROM " & precrs & "Fichas WHERE CodigoVIP='" & codigoVIP & "'"
	rs.open cs,base
	if not rs.eof then 'Ya existe ese email
		esaId=rs("Id")
	end if
	rs.close

else 'resto de casos
    repite_email = 1
	if repite_email<>0 or repiteMail then 'siempre crear ficha, se puede repetir email
		
		'Añadir los datos personales la ficha recepcionista
		cs="INSERT INTO " & precrs & "Fichas (Apellidos,Nombre,Telefono,Fax,Direccion,cp,Poblacion,Provincia,NombrePais,"
		cs=cs & "EMail,FechaLlegada,FechaSalida,FechaAlta,Hotel,CodReserva,Servicios,IdiomaWeb,"
		cs=cs & "Informacion,Confirmado) VALUES ('" & apellidos& "','" & nombre & "','"
		cs=cs & telefono & "','" & fax & "','" & direccion & "','" & cp & "','" & poblacion & "','"
		cs=cs & provincia & "','" & pais & "','" & email & "',"
		cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
		cs=cs & FechaMySQL(date) & ","
		cs=cs & est & "," & codres & ",'"
		cs=cs & servicios & "','" & lang & "'," & info & "," & confirmada & ")"
		'response.write "ficha: " & cs & "<br>"
		base.execute cs
		'Buscar la Ult. Id
		cs="SELECT MAX(Id) as Ultima FROM " & precrs & "Fichas"
		rs.open cs,base
		if not rs.eof then
			esaId=paClng(rs("Ultima"))
		end if
		rs.close
	
	else 'comprobar email

		'Comprobar que no exista ese email
		cs="SELECT Id FROM " & precrs & "Fichas WHERE EMail='" & email & "'"
		rs.open cs,base
		if not rs.eof and email<>"" then 'Ya existe ese email
			esaId=rs("Id")
			rs.close
			'Actualizar
			cs="UPDATE Fichas SET Apellidos='" & apellidos & "',"
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Telefono='" & telefono & "',"
			cs=cs & "Fax='" & fax & "',"
			cs=cs & "Direccion='" & direccion & "',"
			cs=cs & "CP='" & cp & "',"
			cs=cs & "Poblacion='" & poblacion & "',"
			cs=cs & "Provincia='" & provincia & "',"
			cs=cs & "NombrePais='" & pais & "',"
			cs=cs & "FechaLlegada=" & FechaMySQL(FLlegada) & ","
			cs=cs & "FechaSalida=" & FechaMySQL(FSalida) & ","
			cs=cs & "FechaAlta=" & FechaMySQL(date) & ","
			cs=cs & "Hotel=" & est & ","
			cs=cs & "CodReserva=" & codres & ","
			cs=cs & "Servicios='" & servicios & "',"
			cs=cs & "IdiomaWeb='" & lang & "',"
			cs=cs & "Informacion=" & info & ","
			cs=cs & "Confirmado=0 WHERE Id=" & esaId
			'response.write cs
			base.execute cs
		
		else 'insertar
			rs.close
			'Añadir los datos personales la ficha recepcionista
			cs="INSERT INTO " & precrs & "Fichas (Apellidos,Nombre,Telefono,Fax,Direccion,cp,Poblacion,Provincia,NombrePais,"
			cs=cs & "EMail,FechaLlegada,FechaSalida,FechaAlta,Hotel,CodReserva,Servicios,IdiomaWeb,"
			cs=cs & "Informacion,Confirmado) VALUES ('" & apellidos& "','" & nombre & "','"
			cs=cs & telefono & "','" & fax & "','" & direccion & "','" & cp & "','" & poblacion & "','"
			cs=cs & provincia & "','" & pais & "','" & email & "',"
			cs=cs & FechaMySQL(FLlegada) & "," & FechaMySQL(FSalida) & ","
			cs=cs & FechaMySQL(date) & ","
			cs=cs & est & "," & codres & ",'"
			cs=cs & servicios & "','" & lang & "'," & info & "," & confirmada & ")"
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
		
	end if 'repite_email

end if 'codigoVIP<>''

'actualizar la reserva con la ficha cliente
cs="UPDATE " & precrs & "Reservas SET IdCliente=" & esaId & " WHERE cod_res=" & codres
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
response.write "<prepago>" & prepago & "</prepago>" & vbcrlf
response.write "<totalreserva>" & importe & "</totalreserva>" & vbcrlf
response.write "<pid>" & pid & "</pid>" & vbcrlf
response.write "<clave>" & pid2& "</clave>" & vbcrlf
response.write "</data>"
%>