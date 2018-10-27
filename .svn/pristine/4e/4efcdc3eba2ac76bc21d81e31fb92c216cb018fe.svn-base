<!--#include file="includes/FunGestion.asp"-->
<%
if not adminBoss then response.Redirect("index.asp") 'solo para el boss

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

idm=paClng(request.QueryString("idm"))

%><!--#include file="actuAplicaciones.asp"--><%

'Tabla de Modulos
cs="SELECT Id,NombreBoton,Programa,Orden "
cs=cs & "FROM " & precrsgen & "aplicaciones WHERE IdModulo=" & idm & " ORDER BY Orden"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.getrows
	RId=0
	RBoton=1
	RPrograma=2
	ROrden=3
	haylista=true
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

<style type="text/css">
<!--
	body {
		margin:0px;
	}
-->
</style>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra&idm=<%=idm%>";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verAplicacion.asp?id=0&p=<%=pag%>&idm=<%=idm%>",530,340,0,0);
	//palIframe(top.document.getElementById("verApli"),510,340,0,0,"verAplicacion.asp?id=0&p=<%=pag%>&idm=<%=idm%>");
}
function verFicha(id){
	top.creaFlotante("verAplicacion.asp?id="+id+"&p=<%=pag%>&idm=<%=idm%>",530,340,0,0);
	//palIframe(top.document.getElementById("verApli"),510,340,0,0,"verAplicacion.asp?id="+id+"&p=<%=pag%>&idm=<%=idm%>");
}
var ultimoFrame="";
</script>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="POST">
<div id='principal' style="width:470px; height:170px; overflow-y:scroll; overflow-x:hidden">
	<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
		<tr><td colspan="4" align="left" class="tituloTabla">Aplicaciones</td></tr>
		<tr>
		<th align="center" class='colu_par'>Borrar</th>
		<th align='left' class="colu_impar">Nombre</th>
		<th align='left' class="colu_par">Programa</th>
		<th align='left' class="colu_impar">Orden</th>
		</tr>
		<%if haylista then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
		<tr>
		<td align="center" class='<%=laColu(0)%>'>
		  <input type="checkbox" style='border:none' name="aborrar" value="<%=RegLista(RId,r)%>" class="<%=laColu(0)%>">
		</td>
		<td align="left" class='<%=laColu(1)%>'>
		  <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=RegLista(RBoton,r)%></a>
		</td>
		<td align="left" class='<%=laColu(0)%>'>
		  <%=RegLista(RPrograma,r)%>
		</td>
		<td align="left" class='<%=laColu(1)%>'>
		  <%=RegLista(ROrden,r)%>
		</td>
		</tr>
		<%next
		end if%>
		</tr>
	</table>
</div> <!-- principal -->
<div align="center">
<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nueva Aplicación'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcadas'>
</div>

</form>
</body>
</html>