<%
	'Solo cuando habis=si
		modo=request.QueryString("modo")
		MiId=request.form("id")
		
		select case modo 
			case "borra" 'Borrar marcadas
				queborro=split(request.form("aborrar"),",")
				if ubound(queborro)>=0 then
					cs="DELETE FROM " & precrs & "TipoHabitaNombres WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "Id=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					base.execute cs
					'Borrar precios Habitacion
					cs="DELETE FROM " & precrs & "TipoHabitaPrecios WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "IdHabita=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
	
					'Borrar en DescuentosColectvios
					cs="DELETE FROM " & precrs & "DescuentosColectivos WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "TipoHab=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					base.execute cs

					'Busco los cod. de suplementos para poder borrar en las tablas relacionadas
					cs="SELECT Id FROM " & precrs & "RegimenHotel WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "CodigoHab=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					rs.open cs,base
					haysuples=false
					if not rs.eof then
						RegCodS=rs.getrows
						haysuples=true
					end if
					rs.close
					'Borrar en la tablas relacionadas
					if haysuples then
						for r=0 to ubound(RegCodS,2)
							'Dtos Suplementos
							cs="DELETE FROM " & precrs & "RegimenDtos WHERE IdRegimenHotel=" & RegCodS(0,r)
							base.execute cs
						next			
					end if
					'Borrar en la tabla suplementosTempo
					cs="DELETE FROM " & precrs & "RegimenHotel WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "CodigoHab=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					base.execute cs
					
					'Borrar en cupo habitaciones
					cs="DELETE FROM " & precrs & "Cupos WHERE "
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "CodigoHab=" & trim(queborro(t)) & " OR "
						end if
					next
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	
					base.execute cs

				end if
				
			case "nuevo" 'Añadir
				'Valores
				orden=request.form("orden")
				tipoh=request.form("tipoh")
				nombre_es=QuitarApos(request.form("nombre_es"))
				nombre_it=QuitarApos(request.form("nombre_it"))
				nombre_en=QuitarApos(request.form("nombre_en"))
				nombre_de=QuitarApos(request.form("nombre_de"))
				nombre_fr=QuitarApos(request.form("nombre_fr"))
				paracapmax=quitarComa(request.Form("capmax"))
				paracapmin=quitarComa(request.Form("capmin"))
				paracapnormal=quitarComa(request.Form("capnormal"))
				paraAdultMax=quitarComa(request.Form("adultmax"))
				paraAdultMin=quitarComa(request.Form("adultmin"))
				paraNiMax=quitarComa(request.Form("ninmax"))
				cunaocupa=request.Form("cunaocupa")
				if cunaocupa="" then cunaocupa=0
				
				cs="INSERT INTO " & precrs & "TipoHabitaNombres (TipoHabitacion,Nombre_es,"
				cs=cs & "Nombre_it,Nombre_en,Nombre_de,Nombre_fr,CodigoEsta,Orden,ParaCapMax,"
				cs=cs & "ParaCapMin,ParaCapNormal,ParaAdultMax,ParaNiMax,CunaOcupa,ParaAdultMin) VALUES ("
				cs=cs & tipoh & ",'" & nombre_es & "','" & nombre_it & "','"
				cs=cs & nombre_en & "','" & nombre_de & "','" & nombre_fr & "',"
				cs=cs & est & "," & orden & "," & paracapmax & "," & paracapmin & ","
				cs=cs & paracapnormal & "," & paraAdultMax & "," & paraNiMax & "," & cunaocupa & "," & paraAdultMin & ")"				
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento

				'Busco el id de la ult. habi.
				cs="SELECT MAX(Id) as idhabi FROM " & precrs & "TipoHabitaNombres"
				rs.open cs,base
				if not rs.eof then
					idhabi=rs("idhabi")
				end if
				rs.close
				
				'Añadir Precios habitacion por temporada
				for t=0 to ubound(RegTempos,2)
					cs="INSERT INTO " & precrs & "TipoHabitaPrecios (IdHabita,Temporada,PrePreBase,PreperHab) VALUES ("
					cs=cs & idhabi & "," & RegTempos(TCodi,t) & ",0,0)"
					base.execute cs
				next
				laid=idhabi 'Para qu cargue la ficha que acabo de crear
				
			case "actu"
				'Valores
				orden=request.form("orden")
				tipoh=request.form("tipoh")
				nombre_es=QuitarApos(request.form("nombre_es"))
				nombre_it=QuitarApos(request.form("nombre_it"))
				nombre_en=QuitarApos(request.form("nombre_en"))
				nombre_de=QuitarApos(request.form("nombre_de"))
				nombre_fr=QuitarApos(request.form("nombre_fr"))
				paracapmax=quitarComa(request.Form("capmax"))
				paracapmin=quitarComa(request.Form("capmin"))
				paracapnormal=quitarComa(request.Form("capnormal"))
				paraAdultMax=quitarComa(request.Form("adultmax"))
				paraAdultMin=quitarComa(request.Form("adultmin"))
				paraNiMax=quitarComa(request.Form("ninmax"))
				cunaocupa=request.Form("cunaocupa")
				if cunaocupa="" then cunaocupa=0
	
				'Actualiza Nombres
				cs="UPDATE " & precrs & "TipoHabitaNombres SET "
				cs=cs & "Nombre_es='" & nombre_es & "',"
				cs=cs & "Nombre_it='" & nombre_it & "',"
				cs=cs & "Nombre_en='" & nombre_en & "',"
				cs=cs & "Nombre_de='" & nombre_de & "',"
				cs=cs & "Nombre_fr='" & nombre_fr & "',"
				cs=cs & "TipoHabitacion=" & tipoh & ","
				cs=cs & "ParaCapMax=" & paracapmax & ","
				cs=cs & "ParaCapMin=" & paracapmin & ","
				cs=cs & "ParaCapNormal=" & paracapnormal & ","
				cs=cs & "ParaAdultMax=" & paraAdultMax & ","
				cs=cs & "ParaAdultMin=" & paraAdultMin & ","
				cs=cs & "ParaNiMax=" & paraNiMax & ","
				cs=cs & "CunaOcupa=" & cunaocupa & ","
				cs=cs & "Orden=" & orden & " "
				cs=cs & "WHERE Id=" & MiId
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento

				
		end select
%>