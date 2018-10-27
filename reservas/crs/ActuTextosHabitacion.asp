<%
if request.form<>"" then 'hay que actualizar
	'Valores del form
	MiId=paclng(request.Form("id"))
	texto=QuitarApos(request.form("texto_" & langPorDefecto))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi
	
	'on error resume next
	base.BeginTrans
	
	cs="UPDATE " & precrs & "HabitacionesHotel SET "
	cs=cs & "Texto='" & texto & "' "
	cs=cs & "WHERE IdHabitacion=" & MiId
	'response.Write(cs)
	base.execute cs
	
	'Actu traduccion
	for idi=1 to ubound(ListaIdiomas)
		if TIdiomas(idi)<>"" then 'buscar si existe
			cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='HabitacionesHotel' AND Campo='Texto' AND "
			cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & MiId
			rs.open cs,base
			if not rs.eof then
				cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
				cs=cs & "WHERE Id=" & rs("id")
				base.execute cs
			
			else
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & MiId & ",'" & listaIdiomas(idi) & "','HabitacionesHotel','Texto','"
				cs=cs & TIdiomas(idi) & "'," & est & ")"
				base.execute cs
			end if 'eof
			rs.close
		else 'borrarlo si esta en blanco
			
			cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='HabitacionesHotel' AND Campo='Texto' "
			cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & MiId
			base.execute cs
			
		end if
	next 'idi
	
	if err.number<>0 then base.RollBackTrans
	base.CommitTrans
	on error goto 0
			
end if 'modo

%>