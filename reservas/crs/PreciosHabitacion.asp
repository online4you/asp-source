<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")

laid=clng("0" & request.QueryString("id"))
pasalir=0
%><!--#include file="ActuPVPHabis.asp"--><%

if laid<>0 then 'Busco el registro para modificar
	
	'Temporadas de ese hotel
	cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
	cs=cs & "WHERE CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo
	cs=cs & " ORDER BY FInicio"
	'response.Write cs & "<br>"
	rs.open cs,base
	haytempos=false
	if not rs.eof then
		RegTempos=rs.getrows
		TCodi=0
		TFIni=1
		TFFin=2
		haytempos=true
	end if
	rs.close

	'Busco los precios de esa habitacion
	cs= "SELECT IdHabita,Temporada,Preprebase,Preperhab "
	cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "Temporadas Temporadas "
	cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
	cs=cs & "WHERE IdHabita=" & laid & " AND YEAR(FInicio)=" & anyo
	cs=cs & " ORDER BY FInicio"
	rs.open cs,base
	hayprecios=false
	if not rs.eof then
		RegPrecios=rs.getrows
		PCodi=0
		PTempo=1
		PPrecio=2
		PPorH=3
		hayprecios=true
	end if
	rs.close

	if not hayprecios then 'crear los precios de las temporadas
		if haytempos then
			for t=0 to ubound(RegTempos,2)
				cs="INSERT INTO " & precrs & "TipoHabitaPrecios (IdHabita,Temporada,Preprebase,Preperhab) "
				cs=cs & "SELECT Id," & RegTempos(TCodi,t) & ",0,0 FROM " & precrs & "TipoHabitaNombres "
				cs=cs & "WHERE CodigoEsta=" & est & " AND Id=" & laid
				base.execute cs
			next 'temporadas
		end if 'temporadas
		
		'Busco los precios de esa habitacion
		cs= "SELECT IdHabita,Temporada,Preprebase,Preperhab "
		cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "Temporadas Temporadas "
		cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
		cs=cs & "WHERE IdHabita=" & laid & " AND YEAR(FInicio)=" & anyo
		cs=cs & " ORDER BY FInicio"
		rs.open cs,base
		hayprecios=false
		if not rs.eof then
			RegPrecios=rs.getrows
			PCodi=0
			PTempo=1
			PPrecio=2
			PPorH=3
			hayprecios=true
		end if
		rs.close

	end if 'hayprecios

end if 'laid<>0

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
function Modificar(){
	document.f1.action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>";
	document.f1.submit();
}
</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<div style="width:400px; " class="capaFrame">
	<div style='width:100%;' class="capaFrame1">
		<table width='100%' border='0' cellspacing='0' cellpadding="0">
		<tr class='cabetabla'>
		<th align='center' colspan="3">PRECIOS HABITACION</th>
		</tr>
		<tr class='cabetabla'>
		<th align='center'>Temporada</th>
		<th align='center'>Importe</th>
		<th align='center'>Modo Cálculo</th>
		</tr>
		<%if hayprecios then 'Lista Precios
				for p=0 to ubound(RegPrecios,2)%>
					<tr>
					<td align='center'>
					<%'Poner la temporada
					for t=0 to ubound(RegTempos,2)
						if RegTempos(Tcodi,t)=RegPrecios(PTempo,p) then%>
							<%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t))%>
						<%end if
					next%>
					</td>
					<td align='center'>
					<input type='text' name='importe-<%=RegPrecios(PTempo,p)%>' value='<%=formatnumber(RegPrecios(PPrecio,p),2)%>' style="width:55px" maxlength="8">
					</td>
					<td align='center'>
					<%
					marca0=""
					marca1=""
					if RegPrecios(PPorH,p) then 'Marca la opcion
						marca1=" checked"
					else
						marca0=" checked"
					end if				
					%>
					<input type="radio" name="tipo-<%=RegPrecios(PTempo,p)%>"  style='height:13px;border: 0px; width:13px' value="0"<%=marca0%>>x pers.
					&nbsp;&nbsp;
					<input type="radio" name="tipo-<%=RegPrecios(PTempo,p)%>"  style='height:13px;border: 0px; width:13px' value="1"<%=marca1%>>x Hab.
					</td>
					</tr>
				<%next
		end if%> 
		<tr><td colspan='3' height='5'></td></tr>
		</table>
	</div>
	<div align='center' class="capaFrame2">
		<input name='boton' type='button' value="Actualizar Precios" onclick='javascript:Modificar();' style="cursor:pointer"></div>
</div>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
