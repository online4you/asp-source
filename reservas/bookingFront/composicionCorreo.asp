<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<%
'la ide se recoge en datosempresa.asp (idempresa)
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
 currDay=day(date)& ""
 currMonth=month(date)& ""
 if (len(currDay)=1) then currDay= "0"+ currDay
 if (len(currMonth)=1) then currMonth= "0"+ currMonth
 strcurrentdate = currDay & "/" & currMonth & "/" & year(date)
 


codres=request.QueryString("num_operacion")
if codres="" then codres=request.form("num_operacion")


set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Buscar codigo del hotel
cs="SELECT Reservas.CodigoEsta,Establecimientos.Nombre,FechaIni,FechaFin,NumDias,Servicios,"
cs=cs & "Importe,ImportePag,Comentarios,Idi,CodOferta, PelasOferta,IdCliente,Moneda, numFact "
cs=cs & "FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
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
	codigosOferta=rs("CodOferta")
	obs=rs("comentarios")
	lang=rs("Idi")
	idcliente=rs("idcliente")
	moneda=paClng(rs("moneda"))
	numFact=paClng(rs("numFact"))
	
	select case moneda
		case 0 'euros
			textomoneda="&euro;"
		case 1 'dolares
			textomoneda="$"
		case 2 'libras
			textomoneda="&pound;"
	end select
	textomoneda="&euro;"
	hayhotel=true
end if
rs.close

htmlOfertas=""
objIdioma.cargaIdioma(lang)
if (not isnull(codigosOferta) and codigosOferta<>"") then
	if (codigosOferta="1" or right(codigosOferta, 2)="-1") then
		htmlOfertas=htmlOfertas & objIdioma.getTraduccionHTML("i_oferta_temporada") & "<br>"
	end if

	'Buscar ofertas
	cs="SELECT "
	cs=cs & "IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion) AS Tradu "
	cs=cs & "FROM jos_crs_Ofertas Ofertas  "
	cs=cs & "LEFT JOIN jos_crs_Traducciones Traducciones ON Ofertas.Id=Traducciones.IdReferencia AND Traducciones.Tabla='Ofertas' AND Traducciones.Campo='Titulo' AND Traducciones.Idioma='"& lang &"' "
	cs=cs & "WHERE Ofertas.Id IN(" & replace(codigosOferta,"-",",") & ") "
	
	'response.write cs
	
	rs.open cs,base
	hayCodigosOferta=false
	do while not rs.eof 
		htmlOfertas=htmlOfertas & rs("Tradu") & "<br>"
		hayCodigosOferta=true
		rs.movenext
	loop
	rs.close
end if

if hayhotel then 'Buscar el resto de datos
	'Datos del Cliente
	cs="SELECT * FROM " & precrs & "Fichas Fichas WHERE Id=" & IdCliente
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
		email2=rs("email2") 
		checkFactura=rs("checkFactura") 
		factNombre=rs("factNombre") 
		factCifNif=rs("factCifNif") 
		factCP=rs("factCP") 
		factDir=rs("factDir") 
		factLoc=rs("factLoc") 
		factProv=rs("factProv") 
		factEmail=rs("factEmail") 
		checkPersonaContacto=rs("checkPersonaContacto") 
		apeContact=rs("apeContact") 
		nomContact=rs("nomContact") 
		telContact=rs("telContact") 
		tipoDocu=rs("tipoDocu") 
		documento=rs("documento") 
		deseoRecibirOfertas =rs("deseoRecibirOfertas")
		acepto=rs("acepto")
	end if
	rs.close
	
	'Buscar datos del hotel
	'cs="SELECT Direccion,CP,Poblacion,Telefono,Fax,EMail FROM " & precrs & "DatosHotel DatosHotel "
	'cs=cs & "WHERE CodigoEsta=" & est
	cs="SELECT stat.name provincia, cit.name ciudad, i.address,DatosHotel.CP,DatosHotel.Telefono,DatosHotel.Fax,DatosHotel.EMail FROM " & precrs & "DatosHotel DatosHotel  "
	cs=cs & "inner join " & precrs & "Establecimientos est on est.CodigoEsta=DatosHotel.CodigoEsta "
	cs=cs & "inner join jos_hg_hotelitems i on i.id=est.hg_CodigoEsta "
	cs=cs & "left join jos_hg_cities cit on cit.id=i.city "
	cs=cs & "left join jos_hg_states stat on stat.id=i.statename "
	cs=cs & "WHERE DatosHotel.CodigoEsta=" & est
	
	'response.Write(cs)
	rs.open cs,base
	if not rs.eof then
		hdire=rs("address")
		hcp=rs("cp")
		hpobla=rs("provincia") & " " & rs("ciudad")
		htele=rs("telefono")
		hfax=rs("fax")
		mailHotel=rs("email")
	end if
	rs.close

		dim otravez,intercambio
		'dim CuantasH(),NombreH(),SupleH()		
		dim CuantasH(),SupleH()			
		dim tadultos(),tninos1(),tninos2(),tbebes()

		'set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		'Abrir fichero plantilla
		'set oFichero = FSO.OpenTextFile(server.MapPath("/reservas/bookingFront/plantillasCorreo/correoReserva_"& idEmpresa &".html")) 
		'plantilla= oFichero.ReadAll  'Paso los datos a una variable
		'Cerrar el fichero
		'oFichero.close
		'set oFichero=nothing
		'set FSO=nothing

		plantilla= ""
		pre=""
		post=""
		factura=""
		'cs="select max(IF(ISNULL(numfact),1,numfact+1)) factura from " & precrs & "Reservas WHERE YEAR(FechaReserva)=YEAR(current_date)"
		'rs.open cs,base
		'if not rs.eof then
		'	factura= rs("factura")
		'end if
		'rs.close
	
		'cs="UPDATE " & precrs & "Reservas SET numfact=" & factura & " WHERE isnull(numfact) and Cod_res=" & codres
		'base.execute cs
		
		cs="select numfact from " & precrs & "Reservas WHERE Cod_res=" & codres
		rs.open cs,base
		if not rs.eof then
			If not IsNull(rs("numfact")) and rs("numfact")<>"" Then
				factura= rs("numfact")
			end if
		end if
		rs.close
		
		cs="select prefijo from jos_hg_settings WHERE id=1"
		rs.open cs,base
		prefijo= ""
		if not rs.eof then
			If not IsNull(rs("prefijo")) and rs("prefijo")<>"" Then
				prefijo= rs("prefijo")& "-"
			end if
		end if
		rs.close
		
		if (checkFactura="1") then
			cs="select temp.body from jos_acymailing_template temp "
			cs=cs & " inner join jos_hg_settings setin on setin.voucherTPVFactura=temp.name"
		else
			cs="select temp.body from jos_acymailing_template temp "
			cs=cs & " inner join jos_hg_settings setin on setin.voucherTPV=temp.name"
		end if
		rs.open cs,base
		if not rs.eof then
			plantilla= rs("body")
		end if
		rs.close
		
		
		
		
		'Condiciones hotel
		cs="SELECT IF(ISNULL(Traducciones.Traduccion),CondicionesHotel.Texto,Traducciones.Traduccion) AS Tradu  "
		cs=cs & "FROM " & precrs & "CondicionesHotel CondicionesHotel "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON CondicionesHotel.CodigoEsta=Traducciones.IdReferencia AND Tabla='CondicionesHotel' AND "
		cs=cs & "Campo='Texto' AND Idioma='" & lang & "' "		
		cs=cs & "WHERE CondicionesHotel.CodigoEsta=" & est
		'response.write cs
		rs.open cs,base
		if not rs.eof then
			condicionesHotel="" & rs("tradu")
		end if
		rs.close

		'Buscar nombres de colectivos
		cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) AS Tradu "
		cs=cs & "FROM " & precrs & "Colectivos Colectivos "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "		
		cs=cs & "WHERE Colectivos.CodigoEsta=" & est
		cs=cs & " ORDER BY orde"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			CColec=0
			NColec=1
		end if
		rs.close

		'Suplementos del hotel
		cs="SELECT Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) AS Tradu "
		cs=cs & "FROM " & precrs & "Regimen Regimen "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
		cs=cs & " ORDER BY Id "		
		'response.Write(cs)
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
		cs=cs & "IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu,Importe "
		cs=cs & "FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
		cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "		
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
		
		texto=Replace(texto, "voucher=lang",lang) 
		texto=Replace(texto, "voucher=codres",objIdioma.getTraduccionHTML("i_codres") & " " & codres) 
		texto=Replace(texto, "voucher=numfactura",objIdioma.getTraduccionHTML("i_numFactura") & ":" & numFact) 
		'datos hotel
		texto=Replace(texto, "voucher=datoshotel",ucase(objIdioma.getTraduccionHTML("i_Vdatoshotel"))) 
		texto=Replace(texto, "voucher=nombrehotel",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & hnombre) 
		texto=Replace(texto, "voucher=direhotel",objIdioma.getTraduccionHTML("i_direccion") & ":&nbsp;" & hdire)  
		texto=Replace(texto, "voucher=poblahotel",objIdioma.getTraduccionHTML("i_pais") & "/" & objIdioma.getTraduccionHTML("i_provincia") & ":&nbsp;" & hpobla) 
		texto=Replace(texto, "voucher=telehotel",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & htele) 
		'texto=Replace(texto, "voucher=emailhotel","<a href=""mailto:" & mailhotel & """>" & mailhotel & "</a>") 
		
		'Datos Reserva
		texto=Replace(texto, "voucher=datosreserva",ucase(objIdioma.getTraduccionHTML("i_datosres"))) 
		texto=Replace(texto, "voucher=codigoreservaFactura",objIdioma.getTraduccionHTML("i_codres") & ":&nbsp;" & prefijo & codres & "<br>" & objIdioma.getTraduccionHTML("i_numFactura") & ":&nbsp;" & year(date) & "-" & prefijo &  factura ) 
		texto=Replace(texto, "voucher=fechallegada",objIdioma.getTraduccionHTML("i_fllegada") & ":&nbsp;" & fini) 
		texto=Replace(texto, "voucher=fechasalida",objIdioma.getTraduccionHTML("i_fsalida") & ":&nbsp;" & ffin) 
		texto=Replace(texto, "voucher=noches",objIdioma.getTraduccionHTML("i_noches") & ":&nbsp;" & ndias) 
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
		texto=Replace(texto, "voucher=habitaciones",textohab) 
		
		texto=Replace(texto, "voucher=precio",objIdioma.getTraduccionHTML("i_total") & ":&nbsp;<b>" & formatnumber(pelas,2) & "&nbsp;" & textoMoneda & "</b>")
		texto=Replace(texto, "voucher=pagado",objIdioma.getTraduccionHTML("i_prepago") & ":&nbsp;<b>" & formatnumber(pagado,2) & "&nbsp;" & textoMoneda & "</b>")
		pagoenhotel=pelas - pagado
		texto=Replace(texto, "voucher=pagarhotel",objIdioma.getTraduccionHTML("i_pagoenhotel") & ":&nbsp;<b>" & formatnumber(pagoenhotel,2) & "&nbsp;" & textoMoneda & "</b>")

		texto=Replace(texto, "voucher=hoy",strcurrentdate)
		texto=Replace(texto, "voucher=datosEconomicos",objIdioma.getTraduccionHTML("i_datosEconomicos"))
		texto=Replace(texto, "voucher=baseImponible",objIdioma.getTraduccionHTML("i_baseImponible") & ":&nbsp;<b>" & formatnumber((pagado/(121/100)),2) & "&nbsp;" & textoMoneda & "</b>")
		texto=Replace(texto, "voucher=iva",objIdioma.getTraduccionHTML("i_iva") & ":&nbsp;<b>" & formatnumber((pagado/(121/100))*(21/100),2) & "&nbsp;" & textoMoneda & "</b>")
		texto=Replace(texto, "voucher=totalFactura",objIdioma.getTraduccionHTML("i_totalFactura") & ":&nbsp;<b>" & formatnumber(pagado,2) & "&nbsp;" & textoMoneda & "</b>")

		'Ofertas
		texto=Replace(texto, "voucher=descripcionesOfertas",htmlOfertas) 
		
		'Datos personales

		texto=Replace(texto, "voucher=datospersonales",ucase(objIdioma.getTraduccionHTML("i_datos"))) 
		if (checkPersonaContacto="1") then 
			texto=Replace(texto, "voucher=nombrecliente",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & apellidos & ", " & nombre) 
			texto=Replace(texto, "voucher=nomContact",objIdioma.getTraduccionHTML("i_nomContact") & ":&nbsp;" & apeContact & ", " & nomContact) 
			texto=Replace(texto, "voucher=telContact",objIdioma.getTraduccionHTML("i_telContact") & ":&nbsp;" & telContact) 
		else
			texto=Replace(texto, "voucher=nombrecliente",objIdioma.getTraduccionHTML("i_nombre") & ":&nbsp;" & apellidos & ", " & nombre) 
			texto=Replace(texto, "voucher=nomContact","&nbsp;") 
			texto=Replace(texto, "voucher=telContact","&nbsp;") 
		end if
		if (tipoDocu="1") then tipoDocu=objIdioma.getTraduccionHTML("i_nif")
		if (tipoDocu="2") then tipoDocu=objIdioma.getTraduccionHTML("i_namePasaporte")
		if (tipoDocu="3") then tipoDocu=objIdioma.getTraduccionHTML("i_otros")
		texto=Replace(texto, "voucher=tipoDocumento",objIdioma.getTraduccionHTML("i_tipoDocu") & ":&nbsp;" & tipoDocu) 
		texto=Replace(texto, "voucher=documento",objIdioma.getTraduccionHTML("i_documento") & ":&nbsp;" & documento) 
		texto=Replace(texto, "voucher=emailcliente",objIdioma.getTraduccionHTML("i_email") & ":&nbsp;" & email)
		texto=Replace(texto, "voucher=telefonocliente",objIdioma.getTraduccionHTML("i_telefono") & ":&nbsp;" & telefono) 
		texto=Replace(texto, "voucher=obscliente",objIdioma.getTraduccionHTML("i_observaciones") & ":&nbsp;" & obs)
		if condicionesHotel<>"" then
			texto=Replace(texto, "voucher=condiciones",objIdioma.getTraduccionHTML("i_condiciones") & ":&nbsp;" & condicionesHotel)
		else
			texto=Replace(texto, "voucher=condiciones","")
		end if
		
		texto=Replace(texto, "voucher=datosfactuta",ucase(objIdioma.getTraduccionHTML("i_datosFactura"))) 
		texto=Replace(texto, "voucher=nombreFact",objIdioma.getTraduccionHTML("i_razonSocial") & ":&nbsp;" & factNombre) 
		texto=Replace(texto, "voucher=cifNifFact",objIdioma.getTraduccionHTML("i_CifNif") & ":&nbsp;" & factCifNif) 
		texto=Replace(texto, "voucher=dirFiscal",objIdioma.getTraduccionHTML("i_dirFiscal") & ":<br>&nbsp;&nbsp;" & factDir & " <br>&nbsp;&nbsp;" & factCP & " <br>&nbsp;&nbsp;" & factLoc & "<br>&nbsp;&nbsp;" & factProv ) 
		texto=Replace(texto, "voucher=emailFact",objIdioma.getTraduccionHTML("i_email") & ":&nbsp;" & factEmail) 
	

		plantillaShow=texto
		
		Dim objFSO, objFile, objFolder
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objFolder = objFSO.GetFolder(server_path & "images\Voucher")
		attachments=""
		For Each objFile in objFolder.Files
			fileName=mid(objFile.Name,1,InStr(1,objFile.Name,".")-1)
			extName=mid(objFile.Name,InStr(1,objFile.Name,".")+1,len(objFile.Name)) 
			if (InStr(1,plantilla,"http://www.online4you.es/images/Voucher/" & objFile.Name)<>0) then
				plantilla= replace (plantilla,"http://www.online4you.es/images/Voucher/" & objFile.Name, "cid:" & fileName ) 
				if (attachments="") then
					attachments=attachments & "/images/Voucher/" & objFile.Name
				else
					attachments=attachments & ",/images/Voucher/" & objFile.Name
				end if
			end if
		Next
		Set objFolder = Nothing
		Set objFSO = Nothing



			
		correocli=texto
		correopro=texto
	

	
	'response.write correopro
	'response.End()
	correopro=Replace(correopro, "'","`")
	cs="INSERT INTO " & precrs & "MailsReservas (codres,pre,body,post,attachments, asunto) VALUES (" & codres & ",'" & pre & "','" & correopro & "','" & post & "','" & attachments & "', '" & objIdioma.getTraduccionHTML("i_confireserva") & " " & prefijo & codres & " " & hnombre & "')"
	'response.Write(cs)
	'response.end()
	base.execute cs
	cs="delete from " & precrs & "MailsReservas "
	cs=cs & "where codres in "
	cs=cs & "(select res.Cod_Res from " & precrs & "Reservas res where res.FechaFin < DATE_SUB(CURRENT_TIMESTAMP(),INTERVAL 1 MONTH))"
	'response.Write(cs)
	base.execute cs
	
		cs="select id from " & precrs & "MailsReservas where codres=" & codres & " order by id desc"
		rs.open cs,base
		if not rs.eof then
			id=rs("id")
			url = mainUrl & "/templates/photel/custom/httpFunctions.php?toCmd=getMailBody(" & id & ",'id','jos_crs_MailsReservas')&lang=" & lang 
			response.write "<!-- " & url & "-->"
			set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
			xmlhttp.open "GET", url, false 
			xmlhttp.send "" 
			respuesta=xmlhttp.responseText
			respuesta=replace(respuesta,"'","""")
			respuesta=mid(respuesta,InStr(1,respuesta,"<prebody>")+9,len(respuesta))
			respuesta=mid(respuesta,1,InStr(1,respuesta,"<postbody>")-1)
		end if
		rs.close
	plantillaShow=respuesta
	responseToTPV=""
	if errorcorreo <> "" then
		responseToTPV=errorcorreo
	end if
	
	'response.write errorcorreo
	
	'cs="UPDATE " & precrs & "Reservas SET activa=-1 WHERE Cod_res=" & codres
	'base.execute cs
	responseToTPV=plantillaShow
	
	cs="INSERT INTO " & precrs & "TPVLog (codres,response) VALUES (" & codres & ",""" & replace(responseToTPV,"""","'") & """)"
	'response.write cs
	base.execute cs
	cs="delete from " & precrs & "TPVLog "
	cs=cs & "where data < DATE_SUB(CURRENT_TIMESTAMP(),INTERVAL 1 MONTH)"
	
	base.execute cs
	
end if 'hayhotel

%>
<div id="result" style="visibility: hidden;position: absolute;top:0px"></div>
<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td>
<input name="button" type='button' class="boton86" id='button' style='cursor:pointer' onclick="javascript:reSendVoucher();" value='<%=objIdioma.getTraduccionHTML("i_enviar")%>'>
</td>
<td>
<input name="emails" type='text' id='emails' size="100" maxlength="250" />
</td>
</tr>
<tr><td colspan="2">
<%=responseToTPV%>
</td></tr>

</table>
<script type="text/javascript">
/*
*Esta libreria es una libreria AJAX creada por Javier Mellado con la inestimable
*colaboracion de Beatriz Gonzalez.
*y descargada del portal AJAX Hispano http://www.ajaxhispano.com
*contacto javiermellado@gmail.com
*
*Puede ser utilizada, pasada, modificada pero no olvides mantener
*el espiritu del software libre y respeta GNU-GPL
*/ 
var toDo="";
function  checkIfOK(){
	if (toDo!=""){
		eval (toDo);
	}
	toDo="";
	
}
function creaAjax(){
         var objetoAjax=false;
         try {
          /*Para navegadores distintos a internet explorer*/
          objetoAjax = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
          try {
                   /*Para explorer*/
                   objetoAjax = new ActiveXObject("Microsoft.XMLHTTP");
                   }
                   catch (E) {
                   objetoAjax = false;
          }
         }

         if (!objetoAjax && typeof XMLHttpRequest!='undefined') {
          objetoAjax = new XMLHttpRequest();
         }
         return objetoAjax;
}
                        

function FAjax (url,capa,valores,metodo)
{
          var ajax=creaAjax();
          var capaContenedora = document.getElementById(capa);

/*Creamos y ejecutamos la instancia si el metodo elegido es POST*/
if(metodo.toUpperCase()=='POST'){
         ajax.open ('POST', url, true);
         ajax.onreadystatechange = function() {
         if (ajax.readyState==1) {
                          capaContenedora.innerHTML="Cargando.......";
         }
         else if (ajax.readyState==4){
                   if(ajax.status==200)
                   {
                        document.getElementById(capa).innerHTML=ajax.responseText;
						checkIfOK();
                   }
                   else if(ajax.status==404)
                                             {

                            capaContenedora.innerHTML = "La direccion no existe";
                                             }
                           else
                                             {
                            capaContenedora.innerHTML = "Error: ".ajax.status;
                                             }
                                    }
                  }
         ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
         ajax.send(valores);
         return;
}
/*Creamos y ejecutamos la instancia si el metodo elegido es GET*/
if (metodo.toUpperCase()=='GET'){

         ajax.open ('GET', url, true);
         ajax.onreadystatechange = function() {
         if (ajax.readyState==1) {
                                      capaContenedora.innerHTML="Cargando.......";
         }
         else if (ajax.readyState==4){
                   if(ajax.status==200){
                                             document.getElementById(capa).innerHTML=ajax.responseText;
                   }
                   else if(ajax.status==404)
                                             {

                            capaContenedora.innerHTML = "La direccion no existe";
                                             }
                                             else
                                             {
                            capaContenedora.innerHTML = "Error: " + ajax.status;
                                             }
                                    }
                  }
         ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
         ajax.send(null);
         return
}
} 
</script>

<script language="JavaScript">
function printVoucher(){
	this.print();
}

function reSendVoucher(){
	var url;
	var emailTo=document.getElementById('emails').value;
	if (emails!=''){
		url="/templates/photel/custom/httpFunctions.php";
		FAjax (url,"result","toCmd=sendJMail(<%=id%>,'id','jos_crs_MailsReservas','reservas@online4you.es','Online4you.es','" + emailTo + "')","POST")
		toDo="checkSendMail()";
	}
}
function checkSendMail(){
	if (document.getElementById('result').innerHTML.indexOf('Mail sent')>0) {
		alert("<%=objIdioma.getTraduccionHTML("i_mailEnviadoOK")%>");
	}
	else {
		alert("<%=objIdioma.getTraduccionHTML("i_mailEnviadoKO")%>");
	}
}
</script>
<%
set objIdioma=nothing
set rs=nothing
base.close
set base=nothing

%>