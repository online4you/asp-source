<%
'Buscar habitaciones con personas
dim Vhabis(),Vnombreh(),Vadultos(),Vbebes(),Vninos1(),Vninos2()
dim iadultos(),ininos1(),ininos2() 'Idioma de los colectivos
dim codsuples(),nomsuples(),VImporte()

'response.write "cuantas "&request.form
cuantas=clng("0" & request.form("cuantas"))
for nh=1 to cuantas

	redim preserve Vhabis(nh)
	redim preserve Vnombreh(nh)
	redim preserve Vadultos(nh)
	redim preserve Vbebes(nh)
	redim preserve Vninos1(nh)
	redim preserve Vninos2(nh)
	redim preserve iadultos(nh)
	redim preserve ininos1(nh)
	redim preserve ininos2(nh)
	redim preserve codsuples(nh)
	redim preserve nomsuples(nh)
	redim preserve VImporte(nh)
	
	'Buscar los datos
	codigohab=clng("0" & request.form("habi_" & nh))
	Vhabis(nh)=codigohab
	Vnombreh(nh)=request.form("nombrehabi_" & nh)
	Vadultos(nh)=clng("0" & request.form("HC0_" & nh))
	Vbebes(nh)=clng("0" & request.form("HCBebes_" & nh))
	Vninos1(nh)=clng("0" & request.form("HC1_" & nh))
	Vninos2(nh)=clng("0" & request.form("HC2_" & nh))
	iadultos(nh)=request.form("nombreHC0_" & nh) 'nombre del colectivo en idioma cliente
	ininos1(nh)=request.form("nombreHC1_" & nh) 'nombre del colectivo en idioma cliente
	ininos2(nh)=request.form("nombreHC2_" & nh) 'nombre del colectivo en idioma cliente

	codsuples(nh)=clng("0" & request.form("SU_" & nh))
	nomsuples(nh)=request.form("nombresuple_" & nh)
	
	VImporte(nh)=paDbl(request.form("importe_" & nh)) 'pelas por habitacion
	
next 'nh
%>