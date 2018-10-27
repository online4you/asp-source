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

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("idh"))

%><!--#include file="actuHabitacion.asp"--><%
tipoH=0
redim TIdiomas(ubound(ListaIdiomas))
'Datos habitacion
cs="SELECT Orden,Nombre,TipoHabitacion,paraCapMin,ParaCapNormal,ParaCapMax,ParaAdultMax,ParaAdultMin,ParaNiMax,CunaOcupa,"
cs=cs & "Idioma,Traduccion,AdmiteNinos, prePago " 
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabitaNombres' AND Campo='Nombre' WHERE TipoHabitaNombres.Id=" & laid
'response.Write(cs & "<br>")
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
	admiteninos=rs("admiteninos")
	prePago=rs("prePago")
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
cs="SELECT TipoHabita.Id,IF(ISNULL(Traducciones.Traduccion),TipoHabita.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "TipoHabita TipoHabita LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabita.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoHabita' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "ORDER BY Orden"
'response.Write(cs & "<br>")
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
maxAncho=920 'ancho total iframe
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
<style type="text/css">
input {
	height:12px;
	font-size:11px;
}
</style>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	parent.cerrar();
}
<%if pasalir=1 then%>
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.nombre_<%=langPorDefecto%>.value==""){
		alert("<%=objIdioma.getTraduccion("i_obligados")%>");
		return;
	}
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&est=<%=est%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&idh=<%=laid%>&est=<%=est%>";

	document.f1.submit();
}
function VerCupo(){
	top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&mes=<%=month(date)%>&anyo=<%=anyo%>&tipoD=0&th=<%=laid%>&rm=12",1000,600,0,0);
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
<form name='f1' action="<%=MiPag%>" method="post">
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
					<%=objIdioma.getTraduccionHTML("i_nombre_" & listaIdiomas(idi))%>
					<%if idi=0 then response.write "*"%>:<br/>   
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
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%=objIdioma.getTraduccionHTML("i_admiteninos")%>
		<select name="admiteninos">
	        <option value="1"<%if admiteninos=1 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            <option value="0"<%if admiteninos=0 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
        </select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<%=objIdioma.getTraduccionHTML("i_prepago")%>
		<input type="text" name="prePago" value="<%=prePago%>" maxlength='3' style="width:25px">
		&nbsp;&nbsp;&nbsp;&nbsp;
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
		<iframe frameborder='0' hspace='0' vspace='0' src='preciosTemporada.asp?id=<%=laid%>&est=<%=est%>' style="width:370px;" class="iframeHabitacion" scrolling="no"></iframe>
	
		<iframe id='dto3' name='dto3' frameborder='0' hspace='0' vspace='0' src='Dto3Habitacion.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:540px; margin-left:5px;" class="iframeHabitacion" scrolling="no"></iframe>
		
		<iframe id='pregimen' name='pregimen' frameborder='0' hspace='0' vspace='0' src='precioRegimen.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:460px; margin-top:5px;" class="iframeHabitacion" scrolling="no"></iframe>
	
		<iframe id='dtoregimen' name='dtoregimen' frameborder='0' hspace='0' vspace='0' src='dtosRegimen.asp?id=<%=laid%>&est=<%=est%>&fa=<%=fc%>' style="width:450px; margin-left:5px; margin-top:5px;" class="iframeHabitacion" scrolling="no"></iframe>
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
	document.getElementById('bnuevo').value='<%=objIdioma.getTraduccion("i_anadirhabitacion")%>';
	<%end if%>
	document.f1.nombre_<%=langPorDefecto%>.focus();
	
	alto=(document.body.offsetHeight); //tamaño capa
	//top.document.getElementById(this.name).style.height=alto+"px";
	parent.document.getElementById("frame1").style.height=alto+"px";
	parent.document.getElementById("secciones").style.height=(alto+35)+"px";
	
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>