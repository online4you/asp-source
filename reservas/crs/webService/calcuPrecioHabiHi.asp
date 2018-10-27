<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.QueryString("est")) 'el hotel

'datos hotel
cs="SELECT DatosHotel.CodigoEsta,Nombre,Estado,Categoria,TipoAlojamiento,Zona,PorCiento "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel ON "
cs=cs & "Establecimientos.CodigoEsta=DatosHotel.CodigoEsta WHERE DatosHotel.CodigoEsta=" & est
rs.Open cs, base
if not rs.eof then
	'Variables para la tabla RegHoteles
	nhotel="" & rs("Nombre")
	estado=paClng(rs("estado"))
	categoria=rs("categoria")
	tipoaloja=rs("tipoalojamiento")
	zona=rs("zona")
	prepago=rs("porciento")
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<center><h2>Hotel no encontrado</h2></center>"
	response.End()
end if
rs.close

FLlegada=cdate(request.QueryString("fini"))
FSalida=cdate(request.QueryString("ffin"))
anyo=year(FLlegada)
noches=FSalida-FLlegada
lang=request.QueryString("lang")

'Datos la habitacion
codhab=clng("0" & request.QueryString("codhab"))
adultos=clng("0" & request.QueryString("ad"))
ninos1=clng("0" & request.QueryString("ni1"))
ninos2=clng("0" & request.QueryString("ni2"))
codsuple=clng("0" & request.QueryString("codsup"))

'Buscar los colectivos de este hotel
cs="SELECT CodigoColec,Orde FROM " & precrs & "Colectivos "
cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY orde"
'response.write "cs: " & cs & "<br>"
colecadultos=0
colecninos1=0
colecninos2=0
rs.open cs,base
do while not rs.eof
	if rs("orde")=0 then colecadultos=rs("CodigoColec") 'codigo adultos
	if rs("orde")=1 then colecninos1=rs("CodigoColec") 'codigo ninos1
	if rs("orde")=2 then colecninos2=rs("CodigoColec") 'codigo ninos2
	rs.movenext
loop
rs.close

'dias semana
dim diasemana(7)
diasemana(1)="L"
diasemana(2)="M"
diasemana(3)="X"
diasemana(4)="J"
diasemana(5)="V"
diasemana(6)="S"
diasemana(7)="D"

'Array de las lineas de reserva
dim PrecioHab(),Preciosuples(),TotalSuples(),PrecioPlazas(),DtoHab(),DtoSuples()
dim FechaRes(),PrecioPerso()
dim OfertaHab(),OfertaRegimen()
dim TotalOferta(),CodiOferta(),TextoOferta()
redim preserve PrecioHab(noches)
redim preserve PrecioPerso(noches)
redim preserve FechaRes(noches)
redim preserve PrecioSuples(noches)
redim preserve PrecioPlazas(noches)
redim preserve DtoHab(noches)
redim preserve DtoSuples(noches)
redim preserve TotalSuples(noches)
redim preserve OfertaHab(noches)
redim preserve OfertaRegimen(noches)
redim preserve totalOferta(noches)
redim preserve codiOferta(noches)
redim preserve textoOferta(noches)

'extras, galas
dim LIdExtra(),LDiaExtra(),LTextoExtra(),LPelasExtra()
lextra=-1

anteriorTempo=-1
sumabruto=0
dia=0 'dias de reserva
for d=FLlegada to FSalida-1
	dia=dia+1 'dias de reserva
	FechaRes(dia)=d 'Dia de la reserva
	anyo=year(d)
	%><!--#include file="calcuTemporada.asp"--><%
	if calcular then 
		%><!--#include file="tieneOferta.asp"--><%
		%><!--#include file="precioHabi.asp"--><%
		%><!--#include file="Dto3Persona.asp"--><%
		%><!--#include file="PrecioRegimen.asp"--><%
		%><!--#include file="DtosRegimen.asp"--><%
		%><!--#include file="precioExtra.asp"--><%
		'Comprobar si hay oferta para el precio total reserva
		if hayOferta then
			%><!--#include file="CalculaOferta.asp"--><%
		end if 'hayOferta
	end if
next 'dia

'Importe reserva
SumaHabi=0
SumaSuple=0
SumaDto3=0
SumaDtoSuple=0
for d=1 to noches
	sumaHabi=sumaHabi+PrecioPlazas(d)
	sumaDto3=sumaDto3+DtoHab(d)
	sumaSuple=sumaSuple+TotalSuples(d)
	sumaDtoSuple=sumaDtoSuple+dtoSuples(d)
next
sumaBruto=SumaHabi+SumaSuple-(SumaDto3+SumaDtoSuple) 'Total Bruto reserva


if lextra>-1 then
	for kk=0 to ubound(LPelasExtra)
		sumaExtras=sumaExtras+LPelasExtra(kk)
	next 'kk
end if 'lextra

sumabruto=sumabruto+sumaExtras

set rs=nothing
base.close
set base=nothing

'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
response.write "<hotel>" & nhotel & "</hotel>" & vbcrlf
response.write "<categoria>" & categoria & "</categoria>" & vbcrlf
response.write "<zona>" & zona & "</zona>" & vbcrlf
response.write "<tipoaloja>" & tipoaloja & "</tipoaloja>" & vbcrlf
response.write "<estado>" & estado & "</estado>" & vbcrlf
response.write "<prepago>" & prepago & "</prepago>" & vbcrlf
response.write "<totalbruto>" & sumabruto & "</totalbruto>" & vbcrlf
'Ofertas
anter=-1
for d=1 to noches
	if codiOferta(d)<>anter then 'otra oferta o la primera
		response.write "<oferta>" & vbcrlf	
		response.write vbtab & "<codioferta>" & codiOferta(d) & "</codioferta>" & vbcrlf
		response.write vbtab & "<textooferta>" & textoOferta(d) & "</textooferta>" & vbcrlf
		'Buscar cuantas hay de esta oferta
		sumaOferta=0
		for pp=1 to noches
			if codiOferta(pp)=codiOferta(d) then sumaOferta=sumaOferta+totalOferta(pp)
		next
		response.write vbtab & "<totaloferta>" & sumaOferta & "</totaloferta>" & vbcrlf
		response.write "</oferta>" & vbcrlf	
		sumaOferta=0
	end if
	anter=codiOferta(d) 'pa controlar si cambia de oferta
next

if lextra>-1 then
	for kk=0 to ubound(LPelasExtra)
		response.write "<extra>" & vbcrlf	
		response.write vbtab & "<codiextra>" & LIdExtra(kk) & "</codiextra>" & vbcrlf
		response.write vbtab & "<textoextra>" & LTextoExtra(kk) & "</textoextra>" & vbcrlf
		response.write vbtab & "<totalextra>" & LPelasExtra(kk) & "</totalextra>" & vbcrlf
		response.write "</extra>" & vbcrlf	
	next 'kk
end if 'lextra


'if hayOfertaFR or HayOfertaFE then
	'for o=0 to ubound(RegLOfertas,2)
	'response.write "<oferta>" & vbcrlf	
	'response.write vbtab & "<codioferta>" & codiOferta(o) & "</codioferta>" & vbcrlf
	'response.write vbtab & "<textooferta>" & textoOferta(o) & "</textooferta>" & vbcrlf
	'response.write vbtab & "<totaloferta>" & totalOferta(o) & "</totaloferta>" & vbcrlf
	'response.write "</oferta>" & vbcrlf	
	'next 'o
'end if
for d=1 to noches
	response.write "<reserva>" & vbcrlf
	response.write vbtab & "<dia>" & fechaRes(d) & "</dia>" & vbcrlf
	response.write vbtab & "<codhab>" & codhab & "</codhab>" & vbcrlf
	response.write vbtab & "<nomhab>" & nombrehabi & "</nomhab>" & vbcrlf
	response.write vbtab & "<preciohab>" & precioPlazas(d) & "</preciohab>" & vbcrlf
	response.write vbtab & "<dtohab>" & dtohab(d) & "</dtohab>" & vbcrlf
	response.write vbtab & "<nomsuple>" & nombresuple & "</nomsuple>" & vbcrlf
	response.write vbtab & "<preciosuple>" & totalSuples(d) & "</preciosuple>" & vbcrlf
	response.write vbtab & "<dtosuple>" & dtoSuples(d) & "</dtosuple>" & vbcrlf
	response.write "</reserva>" & vbcrlf
next
response.write "</data>"



%>