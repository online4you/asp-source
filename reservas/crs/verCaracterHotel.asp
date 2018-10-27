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

laid=paClng(request.QueryString("idh"))

cs="SELECT Caracteristicas.Id,Caracteristica,Icono,CodigoEsta FROM " & precrs & "Caracteristicas Caracteristicas LEFT JOIN " & precrs & "CaracteristicasHotel CaracteristicasHotel "
cs=cs & "ON Caracteristicas.Id=CaracteristicasHotel.IdCaracter AND CodigoEsta=" & laid
cs=cs & " ORDER BY Orden"
'response.write cs
rs.open cs,base
hayLista=false
if not rs.eof then
	RegLista=rs.getrows
	RId=0
	RNombre=1
	RIcono=2
	RHotel=3
	hayLista=true
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
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.cerrar();
}

function marcar(ese){
	var url="";
	if (ese.checked)
		marca=1;
	else
		marca=0;
		
	url="marcaCaracterHotel.asp?est=<%=laid%>&id="+ese.value+"&marca="+marca;
	$("paProcesos").src=url;
}

</script>
<body class="laFicha">
<iframe name="paProcesos" id="paProcesos" class="fichaIframe" src="vacio.html"></iframe>
<form name='f1' action="<%=MiPag%>" method="post">
<div style="height:380px; width:960px; overflow-x:hidden; overflow-y:scroll;">		
	<table align='center' width='945' border='0' cellpadding="0" cellspacing="2">
		<tr><td align='left' colspan="4"><%=objIdioma.getTraduccionHTML("i_textocaracter")%></td></tr>
        <tr><td align='left' colspan="4" height="10"></td></tr>
        <%if hayLista then
		colu=1
		for r=0 to ubound(RegLista,2)
			if colu=1 then response.write "<tr>"%>
				<td align="left" valign="middle" width="25%">
					<%if RegLista(RIcono,r)<>"" then%>
						<img src="<%=rutaFotos & RegLista(RIcono,r)%>" style="max-width:40px;" align="left">
					<%end if%>
                    &nbsp;<input type="checkbox" name="caracter_<%=RegLista(RId,r)%>" onclick="javascript:marcar(this);" value="<%=RegLista(RId,r)%>"<%if not isnull(RegLista(RHotel,r)) then response.write " checked"%>>
                    &nbsp;<%=RegLista(RNombre,r)%>
				</td>
        	<%colu=colu+1
			if colu>4 then 
				response.write "</tr>"
				colu=1
			end if 'colu
        next 'r
		end if 'hayLista%>
	</table>
</div>
<center>
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>