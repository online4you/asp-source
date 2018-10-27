<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga")
modo=request.QueryString("modo")
if modo="borra" then
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cs="("
		for t=0 to ubound(queborro)
			if clng(queborro(t))<>0 then 'Para no borrar la cero
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			end if
		next
		if right(cs,4)=" OR " then 'Quitar el ultimo operador
			cs=left(cs,len(cs)-4)
		end if	
		cs=cs & ")"
		
		base.execute "DELETE FROM " & precrs & "SizeGraficos WHERE " & cs
		
	end if

end if 'modo=borra

laid=paClng(request.QueryString("ide"))
if laid<>0 then 'Busco la empresa

	cs="SELECT Id,Ancho,Alto,Prefijo,ProporcionAncho,ProporcionAlto FROM " & precrs & "SizeGraficos "
	cs=cs & "WHERE IdEmpresa=" & laid
	rs.open cs,base
	haySize=false
	if not rs.eof then
		RegSize=rs.GetRows
		RCodi=0
		RAncho=1
		RAlto=2
		RPrefi=3
		RPAncho=4
		RPAlto=5
		haySize=true
	end if
	rs.close
	
	'Busca nombre empresa
	cs="SELECT Nombre FROM " & precrs & "Empresas WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
	end if
	rs.close


end if 'laid<>0

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
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esta ventana
}

function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&ide=<%=laid%>";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verSizeGraficos.asp?id=0&ide=<%=laid%>&recarga="+self.name,350,200,0,0);
}
function verFicha(id){
	top.creaFlotante("verSizeGraficos.asp?id="+id+"&ide=<%=laid%>&recarga="+self.name,350,200,0,0);
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=nombre%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
	<div style="height:150px; overflow-y:scroll; overflow-x:hidden">
	 <table width='98%' border="0" cellpadding="0" cellspacing="1">
		  <tr>
			<th class="colu_par"></th>
			<th align="center" class="colu_par">Id</th>
			<th align="center" class="colu_par">Ancho</th>
			<th align="center" class="colu_par">Alto</th>
            <th align="center" class="colu_par">Prefijo</th>
            <th align="center" class="colu_par">Mantiene Ancho</th>
            <th align="center" class="colu_par">Mantiene Alto</th>
		  </tr>
		<%if haySize then
		for R=0 to ubound(RegSize,2)
			if (r mod 2)=0 then 
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
		  <tr>
			<td align="center" width='10' class="<%=estilo%>">
			  <input type="checkbox" style='border:none' name="aborrar" value="<%=RegSize(RCodi,r)%>">
			</td>
			<td align="center" class="<%=estilo%>">
			  <a href='javascript:verFicha(<%=RegSize(RCodi,r)%>);' class="enlaceLista"><%=RegSize(RCodi,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>">
			<a href='javascript:verFicha(<%=RegSize(RCodi,r)%>);' class="enlaceLista">
			<%=RegSize(RAncho,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>">
			<a href='javascript:verFicha(<%=RegSize(RCodi,r)%>);' class="enlaceLista">
			<%=RegSize(RAlto,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>">
			<a href='javascript:verFicha(<%=RegSize(RCodi,r)%>);' class="enlaceLista">
			<%=RegSize(RPrefi,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>">
            <%if RegSize(RPAncho,r) then response.write "Sí"%>
            </td>
			<td align="center" class="<%=estilo%>">
            <%if RegSize(RPAlto,r) then response.write "Sí"%>
            </td>
		  </tr>
		<%next
		end if%>
	</table>
	</div>
	<div align="center">
		<input type="button" class="boton86" value="Nuevo" onClick="javascript:enBlanco();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="boton86" value="Borrar marcados" onClick="javascript:ABorrar();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="boton86" value="Cerrar" onClick="javascript:cerrar();">
	</div>

</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
