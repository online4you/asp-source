<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

dim TIdioma(3),carpetaIdioma(3)
TIdioma(1)="es"
TIdioma(2)="en"
TIdioma(3)="de"
carpetaIdioma(1)="/hoteles-mallorca"
carpetaIdioma(2)="/majorca-hotels"
carpetaIdioma(3)="/mallorca-hotels"


cs="SELECT CodigoEsta,Nombre,Nombre_es,TipoAlojamiento "
cs=cs & "FROM " & precrs & "ConsultaHoteles ConsultaHoteles INNER JOIN " & precrs & "Nucleos Nucleos "
cs=cs & "ON ConsultaHoteles.Zona=Nucleos.Id "
cs=cs & "WHERE Estado<>0 "
cs=cs & "ORDER BY Nombre"
rs.open cs,base
hayficha=false
if not rs.eof then
	hayficha=true
	RegHoteles=rs.Getrows
	HCodi=0
	HNombre=1
	HZona=2
	HTAloja=3
end if
rs.close

if hayficha then
	
	'Generar las paginas
	Response.write "<b>HOTELES</b>" & "<br><br>"
	for h=0 to ubound(RegHoteles,2)
		MiId=RegHoteles(HCodi,h)
		nhotel=RegHoteles(HNombre,h)
		pagina=RegHoteles(HPagina,h)
		'on error resume next
		for ti=1 to ubound(TIdioma)
			GenerarHTM pagina,TIdioma(ti),ti
		next
		Response.write "Establecimiento: " & MiId & " - " & nhotel & " --> <br> "
		'if error.number<>0 then
		'	response.write "Error<br>"
		'else
		'	response.write "Correcta<br>"
		'end if
		'err.clear
	next
end if 'hayficha

set rs=nothing
base.close
set base=nothing
%> 
