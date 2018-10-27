<%
	'Solo cuando habis=si
if request.form<>"" then
	modo=request.QueryString("modo")
	MiId=request.form("id")
	'Valores
	orden=request.form("orden")
	tipoh=request.form("tipoh")
	
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi	paracapmax=quitarComa(request.Form("capmax"))
	
	paracapmin=paClng(request.Form("capmin"))
	paracapmax=paClng(request.Form("capmax"))
	paracapnormal=paClng(request.Form("capnormal"))
	paraAdultMax=paClng(request.Form("adultmax"))
	paraAdultMin=paClng(request.Form("adultmin"))
	paraNiMax=paClng(request.Form("ninmax"))
	cunaocupa=paClng(request.Form("cunaocupa"))
	admiteninos=paClng(request.Form("admiteninos"))
	prePago=paClng(request.Form("prePago"))
	
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				'on error resume next
				base.BeginTrans
			
				cs=""
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute "DELETE FROM " & precrs & "TipoHabitaNombres WHERE " & cs
				
				'Borrar precios Habitacion
				cs=replace(cs,"Id=","IdHabita=")
				base.execute "DELETE FROM " & precrs & "TipoHabitaPrecios WHERE " & cs
				controlRegistro("DELETE FROM TipoHabitaPrecios WHERE " & cs) 'guarda seguimiento
			
				'Borrar en DescuentosColectvios
				cs=replace(cs,"IdHabita=","TipoHab=")
				base.execute "DELETE FROM " & precrs & "DescuentosColectivos WHERE " & cs

				'Busco los cod. de suplementos para poder borrar en las tablas relacionadas
				cs=replace(cs,"TipoHab=","CodigoHab=")
				
				'Borrar en la tabla suplementosTempo
				base.execute "DELETE FROM " & precrs & "RegimenHotel WHERE " & cs
				
				'Borrar en cupo habitaciones
				base.execute "DELETE FROM " & precrs & "Cupos WHERE " & cs
				
				
				rs.open "SELECT Id FROM " & precrs & "RegimenHotel WHERE " & cs,base
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
				
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0

			end if
		case "duplica" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)=0 then
				'on error resume next
				base.BeginTrans
				
				idHabita=trim(queborro(t))
				HAnyo=request.form("HAnyo")
				HSeleccionado=request.form("HSeleccionado")
				
				intro=chr(13)& chr(10)

cs="insert into jos_crs_TipoHabitaNombres ( " & intro
cs= cs & "TipoHabitacion,CodigoEsta,Nombre,ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,ParaCapNormal,ParaAdultMin,Orden,CunaOcupa,AdmiteNinos,prePago) " & intro
cs= cs & "select  " & intro
cs= cs & "nom.TipoHabitacion,nom.CodigoEsta,SUBSTRING(CONCAT('Copia de ', nom.Id, ' ', nom.Nombre),1,50),nom.ParaCapMax,nom.ParaCapMin,nom.ParaAdultMax,nom.ParaNiMax,nom.ParaCapNormal,nom.ParaAdultMin,nom.Orden,nom.CunaOcupa,nom.AdmiteNinos,nom.prePago " & intro
cs= cs & "from jos_crs_TipoHabitaNombres nom where nom.CodigoEsta=" & HSeleccionado & intro
cs= cs & "and nom.Id=" & idHabita & intro

				'response.write cs & intro
				base.execute cs
				
cs="insert into jos_crs_TipoHabitaPrecios (IdHabita,Temporada,PrePreBase,PrePerHab,Anyo,Tarifa) " & intro
cs= cs & "select  " & intro
cs= cs & "(select max(id) from jos_crs_TipoHabitaNombres),pre.Temporada,pre.PrePreBase,pre.PrePerHab,pre.Anyo,pre.Tarifa " & intro
cs= cs & "from jos_crs_TipoHabitaPrecios pre " & intro
cs= cs & "where pre.IdHabita=" & idHabita & intro
				
				'response.write cs & intro
				base.execute cs
				
cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,ReleaseHab,DiasMinimos,Estado,Tarifa) "  & intro
cs= cs & "select  " & intro
cs= cs & "(select max(id) from jos_crs_TipoHabitaNombres),cu.CodigoEsta ,cu.Dia,cu.Cupo,cu.Precio,cu.ReleaseHab,cu.DiasMinimos,cu.Estado,cu.Tarifa " & intro
cs= cs & "from " & precrs & "Cupos cu where cu.CodigoEsta=" & HSeleccionado & intro
cs= cs & "and cu.CodigoHab=" & idHabita & intro

				'response.write cs & intro
				base.execute cs
				
cs="insert into jos_crs_DescuentosColectivos (  " & intro
cs= cs & "CodigoColec,Temporada,TipoHab,Prebase,Precio,Anyo,Tarifa,DesdePlazas,HastaPlazas) " & intro
cs= cs & "select  " & intro
cs= cs & "des.CodigoColec,des.Temporada,(select max(id) from jos_crs_TipoHabitaNombres),des.Prebase,des.Precio,des.Anyo,des.Tarifa,des.DesdePlazas,des.HastaPlazas " & intro
cs= cs & "from jos_crs_DescuentosColectivos des " & intro
cs= cs & "where Anyo=" & HAnyo & " " & intro
cs= cs & "and TipoHab=" & idHabita  & intro		
				
				'response.write cs & intro
				base.execute cs
				
cs="insert into jos_crs_RegimenHotel ( " & intro
cs= cs & "IdRegimen,CodigoEsta,CodigoHab,CodigoTempo,Precio,Defecto,ANYO,Tarifa) " & intro
cs= cs & "select  " & intro
cs= cs & "reg.IdRegimen,reg.CodigoEsta,(select max(id) from jos_crs_TipoHabitaNombres),reg.CodigoTempo,reg.Precio,reg.Defecto,reg.ANYO,reg.Tarifa " & intro
cs= cs & "from jos_crs_RegimenHotel reg " & intro
cs= cs & "where CodigoEsta=" & HSeleccionado & " " & intro
cs= cs & "and CodigoHab=" & idHabita  & intro
	
				'response.write cs & intro
				base.execute cs
				
'insert into jos_crs_RegimenDtos (
'IdRegimenHotel,CodigoColec,Descuento,Precio,Tarifa,DesdePlazas,HastaPlazas)
'select 
'regdes.IdRegimenHotel,regdes.CodigoColec,regdes.Descuento,regdes.Precio,regdes.Tarifa,regdes.DesdePlazas,regdes.HastaPlazas
'from jos_crs_RegimenDtos regdes
'where IdRegimenHotel in (select id from jos_crs_RegimenHotel where CodigoEsta=373)

'Añadir traducciones
					
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
				
			end if	
		case "nuevo" 'Añadir
			'on error resume next
			base.BeginTrans
			
			cs="INSERT INTO " & precrs & "TipoHabitaNombres (TipoHabitacion,Nombre,CodigoEsta,Orden,ParaCapMax,"
			cs=cs & "ParaCapMin,ParaCapNormal,ParaAdultMax,ParaNiMax,CunaOcupa,ParaAdultMin,AdmiteNinos) VALUES ("
			cs=cs & tipoh & ",'" & nombre & "'," & est & "," & orden & "," & paracapmax & "," & paracapmin & ","
			cs=cs & paracapnormal & "," & paraAdultMax & "," & paraNiMax & "," & cunaocupa & ","
			cs=cs & paraAdultMin & "," & admiteninos & ")"				
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento

			'Busco el id de la ult. habi.
			cs="SELECT MAX(Id) as idhabi FROM " & precrs & "TipoHabitaNombres"
			rs.open cs,base
			if not rs.eof then
				idhabi=rs("idhabi")
			end if
			rs.close
			laid=idhabi 'Para qu cargue la ficha que acabo de crear
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & IdHabi & ",'" & listaIdiomas(idi) & "','TipoHabitaNombres','Nombre','"
					cs=cs & TIdiomas(idi) & "')"
					base.execute cs
					'response.write cs & "<br>"
				end if
			next 'idi
			
			
			'Temporadas de ese hotel
			cs="SELECT CodigoTemp,FInicio,FFinal,ReleaseHab,Minimo FROM " & precrs & "Temporadas "
			cs=cs & "WHERE CodigoEsta=" & est
			cs=cs & " ORDER BY FInicio"
			'response.write cs & "<br>"
			rs.open cs,base
			haytempos=false
			if not rs.eof then
				RegTempos=rs.getrows
				TCodi=0
				TFini=1
				TFFin=2
				TRelease=3
				TMinimos=4
				haytempos=true
			end if
			rs.close
			
						
			cs="SELECT Id FROM " & precrs & "Tarifas"
			rs.open cs,base
			haytarifas=false
			if not rs.eof then
				RegTari=rs.getrows
				haytarifas=true
			end if
			rs.close
			
			if haytarifas then
			for tt=0 to ubound(RegTari,2)
					
				'Añadir Precios habitacion por temporada
				for t=0 to ubound(RegTempos,2)
					cs="INSERT INTO " & precrs & "TipoHabitaPrecios (IdHabita,Temporada,PrePreBase,PreperHab,Tarifa) VALUES ("
					cs=cs & idhabi & "," & RegTempos(TCodi,t) & ",0,0," & RegTari(0,tt) & ")"
					base.execute cs
			
					'crear registro cupos de esa habitacion
					for fecha=RegTempos(TFIni,t) to RegTempos(TFFin,t)
						cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo,Precio,ReleaseHab,DiasMinimos,"
						cs=cs & "Estado,Tarifa) VALUES ("
						cs=cs & IdHabi & "," & est & "," & FechaMySQL(fecha) & ",0,0,"
						cs=cs & RegTempos(TRelease,t) & "," & RegTempos(TMinimos,t) & ",2," & RegTari(0,tt) & ")"
						base.execute cs
					next 'fecha
					
				next 't			
				
			next
			end if 'haytarifas
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0

			
		case "actu"
			'on error resume next
			base.BeginTrans
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "TipoHabitaNombres SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "TipoHabitacion=" & tipoh & ","
			cs=cs & "ParaCapMax=" & paracapmax & ","
			cs=cs & "ParaCapMin=" & paracapmin & ","
			cs=cs & "ParaCapNormal=" & paracapnormal & ","
			cs=cs & "ParaAdultMax=" & paraAdultMax & ","
			cs=cs & "ParaAdultMin=" & paraAdultMin & ","
			cs=cs & "ParaNiMax=" & paraNiMax & ","
			cs=cs & "CunaOcupa=" & cunaocupa & ","
			cs=cs & "AdmiteNinos=" & admiteninos & ","
			cs=cs & "Orden=" & orden & ", "
			cs=cs & "prePago=" & prePago & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			laid=MiId
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
				
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='TipoHabitaNombres' AND Campo='Nombre' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','TipoHabitaNombres','Nombre','"
						cs=cs & TIdiomas(idi) & "'," & est & ")"
						base.execute cs
					end if 'eof
					rs.close
					
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='TipoHabitaNombres' AND Campo='Nombre' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
					
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
	end select

end if 'form<>""
%>