<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuVisita.asp"--><%

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
laid=paClng(request.QueryString("id"))
if laid<>0 then 
	cs="SELECT VisitasVIP.*,Fichas.Nombre,Fichas.Apellidos,CodigoVIP FROM " & precrs & "VisitasVIP VisitasVIP LEFT JOIN " & precrs & "Fichas Fichas "
	cs=cs & "ON VisitasVIP.IdFicha=Fichas.Id "
	cs=cs & "WHERE VisitasVIP.Id=" & laid
	rs.open cs,base
	if not rs.eof then
		codamigo=rs("codigoVIP")
		codigoesta=rs("codigoesta")
		fecha=rs("fecha")
		noches=rs("noches")
		habitacion=rs("habitacion")
		pax=rs("pax")
		comentarios=rs("comentario")
		codreserva=rs("codreserva")
		nombre=rs("Apellidos") & ", " & rs("nombre")
	end if
	rs.close

else
	idficha=paCLng(request.QueryString("idf"))
	if idficha<>0 then 'busco el nombre
		cs="SELECT Nombre,Apellidos,CodigoVIP FROM Fichas WHERE Id=" & idficha
		rs.open cs,base
		if not rs.eof then
			nombre=rs("Apellidos") & ", " & rs("nombre")
			codAmigo=rs("codigoVIP")
		end if
		rs.close
	end if	
end if

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

	
set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	//top.frames['<%=recarga%>'].location="visitas.asp?p=<%=pag%>";
	eval("top.<%=recarga%>.location.reload()");
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";
		
	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">VISITA AMIGO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div id='conteAmigo' style="overflow:hidden; height:auto; width:100%;">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="left" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
    
      <table align='left' width='100%' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
		<tr>
			<td align='right' width='150'>Cod. Amigo:</td>
			<td align='left'><b><%=codamigo%>&nbsp;<span id='elNombre'><%=nombre%></span></b>
            <input type="hidden" name="idficha" value="<%=idficha%>">
            </td>
		</tr>
		<tr>
			<td align='right'>Hotel:</td>
			<td align='left'>
			<select name="codigoesta">
			<option value="0">Seleccionar</option>
			<%if hayhoteles then
				for h=0 to ubound(RegHoteles,2)
				marca=""
				if codigoesta=RegHoteles(HCodi,h) then marca=" selected"%>
				<option value="<%=RegHoteles(HCodi,h)%>"<%=marca%>><%=RegHoteles(HNombre,h)%></option>
				<%next
			end if%>
			</select>
			</td>
		</tr>
		<tr>
			<td align='right'>Fecha Visita:</td>
			<td align='left'>
			<input type="text" style="width:80px;" maxlength="12" name="fecha" value="<%=verFecha(fecha)%>"> (dd/mm/aa)
			</td>
		</tr>
		<tr>
			<td align='right'>Cod. Reserva:</td>
			<td align='left'><input type='text' style='width:80px' maxlength='14' name='codreserva' value='<%=codreserva%>'></td>
		</tr>
		<tr>
			<td align='right'>Nº Noches:</td>
			<td align='left'><input type='text' style='width:80px' maxlength='14' name='noches' value='<%=noches%>'></td>
		</tr>
		<tr>
			<td align='right'>Nº Habitación:</td>
			<td align='left'><input type='text' style='width:80px' maxlength='14' name='habitacion' value='<%=habitacion%>'></td>
		</tr>
		<tr>
			<td align='right'>Nº Pax:</td>
			<td align='left'><input type='text' style='width:80px' maxlength='14' name='pax' value='<%=pax%>'></td>
		</tr>
		<tr>
			<td align='right'>Comentarios:</td>
			<td align='left'><textarea style='width:250px;height:80px;' name='obs'><%=comentarios%></textarea></td>
		</tr>
        <tr>
          <td colspan="2" height='5'></td>
        </tr>
      </table>   
    </td>
   	</tr>
    <tr><td align="center">
            <input name="botonet" type='button' class="boton86" id='botonet' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	</td></tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	//alert(document.getElementById('conteReserva').offsetHeight);
	alto=(document.getElementById('conteAmigo').offsetHeight-500); //tamaño capa
	top.document.getElementById(this.name).style.height=(top.document.getElementById(this.name).offsetHeight+alto)+"px";

	<%if laid=0 then%>
		document.getElementById('botonet').value='Añadir';
	<%end if%>
	document.f1.codigovip.focus();
</script>
</body>
</html>
