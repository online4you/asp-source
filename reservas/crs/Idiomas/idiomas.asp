<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly



parametros="./webservice/buscaPrecioHoteles.asp?ide=4&est=0&lang=es&ad=2&fini=15/05/08&ffin=26/05/08"

Set objDom = Server.CreateObject("Microsoft.XMLDOM")
objDom.async = false
objDom.validateOnParse = false
objDom.setProperty "ServerHTTPRequest", true
if objDom.Load(parametros) then

	set nodo=objDom.documentElement.SelectNodes("/data/hotel")
	set resul=objDom.selectSingleNode("/data/hotel[nombre='HSM Linda Playa']")
	'For Each objItem in resul
		response.write resul.childnodes(0).text & "<br>"
		response.write resul.selectSingleNode("codigo").text & "<br>"
	'next
	For Each objItem in nodo
		response.write objItem.childNodes(1).text & "<br>"
	next


end if
Set objDom = Nothing


set rs=nothing
base.close
set base=nothing
response.End()
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verUsuario.asp?id=0&recarga="+self.name,400,240,0,0);
	//palIframe(document.getElementById("verFicha"),400,240,0,0,"verUsuario.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	top.creaFlotante("verUsuario.asp?id="+id+"&recarga="+self.name,615,300,0,0);
	//palIframe(document.getElementById("verFicha"),600,300,0,0,"verUsuario.asp?id="+id+"&recarga="+self.name);
}
</script>
</head>
<body>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' action="<%=MiPag%>" method="POST">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table width='100%' border='0' cellpadding="0" cellspacing="0">
              <tr> 
                <td align='right' colspan='5'> <input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Usuario'> 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'> 
                </td>
              </tr>
              <tr>
                <td class="tituloTabla" colspan="5" align="left" >Usuarios</td>
              </tr>
              <tr> 
                <th class="colu_par">Borrar</th>
                <th align='left' class="colu_impar">Nombre</th>
                <th align='left' class="colu_par">Nick</th>
                <th align='left' class="colu_impar">Password</th>
                <th align='left' class="colu_par">Nivel</th>
              </tr>
              <%if hayuser then
			for R=IReg to IReg+PorPag-1
			if R>ubound(RegUser,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if
			%>
              <tr> 
                <td align="center" width='10' class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegUser(UId,r)%>"> 
                </td>
                <td align="left" class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNombre,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(0)%>'> <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNick,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(1)%>'> <%=RegUser(UPass,r)%> 
                </td>
                <td align="left" class='<%=laColu(0)%>' > <%=nombreNivel(RegUser(UNivel,r))%> 
                </td>
              </tr>
              <%next
	end if%>
              <tr>
                <td align="center" colspan="5" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
</div>
</body>
</html>
