<%
'estadoHab de la habitacion
select case RegPrecios(PEstadoHab,prec)
	case 0 'No venta
		estadoHab="NV"
	case 1 'On Request sólo en caso de que no halla ningun día - No Venta
		if estadoHab<>"NV" then estadoHab="OR"
	case 2 'On Line
		if estadoHab<>"NV" AND estadoHab<>"OR" then estadoHab="OL"
end select

'estanc. minima de la habitacion
if RegPrecios(PMinimos,prec)<noches then diasMinimos=RegPrecios(PMinimos,prec)

'control release
if (date+RegPrecios(PRelease,prec))>FechaRes(dia) then Release=RegPrecios(PRelease,prec)

%>