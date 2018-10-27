<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.QueryString("sf")="si" then
	response.Cookies("cookieFiltroVisita")="" 'sin filtro
end if

'Lista de registros
condicion=request.Cookies("cookieFiltroVisita")
if condicion="" then condicion="WHERE Fichas.CodigoVIP<>'' AND Activa<>0 "
cs="SELECT Cod_Res,FechaIni,FechaFin,Establecimientos.Nombre as Hotel,FechaReserva,"
cs=cs & "Fichas.CodigoVIP,Apellidos+', '+Fichas.Nombre as Cliente,Importe "
cs=cs & "FROM (" & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) INNER JOIN Fichas "
cs=cs & "ON Reservas.IdCliente=Fichas.Id "
cs=cs & condicion
cs=cs & "ORDER BY Cod_Res DESC"
'response.write cs
rs.Open cs, base
haylista=false
if not rs.eof then
	haylista=true
	dim LosReg
	RegLista=rs.GetRows
	RCodRes=0
	RFIni=1
	RFFin=2
	RHotel=3
	RFecha=4
	RCodigo=5
	RCliente=6
	RPelas=7

	PorPag=19
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("P")
	if Pag="" then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag

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
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function SinFiltro(){
	window.location="<%=MiPag%>?sf=si";
}
function verReserva(id){
	top.creaFlotante("../verListaReservas.asp?id="+id+"&recarga="+self.name,520,510,0,0);
}
function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroListaVisitas.asp?p=<%=pag%>",510,240,0,0);
}
</script>
<body>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="10"> <input type='button' class="boton145" value='Filtrar Listado' onclick="javascript:verFiltro();"> 
                </td>
              </tr>
              <tr>
                <td colspan="7" align="left" class="tituloTabla">Lista Reservas 
                  VIP</td>
              </tr>
              <tr> 
                <th align="center" class="colu_impar">Codigo VIP</th>
                <th align='center' class="colu_par">Fecha Reserva</th>
                <th align='center' class="colu_impar">Cod. Reserva</th>
                <th align='center' class="colu_par">Hotel</th>
                <th align='center' class="colu_impar">Estancia</th>
                <th align='center' class="colu_par">Cliente</th>
                <th align='center' class="colu_impar">Importe</th>
              </tr>
              <%if haylista then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=IReg to IReg+PorPag-1
			if R>ubound(RegLista,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verReserva(<%=RegLista(RCodRes,r)%>);'><%=RegLista(RCodigo,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verReserva(<%=RegLista(RCodRes,r)%>);'><%=VerFecha(RegLista(RFecha,r))%></a></td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verReserva(<%=RegLista(RCodRes,r)%>);'><%=RegLista(RCodRes,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RHotel,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=verFecha(RegLista(RFIni,r)) & " - " & verFecha(RegLista(RFFin,r))%></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RCliente,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=formatNumber(RegLista(RPelas,r),2)%></td>
              </tr>
              <%
	next
end if%>
              <tr>
                <td align="center" colspan="7" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
</body>
</html>
