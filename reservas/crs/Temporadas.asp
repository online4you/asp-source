<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

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
if est=0 then est=paClng(request.form("HSeleccionado"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est
deleteTemporal=request.QueryString("deleteTemporal")
%><!--#include file="actuTemporadas.asp"--><%

'Lista de registros
cs="SELECT CodigoTemp,Finicio,FFinal,ReleaseHab,Minimo,Prepago"

if idEmpresa = 98 then

	cs = cs + ", Oferta"

end if

cs=cs & " FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") "
cs=cs & "ORDER BY FInicio"
'response.Write(cs & "<br>")
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RFIni=1
	RFFin=2
	RRelease=3
	RMinimo=4
	RPrepago=5
	ROferta=6
	haylista=true
	
	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=paClng(porp)
	TotReg=ubound(RegLista,2)+1
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
	if (confirm('<%=objIdioma.getTraduccion("i_borratemporada")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verTemporadas.asp?id=0&est=<%=est%>&recarga="+self.name,450,250,0,0);
}
function verFicha(id){
	top.creaFlotante("verTemporadas.asp?id="+id+"&est=<%=est%>&recarga="+self.name,450,150,0,0);
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal' style="overflow:scroll">
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <%
				span = 6
				if idEmpresa = 98 then
					span  = 7
				end if
			%>
                <td align='right' colspan="<%= span %>"> <input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevatemporada")%>'> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr> 
                <td colspan="<%= span %>" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_temporadas")%></td>
              </tr>
              <tr> 
                <th class="colu_par" align="center"></th>
                <th class="colu_par" align="center">ID</th>
                <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_rangofechas")%></th>
                <th class="colu_par" align="center">Release</th>
                <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_estanciaminima")%></th>
                <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_prepago")%></th>
                <%
			if idEmpresa = 98 then
				' Algunas empresas tienen esta característica
		%>
                <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_es_oferta")%></th>
                <%	end if %>
              </tr>
              <%if haylista then
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if 
		%>
              <tr> 
                <td width='20' class='<%=estilo%>' align="center"> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="center" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'> 
                  <%=VerFecha(RegLista(RFIni,r))%> - <%=VerFecha(RegLista(RFFin,r))%></a> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RRelease,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RMinimo,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RPrepago,r)%> 
                </td>
                <%
                if idEmpresa = 98 then
                    ' Algunas empresas tienen esta característica
            %>
                <td align="center" class='<%=estilo%>'> 
                  <% if RegLista(ROferta,r) then response.write objIdioma.getTraduccionHTML("i_si") %>
                </td>
                <%	end if %>
              </tr>
              <%	
		next
	end if 
	%>
              <tr> 
                <td align="center" colspan="<%=span %>" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
