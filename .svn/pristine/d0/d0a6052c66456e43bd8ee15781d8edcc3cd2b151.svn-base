<!--#include file="../Connections/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

cs="DROP VIEW ConsultaHoteles"
response.write "Consulta: " & cs & "<br/>"
base.execute cs
cs="CREATE VIEW ConsultaHoteles SELECT Establecimientos.CodigoEsta,Nombre,MinDias,Estado,"
cs=cs & "Poblacion,Zona,TipoAlojamiento,Categoria,Foto1 "
cs=cs & "FROM (" & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) INNER JOIN PresentacionHotel "
cs=cs & "ON Establecimientos.CodigoEsta=PresentacionHotel.CodigoEsta "
response.write "Consulta: " & cs & "<br/>"
base.execute cs
'cs="ALTER TABLE TiposServicio ADD Foto nvarchar(75) NULL;"
'response.write "Consulta: " & cs & "<br/>"
'base.execute cs

base.close
set base=nothing
%>