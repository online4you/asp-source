<!--#include file="../includes/FunGestion.asp"-->
<%
set FSO = Server.CreateObject("Scripting.FileSystemObject")
set MiFiche=FSO.CreateTextFile(server.MapPath("../csv") & "\" & IdEmpresa & "_listaFichas.csv",true,false) 

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

condicion=request.Cookies("cookieFiltroLCli")
if condicion="" then condicion="WHERE Email<>'' AND (Fichas.CodigoVIP='' OR Fichas.CodigoVIP IS NULL) " 'por defecto
cs="SELECT Fichas.* "
cs=cs & "FROM " & precrs & "Fichas LEFT JOIN " & precrs & "Reservas ON Fichas.Id=Reservas.IdCliente "
cs=cs & condicion
cs=cs & " ORDER BY Id ASC"
'response.write cs & "<br>"
rs.Open cs, base
texto="Id;Fecha Alta;Apellidos;Nombre;Telefono;Fax;EMail;Direccion;CP;Localidad;Pais;Idioma Web;Informacion" & vbcrlf
do while not rs.eof
	texto=texto & rs("Id") & ";"
	texto=texto & rs("FechaAlta") & ";"
	texto=texto & rs("apellidos") & ";"
	texto=texto & rs("Nombre") & ";"
	texto=texto & rs("Telefono") & ";"
	texto=texto & rs("Fax") & ";"
	texto=texto & rs("EMail") & ";"
	texto=texto & rs("Direccion") & ";"
	texto=texto & rs("CP") & ";"
	texto=texto & rs("Poblacion") & ";"
	texto=texto & rs("NombrePais") & ";"
	texto=texto & rs("IdiomaWeb") & ";"
	if rs("Informacion") then
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

Set Upload = Server.CreateObject("Persits.Upload")
Upload.SendBinary server.MapPath("../csv") & "\" & IdEmpresa & "_listaFichas.csv", True, "application/octet-binary", True
set Upload=nothing

'response.write texto
%>
