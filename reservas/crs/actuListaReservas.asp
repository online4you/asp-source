<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")


modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM TipoReserva WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "IdReserva=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			'Borrar Reserva
			cs="DELETE FROM Reservas WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "Cod_res=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		end if
		
	
	case "actu"
		MiId=request.form("id")
		activa=request.form("activa")
		tpelas=QuitarComa(paDbl(request.form("importe")))
		prepago=QuitarComa(paDbl(request.form("prepago")))
		obs=QuitarApos(request.form("obs"))
		fini=request.Form("fllegada")
		ffin=request.Form("fsalida")
		numFact=request.Form("numFact")
		idi=request.Form("idiWeb")

		noches=0
		if isdate(fini) and isdate(ffin) then
			noches=cdate(ffin)-cdate(fini)
		end if

		'Reservas
		cs="UPDATE " & precrs & "Reservas SET "
		cs=cs & "FechaIni=" & FechaMySQL(fini) & ","
		cs=cs & "FechaFin=" & FechaMySQL(ffin) & ","
		cs=cs & "NumDias=" & noches & ","
		cs=cs & "Activa=" & activa & ","
		cs=cs & "Importe=" & tpelas & ","
		cs=cs & "idi='" & idi & "',"
		cs=cs & "ImportePag=" & prepago & ","
		if numFact="" then 
			cs=cs & "numFact=null,"
		else
			cs=cs & "numFact=" & numFact & ","
		end if
		cs=cs & "Comentarios='" & obs & "' "
		cs=cs & "WHERE Cod_res=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
		
		'Actualizar los datos de la ficha
		apellidos=QuitarApos(request.form("apellidos"))
		nombre=QuitarApos(request.form("nombre"))
		direccion=QuitarApos(request.form("direccion"))
		cp=QuitarApos(request.form("cp"))
		poblacion=QuitarApos(request.form("poblacion"))
		provincia=QuitarApos(request.form("provincia"))
		pais=QuitarApos(request.form("pais"))
		telefono=QuitarApos(request.form("telefono"))
		fax=QuitarApos(request.form("fax"))
		email=QuitarApos(request.form("email"))
		checkFactura=quitarApos(request.form("checkFactura"))
		factCifNif=quitarApos(request.form("factCifNif"))
		factCP=quitarApos(request.form("factCP"))
		factNombre=quitarApos(request.form("factNombre"))
		factDir=quitarApos(request.form("factDir"))
		factLoc=quitarApos(request.form("factLoc"))
		factProv=quitarApos(request.form("factProv"))
		factEmail=quitarApos(request.form("factEmail"))
		
		checkPersonaContacto=quitarApos(request.form("checkPersonaContacto"))
		apeContact=quitarApos(request.form("apeContact"))
		nomContact=quitarApos(request.form("nomContact"))
		telContact=quitarApos(request.form("telContact"))
		tipoDocu=quitarApos(request.form("tipoDocu"))
		tipoDocuId=quitarApos(request.form("tipoDocuId"))
		documento=quitarApos(request.form("documento"))
		typeOfPaymentID=request.form("typeOfPaymentID")
		
		deseoRecibirOfertas=quitarApos(request.form("deseoRecibirOfertas"))
		acepto=quitarApos(request.form("acepto"))

		cs="UPDATE " & precrs & "Fichas SET Apellidos='" & apellidos & "',"
		cs=cs & "Nombre='" & nombre & "',"
		cs=cs & "Direccion='" & direccion & "',"
		cs=cs & "CP='" & cp & "',"
		cs=cs & "Poblacion='" & poblacion & "',"
		cs=cs & "Provincia='" & provincia & "',"
		cs=cs & "NombrePais='" & pais & "',"
		cs=cs & "Telefono='" & telefono & "',"
		cs=cs & "Fax='" & fax & "',"
		cs=cs & "EMail='" & email & "', "
		cs=cs & "email2='" & email2 & "',"
		cs=cs & "checkFactura='" & checkFactura & "',"
		cs=cs & "factNombre='" & factNombre & "',"
		cs=cs & "factCifNif='" & factCifNif & "',"
		cs=cs & "factCP='" & factCP & "',"
		cs=cs & "factDir='" & factDir & "',"
		cs=cs & "factLoc='" &  factLoc & "',"
		cs=cs & "factProv='" & factProv & "',"
		cs=cs & "factEmail='" & factEmail & "',"
		cs=cs & "checkPersonaContacto='" & checkPersonaContacto & "',"
		cs=cs & "apeContact='" & apeContact & "',"
		cs=cs & "nomContact='" & nomContact & "',"
		cs=cs & "telContact='" & telContact & "',"
		cs=cs & "tipoDocu='" & tipoDocu & "',"
		cs=cs & "documento='" & documento & "',"
		cs=cs & "deseoRecibirOfertas='" & deseoRecibirOfertas & "',"
		cs=cs & "acepto='" & acepto & "',"
		cs=cs & "typeOfPaymentID='" & typeOfPaymentID & "' "
		cs=cs & "WHERE CodReserva=" & MiId
		'response.Write(cs & "<br>")
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	
end select

	if (request.form("pasalir")="") then 
		pasalir="1"
	else
		pasalir=request.form("pasalir")
	end if

end if

%>