<%
	'Buscado cod. temporada
	calcular=false
	codtem=0
	if haytempos then
	for t=0 to ubound(RegTempos,2)
		if RegTempos(TFIni,t)<=d and RegTempos(TFFin,t)>=d then 'este es
			codtem=RegTempos(TCodi,t)
			calcular=true
			exit for
		end if
	next 'tempos
	end if 'haytempos
%>