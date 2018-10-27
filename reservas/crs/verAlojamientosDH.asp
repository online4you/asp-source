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
function abreMetas(){
	var vent;
	ancho=770;
	alto=300;
	l=parseInt(screen.width)/2-(ancho/2);
	vent=open("Metas.asp?idh=<%=laid%>","","width="+ancho+",height="+alto+",top=100,left="+l+",status=no,Resizable=no");
	vent.focus();
}
</script>
<body style="background-image:none;">
<form name="f1" method="post" action="<%=MiPag%>">
			<table width='100%' align='center' border="0" cellpadding="0" cellspacing="0" class="tdTabla">
			  <tr><td align='center' class="tituloTabla">DATOS HOTEL<b><%=ucase(nhotel)%></b></td>
			  </tr>
			  <tr><td valign="top" align="center">
				<table cellpadding='5'>
				<tr>
				<td>
				<table width='100%' border='0' cellspacing='0'>
				  <tr>
					<td align='right'>Alojamiento:</td>
					<td align='left'>
					  <input type="text" name='nombrev' value="<%=nombre%>" size='50' maxlength='75'></td>
				  </tr>
				  <tr><td align='right'>Tipo Alojamiento:</td>
					<td align='left'>
						<select name='tipohotelv'>
							<%if haytipos then
								for t=0 to ubound(RegTipos,2)
									marca=""
									if RegTipos(TId,t)=tipoh then marca="selected"%>
									<option value='<%=RegTipos(TId,t)%>' <%=marca%>><%=RegTipos(TNombre,t)%></option>
								<%next
							end if%>
						</select>
					</td>
				  </tr>
				  <tr><td align='right'>Categoria:</td>
					<td align='left'>
						<select name='categoriav'>
							<option value='0'>No tiene</option>
							<%if haycate then
								for c=0 to ubound(RegCate,2)
									marca=""
									if RegCate(CId,c)=categoria then marca="selected"%>
									<option value='<%=RegCate(CId,c)%>' <%=marca%>><%=RegCate(CNombre,c)%></option>
								<%next
							end if%>
						</select>
					</td>
				  </tr>
				   <tr><td align='right'>Cadena:</td>
					<td align='left'>
						<select name='proveedorv' id='proveedorv' <%if not esAdmin then response.write " disabled"%>>
							<option value=0>Vincular a cadena</option>
							<%if haypro then
								for p=0 to ubound(Regpro,2)%>
								<%marc=""
								if Regpro(pId,p)=clng(idpro) then marc="selected"%>
									<option value=<%=Regpro(pId,p)%> <%=" " & marc%>><%=Regpro(pNombre,p)%></option>
								<%next
							end if%>
						</select>
						<% if esAdmin then%>
						&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='boton145' value='Ir a Cadena' onclick="javascript:document.location.href='proveedores.asp?id='+document.getElementById('proveedorv').value;" style='cursor:pointer'>
						<%end if%>
					</td>
				  </tr>
				  <tr>
					<td align='right'>EMail:</td>
					<td align='left'>
					  <input type="text" name='emailv' value="<%=email%>" size='50' maxlength='75'><br/>
					  (se puede poner 2 emails separados por ",")
					  </td>
				  </tr>
				  <tr>
					<td align='right'>Direcci&oacute;n:</td>
					<td align='left'>
					  <input type="text" name='direccionv' value="<%=dire%>" size='50' maxlength='50'>
					  </td>
				  </tr>
				  <tr  >
					<td align='right'>CP:</td>
					<td align='left'>
					  <input type="text" name='cpv' value="<%=cp%>" size='6' maxlength='5'></td>
				  </tr>
				  <tr  >
					<td align='right'>Poblaci&oacute;n:</td>
					<td align='left'>
					  <input type="text" name='poblacionv' value="<%=pobla%>" size='50' maxlength='50'></td>
				  </tr>
				  <tr  >
					<td align='right'>Tel&eacute;fono:</td>
					<td align='left'>
					  <input type="text" name='telefonov' value="<%=tele%>" size='25' maxlength='25'></td>
				  </tr>
				  <tr  >
					<td align='right'>Fax:</td>
					<td align='left'>
					  <input type="text" name='faxv' value="<%=fax%>" size='25' maxlength='25'></td>
				  </tr>
				  <tr>
					<td align='right'>Web:</td>
					<td align='left'>
					  <input type="text" name='webv' value="<%=web%>" size='25' maxlength='50'></td>
				  </tr>
				<%if hayNucleos then%>
				  <tr>
					<td align='right'>Zona:</td>
					<td align='left'>
					  <select name='zonav'>
					  	<option value='0'>Seleccionar</option>
						<%for z=0 to ubound(RegNucleos,2)
						marca=""
						if RegNucleos(Nid,z)=zona then marca="selected"%>
						<option value='<%=RegNucleos(NId,z)%>' <%=marca%>><%=RegNucleos(NNombre,z)%></option>
						<%next%>
					  </select>
					</td>
				  </tr>
				  <%end if%>
				  <tr>
					<td align='right'>&nbsp;Orden de visual.:</td>
					<td align='left'>
						<select name='ordenv'>
						  <%for t=0 to 20%>
						  <option value='<%=t%>'><%=t%></option>
						  <%next%>
						</select>
						<input type="hidden" name='avisov' value="0"></td>
				  </tr>
				  <tr>
					<td align='right'>&nbsp;Dias Anulación:</td>
					<td align='left'>
						<input type="text" name='diasanulv' value="<%=diasanul%>" size='2' maxlength="6"></td>
				  </tr>
				  <tr>
					<td align='right'>&nbsp;% Prepago:</td>
					<td align='left'>
				  <input type="text" name="prepagov" value="<%=prepago%>" size='2' maxlength="6" <%if not esAdmin then response.write " readonly"%>>
				  % &nbsp;&nbsp;&nbsp; Noches m&iacute;nimas:
				  <input type="text" name="diasminv" value="<%=diasmin%>" size='2' maxlength="5">
					</td>
				  </tr>
				  <tr>
					<td align='right'>&nbsp;Estado Hotel:</td>
					<td align='left'>
						<select name='estadov' <%if not esAdmin then response.write " disabled"%>>
						<option value='0' <%if estado=0 then response.write "selected"%>>No Venta</option>
						<option value='1' <%if estado=1 then response.write "selected"%>>On Request</option>
						<option value='2' <%if estado=2 then response.write "selected"%>>On-Line</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <input type="button" class='boton145' value='Metas del hotel' onclick="javascript:abreMetas();" style="cursor:pointer;">
					  </td>
				  </tr>
				  <tr>
					<td align='right'>Observaciones:</td>
					<td align='left'>
						<textarea style="width:250px; height:40px;" name='obsv'><%=obs%></textarea>
					</td>
				  </tr>
				  
				  <tr>
					<td colspan="2" height="10"></td>
				  </tr>
				</table>
				</td>
			<td valign='top' align='center'>
				<% if esAdmin then%>
				<table>
				<tr>
				<td align='center'>Comentarios:</td></tr>
				<tr>
				<td align='center'>
				<textarea style="width:300px; height:160px;" name='obs2v'><%=obs2%></textarea>
				</td>
				</tr>
				</table>
				<table>
				<tr><td align='center' colspan='2'>CONTACTOS HOTEL</td></tr>
				<% if hayCnt then%>
					<%for cnt=0 to ubound(regcnt,2)%>
					<tr><td><a href="contactos.asp?cnt=<%=regcnt(Cntid,cnt)%>&ht=<%=MiId%>&pro=<%=idpro%>" ><%=RegCnt(CntApellidos,cnt)%>, <%=RegCnt(Cntnombre,cnt)%></a>&nbsp;&nbsp;&nbsp;</td>
					<td><%=RegCnt(Cntcargo,cnt)%></td>
					<%next%>
					</tr>
				<%end if%>
					<tr><td colspan='2'><input type='button' class='boton145' value='Agregar Contacto' onclick='javascript:top.location.href="contactos.asp?ht=<%=MiId%>&pro=<%=idpro%>"'></td></tr>
				</table>
				<%end if%>
				</td>
				</tr>
			  <tr><td align='center' colspan="2">
					<input name="yesooooo" class='boton145' type='button' id='button' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <input name="pasa" class='boton145' type='button' id='button' style='cursor:pointer' onclick="javascript:pasaHTMLMenuNewEd();" value='Pasar a HTM'>
				</td>
			  </tr>
			</table><!--fin datos-->
		</form>
</body>
</html>