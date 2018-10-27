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
laid=paClng(request.QueryString("id"))

%>
<!--#include file="actuAlojamiento.asp"-->
<%

hayNucleos=true
set claseZona=new clsListadoZonas
RegNucleos=claseZona.cargaListaZonas(0,0,lang) '(idpadre,nivel,idioma)
set claseZona=nothing
if isnull(RegNucleos) then hayNucleos=false
ZCodi=0
ZNombre=1
ZIdPadre=2
ZNivel=3


'Buscar Tipos Alojamientos
'cs="SELECT Id,IdTipo,ISNULL(dbo.fnGetTraduccion('TipoAlojamiento','Nombre',Id,'" & lang & "'),Nombre) AS Tradu "
'cs=cs & "FROM " & precrs & "TipoAlojamiento"

cs="SELECT TipoAlojamiento.Id,TipoAlojamiento.IdTipo, "
cs=cs & "IF(ISNULL(traduc.Traduccion),TipoAlojamiento.Nombre,traduc.Traduccion) AS Tradu  "
cs=cs & "FROM " & precrs & "TipoAlojamiento TipoAlojamiento "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TipoAlojamiento"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TipoAlojamiento.Id = traduc.IdReferencia  "

'response.write(cs)
rs.open cs,base
haytipos=false
if not rs.eof then
	RegTipos=rs.getrows
	TId=0
	TTipo=1
	TTradu=2
	haytipos=true
end if
rs.close

'Buscar categorias
cs="SELECT Id,IdTipo,IF(ISNULL(traduc.Traduccion),Categorias.Nombre,traduc.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "Categorias Categorias "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Categorias"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON Categorias.Id = traduc.IdReferencia  "

rs.open cs,base
haycate=false
if not rs.eof then
	RegCate=rs.getrows
	CId=0
	CTipo=1
	CTradu=2
	haycate=true
end if
rs.close

'Buscar tipos moneda
cs="SELECT TiposMoneda.Id,TiposMoneda.CodigoISO,TiposMoneda.PorDefecto,"
cs=cs & "IF(ISNULL(traduc.Traduccion),TiposMoneda.Nombre,traduc.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "TiposMoneda TiposMoneda "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TiposMoneda"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TiposMoneda.Id = traduc.IdReferencia  "
cs=cs & " ORDER BY Orden"

hayMonedas=false
rs.open cs,base
if not rs.eof then
	RegMonedas=rs.getrows
	RMId=0
	RMISO=1
	RMDefecto=2
	RMTradu=3
	hayMonedas=true
end if
rs.close

if laid<>0 then
	cs="SELECT Nombre,Email,Direccion,cp,Poblacion,Telefono,Fax,Aviso,Zona,URL,Estado,"
	cs=cs & "orde,Porciento,MinDias,DiasAnulacion,TipoAlojamiento,Categoria,Obs,URL,Moneda,Foto,desde, porHabPer "
	cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel "
	cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta "
	cs=cs & "WHERE Establecimientos.CodigoEsta=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		email=rs("email")
		dire=rs("direccion")
		cp=rs("cp")
		pobla=rs("poblacion")
		tele=rs("telefono")
		fax=rs("fax")
		aviso=rs("aviso")
		zona=rs("zona")
		estado=rs("estado")
		url=rs("url")
		orden=rs("orde")
		prepago=rs("porciento")
		desde=rs("desde")
		porHabPer=rs("porHabPer")
		diasmin=rs("mindias")
		tipoh=rs("tipoalojamiento")
		categoria=rs("categoria")
		diasanul=rs("diasanulacion")
		obs=rs("obs")
		url=rs("url")
		moneda=paClng(rs("moneda"))
		foto=rs("foto")
	end if
	rs.close

else 'añadir
	'buscar moneda por defecto
	if hayMonedas then
	for m=0 to ubound(RegMonedas,2)
		if RegMonedas(RMDefecto,m) then
			moneda=RegMonedas(RMId,m)
			exit for
		end if
	next
	end if
end if

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner el iframe flotante a cerrar
	top.quitaFlota(self.name);
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>";
	document.getElementById('est').value="<%=est%>";
	document.getElementById('recarga').value="<%=recarga%>";
	if (document.f1.id.value=="0"){
		document.getElementById('modo').value="nuevo";}
	else{
		document.getElementById('modo').value="actu";}


	document.f1.submit();
}

function verTextoHotel(id){
	top.creaFlotante("verCondicionesHotel.asp?est="+id,950,280,0,0);
}

function verFPagoHotel(id){
	top.creaFlotante("verFPagoHotel.asp?idh="+id,480,220,0,0);
}

function Subir(esa){
	eval("document.f1.lafoto_"+esa+".src=document.f1.foto_"+esa+".value");
}

function quitaFoto(esa){
	document.f1.action="<%=MiPag%>?idh=<%=laid%>&qf="+esa;
	document.f1.submit();
}

function Subiendo(){
	document.getElementById('boton_0').value='Subiendo Foto';
	document.getElementById('boton_0').style.visibility='hidden';
	reloj=setTimeout('parpadeo()',100);
}
var texto=true;
function parpadeo(){
	if (texto)
		document.getElementById('boton_0').style.visibility='visible';
	else
		document.getElementById('boton_0').style.visibility='hidden';
	
	texto=!(texto);
	reloj=setTimeout('parpadeo()',600);
}
</script>
</head>
<body class="laFicha">
<div id='tituloFicha' class="tituloFicha">
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_alojamiento"))%> -> <%=nombre%></div>
	<div id='laX' class="laX"></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="18" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="get" enctype="multipart/form-data">
		<input type="hidden" name="modo" id="modo">
		<input type="hidden" name="est" id="est">
		<input type="hidden" name="recarga" id="recarga">

<table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
  <tr>
    <td bgcolor="#FFFFFF" align="left">
	<table width='415' border='0' cellspacing='0' align="left">
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_alojamiento")%>:</td>
        <td align='left'>
          <input disabled="true" type="text" name='nombreDisabled' value="<%=nombre%>" size='50' maxlength='75'></td>
          <input  type="hidden" name='nombre' value="<%=nombre%>">
      </tr>
      <tr>
	  <tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tipoaloja")%>:</td>
	  	<td align='left'>
			<select name='tipohotel'>
				<%if haytipos then
					for t=0 to ubound(RegTipos,2)
						marca=""
						if RegTipos(TId,t)=tipoH then marca=" selected"%>
						<option value='<%=RegTipos(TId,t)%>'<%=marca%>><%=RegTipos(TTradu,t)%></option>
					<%next
				end if%>
			</select>
		</td>
	  </tr>
	  <tr><td align='right'><%=objIdioma.getTraduccionHTML("i_categoria")%>:</td>
	  	<td align='left'>
			<select name='categoria'>
				<option value='0'>No tiene</option>
				<%if haycate then
					for c=0 to ubound(RegCate,2)
					marca=""
					if RegCate(CId,c)=categoria then marca=" selected"%>
						<option value='<%=RegCate(CId,c)%>'<%=marca%>><%=RegCate(CTradu,c)%></option>
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
        <td align='right'><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
        <td align='left'>
          <input type="text" name='direccion' value="<%=dire%>" size='50' maxlength='50'></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_cp")%>:</td>
        <td align='left'>
          <input type="text" name='cp' value="<%=cp%>" size='6' maxlength='5'></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_poblacion")%>:</td>
        <td align='left'>
          <input type="text" name='poblacion' value="<%=pobla%>" size='50' maxlength='50'></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_telefono")%>:</td>
        <td align='left'>
          <input type="text" name='telefono' value="<%=tele%>" size='25' maxlength='25'></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_fax")%>:</td>
        <td align='left'>
          <input type="text" name='fax' value="<%=fax%>" size='25' maxlength='25'></td>
      </tr>
      <tr>
        <td align='right'>Web:</td>
        <td align='left'>
          <input type="text" name='web' value="<%=url%>" size='25' maxlength='100'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_moneda")%>:</td>
        <td align='left'>
			<select name="moneda">
			<%if hayMonedas then
			for m=0 to ubound(RegMonedas,2)
			marca=""
			if moneda=RegMonedas(RMId,m) then marca=" selected"%>
			<option value="<%=RegMonedas(RMId,m)%>"<%=marca%>><%=RegMonedas(RMISO,m) & " - " & RegMonedas(RMTradu,m)%></option>
			<%next
			end if 'haymonedas%>
			</select>
		</td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_zona")%>:</td>
        <td align='left'>
          <select name='zona'>
          <%
			if hayNucleos then
			for z=0 to ubound(RegNucleos,2)
				marca=""
				tabZona="padding-left:" & (10*RegNucleos(ZNivel,z)+3) & "px"
				laZona=RegNucleos(ZNombre,z)
				if RegNucleos(ZNivel,z)>0 then laZona="- " & laZona
				if RegNucleos(ZCodi,z)=zona then marca=" selected"%>
				<option style="<%=tabZona%>" value="<%=RegNucleos(ZCodi,z)%>"<%=marca%>><%=laZona%></option>  
			<%next
			end if 'zonas %>
          </select>
        </td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_ordenvisual")%>:</td>
		<td align='left'>
            <select name='orden'>
              <%for t=0 to 20
			  marca=""
			  if t=orden then marca=" selected"%>
              <option value='<%=t%>'<%=marca%>><%=t%></option>
              <%next%>
            </select>
            <input type="hidden" name='aviso' value="0"></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_diasanula")%>:</td>
		<td align='left'>
            <input type="text" name='diasanul' value="<%=diasanul%>" size='2' maxlength="6"></td>
      </tr>
      <tr>
        <td align='right'>% <%=objIdioma.getTraduccionHTML("i_prepago")%>:</td>
		<td align='left'>
     	<input type="text" name="prepago" value="<%=prepago%>" size='2' maxlength="6">
        </td>
      </tr>
	         <tr>
        <td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_desde")%>:</td>
		<td align='left'>
			<input type="text" name="desde" value="<%=desde%>" size='2' maxlength="6">
		  </td>
      </tr>

	    <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_tipocalculo")%>:</td>
		<td align='left'>
            <select name='porHabPer'>
              
              <option value='0'<%if porHabPer=0 then response.write "selected" %>>Por Persona</option>
			  <option value='1'<%if porHabPer=1 then response.write "selected" %>>Por Habitacion</option>
            </select>
            </td>
      </tr>
  
	  
	  
      <tr>
        <td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_estadohotel")%>:</td>
		<td align='left'>
			<select name='estado'>
			<option value='<%=noventa%>'<%if estado=noventa then response.write " selected"%>>No Venta</option>
			<option value='<%=onrequest%>'<%if estado=onrequest then response.write " selected"%>>On Request</option>
			<option value='<%=online%>'<%if estado=online then response.write " selected"%>>On-Line</option>
			</select>
            <br/>
			<input name="ssboton" type='button' class="boton145" onclick="javascript:verTextoHotel(<%=laid%>);" value='<%=objIdioma.getTraduccionHTML("i_condicioneshotel")%>' style="margin-bottom:0px;">
            <%if esAdmin then%>
			&nbsp;&nbsp;&nbsp;
			<input name="ssbotor" type='button' class="boton86" onclick="javascript:verFPagoHotel(<%=laid%>);" value='<%=objIdioma.getTraduccionHTML("i_formapago")%>' style="margin-bottom:0px;">
            <%end if%>
		  </td>
      </tr>

      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_observaciones")%>:</td>
		<td align='left'>
            <textarea style="width:300px; height:40px;" name='obs'><%=obs%></textarea>
		</td>
      </tr>
    </table>
	</td>
	<td valign="top" align="left">
		&nbsp;
	</td></tr>
	<tr><td colspan="2" height='10'></td></tr>
	<tr><td colspan="2" align="center">
		<input name="boton" type='button' class="boton86" id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccion("i_anadir")%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="hidden" name="id" value="<%=laid%>">
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>">
	</td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid<>0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccionHTML("i_modificar")%>';
	<%end if%>
	document.f1.nombre.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>