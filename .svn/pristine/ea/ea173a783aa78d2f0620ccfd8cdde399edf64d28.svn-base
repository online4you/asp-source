<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
laid=clng("0" & request.QueryString("id"))
%>
<!--#include file="actuAlojamiento.asp"-->
<%
cs="SELECT id,Zona_es FROM " & precrs & "Zonas"
rs.open cs,base
hayNucleos=false
if not rs.eof then
	RegNucleos=rs.getrows
	Nid=0
	NNombre=1
	hayNucleos=true
end if
rs.close


'Buscar Tipos Alojamientos
cs="SELECT id,nombre_es,IdTipo FROM " & precrs & "TipoAlojamiento"
rs.open cs,base
haytipos=false
if not rs.eof then
	RegTipos=rs.getrows
	TId=0
	TNombre=1
	TTipo=2
	haytipos=true
end if
rs.close

'Buscar categorias
cs="SELECT id,nombre_es,IdTipo FROM " & precrs & "Categorias"
rs.open cs,base
haycate=false
if not rs.eof then
	RegCate=rs.getrows
	CId=0
	CNombre=1
	CTipo=2
	haycate=true
end if
rs.close
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
		parent.location="Alojamientos.asp?p=<%=pag%>";
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
function actiBlanco(){
	document.getElementById('texto_es').value="";
	document.getElementById('texto_it').value="";
	document.getElementById('texto_en').value="";
	document.getElementById('texto_de').value="";
	document.getElementById('texto_fr').value="";
	document.getElementById('productos').style.visibility='visible';
}
</script>

<body class="laFicha">
<div class="tituloFicha" onmousedown="pulsada(top.document.getElementById('verFicha'))" onmouseup="javascript:top.liberaCapa();" onDblClick="javascript:cambiaForma();">
	<div class="nombreFicha">NUEVO ALOJAMIENTO</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	<table width='500' border='0' cellspacing='0'>
      <tr>
        <td align='right'>Alojamiento:</td>
        <td align='left'>
          <input type="text" name='nombre' value="<%=nombre%>" size='50' maxlength='75'>
		  <input type="hidden" name='pagina' value="<%=pagina%>" size='25' maxlength='25'></td>
      </tr>
	  <!--
      <tr>
        <td align='right'>Nombre Página:</td>
        <td align='left'>
          <input type="hidden" name='pagina' value="<%'=pagina%>" size='25' maxlength='25'>
		  &nbsp;* Nombre de la página web del hotel</td>
      </tr>-->
      <tr>
	  <tr><td align='right'>Tipo Alojamiento:</td>
	  	<td align='left'>
			<select name='tipohotel'>
				<%if haytipos then
					for t=0 to ubound(RegTipos,2)%>
						<option value='<%=RegTipos(TId,t)%>'><%=RegTipos(TNombre,t)%></option>
					<%next
				end if%>
			</select>
		</td>
	  </tr>
	  <tr><td align='right'>Categoria:</td>
	  	<td align='left'>
			<select name='categoria'>
				<option value='0'>No tiene</option>
				<%if haycate then
					for c=0 to ubound(RegCate,2)%>
						<option value='<%=RegCate(CId,c)%>'><%=RegCate(CNombre,c)%></option>
					<%next
				end if%>
			</select>
		</td>
	  </tr>
	  <tr><td align='right'>Cadena:</td>
		<td align='left'>
			<select name='proveedor' id='proveedor'>
				<option value=''>Vincular a cadena</option>
				<%if haypro then
					for p=0 to ubound(Regpro,2)%>
						<option value='<%=Regpro(pId,p)%>'><%=Regpro(pNombre,p)%></option>
					<%next
				end if%>
			</select>
		</td>
	  </tr>
      <tr>
        <td align='right'>EMail:</td>
        <td align='left'>
          <input type="text" name='email' value="<%=email%>" size='50' maxlength='75'></td>
      </tr>
      <tr  >
        <td align='right'>Direcci&oacute;n:</td>
        <td align='left'>
          <input type="text" name='direccion' value="<%=dire%>" size='50' maxlength='50'></td>
      </tr>
      <tr  >
        <td align='right'>CP:</td>
        <td align='left'>
          <input type="text" name='cp' value="<%=cp%>" size='6' maxlength='5'></td>
      </tr>
      <tr  >
        <td align='right'>Poblaci&oacute;n:</td>
        <td align='left'>
          <input type="text" name='poblacion' value="<%=pobla%>" size='50' maxlength='50'></td>
      </tr>
      <tr  >
        <td align='right'>Tel&eacute;fono:</td>
        <td align='left'>
          <input type="text" name='telefono' value="<%=tele%>" size='25' maxlength='25'></td>
      </tr>
      <tr  >
        <td align='right'>Fax:</td>
        <td align='left'>
          <input type="text" name='fax' value="<%=fax%>" size='25' maxlength='25'></td>
      </tr>
      <tr  >
        <td align='right'>Web:</td>
        <td align='left'>
          <input type="text" name='web' value="<%=web%>" size='25' maxlength='50'></td>
      </tr>
      <tr>
        <td align='right'>Zona:</td>
        <td align='left'>
          <select name='zona'>
          <%if hayNucleos then
            for z=0 to ubound(RegNucleos,2)%>
            <option value='<%=RegNucleos( NId,z)%>' <%=marca%>><%=RegNucleos(NNombre,z)%></option>
            <%next
		end if%>
          </select>
        </td>
      </tr>
      <tr>
        <td align='right'>&nbsp;Orden de visual.:</td>
		<td align='left'>
            <select name='orden'>
              <%for t=0 to 20%>
              <option value='<%=t%>'><%=t%></option>
              <%next%>
            </select>
            <input type="hidden" name='aviso' value="0"></td>
      </tr>
      <tr>
        <td align='right'>&nbsp;Dias Anulación:</td>
		<td align='left'>
            <input type="text" name='diasanul' value="<%=diasanul%>" size='2' maxlength="6"></td>
      </tr>
      <tr>
        <td align='right'>&nbsp;% Prepago:</td>
		<td align='left'>
     	<input type="text" name="prepago" value="<%=prepago%>" size='2' maxlength="6">
      % &nbsp;&nbsp;&nbsp; Noches m&iacute;nimas:
      <input type="text" name="diasmin" value="<%=diasmin%>" size='2' maxlength="5">
        </td>
      </tr>
      <tr>
        <td align='right'>&nbsp;Estado Hotel:</td>
		<td align='left'>
			<select name='estado'>
			<option value='0'>No Venta</option>
			<option value='1' selected>On Request</option>
			<option value='2'>On-Line</option>
			</select>
		  </td>
      </tr>
      <tr>
        <td align='right'>Observaciones:</td>
		<td align='left'>
            <textarea style="width:300px; height:40px;" name='obs'></textarea>
		</td>
      </tr>
	  <tr>
        <td align='right'>Comentarios:</td>
		<td align='left'>
            <textarea style="width:300px; height:60px;" name='obs2'></textarea>
		</td>
      </tr>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" type='button' class="boton86" id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='Añadir'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="hidden" name="id" value="<%=laid%>">
      <input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
        </td>
      </tr>
    </table></td></tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='Añadir';
	<%end if%>
</script>
</body>
</html>