<%
'Buscar tipos moneda
cs="SELECT TiposMoneda.Id,CodigoISO,PorDefecto,ISNULL(Traduccion,Nombre) AS Tradu,Abreviado "
cs=cs & "FROM TiposMoneda LEFT JOIN Traducciones "
cs=cs & "ON TiposMoneda.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TiposMoneda' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "ORDER BY Orden"
hayMonedas=false
rs.open cs,base
if not rs.eof then
	RegMonedas=rs.getrows
	RMId=0
	RMISO=1
	RMDefecto=2
	RMTradu=3
	RMBreve=4
	hayMonedas=true
end if
rs.close

monedaDefecto="EUR" 'por defecto
nombreMoneda="Euro" 'por defecto
if hayMonedas then
for m=0 to ubound(RegMonedas,2)
	if RegMonedas(RMDefecto,m) then
		monedaDefecto=RegMonedas(RMISO,m) 'codigo ISO por defecto
		nombreMoneda=RegMonedas(RMTradu,m)
		exit for
	end if
next
end if 'haymonedas
monedaHotel=monedaDefecto

%><!--#include file="conversorMoneda.asp"--><%

if hayMonedas then
for m=0 to ubound(RegMonedas,2)
	if RegMonedas(RMISO,m)=coin then
		nombreMoneda=RegMonedas(RMTradu,m)
		exit for
	end if
next
end if 'haymonedas
%>