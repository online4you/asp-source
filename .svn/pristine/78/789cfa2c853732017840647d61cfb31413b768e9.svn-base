<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

laid=paClng(request.QueryString("id"))
recarga=request.QueryString("recarga")

if request.form<>"" and request.QueryString("modo")="borra" then 'borra registros
	
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cadena=""
		for t=0 to ubound(queborro)
			cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
		next
		if right(cadena,4)=" OR " then 'Quitar el ultimo operador
			cadena=left(cadena,len(cadena)-4)
		end if	
		'Borrar 
		cs="DELETE FROM " & precrs & "VisitasVIP VisitasVIP WHERE " & cadena
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	end if

end if 'form

'Lista de registros
cs="SELECT VisitasVIP.Id,Fichas.CodigoVIP,Fecha,NumDias,Establecimientos.Nombre as Hotel,"
cs=cs & "(isnull(Fichas.Apellidos,'')+' '+Fichas.Nombre) as NombreAmigo "
cs=cs & "FROM ((" & precrs & "VisitasVIP VisitasVIP LEFT JOIN " & precrs & "Fichas Fichas "
cs=cs & "ON VisitasVIP.IdFicha=Fichas.Id) LEFT JOIN Establecimientos "
cs=cs & "ON VisitasVIP.CodigoEsta=Establecimientos.CodigoEsta) LEFT JOIN Reservas "
cs=cs & "ON VisitasVIP.CodReserva=Reservas.Cod_Res "
cs=cs & "WHERE IdFicha=" & laid
cs=cs & " ORDER BY VisitasVIP.Id Desc "
'response.write cs
rs.Open cs, base
haylista=false
if not rs.eof then
	haylista=true
	RegLista=rs.GetRows
	RId=0
	RCodigo=1
	RFecha=2
	RNoches=3
	RHotel=4
	RAmigo=5
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
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?id=<%=laid%>&modo=borra&recarga=<%=recarga%>";
		document.f1.submit();
	}
}
function cerrar(){
	parent.cerrar();
}
function verVisita(id){
	top.creaFlotante("verVisita.asp?id="+id+"&recarga=<%=recarga%>."+self.name,500,400,0,0);
}
function nuevaVisita(){
	top.creaFlotante("verVisita.asp?id=0&idf=<%=laid%>&recarga=<%=recarga%>."+self.name,500,400,0,0);
}
</script>
<body>
<form name='f1' method="post">
<div style="height:380px; overflow-y:scroll;">
	<table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
     <tr>
     	<th align="center" class="colu_par"></th>
        <th align="center" class="colu_impar">Id</th>
		<th align='center' class="colu_par">Fecha</th>
        <th align='center' class="colu_impar">Cod. Amigo</th>
		<th align='center' class="colu_par">Nombre</th>
        <th align='center' class="colu_impar">Hotel</th>
        <th align='center' class="colu_par">Noches</th>
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
		<input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RId,r)%>"></td>
		<td align="center" class='<%=laColu(1)%>'>
		<a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=RegLista(RId,r)%></a></td>
		<td align="center" class='<%=laColu(0)%>' >
		<a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=VerFecha(RegLista(RFecha,r))%></a></td>
        <td align="center" class='<%=laColu(1)%>'>
		<a href='javascript:verVisita(<%=RegLista(RId,r)%>);'><%=RegLista(RCodigo,r)%></a></td>
        <td align="center" class='<%=laColu(0)%>'><%=RegLista(RAmigo,r)%></td>
        <td align="center" class='<%=laColu(1)%>'><%=RegLista(RHotel,r)%></td>
		<td align="center" class='<%=laColu(0)%>'><%=RegLista(RNoches,r)%></td>
      </tr>
      <%
	next
end if%>
</table>
</div>
<div align="center">
    <input type='button' class="boton145" value='Nueva Visita' onclick="javascript:nuevaVisita();">
    <input type='button' class="boton145" value='Borrar Marcadas' onclick='javascript:ABorrar();'>
    <input type='button' class="boton145" value='Cerrar' onclick='javascript:cerrar();'>
</div>
</form>
</body>
</html>
