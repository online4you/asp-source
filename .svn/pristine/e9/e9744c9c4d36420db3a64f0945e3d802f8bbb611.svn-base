<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

dim TIdiomas() 'titulo traduccion
dim TexIdiomas() 'texto traduccion

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))

%><!--#include file="actuServicio.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
redim TexIdiomas(ubound(ListaIdiomas))

laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT ServiciosExtras.*,Idioma,Traduccion,Campo "
	cs=cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON ServiciosExtras.Id=Traducciones.IdReferencia AND Tabla='ServiciosExtras' "	
	cs=cs & "WHERE ServiciosExtras.id=" & laid
	'response.Write(cs & "<br>")
	rs.open cs,base
	do while not rs.eof
		url=rs("url")
		nombre=rs("nombre")
		texto=rs("texto")
		codigoesta=rs("codigoesta")
		activo=rs("activo")
		orden=rs("orden")
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=rs("idioma") then 'este
				if rs("campo")="Nombre" then TIdiomas(idi)=rs("traduccion") 'titulos
				if rs("campo")="Texto" then TexIdiomas(idi)=rs("traduccion") 'texto
			end if
		next 'idi
		TIdiomas(0)=nombre 'langPorDefecto
		TexIdiomas(0)=Texto 'langPorDefecto
		rs.movenext
	loop
	rs.close

else
	codigoesta=est
	activo=true
	orden=0
end if

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
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

'calcula ancho del textarea
maxAncho=980 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>2 then 'hay mas de cuatro y sólo pongo 4 idiomas por fila
	anchoColu=paClng(anchoDispo/4)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if

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
<%if IdAlta<>0 then%>
	//abrir la ficha desde el padre y cierra esta
	recargaFrame('<%=recarga%>');
	top.<%=recarga%>.verFicha(<%=IdAlta%>);
	cerrar();
<%end if%>
<%if pasalir=1 and paClng(IdAlta)=0 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&p=<%=pag%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&p=<%=pag%>&recarga=<%=recarga%>";

	document.f1.submit();
}

function cambiaSolapa(esa){
	//Poner todas a normal
	for (x=1;x<=2;x++){
		document.getElementById("sola"+x).className='laSolapa2';
		document.getElementById("frame"+x).style.visibility='hidden';
		document.getElementById("frame"+x).style.zIndex=5;
	}
	//Activa
	document.getElementById("sola"+esa).className='laSolapaOver2';
	document.getElementById("frame"+esa).style.visibility='visible';
	document.getElementById("frame"+esa).style.zIndex=10;
}

function cargaTexto(campo,valor){
	document.getElementById('capa'+campo).innerHTML=valor;
	document.getElementById(campo).value=valor;
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_servicio"))%> -> <%=TIdiomas(0)%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px">
  <tr>
    <td class="tdTabla">

	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
    <tr>
    <%
	colu=1
	maxColu=4
	if (ubound(listaIdiomas)+1)<maxColu then maxColu=ubound(listaIdiomas)+1
	for idi=0 to ubound(listaIdiomas)%>
		<td align='left'>
        <%=objIdioma.getTraduccionHTML("i_titulo_" & listaIdiomas(idi))%>:<br/>
        <input type="text" maxlength="100" style="width:<%=anchoColu%>px" value='<%=TIdiomas(Idi)%>' name="nombre_<%=listaIdiomas(idi)%>">
        </td>
        <%colu=colu+1
		if colu>maxColu then
			response.write "</tr><tr>"
			colu=1
		end if
    next 'idi%>
    </tr>
	<tr>
    <%
	colu=1
	'maxColu=4
	for idi=0 to ubound(listaIdiomas)%>
		<td align='left'>
		<%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_<%=listaIdiomas(idi)%>',680,450);"><br/>        
		<textarea name="texto_<%=listaIdiomas(idi)%>" id='texto_<%=listaIdiomas(idi)%>' style="width:<%=anchoColu%>px; height:60px;"><%=TexIdiomas(Idi)%></textarea>
        </td>
        <%colu=colu+1
		if colu>maxColu then
			response.write "</tr><tr>"
			colu=1
		end if
    next 'idi%>
    </tr>

		<tr>
		  <td align='left' colspan='<%=maxColu%>'>URL de informaci&oacute;n del Servicio 
		  <input type='text' size='50' maxlength="75" name='url' value='<%=url%>'>&nbsp;
		  (si se deja en blanco no saldr&aacute; el enlace)
		  </td>
		</tr>
		<tr><td colspan="<%=maxColu%>" align='left'>Hotel: 
			<select name='codigoesta'>
			<option value="0"><%=objIdioma.getTraduccionHTML("i_todosloshoteles")%></option>
			<%if hayHoteles then
			for h=0 to ubound(RegHoteles,2)
				marca=""
				if RegHoteles(HCodi,h)=codigoesta then marca=" selected"%>
				<option value='<%=RegHoteles(HCodi,h)%>'<%=marca%>><%=RegHoteles(HNombre,h)%></option>
			<%next
			end if%>
		</select>
		</td></tr>
		<tr>
		  <td align='left' colspan='<%=maxColu%>'>
		  <%=objIdioma.getTraduccionHTML("i_ordenvisual")%> <input type="text" style="width:30px" value="<%=orden%>" name="orden">
		  </td>
		</tr>
		<tr>
		  <td align='left' colspan='<%=maxColu%>'>
		  <%=objIdioma.getTraduccionHTML("i_activo")%> <input type="checkbox" value="1" name="activo"<%if activo then response.write " checked"%>>
		  </td>
		</tr>
        <tr>
        <td align='center' colspan='<%=maxColu%>'>
          <input name="boton" class='boton86' type='button' id='boton' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>'>
          <input type='hidden' name='id' value='<%=laid%>'>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>"></td>
      </tr>
      <%if laid<>0 then 'visualizar los precios %>
	  <tr><td colspan="<%=maxColu%>" align="left">

	  <div style="position:relative; height:22px; width:auto; margin-top:5px;"> 
	  	  		<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="precioServicio.asp?ids=<%=laid%>&est=<%=codigoesta%>" class="elFrame" style="height:240px; width:930px" scrolling="no"></iframe>

                <div id='solapas' style="visibility: hidden"> 
                  <div id='sola1' class="laSolapa2" onClick="javascript:cambiaSolapa(1);" style="margin-left:0px"><%=objIdioma.getTraduccionHTML("i_precios")%></div>
                  <div id='sola2' class="laSolapa2" onClick="javascript:cambiaSolapa(2);"><%=objIdioma.getTraduccionHTML("i_fotos")%></div>
                </div>
                <div id='lineaSolapa3' style="width:708px;"></div>
              </div>		
	<div id='zonaFrames' style="height:280px;"> 
		<iframe id='frame1' name='frame1' frameborder="0" hspace="0" vspace="0" src="precioServicio.asp?ids=<%=laid%>&est=<%=codigoesta%>" class="elFrame" style="height:240px; width:930px" scrolling="no"></iframe>
		<iframe id='frame2' name='frame2' frameborder="0" hspace="0" vspace="0" src="fotosServicio.asp?ids=<%=laid%>&est=<%=codigoesta%>" class="elFrame" style="height:240px; width:930px;" scrolling="no"></iframe>
	</div>
	  </td></tr>
      <%end if 'laid %>
    </table>
	</td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%else%>
		cambiaSolapa(1);
	<%end if%>
	document.f1.nombre_es.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>