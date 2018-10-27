<%

'nuevoVte tema de los Extras
cs="SELECT * "
cs=cs & "FROM Extras "
cs=cs & "WHERE CodigoEsta=" & est & " AND " & FechaMySQL(d) & " BETWEEN FInicio AND FFinal"
rs.open cs,base
sumaExtras=0
do while not rs.eof
	pelasExtra=0
	esvalido=false
	suplevalido=false
	'Busco si determina suplemento
	if rs("tiposuple")<>"" then 'comprobar
		if codsuple<>0 then 'buscar si es codigo válido
			if instr(rs("tiposuple"),codsuple)<>0 then suplevalido=true
		end if
	else
		suplevalido=true
	end if
	habivalido=false
	'Busco si determina tipo habitacion
	if rs("tipohabi")<>"" then 'comprobar
		if codhab<>0 then 'buscar si es codigo válido
			if instr(rs("tipohabi"),codhab)<>0 then habivalido=true
		end if
	else
		habivalido=true
	end if

	if suplevalido AND habivalido then esvalido=true
	if esvalido then 'es guena

		if rs("porpersona") then 'calculo por persona
			'Comprobar si hay descuento
			if rs("descuento")<>0 then
				pelasdto=rs("importe")-redondear(rs("importe")*rs("descuento")/100)
				if rs("colectivo")=clng("0" & colecninos1) then 'ninos1
					pelasExtra=pelasExtra+(pelasdto*ninos1)
				elseif rs("colectivo")=clng("0" & colecninos2) then
					pelasExtra=pelasExtra+(pelasdto*ninos2)
				end if
				if rs("descuento2")<>0 then 'mas descuento
					pelasdto=rs("importe")-redondear(rs("importe")*rs("descuento2")/100)
					if rs("colectivo2")=clng("0" & colecninos1) then 'ninos1
						pelasExtra=pelasExtra+(pelasdto*ninos1)
					elseif rs("colectivo2")=clng("0" & colecninos2) then
						pelasExtra=pelasExtra+(pelasdto*ninos2)
					end if
				end if 'dto2
				pelasExtra=pelasExtra+(rs("importe")*adultos)
			else 'pa tos mismo precio
				pelasExtra=pelasExtra+(rs("importe")*plazas)
			end if
		else 'por hab
			pelasExtra=pelasExtra+rs("importe")
		end if
		'Buscar si esa id de extra ya existe
		yahay=false
		if lextra>-1 then 'hay alguna
			for kk=0 to ubound(LIdExtra)
				if LIdExtra(kk)=rs("id") then 'ya está
					yahay=true
					exit for
				end if
			next 'kk
		end if
		if yahay then 'actualizar los importe
			LPelasExtra(kk)=LPelasExtra(kk)+pelasExtra
		else 'nueva linea
			lextra=lextra+1
			redim preserve LIdExtra(lextra)
			redim preserve LDiaExtra(lextra)
			redim preserve LTextoExtra(lextra)
			redim preserve LPelasExtra(lextra)
			LIdExtra(lextra)=rs("id")
			LDiaExtra(lextra)=rs("finicio")
			LTextoExtra(lextra)=rs("extra_" & lang)
			LPelasExtra(lextra)=pelasExtra
		end if'nueva linea extra
		sumaExtras=sumaExtras+pelasExtra
	end if 'es valido
	rs.movenext
loop 'eof
rs.close

%>