<!--#include file="validoUser.asp"-->
<!--#include file="Funciones.asp"-->
<%
Const adSchemaTables = 20
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
base.Open ConectaMDB

strFiltro = Array(Empty,Empty,Empty,"TABLE")
Set Rs = base.OpenSchema(adSchemaTables,strFiltro) 'solo carga las tablas
'Set Rs = base.OpenSchema(adSchemaTables)
do While not Rs.EOF
	response.write rs("TABLE_NAME") & "<br>"
	Rs.MoveNext
loop

rs.close
set rs=nothing
base.close
set base=nothing


%>