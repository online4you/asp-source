<!--#include file="../Connections/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

'tabla errores
cs="SELECT Mensaje FROM " & precrs & "resum WHERE id=" & request.querystring("id")
rs.Open cs,base
if not rs.eof then
	response.write rs("mensaje")
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>