<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<%
'la ide se recoge en datosempresa.asp (idempresa)
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

result=paClng(Request.QueryString("result"))
codres=Request.QueryString("pszPurchorderNum")
fecha=Request.QueryString("pszTxnDate")
tipotrans=Request.QueryString("tipotrans")
store=Request.QueryString("store")
lang=Request.QueryString("lang")
n_auto=Request.QueryString("pszApprovalCode")
referencia=Request.QueryString("pszTxnID")

if request.Form<>"" then 'enviar datos para comprobacion
	mensaje="<p>" & request.querystring & "</p>"
	sendPEMail "gisela@planeta-web.com","Datos 4B Form Reserva " & codres,REMITENTE,mensaje,""
end if

if result=0 then

	set base=server.createobject("ADODB.Connection")
	base.Open Conecta
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
			texto=Replace(texto, "Vte=codres",objIdioma.getTraduccionHTML("i_codres") & " " & codres) 
			'datos hotel
			texto=Replace(texto, "Vte=datoshotel",ucase(objIdioma.getTraduccionHTML("i_Vdatoshotel"))) 
			texto=Replace(texto, "Vte=nombrehotel",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & hnombre) 
			texto=Replace(texto, "Vte=direhotel",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & hdire) 
			texto=Replace(texto, "Vte=poblahotel",objIdioma.getTraduccionHTML("i_provincia") & ":&nbsp;" & hpobla) 
			texto=Replace(texto, "Vte=telehotel",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & htele) 
			texto=Replace(texto, "Vte=emailhotel","<a href='mailto:" & mailhotel & "'>" & mailhotel & "</a>") 
			
			'Datos Reserva
			texto=Replace(texto, "Vte=datosreserva",ucase(objIdioma.getTraduccionHTML("i_datosres"))) 
			texto=Replace(texto, "Vte=codigoreserva",objIdioma.getTraduccionHTML("i_codres") & ":&nbsp;" & codres) 
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
					if tadultos(h)<>0 then textohab=textohab & RegColec(NColec,0) & ":" & tadultos(h) & vbcrlf
					if tbebes(h)<>0 then textohab=textohab & " - " & objIdioma.getTraduccionHTML("i_bebes") & ":" & tbebes(h) & vbcrlf
					if tninos1(h)<>0 then textohab=textohab & " - " & RegColec(NColec,1) & ":" & tninos1(h) & vbcrlf
					if tninos2(h)<>0 then textohab=textohab & " - " & RegColec(NColec,2) & ":" & tninos2(h) & vbcrlf
					textohab=textohab & "<br/><br/>"
				next
			end if
			texto=Replace(texto, "Vte=habitaciones",textohab) 
			
			texto=Replace(texto, "Vte=precio",objIdioma.getTraduccionHTML("i_total") & ":&nbsp;<b>" & formatnumber(pelas,2) & "&nbsp;" & textoMoneda & "</b>")
			texto=Replace(texto, "Vte=pagado",objIdioma.getTraduccionHTML("i_prepago") & ":&nbsp;<b>" & formatnumber(pagado,2) & "&nbsp;" & textoMoneda & "</b>")
			pagoenhotel=pelas - pagado
			texto=Replace(texto, "Vte=pagarhotel",objIdioma.getTraduccionHTML("i_pagoenhotel") & ":&nbsp;<b>" & formatnumber(pagoenhotel,2) & "&nbsp;" & textoMoneda & "</b>")
	
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
			
			if idempresa = 93 then
				texto=Replace(texto, chr(10),"")
				texto=Replace(texto, chr(13),"")
			end if
				
			correocli=texto
			correopro=texto
		
		'Email para el cliente
		errorcorreo=sendPEMail(email,objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre,mailHotel,correocli,"")
	
		'Email para el hotel
		errorcorreo=sendPEMail(mailhotel,objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre,email,correopro,"")
		'response.write correopro
		
		'Copia de email para bcm
		errorcorreo=sendPEMail("info@bcmplanetdance.com",objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre ,email,correopro,"")
			
		'Copia de email
		errorcorreo=sendPEMail("gisela@planeta-web.com",objIdioma.getTraduccionHTML("i_confireserva") & " " & codres & " " & hnombre ,email,correopro,"")
		if errorcorreo <> "" then
			response.write errorcorreo
		end if
		response.write correopro
		
		cs="UPDATE Reservas SET activa=-1 WHERE Cod_res=" & codres
		base.execute cs
		'response.write "$*$OKY$*$"
		
	end if 'hayhotel
	
	set objIdioma=nothing
	set rs=nothing
	base.close
	set base=nothing

end if 'result=0
%>
