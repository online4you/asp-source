<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

busco=request.QueryString("cualo")
pag=request.QueryString("pag")
mark=request.form("mark")
	
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

lhotel=replace(buscoHoteles,"WHERE "," AND ")
toSearch=controlAcentos(busco)
toSearch=Replace(toSearch, "[", "")
toSearch=Replace(toSearch, "]", "")
'Buscar los hoteles
cs="SELECT Establecimientos.CodigoEsta,Nombre,Poblacion "
cs=cs & "FROM (" & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) "
cs=cs & "WHERE Nombre LIKE '%" & toSearch & "%'" & lhotel
hayhotel=false
'response.write cs & "<br>"
rs.open cs,base
if not rs.eof then
	RegHoteles=rs.getrows
	HCodi=0
	HNombre=1
	HPobla=2
	hayhotel=true
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
<script language="javascript" type="text/javascript" src="includes/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="includes/moverFrames.js"></script>
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
//Si solo hay uno, cargo y cierro
<%if hayhotel then 
	if ubound(RegHoteles,2)=0 then%>
		<%if instr(pag,"alojamientos.asp")<>0 then%>
		//alert(<%=reghoteles(hcodi,0)%>);
		window.opener.verFicha(<%=RegHoteles(HCodi,0)%>);
		//alert (window.opener.location);}
		<%else%>
		window.opener.location="<%=pag%>?est=<%=RegHoteles(HCodi,0)%>";
		<%end if%>
		window.opener.focus();
		window.close();
		
	<%
	end if
end if%>

function Recarga(hotel){
	<%if instr(pag,"alojamientos.asp")<>0 then%>
	//window.opener.location="<%=pag%>?est="+hotel+"&id="+hotel+"&ver=dh";
	window.opener.verFicha(hotel);
	<%else%>
	window.opener.location="<%=pag%>?est="+hotel;
	<%end if%>
	window.opener.focus();
	window.close();
}

</script>
<body>
<div style="overflow-y:scroll; height:245px;">
<table border='0' cellpadding="0" cellspacing="2">
<tr>
	<th align='left' class="colu_impar" width='250'>Alojamiento</th>
	<th align='left' class="colu_par" width='100'>Zona</th>
</tr>
<%if not hayhotel then%>
	<tr>
		<td colspan='2' align='left' class="fila_par"><br><br>No encontrado, vuelva a intentarlo</td>
	</tr>
<%else
		for h=0 to ubound(RegHoteles,2)%>
			<tr>
			<td align='left' valign="top" class="fila_par">
			<a href="javascript:Recarga(<%=RegHoteles(HCodi,h)%>);">
			<%=RegHoteles(HNombre,h)%></a></td>
			<td align='left' valign="top" class="fila_impar"><%=RegHoteles(HPobla,h)%></td>
			</tr>
		<%next 'h
end if 'hayhotel%>
</table>
</div>
</body>
</html>