<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
	rs.LockType=adLockReadOnly

	est=paClng(request.QueryString("est"))
codhab=paClng(request.QueryString("codhab"))
fini="" & request.querystring("fini")
ffin="" & request.querystring("ffin")

cs="SELECT Dia,Cupo,Estado,Confirmadas "
cs=cs & "FROM "
cs=cs & "(SELECT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM " & precrs & "Cupos Cupos LEFT OUTER JOIN (SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "Reservas Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0 AND Anulada=0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal) Confirmadas ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal "
cs=cs & " WHERE (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin) & ") "
cs=cs & " GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia) Disponibles "
cs=cs & "WHERE (Dia BETWEEN " & FechaMySQL(fini) & " AND " & FechaMySQL(ffin) & ")"
cs=cs & " AND CodigoHab=" & codhab & " " 
cs=cs & "ORDER BY Dia"
'response.write cs & "<br/>"
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	PDia=0
	PCupo=1
	PEstado=2
	PConfi=3
	hayLista=true
end if
rs.close

set rs=nothing
base.close
set base=nothing

'Generar XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if haylista then
	for r=0 to ubound(RegLista,2)
		response.write "<dia>" & vbcrlf
		response.write vbtab & "<fecha>" & RegLista(PDia,r) & "</fecha>" & vbcrlf
		response.write vbtab & "<disponibles>"
		dispo=RegLista(PCupo,r)-paClng(RegLista(PConfi,r))
		if dispo<0 then response.write 0 else response.write dispo
		response.write "</disponibles>" & vbcrlf
		response.write vbtab & "<estado>"
		select case RegLista(PEstado,r)
			case noventa:response.write "NV"
			case onrequest:response.write "OR"
			case online:response.write "OL"
		end select
		response.write "</estado>" & vbcrlf
		response.write "</dia>" & vbcrlf
	next
else 'no hay
	response.write "<dia><codigo>Error</codigo></dia>" & vbcrlf
end if
response.write "</data>"
%>