<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta

est=paClng(request.QueryString("est"))
laid=paClng(request.QueryString("id"))
marca=paClng(request.QueryString("marca"))

if marca then 'añadir registro
	cs="INSERT INTO " & precrs & "CaracteristicasHotel (IdCaracter,CodigoEsta) VALUES ("
	cs=cs & laid & "," & est & ")"
	base.execute cs
	controlRegistro(cs)
else 'desmarcar registro (elimina)
	cs="DELETE FROM " & precrs & "CaracteristicasHotel WHERE IdCaracter=" & laid & " AND CodigoEsta=" & est
	base.execute cs
	controlRegistro(cs)
end if 'marca

base.close
set base=nothing
%>