<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
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
		
		on error resume next
		base.BeginTrans
		base.execute "DELETE FROM " & precrs & "SeccionesHotel SeccionesHotel WHERE " & cs
		controlRegistro("DELETE FROM SeccionesHotel WHERE " & cs) 'guarda seguimiento
		
		'Borrar traducciones
		cs=replace(cs,"Id=","IdReferencia=")
		base.execute "DELETE FROM " & precrs & "Traducciones Traducciones WHERE " & cs & " AND Tabla='SeccionesHotel'"
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0
		
		response.Cookies("cambioSecci")="1" 'para actualizar la ficha
		
	end if

end if 'modo=borra

laid=paClng(request.QueryString("idh"))
if laid<>0 then 'Busco el registro para modificar

	cs="SELECT Id,Seccion,Orden FROM " & precrs & "SeccionesHotel "
	cs=cs & "WHERE CodigoEsta=" & laid & " ORDER BY Orden"
	rs.open cs,base
	haySecci=false
	if not rs.eof then
		RegSecci=rs.GetRows
		RsCodi=0
		RsNombre=1
		RsOrden=2
		haySecci=true
	end if
	rs.close
	
	'Busca nombre hotel
	cs="SELECT Nombre FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & laid
	rs.open cs,base
	if not rs.eof then
		nombreHotel=rs("nombre")
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
	if (GetCookie("cambioSecci")=="1") {
		url=top.frames['<%=recarga%>'].location;
		top.frames['<%=recarga%>'].location=url;
	}
	top.quitaFlota(self.name); //quito esta ventana
}

function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&idh=<%=laid%>&recarga=<%=recarga%>";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verSeccion.asp?id=0&idh=<%=laid%>&recarga="+self.name,450,200,0,0);
}
function verFicha(id){
	top.creaFlotante("verSeccion.asp?id="+id+"&idh=<%=laid%>&recarga="+self.name,450,200,0,0);
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_seccion")%> -> <%=nombreHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
	<div style="height:150px; overflow-y:scroll; overflow-x:hidden">
	 <table width='98%' border="0" cellpadding="0" cellspacing="1">
		  <tr>
			<th class="colu_par"></th>
			<th align="center" class="colu_par">Id</th>
			<th align="center" class="colu_par"><%=objIdioma.getTraduccionHTML("i_seccion")%></th>
			<th align="center" class="colu_par"><%=objIdioma.getTraduccionHTML("i_orden")%></th>
		  </tr>
		<%if haySecci then
		for R=0 to ubound(RegSecci,2)
			if (r mod 2)=0 then 
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
		  <tr>
			<td align="center" width='10' class="<%=estilo%>">
			  <input type="checkbox" style='border:none' name="aborrar" value="<%=RegSecci(RsCodi,r)%>">
			</td>
			<td align="center" class="<%=estilo%>">
			  <a href='javascript:verFicha(<%=RegSecci(RId,r)%>);' class="enlaceLista"><%=RegSecci(RsCodi,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>">
			<a href='javascript:verFicha(<%=RegSecci(RsCodi,r)%>);' class="enlaceLista">
			<%=RegSecci(RsNombre,r)%></a>
			</td>
			<td align="center" class="<%=estilo%>"><%=paClng(RegSecci(RsOrden,r))%></td>
		  </tr>
		<%next
		end if%>
	</table>
	</div>
	<div align="center">
		<input type="button" class="boton86" value="Nueva" onClick="javascript:enBlanco();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="boton86" value="Borrar marcadas" onClick="javascript:ABorrar();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="boton86" value="Cerrar" onClick="javascript:cerrar();">
	</div>

</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
