<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

todos=request.QueryString("todos")
any=paClng(request.QueryString("any"))
if any=0 then any=anyo
compara=paClng(request.QueryString("cp"))
if compara=0 then compara=any
est=paClng(request.Cookies("codiHotel"))

'Buscar reservas del año (importes)
cs="SELECT month(fechaReserva),SUM(Importe) as LasPelas "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY month(fechareserva)"
'response.write cs
hayestemesP=false
rs.open cs,base
if not rs.eof then
	RegMesP=rs.getrows
	MFechaP=0
	MPelasP=1
	hayestemesP=true
	totalIReservas=0
	for r=0 to ubound(RegMesP,2)
		totalIReservas=totalIReservas+RegMesP(MPelasP,r)
	next
	'response.write cs
end if
rs.close

if compara<>any then 'buscar los importes del otro año

	cs="SELECT month(fechaReserva),SUM(Importe) as LasPelas "
	cs=cs & "FROM " & precrs & "Reservas Reservas "
	if todos="-1" then 'Ver Todos
		cadena=replace(buscoHoteles,"WHERE ","")
		cadena=replace(cadena,"Establecimientos.","Reservas.")
		if cadena<>"" then
			cs=cs & "WHERE (" & cadena & ") AND Activa<>0 " '"WHERE Reservas.CodigoEsta<>0 "
		else
			cs=cs & "WHERE Reservas.CodigoEsta<>0 AND Activa<>0 "
		end if
	else
		cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND Activa<>0 "
	end if
	cs=cs & "AND YEAR(FechaReserva)=" & compara & " "
	cs=cs & "GROUP BY month(fechareserva)"
	'response.write cs
	hayestemesP_A=false
	rs.open cs,base
	if not rs.eof then
		RegMesP_A=rs.getrows
		MFechaP_A=0
		MPelasP_A=1
		hayestemesP_A=true
		totalIReservas_A=0
		for r=0 to ubound(RegMesP_A,2)
			totalIReservas_A=totalIReservas_A+RegMesP_A(MPelasP_A,r)
		next
	end if
	rs.close



end if 'compara<>any

if todos="-1" then
	titulo="(" & objIdioma.getTraduccion("i_ctodosloshoteles") & ")"
else
	for h=0 to ubound(RegHoteles,2)
		if RegHoteles(HCodi,h)=est then
			titulo=ucase(RegHoteles(HNombre,h))
		end if
	next
end if

set rs=nothing
base.close
set base=nothing


texto=titulo & ";" & vbcrlf & vbcrlf
texto=texto & ";"
for m=1 to 12
	texto=texto & nombreMes(m) & ";"
next
texto=texto & vbcrlf
if hayestemesP then
	'año anterior
	if hayestemesP_A then 'compara otro año
		texto=texto & objIdioma.getTraduccion("i_anyo") & " " & compara & ";"
		for m=1 to 12
			valor=0
			for r=0 to ubound(RegMesP_A,2)
				if RegMesP_A(MFechaP_A,r)=m then
					valor=redondear(RegMesP_A(MPelasP_A,r))
					exit for
				end if
			next
			texto=texto & valor & ";"
		next 'los meses			
		texto=texto & vbcrlf
	end if	'hayestemesP_A
	
	'Año actual
	texto=texto & objIdioma.getTraduccion("i_anyo") & " " & any & ";"
	for m=1 to 12
		valor=0
		for r=0 to ubound(RegMesP,2)
			if RegMesP(MFechaP,r)=m then
				valor=redondear(RegMesP(MPelasP,r))
				exit for
			end if
		next
		texto=texto & valor & ";"
	next 'los meses
	texto=texto & vbcrlf

end if 'hayestemesP

set FSO = Server.CreateObject("Scripting.FileSystemObject")
set MiFiche=FSO.CreateTextFile(server.MapPath("csv") & "\" & IdEmpresa & "_GAnyoPelas.csv",true,false) 

'guardar fihero
MiFiche.write texto
MiFiche.close
set MiFiche=nothing
set FSO=nothing
%>
<script language="javascript" type="text/javascript">
window.location="/csv/<%=IdEmpresa%>_GAnyoPelas.csv";
</script>
