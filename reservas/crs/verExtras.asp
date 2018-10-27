<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
%>
<!--#include file="actuExtras.asp"-->

<%

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Extras "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		fini=rs("FInicio")
		ffin=rs("FFinal")
		extra_es=rs("extra_es")
		extra_it=rs("extra_it")
		extra_en=rs("extra_en")
		extra_de=rs("extra_de")
		extra_fr=rs("extra_fr")
		importe=rs("importe")
		colectivo=rs("colectivo")
		descuento=rs("descuento")
		porpersona=rs("porpersona")
		tiposuple=rs("tiposuple")
		tipohabi=rs("tipohabi")
	end if
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
		parent.location="Extras.asp?p=<%=pag%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&est=<%=est%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&est=<%=est%>";

	document.f1.submit();
}
function cerrar(){
	encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';
}
</script>

<body class="laFicha">
<div class="tituloFicha" onmousedown="pulsada(top.document.getElementById('verFicha'))" onmouseup="javascript:top.liberaCapa();" onDblClick="javascript:cambiaForma();">
	<div class="nombreFicha">EXTRA</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
      <tr>
        <td align='right'>Desde d&iacute;a</td>
        <td align='left'>
          <input type='text' name="fechainicio" value='<%=fini%>' maxlength="10" size='8'>
&nbsp;&nbsp; Hasta d&iacute;a
      <input type='text' name="fechafinal" value='<%=ffin%>' maxlength="10" size='8'>
      (d&iacute;a/mes/a&ntilde;o) </td>
      </tr>
      <tr>
        <td align='right'>Concepto Esp.</td>
        <td align='left'><input type='text' size='50' maxlength='100' name='extra_es' value='<%=extra_es%>'></td>
      </tr>
      <tr>
        <td align='right'>Concepto Ita.</td>
        <td align='left'><input type='text' size='50' maxlength='100' name='extra_it' value='<%=extra_it%>'></td>
      </tr>
      <tr>
        <td align='right'>Concepto Ing.</td>
        <td align='left'><input type='text' size='50' maxlength='100' name='extra_en' value='<%=extra_en%>'></td>
      </tr>
      <tr>
        <td align='right'>Concepto Ale.</td>
        <td align='left'><input type='text' size='50' maxlength='100' name='extra_de' value='<%=extra_de%>'></td>
      </tr>
      <tr>
        <td align='right'>Concepto Fra.</td>
        <td align='left'><input type='text' size='50' maxlength='100' name='extra_fr' value='<%=extra_fr%>'></td>
      </tr>
      <tr>
        <td align='right'>Importe</td>
        <td align='left'><input type='text' size='5' maxlength='8' name='importe' value='<%=importe%>'></td>
      </tr>
      <tr>
        <td align='right'>Por persona</td>
        <td align='left'><input type='checkbox' name='porpersona' value='1'<%if porpersona then response.write " checked"%>></td>
      </tr>
	  <tr><td></td>
	  	<td align="left"><b>Aplica Extra si marca estos suplementos</b></td>
	  </tr>
	  <tr>
        <td align='right'>Suplementos:</td>
        <td align='left' valign="top">
		<%if haysuples then
			for ss=0 to ubound(RegSuples,2)%>
			<input name='tiposuple' type="checkbox" value="<%=RegSuples(SCodi,ss)%>"<%if instr(tiposuple,RegSuples(SCodi,ss))<>0 then response.write " checked"%>>
			<%=RegSuples(SNombre,ss)%>
			<%
			latempo=" (cualquiera)"
			if haytempos then
				for t=0 to ubound(RegTempos,2)
					if RegTempos(TCodi,t)=RegSuples(STempo,ss) then
						latempo=" (" & verFecha(RegTempos(TFIni,t)) & "-" & verFecha(RegTempos(TFFin,t)) & ")"
						exit for
					end if
				next
			end if
			response.write latempo
			%>								
			<br />
			<%next
		end if%>
		</td>
      </tr>
	  <tr><td></td>
	  	<td align="left"><b>Aplica Extra según estas habitaciones</b></td>
	  </tr>
	  <tr>
        <td align='right'>Habitaciones:</td>
        <td align='left' valign="top">
		<%if hayhabis then
			for ss=0 to ubound(RegHabis,2)%>
			<input name='tipohabi' type="checkbox" value="<%=RegHabis(HCodi,ss)%>"<%if instr(tipohabi,RegHabis(HCodi,ss))<>0 then response.write " checked"%>><%=RegHabis(HNombre,ss)%><br />
			<%next
		end if%>
		</td>
      </tr>
      <tr>
        <td align='right'></td>
        <td align='left'><b>Descuentos</b></td>
      </tr>
	  <tr>
        <td align='right'>Se aplica a</td>
        <td align='left'>
		<select name="colectivo">
		<option value="0">No se aplica descuento</option>
		<%if haycolec then
			for c=0 to ubound(RegColec,2)
				marca=""
				if colectivo=RegColec(CCodi,c) then marca=" selected"%>
				<option value="<%=RegColec(CCodi,c)%>"<%=marca%>><%=RegColec(CNombre,c)%></option>
			<%next
		end if%>
		</select>
		</td>
      </tr>
	  <tr>
        <td align='right'>Dto:</td>
        <td align='left'><input type='text' size='5' maxlength='8' name='descuento' value='<%=descuento%>'></td>
      </tr>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" type='button' class="boton86" id='boton' style='cursor:hand' onclick="javascript:Modificar();" value='Actualizar'>
          <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></table>

	</td>
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