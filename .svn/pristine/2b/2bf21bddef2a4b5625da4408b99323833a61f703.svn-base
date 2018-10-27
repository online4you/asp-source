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

est=paClng(request.QueryString("est"))
cpromo=request.QueryString("cpromo")
fini=cdate(request.QueryString("fini"))
ffin=cdate(request.QueryString("ffin"))


'Comprobar cod. promociones
cs="SELECT CodigoPromocion,FechaInicio,FechaFin,"
cs=cs & "ISNULL(dbo.fnGetTraduccion('Ofertas','Titulo',Id,'" & lang & "'),Titulo) AS Titulo "
cs=cs & "FROM Ofertas "
cs=cs & "WHERE Activa<>0 AND Calcula<>0 AND Ofertas.CodigoEsta=" & est & " AND Caduca>" & fechaSQLServer(date)
cs=cs & " AND CodigoPromocion='" & cpromo & "'"
cs=cs & " AND (((" & fechaSQLServer(fini) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & "(" & fechaSQLServer(ffin-1) & " BETWEEN FechaInicio AND FechaFin)) OR "
cs=cs & "((" & fechaSQLServer(fini) & " BETWEEN FechaInicio AND FechaFin) AND "
cs=cs & fechaSQLServer(ffin-1) & ">FechaFin) OR (" & fechaSQLServer(fini) & "<FechaInicio AND "
cs=cs & "(" & fechaSQLServer(ffin-1) & " BETWEEN FechaInicio AND FechaFin)) OR ("
cs=cs & fechaSQLServer(fini) & "<FechaInicio AND " & fechaSQLServer(ffin-1) & ">FechaFin))"
hayOferta=false
rs.open cs,base
if not rs.eof then
	IdOferta=rs("CodigoPromocion")
	tituOferta=rs("titulo")
	msgerror=tituOferta
else
	IdOferta=""
	tituOferta=""
	msgerror="Cod. Promoción no es válido o fechas incorrectas"
end if
rs.close

set rs=nothing
base.close

response.write "<b>&raquo;&nbsp;" & msgerror & "</b>"
%>
<script language="javascript" type="text/javascript">
$('#codpromo').val("<%=IdOferta%>");
document.fb.cpromo.value="<%=IdOferta%>";
document.fb.npromo.value="<%=tituOferta%>";
document.f1.cpromo.value="<%=IdOferta%>";
document.f1.npromo.value="<%=tituOferta%>";
</script>
<%set objIdioma=nothing%>