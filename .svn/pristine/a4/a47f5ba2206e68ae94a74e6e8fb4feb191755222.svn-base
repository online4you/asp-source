<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

query=request.QueryString("query")
if (query<>"") then
	cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " 
	cs=cs & " where ucase(Nombre) like '%"&ucase(query)&"%'"
	cs=cs & " ORDER BY Nombre"
	'response.write cs & "<br>"
	rs.Open cs, base
	HayHoteles=false
	if not rs.eof then
		response.write rs("CodigoEsta")
	end if
	rs.close
end if
%>