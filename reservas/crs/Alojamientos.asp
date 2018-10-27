<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
'response.write conecta
base.Open Conecta

%><!--#include file="borraAlojamiento.asp"--><%

cs="SELECT Establecimientos.CodigoEsta,Establecimientos.Nombre,Porciento,MinDias,Estado,Obs,"
cs=cs & "TipoAlojamiento.Nombre as TipoAloja,Poblacion "
cs=cs & "FROM ((" & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) LEFT JOIN " & precrs & "TipoAlojamiento TipoAlojamiento "
cs=cs & "ON DatosHotel.TipoAlojamiento=TipoAlojamiento.Id) "
cs=cs & buscoHoteles
cs=cs & " ORDER BY Establecimientos.Nombre"
responsedebug(Conecta)
'response.Write("cs=" & cs & "<br>" )

rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HPorciento=2
	HMinDias=3
	HEstado=4
	HObs=5
	HTipoa=6
	HZona=7
	HayHoteles=true

	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	TotReg=ubound(RegHoteles,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("P"))
	if Pag=0 then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_borrahotel")%>')){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra&p=<%=p%>";
		document.f1.submit();
	}
}

function enBlanco(){
	<%if con_cms then %>
	top.creaFlotante("verAlojamientoCMS.asp?id=0&recarga="+self.name,980,640,0,0);
	<%else%>
	top.creaFlotante("verAlojamiento.asp?id=0&recarga="+self.name,500,500,0,0);
	<%end if%>
}
function verFicha(id){
	<%if con_cms then %>
	//alert("P1");
	top.creaFlotante("verAlojamientoCMS.asp?id="+id+"&recarga="+self.name,980,640,0,0);
	<%else%>
	//alert("P2");
	top.creaFlotante("verAlojamiento.asp?id="+id+"&recarga="+self.name,500,500,0,0);
	<%end if%>
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> 
            <!-- tabla -->
            <table border="0" cellpadding="0" cellspacing="0" width='100%' align='center' style="margin-top:10px;">
              <td align='right' colspan='6'> 
                <%if miNivel<TRecepcion then 'con acceso%>
                <!--<input type='button' class="boton145" onClick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevoalojamiento")%>'> -->
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type='button' class="boton145" onClick='javascript:ABorrar();' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>'> 
                <%end if%>
              </td>
              </tr>
              <tr> 
                <td colspan="6" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_datosalojamiento")%></td>
              </tr>
              <tr> 
                <th class="colu_par" align='center'></th>
                <th class="colu_par" align='center'>Id</th>
                <th class="colu_par" align='left'><%=objIdioma.getTraduccionHTML("i_nombre")%></th>
                <th class="colu_par" align='left'><%=objIdioma.getTraduccionHTML("i_tipo")%></th>
                <th class="colu_par" align='left'><%=objIdioma.getTraduccionHTML("i_zona")%></th>
                <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_estado")%></th>
              </tr>
              <%if HayHoteles then
				for R=IReg to IReg+PorPag-1
					if R>ubound(RegHoteles,2) then exit for
					if (r mod 2)=0 then
						estilo="fila_par"
					else 
						estilo="fila_impar"
					end if%>
              <tr> 
                <td align='center' class='<%=laColu(0)%>' > <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegHoteles(HCodi,r)%>"></td>
                <td align='center' class='<%=estilo%>' ><a href='javascript:verFicha(<%=RegHoteles(HCodi,r)%>)'><%=RegHoteles(HCodi,r)%></a></td>
                <td align='left' class='<%=estilo%>' >&nbsp;<a href='javascript:verFicha(<%=RegHoteles(HCodi,r)%>)'> 
                  <%=RegHoteles(HNombre,r)%></a></td>
                <td align='left' class='<%=estilo%>' ><%=RegHoteles(HTipoa,r)%>&nbsp;</td>
                <td align='left' class='<%=estilo%>' ><%=RegHoteles(HZona,r)%>&nbsp;</td>
                <td align='center' class='<%=estilo%>' > 
                  <%select case RegHoteles(HEstado,r)
						case 0 'no venta
							response.write objIdioma.getTraduccionHTML("i_noventa")
						case 1 'on request
							response.write objIdioma.getTraduccionHTML("i_onrequest")
						case 2 'on line
							response.write objIdioma.getTraduccionHTML("i_online")
					end select%>
                </td>
              </tr>
              <%next
				end if%>
              <tr> 
                <td align="center" colspan="6" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
