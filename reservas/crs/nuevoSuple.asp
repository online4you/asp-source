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

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("idh"))

pasalir=0
if request.Form<>"" then
	'Añadir dto
	regimen=paClng(request.form("regimen"))
	habitacion=paClng(request.form("habitacion"))
	tempo=paClng(request.form("temporada"))
	precio=request.form("precio")
	defecto=request.form("defecto")
	if defecto="" then defecto=0
	'Comprobar que no exista el mismo
	cs="SELECT Id FROM " & precrs & "RegimenHotel WHERE IdRegimen=" & regimen & " AND CodigoTempo=" & tempo
	cs=cs & " AND CodigoHab=" & habitacion & " AND CodigoEsta=" & est & " AND Anyo=" & anyo & " AND Tarifa=" & laTarifa
	rs.open cs,base
	if rs.eof then
		'Añadir el nuevo
		cs="INSERT INTO " & precrs & "RegimenHotel (IdRegimen,CodigoEsta,CodigoHab,CodigoTempo,Precio,"
		cs=cs & "Defecto,Anyo,Tarifa) VALUES (" & regimen & "," & est & ","
		cs=cs & habitacion & "," & tempo & "," & QuitarComaMiles(precio) & "," & defecto
		cs=cs & "," & anyo & "," & laTarifa & ")"
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
		pasalir=1
		
	else 'ya está
		msgerror=objIdioma.getTraduccionHTML("i_regimenexiste")
	end if
	rs.close
		
end if 'form<>""

'Suplementos
cs="SELECT Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion)  AS Tradu "
cs=cs & " FROM " & precrs & "Regimen Regimen LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "ORDER BY Regimen.Id"
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close


'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") "
cs=cs & " ORDER BY FInicio"
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
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame("<%=recarga%>");
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?modo=nuevo&idh=<%=laId%>&est=<%=est%>&recarga=<%=recarga%>";
	document.f1.submit();
}
</script>
<style>
.fila_impar, .fila_par {
	white-space:nowrap;
}
</style>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_precioregimen")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2" class="tdTabla">
	<%if msgerror<>"" then 'repetido%>
	<tr><th align='left' colspan="5" class="colu_impar">&nbsp;*&nbsp;<%=msgerror%></th>
	</tr>
	<%end if%>
	<tr><th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
		<th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_habitacion")%></th>
		<th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_temporada")%></th>
		<th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
		<th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_incluido")%></th>
	</tr>
	<tr><td align="center">
		<select name='regimen'>
		<%'Poner lista de Regimen
		for c=0 to ubound(RegSuples,2)%>
			<option value='<%=RegSuples(SCodi,c)%>'>
				<%=RegSuples(SNombre,c)%>
			</option>
		<%next%>
		</select>
		</td>
		<td align="center">
		<select name='habitacion'>
		<option value="0"><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
		<option value="<%=laId%>">Esta Hab.</option>
		</select>
		</td>
		<td align="center">
		<select name='temporada'>
		<option value="0"><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
		<%'Poner lista de Colectivos 
		for t=0 to ubound(RegTempos,2)%>
			<option value='<%=RegTempos(Tcodi,t)%>'>
				<%=VerFecha(RegTempos(TFini,t)) & "-" & VerFecha(RegTempos(TFfin,t))%>
			</option>
		<%next%>
		</select>
		</td>
		<td align="center">
		<input type="text" name="precio" style="width:50px;">
		</td>
		<td align="center">
		<input type="checkbox" name="defecto" value="-1">
		</td>
	</tr>
	<tr><td colspan="5" height="10"></td></tr>
	<tr><td align='center' colspan='5'>
		<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_nuevo")%>' onclick="javascript:Modificar();" class="boton86">	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class='boton86' onClick="javascript:cerrar();" ></td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	document.f1.regimen.focus();
</script>
</body>
</html>