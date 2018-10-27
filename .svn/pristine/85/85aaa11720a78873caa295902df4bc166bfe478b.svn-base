<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.QueryString("sf")="si" then
	response.Cookies("cookieFiltroVIP")="" 'sin filtro
end if

modo=request.QueryString("modo")
if modo="borra" then 
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cs=""
		for t=0 to ubound(queborro)
			if clng(queborro(t))<>0 then 'Para no borrar la cero
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			end if
		next
		if right(cs,4)=" OR " then 'Quitar el ultimo operador
			cs=left(cs,len(cs)-4)
		end if	
		base.execute "DELETE FROM " & precrs & "Fichas WHERE " & cs
		controlRegistro("DELETE FROM " & precrs & "Fichas WHERE " & cs) 'guarda seguimiento
		cs=replace(cs,"Id=","IdFicha=")
		'Borrar visitas
		base.execute "DELETE FROM " & precrs & "VisitasVIP WHERE " & cs
		
	end if
		
end if 'borra

'Lista de registros
condicion=request.Cookies("cookieFiltroVIP")
if condicion="" then condicion="WHERE CodigoVIP<>'' " 'por defecto
cs="SELECT Id,EMail,CodigoVIP,FechaAlta,Nombre,Apellidos,Activo "
cs=cs & "FROM " & precrs & "Fichas Fichas "
cs=cs & condicion
response.Cookies("envioFiltro")=cs 'la consulta sin el ORDER para enviar los emails
cs=cs & " ORDER BY CodigoVIP DESC"
'response.write cs
rs.Open cs, base
haylista=false
if not rs.eof then
	haylista=true
	RegLista=rs.GetRows
	RId=0
	RCodi=2
	RFecha=3
	RNombre=4
	RApe=5
	REMail=1
	RActivo=6

	PorPag=19
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("P"))
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
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra&p=<%=p%>";
		document.f1.submit();
	}
}

function SinFiltro(){
	window.location="<%=MiPag%>?sf=si";
}
function verFicha(id){
	top.creaFlotante("verFicha.asp?id="+id+"&recarga="+self.name,540,400,0,0);
}
function nuevaFicha(){
	top.creaFlotante("verFicha.asp?id=0&recarga="+self.name,540,400,0,0);
}
function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroVIP.asp?p=<%=pag%>",510,220,0,0);
}
function grabaCSV(){
	document.getElementById('paCSV').src="csv_usuariosVIP.asp";
}

</script>
<body>
<iframe id='paCSV' name="paCSV" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<!--#include file="../capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="7"> <input type='button' class="boton145" value='&nbsp;Exportar Listado CSV&nbsp;' onclick="javascript:grabaCSV();"> 
                  <input type='button' class="boton145" value='&nbsp;Filtrar Listado&nbsp;' onclick="javascript:verFiltro();"> 
                  <input type='button' class="boton145" value='Nueva Ficha' onclick="javascript:nuevaFicha();"> 
                  <input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="7" align="left" class="tituloTabla">Lista Clientes 
                  VIP</td>
              </tr>
              <tr> 
                <th align="center" class="colu_par">&nbsp;</th>
                <th align="center" class="colu_impar">Codigo VIP</th>
                <th align='center' class="colu_par">Fecha Alta</th>
                <th align='center' class="colu_impar">Nombre</th>
                <th align='center' class="colu_par">Apellidos</th>
                <th align='center' class="colu_impar">EMail</th>
                <th align='center' class="colu_par">Activo</th>
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
                <td align="center" class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RId,r)%>"> 
                </td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=RegLista(RCodi,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=VerFecha(RegLista(RFecha,r))%></a></td>
                <td align="center" class='<%=laColu(1)%>'><%=RegLista(RNombre,r)%></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RApe,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=RegLista(REmail,r)%></td>
                <td align="center" class='<%=laColu(0)%>'>
                  <%if RegLista(RActivo,r) then response.write "Sí" else Response.write "No"%>
                </td>
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
<script language="javascript" type="text/javascript">
<%if request.QueryString("csv")="1" then%>
	window.open("http://www.planetaweb.es/csv/fichas_VIP.csv");
<%end if%>
</script>
</body>
</html>
