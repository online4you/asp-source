<%
'Buscar habitaciones con personas
dim Vhabis(),Vnombreh(),Vadultos(),Vbebes(),Vninos1(),Vninos2()
dim iadultos(),ininos1(),ininos2() 'Idioma de los colectivos
dim codsuples(),nomsuples(),VImporte(),prepagoHab()

'response.write "cuantas "&request.form
cuantas=clng("0" & request.form("cuantas"))
if cuantas=0 then cuantas=paClng(request.QueryString("cuantas"))

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
	redim preserve prepagoHab(nh)
	
	'Buscar los datos
	codigohab=clng("0" & request.form("habi_" & nh))
if codigohab=0 then codigohab=clng("0" & request.QueryString("habi_" & nh))
	Vhabis(nh)=codigohab
	
	Vnombreh(nh)=request.form("nombrehabi_" & nh)
if Vnombreh(nh)="" then Vnombreh(nh)=request.QueryString("nombrehabi_" & nh)
	Vadultos(nh)=clng("0" & request.form("HC0_" & nh))
if Vadultos(nh)=0 then Vadultos(nh)=paClng(request.QueryString("HC0_" & nh))
	Vbebes(nh)=clng("0" & request.form("HCBebes_" & nh))
if Vbebes(nh)=0 then Vbebes(nh)=paClng(request.QueryString("HCBebes_" & nh))
	Vninos1(nh)=clng("0" & request.form("HC1_" & nh))
if Vninos1(nh)=0 then Vninos1(nh)=paClng(request.QueryString("HC1_" & nh))
	Vninos2(nh)=clng("0" & request.form("HC2_" & nh))
if Vninos2(nh)=0 then Vninos2(nh)=paClng(request.QueryString("HC2_" & nh))
	iadultos(nh)=request.form("nombreHC0_" & nh) 'nombre del colectivo en idioma cliente
if iadultos(nh)="" then iadultos(nh)=request.QueryString("nombreHC0_" & nh)
	ininos1(nh)=request.form("nombreHC1_" & nh) 'nombre del colectivo en idioma cliente
if ininos1(nh)="" then ininos1(nh)=request.QueryString("nombreHC1_" & nh)
	ininos2(nh)=request.form("nombreHC2_" & nh) 'nombre del colectivo en idioma cliente
if ininos2(nh)="" then ininos2(nh)=request.QueryString("nombreHC2_" & nh)
	codsuples(nh)=clng("0" & request.form("SU_" & nh))
if codsuples(nh)=0 then codsuples(nh)=paClng(request.QueryString("SU_" & nh))
	nomsuples(nh)=request.form("nombresuple_" & nh)
if nomsuples(nh)="" then nomsuples(nh)=request.QueryString("nombresuple_" & nh)
	'VImporte(nh)=paDbl(request.form("importe_" & nh)) 'pelas por habitacion
	VImporte(nh)=paDbl(request.form("precioHab_" & nh)) 'pelas por habitacion en bruto
if VImporte(nh)=0 then VImporte(nh)=paDbl(request.QueryString("precioHab_" & nh))
	prepagoHab(nh)=request.form("prepagoHab_" & nh) 'prepago
if prepagoHab(nh)="" then prepagoHab(nh)=request.QueryString("prepagoHab_" & nh)

next 'nh
%>