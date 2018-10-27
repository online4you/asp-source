<%
	'Buscado cod. temporada
	calcular = false
	codtem = 0
	ofertatem = 0

	if haytempos then
		for t = 0 to ubound(RegTempos, 2)
			if RegTempos(TFIni, t) <= d and RegTempos(TFFin, t) >= d then 'este es
				codtem = RegTempos(TCodi, t)
				
				if ide = 98 then
					ofertatem = RegTempos(TOferta, t)
				end if
				
				calcular = true
				
				exit for
			end if
		next 'tempos
	end if 'haytempos
	
	' Corregimos el valor de ofertatem si fuese necesario (por si el registro es null
	if ofertatem then
		ofertatem = 1
	else
		ofertatem = 0
	end if	
%>