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

laid=paClng(request.QueryString("idh"))
recarga=request.QueryString("recarga") 'pagina del padre

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
'cs=cs & "FROM TipoAlojamiento"
cs="SELECT Id,IdTipo,IF(ISNULL(traduc.Traduccion),Nombre,traduc.Traduccion)  AS Tradu "
cs=cs & " FROM " & precrs & "TipoAlojamiento TipoAlojamiento  LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TipoAlojamiento"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TipoAlojamiento.Id = traduc.IdReferencia "

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
'cs="SELECT Id,IdTipo,ISNULL(dbo.fnGetTraduccion('Categorias','Nombre',Id,'" & lang & "'),Nombre) AS Tradu "
'cs=cs & "FROM Categorias"

cs="SELECT Id,IdTipo,IF(ISNULL(traduc.Traduccion),Nombre,traduc.Traduccion)  AS Tradu "
cs=cs & " FROM " & precrs & "Categorias Categorias  LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Categorias"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON Categorias.Id = traduc.IdReferencia "

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
'cs="SELECT Id,CodigoISO,PorDefecto,"
'cs=cs & "ISNULL(dbo.fnGetTraduccion('TiposMoneda','Nombre',Id,'" & lang & "'),Nombre) AS Tradu "
'cs=cs & "FROM TiposMoneda ORDER BY Orden"

cs="SELECT Id,CodigoISO,PorDefecto, IF(ISNULL(traduc.Traduccion),Nombre,traduc.Traduccion)  AS Tradu "
cs=cs & " FROM " & precrs & "TiposMoneda TiposMoneda  LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TiposMoneda"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TiposMoneda.Id = traduc.IdReferencia ORDER BY Orden"
'response.Write(cs)

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
	cs=cs & "orde,Porciento,MinDias,DiasAnulacion,TipoAlojamiento,Categoria,Obs,URL,Moneda,Foto,Visitas "
	cs=cs & "FROM " & precrs & "Establecimientos Establecimientos LEFT JOIN " & precrs & "DatosHotel DatosHotel "
	cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta "
	cs=cs & "WHERE Establecimientos.CodigoEsta=" & laid
	'response.Write(cs & "<br>")
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
		diasmin=rs("mindias")
		tipoh=rs("tipoalojamiento")
		categoria=rs("categoria")
		diasanul=rs("diasanulacion")
		obs=rs("obs")
		url=rs("url")
		moneda=paClng(rs("moneda"))
		foto=rs("foto")
		visitas=rs("visitas")
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
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.cerrar();
}

<%if modo="nuevo" and con_cms then 'recarga padre y vuelve a cargar ficha nueva %>
	url=top.<%=recarga%>.location;
	top.<%=recarga%>.location=url;
	top.<%=recarga%>.verFicha(<%=codigoesta%>);
	cerrar();
<%end if
if pasalir=1 then%>
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>
function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else {
		//activar los select si estan desactivados
		<%if desactivo=" disabled" then %>
		var listas=$$('select');
		for(x=0;x<listas.length;x++){
			listas[x].disabled=false;
		}
		<%end if 'desactivo%>
		document.f1.action="<%=MiPag%>?modo=actu&idh=<%=laid%>&recarga=<%=recarga%>";
	}

	document.f1.submit();
}

function verTextoHotel(id){
	top.creaFlotante("verCondicionesHotel.asp?idh="+id,970,350,0,0);
}

function verFPagoHotel(id){
	top.creaFlotante("verFPagoHotel.asp?idh="+id,480,220,0,0);
}

function quitaFoto(esa){
	document.f1.action="<%=MiPag%>?id=<%=laid%>&qf="+esa;
	document.f1.submit();
}
</script>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="POST" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
  <tr>
    <td class="tdTabla" align="left">
	<table width='550' border='0' cellspacing='0' align="left">
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_alojamiento")%>:</td>
        <td align='left'>
          <input type="text" name='nombre' value="<%=nombre%>" size='50' maxlength='75'<%=sololeer%>></td>
      </tr>
      <tr>
	  <tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tipoaloja")%>:</td>
	  	<td align='left'>
			<select name='tipohotel'<%=desactivo%>>
            	<option value='0'>No Seleccionado</option>
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
			<select name='categoria'<%=desactivo%>>
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
          <input type="text" name='email' value="<%=email%>" size='50' maxlength='75'<%=sololeer%>></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
        <td align='left'>
          <input type="text" name='direccion' value="<%=dire%>" size='50' maxlength='50'<%=sololeer%>></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_cp")%>:</td>
        <td align='left'>
          <input type="text" name='cp' value="<%=cp%>" size='6' maxlength='5'<%=sololeer%>></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_poblacion")%>:</td>
        <td align='left'>
          <input type="text" name='poblacion' value="<%=pobla%>" size='50' maxlength='50'<%=sololeer%>></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_telefono")%>:</td>
        <td align='left'>
          <input type="text" name='telefono' value="<%=tele%>" size='25' maxlength='25'<%=sololeer%>></td>
      </tr>
      <tr  >
        <td align='right'><%=objIdioma.getTraduccionHTML("i_fax")%>:</td>
        <td align='left'>
          <input type="text" name='fax' value="<%=fax%>" size='25' maxlength='25'<%=sololeer%>></td>
      </tr>
      <tr>
        <td align='right'>Web:</td>
        <td align='left'>
          <input type="text" name='web' value="<%=url%>" size='25' maxlength='100'<%=sololeer%>></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_moneda")%>:</td>
        <td align='left'>
			<select name="moneda"<%=desactivo%>>
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
          <select name='zona'<%=desactivo%>>
          <%if hayNucleos then
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
            <select name='orden'<%=desactivo%>>
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
        <td align='right'><%=objIdioma.getTraduccionHTML("i_estadohotel")%>:</td>
		<td align='left'>
			<select name='estado'>
			<option value='<%=noventa%>'<%if estado=noventa then response.write " selected"%>>No Venta</option>
			<option value='<%=onrequest%>'<%if estado=onrequest then response.write " selected"%>>On Request</option>
			<option value='<%=online%>'<%if estado=online then response.write " selected"%>>On-Line</option>
			</select>
			&nbsp;&nbsp;
			<input name="ssboton" type='button' class="boton145" onclick="javascript:verTextoHotel(<%=laid%>);" value='<%=objIdioma.getTraduccionHTML("i_condicioneshotel")%>' style="margin-bottom:0px;">
            <%if esAdmin then%>
			&nbsp;
			<input name="ssbotor" type='button' class="boton86" onclick="javascript:verFPagoHotel(<%=laid%>);" value='<%=objIdioma.getTraduccionHTML("i_formapago")%>' style="margin-bottom:0px;">
            <%end if%>
		  </td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_observaciones")%>:</td>
		<td align='left'>
            <textarea style="width:300px; height:60px;" name='obs'><%=obs%></textarea>
		</td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_visitas")%>:</td>
		<td align='left'><b><%=visitas%></td>
      </tr>
    </table>
	</td>
	<td valign="top" align="left">
		<div style="margin-top:10px; margin-left:0px; width:350px; height:auto; border:1px solid #999999" align="center">
		<br/><%=objIdioma.getTraduccionHTML("i_fotoalojamiento")%><br/><br/>
		<%if foto<>"" then lafoto=rutaFotos & foto else lafoto="img/tr.gif"%>
		<img id='lafoto_0' border='1' src="<%=lafoto%>" style="max-width:230px;"/><br/>
		<br/>
		<input name='foto_0' type="file" size='35' style='width:200px; height:17px;<%if miNivel>=TComercial then response.write "display:none"%>'><br/>
		<br/>
		</div>
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