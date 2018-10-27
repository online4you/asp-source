<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

lang = request.QueryString("lang")
est = paClng(request.QueryString("idh"))
ide = paClng(request.QueryString("ide"))
temp = paClng(request.QueryString("temp"))

cs =      "SELECT "
cs = cs & "    Temp.CodigoTemp "
cs = cs & "	   , Temp.CodigoEsta "
cs = cs & "    , Temp.FInicio "
cs = cs & "	   , Temp.FFinal "
cs = cs & "	   , Temp.ReleaseHab "
cs = cs & "	   , Temp.Minimo "
cs = cs & "	   , Temp.Prepago "
cs = cs & "	   , Temp.Oferta "
cs = cs & "FROM "
cs = cs & "    " & precrs & "Temporadas Temp "
cs = cs & "WHERE "
cs = cs & "    Temp.CodigoTemp = " & temp & " "
cs = cs & "	   AND Temp.CodigoEsta = " & est & " "
'response.Write(cs)
rs.open cs, base
haytempo = false
if not rs.eof then
	RegTempo = rs.getrows
	
	TeCodigoTemp = 0
	TeCodigoEsta = 1
	TeFInicio = 2
	TeFFinal = 3
	TeRelease = 4
	TeMinimo = 5
	TePrepago = 6
	TeOferta = 7
	
	haytempo = true
end if
rs.close

'Generar XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf

if haytempo then
	for s = 0 to ubound(RegTempo, 2)
		response.write "<temporada>" & vbcrlf
		
		response.write vbtab & "<codigoTemp>" & RegTempo(TeCodigoTemp, s) & "</codigoTemp>" & vbcrlf
		response.write vbtab & "<codigoEsta>" & RegTempo(TeCodigoEsta, s) & "</codigoEsta>" & vbcrlf
		response.write vbtab & "<fInicio>" & RegTempo(TeFInicio, s) & "</fInicio>" & vbcrlf
		response.write vbtab & "<fFinal>" & RegTempo(TeFFinal, s) & "</fFinal>" & vbcrlf
		response.write vbtab & "<release>" & RegTempo(TeRelease, s) & "</release>" & vbcrlf
		response.write vbtab & "<minimo>" & RegTempo(TeMinimo, s) & "</minimo>" & vbcrlf
		response.write vbtab & "<prepago>" & RegTempo(TePrepago, s) & "</prepago>" & vbcrlf
		response.write vbtab & "<oferta>"
			
			if RegTempo(TeOferta, s) then
				response.write "1"
			else
				response.write "0"
			end if
		
		response.write "</oferta>" & vbcrlf		
		
		
		cs =      "SELECT "
		cs = cs & "    Trad.Traduccion "
		cs = cs & "FROM "
		cs = cs & "   " & precrs & "Traducciones Trad "
		cs = cs & "WHERE "
		cs = cs & "    Trad.IdReferencia = " & RegTempo(TeCodigoTemp, s)
		cs = cs & "    AND Trad.Tabla = 'Temporada' "
		cs = cs & "	   AND Trad.Campo = 'Nombre' "
		cs = cs & "	   AND Trad.Idioma = '" & lang & "' "	

		rs.open cs, base
		haytradu = false
		if not rs.eof then
			RegTradu = rs.getrows
			TrTraduccion = 0
			
			haytradu = true
		end if
		rs.close
		
		response.write vbtab & "<traduccion>"
		if haytradu then
			response.write RegTradu(TrTraduccion, 0)			
		end if
		response.write "</traduccion>" & vbcrlf
		
		response.write "</temporada>" & vbcrlf
	next
else 'no hay
	response.write "No tiene temporada"
end if
response.write "</data>"

set rs = nothing
base.close
set base = nothing
%>