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

%><!--#include file="actuTiposHabitacion.asp"--><%

'Lista de registros
cs="SELECT TipoHabita.Id,Nombre,ParaCapMax,ParaCapMin,ParaCapNormal,"
cs=cs & "ParaAdultMax,ParaNiMax FROM " & precrs & "TipoHabita TipoHabita ORDER BY Orden"
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNombre=1
	RMax=2
	RMin=3
	RNormal=4
	RAMax=5
	RNMax=6
	hayLista=true

	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
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

totalcampos=6 'los idiomas + la id + orden


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
	top.creaFlotante("verTiposHabitacion.asp?id=0&recarga="+self.name,510,250,0,0);
}
function verFicha(id){
	top.creaFlotante("verTiposHabitacion.asp?id="+id+"&recarga="+self.name,510,250,0,0);
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
          <td align="left" width="760"> <table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
              <tr> 
                <td align="right" colspan="<%=totalcampos+2%>"> <input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevotipo")%>'> 
                  <input type='button' class="boton145" style='cursor:pointer' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr> 
                <td colspan="<%=totalcampos+2%>" align="left" class="tituloTabla"><%=Ucase(objIdioma.getTraduccionHTML("i_tipohab"))%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_par" align="center">ID</th>
                <th class="colu_par" align="left"><%=objIdioma.getTraduccionHTML("i_tipohab")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_capminima")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_capnormal")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_capmaxima")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_adulmaximo")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_ninmaximo")%></th>
              </tr>
              <%if haylista then
			for R=IReg to IReg+PorPag-1
				if R>ubound(RegLista,2) then exit for
				if (r mod 2)=0 then 
					estilo="fila_par"
				else 
					estilo="fila_impar"
				end if%>
              <tr> 
                <td align="center" width='20' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RMin,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RNormal,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RMax,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RAMax,r)%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(RNMax,r)%> 
                </td>
              </tr>
              <%
			next
			end if%>
              <tr> 
                <td align="center" colspan="<%=totalcampos+2%>" class="tituloTabla"> 
                  <!--#include file="controlPaginas.asp"--> </td>
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
