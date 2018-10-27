<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="constantesMenus.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuMenu.asp"--><%


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
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&p=<%=p%>";
		document.f1.submit();
	}
}

function nuevaFicha(){
	top.creaFlotante("verMenu.asp?recarga="+self.name,1010,320,0,0);
}
function verFicha(id){
	top.creaFlotante("verMenu.asp?id="+id+"&recarga="+self.name,1010,320,0,0);
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
                <td align='right' colspan="12"> <input type='button' class="boton145" value='Nuevo botón' onClick="javascript:nuevaFicha();"> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="5" align="left" class="tituloTabla">MENUS</td>
              </tr>
              <tr> 
                <th align='center' class="colu_par">Men&uacute;</th>
                <th align='center' class="colu_impar">Tipo Enlace</th>
                <th align='center' class="colu_par">Nivel Acceso</th>
                <th align='center' class="colu_impar">Orden</th>
                <th align='center' class="colu_par">Activo</th>
              </tr>
              <tr>
                <td align="center" colspan="5" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>
