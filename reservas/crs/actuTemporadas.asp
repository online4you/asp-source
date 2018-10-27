<%
if request.form<>"" and request.QueryString("modo") <> "" then 'Actualizar

	modo = request.QueryString("modo")
	MiId = request.form("id")
	fini = request.form("fechainicio")
	ffin = request.form("fechafinal")
	release = paClng(request.form("release"))
	minimo = paClng(request.form("minimo"))
	prepago = paDbl(replace(request.form("prepago"),".",","))
	
		oferta = request.form("oferta")

		
	redim NombreOfertaIdiomas(ubound(ListaIdiomas))
	for i = 0 to ubound(ListaIdiomas)
		NombreOfertaIdiomas(i) = QuitarApos(request.form("nombre_" & ListaIdiomas(i)))
	next
	

		if oferta <> 1 then oferta = 0

	
	if (not isdate(fini) or not isdate(ffin)) AND modo<>"borra" then 'Fechas incorrectas
		msgerror=objIdioma.getTraduccionHTML("i_errorfechas")
	end if
	
	if msgerror="" then 'no hay problemas

		select case modo 
			case "borra" 'Borrar marcadas
				queborro = split(request.form("aborrar"),",")
				if ubound(queborro) >= 0 then
					cs=""
					for t=0 to ubound(queborro)
						if clng(queborro(t))<>0 then 'Para no borrar la cero
							cs=cs & "CodigoTemp=" & trim(queborro(t)) & " OR "
						end if
					next
					
					if right(cs,4)=" OR " then 'Quitar el ultimo operador
						cs=left(cs,len(cs)-4)
					end if	

					cs3 = "1 = 0"					
					for x = 0 to ubound(queborro)
						if clng(queborro(x)) <> 0 then 'Para no borrar la cero
							cs3 = cs3 & " OR IdReferencia=" & trim(queborro(x))
						end if
					next
					
					cs2="SELECT FInicio,FFinal,CodigoEsta FROM " & precrs & "Temporadas WHERE " & cs
					rs.open cs2,base
					haytempos = false
					if not rs.eof then
						RegTempos = rs.getrows
						TFIni = 0
						TFFin = 1
						THotel = 2
						haytempos = true
					end if
					rs.close
					
					'on error resume next
					base.BeginTrans
						
							
					'Borrar lineas de cupo de esas temporadas
					if haytempos then
						for t=0 to ubound(RegTempos,2)
							cs2="DELETE FROM " & precrs & "Cupos WHERE CodigoEsta=" & RegTempos(THotel,t)
							cs2=cs2 & " AND (Dia BETWEEN " & FechaMySQL(RegTempos(TFIni,t)) & " AND "
							cs2=cs2 & FechaMySQL(RegTempos(TFFin,t)) & ")"
							base.execute cs2
						next 't
					end if 'haytempos
				
					base.execute "DELETE FROM " & precrs & "Temporadas WHERE " & cs
					controlRegistro("DELETE FROM Temporadas WHERE " & cs) 'guarda seguimiento
					
					'Borrar en tipohabita precios
					cs = replace(cs, "CodigoTemp=", "Temporada=")
					base.execute "DELETE FROM " & precrs & "TipoHabitaPrecios WHERE " & cs
		
					'Borrar en DescuentosColectvios
					base.execute "DELETE FROM " & precrs & "DescuentosColectivos WHERE " & cs
					
					
					'Borrar en RéGIMEN DE LA HABITACIóN
					cs = replace(cs, "Temporada=", "CodigoTempo=")
					base.execute "DELETE FROM " & precrs & "regimenHotel WHERE " & cs
					
					
					
						'Borramos las traducciones de esta temporada						
						cs3 = "DELETE FROM " & precrs & "Traducciones WHERE Tabla = 'Temporada' AND (" & cs3 & ")"
						base.execute cs3

											
					if err.number<>0 then base.RollBackTrans
					base.CommitTrans
					on error goto 0
					
				end if
				
			case "nuevo" 'Añadir
				
				fini = cdate(fini)
				ffin = cdate(ffin)
				
				if fini > ffin then 'la fecha final es menor
					msgerror = objIdioma.getTraduccionHTML("i_errorfechas")
				end if
				
				'Comprobar que las fechas no solapen otra temporada
				cs = "SELECT CodigoTemp FROM " & precrs & "Temporadas "
				cs = cs & "WHERE ((" & FechaMySQL(fini) & " BETWEEN FInicio AND FFinal) OR "
				cs = cs & "(" & FechaMySQL(ffin) & " BETWEEN FInicio AND FFinal)) AND CodigoEsta=" & est
				'response.write cs
				rs.open cs,base
				if not rs.eof then
					msgerror = objIdioma.getTraduccionHTML("i_avisosolapan")
				end if
				rs.close
				
				if msgerror="" then 'fechas correctas

					'on error resume next
					base.BeginTrans
						
					'Añadir en temporadas
					cs = "INSERT INTO " & precrs & "Temporadas (CodigoEsta,FInicio,FFinal,ReleaseHab,Minimo,Prepago"


						' Algunas empresas tienen esta característica
						cs = cs & ",Oferta"


					cs = cs & ") VALUES ("
					cs = cs & est & "," & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
					cs = cs & release & "," & minimo & "," & quitarComa(prepago)
					

						' Algunas empresas tienen esta característica
						cs = cs & "," & oferta

					
					cs = cs & ")"
					
					base.execute cs
					'response.write cs
					controlRegistro(cs) 'guarda seguimiento
					
					'Busco el id de la ult. temporada
					cs="SELECT MAX(CodigoTemp) as IdTempo FROM " & precrs & "Temporadas"
					rs.open cs,base
					if not rs.eof then
						IdTempo=rs("IdTempo")
					end if
					rs.close
					
					'añadir en cada tarifa
					cs="SELECT Id FROM " & precrs & "Tarifas"
					rs.open cs,base
					haytarifas=false
					if not rs.eof then
						RegTari=rs.getrows
						haytarifas=true
					end if
					rs.close
					
					'Si no hay tarifas creo un a general
					if (not haytarifas) then 
						cs="INSERT INTO `jos_crs_tarifas` (`Id`, `Nombre`) VALUES (1, 'General')"
						base.execute cs
						
						'añadir en cada tarifa
						cs="SELECT Id FROM " & precrs & "Tarifas"
						rs.open cs,base
						haytarifas=false
						if not rs.eof then
							RegTari=rs.getrows
							haytarifas=true
						end if
						rs.close				
					end if
					
					
					
					if haytarifas then
						for t=0 to ubound(RegTari,2)

							'Buscar las habitaciones de esa temporada y añadir en la tabla Preciohabitacion
							cs="INSERT INTO " & precrs & "TipoHabitaPrecios (IdHabita,Temporada,Preprebase,Preperhab,Tarifa) "
							cs=cs & "SELECT Id," & idtempo & ",0,0," & RegTari(0,t) & " FROM " & precrs & "TipoHabitaNombres "
							cs=cs & "WHERE CodigoEsta=" & est 
							'response.Write(cs & "<br>" & RegTari(0,t))
							base.execute cs
							
						next
					end if 'haytarifas
					
					'Crear cupos para cada habitacion y esas fechas
					cs="SELECT IdHabita,Tarifa,FInicio,FFinal,ReleaseHab,Minimo FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "Temporadas Temporadas "
					cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
					cs=cs & "WHERE CodigoTemp=" & IdTempo
					'response.Write(cs & "<br>")
					
					rs.open cs,base
					hayLHabis=false
					if not rs.eof then
						RegLHabis=rs.getrows
						RHCodi=0
						RHTarifa=1
						RHFini=2
						RHFFin=3
						RHRelease=4
						RHMinimo=5
						hayLHabis=true
					end if
					rs.close

					if hayLHabis then
					for h=0 to ubound(RegLHabis,2)
						for fecha=RegLHabis(RHFini,h) to RegLHabis(RHFFin,h)
							cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,DiasMinimos,ReleaseHab,"
							cs=cs & "Estado,Tarifa,LimiteCheckIn) VALUES ("
							cs=cs & RegLHabis(RHCodi,h) & "," & est & "," & FechaMySQL(fecha) & ",0,0,"
							cs=cs & RegLHabis(RHMinimo,h) & "," & RegLHabis(RHRelease,h) & ",2," & RegLHabis(RHTarifa,h) & ",-1)"
							base.execute cs
						next 'fechas
					next 'h
					end if 'hayLHabis
					

					if err.number <> 0 then 
						base.RollBackTrans
						msgerror=err.number & " - " & err.description
					end if
					base.CommitTrans
					on error goto 0


						'Creamos las traducciones del campo nombre
						for idi = 0 to ubound(ListaIdiomas)
							if NombreOfertaIdiomas(idi) <> "" then 'crear registro
								cs = "INSERT INTO " & precrs & "Traducciones (IdReferencia, Idioma, Tabla, Campo, Traduccion, CodigoEsta) "
								cs = cs & "VALUES ("
								cs = cs & IdTempo & ", '" & ListaIdiomas(idi) & "', 'Temporada', 'Nombre', '"
								cs = cs & NombreOfertaIdiomas(idi) & "', " & est & ")"
								
								base.execute cs
							end if
						next						
								
				end if 'msgerror=""
			case "actu"
				
				fini = cdate(fini)
				ffin = cdate(ffin)
				
				if fini > ffin then 'la fecha final es menor
					msgerror = objIdioma.getTraduccionHTML("i_errorfechas")
				end if

				'Comprobar que las fechas no solapen otra temporada
				cs = "SELECT CodigoTemp FROM " & precrs & "Temporadas "
				cs = cs & "WHERE ((" & FechaMySQL(fini) & " BETWEEN FInicio AND FFinal) OR "
				cs = cs & "(" & FechaMySQL(ffin) & " BETWEEN FInicio AND FFinal)) AND CodigoTemp<>" & MiId
				cs = cs & " AND CodigoEsta=" & est
				rs.open cs,base
				
				if not rs.eof then
					msgerror=objIdioma.getTraduccionHTML("i_avisosolapan")
				end if
				rs.close
				
				if msgerror = "" then 'fechas correctas
			
					'on error resume next
					base.BeginTrans
					
					fini = cdate(fini)
					ffin = cdate(ffin)
					
					'Buscar fechas originales
					cs="SELECT FInicio, FFinal FROM " & precrs & "Temporadas WHERE CodigoTemp=" & MiId
					rs.open cs,base
					if not rs.eof then
						FIniOriginal = rs("finicio")
						FFinOriginal = rs("ffinal")
					end if
					rs.close
					
					cs = "UPDATE " & precrs & "Temporadas SET "
					cs = cs & "FInicio=" & FechaMySQL(fini) & ","
					cs = cs & "FFinal=" & FechaMySQL(ffin) & ","
					cs = cs & "ReleaseHab=" & release & ","
					cs = cs & "Minimo=" & minimo & ","
					cs = cs & "Prepago=" & quitarComa(prepago)
					

						' Algunas empresas tienen esta característica
						cs = cs & ",Oferta=" & oferta

					
					cs = cs & " WHERE CodigoTemp=" & MiId
					'response.write "cs: " & cs & "<br>"
					'response.End()
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
					
					'Tabla habitaciones
					cs = "SELECT Id FROM " & precrs & "TipoHabitaNombres WHERE CodigoEsta=" & est
					hayhabis = false
					rs.open cs,base
					if not rs.eof then
						RegHabis=rs.getrows
						RHCodi=0
						hayHabis=true					
					end if
					rs.close
					
					'modificar en cada tarifa
					cs="SELECT Id FROM " & precrs & "Tarifas"
					rs.open cs,base
					haytarifas=false
					if not rs.eof then
						RegTari=rs.getrows
						haytarifas=true
					end if
					rs.close
					
					if haytarifas then
					for t=0 to ubound(RegTari,2)
						'Actualiza release y estancia mínima en cupos
						cs="UPDATE " & precrs & "Cupos SET ReleaseHab=" & release & ","
						cs=cs & "DiasMinimos=" & minimo & " "
						cs=cs & "WHERE CodigoEsta=" & est & " AND (Dia BETWEEN " & FechaMySQL(fini) & " AND "
						cs=cs & FechaMySQL(ffin) & ") AND Tarifa=" & RegTari(0,t)
						'base.execute cs
						
						'Comprobar si las fechas han cambiado, para controlar los registros de cupo
						if FIniOriginal<>FIni then 
							if FIni<FIniOriginal then 'hay más días
								'crear registros cupos por cada habitacion
								if hayhabis then
								for h=0 to ubound(RegHabis,2)
									for fecha=FIni to (FIniOriginal-1)
										cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,DiasMinimos,ReleaseHab,Estado,Tarifa) VALUES ("
										cs=cs & RegHabis(RHCodi,h) & "," & est & "," & FechaMySQL(fecha) & ",0,0," & minimo & "," & release & ",2," & RegTari(0,t) & ")"
										base.execute cs
									next 'fecha
								next 'h
								end if 'hayhabis
								
							else 'menos días
								'borrar registros cupo
								cs="DELETE FROM " & precrs & "Cupos WHERE CodigoEsta=" & est
								cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FIniOriginal) & " AND "
								cs=cs & FechaMySQL(FIni-1) & ")"
								base.execute cs
							
							end if 'Fini
						
						end if 'FIniOriginal

						if FFinOriginal<>FFin then 
							if FFin>FFinOriginal then 'hay más días
								'crear registros cupos por cada habitacion
								if hayhabis then
								for h=0 to ubound(RegHabis,2)
									for fecha=(FFinOriginal+1) to FFin
										cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,DiasMinimos,ReleaseHab,Estado,Tarifa) VALUES ("
										cs=cs & RegHabis(RHCodi,h) & "," & est & "," & FechaMySQL(fecha) & ",0,0," & minimo & "," & release & ",2," & RegTari(0,t) & ")"
										base.execute cs
									next 'fecha
								next 'h
								end if 'hayhabis
								
							else 'menos días
								'borrar registros cupo
								cs="DELETE FROM " & precrs & "Cupos WHERE CodigoEsta=" & est
								cs=cs & " AND (Dia BETWEEN " & FechaMySQL(FFin+1) & " AND "
								cs=cs & FechaMySQL(FFinOriginal) & ")"
								base.execute cs
							
							end if 'Fini
						
						end if 'FIniOriginal
						
						
					next
					end if 'haytarifas
										
					if err.number<>0 then
						base.RollBackTrans
						msgerror=err.number & " - " & err.description
					end if
					base.CommitTrans
					on error goto 0
				

						'Actualiza traducciones
						
						for i = 0 to ubound(ListaIdiomas)
							'miramos si el registro existe
							cs = "SELECT Id FROM " & precrs & "Traducciones WHERE Tabla = 'Temporada' AND IdReferencia = " & MiId
							cs = cs & " AND Idioma = '" & ListaIdiomas(i) & "'"
							
							rs.open cs, base
							haytraduccion = false
							
							if not rs.eof then
								haytraduccion = true
							end if
							rs.close
							
							if haytraduccion then
								cs = "UPDATE " & precrs & "Traducciones SET"
								cs = cs & " Traduccion = '" & NombreOfertaIdiomas(i) & "'"
								cs = cs & " WHERE Tabla = 'Temporada'"
								cs = cs & " AND IdReferencia = " & MiId 
								cs = cs & " AND Idioma = '" & ListaIdiomas(i) & "'"
							
								base.execute cs
							else
								cs = "INSERT INTO " & precrs & "Traducciones (IdReferencia, Idioma, Tabla, Campo, Traduccion, CodigoEsta) "
								cs = cs & "VALUES ("
								cs = cs & MiId & ", '" & ListaIdiomas(i) & "', 'Temporada', 'Nombre', '"
								cs = cs & NombreOfertaIdiomas(i) & "', " & est & ")"
								
								base.execute cs
							end if
						next

				end if 'msgerror
		end select
		if (modo<>"") then
			cs="SELECT *	  FROM " & precrs & "cupos_temp"
			rs.open cs,base
			do while not rs.eof
				base.BeginTrans
				toExec="update jos_crs_cupos set " 
				toExec=toExec & " Cupo=" & rs("Cupo") & ",  " 
				toExec=toExec & " Precio=" & replace(rs("Precio"),",",".") & " , " 
				toExec=toExec & " DiasMinimos=" & rs("DiasMinimos") & ", " 
				toExec=toExec & " ReleaseHab=" & rs("ReleaseHab") & ", " 
				toExec=toExec & " estado=" & rs("estado") & ", " 
				toExec=toExec & " Tarifa=" & rs("Tarifa") & ", " 
				toExec=toExec & " LimiteCheckIn=" & rs("LimiteCheckIn") & " " 
				toExec=toExec & " where  " 
				toExec=toExec & " CodigoHab=" & rs("CodigoHab") & " " 
				toExec=toExec & " and CodigoEsta=" & rs("CodigoEsta") & " " 
				toExec=toExec & " and date(Dia)=" & FechaMySQL(rs("Dia")) & " " 
				'response.write toExec
				
				base.execute toExec
				base.CommitTrans
				rs.movenext
			loop
			rs.close
		end if 					
		'response.end()
		
		if msgerror="" then pasalir=1 'correcto
	end if 'msgerror=""
else
	if (deleteTemporal="") then
			base.BeginTrans

			cs2="delete from " & precrs & "Cupos_temp  "
			base.execute cs2
			'response.write  cs2
			
			if (est<>"") then 
				cs2="INSERT INTO " & precrs & "Cupos_temp  "
				cs2=cs2 &" SELECT * FROM " & precrs & "Cupos WHERE CodigoEsta=" & est
				base.execute cs2
				'response.write  cs2
			end if		
			base.CommitTrans	
	end if
end if 'form<>"


%>
