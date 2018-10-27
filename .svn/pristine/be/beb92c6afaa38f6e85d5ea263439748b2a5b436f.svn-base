<!--#include file="../includes/FunGestion.asp"-->
<%
set FSO = Server.CreateObject("Scripting.FileSystemObject")
set MiFiche=FSO.CreateTextFile(server.MapPath("../csv") & "\" & IdEmpresa & "_fichasVIP.csv",true,false) 

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla
busco=request.Cookies("cookieFiltroVIP")
if busco="" then busco="WHERE CodigoVIP<>'' " 'por defecto
cs="SELECT CodigoVIP,FechaAlta,Nombre,Apellidos,EMail,Telefono,Direccion,CP,Poblacion,"
cs=cs & "Provincia,NombrePais,IdiomaWeb,Informacion "
cs=cs & "FROM " & precrs & "Fichas "
cs=cs & busco
cs=cs & " ORDER BY FechaAlta DESC"
'response.write cs
rs.Open cs, base
texto="CodigoVIP;Fecha Alta;Nombre;Apellidos;EMail;Telefono;Direccion;CP;Poblacion;Provincia;Pais;IdiomaWeb;Publicidad" & vbcrlf
do while not rs.eof
	texto=texto & rs("CodigoVip") & ";"
	texto=texto & rs("fechaAlta") & ";"
	texto=texto & rs("Nombre") & ";"
	texto=texto & rs("Apellidos") & ";"
	texto=texto & rs("Email") & ";"
	texto=texto & rs("telefono") & ";"
	texto=texto & rs("direccion") & ";"
	texto=texto & rs("cp") & ";"
	texto=texto & rs("poblacion") & ";"
	texto=texto & rs("provincia") & ";"
	texto=texto & rs("NombrePais") & ";"
	texto=texto & rs("IdiomaWeb") & ";"
	texto=texto & rs("informacion") & vbcrlf
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
Upload.SendBinary server.MapPath("../csv") & "\" & IdEmpresa & "_fichasVIP.csv", True, "application/octet-binary", True
set Upload=nothing
%>

