<!--#include file="../includes/FunGestion.asp"-->
<%
set FSO = Server.CreateObject("Scripting.FileSystemObject")
set MiFiche=FSO.CreateTextFile(server.MapPath("../csv") & "\" & IdEmpresa & "_listaAgencias.csv",true,false) 

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

condicion=request.Cookies("cookieFiltroAgNwE")
'if condicion="" then condicion="WHERE id<>'' " 'por defecto
cs="SELECT * FROM " & precrs & "Agencias "
cs=cs & condicion
cs=cs & " ORDER BY Id ASC"
'response.write cs & "<br>"
rs.Open cs, base
texto="Id;Nombre;EMail;Direccion;CP;Localidad;Pais;Telefono;Fax;Comision;BAL;Contacto;Usuario;Clave;Activa" & vbcrlf
do while not rs.eof
	texto=texto & rs("Id") & ";"
	texto=texto & HTMLDecode(rs("Nombre")) & ";"
	texto=texto & rs("EMail") & ";"
	texto=texto & HTMLDecode(rs("Direccion")) & ";"
	texto=texto & HTMLDecode(rs("CP")) & ";"
	texto=texto & HTMLDecode(rs("Poblacion")) & ";"
	texto=texto & HTMLDecode(rs("Pais")) & ";"
	texto=texto & "" & rs("Telefono") & ";"
	texto=texto & "" & rs("Fax") & ";"
	texto=texto & rs("Comision") & ";"
	texto=texto & rs("BAL") & ";"
	texto=texto & HTMLDecode(rs("Contacto")) & ";"
	texto=texto & HTMLDecode(rs("Usuario")) & ";"
	texto=texto & HTMLDecode(rs("Clave")) & ";"
	if rs("Activa") then
		texto=texto & "SI" & vbcrlf
	else
		texto=texto & "NO" & vbcrlf
	end if
	rs.movenext
loop
rs.close


set rs=nothing
base.close
set base=nothing

'guardar fihero
MiFiche.write texto
MiFiche.close
set MiFiche=nothing
set FSO=nothing

'Set Upload = Server.CreateObject("Persits.Upload")
'Upload.SendBinary server.MapPath("../csv") & "\" & IdEmpresa & "_listaAgencias.csv", True, "application/octet-binary", True
'set Upload=nothing

'response.write texto
%>
<script language="javascript" type="text/javascript">
window.location="/csv/<%=IdEmpresa%>_listaAgencias.csv";
</script>
