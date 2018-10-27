<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

laid=paClng(request.QueryString("id"))

'Tabla de habitaciones estandar
cs="SELECT TipoHabita.Id,Nombre,Idioma,Traduccion,ParaCapMax,ParaCapMin,ParaCapNormal,ParaAdultMax,ParaNiMax,ParaAdultMin  "
cs=cs & "FROM " & precrs & "TipoHabita TipoHabita LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabita.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabita' AND Campo='Nombre' "
cs=cs & "WHERE TipoHabita.Id=" & laid
hayhabis=false
rs.open cs,base
if not rs.eof then
	RegHabis=rs.getrows
	THId=0
	THNombre=1
	THLang=2
	THTradu=3
	THMax=4
	THMin=5
	THNormal=6
	THAMax=7
	THNMax=8
	THAMin=9
	hayhabis=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<script language="javascript" type="text/javascript">
<%if hayHabis then
for h=0 to ubound(RegHabis,2)
	if h=0 then %>
	parent.document.f1.nombre_<%=langPorDefecto%>.value='<%=RegHabis(THNombre,h)%>';
	parent.document.f1.capmin.value='<%=RegHabis(THMin,h)%>';
	parent.document.f1.capnormal.value='<%=RegHabis(THNormal,h)%>';
	parent.document.f1.capmax.value='<%=RegHabis(THMax,h)%>';
	parent.document.f1.adultmin.value='<%=RegHabis(THAMin,h)%>';
	parent.document.f1.adultmax.value='<%=RegHabis(THAMax,h)%>';
	parent.document.f1.ninmax.value='<%=RegHabis(THNMax,h)%>';
	<%end if
	if RegHabis(THLang,h)<>"" then%>
	if (parent.document.f1.nombre_<%=RegHabis(THLang,h)%>!=undefined)
		parent.document.f1.nombre_<%=RegHabis(THLang,h)%>.value='<%=RegHabis(THTradu,h)%>';
	<%end if
next
end if%>
</script>