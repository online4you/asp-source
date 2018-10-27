<%
'Buscar habitaciones con personas
dim habis(),adultos(),bebes(),ninos1(),ninos2()
dim codsuples(),HImporte(), prepagoHab()
dim colecadultos(),colecninos1(),colecninos2() 'Codigo de los colectivos (se usa en los dtos)

cuantas=paClng(request.Querystring("cuantas"))
for nh=1 to cuantas

	redim preserve habis(nh)
	redim preserve cuantash(nh)
	redim preserve adultos(nh)
	redim preserve bebes(nh)
	redim preserve ninos1(nh)
	redim preserve ninos2(nh)
	redim preserve codsuples(nh)
	redim preserve colecadultos(nh)
	redim preserve colecninos1(nh)
	redim preserve colecninos2(nh)
	redim preserve HImporte(nh)
	redim preserve prepagoHab(nh)
	
	'Buscar los datos
	codigohab=paClng(request.Querystring("habi-" & nh))
	habis(nh)=codigohab
	adultos(nh)=paClng(request.Querystring("adultos-" & nh))
	bebes(nh)=paClng(request.Querystring("bebes-" & nh))
	ninos1(nh)=paClng(request.Querystring("ninos1-" & nh))
	ninos2(nh)=paClng(request.Querystring("ninos2-" & nh))
	codsuples(nh)=paClng(request.Querystring("suple-" & nh))
	HImporte(nh)=PaDbl(request.Querystring("importe-" & nh))
	prepagoHab(nh)=PaDbl(request.Querystring("prepago-" & nh))
	
next 'nh
%>