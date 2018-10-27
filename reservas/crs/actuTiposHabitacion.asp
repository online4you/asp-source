<%
if request.form<>"" then 'Actualizar
	'valores form
	nombre=QuitarApos(request.form("nombre_" & langPorDefecto))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("nombre_" & listaIdiomas(idi)))
	next 'idi
	
	capmax=paClng(request.form("ParaCapMax"))
	capmin=paClng(request.form("ParaCapMin"))
	capnormal=paClng(request.form("ParaCapNormal"))
	adultmax=paClng(request.form("AdultMax"))
	adultmin=paClng(request.form("AdultMin"))
	ninmax=paClng(request.form("NinMax"))
	orden=paClng(request.form("orden"))

	modo=request.QueryString("modo")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="("
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				cs=cs & ")"
				
				on error resume next
				base.BeginTrans
			
				base.execute "DELETE FROM " & precrs & "TipoHabita WHERE " & cs
				controlRegistro("DELETE FROM " & precrs & "TipoHabita WHERE " & cs) 'guarda seguimiento
				
				'Borrar traducciones
				cs=replace(cs,"Id=","IdReferencia=")
				base.execute "DELETE FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='TipoHabita'"
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0

			end if
			
		case "nuevo" 'Añadir
			on error resume next
			base.BeginTrans
			
			'Añadir
			cs="INSERT INTO " & precrs & "TipoHabita (Nombre,ParaCapMax,ParaCapMin,ParaAdultMax,"
			cs=cs & "ParaNiMax,ParaCapNormal,Orden,ParaAdultMin) VALUES ('"
			cs=cs & nombre & "'," & capmax & "," & capmin & "," & adultmax & ","
			cs=cs & ninmax & "," & capnormal & "," & orden & "," & adultmin & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Busxcar la ultima Id
			cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoHabita"
			rs.open cs,base
			laUlti=0
			if not rs.eof then
				laulti=paClng(rs("ulti"))
			end if
			rs.close
			
			'Añadir traducciones
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'crear registro
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & laulti & ",'" & listaIdiomas(idi) & "','TipoHabita','Nombre','"
					cs=cs & TIdiomas(idi) & "')"
					base.execute cs
					'response.write cs & "<br>"
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
		case "actu"
			MiId=request.form("id")
			
			on error resume next
			base.BeginTrans
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "TipoHabita SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "ParaCapMax=" & capmax & ","
			cs=cs & "ParaCapMin=" & capmin & ","
			cs=cs & "ParaAdultMax=" & adultmax & ","
			cs=cs & "ParaAdultMin=" & adultmin & ","
			cs=cs & "ParaNiMax=" & ninmax & ","
			cs=cs & "ParaCapNormal=" & capnormal & ","
			cs=cs & "Orden=" & orden & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actu traduccion
			for idi=1 to ubound(ListaIdiomas)
				if TIdiomas(idi)<>"" then 'buscar si existe
					cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='TipoHabita' AND Campo='Nombre' AND "
					cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
					rs.open cs,base
					if not rs.eof then
						cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
						cs=cs & "WHERE Id=" & rs("id")
						base.execute cs
					
					else
						cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
						cs=cs & MiId & ",'" & listaIdiomas(idi) & "','TipoHabita','Nombre','"
						cs=cs & TIdiomas(idi) & "')"
						base.execute cs
					end if 'eof
					rs.close
				else 'borrarlo si esta en blanco
					
					cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='TipoHabita' AND Campo='Nombre' "
					cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
					base.execute cs
					
				end if
			next 'idi
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0

			
	end select
	pasalir=1
end if 'form<>""
%>