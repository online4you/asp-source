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

%><!--#include file="ActuAgencias.asp"--><%

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

'Lista de registros
if request.QueryString("sf")="si" then response.Cookies("cookieFiltroAge")=""
condicion=request.Cookies("cookieFiltroAge")
'if condicion="" then condicion="WHERE id<>'' " 'por defecto
cs="SELECT Id,nombre,email,contacto,telefono,Activa "
cs=cs & "FROM " & precrs & "Agencias Agencias "
cs=cs & condicion
cs=cs & " ORDER BY Id DESC"
'response.write cs
rs.Open cs, base
haylista=false
if not rs.eof then
	haylista=true
	RegLista=rs.GetRows
	RId=0
	RNombre=1
	REmail=2
	RContacto=3
	RTElefono=4
	RActiva=5

	porP=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
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
<!--#include file="../metasCabecera.asp"-->
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
function enBlanco(){
	top.creaFlotante("verFicha.asp?id=0&recarga="+self.name,520,460,0,0);
}
function verFicha(id){
	top.creaFlotante("verFicha.asp?id="+id+"&recarga="+self.name,520,460,0,0);
}
function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroAg.asp?lang=<%=pag%>&recarga="+self.name,510,220,0,0);
}

function grabaCSV(){
	document.getElementById('paCSV').src="csv_listaAgencias.asp";
}
</script>
<body>
<iframe id='paCSV' name="paCSV" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
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
                <td align='right' colspan="7"> <input type='button' class="boton145" value='&nbsp;Nueva Agencia&nbsp;' onclick="javascript:enBlanco();"> 
                  <input type='button' class="boton145" value='&nbsp;Filtrar Listado&nbsp;' onclick="javascript:verFiltro();"> 
                  <input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'> 
                  <input type='button' class="boton145Excel" value='Exporta en CSV' onclick="javascript:grabaCSV();"> 
                </td>
              </tr>
              <tr>
                <td colspan="7" align="left" class="tituloTabla">Lista Agencias</td>
              </tr>
              <tr> 
                <th align="center" class="colu_par">&nbsp;</th>
                <th align="center" class="colu_impar">Id</th>
                <th align='center' class="colu_par">Agencia</th>
                <th align='center' class="colu_impar">E-mail</th>
                <th align='center' class="colu_par">Contacto</th>
                <th align='center' class="colu_impar">Telefono</th>
                <th align='center' class="colu_par">Activa</th>
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
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=RegLista(RNombre,r)%></a></td>
                <td align="center" class='<%=laColu(1)%>'><%=RegLista(REmail,r)%></td>
                <td align="center" class='<%=laColu(0)%>'><%=RegLista(RContacto,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=RegLista(RTelefono,r)%></td>
                <td align="center" class='<%=laColu(0)%>'> 
                  <%if RegLista(RActiva,r) then
			response.write "Sí"
		else
			response.write "No"
		end if%>
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
<!--#include file="../pieFrame.asp"-->
</body>
</html>
