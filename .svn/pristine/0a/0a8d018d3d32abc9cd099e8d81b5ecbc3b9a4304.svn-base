<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta
est=clng("0" & request.QueryString("est"))
MiId=clng("0" & request.QueryString("id"))
ver=request.QueryString("ver")

'MiId=request.querystring("id")
acti=request.QueryString("acti")
if acti<>"" then 'viene un valor, hay que añadir
	texto_es=quitarApos(request.form("texto_es"))
	texto_it=quitarApos(request.form("texto_it"))
	texto_en=quitarApos(request.form("texto_en"))
	texto_de=quitarApos(request.form("texto_de"))
	texto_fr=quitarApos(request.form("texto_fr"))
	idacti=request.form("idacti")
	if idacti="" then 'insertar
		cs="INSERT INTO " & precrs & "TiposServicioHotel (IdTipo,CodigoEsta,Texto_es,Texto_it,Texto_en,"
		cs=cs & "Texto_de,Texto_fr) VALUES ("
		cs=cs & acti & "," & MiId & ",'" & texto_es & "','" & texto_it & "','" & texto_en & "','"
		cs=cs & texto_de & "','" & texto_fr & "')"
	else 'actualizar
		cs="UPDATE " & precrs & "TiposServicioHotel SET Texto_es='" & texto_es & "',"
		cs=cs & "Texto_it='" & texto_it & "',"
		cs=cs & "Texto_en='" & texto_en & "',"
		cs=cs & "Texto_de='" & texto_de & "',"
		cs=cs & "Texto_fr='" & texto_fr & "' "
		cs=cs & "WHERE IdTipo=" & idacti & " AND CodigoEsta=" & MiId
	end if
	base.execute cs
	controlRegistro(cs) 'guarda seguimiento
end if
'Comprobar si hay que borrar actividades
queborro=split(request.form("elimina"),",")
if ubound(queborro)>=0 then
	cadena="("
	for t=0 to ubound(queborro)
		cadena=cadena & "IdTipo=" & trim(queborro(t)) & " OR "
	next
	if right(cadena,4)=" OR " then 'Quitar el ultimo operador
		cadena=left(cadena,len(cadena)-4)
	end if	
	cadena=cadena & ") AND CodigoEsta=" & MiId
	'Borrar en Actividades hotels
	cs="DELETE FROM " & precrs & "TiposServicioHotel WHERE " & cadena
	base.execute cs
	controlRegistro(cs) 'guarda seguimiento
end if

%><!--#include file="actuAlojamiento.asp"--><%

dim TIdioma(5)
TIdioma(1)="it"
TIdioma(2)="es"
TIdioma(3)="en"
TIdioma(4)="de"
TIdioma(5)="fr"



cs="SELECT Establecimientos.CodigoEsta,Nombre,Porciento,MinDias,Estado,Obs,Nombre_es,Zona "
cs=cs & "FROM (" & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) INNER JOIN TipoAlojamiento "
cs=cs & "ON DatosHotel.TipoAlojamiento=TipoAlojamiento.Id "
cs=cs & buscoHoteles
cs=cs & " ORDER BY Establecimientos.Nombre"
'response.write cs & "<br/>"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HPorciento=2
	HMinDias=3
	HEstado=4
	HObs=5
	HTipoa=6
	HZona=7
	HayHoteles=true

	PorPag=25
	TotReg=ubound(RegHoteles,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("P")
	if Pag="" then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close

'Buscar datos del hotel
%><!--'#include file="verAlojamiento.asp"--><%


'Buscar las zonas
'cs="SELECT id,Zona_es FROM Zonas"
'rs.open cs,base
'hayzonas=false
'if not rs.eof then
'	RegZonas=rs.getrows
'	Zid=0
'	ZNombre=1
'	hayzonas=true
'end if
'rs.close

'Buscar las Subzonas
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

'cadenas(proveedores)
cs="SELECT id,nombre FROM " & precrs & "proveedores ORDER BY nombre"
rs.open cs,base
haypro=false
if not rs.eof then
	RegPro=rs.getrows
	PId=0
	PNombre=1
	haypro=true
end if
rs.close
'contactos del hotel
cs="SELECT id,nombre,apellidos,idpro,cargo FROM " & precrs & "contactos where idest=" & laid
rs.open cs,base
hayCnt=false
if not rs.eof then
	RegCnt=rs.getrows
	CntId=0
	CntNombre=1
	Cntapellidos=2
	Cntidpro=3
	CntCargo=4
	hayCnt=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

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
		parent.location="verAlojamientosPanelVer.asp?p=<%=pag%>";
	else
		eval(parent.ultimoFrame); //recarga el ultimo frame
		
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?modo=actu&ver=<%=ver%>&id=<%=MiId%>&est=<%=est%>";

	document.f1.submit();
}
function nuevaActi(){
	acti=document.f1.actividad.value;
	if (acti=='0'){
		alert("No se ha seleccionado producto");
		return false;
	}
	document.f1.action="<%=MiPag%>?est=<%=est%>&id=<%=laid%>&acti="+acti+"&ver=act";
	document.f1.submit();
}

var textoes=new Array();
var textoit=new Array();
var textoen=new Array();
var textode=new Array();
var textofr=new Array();
<%
if tieneacti then
	for a=0 to ubound(RegAHotel,2)
	response.Write "textoes[" & RegAHotel(AHId,a)  & "]='" & saltoLinea(RegAHotel(AHTexto_es,a)) & "';" & vbcrlf
	response.Write "textoit[" & RegAHotel(AHId,a)  & "]='" & saltoLinea(RegAHotel(AHTexto_it,a)) & "';" & vbcrlf
	response.Write "textoen[" & RegAHotel(AHId,a)  & "]='" & saltoLinea(RegAHotel(AHTexto_en,a)) & "';" & vbcrlf
	response.Write "textode[" & RegAHotel(AHId,a)  & "]='" & saltoLinea(RegAHotel(AHTexto_de,a)) & "';" & vbcrlf
	response.Write "textofr[" & RegAHotel(AHId,a)  & "]='" & saltoLinea(RegAHotel(AHTexto_fr,a)) & "';" & vbcrlf
	next
end if
%>
function ponActi(esa) {
	document.f1.idacti.value=esa;
	document.getElementById('actividad').value=esa;
	document.getElementById('actividad').disabled=true;
	document.getElementById('botonacti').value="Actualizar";
	document.getElementById('texto_es').value=textoes[esa];
	document.getElementById('texto_it').value=textoit[esa];
	document.getElementById('texto_en').value=textoen[esa];
	document.getElementById('texto_de').value=textode[esa];
	document.getElementById('texto_fr').value=textofr[esa];
	document.getElementById('productos').style.visibility='visible';
	
}
function actiBlanco(){
	document.getElementById('texto_es').value="";
	document.getElementById('texto_it').value="";
	document.getElementById('texto_en').value="";
	document.getElementById('texto_de').value="";
	document.getElementById('texto_fr').value="";
	document.getElementById('productos').style.visibility='visible';
}

function borraActi(){
	document.f1.action="<%=MiPag%>?est=<%=est%>&id=<%=laid%>&ver=act";
	document.f1.submit();
}
</script>
<body style="background-image:none;">
<form name="f1" method="post" action="<%=MiPag%>">
			<table width='100%' align='center' border="0" cellpadding="0" cellspacing="0" class="tdTabla">
			  <tr><td align='center' class="tituloTabla">ACTIVIDADES DEL HOTEL<b><%=ucase(nhotel)%></b></td>
			  </tr>
 <tr><td valign="top" align="center">
				
					<!--poner actividades del hotel-->
					<table cellpadding="0" cellspacing="2" width="80%" border="1">
					<%if tieneacti then%>
						<tr>
						<%for a=0 to ubound(RegAHotel,2)%>
							<td align='left'>
				  			<input type="checkbox" style='border:none' name="elimina" value="<%=RegAHotel(AHId,a)%>">&nbsp;<a href="javascript:ponActi(<%=RegAHotel(AHId,a)%>);">
							<%=RegAHotel(AHNombre,a)%></a>
							</td>
							<%if ((a+1)/4)=int((a+1)/3) then 'otra fila
								response.write "</tr><tr>"
							end if
						next%>
						</tr>
					<%end if%>
					</table>
					<br>
					<div id='productos' style="visibility:hidden; width:760px; height:195px; overflow:hidden; border: 1px solid #000000; background-color:#CCCCCC;">
					<table border="0" width="100%" cellspacing="2" cellpadding="0">
					<tr><td colspan="5" align="left">
						Seleccionar Servicio:<br/>
						<select id='actividad' name='actividad'>
						<option value='0'>Seleccionar</option>
						<%if hayacti then
							for a=0 to ubound(RegActi,2)%>
								<option value="<%=RegActi(ACodi,a)%>"><%=RegActi(ANombre,a)%></option>
							<%next
						end if%>
						</select>					
					</td></tr>
					<tr>
					<td align='left'>Texto Esp.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto_es',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ita.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto_it',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ing.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto_en',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ale.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto_de',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Fr.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto_fr',600,430);" style="cursor:pointer; width: 70px;"></td>
					</tr>
					<tr>
					<td align='left'>
						<textarea id='texto_es' name='texto_es' style="height:100px; width:148px;"><%=texto_es%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto_it' name='texto_it' style="height:100px; width:148px;"><%=texto_it%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto_en' name='texto_en' style="height:100px; width:148px;"><%=texto_en%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto_de' name='texto_de' style="height:100px; width:148px;"><%=texto_de%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto_fr' name='texto_fr' style="height:100px; width:148px;"><%=texto_fr%></textarea>
					</td>
					</tr>
					<tr><td colspan="7" align="center">
						<input id='botonacti' type="button" class="boton145" value="Añadir" style="cursor:pointer" onclick="javascript:nuevaActi();">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="hidden" name="idacti" value="">
					</td></tr>
					</table>
					</div>
					<center>
					<input type="button" class='boton145' value="Añadir Servicio" style="cursor:pointer;" onclick="javascript:actiBlanco();">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class='boton145' value="Borrar marcados" style="cursor:pointer;" onClick="javascript:borraActi();">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</center>
				</td></tr>
				</table>

		</form>
</body>
</html>