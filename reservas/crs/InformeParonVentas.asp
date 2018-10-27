<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

est=request.QueryString("est") 

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

'Temporadas
cs="SELECT MIN(FInicio) as laMinima,MAX(FFinal) as laMaxima FROM " & precrs & "Temporadas Temporadas WHERE "
cs=cs & "CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo
rs.Open cs, base
if not rs.eof then
	hotelcerrado=false
	laminima=rs("laMinima")
	lamaxima=rs("laMaxima")
else
	hotelcerrado=true
end if
rs.close

if not hotelcerrado then
	'Cupo
	cs="SELECT Dia,CodigoHab,Nombre_" & lang & " FROM " & precrs & "Disponibles Disponibles INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "ON Disponibles.CodigoHab=TipoHabitaNombres.Id "
	cs=cs & "WHERE (Cupo-isnull(Confirmadas,0))<1 "
	cs=cs & " AND Disponibles.CodigoEsta=" & est & " AND (Dia BETWEEN " & FechaMySQL(laminima) & " AND " & FechaMySQL(lamaxima)
	cs=cs & ") ORDER BY CodigoHab,Dia"
	rs.Open cs, base
	hayparon=false
	if not rs.eof then
		RegParon=rs.GetRows
		PDia=0
		PHabi=1
		PNHabi=2
		hayparon=true
		'response.write cs & "<br>"
	end if
	rs.close

end if 'hotelcerrado


'Nombre Hotel
cs="SELECT Nombre FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nest=rs("Nombre")
end if
rs.close

'Nombre Habitacion
cs="SELECT Id,Nombre_" & lang & " FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
rs.open cs,base
hayhabis=false
if not rs.eof then
	RegHabis=rs.getrows
	HCodi=0
	HNombre=1
	hayhabis=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
#losmeses td {
	border:1px solid #999999;
	width:17px;
	height:14px;
}
#losmeses th {
	height:18px;
	font-size:11px;
}
-->
</style>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <div class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_infoparonventas")%></div>
            <div id='capaListaHabitacion'> 
              <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr> 
                  <td> 
                    <%if hotelcerrado then
			response.write "<center><h3>" & objIdioma.getTraduccionHTML("i_hotelcerrado") & "</h3></center>" & vbcrlf
			
		else%>
                    <table id='losmeses' align='center' width="100%" cellspacing="0" border="0" cellpadding="0">
                      <%if hayparon then
			regi=0
			lahabi=0
			elmes=0
			for P=0 to ubound(RegParon,2)
				if RegParon(PHabi,p)<>lahabi then 'cambio de habitacion
					lahabi=RegParon(PHabi,p)%>
                      <tr> 
                        <td colspan="31" height="10" style="border:none;"></td>
                      </tr>
                      <tr> 
                        <th colspan="31" align="center"><%=ucase(RegParon(PNHabi,p))%></th>
                      </tr>
                      <%end if
				if month(RegParon(PDia,p))<>elmes then 'cambio de mes
					elmes=month(RegParon(PDia,p))%>
                      <tr> 
                        <th colspan="31" align="left"><%=ucase1(nombremes(month(RegParon(PDia,p))))%></th>
                      </tr>
                      <%end if%>
                      <tr> 
                        <%for d=1 to 31 'to el mes
					if not isdate(d & "/" & elmes & "/" & anyo) then%>
                        <td align="center"></td>
                        <%else 'es guena la fecha
						if p<=ubound(RegParon,2) then 
							'Comprobar que esté en paron
							if day(RegParon(PDia,p))<>d then %>
                        <td align="center" style="color:#666666"><%=d%></td>
                        <%else 'pon color en el día y pasa al siguiente
								%>
                        <td align="center" style="color:red"><%=d%></td>
                        <%p=p+1
								'Comprobar si no ha cambiado la habitacion
								if p<ubound(RegParon,2) then
									if lahabi<>RegParon(PHabi,p) then
										for o=d+1 to 31 'pinta el resto del mes%>
                        <td align="center" style="color:#666666"><%=o%></td>
                        <%next
										exit for
									end if
									'Comprobar si cambia de mes
									if elmes<>month(RegParon(PDia,p)) then
										for o=d+1 to 31 'pinta el resto del mes%>
                        <td align="center" style="color:#666666"><%=o%></td>
                        <%next
										exit for
									end if
								end if 'ubound

							end if 'ese dia
						else 'sa pasao%>
                        <td align="center" style="color:#666666"><%=d%></td>
                        <%end if 'sa pasao
					end if 'guena fecha
				next%>
                      </tr>
                      <%p=p-1
				elmes=month(RegParon(PDia,p))
				lahabi=RegParon(PHabi,p)
			next%>
                      <%end if%>
                    </table>
                    <%end if%>
                  </td>
                </tr>
              </table>
            </div></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
