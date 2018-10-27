<!--#include file="includes/FunGestion.asp"-->
<%
if not adminBoss then response.Redirect("index.asp") 'solo para el boss

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuModulos.asp"--><%

'Tabla de Modulos
cs="SELECT Id,Modulo,Programa,Orden "
cs=cs & "FROM " & precrsgen & "Modulos ORDER BY Orden"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.getrows
	RId=0
	RModulo=1
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
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	palIframe(document.getElementById("verFicha"),450,240,0,0,"verModulo.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),510,440,0,0,"verModulo.asp?id="+id+"&recarga="+self.name);
}
var ultimoFrame="";
</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align='left' cellpadding="0" cellspacing="0">
	<tr><td align='center' width='100' valign='top'>
		<!--#include file="menuIzq.asp"--></td>
		<td align="left" width="700">
		
		<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
		<tr>
		<td align='right' colspan='4'>
		<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Módulo'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
		</td>
		</tr>
		<tr><td colspan="4" height="5"></td></tr>
		<tr><td colspan="4" align="left" class="tituloTabla">Módulos</td></tr>
		<tr>
		<th align="center" class='colu_par'>Borrar</th>
		<th align='left' class="colu_impar">Módulo</th>
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
		  <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RId,r)%>" class="<%=laColu(0)%>">
		</td>
		<td align="left" class='<%=laColu(1)%>'>
		  <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=RegLista(RModulo,r)%></a>
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
		<tr><td height='15' colspan='4'></td></tr>
		<tr><td align='right' colspan='4'>
		<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Módulo'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
		</td>
		</tr>
		</table>
	
	</td>
	</tr>
</table>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verApli' name='verApli' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>