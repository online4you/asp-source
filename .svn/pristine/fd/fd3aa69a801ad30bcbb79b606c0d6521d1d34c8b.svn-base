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

	'Dtos colectivos por habitacion y temporada, y establecimiento
	cs="SELECT DescuentosColectivos.CodigoColec,Temporada,Prebase,Precio "
	cs=cs & "FROM (" & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
	cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec) "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo & " AND TipoHab=" & laid
	rs.open cs,base
	haydtos=false
	if not rs.eof then
		RegDtos=rs.getrows
		DCodi=0
		DTempo=1
		Ddto=2
		DPrecio=3
		haydtos=true
	end if
	rs.close
	
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

	'Bucar los nombres colectivos de este hotel
	cs="SELECT CodigoColec,Nombre,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "ColectivosNomres ColectivosNomres "
	cs=cs & "ON Colectivos.COdigoColec=ColectivosNomres.ColectivoIdi "
	cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' AND Nombre<>''"
	rs.open cs,base
	if not rs.eof then
		RegColec=rs.getrows
		CCodi=0
		CNombre=1
		COrde=2
	end if
	rs.close
	
end if 'laid<>0

set rs=nothing
base.close
set base=nothing
%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="css.css" rel="stylesheet" type="text/css">
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript" src="js/funciones.js"></script>
<style type="text/css">
<!--
body {
	margin:0px;
	background-image:none;
}
-->
</style>
</head>
<script language="javascript">
function Modificar(){
	document.f1.action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>";
	document.f1.submit();
}
</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<div style="width:500px;" class="capaFrame">
	<div style='width:100%;' class="capaFrame1">
	<table width='100%' border='0' cellspacing='0'>
	<tr class='cabetabla'>
	<th align='center' colspan="5">DESCUENTOS CAMA SUPLETORIA EN HABITACION</th>
	</tr>
	<tr class='cabetabla'>
	<th align='center'></th>
	<th align='center'>Colectivo</th>
	<th align='center'>Temporada</th>
	<th align='center'>% Dto.</th>
	<th align='center'>Precio</th>
	</tr>
	<%if haydtos then 'Lista Precios
			for p=0 to ubound(RegDtos,2)
				identidad=laid & "-" & RegDtos(DCodi,p) & "-" & RegDtos(DTempo,p)
				'Comprobar que sea de esa habitacoin
				if RegDtos(DHabi,p)=laid then
				%>
				<tr>
				<td align='center'><input type='checkbox' name='dtoborrar' value='<%=identidad%>'  style='height:13;border: 0px; width:13px'></td>
				<td align='center'>
					<select name='colectivo-<%=identidad%>'>
				<%'Poner lista de Colectivos y marcar la selecc.
						for c=0 to ubound(RegColec,2)
							marca=""
							if RegColec(CCodi,c)=RegDtos(DCodi,p) then marca="selected"%>
							<option value='<%=RegColec(CCodi,c)%>' <%=marca%>>
								<%=RegColec(CNombre,c)%>
							</option>
						<%next%>
					</select>
				</td>
				<td align='center'>
					<select name='temporada-<%=identidad%>'>
						<option value='0' <%if RegDtos(DTempo,p)=0 then response.write "selected"%>>Cualquiera</option>
						<%'Poner lista de temporadas y marcar la selecc.
						for t=0 to ubound(RegTempos,2)
							marca=""
							if RegTempos(Tcodi,t)=RegDtos(DTempo,p) then marca="selected"%>
							<option value='<%=RegTempos(Tcodi,t)%>' <%=marca%>>
								<%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t))%>
							</option>
						<%next%>
					</select>
				</td>
				<td align='center'>
				<input type='text' name='dto-<%=identidad%>' value='<%=RegDtos(DDto,p)%>' size='4' maxlength="8">
				</td>
				<td align='right'>
				<input type='text' name='precio-<%=identidad%>' value='<%=RegDtos(DPrecio,p)%>' style="width:30px" maxlength="8">
				</tr>
				<%end if 'misma habitacion
			next
	end if%> 
	</table>
	</div>
	<div align='center' class="capaFrame2">
		<input name='boton' type='button' value="Nuevo Dto" onclick="javascript:VerDesglose(false);document.getElementById('nuevodto').style.visibility='visible';document.f1.colectivodto.focus();" style="cursor:pointer">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input name='boton' type='button' value="Actualizar" onclick='javascript:ModificarDtos();' style="cursor:pointer">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input name='boton' type='button' value="Borrar" onclick='javascript:BorrarDtos();' style="cursor:pointer">
	</div>
</div>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
