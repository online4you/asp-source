<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")

tipoh="0"
laid=clng("0" & request.QueryString("id"))
pasalir=0
%>
<!--#include file="modiHabis.asp"-->
<%
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "TipoHabitaNombres "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		orden=rs("orden")
		nombre_es=rs("nombre_es")
		nombre_it=rs("nombre_it")
		nombre_en=rs("nombre_en")
		nombre_de=rs("nombre_de")
		nombre_fr=rs("nombre_fr")
		tipoh=rs("tipohabitacion")
		capmin=rs("paracapmin")
		capnormal=rs("paracapnormal")
		capmax=rs("paracapmax")
		adultmax=rs("paraAdultMax")
		adultmin=rs("paraAdultMin")
		ninmax=rs("paraNiMax")
		cunaocupa=rs("cunaocupa")
		
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
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?modo=actu";

	document.f1.submit();
}
function Cerrar(){
	parent.document.getElementById('verHabitacion').style.visibility='hidden';
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	if (parent.ultimoFrame=="undefined")
		parent.location="HabitacionesNew.asp?est=<%=est%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	Cerrar();
<%end if%>
</script>
<body onmousemove="mueveCapa(event)">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" width='100%' cellpadding="0" cellspacing="0" id="mitabla" class="tdTabla">
  <tr><td background="img/corners/a_c.gif">
		<table align='center' width='100%' border='0' cellpadding="0" cellspacing="1">
		<tr>
			<td width="33%">&nbsp;</td>
			<td width='33%' align='center'><div align="center" class="tituCapa" onmousedown="clickCapa(event, top.document.getElementById('verHabitacion'))" onmouseup="javascript:top.liberaCapa();" style="width:100%">HABITACI&Oacute;N</div>
			</td>
			<td width='33%' align='right'><input name='cierre2' type='button' value='X Cerrar' style='cursor:pointer; height:14; margin-top:2px' onclick="javascript:Cerrar();">
			</td>
		</tr>
		</table>
	</td></tr>
  <tr><td class="tdTabla">

	<table width='100%' border='0' cellspacing='0' bgcolor="#FFDCB9">
		<tr><td colspan='5' align='left'>
			Tipo Habitación Estandar:
			<select name='tipoh' onChange="ponerTipoH(this);">
				<option value='0'>Seleccionar</option>
				<%if hayhabis then
					for h=0 to ubound(RegTHabis,2)
						marca=""
						if RegTHabis(THId,h)=tipoh then marca="selected"%>
						<option value='<%=RegTHabis(HId,h)%>' <%=marca%>><%=RegTHabis(THN_es,h)%></option>
					<%next
				end if%>
			</select>
		</td>
		</tr>
	
		<tr>
		<td align='left'>Nombre Esp.</td>
		<td align='left'>Nombre Ita.</td>
		<td align='left'>Nombre Ing.</td>
		<td align='left'>Nombre Ale.</td>
		<td align='left'>Nombre Fr.</td>
		</tr><tr>
		<td align='left'><input type='text' style="width:170px;" maxlength='50' name='nombre_es' value='<%=nombre_es%>'></td>
		<td align='left'><input type='text' style="width:170px;" maxlength='50' name='nombre_it' value='<%=nombre_it%>'></td>
		<td align='left'><input type='text' style="width:170px;" maxlength='50' name='nombre_en' value='<%=nombre_en%>'></td>
		<td align='left'><input type='text' style="width:170px;" maxlength='50' name='nombre_de' value='<%=nombre_de%>'></td>
		<td align='left'><input type='text' style="width:170px;" maxlength='50' name='nombre_fr' value='<%=nombre_fr%>'></td>
		</tr>
		<tr>
		<td align='left' colspan="5">Cap. M&iacute;nima:&nbsp;
			<input type="text" name="capmin" value="<%=capmin%>" size='3' maxlength="5">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Cap. Normal:&nbsp;
			<input type="text" name="capnormal" value="<%=capnormal%>" size='3' maxlength="5">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Cap. Máxima:&nbsp;
			<input type="text" name="capmax" value="<%=capmax%>" size='3' maxlength="5">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Adult. Mínimo:&nbsp;
			<input type="text" name="adultmin" value="<%=adultmin%>" size='3' maxlength="5">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Adult. Máximo:&nbsp;
			<input type="text" name="adultmax" value="<%=adultmax%>" size='3' maxlength="5">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Niños Máximo:&nbsp;
			<input type="text" name="ninmax" value="<%=ninmax%>" size='3' maxlength="5"></td>		
		</tr>
		<tr>
		<td align='left'>Orden Visualización
		<select name='orden'>
			<%for o=0 to 8
					marca=""
					if o=orden then marca="selected"%>
				<option value='<%=o%>' <%=marca%>><%=o%></option>
			<%next%>
		</select>
		</td>
		<td align='left' colspan="4">¿La cuna ocupa plaza?&nbsp;
			<input type="checkbox" value="1" name="cunaocupa"<%if cunaocupa then response.write " checked"%>>&nbsp;
			(si está marcado los bebes ocupan plaza de la habitación)
		</td>
		</tr>
		<tr><td colspan="5" height='10'></td></tr>
		<tr><td colspan='5' align='center'>
		<input id='bnuevo' type='button' value='Actualizar datos habitación' onclick="javascript:Modificar();" style='cursor:pointer'>	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='elcupo' style='cursor:pointer' onclick="javascript:VerCupo();" value='Cupo de la Habitación'>
		<input type='hidden' name='id' value='<%=laid%>'>
		</td></tr>		
		<tr><td colspan="5" height='5'></td></tr>		
	</table>
	
	  </td>
		<td>&nbsp;</td>
    </tr>

	<tr><td background="img/corners/i.gif">&nbsp;</td>
	<td align='center'>
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
      <tr>
        <td align='center' valign='top'>
		  <!-- precios habitacion -->
		  <iframe frameborder="0" hspace="0" vspace="0" src="PreciosHabitacion.asp?id=<%=laid%>&est=<%=est%>" width="400" height="200" style="overflow:hidden"></iframe>
		</td>
		<td align='center' valign="top">
			<%'TABLA DE DTOS POR COLECTIVOS%>
			<iframe frameborder="0" hspace="0" vspace="0" src="DtosHabitacion.asp?id=<%=laid%>&est=<%=est%>" width="500" height="200" style="overflow:hidden"></iframe>
		</td>
		</tr>		
	</table>


<!-- SEGUNDA LINEA DESGLOSE -->
<table width='100%' border='0' cellspacing="2">
<tr id='linea2'>
	<td align='center' valign='top' bgcolor="#FFDCB9">
	<div style='width:460px; height:180px; overflow:auto;'>
	<iframe frameborder="0" hspace="0" vspace="0" src=""></iframe>
	</div>
	<%'TABLA DE SUPLEMENTOS POR TEMPORADA%>	
</td>

<td align='center' valign="top" bgcolor="#FFDCB9">
	<%'TABLA DE DTOS POR SUPLEMENTOS%>
	<div  id='lineasdtos' style='width:430px; height:180px; overflow:auto;'>
	<iframe frameborder="0" hspace="0" vspace="0" src=""></iframe>
	</div>
</td>
</tr>
<tr><td align='center' colspan="2">
	<input name='cierre' type="button" value="Cerrar Ventana" onClick="javascript:Cerrar();" style='cursor:pointer'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name='paron' type="button" value="Cupo de la Habitación" onClick="javascript:VerCupo();" style='cursor:pointer'>
</td></tr>
</table>

	  </td></tr>
</table>


</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
	document.f1.nombre_es.focus();
</script>
</body>
</html>
