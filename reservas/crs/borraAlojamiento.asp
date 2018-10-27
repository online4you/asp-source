<%
if request.form<>"" then
	modo=request.QueryString("modo")
	if modo="borra" then 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			'COLECTIVOS
			cadena=""
			for t=0 to ubound(queborro)
				cadena=cadena & "CodigoEsta=" & trim(queborro(t)) & " OR "
			next
			if right(cadena,4)=" OR " then 'Quitar el ultimo operador
				cadena=left(cadena,len(cadena)-4)
			end if	
			
			on error resume next
			base.BeginTrans
			
			'Borrar en Colectivos
			cs2="SELECT " & precrs & "CodigoColec CodigoColec FROM Colectivos WHERE " & cadena
			rs.open cs2,base
			hayTemp=false
			if not rs.eof then
				RegTemp=rs.getrows
				IdTemp=0
				hayTemp=true
			end if
			rs.close
			if hayTemp then
			for t=0 to ubound(RegTemp,2)
				cs="DELETE FROM " & precrs & "DescuentosColectivos WHERE CodigoColec=" & RegTemp(IdTemp,t)
				base.execute cs
			next
			end if
			'Borrar colectivo
			cs="DELETE FROM " & precrs & "Colectivos WHERE " & cadena
			base.execute cs

			'HABITACIONES
			'Buscar las Hab.
			cs2="SELECT Id FROM " & precrs & "TipoHabitaNombres WHERE " & cadena
			rs.open cs2,base
			hayTemp=false
			if not rs.eof then
				RegTemp=rs.getrows
				IdTemp=0
				hayTemp=true
			end if
			rs.close
			if hayTemp then
			for t=0 to ubound(RegTemp,2)
				'Borrar Precios hab.
				cs="DELETE FROM " & precrs & "TipoHabitaPrecios WHERE IdHabita=" & RegTemp(IdTemp,t)
				base.execute cs
			next
			end if
			'Borrar Hab
			cs="DELETE FROM " & precrs & "TipoHabitaNombres WHERE " & cadena
			base.execute cs

			'Borrar Temporada
			cs="DELETE FROM " & precrs & "Temporadas WHERE " & cadena
			base.execute cs

			'Borrar Cupos
			cs="DELETE FROM " & precrs & "Cupos WHERE " & cadena
			base.execute cs
			
			'Borrar DatosHotel
			cs="DELETE FROM " & precrs & "DatosHotel WHERE " & cadena
			base.execute cs
			'Borrar GoogleMaps
			cs="DELETE FROM " & precrs & "GMapsHotel WHERE " & cadena
			base.execute cs
			'Borrar Caracteristicas
			cs="DELETE FROM " & precrs & "CaracteristicasHotel WHERE " & cadena
			base.execute cs
			'Cond. del hotel
			cs="DELETE FROM " & precrs & "CondicionesHotel WHERE " & cadena
			base.execute cs
			
			
			
			'Borrar TipoReserva
			cs="DELETE FROM " & precrs & "TipoReserva WHERE " & cadena
			base.execute cs
			
			'Borrar Reserva
			cs="DELETE FROM " & precrs & "Reservas WHERE " & cadena
			base.execute cs

			'Suplementos
			'Buscar las suplementos
			cs2="SELECT Id FROM " & precrs & "RegimenHotel WHERE " & cadena
			rs.open cs2,base
			hayTemp=false
			if not rs.eof then
				RegTemp=rs.getrows
				IdTemp=0
				hayTemp=true
			end if
			rs.close
			if hayTemp then
			for t=0 to ubound(RegTemp,2)
				cs="DELETE FROM " & precrs & "RegimenDtos WHERE IdRegimenHotel=" & RegTemp(IdTemp,t)
				base.execute cs
			next
			end if
			'Borrar reg
			cs="DELETE FROM " & precrs & "RegimenHotel WHERE " & cadena
			base.execute cs
			
			'OFERTAS
			cs="DELETE FROM " & precrs & "Ofertas WHERE " & cadena
			base.execute cs
			
			'Traducciones
			cs="DELETE FROM " & precrs & "Traducciones WHERE " & cadena
			base.execute cs
			
			'Borrar Establecimiento
			cs="DELETE FROM " & precrs & "Establecimientos WHERE " & cadena
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0

			
		end if
	
	end if 'modo="borra"

end if 'form<>""
%>