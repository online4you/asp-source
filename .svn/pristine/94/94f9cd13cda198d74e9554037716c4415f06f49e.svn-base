<%tipoVenta=1 'onrequest
Fpago=0
'comprobar que no venga de otro sitio
servidor=lcase("" & request.ServerVariables("HTTP_REFERER"))
if instr(servidor,"booking.kubikcrs.com")=0 then 'se estan colando
	response.write "Operacion no autorizada"
	response.End()	
end if

%>
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<!--#include file="CR_recogeHabis.asp"-->
<!--#include file="CR_GrabaDatosBD.asp"-->
<!--#include file="CR_extrasHotel.asp"-->
<!--#include file="includes/constantes.asp"-->
  
<%

if codres<>0 then 'mirar los servicios extras
	set base=server.createobject("ADODB.Connection")
	base.Open Conecta
	
	anteservi=0
	if hayServis then
	for s=0 to ubound(RegServis,2)
		if anteservi<>RegServis(SCodi,s) then
			linea=0
		else
			linea=linea+1
		end if
		'Comprobar si esta marcado
		if request.form("servi_" & RegServis(SCodi,s) & "_" & linea)="1" then 'está marcado
			cantidad=paClng(request.form("cuantos_" & RegServis(SCodi,s) & "_" & linea))
			'response.write cantidad & " " & RegServis(SNombre,s) & "<br>"
			if cantidad>0 then 
				cs="INSERT INTO ReservaServicio (CodReserva,IdServicio,Cuantas,Pelas,Tarifa,IdColectivo) VALUES ("
				cs=cs & codres & "," & RegServis(SCodi,s) & "," & cantidad
				cs=cs & "," & quitarComa(RegServis(SPelas,s)) & ",1," & RegServis(SCColec,s) & ")"
				base.execute cs
			end if 'cantidad>0
		end if
	
		anteservi=RegServis(SCodi,s)
	next 's
	end if 'hayServis


	'grabar si tiene ofertas de reserva
	codioferta=split(request.form("codiofertas"),"-")
	sumaoferta=split(request.form("sumaofertas"),"-")
	for o=0 to ubound(codioferta)
		if trim(codioferta(o))<>"" then
			cs="INSERT INTO OfertasReserva (IdOferta,IdReserva,Importe) VALUES ("
			cs=cs & codioferta(o) & "," & codres & "," & quitarComa(sumaoferta(o)) & ")"
			base.execute cs
		end if
	next 'o
	



end if 'codres<>0
	
 
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
 
'if request.Form<>"" then 'enviar datos para comprobacion
'   mensaje="<p>" & request.form & "</p>"
'   response.Write codres&"---"&REMITENTE&"---"&mensaje
'   errorcorreo=sendEmailTo "martin@planeta-web.com","Datos Form Peticion " & REMITENTE,mensaje
'end if

 
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Buscar codigo del hotel
cs="SELECT Reservas.CodigoEsta,Establecimientos.Nombre,FechaIni,FechaFin,NumDias,Servicios,"
cs=cs & "Importe,ImportePag,Comentarios,Idi,PelasOferta,IdCliente,Moneda "
cs=cs & "FROM Reservas INNER JOIN Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE cod_res=" & codres

rs.open cs,base
hayhotel=false
if not rs.eof then
	est=rs("codigoesta")
	hnombre=rs("nombre")
	FIni=VerFecha(rs("fechaini"))
	FFin=VerFecha(rs("fechafin"))
	ndias=rs("numdias")
	servis=rs("servicios")
	pelas=rs("importe")
	pagado=rs("importepag")
	dtooferta=paDbl(rs("pelasOferta"))
	obs=rs("comentarios")
	lang=rs("Idi")
	idcliente=rs("idcliente")
	moneda=paClng(rs("moneda"))
	select case moneda
		case 0 'euros
			textomoneda="&euro;"
		case 1 'dolares
			textomoneda="$"
		case 2 'libras
			textomoneda="&pound;"
	end select
	hayhotel=true
end if
rs.close

if hayhotel then 'Buscar el resto de datos
	'Datos del Cliente
	cs="SELECT * FROM Fichas WHERE Id=" & IdCliente
	rs.open cs,base
	if not rs.eof then
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		pais=rs("Nombrepais")
		telefono=rs("telefono")
		fax=rs("fax")
		email=rs("email")
	end if
	rs.close
	
	'Buscar datos del hotel
	cs="SELECT Direccion,CP,Poblacion,Telefono,Fax,EMail FROM DatosHotel "
	cs=cs & "WHERE CodigoEsta=" & est
	rs.open cs,base
	if not rs.eof then
		hdire=rs("direccion")
		hcp=rs("cp")
		hpobla=rs("poblacion")
		htele=rs("telefono")
		hfax=rs("fax")
		mailHotel=rs("email")
	end if
	rs.close

		dim otravez,intercambio
		'dim CuantasH(),NombreH(),SupleH()		
		dim CuantasH(),SupleH()			
		dim tadultos(),tninos1(),tninos2(),tbebes()

		set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		'Abrir fichero plantilla
		set oFichero = FSO.OpenTextFile(server.MapPath("/plantillasCorreo/correoReserva_"& idEmpresa &".html")) 
		plantilla= oFichero.ReadAll  'Paso los datos a una variable
		'Cerrar el fichero
		oFichero.close
		set oFichero=nothing
		set FSO=nothing

		'Condiciones hotel
		cs="SELECT ISNULL(dbo.fnGetTraduccion('CondicionesHotel','Texto',CodigoEsta,'" & lang & "'),Texto) AS Tradu "
		cs=cs & "FROM CondicionesHotel "
		cs=cs & "WHERE CodigoEsta=" & est
		'response.write cs
		rs.open cs,base
		if not rs.eof then
			condicionesHotel="" & rs("tradu")
		end if
		rs.close

		'Buscar nombres de colectivos
		cs="SELECT CodigoColec,ISNULL(dbo.fnGetTraduccion('Colectivos','Nombre',CodigoColec,'" & lang & "'),Nombre) AS Tradu "
		cs=cs & "FROM Colectivos "
		cs=cs & "WHERE CodigoEsta=" & est
		cs=cs & " ORDER BY orde"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			CColec=0
			NColec=1
		end if
		rs.close

		'Suplementos del hotel
		cs="SELECT Id,ISNULL(dbo.fnGetTraduccion('Regimen','Nombre',Id,'" & lang & "'),Nombre) AS Tradu "
		cs=cs & "FROM Regimen ORDER BY Id"
		haysuples=false
		rs.open cs,base
		if not rs.eof then
			RegSuples=rs.getrows
			SCodi=0
			SNombre=1
			haysuples=true
		end if
		rs.close
		
		'Nombre habitaciones y cuantas
		cs="SELECT NumAdultos,NumBebes,NumNinos1,NumNinos2,Suplementos,"
		cs=cs & "ISNULL(dbo.fnGetTraduccion('TipoHabitaNombres','Nombre',TipoHabitaNombres.Id,'" & lang & "'),Nombre) AS Tradu,Importe "
		cs=cs & "FROM TipoReserva INNER JOIN TipoHabitaNombres "
		cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id "
		cs=cs & "WHERE IdReserva=" & codres
		rs.open cs,base
		numhabis=0
		do while not rs.eof 
			numhabis=numhabis+1
			redim preserve nombreh(numhabis)
			redim preserve Supleh(numhabis)
			nombreh(numhabis)=rs("tradu")
			
			redim preserve tadultos(numhabis)
			redim preserve tninos1(numhabis)
			redim preserve tninos2(numhabis)
			redim preserve tbebes(numhabis)
			tadultos(numhabis)=rs("NumAdultos")
			tbebes(numhabis)=rs("NumBebes")
			tninos1(numhabis)=rs("NumNinos1")
			tninos2(numhabis)=rs("NumNinos2")
			
			'Buscar nomnbre suplementos
			suples=rs("suplementos")
			if suples<>"" then
				TSuples=split(suples,";")
				for s=0 to ubound(TSuples)
					if TSuples(s)<>"" then
						Supleh(numhabis)=TSuples(s)
					end if
				next 
			end if
			
			rs.movenext
		loop
		rs.close

		objIdioma.cargaIdioma(lang)

		texto=plantilla 'plantilla del voucher
		texto=Replace(texto, "Vte=lang",lang) 
		texto=Replace(texto, "Vte=LOGOHOTEL", idempresa)
		texto=Replace(texto, "Vte=codres",objIdioma.getTraduccionHTML("i_FormuPeti") & " " & codres) 
		'datos hotel
		texto=Replace(texto, "Vte=datoshotel",ucase(objIdioma.getTraduccionHTML("i_Vdatoshotel"))) 
		texto=Replace(texto, "Vte=nombrehotel",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & hnombre) 
		texto=Replace(texto, "Vte=direhotel",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & hdire) 
		texto=Replace(texto, "Vte=poblahotel",objIdioma.getTraduccionHTML("i_provincia") & ":&nbsp;" & hpobla) 
		texto=Replace(texto, "Vte=telehotel",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & htele) 
		texto=Replace(texto, "Vte=emailhotel","<a href='mailto:" & mailhotel & "'>" & mailhotel & "</a>") 
		
		'Datos petición
		texto=Replace(texto, "Vte=datosreserva",ucase(objIdioma.getTraduccionHTML("i_datosresPeticion"))) 
		texto=Replace(texto, "Vte=codigoreserva",objIdioma.getTraduccionHTML("i_codPeticio") & ":&nbsp;" & codres) 
		texto=Replace(texto, "Vte=fechallegada",objIdioma.getTraduccionHTML("i_fllegada") & ":&nbsp;" & fini) 
		texto=Replace(texto, "Vte=fechasalida",objIdioma.getTraduccionHTML("i_fsalida") & ":&nbsp;" & ffin) 
		texto=Replace(texto, "Vte=noches",objIdioma.getTraduccionHTML("i_noches") & ":&nbsp;" & ndias) 
		'habitaciones
		textohab=""
		if numhabis<>0 then
			for h=1 to numhabis
				textohab=textohab & "<b>" & objIdioma.getTraduccionHTML("i_datoshab") & "</b><br/>"
				textohab=textohab & " - " & nombreh(h)
				hay=false
				if haysuples then
					for s=0 to ubound(RegSuples,2)
						if RegSuples(SCodi,s)=clng(supleh(h)) then
							 textohab=textohab & "  - " & RegSuples(SNombre,s) & "<br/>"
							 hay=true
						end if
					next
				end if
				if not hay then textohab=textohab & "<br/>"
				if tadultos(h)<>0 then textohab=textohab & objIdioma.getTraduccionHTML("i_adultos") &RegColec(NColec,0) & ":" & tadultos(h) & vbcrlf
				if tbebes(h)<>0 then textohab=textohab & " - " & objIdioma.getTraduccionHTML("i_bebes") & ":" & tbebes(h) & vbcrlf
				if tninos1(h)<>0 then textohab=textohab & " - " & RegColec(NColec,1) & ":" & tninos1(h) & vbcrlf
				if tninos2(h)<>0 then textohab=textohab & " - " & RegColec(NColec,2) & ":" & tninos2(h) & vbcrlf
				textohab=textohab & "<br/><br/>"
			next
		end if
		texto=Replace(texto, "Vte=habitaciones",textohab) 
		
		texto=Replace(texto, "Vte=precio",objIdioma.getTraduccionHTML("i_total") & ":&nbsp;<b>" & formatnumber(pelas,2) & "&nbsp;" & textoMoneda & "</b>")

		'Datos personales
		texto=Replace(texto, "Vte=datospersonales",ucase(objIdioma.getTraduccionHTML("i_datos"))) 
		texto=Replace(texto, "Vte=nombrecliente",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & apellidos & ", " & nombre) 
		texto=Replace(texto, "Vte=direcliente",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & direccion) 
		texto=Replace(texto, "Vte=poblacliente",objIdioma.getTraduccionHTML("i_localidad") & ":&nbsp;" & poblacion) 
		texto=Replace(texto, "Vte=provicliente",objIdioma.getTraduccionHTML("i_provincia") & ":&nbsp;" & provincia) 
		texto=Replace(texto, "Vte=paiscliente",objIdioma.getTraduccionHTML("i_pais") & ":&nbsp;" & pais) 
		texto=Replace(texto, "Vte=telefonocliente",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & telefono) 
		texto=Replace(texto, "Vte=emailcliente",objIdioma.getTraduccionHTML("i_email") & ":&nbsp;" & email)
		texto=Replace(texto, "Vte=obscliente",objIdioma.getTraduccionHTML("i_observaciones") & ":&nbsp;" & obs)
		if condicionesHotel<>"" then
			texto=Replace(texto, "Vte=condiciones",objIdioma.getTraduccionHTML("i_condiciones") & ":&nbsp;" & condicionesHotel)
		else
			texto=Replace(texto, "Vte=condiciones","")
		end if
			
		correocli=texto
		correopro=texto
	
	'Email para el cliente
	errorcorreo=sendEmailTo(email,objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre,mailHotel,correocli,"")

	'Email para el hotel
	errorcorreo=sendEmailTo(mailhotel,objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre,email,correopro,"")
 		
	'Copia de email
 	errorcorreo=sendEmailTo("gisela@planeta-web.com",objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre ,email,correopro,"")
 	if errorcorreo <> "" then
		response.write errorcorreo
	end if
	'response.write correopro
 
end if 'hayhotel


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
<link href="css/iframe.css" rel="stylesheet" type="text/css" />
<link href="css/iframe_<%=idEmpresa%>.css" rel="stylesheet" type="text/css" />
</head>
<body>
 
<div id='principalFrame'>
     <div id='frameCabecera'>
 		  <div class="texto">  
               <%=objIdioma.getTraduccionHTML("i_graciascontacto")%>
 		  </div>
      </div>  
</div>  
 
</body>
</html>
<%
set objIdioma=nothing
set rs=nothing
base.close
set base=nothing

%>
