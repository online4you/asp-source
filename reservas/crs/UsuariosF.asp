<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
'elCharSet="utf-8"
'response.Charset=elCharSet 'los datos estan en utf-8

set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuUsuario.asp"--><%

'Tabla de usuarios
cs="SELECT Id,Usuario,Nombre,Nivel,Activo FROM " & precrsgen & "usuarios "
'if adminBoss then 'the boss
'	cs=cs & "ORDER BY IdEmpresa,Nombre"
'else
	cs=cs & "WHERE IdEmpresa=" & IdEmpresa & " ORDER BY IdEmpresa,Nombre"
'end if
rs.open cs,base
hayuser=false
if not rs.eof then
	RegUser=rs.getrows
	UId=0
	UNick=1
	UNombre=2
	UNivel=3
	UActivo=4
	hayuser=true
	
	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	TotReg=ubound(RegUser,2)+1
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
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
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' action="<%=MiPag%>" method="POST">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table width='100%' border='0' cellpadding="0" cellspacing="0">
              <tr> 
                <td align='right' colspan='5'> <input type='button' class="boton145" onClick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevousuario")%>'> 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type='button' class="boton145" onClick='javascript:ABorrar();' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>'> 
                </td>
              </tr>
              <tr>
                <td class="tituloTabla" colspan="6" align="left" ><%=objIdioma.getTraduccionHTML("i_usuarios")%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th align='center' class="colu_par">Id</th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nombre")%></th>
                <th align='left' class="colu_par">Nick</th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nivel")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_activo")%></th>
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
                <td align="center" width='10' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegUser(UId,r)%>"> 
                </td>
                <td align="center" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UId,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=server.HTMLEncode(RegUser(UNombre,r))%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=server.HTMLEncode(RegUser(UNick,r))%></a> 
                </td>
                <td align="left" class='<%=estilo%>' > <%=server.HTMLEncode(nombreNivel(RegUser(UNivel,r)))%> 
                </td>
                <td align="center" class='<%=estilo%>'> 
                  <%if RegUser(UActivo,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
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
</div>
<!--#include file="pieFrame.asp"-->
</body>
</html>
