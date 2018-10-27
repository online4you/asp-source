<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

MiId=request.querystring("id")
if MiId="" then MiId=request.Cookies("laid")
'Buscar los datos del mapa
cs="SELECT * FROM " & precrs & "ComoLlegar WHERE CodigoEsta=" & MiId
rs.open cs,base
if not rs.eof then
	texto_es=rs("texto1_es")
	texto_en=rs("texto1_en")
	texto_de=rs("texto1_de")
	nodos=rs("nodos")
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<?xml version="1.0" encoding="utf-8"?>
<data>
<texto_es><%=server.HTMLEncode("" & texto_es)%></texto_es>
<texto_en><%=server.HTMLEncode("" & texto_en)%></texto_en>
<texto_de><%=server.HTMLEncode("" & texto_de)%></texto_de>
<%response.write nodos%>
</data>
