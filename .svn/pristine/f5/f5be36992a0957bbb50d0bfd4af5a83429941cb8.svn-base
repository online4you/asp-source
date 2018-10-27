<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

%><!--#include file="actuCliente.asp"--><%

pag=paClng(request.QueryString("p"))

sf=request.QueryString("sf")
if sf="si" then
	response.Cookies("cookieFiltroLCli")=""
end if
condicion=request.Cookies("cookieFiltroLCli")
if condicion="" then condicion="WHERE Email<>'' AND (Fichas.CodigoVIP='' OR Fichas.CodigoVIP IS NULL) " 'por defecto
cs="SELECT DISTINCT Id,EMail,FechaAlta,Nombre,Apellidos "
cs=cs & "FROM " & precrs & "Fichas Fichas LEFT JOIN " & precrs & "Reservas Reservas ON Fichas.Id=Reservas.IdCliente "
cs=cs & condicion
response.Cookies("envioFiltro")=cs 'la consulta sin el ORDER para enviar los emails
cs=cs & " ORDER BY Id DESC"
'response.write cs
rs.Open cs, base
hayfichas=false
if not rs.eof then
	hayfichas=true
	dim LosReg
	LosReg=rs.GetRows
	'RCodRes=0
	RId=0
	RFecha=2
	RNom=3
	RApe=4
	REMail=1

	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	TotReg=ubound(LosReg,2)+1
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
function filtrar(){
		document.f1.action="<%=MiPag%>?filtro=1";
		document.f1.submit();
}

function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function verFicha(id){
	top.creaFlotante("verCliente.asp?id="+id+"&recarga="+self.name,460,420,0,0);
}


function marcado(ese){
	marcar=false;
	if (ese.checked) marcar=true;
	for (t=0;t<document.f1.length;t++)
	{
		if (document.f1[t].name=='aborrar'){
			if (marcar)
				document.f1[t].checked=true;
			else
				document.f1[t].checked=false;
		}
	}
}
function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroListaClientes.asp?p=<%=pag%>&recarga="+self.name,520,250,0,0);
}

function grabaCSV(){
	document.getElementById('paCSV').src="csv_listaFichas.asp";
}
</script>
<body>
<!--#include file="../capaRecarga.asp"-->
<!--#include file="../includes/porPagina.asp"-->
<iframe id='paCSV' name="paCSV" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="750"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="10"> <input type='button' class="boton145" value='Filtrar Lista' onclick="javascript:verFiltro();"> 
                  <input type='button' class="boton145" value='Quitar Filtro' onclick='javascript:window.location="<%=MiPag%>?sf=si";'> 
                  <input type='button' class="boton145" value='Borrar marcados' onclick='javascript:ABorrar();'> 
                  <input type='button' class="boton145Excel" value='Exporta en CSV' onclick="javascript:grabaCSV();"> 
                </td>
              </tr>
              <tr>
                <td colspan="6" align="left" class="tituloTabla">Lista Clientes</td>
              </tr>
              <tr> 
                <th class="colu_par" align="center"> <input type="checkbox" style='border:none' name="orrar" onClick="javascript:marcado(this);"></th>
                <th align="center" class="colu_impar">Id</th>
                <th align="center" class="colu_par">Fecha Alta</th>
                <th align="left" class="colu_impar">Nombre</th>
                <th align="left" class="colu_par">Apellidos</th>
                <th align="left" class="colu_impar">EMail</th>
              </tr>
              <%if hayfichas then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=IReg to IReg+PorPag-1
			if R>ubound(LosReg,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" class='<%=laColu(0)%>'><input type="checkbox" style='border:none' name="aborrar" value="<%=losreg(RId,r)%>"></td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=LosReg(RId,r)%>);' class="enlaceLista"> 
                  <%=LosReg(RId,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>'> <a href='javascript:verFicha(<%=LosReg(RId,r)%>);' class="enlaceLista"> 
                  <%=verFecha(LosReg(RFecha,r))%></a></td>
                <td align="left" class='<%=laColu(1)%>'><%=LosReg(RNom,r)%></td>
                <td align="left" class='<%=laColu(0)%>'><%=LosReg(RApe,r)%></td>
                <td align="left" class='<%=laColu(1)%>'><%=LosReg(REmail,r)%></td>
              </tr>
              <%next%>
              <tr>
                <td height='25' colspan='6'> <b></b>Total Registros: <%=TotReg%></b><br></td>
              </tr>
              <%end if%>
              <tr>
                <td align="center" colspan="6" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
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