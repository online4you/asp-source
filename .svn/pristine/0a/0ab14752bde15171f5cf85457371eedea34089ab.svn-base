<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta

idf=paClng(request.QueryString("idf")) 'id foto
recarga=request.QueryString("recarga")
ord=paClng(request.QueryString("ord")) 'orden
tabla=request.QueryString("tabla")

cs="UPDATE " & tabla & " SET Orden=" & ord
cs=cs & " WHERE Id=" & idf
base.execute cs
'response.write cs
base.close
set base=nothing
%>
<script type="text/javascript">
lapag=top.<%=recarga%>.location.href;
top.<%=recarga%>.location=lapag;
</script>
