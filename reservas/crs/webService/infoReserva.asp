<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

idRes=request.QueryString("idRes") 'la id de la reserva 

hayreserva=false
cs="SELECT Reservas.Cod_Res, Reservas.CodigoEsta, Reservas.FechaIni, Reservas.FechaFin, "
cs=cs&"Reservas.FechaReserva, Reservas.Importe, Reservas.ImportePag, Reservas.Comentarios, "
cs=cs&"Reservas.TipoVenta, Fichas.Id 'IdCliente', Fichas.Apellidos, Fichas.Nombre, Fichas.Telefono, "
cs=cs&"IsNull(Fichas.Pais,Fichas.NombrePais) 'Pais', "
cs=cs&"Fichas.EMail, Fichas.IdiomaWeb 'lang', Fichas.NombrePais, Fichas.Tratamiento "
cs=cs&"FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "Fichas Fichas ON Reservas.IdCliente = Fichas.Id "
cs=cs&"WHERE Reservas.Cod_Res = " & idRes
	
'response.write cs & "<br/>"

rs.Open cs, base
if not rs.eof then
	RegReserva=rs.getrows
	R_IdRes=0
	R_CodigoEsta=1
	R_Fini=2
	R_Ffin=3
	R_Freserva=4
	R_Importe=5
	R_ImportePag=6
	R_Comentarios=7
	R_TipoVenta=8
	R_IdCliente=9
	R_Apellidos=10
	R_Nombre=11
	R_Telefono=12
	R_Pais=13
	R_Email=14
	R_Lang=15
	R_NombrePais=16
	R_Tratamiento=17
	hayreserva=true
end if
rs.close

hayreserva2=false
cs="SELECT TipoReserva.Id, TipoReserva.IdTipoHabitacion, "
cs=cs & "isnull(dbo.fnGetTraduccion('TipoHabitaNombres','Nombre',TipoReserva.IdTipoHabitacion,'es'),Nombre) 'Nombre', "
cs=cs & "TipoReserva.NumAdultos, TipoReserva.NumBebes, TipoReserva.NumNinos1, TipoReserva.Suplementos "
cs=cs & "FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres ON TipoHabitaNombres.Id=TipoReserva.IdTipoHabitacion "
cs=cs & "AND TipoHabitaNombres.CodigoEsta = TipoReserva.CodigoEsta WHERE TipoReserva.IdReserva = " & idRes
cs=cs & " ORDER BY TipoReserva.Id, TipoReserva.IdTipoHabitacion"
	
'response.write cs & "<br/>"

rs.Open cs, base
if not rs.eof then
	RegReserva2=rs.getrows
	R2_Id=0
	R2_IdHabitacion=1
	R2_NombreHabitacion=2
	R2_NumAdultos=3
	R2_NumBebes=4
	R2_NumNinos1=5
	R2_Regimen=6
	hayreserva2=true
end if
rs.close

nreserva=0
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if hayreserva then
	for r=0 to ubound(RegReserva,2)
		nreserva=nreserva+1
		response.write vbtab & "<reserva>" & vbcrlf
		response.write vbtab & vbtab & "<codigo>" & RegReserva(R_IdRes,r) & "</codigo>" & vbcrlf
		response.write vbtab & vbtab & "<establ>" & CDbl(RegReserva(R_CodigoEsta,r)) & "</establ>" & vbcrlf
		response.write vbtab & vbtab & "<fini>" & RegReserva(R_Fini,r) & "</fini>" & vbcrlf
		response.write vbtab & vbtab & "<ffin>" & RegReserva(R_Ffin,r) & "</ffin>" & vbcrlf
		response.write vbtab & vbtab & "<freserva>" & RegReserva(R_Freserva,r) & "</freserva>" & vbcrlf
		response.write vbtab & vbtab & "<importe>" & (RegReserva(R_Importe,r)) & "</importe>" & vbcrlf
		response.write vbtab & vbtab & "<importePag>" & (RegReserva(R_ImportePag,r)) & "</importePag>" & vbcrlf
		response.write vbtab & vbtab & "<comentarios>" & server.HTMLEncode(RegReserva(R_Comentarios,r)) & "</comentarios>" & vbcrlf
		response.write vbtab & vbtab & "<tipoventa>" & CLng(RegReserva(R_TipoVenta,r)) & "</tipoventa>" & vbcrlf
		response.write vbtab & vbtab & "<idcliente>" & CLng(RegReserva(R_IdCliente,r)) & "</idcliente>" & vbcrlf
		response.write vbtab & vbtab & "<apellidos>" & server.HTMLEncode(RegReserva(R_Apellidos,r)) & "</apellidos>" & vbcrlf
		response.write vbtab & vbtab & "<nombre>" & server.HTMLEncode(RegReserva(R_Nombre,r)) & "</nombre>" & vbcrlf
		response.write vbtab & vbtab & "<telefono>" & server.HTMLEncode(RegReserva(R_Telefono,r)) & "</telefono>" & vbcrlf
		response.write vbtab & vbtab & "<pais>" & server.HTMLEncode(RegReserva(R_Pais,r)) & "</pais>" & vbcrlf
		response.write vbtab & vbtab & "<email>" & server.HTMLEncode(RegReserva(R_Email,r)) & "</email>" & vbcrlf
		response.write vbtab & vbtab & "<lang>" & server.HTMLEncode(RegReserva(R_Lang,r)) & "</lang>" & vbcrlf
		response.write vbtab & vbtab & "<nombrePais>" & server.HTMLEncode(RegReserva(R_NombrePais,r)) & "</nombrePais>" & vbcrlf
		response.write vbtab & vbtab & "<tratamiento>" & server.HTMLEncode(RegReserva(R_Tratamiento,r)) & "</tratamiento>" & vbcrlf
		if hayreserva2 then
			for r2=0 to ubound(RegReserva2,2)
				response.write vbtab & vbtab & "<habitacion>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<idHab>" & RegReserva2(R2_IdHabitacion,r2) & "</idHab>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<nomHab>" & server.HTMLEncode(RegReserva2(R2_NombreHabitacion,r2)) & "</nomHab>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<adultos>" & RegReserva2(R2_NumAdultos,r2) & "</adultos>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<bebes>" & RegReserva2(R2_NumBebes,r2) & "</bebes>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<ninos>" & RegReserva2(R2_NumNinos1,r2) & "</ninos>" & vbcrlf
				response.write vbtab & vbtab & vbtab & "<regimen>" & RegReserva2(R2_Regimen,r2) & "</regimen>" & vbcrlf
				response.write vbtab & vbtab & "</habitacion>" & vbcrlf
			next
		end if
		response.write vbtab & "</reserva>" & vbcrlf
	next
End if
response.write vbtab & "<resultados>"&nreserva&"</resultados>" & vbcrlf
response.write "</data>"
%>