<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang=request.QueryString("lang")

cs="SELECT GrupoCaracteristicas.Id,"
cs=cs & "ISNULL(dbo.fnGetTraduccion('GrupoCaracteristicas','Nombre',GrupoCaracteristicas.Id,'" & lang & "'),Nombre) AS Grupo,"
cs=cs & "Caracteristicas.Id,"
cs=cs & "ISNULL(dbo.fnGetTraduccion('Caracteristicas','Caracteristica',Caracteristicas.Id,'" & lang & "'),Caracteristica) AS Caracter,"
cs=cs & "Caracteristicas.Destacada "
cs=cs & "FROM " & precrs & "GrupoCaracteristicas GrupoCaracteristicas LEFT JOIN " & precrs & "Caracteristicas Caracteristicas "
cs=cs & "ON GrupoCaracteristicas.Id=Caracteristicas.IdGrupo "
cs=cs & "ORDER BY GrupoCaracteristicas.Orden,GrupoCaracteristicas.Id, Caracteristicas.Orden,Caracteristicas.ID DESC"
'responseLog(cs & "<br>")
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	RIdGrupo=0
	RGrupo=1
	RCodi=2
	RNombre=3
	RDesta=4
	hayLista=true
	
end if 'eof
rs.close


if hayLista then
	'Generar XML de respuesta
	response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
	response.write "<caracteristicas>" & vbcrlf
	for c=0 to ubound(RegLista,2)
		response.write vbtab & "<caracteristica>" & vbcrlf
		response.write vbtab & vbtab & "<id>" & RegLista(RCodi,c) & "</id>" & vbcrlf
		response.write vbtab & vbtab & "<nombre>" & server.HTMLEncode(RegLista(RNombre,c)) & "</nombre>" & vbcrlf
		response.write vbtab & vbtab & "<destacada>"
		if RegLista(RDesta,c) then
			response.write "true"
		else
			response.write "false"
		end if
		response.write "</destacada>" & vbcrlf
		response.write vbtab & vbtab & "<idgrupo>" & RegLista(RIdGrupo,c) & "</idgrupo>" & vbcrlf
		response.write vbtab & vbtab & "<grupo>" & server.HTMLEncode(RegLista(RGrupo,c)) & "</grupo>" & vbcrlf
		response.write vbtab & "</caracteristica>" & vbcrlf
	next
	response.write "</caracteristicas>"

else 'no hay
	response.write "No hay caracteriscticas" & vbcrlf
end if 'hayservis

set rs=nothing
base.close
set base=nothing
%>