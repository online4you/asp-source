<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
lang=request.QueryString("lang")
if lang="" then lang="es"
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

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

todos=request.querystring("todos")


nmes=request.QueryString("elmes")
if nmes="" then nmes=month(date)
nmes=clng(nmes)
any=request.QueryString("any")
if any="" then any=year(date)
any=clng(any)

	'Buscar ultimo dia del mes
	UDia="31/" & nmes & "/" & any
	resta=31
	do while not isdate(udia)
		UDia=RESTA & "/" & nmes & "/" & any
		resta=resta-1
	loop
	UDia=day(Udia)

fini=any & "/" & nmes & "/01"
ffin=any & "/" & nmes & "/" & udia

'Buscar reservas del mes y año
cs="SELECT TipoReserva.FechaInicio,TipoReserva.FechaFinal,IdReserva,Activa,"
cs=cs & "IdTipoHabitacion,CuantasHabis "
cs=cs & "FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "TipoReserva TipoReserva "
cs=cs & "ON Reservas.Cod_Res=TipoReserva.IdReserva "
cs=cs & "WHERE Reservas.CodigoEsta=" & est & " AND "
cs=cs & "(FechaInicio>" & FechaMySQL(fini) & " OR FechaFinal>" & FechaMySQL(fini) & ") "
cs=cs & "AND (FechaInicio<" & FechaMySQL(ffin) & " OR FechaFinal<" & FechaMySQL(ffin) & ") "
cs=cs & "ORDER BY IdReserva"
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFIni=0
	MFFin=1
	MRes=2
	MActi=3
	MHCodi=4
	MHCanti=5
	hayestemes=true
end if
rs.close

if hayestemes then
	'Buscar el nombre de habitacion de ese hotel
	cs="SELECT TipoHabitaNombres.Id,ISNULL(Traduccion,Nombre) as Tradu FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
	cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est
	rs.open cs,base
	hayhabis=false
	if not rs.eof then
		RegHabis=rs.getrows
		HCodi=0
		HNombre=1
		hayhabis=true
	end if
	rs.close
	if hayhabis then
		dim HabisTrue()
		dim HabisFalse()
		redim HabisTrue(UDia,ubound(RegHabis,2))
		redim HabisFalse(UDia,ubound(RegHabis,2))
		for h=0 to ubound(RegHabis,2)
			'Carga datos en las tablas
			'el cero es el nombre de la habitacion
			HabisTrue(0,h)=RegHabis(HNombre,h)
			HabisFalse(0,h)=RegHabis(HNombre,h)
			for d=1 to UDia
				for r=0 to ubound(RegMes,2)
					laf=cdate(d & "/" & nmes & "/" & any)
					if cdate(RegMes(MFIni,r))<=laf and cdate(RegMes(MFFin,r))>laf then 'este es el dia
						if RegMes(MHCodi,r)=RegHabis(HCodi,h) then 'Este tipo habitacion
							if RegMes(MActi,r) then 'Activa
								HabisTrue(d,h)=HabisTrue(d,h)+RegMes(MHCanti,r)
							else
								HabisFalse(d,h)=HabisFalse(d,h)+RegMes(MHCanti,r)
							end if
						end if 'misma habitacion
					end if
				next 'r de regmes
			next 'd
		next 'h de reghabis
	
	end if 'Hayhabis

end if 'hayestemes

set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
#miTabla td {
	border-bottom:1px solid #666666;
	border-right:1px solid #666666;
}
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
          <td align="left" width="740"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <td align='right'> <input type='button' class="boton145" value='Ver Todos los hoteles' onClick="javascript:window.location='<%=MiPag%>?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=-1';"> 
                  <input type='button' class="boton145" value='Nº Reservas del mes' onClick="javascript:window.location='EstadisticaMes.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                  <input type='button' class="boton145" value='Importes de reservas' onClick="javascript:window.location='EstadisticaMesEuros.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                  <input type='button' class="boton145" value='Habitaciones Ocupadas' onClick="javascript:window.location='EstadisticaMesHabi.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                </td>
              </tr>
              <%
	if nmes=1 then
		busca="&elmes=12&any=" & (any-1)
	else
		busca="&elmes=" & (nmes-1) & "&any=" & any
	end if%>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td align='center'> <a href="<%=MiPag%>?est=<%=est & busca%>&todos=<%=todos%>"><span class="style1">Mes 
                  Anterior</span></a> &nbsp;<b> Habitaciones ocupadas en <%=ucase(monthname(nmes))%>&nbsp;<%=any%></b>&nbsp; 
                  <%
	if nmes=12 then
		busca="&elmes=1&any=" & (any+1)
	else
		busca="&elmes=" & (nmes+1) & "&any=" & any
	end if%>
                  <a href="<%=MiPag%>?est=<%=est & busca%>&todos=<%=todos%>"><span class="style1">Mes 
                  Siguiente</span></a></td>
              </tr>
              <tr> 
                <td align="left" class="tituloTabla">ESTADÍSTICAS MES POR HABITACIONES</td>
              </tr>
              <tr> 
                <td valign="middle" class="tdTabla"> <table id='miTabla' align='center' border="0" cellpadding="0" cellspacing="0" width="100%">
                    <%
	dim SeD()	
	redim SeD(UDia)
for I=1 to UDia
	'Tabla del dia de la semana
	DiaSemana= I & "/" & nmes & "/" & any 
	select case weekday(diasemana)
		case VbSunday 'Domingo
			SeD(I)="<font color='#FF0000'>D</font>"
		case VbMonday 'Lunes
			SeD(I)="L"
		case vbTuesday 'Martes
			SeD(I)="M"
		case vbwednesday 'Miercoles
			SeD(I)="X"
		case vbThursday 'Jueves
			SeD(I)="J"
		case vbfriday 'Viernes
			SeD(I)="V"
		case vbsaturday 'Sabado
			SeD(I)="S"
	end select
next
%>
                    <tr> 
                      <td align=left class="CabeTabla">&nbsp;</td>
                      <%
	for I=1 to UDia
		response.write "<TD align=center class='cabetabla'>"
		response.write I
		response.write "</td>"
	next%>
                    </tr>
                    <tr> 
                      <td align=left class="CabeTabla"><b>Dia</b></td>
                      <%
	for I=1 to UDia
		response.write "<TD align=center width='15'>"
		response.write SeD(I)
		response.write "</td>"
	next%>
                    </tr>
                    <%if hayestemes then
	Tmes=0%>
                    <tr> 
                      <td align=left colspan='<%=udia+1%>'><b>Reservas Confirmadas</b></td>
                    </tr>
                    <%if hayhabis then 'Hay habitaciones
			for h=0 to ubound(RegHabis,2)%>
                    <tr> 
                      <td align='left'><%=RegHabis(HNombre,h)%></td>
                      <%for d=1 to UDia%>
                      <TD align=center> 
                        <%
					response.write "<b>" & HabisTrue(d,h) & "</b><br>"
					Tmes=Tmes+HabisTrue(d,h)%>
                      </td>
                      <%next 'd%>
                    </tr>
                    <%next
	end if%>
                    <tr> 
                      <td align=left colspan='<%=udia+1%>'><b>Reservas No Confirmadas</b></td>
                    </tr>
                    <%if hayhabis then 'Hay habitaciones
			for h=0 to ubound(RegHabis,2)%>
                    <tr> 
                      <td align='left'><%=RegHabis(HNombre,h)%></td>
                      <%for d=1 to UDia%>
                      <TD align=center> 
                        <%
					response.write "<b>" & HabisFalse(d,h) & "</b><br>"
					Tmes=Tmes+HabisFalse(d,h)%>
                      </td>
                      <%next 'd%>
                    </tr>
                    <%next
	end if%>
                    <%end if 'Hayestemes%>
                  </table>
                  <!-- mitabla -->
                </td>
              </tr>
              <tr> 
                <td align="center"> <br/> <input type='button' class="boton145" value='Estad&iacute;sticas por Año' onClick="javascript:window.location='EstadisticaAny.asp?est=<%=est%>&any=<%=any%>&todos=<%=todos%>';"> 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  <input type='button' class="boton145" value='Estad&iacute;sticas por Mes' onClick="javascript:window.location='<%=MiPag%>?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td></tr>
      </table> 
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
</body>
</html>
