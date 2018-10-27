<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="claseIdioma.asp"-->
<%
set objIdioma_es = new clsIdioma 'lang actual

'session.CodePage=1252
'response.charset="ISO-8859-1"


'session.CodePage=65001
response.charset="UTF-8"

haylista=false
if objIdioma_es.nRegistros>0 then
	hayLista=true
	RegLista=objIdioma_es.listaTraduccion() 'array con los registros
	'Campos del array
	LEti=0
	LTradu=1
	LDetalle=2

	'for l=0 to ubound(RegLista,2)
		'response.write RegLista(LTradu,l) & " -> " & server.HTMLEncode(RegLista(LTradu,l)) & "<br>"
	'next

end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Mar Hotels</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%
for l=0 to ubound(RegLista,2)
	response.write RegLista(LEti,l) & " -> " & RegLista(LTradu,l) & " -> " & server.HTMLEncode(RegLista(LTradu,l)) & "<br>"
next
%>
</body>
</html>



