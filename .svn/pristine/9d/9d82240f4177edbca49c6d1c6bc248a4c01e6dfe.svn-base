<%
if request.form<>"" then 'Actualizar
	'valores form
	nombre_es=QuitarApos(request.form("nombre_es"))
	nombre_it=QuitarApos(request.form("nombre_it"))
	nombre_en=QuitarApos(request.form("nombre_en"))
	nombre_de=QuitarApos(request.form("nombre_de"))
	nombre_fr=QuitarApos(request.form("nombre_fr"))
	miTarifa=paClng(request.form("laTarifa"))
	margen=paDbl(request.form("margen"))

	modo=request.QueryString("modo")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM Tarifas WHERE "
				cadena=""
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cadena,4)=" OR " then 'Quitar el ultimo operador
					cadena=left(cadena,len(cadena)-4)
				end if	
				base.execute cs & cadena
				controlRegistro(cs) 'guarda seguimiento
				'Borrar resto de tablas relacionadas con la tarifa
				cadena=replace(cadena,"Id=","Tarifa=")
				base.execute "DELETE FROM " & precrs & "Cupos WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "DescuentosColectivos WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "Ofertas WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "OfertasVIP WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "Extras WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "RegimenHotel WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "RegimenDtos WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "Reservas WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "TipoHabitaPrecios WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "Agencias WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "ReservaServicio WHERE " & cadena
				base.execute "DELETE FROM " & precrs & "ServiciosPrecios WHERE " & cadena
			
			end if
			
		case "nuevo" 'Añadir
			'Busxcar la ultima Id
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Tarifas"
			rs.open cs,base
			laUlti=0
			if not rs.eof then
				laulti=paClng(rs("ulti"))+1
			end if
			rs.close
			'Añadir
			cs="INSERT INTO " & precrs & "Tarifas (Id,Nombre_es,Nombre_it,Nombre_en,"
			cs=cs & "Nombre_de,Nombre_fr) VALUES (" & laulti & ",'"
			cs=cs & nombre_es & "','" & nombre_it & "','" & nombre_en & "','" & nombre_de & "','"
			cs=cs & nombre_fr & "')"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento

			'Crear registros en Cupo
			cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,DiasMinimos,Release,"
			cs=cs & "Estado,Tarifa) "
			cs=cs & "SELECT CodigoHab,CodigoEsta,Dia,Cupo,Precio+Precio*SIGN(" & margen & ")*ABS(" & margen & ")/100 as Pelas,"
			cs=cs & "DiasMinimos,Release,Estado," & laUlti & " FROM Cupos WHERE Tarifa=" & miTarifa
			base.execute cs
			'RegimenHotel
			cs="INSERT INTO " & precrs & "RegimenHotel (IdRegimen,CodigoEsta,CodigoHab,CodigoTempo,Precio,Defecto,Anyo,Tarifa) "
			cs=cs & "SELECT IdRegimen,CodigoEsta,CodigoHab,CodigoTempo,"
			cs=cs & "Precio+Precio*SIGN(" & margen & ")*ABS(" & margen & ")/100 as Pelas,Defecto,Anyo,"
			cs=cs & laUlti & " FROM RegimenHotel WHERE Tarifa=" & miTarifa
			base.execute cs
			'TipoHabitaPrecios
			cs="INSERT INTO " & precrs & "TipoHabitaPrecios (IdHabita,Temporada,PrePreBase,PrePerHab,Tarifa) "
			cs=cs & "SELECT IdHabita,Temporada,"
			cs=cs & "PrePreBase+PrePreBase*SIGN(" & margen & ")*ABS(" & margen & ")/100 as Pelas,PrePerHab,"
			cs=cs & laUlti & " FROM TipoHabitaPrecios WHERE Tarifa=" & miTarifa
			base.execute cs

			'Descuentoscolectivos
			cs="INSERT INTO " & precrs & "DescuentosColectivos (CodigoColec,Temporada,TipoHab,PreBase,Precio,Anyo,Tarifa) "
			cs=cs & "SELECT CodigoColec,Temporada,TipoHab,PreBase,"
			cs=cs & "Precio+Precio*SIGN(" & margen & ")*ABS(" & margen & ")/100 as Pelas,Anyo,"
			cs=cs & laUlti & " FROM DescuentosColectivos WHERE Tarifa=" & miTarifa
			base.execute cs
				
				
			
		case "actu"
			MiId=request.form("id")
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Tarifas SET "
			cs=cs & "Nombre_es='" & nombre_es & "',"
			cs=cs & "Nombre_it='" & nombre_it & "',"
			cs=cs & "Nombre_en='" & nombre_en & "',"
			cs=cs & "Nombre_de='" & nombre_de & "',"
			cs=cs & "Nombre_fr='" & nombre_fr & "' "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
	pasalir=1
end if 'form<>""
%>