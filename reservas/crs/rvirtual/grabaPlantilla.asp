<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

pl=clng("0" & request.QueryString("pl"))
if pl=0 then 'Añadir o actualizar
	nombre=quitarApos(request.QueryString("titu"))
	mensaje=request.form("mensaje")
	mensaje=replace(mensaje,"'",chr(34))
	'Buscar si ese nombre existe
	cs="SELECT Id FROM " & precrs & "PlantillasNews WHERE Nombre='" & nombre & "'"
	rs.open cs,base
	if not rs.eof then
		laid=rs("id")
		rs.close
		'Actualizar
		cs="UPDATE " & precrs & "PlantillasNews SET Plantilla='" & mensaje & "' WHERE Id=" & laid
		base.execute cs
	else
		rs.close
		'Añadir
		cs="INSERT INTO " & precrs & "PlantillasNews (Nombre,Plantilla) VALUES ('"
		cs=cs & nombre & "','" & mensaje & "')"
		base.execute cs
		'Buscar la id
		cs="SELECT Max(Id) as Ulti FROM " & precrs & "PlantillasNews"
		rs.open cs,base
		if not rs.eof then
			laid=clng("0" & rs("ulti"))
		end if
		rs.close
	end if

else 'Borrar plantilla

	cs="DELETE FROM " & precrs & "PlantillasNews WHERE Id=" & pl
	base.execute cs
	laid=0
end if
set rs=nothing
base.close
set base=nothing

volver=request.querystring("volver")
response.Redirect volver & "?pl=" & laid
%>