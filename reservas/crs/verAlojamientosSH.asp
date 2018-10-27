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
</script>
<body style="background-image:none;">
<form name="f1" method="post" action="<%=MiPag%>">
			<table width='100%' align='center' border="0" cellpadding="0" cellspacing="0" class="tdTabla">
			  <tr><td align='center' class="tituloTabla">CÓMO LLEGAR<b><%=ucase(nhotel)%></b></td>
			  </tr>
			  <tr><td valign="top" align="center">

					<table width='100%' border='0' cellspacing="2" cellpadding="0">
					<tr>
					<td align='left'>Texto Esp.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto1_es',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ita.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto1_it',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ing.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto1_en',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Ale.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto1_de',600,430);" style="cursor:pointer; width: 70px;"></td>
					<td align='left'>Texto Fr.<input type="button" class='boton86' value="Editor" onclick="javascript:abreEditor('texto1_fr',600,430);" style="cursor:pointer; width: 70px;"></td>
					</tr>
					<tr>
					<td align='left'>
						<textarea id='texto1_es' name='texto1_es' style="height:140px; width:148px;"><%=texto1_es%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto1_it' name='texto1_it' style="height:140px; width:148px;"><%=texto1_it%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto1_en' name='texto1_en' style="height:140px; width:148px;"><%=texto1_en%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto1_de' name='texto1_de' style="height:140px; width:148px;"><%=texto1_de%></textarea>
					</td>
					<td align='left'>
						<textarea id='texto1_fr' name='texto1_fr' style="height:140px; width:148px;"><%=texto1_fr%></textarea>
					</td>
					</tr>
				  <tr>
					<td align='center' colspan='5'>
					  <input name="bnuevo" type='button' class="boton145" id='button' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <% if request.Cookies("userBD")="qbv387" then%>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <input name='botonNE' type="button" class="boton145" value="&nbsp;Google Map&nbsp;" onClick="javascript:window.open('correcGmap.asp?est=<%=laid%>','Gmapa','top=20,left=40,width=770,height=720,toolsbar=no,scrollbars=no,Resizable=no,Directories =no,Location =no,Status =no,Titlebar=no');" style='cursor:pointer'>
				  <%end if%>
					</td>
				  </tr>
					<tr><td colspan='5' align='center'>
						<%'INCLUIR MODULO DE FOTOS%>
						<iframe align='top' frameborder="0" height="130"  hspace="0" vspace="0" width="710" src="FotosHotel.asp?idf=<%=laid%>&otravez=1&ver=<%=ver%>">
						</iframe>
					</td></tr>
					</table>
		
				</td></tr>
		</table>
		</form>
</body>
</html>