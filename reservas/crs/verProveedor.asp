<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
%>
<!--#include file="actuProveedor.asp"-->

<%
laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Proveedores "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		direccion=rs("direccion")
		cp=rs("cp")
		nomfiscal=rs("nomfiscal")
		dirfiscal=rs("dirfiscal")
		cpfiscal=rs("cpfiscal")
		cif=rs("cif")
		web=rs("webcadena")
		localidad=rs("localidad")
		comision=rs("comision")
		prepago=rs("prepago")
	end if
	rs.close
	cs="SELECT id,nombre,apellidos,cargo FROM " & precrs & "contactos WHERE idpro=" & laid 
	rs.open cs,base
	Haycontactos=false
	if not rs.eof then
	RegContactos=rs.getrows
		RCid=0
		RCnombre=1
		RCapellidos=2
		RCcargo=3
		haycontactos=true
	end if
	rs.close
	cs="SELECT establecimientos.CodigoEsta,nombre FROM " & precrs & "Establecimientos establecimientos INNER JOIN " & precrs & "Datoshotel datoshotel ON establecimientos.codigoesta=datoshotel.codigoesta WHERE Idpro=" & laid
	rs.open cs,base
	Hayhotelencadena=false
	if not rs.eof then
		Reghotelcad=rs.getrows
		RhCid=0
		RhCnombre=1
		Hayhotelencadena=true
	end if
	'response.write hayhotelencadena & " --- " & Reghotelcad(RhCid,0)
	rs.close
end if

set rs=nothing
base.close
set base=nothing
%>

<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	if (parent.ultimoFrame=="")
		parent.location="Proveedor.asp?p=<%=pag%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?modo=actu";

	document.f1.submit();
}
function cerrar(){
	encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';
}
</script>

<body class="laFicha">
<div class="tituloFicha" onmousedown="pulsada(top.document.getElementById('verFicha'))" onmouseup="javascript:top.liberaCapa();" onDblClick="javascript:cambiaForma();">
	<div class="nombreFicha">PROVEEDOR</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
			<table align='center'  border='0' cellpadding="0" cellspacing="2">
				<tr><td align='right'>Nombre:</td><input type='hidden' name='id' value='<%=laId%>'>
					<td align='left'><input type="text" maxlength="50" style="width:150px" value='<%=nombre%>' name="nombre"></td>
				</tr>
				<tr>
					<td align='right'>Dirección</td>
					<td align='left'><input type="text" maxlength="50" style="width:150px" value='<%=direccion%>' name="direccion"></td>
				</tr>
				<tr><td align='right'>Codigo Postal:</td>
					<td align='left'><input type="text" maxlength="15" style="width:150px" value='<%=cp%>' name="cp"></td>
				</tr>
				<tr><td align='right'>Nombre fiscal:</td>
					<td align='left'><input type="text" maxlength="50" style="width:150px" value='<%=nomfiscal%>' name="nomfiscal"></td>
				</tr>
				<tr><td align='right'>Dirección fiscal:</td>
					<td align='left'><input type="text" maxlength="50" style="width:150px" value='<%=dirfiscal%>' name="dirfiscal"></td>
				</tr>
				<tr><td align='right'>CP Fiscal:</td>
					<td align='left'><input type="text" maxlength="15" style="width:150px" value='<%=cpfiscal%>' name="cpfiscal"></td>
				</tr>
				<tr><td align='right'>CIF:</td>
					<td align='left'><input type="text" maxlength="9" style="width:150px" value='<%=cif%>' name="cif"></td>
				</tr>
				<tr><td align='right'>Localidad:</td>
					<td align='left'><input type="text" maxlength="75" style="width:150px" value='<%=localidad%>' name="loc"></td>
				<tr><td align='right'>Web:</td>
					<td align='left'><input type="text" maxlength="50" style="width:150px" value='<%=web%>' name="web"></td>
				</tr>
				<tr><td align='right'>% Comisión:</td>
					<td align='left'><input type="text" maxlength="10" style="width:50px" value='<%=comision%>' name="comision"></td>
				</tr>
				<tr><td align='right'>% Prepago:</td>
					<td align='left'><input type="text" maxlength="10" style="width:50px" value='<%=prepago%>' name="prepago"></td>
				</tr>
				<tr><td height='10' colspan='2'></td></tr>
				<%if Hayhotelencadena then ' ponemos hoteles de la cadena%>
				<tr><td align='right'>Hoteles:</td>
				<td align='left'>
					<%for ht=0 to ubound(reghotelcad,2)
						response.write "<a href=alojamientos.asp?id=" & Reghotelcad(RhCid,ht)& ">" & Reghotelcad(RhCnombre,ht) & "</a>"
						if ht<>ubound(reghotelcad,2) then
							response.write ", "
						end if
					next%>
				<tr><td height='10' colspan='2'></td></tr>
				<%end if%>
				</td></tr>
				<tr><td colspan='2' align='center'>
				<div id='botoncontactos' style='height:20px;overflow:hidden'>
				<table cellspacing='0' cellpadding='0' border='0'>
				<tr><td  colspan='2' align='center'><input id='contactos' type='button' class="boton86" value='Ver Contactos' onclick="javascript:parent.location.href='contactos.asp?pro=<%=laid%>'" style='cursor:pointer'></td></tr></table></div>
				</td></tr>
				<tr><td align='center' colspan='2'>
				<input id='boton' class="boton86" type='button' value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
				</td>
					 <td class="tdTabla"></td>
				</tr>
			</table>
	</td>
    <td class="tdTabla"></td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.modulo.focus();
</script>
</body>
</html>