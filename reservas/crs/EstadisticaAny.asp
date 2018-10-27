<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="fechasCalendario.asp"-->
<%
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

todos=request.QueryString("todos")

any=request.QueryString("any")
if any="" then any=year(date)
any=clng(any)

'Buscar reservas del año
cs="SELECT FechaReserva,Cod_Res,Activa "
cs=cs & "FROM " & precrs & "Reservas Reservas "
if todos="-1" then 'Ver Todos
	cadena=replace(buscoHoteles,"WHERE ","")
	cadena=replace(cadena,"Establecimientos.","Reservas.")
	if cadena<>"" then
		cs=cs & "WHERE (" & cadena & ") " '"WHERE Reservas.CodigoEsta<>0 "
	else
		cs=cs & "WHERE Reservas.CodigoEsta<>0 "
	end if
else
	cs=cs & "WHERE Reservas.CodigoEsta=" & est & " "
end if
cs=cs & "AND YEAR(FechaReserva)=" & any & " "
cs=cs & "GROUP BY FechaReserva,Cod_Res,Activa ORDER BY FechaReserva"
hayestemes=false
rs.open cs,base
if not rs.eof then
	RegMes=rs.getrows
	MFecha=0
	MRes=1
	MActi=2
	hayestemes=true
end if
rs.close
if hayestemes then
	'Tablas de los dias
	dim diatrue(12)
	dim diafalse(12)
	'Carga datos en las tablas
	for d=1 to 12
		for r=0 to ubound(RegMes,2)
			if month(RegMes(MFecha,r))=d then 'este es este mes
				if RegMes(MActi,r) then 'Activa
					diatrue(d)=diatrue(d)+1
				else
					diafalse(d)=diafalse(d)+1
				end if
			end if
		next	
	next
end if 'hayestemes

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
                <td align='right'> <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_todosloshoteles")%>' onclick="javascript:window.location='<%=MiPag%>?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=-1';"> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_nreservas")%>' onclick="javascript:window.location='EstadisticaAny.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_verimportes")%>' onclick="javascript:window.location='EstadisticaAnyEuros.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_habiocupadas")%>' onclick="javascript:window.location='EstadisticaMesHabi.asp?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
                </td>
              </tr>
              <%
	'if nmes=1 then
		busca="&elmes=12&any=" & (any-1)
	'else
		'busca="&elmes=" & (nmes-1) & "&any=" & any
	'end if
	%>
              <tr>
                <td height="10"></td>
              </tr>
              <tr> 
                <td align='center'> <a href="<%=MiPag%>?est=<%=est & busca%>&todos=<%=todos%>"><span class="style1"><%=objIdioma.getTraduccionHTML("i_anyoanterior")%></span></a> 
                  &nbsp;<b> 
                  <%if todos="-1" then response.write "(" & objIdioma.getTraduccionHTML("i_todosloshoteles") & ") "%>
                  <%=objIdioma.getTraduccionHTML("i_reservasrealizadas")%>&nbsp;<%=any%></b>&nbsp; 
                  <%busca="&any=" & (any+1)%>
                  <a href="<%=MiPag%>?est=<%=est & busca%>&todos=<%=todos%>"><span class="style1"><%=objIdioma.getTraduccionHTML("i_anyosiguiente")%></span></a> 
                </td>
              </tr>
              <tr>
                <td align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_estadisticas")%></td>
              </tr>
              <tr>
                <td align="center"> <div id='miTabla'> 
                    <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%">
                      <tr> 
                        <td align=left class="CabeTabla">&nbsp;</td>
                        <%
			for I=1 to 12
				response.write "<TD align=center class='cabetabla'>"
				response.write I
				response.write "</td>"
			next%>
                      </tr>
                      <tr> 
                        <td align=left class="CabeTabla"><b><%=objIdioma.getTraduccionHTML("i_mes")%></b></td>
                        <%
			for I=1 to 12
				response.write "<TD align=center>"
				response.write "<a href='EstadisticaMes.asp?est=" & est & "&elmes=" & i & "&any=" & any & "&todos=" & todos & "' style='text-decoration:underline'>"
				response.write ucase1(nombreMes(I)) & "</a>"
				response.write "</td>"
			next%>
                      </tr>
                      <%if hayestemes then
			TmesT=0
			TmesF=0%>
                      <tr> 
                        <td align=left><b><%=objIdioma.getTraduccionHTML("i_reservasconfirmadas")%></b></td>
                        <%
				for d=1 to 12%>
                        <TD align=center> 
                          <%'if diatrue(d)="" then diatrue(d)=0
					response.write "<b>" & diatrue(d) & "</b><br>"
					'if diafalse(d)="" then diafalse(d)=0
					TmesT=TmesT+diatrue(d)%>
                        </td>
                        <%next%>
                      </tr>
                      <tr> 
                        <td align=left><b><%=objIdioma.getTraduccionHTML("i_reservasnoconfirmadas")%></b></td>
                        <%
				for d=1 to 12%>
                        <TD align=center> 
                          <%'if diatrue(d)="" then diatrue(d)=0
					response.write diafalse(d) & "<br>"
					'if diafalse(d)="" then diafalse(d)=0
					TmesF=TmesF+diafalse(d)%>
                        </td>
                        <%next%>
                      </tr>
                      <tr> 
                        <td align=left><b><%=objIdioma.getTraduccionHTML("i_totalreservasmes")%></b></td>
                        <%
				for d=1 to 12%>
                        <TD align=center> 
                          <%'if diatrue(d)="" then diatrue(d)=0
					response.write "<b>" & diatrue(d)+diafalse(d) & "</b>"%>
                        </td>
                        <%next%>
                      </tr>
                      <%end if 'Hayestemes%>
                    </table>
                    <!-- mitabla -->
                    <br/>
                  </div></td>
              </tr>
              <tr>
                <td align="center"> <br/> <b><%=objIdioma.getTraduccionHTML("i_reservasconfirmadasanyo")%>&nbsp;<%=any%>: 
                  <%=TmesT%></b><br/> <%=objIdioma.getTraduccionHTML("i_reservasnoconfirmadasanyo")%>&nbsp;<%=any%>: 
                  <%=TmesF%> </td>
              </tr>
              <tr>
                <td align="center"> <br/> <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_estadisticasanyo")%>' onclick="javascript:window.location='EstadisticaAny.asp?est=<%=est%>&any=<%=any%>&todos=<%=todos%>';"> 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_estadisticasmes")%>' onclick="javascript:window.location='<%=MiPag%>?est=<%=est%>&elmes=<%=nmes%>&any=<%=any%>&todos=<%=todos%>';"> 
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
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
