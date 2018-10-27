<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
dim TIdiomas() 'texto traduccion

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("id"))

%><!--#include file="actuHabitacion.asp"--><%
tipoH=0
redim TIdiomas(ubound(ListaIdiomas))
'Datos habitacion
cs="SELECT Orden,Nombre,TipoHabitacion,paraCapMin,ParaCapNormal,ParaCapMax,ParaAdultMax,ParaAdultMin,ParaNiMax,CunaOcupa,"
cs=cs & "Idioma,Traduccion " 
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabitaNombres' AND Campo='Nombre' WHERE TipoHabitaNombres.Id=" & laid
rs.open cs,base
do while not rs.eof
	orden=rs("orden")
	nombre_es=rs("nombre")
	tipoh=rs("tipohabitacion")
	capmin=rs("paracapmin")
	capnormal=rs("paracapnormal")
	capmax=rs("paracapmax")
	adultmax=rs("paraAdultMax")
	adultmin=rs("paraAdultMin")
	ninmax=rs("paraNiMax")
	cunaocupa=rs("cunaocupa")
	nombreHabi=nombre_es
	TIdiomas(0)=nombre_es
	for idi=1 to ubound(ListaIdiomas)
		if ListaIdiomas(idi)=lang then nombreHabi=rs("traduccion")
		if ListaIdiomas(idi)=rs("idioma") then 'este
			TIdiomas(idi)=rs("traduccion")
			exit for
		end if
	next 'idi
	
	rs.movenext
loop
rs.close


'Tabla de habitaciones estandar
cs="SELECT TipoHabita.Id,ISNULL(Traduccion,Nombre) AS Tradu "
cs=cs & "FROM " & precrs & "TipoHabita TipoHabita LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabita.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabita' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "ORDER BY Orden"
hayhabis=false
rs.open cs,base
if not rs.eof then
	RegTHabis=rs.getrows
	THId=0
	THNombre=1
	hayhabis=true
end if
rs.close

if multiTarifa then
	%><!--#include file="datosMultiTarifa.asp"--><%
end if 'multiTarifa

set rs=nothing
base.close
set base=nothing

'calcula ancho del nombre habitacion
maxAncho=860 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>3 then 'hay mas de cinco y sólo pongo 5 idiomas por fila
	anchoColu=paClng(anchoDispo/5)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<style type="text/css">
input {
	height:12px;
	font-size:11px;
}
</style>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.frames['elFrame<%=ff%>'].location="Habitaciones.asp";
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&est=<%=est%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&est=<%=est%>&recarga=<%=recarga%>";

	document.f1.submit();
}
function VerCupo(){
	//top.creaFlotante("cupos.asp?est=<%=est%>&hab=<%=laid%>",770,530,0,0);
	top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&mes=1&anyo=<%=anyo%>&tipoD=0&th=<%=laid%>&rm=12",1000,600,5,0);
}

function descripcionHabi(){
	top.creaFlotante("descripcionHabi.asp?idh=<%=laId%>&est=<%=est%>",1000,500,0,0);
}

function cambioTarifa(esa){
	//Guardar en cookie el anyo
	SetCookie("tarifa",esa.value,null,"/");
	//recarga la pagina
	window.location="<%=MiPag & "?" & request.QueryString()%>";
}
function ponerTipoH(esa){
	if (esa.value!='0') {
		url="cargaHabEstandar.asp?id="+esa.value;
		$("paProcesos").src=url;
	}
}
</script>
<body class="laFicha">
<iframe name="paProcesos" id="paProcesos" class="fichaIframe" src="vacio.html"></iframe>
<div class="tituloFicha" id='tituloFicha'>
<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_habitacion"))%> -> <%=nombreHabi%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">

	<table width='100%' border='0' cellspacing='0' style="margin-top:5px">
		<tr><td align='left'>
			<%=objIdioma.getTraduccionHTML("i_tipohab_estandar")%>:
			<select name='tipoh' onChange="ponerTipoH(this);">
				<option value='0'><%=objIdioma.getTraduccionHTML("i_seleccionar")%></option>
				<%if hayhabis then
					for h=0 to ubound(RegTHabis,2)
						marca=""
						if RegTHabis(THId,h)=tipoh then marca="selected"%>
						<option value='<%=RegTHabis(HId,h)%>' <%=marca%>><%=RegTHabis(THNombre,h)%></option>
					<%next
				end if%>
			</select>
		</td>
		</tr>
		<tr>
			<td align="left">
				<table width="100%" cellpadding="0" cellspacing="1">
				<tr>
				<%
				colu=1
				maxColu=5
				for idi=0 to ubound(listaIdiomas)%>
					<td align='left'>
					<%=objIdioma.getTraduccionHTML("i_nombre_" & listaIdiomas(idi))%>:<br/>   
					<input type='text' style="width:<%=anchoColu%>px;" maxlength='50' name='nombre_<%=listaIdiomas(idi)%>' value='<%=TIdiomas(idi)%>'>      
					</td>
					<%colu=colu+1
					if colu>maxColu then
						response.write "</tr><tr>"
						colu=1
					end if
				next 'idi%>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_capminima")%>:&nbsp;
			<input type="text" name="capmin" value="<%=capmin%>" maxlength='5' style="width:25px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=objIdioma.getTraduccionHTML("i_capnormal")%>:&nbsp;
			<input type="text" name="capnormal" value="<%=capnormal%>" maxlength='5' style="width:25px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=objIdioma.getTraduccionHTML("i_capmaxima")%>:&nbsp;
			<input type="text" name="capmax" value="<%=capmax%>" maxlength='5' style="width:25px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=objIdioma.getTraduccionHTML("i_adulminimo")%>:&nbsp;
			<input type="text" name="adultmin" value="<%=adultmin%>" maxlength='5' style="width:25px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=objIdioma.getTraduccionHTML("i_adulmaximo")%>:&nbsp;
			<input type="text" name="adultmax" value="<%=adultmax%>" maxlength='5' style="width:25px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=objIdioma.getTraduccionHTML("i_ninmaximo")%>:&nbsp;
			<input type="text" name="ninmax" value="<%=ninmax%>" maxlength='5' style="width:25px"></td>		
		</tr>
		<tr>
		<td align='left'><%=objIdioma.getTraduccionHTML("i_ordenvisual")%>
		<select name='orden'>
			<%for o=0 to 10
					marca=""
					if o=orden then marca="selected"%>
				<option value='<%=o%>' <%=marca%>><%=o%></option>
			<%next%>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<%=objIdioma.getTraduccionHTML("i_cunaocupa")%>&nbsp;
			<input type="checkbox" value="1" name="cunaocupa"<%if cunaocupa then response.write " checked"%>>&nbsp;
			<%=objIdioma.getTraduccionHTML("i_textocunaocupa")%>
			<%if laid<>0 then 'sólo cuando hay habitacion%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="<%=objIdioma.getTraduccionHTML("i_descrihabitacion")%>" onClick="javascript:descripcionHabi();" class="boton145">
			<%end if%>
		</td>
		</tr>
		<tr><td align='center'>
		<%if multiTarifa and hayTarifas then%>
		<p style="float:left">
		<%=objIdioma.getTraduccionHTML("i_tarifa")%>
		<select name='tarifa' onChange="javascript:cambioTarifa(this);">
		<%for t=0 to ubound(RegTarifas,2)
			marca=""
			if RegTarifas(TaCodi,t)=laTarifa then marca=" selected"%>
		<option value='<%=RegTarifas(TaCodi,t)%>'<%=marca%>><%=RegTarifas(TaNombre,t)%></option>
		<%next 't%>
		</select>
		</p>
		<%end if%>
		<input id='bnuevo' type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" class="boton145">
		<%if laid<>0 then%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='elcupo' class="boton145" onclick="javascript:VerCupo();" value='<%=objIdioma.getTraduccionHTML("i_dispocupos")%>'>
		<%end if%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onclick="javascript:cerrar();" value='<%=objIdioma.getTraduccionHTML("i_cerrar")%>'>
		<input type='hidden' name='id' value='<%=laid%>'>
		</td></tr>
	</table>
	<div id='masFrames'>
		<%if laid=0 then 'poner capa encima%>
		<div id='laTapa'></div>
		<%end if%>
		<iframe frameborder='0' hspace='0' vspace='0' src='preciosTemporada.asp?id=<%=laid%>&est=<%=est%>' style="width:350px;" class="iframeHabitacion" scrolling="no"></iframe>
	
		<iframe id='dto3' frameborder='0' hspace='0' vspace='0' src='Dto3Habitacion.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:490px; margin-left:5px;" class="iframeHabitacion" scrolling="no"></iframe>
		
		<iframe id='pregimen' frameborder='0' hspace='0' vspace='0' src='precioRegimen.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:440px; margin-top:5px;" class="iframeHabitacion" scrolling="no"></iframe>
	
		<iframe id='dtoregimen' frameborder='0' hspace='0' vspace='0' src='dtosRegimen.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:400px; margin-left:5px; margin-top:5px;" class="iframeHabitacion" scrolling="no"></iframe>
	</div>
	</td></tr>
	<tr><td align="center">
		<%if laid<>0 then%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='elcupo2' class="boton145" onclick="javascript:VerCupo();" value='<%=objIdioma.getTraduccionHTML("i_dispocupos")%>'>
		<%end if%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onclick="javascript:cerrar();" value='<%=objIdioma.getTraduccionHTML("i_cerrar")%>'>
	</td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
	document.getElementById('bnuevo').value='<%=objIdioma.getTraduccionHTML("i_anadirhabitacion")%>';
	<%end if%>
	document.f1.nombre_<%=langPorDefecto%>.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>