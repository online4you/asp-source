<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<!--#include file="CR_datosHotel.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta


codres=Request.QueryString("order")

cs="SELECT Establecimientos.Nombre as hotel,FechaIni,FechaFin,Fichas.Nombre as nombre,Apellidos,ImportePag "
cs=cs & "FROM (reservas INNER JOIN Establecimientos "
cs=cs & "ON Reservas.codigoesta=Establecimientos.codigoesta) INNER JOIN Fichas "
cs=cs & "ON Reservas.IdCliente=Fichas.Id WHERE cod_res=" & codres

rs.Open cs,base
if rs.eof then
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	
	Response.write "Error en el fichero de datos"
	response.End()
else
	'Quito los puntos y comas y lo dejo sin decimales
	'pelas=replace(formatnumber(rs("ImportePag"),2),",","")
	'pelas=replace(pelas,".","")
	pelas=redondear(rs("ImportePag"))*100 'para quitar los decimales
	importe="M978" & pelas & chr(10)
	refe=codres & chr(10)
	dias=rs("fechafin")-rs("fechaini")
	descri=trim(rs("Nombre")) & " " & trim(rs("Apellidos")) & " en " & trim(rs("hotel"))
	descri=descri & " (" & dias & " días)" & chr(10)
	preci=pelas & chr(10)

end if
rs.close
set rs=nothing
base.close
set base=nothing

response.write importe
response.write "1" & chr(10)
response.write refe
response.write descri
response.write "1" & chr(10)
response.write preci
%>