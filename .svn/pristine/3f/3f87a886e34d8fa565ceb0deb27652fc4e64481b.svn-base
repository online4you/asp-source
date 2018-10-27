<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

idtipo=paClng(request.QueryString("idtipo"))
if idtipo=0 then 'cargar todos los hoteles
	busco=""
else 'hoteles de la zona
	busco=" AND TipoAlojamiento=" & idtipo
end if


'Lista de hoteles de esta empresa
cs="SELECT Establecimientos.CodigoEsta,Nombre "
cs=cs & "FROM Establecimientos INNER JOIN DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta "
cs=cs & " WHERE Estado<>" & noventa & busco
cs=cs & " ORDER BY Orde"

rs.open cs,base
hayHoteles=false
if not rs.eof then
	RegHoteles=rs.getrows
	HCodi=0
	HNombre=1
	hayHoteles=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<script language="javascript" type="text/javascript">
top.$("listaHoteles").innerHTML="<a href=javascript:cambiaHotel(0,'<%=objIdioma.getTraduccionHTML("i_todos")%>')><%=objIdioma.getTraduccionHTML("i_todos")%></a>";
<%
if hayHoteles then
for h=0 to ubound(RegHoteles,2)%>
	hotel=escape('<%=RegHoteles(HNombre,h)%>');
	top.$("listaHoteles").innerHTML=top.$("listaHoteles").innerHTML+"<a href=javascript:cambiaHotel(<%=RegHoteles(HCodi,h)%>,'"+hotel+"')><%=RegHoteles(HNombre,h)%></a>";
<%next
end if%>

top.cambiaHotel(0,'<%=objIdioma.getTraduccionHTML("i_todos")%>'); //primero por defecto
</script>
<%set objIdioma=nothing%>