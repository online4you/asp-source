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

%><!--#include file="actuZonas.asp"--><%

hayLista=true
set claseZona=new clsListadoZonas
RegLista=claseZona.cargaListaZonas(0,0,"es") '(idpadre,nivel,idioma)
set claseZona=nothing
if isnull(RegLista) then hayLista=false

RCodi=0
RNombre=1
RPadre=2
RNivel=3
	
PorPag=paClng(objCookies.getCookie(lcase(MiPag)))
if PorPag=0 then PorPag=RegPorPag 'valor por defecto
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


totalcampos=ubound(ListaIdiomas)+1 'los idiomas 

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
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verZonas.asp?id=0&recarga="+self.name,450,150,0,0);
}
function verFicha(id){
	top.creaFlotante("verZonas.asp?id="+id+"&recarga="+self.name,450,150,0,0);
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
          <td align="left" width="760"> <div style="margin-top:10px;"> 
              <input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevazona")%>'>
              <input type='button' class="boton145" style='cursor:pointer' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'>
            </div>
            <p class="tituloTabla"><%=Ucase(objIdioma.getTraduccionHTML("i_zonas"))%></p>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_par" align="center">Id</th>
                <th class="colu_par" align="left"><%=objIdioma.getTraduccionHTML("i_zona")%></th>
                <th class="colu_par" align="left">Zona Superior</th>
              </tr>
              <%if haylista then
			for R=IReg to IReg+PorPag-1
				if R>ubound(RegLista,2) then exit for
				if (r mod 2)=0 then 
					estilo="fila_par"
				else 
					estilo="fila_impar"
				end if
				tabZona="padding-left:" & (20*RegLista(RNivel,r)) & "px"
				%>
              <tr> 
                <td align="center" width='20' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'> 
                  <span style='<%=tabZona%>'><%=RegLista(RNombre,r)%></span></a> 
                </td>
                <td class="<%=estilo%>"><%=RegLista(RPadre,r)%></td>
              </tr>
              <%
			next
			end if%>
            </table>
            <div class="tituloTabla">
              <!--#include file="controlPaginas.asp"-->
            </div></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
