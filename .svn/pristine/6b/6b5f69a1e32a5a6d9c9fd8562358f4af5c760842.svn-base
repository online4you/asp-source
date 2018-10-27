<%
	thab=paClng(request.QueryString("thab"))
	'if thab=0 then thab=paClng(request.Form("codigohabi"))
	if thab=0 then thab=paClng(request.Form("esaHabi"))
	desdef=request.form("desdef")
	hastaf=request.form("hastaf")
	precio=request.form("precio") 'casi seguro que han usado el punto como separador decimal
	if precio<>"" then
		precio=paDbl(replace(precio,".",",")) 'decimales en España
	end if
	cupo=request.form("cupo")
	if cupo<>"" then cupo=paClng(cupo)
	minimos=request.form("minimos")
	if minimos<>"" then minimos=paClng(minimos)
	release=request.form("release")
	if release<>"" then release=paClng(release)
	checkin=Ucase("" & request.form("checkin"))
	if checkin="NL" then 'no tiene limite
		checkin=-1
	end if
	if checkin<>"" then checkin=paClng(checkin)
	testado=request.form("estado")
	diasSemana=request.form("diaS")
	listaFechas=split(request.form("arrayFechas"),"-")
	if ubound(listaFechas)>0 then 'seleccion fechas manual
		
		if precio<>"" or cupo<>"" or minimos<>"" or release<>"" or testado<>"" or checkin<>"" then 'hay para actualizar
				cs="UPDATE " & precrs & "Cupos SET "
				if precio<>"" then cs=cs & "Precio=" & quitarComa(precio) & ","
				if cupo<>"" then cs=cs & "Cupo=" & cupo & ","
				if minimos<>"" then cs=cs & "DiasMinimos=" & minimos & ","
				if release<>"" then cs=cs & "Release=" & release & ","
				if testado<>"" then cs=cs & "Estado=" & testado & ","
				if checkin<>"" then cs=cs & "LimiteCheckIn=" & checkin & ","
				'Quitar la ultima coma
				if right(cs,1)="," then cs=left(cs,len(cs)-1) & " "
				if thab<>0 then
					cs=cs & "WHERE CodigoHab=" & thab & " AND ("
				else 'cambia en todas las habitaciones
					cs=cs & "WHERE CodigoEsta=" & est & " AND ("
				end if 'thab=0
				for f=0 to ubound(listaFechas)
					if listaFechas(f)<>"" then
						cs=cs & "Dia=" & FechaMySQL(listaFechas(f)) & " OR "
					end if
				next 'f
				'Quitar el último OR
				if right(cs,4)=" OR " then cs=left(cs,len(cs)-4) & ")"
				'response.write cs
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
	
		end if 'datos por actualizar
		
	else 'rango de fechas

		if isdate(desdef) and isdate(hastaf) then
			if precio<>"" or cupo<>"" or minimos<>"" or release<>"" or testado<>"" or checkin<>"" then 'hay para actualizar
				cs="UPDATE " & precrs & "Cupos SET "
				if precio<>"" then cs=cs & "Precio=" & quitarComa(precio) & ","
				if cupo<>"" then cs=cs & "Cupo=" & cupo & ","
				if minimos<>"" then cs=cs & "DiasMinimos=" & minimos & ","
				if release<>"" then cs=cs & "ReleaseHab=" & release & ","
				if testado<>"" then cs=cs & "Estado=" & testado & ","
				if checkin<>"" then cs=cs & "LimiteCheckIn=" & checkin & ","
				'Quitar la ultima coma
				if right(cs,1)="," then cs=left(cs,len(cs)-1) & " "
				
				'Comprobar que dias de la semana
				if diasSemana="L, M, X, J, V, S, D" then 'son todos
					cs=cs & "WHERE (Dia BETWEEN " & FechaMySQL(desdef) & " AND " & FechaMySQL(hastaf)
					cs=cs & ") "
					if thab<>0 then
						cs=cs & "AND CodigoHab=" & thab
					else 'cambia en todas las habitaciones
						cs=cs & "AND CodigoEsta=" & est
					end if 'thab=0
					'response.write cs & "<br>"
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
				else 'ahora viene el cacao
					'Array de la semana
					dim losdias(7)
					losdias(1)="L"
					losdias(2)="M"
					losdias(3)="X"
					losdias(4)="J"
					losdias(5)="V"
					losdias(6)="S"
					losdias(7)="D"
					'Bucle de fechas
					for dd=cdate(desdef) to cdate(hastaf)
						midia=losdias(weekday(dd,vbmonday))
						if instr(diasSemana,midia)<>0 then 'este dia es gueno
							cs2="WHERE Dia=" & FechaMySQL(dd)
							if thab<>0 then
								cs2=cs2 & " AND CodigoHab=" & thab
							else 'cambia en todas las habitaciones
								cs2=cs2 & " AND CodigoEsta=" & est
							end if 'thab=0
							base.execute cs & cs2
						end if
					next 'dd
					controlRegistro(cs) 'guarda seguimiento
				end if
				
				
			end if 'actualizar
		
		else
			msgerror="Fechas no válidas"
		end if
		
	end if 'lista manual fechas
%>