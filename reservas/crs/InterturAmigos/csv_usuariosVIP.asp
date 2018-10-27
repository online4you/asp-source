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
cs=cs & "Provincia,Pais,IdiomaWeb,Informacion "
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
	texto=texto & rs("Pais") & ";"
	texto=texto & rs("IdiomaWeb") & ";"
	if rs("informacion") then
		texto=texto & "Sí" & vbcrlf
	else
		texto=texto & "No" & vbcrlf
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
%>
<script language="javascript" type="text/javascript">
//window.open("/csv/<%=IdEmpresa%>_listaReservas.csv");
window.location="/csv/<%=IdEmpresa%>_fichasVIP.csv";
</script>

