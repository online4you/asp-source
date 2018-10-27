<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
if not adminBoss then response.Redirect("index.asp") 'solo para el boss

set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuModulos.asp"--><%

'Tabla de Modulos
cs="SELECT P1.Id,P1.Modulo,P1.Programa,P1.Orden,P1.Menu,P2.ModuloSuperior,P2.Id AS otra,P2.Programa,P2.Modulo "
cs=cs & "FROM " & precrsgen & "modulos as P1 LEFT JOIN " & precrsgen & "modulos as P2 "
cs=cs & "ON P1.Id=P2.ModuloSuperior "
cs=cs & "WHERE P1.ModuloSuperior=0 "
cs=cs & "ORDER BY P1.Orden"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.getrows
	RId=0
	RModulo=1
	RPrograma=2
	ROrden=3
	RMenu=4
	RSuperior=5
	RSubId=6
	RSubPrograma=7
	RSubModulo=8
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verModulo.asp?id=0&recarga="+self.name,450,240,0,0);
}
function verFicha(id){
	top.creaFlotante("verModulo.asp?id="+id+"&recarga="+self.name,510,440,0,0);
}
var ultimoFrame="";

</script>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	<div id='iframeConte'>
	<form name='f1' action="<%=MiPag%>" method="POST">
	<table border="0" align='left' cellpadding="0" cellspacing="0">
	<tr>
		<td align="left" width="740">
			<table border="0" align='left' cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" width="700">
					
					<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
					<tr>
					<td align='right' colspan='4'>
					<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo M&oacute;dulo'>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
					</td>
					</tr>
					<tr><td colspan="4" height="5"></td></tr>
					<tr><td colspan="4" align="left" class="tituloTabla">M&oacute;dulos</td></tr>
					<tr>
					<th align="center" class='colu_par'>Borrar</th>
					<th align='left' class="colu_impar">M&oacute;dulo</th>
					<th align='left' class="colu_par">Programa</th>
					<th align='center' class="colu_impar">Orden</th>
					</tr>
					<%if haylista then
						function laColu(esa)
							if esa=0 then
								laColu=estilo
							else
								laColu=estilo & esa
							end if
						end function
						laid=0
					for R=0 to ubound(RegLista,2)
						if (r mod 2)=0 then
							estilo="fila_par"
						else 
							estilo="fila_impar"
						end if
						if laid<>RegLista(RId,r) then%>
					<tr>
					<td align="center" class='<%=laColu(0)%>' width="10">
					  <input type="checkbox" style='border:none' name="aborrar" value="<%=RegLista(RId,r)%>" class="<%=laColu(0)%>">
					</td>
					<td align="left" class='<%=laColu(1)%>'>
					  <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'><%=RegLista(RModulo,r)%></a>
					</td>
					<td align="left" class='<%=laColu(0)%>'>
					  <%=RegLista(RPrograma,r)%>
					</td>
					<td align="center" class='<%=laColu(1)%>'>
					  <%=RegLista(ROrden,r)%>
					</td>
					</tr>
					<%if RegLista(RSuperior,r)<>0 then%>
						<tr>
						<td align="center" class='<%=laColu(0)%>' width="10">
						</td>
						<td align="left" class='<%=laColu(1)%>'>
							<input type="checkbox" style='border:none' name="aborrar" value="<%=RegLista(RSubId,r)%>" class="<%=laColu(0)%>">
							<a href='javascript:verFicha(<%=RegLista(RSubId,r)%>);'><%=RegLista(RSubModulo,r)%></a>
						</td>
						<td align="left" class='<%=laColu(0)%>'>
						  <%=RegLista(RSubPrograma,r)%>
						</td>
						<td align="center" class='<%=laColu(1)%>'>
						</td>
						</tr>
					<%end if%>
					<%else 'es submenu%>
						<tr>
						<td align="center" class='<%=laColu(0)%>' width="10">
						</td>
						<td align="left" class='<%=laColu(1)%>'>
							<input type="checkbox" style='border:none' name="aborrar" value="<%=RegLista(RSubId,r)%>" class="<%=laColu(0)%>">
							<a href='javascript:verFicha(<%=RegLista(RSubId,r)%>);'><%=RegLista(RSubModulo,r)%></a>
						</td>
						<td align="left" class='<%=laColu(0)%>'>
						  <%=RegLista(RSubPrograma,r)%>
						</td>
						<td align="center" class='<%=laColu(1)%>'>
						</td>
						</tr>
					<%end if
					laid=RegLista(RId,r)
					next
					end if%>
					<tr><td height='15' colspan='5'></td></tr>
					<tr><td align='right' colspan='5'>
					<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo M&oacute;dulo'>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
					</td>
					</tr>
					</table>
				
				</td>
				</tr>
			</table>
			
		</td></tr>
	</table>
	</form>
	</div> <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieframe.asp"-->
</body>
</html>