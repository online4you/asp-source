<!--#include file="datosEmpresa.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est") 'el hotel clave
laX=request.QueryString("laX") 'posición X 
laY=request.QueryString("laY") 'posición Y
lang=request.QueryString("lang")

hayhotel=false
if(isNumeric(laX) And isNumeric(laY)) Then
	cs="select DatosHotel.CodigoEsta, Establecimientos.Nombre, DatosHotel.Categoria, DatosHotel.Direccion, laX, laY,DatosHotel.Foto,DatosHotel.TipoAlojamiento "
	cs=cs& " , CAST(REPLACE(((laX-("&Replace(laX,",",".")&"))+(laY-("&Replace(laY,",",".")&"))),'-','') AS FLOAT) dif "
	cs=cs& " from GmapsHotel inner join DatosHotel "
	cs=cs& " on GmapsHotel.CodigoEsta = DatosHotel.CodigoEsta "
	cs=cs& " inner join Establecimientos "
	cs=cs& " on DatosHotel.CodigoEsta = Establecimientos.CodigoEsta "
	cs=cs& " where (laX Between ("&Replace(laX,",",".")&" - 3) And ("&Replace(laX,",",".")&" + 3)) "
	cs=cs& " and (laY Between ("&Replace(laY,",",".")&" - 3) And ("&Replace(laY,",",".")&" + 3)) "
	if(isnumeric(est)) then
		cs=cs& " and gmapsHotel.CodigoEsta != " & est
	end if
	cs=cs& " Order by dif "
	
 
	rs.Open cs, base
	if not rs.eof then
		RegCercanos=rs.getrows
		N_IdEstablecimiento=0
		N_NombreEstablecimiento=1
		N_IdCategoria=2
		N_Direccion=3
		N_X=4
		N_Y=5
		N_Foto=6
		N_TipoAloja=7
		hayhotel=true
	end if
	rs.close
end if

nhoteles=0
response.write "<?xml version='1.0' encoding='utf-8'?>" & vbcrlf
response.write "<data>" & vbcrlf
if hayhotel then
	if hayhotel then
		for h=0 to ubound(RegCercanos,2)
			if antehotel<>RegCercanos(HoCodi,h) then 'Cambio de hotel, buscar datos
				antehotel=RegCercanos(HoCodi,h)
				nhoteles=nhoteles+1
				response.write "<hotel>" & vbcrlf
				response.write vbtab & "<codigo>" & RegCercanos(N_IdEstablecimiento,h) & "</codigo>" & vbcrlf
				response.write vbtab & "<nombre>" & server.HTMLEncode(RegCercanos(N_NombreEstablecimiento,h)) & "</nombre>" & vbcrlf
				response.write vbtab & "<categoria>" & RegCercanos(N_IdCategoria,h) & "</categoria>" & vbcrlf
				response.write vbtab & "<direccion>" & server.HTMLEncode(RegCercanos(N_Direccion,h)) & "</direccion>" & vbcrlf
				response.write vbtab & "<laX>" & CDbl(RegCercanos(N_X,h)) & "</laX>" & vbcrlf
				response.write vbtab & "<laY>" & CDbl(RegCercanos(N_Y,h)) & "</laY>" & vbcrlf
				response.write vbtab & "<fotoAloja>" & RegCercanos(N_Foto,h) & "</fotoAloja>" & vbcrlf
				response.write vbtab & "<tipoAloja>" & RegCercanos(N_TipoAloja,h) & "</tipoAloja>" & vbcrlf
				response.write "</hotel>" & vbcrlf
			end if
		next
	end if

End if
response.write "<resultados>"&nhoteles&"</resultados>"
response.write "</data>"
%>