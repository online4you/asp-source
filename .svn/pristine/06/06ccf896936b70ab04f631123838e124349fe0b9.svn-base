<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.QueryString("est")) 'el hotel
if tarifa=0 then tarifa=1 'por defecto

Dim whereClause
whereClause = "INNER JOIN " & precrs & "CaracteristicasHotel carHot on car.Id = carHot.IdCaracter WHERE carHot.CodigoEsta = " & est
whereClause = whereClause & " AND Car.Destacada<>0"
If IsNull(est) Or est = 0 Then
	whereClause = "WHERE Car.Destacada<>0"
End If

'caracteristicas hotel
cs="SELECT car.Id IdCaracteristica, car.Caracteristica NombreCaracteristica, isNull(car.Icono,'') IconoCaracteristica, "
cs=cs&"car.Orden OrdenCaracteristica, car.Destacada DestacadaCaracteristica, car.IdGrupo IdGrupo, "
cs=cs&"gru.Nombre GrupoNombre, gru.Orden OrdenGrupo "
cs=cs&"FROM " & precrs & "Caracteristicas car INNER JOIN " & precrs & "GrupoCaracteristicas gru on car.IdGrupo = gru.Id "
cs=cs& whereClause & " ORDER BY gru.Orden, car.Orden "

'response.write "cs : " & cs & "<br>"
rs.Open cs, base
haycaract=false
if not rs.eof then
	RegCaract=rs.GetRows
	'Variables para la tabla Habitaciones
	HoCarId=0
	HoCarNom=1
	HoCarIco=2
	HoCarOrden=3
	HoCarDestac=4
	HoCarGruId=5
	HoCarGruNom=6
	HoCarGruOrden=7
	haycaract=true
end if
rs.close
	
set rs=nothing
base.close
set base=nothing

Function Restauracion(idr)
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if idr<>0 then
	cs="SELECT Foto FROM " & precrs & "fotoshotel WHERE IdSeccion=(SELECT id from SeccionesHotel WHERE Seccion ='Restauracion' AND CodigoEsta="&idr&")"
	rs.Open cs, base
	hayRes=false
	if not rs.eof then
		RegFotoRes=rs.GetRows
		FotoRestauracion=0
		hayRes=true
	end if
	rs.close

end if 'idr

		if hayRes then
		  Restauracion=RegFotoRes(FotoRestauracion,0)
		 else
		   Restauracion=""
		End If

	
set rs=nothing
base.close
set base=nothing
End Function
	
'General XML de respuesta
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
response.write "<codigo>" & est & "</codigo>" & vbcrlf
'Poner caracteristicas
If haycaract Then
	For f=0 To UBound(RegCaract,2)
		response.write vbtab & "<caracteristica>" & vbcrlf
		response.write vbtab & vbtab & "<idcaracteristica>" & RegCaract(HoCarId,f) & "</idcaracteristica>" & vbcrlf
		response.write vbtab & vbtab & "<nomcaracteristica>" & server.HTMLEncode(RegCaract(HoCarNom,f)) & "</nomcaracteristica>" & vbcrlf
		response.write vbtab & vbtab & "<icono>" & server.HTMLEncode(RegCaract(HoCarIco,f)) & "</icono>" & vbcrlf
		response.write vbtab & vbtab & "<ordencar>" & clng(RegCaract(HoCarOrden,f)) & "</ordencar>" & vbcrlf
		response.write vbtab & vbtab & "<destacada>" & clng(RegCaract(HoCarDestac,f)) & "</destacada>" & vbcrlf
		response.write vbtab & vbtab & "<idgrupo>" & clng(RegCaract(HoCarGruId,f)) & "</idgrupo>" & vbcrlf
		response.write vbtab & vbtab & "<nomgrupo>" & server.HTMLEncode(RegCaract(HoCarGruNom,f)) & "</nomgrupo>" & vbcrlf
		response.write vbtab & vbtab & "<ordengru>" & clng(RegCaract(HoCarGruOrden,f)) & "</ordengru>" & vbcrlf	
	 	FotoRestauracion = Restauracion(est)
		If (FotoRestauracion<>"") then
  		response.write vbtab & vbtab & "<restaturacionfoto>" & FotoRestauracion & "</restaturacionfoto>" & vbcrlf
		Else
		response.write vbtab & vbtab & "<restaturacionfoto>" & FotoRestauracion & "</restaturacionfoto>" & vbcrlf
 		End If	
		FotoRestauracion =""
		response.write vbtab & "</caracteristica>" & vbcrlf
	next 'h
	
end if 'haycaract
response.write "</data>"
%>