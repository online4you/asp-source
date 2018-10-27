<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.QueryString("sf")="si" then
	response.Cookies("cookieFiltroVisita")="" 'sin filtro
end if

if request.form<>"" and request.QueryString("modo")="borra" then 'borra registros
	
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cadena=""
		for t=0 to ubound(queborro)
			cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
		next
		if right(cadena,4)=" OR " then 'Quitar el ultimo operador
			cadena=left(cadena,len(cadena)-4)
		end if	
		'Borrar 
		cs="DELETE FROM " & precrs & "VisitasVIP WHERE " & cadena
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	end if

end if 'form

'Lista de registros
condicion=request.Cookies("cookieFiltroVisita")
cs="SELECT VisitasVIP.Id,Fichas.CodigoVIP,Fecha,NumDias,Establecimientos.Nombre as Hotel,"
cs=cs & "(isnull(Fichas.Apellidos,'')+' '+Fichas.Nombre) as NombreAmigo "
cs=cs & "FROM ((" & precrs & "VisitasVIP VisitasVIP LEFT JOIN " & precrs & "Fichas Fichas "
cs=cs & "ON VisitasVIP.IdFicha=Fichas.Id) LEFT JOIN Establecimientos "
cs=cs & "ON VisitasVIP.CodigoEsta=Establecimientos.CodigoEsta) LEFT JOIN Reservas "
cs=cs & "ON VisitasVIP.CodReserva=Reservas.Cod_Res "
cs=cs & condicion
cs=cs & "ORDER BY VisitasVIP.Id Desc "
'response.write cs
rs.Open cs, base
haylista=false
if not rs.eof then
	haylista=true
	dim LosReg
	RegLista=rs.GetRows
	RId=0
	RCodigo=1
	RFecha=2
	RNoches=3
	RHotel=4
	RAmigo=5

	porP=paClng(objCookies.getCookie(lcase(MiPag)))
	if porp=0 then porp=paClng(RegPorPag) 'valor por defecto
	PorPag=porp
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("P"))
	if Pag=0 then Pag=1
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
function verVisita(id){
	top.creaFlotante("verVisita.asp?id="+id+"&recarga="+self.name,500,400,0,0);
}
function nuevaVisita(){
	top.creaFlotante("verVisita.asp?id=0&recarga="+self.name,500,400,0,0);
}

function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroListaVisitas.asp?p=<%=pag%>",510,240,0,0);
}
</script>
<body>
<!--#include file="../capaRecarga.asp"-->
<!--#include file="../includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="6"> <input type='button' class="boton145" value='Borrar Marcadas' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="7" align="left" class="tituloTabla">Visitas Intertur 
                  Amigo</td>
              </tr>
              <tr> 
                <th align="center" class="colu_par"></th>
                <th align="center" class="colu_impar">Id</th>
                <th align='center' class="colu_par">Fecha</th>
                <th align='center' class="colu_impar">Cod. Amigo</th>
                <th align='center' class="colu_par">Nombre</th>
                <th align='center' class="colu_impar">Hotel</th>
                <th align='center' class="colu_par">Noches</th>
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
                <td align="center" class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RId,r)%>"></td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=RegLista(RId,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=VerFecha(RegLista(RFecha,r))%></a></td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=RegLista(RCodigo,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RAmigo,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=RegLista(RHotel,r)%></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RNoches,r)%></td>
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
<!--#include file="../pieFrame.asp"-->
</body>
</html>
