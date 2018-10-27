<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

	'Variables de tipo servicio
	porpersona=0
	porreserva=1
	pordia=2
	porpersonaydia=3
	porhabitacion=4

if not esAdmin then 'Usuario con hotel
	busco="WHERE "
	buenos=split(request.Cookies("HotelBoss"),";")
	for b=0 to ubound(buenos)
		if isnumeric(buenos(b)) then
			busco=busco & "CodigoEsta=" & buenos(b) & " OR "
		end if
	next
	busco=left(busco,len(busco)-4)
else
	busco="" 'es administrado saca todos los hoteles
end if
'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
if request.QueryString("precios")="si" then%>
	<!--#include file="ModiPVPServis.asp"-->
<%else
	modo=request.QueryString("modo")
	url=quitarApos(request.form("url"))
	MiId=request.form("id")
	nombre_es=QuitarApos(request.form("nombre_es"))
	nombre_it=QuitarApos(request.form("nombre_it"))
	nombre_en=QuitarApos(request.form("nombre_en"))
	nombre_de=QuitarApos(request.form("nombre_de"))
	nombre_fr=QuitarApos(request.form("nombre_fr"))
	
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				'Borrar nombre Servicios
				cs="DELETE FROM " & precrs & "ServiciosExtras  WHERE "
				cadena=""
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cadena,4)=" OR " then 'Quitar el ultimo operador
					cadena=left(cadena,len(cadena)-4)
				end if	
				base.execute cs & cadena
				'Borrar precios Servicios
				cadena=replace(cadena,"Id=","IdServicio=")
				cs="DELETE FROM ServiciosPrecios WHERE "
				base.execute cs & cadena
				
			end if
			
		case "nuevo" 'Añadir
			'Añadir en servicios
			cs="INSERT INTO " & precrs & "ServiciosExtras (CodigoEsta,url,Nombre_es,Nombre_it,Nombre_en,"
			cs=cs & "Nombre_de,Nombre_fr) VALUES ("
			cs=cs & est & ",'" & url & "','" & nombre_es & "','" & nombre_it & "','"
			cs=cs & nombre_en & "','" & nombre_de & "','" & nombre_fr & "')"
			base.execute cs
			
			'Busco el id de la ult. servicio
			cs="SELECT MAX(id) as IDServi FROM ServiciosExtras"
			rs.open cs,base
			if not rs.eof then
				laid=rs("IdServi")
			end if
			rs.close
			
		case "actu"
			cs="UPDATE " & precrs & "ServiciosExtras SET "
			cs=cs & "url='" & url & "',"
			cs=cs & "Nombre_es='" & nombre_es & "',"
			cs=cs & "Nombre_it='" & nombre_it & "',"
			cs=cs & "Nombre_en='" & nombre_en & "',"
			cs=cs & "Nombre_de='" & nombre_de & "',"
			cs=cs & "Nombre_fr='" & nombre_fr & "' "
			cs=cs & "WHERE id=" & MiId
			base.execute cs
			
	end select
end if 'precios='si'

if laid="" then 'Si hay nueva
	laid=request.QueryString("id")
end if
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "ServiciosExtras "
	cs=cs & "WHERE id=" & laid
	rs.open cs,base
	do while not rs.eof
		url=rs("url")
		nombre_es=rs("nombre_es")
		nombre_it=rs("nombre_it")
		nombre_en=rs("nombre_en")
		nombre_de=rs("nombre_de")
		nombre_fr=rs("nombre_fr")
		rs.movenext
	loop
	rs.close
	
	'Buscar precios del servicoi seleccionado
	cs="SELECT id,IdTemporada,IdColectivo,Tipo,Importe FROM " & precrs & "ServiciosPrecios "
	cs=cs & "WHERE IdServicio=" & laid
	hayprecios=false
	rs.open cs,base
	if not rs.eof then
		RegPrecios=rs.getrows
		PId=0
		PTempo=1
		PColec=2
		PTipo=3
		PPelas=4
		hayprecios=true
	end if
	rs.close
end if

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY FInicio"
rs.open cs,base
if not rs.eof then
	RegTempos=rs.getrows
	rs.close
	TCodi=0
	TFIni=1
	TFFin=2
else
	rs.close
	set rs=nothing
	base.close
	set base=nothing
	response.write "<html><body><h2>Tiene que crear primero las temporadas del Establecimiento</h2>" & vbcrlf
	response.write "<input type='button' value='Volver' onclick='javascript:window.history.back();'>" & vbcrlf
	response.write "</body></html>"
	response.End()
end if


'Lista de registros
cs="SELECT ServiciosExtras.id,Nombre_es,IdTemporada,IdColectivo,Tipo,Importe "
cs=cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras LEFT JOIN " & precrs & "ServiciosPrecios ServiciosPrecios "
cs=cs & "ON ServiciosExtras.id=ServiciosPrecios.IdServicio "
cs=cs & "WHERE CodigoEsta=" & est
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNombre=1
	RTempo=2
	RColec=3
	RTipo=4
	RPelas=5
	haylista=true
end if
rs.close

'Buscar nombres de colectivos de ese hotel
cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
cs=cs & "ON Colectivos.COdigoColec=ColectivosNomres.ColectivoIdi "
cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' AND Nombre<>''"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
end if
rs.close



set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}

function Modificar(){
	esaid=document.f1.id.value;
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo&id="+esaid;
	else
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu&id="+esaid;

	document.f1.submit();
}
function enBlanco(){
	document.f1.url.value="";
	document.f1.nombre_es.value='';
	document.f1.nombre_it.value='';
	document.f1.nombre_en.value='';
	document.f1.nombre_de.value='';
	document.f1.nombre_fr.value='';
	document.getElementById('bnuevo').value=" Añadir ";
	document.f1.id.value="";
	document.getElementById('panel').style.visibility='visible';
	//Quitar la lineas de precios
	document.getElementById('lineasprecio').style.visibility='hidden';
	document.f1.nombre_es.focus();
}

function BorrarPrecios(){
	if (confirm("¿Está seguro/a?")){
		esaid=document.f1.id.value;
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra&id="+esaid+"&precios=si";
		document.f1.submit();
	}
}
function ModificarPrecios(){
	esaid=document.f1.id.value;
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu&id="+esaid+"&precios=si";
	document.f1.submit();
}
function NuevoPrecio(){
	esaid=document.f1.id.value;
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo&id="+esaid+"&precios=si";
	document.f1.submit();
}

function VerSelect(Estado){
	//la variable Estado es true(visibles) o false(oculto)
	//Buscar los select que me interesa
	var lista=new Array ();
	lista[0]="temporada-";
	lista[1]="colectivo-";
	maxlista=1;
	if (Estado)
		teveo='visible';
	else
		teveo='hidden';
	//Buscar en todos los objetos
	for (t=0;t<document.f1.length;t++)
		{
			for (l=0;l<=maxlista;l++)
			{
				if (document.f1[t].name.indexOf(lista[l])>=0) //comprueba si está ese select
					document.f1[t].style.visibility=teveo;
			}
		}
}
function DisabledBotones(Estado){
	//la variable Estado es true(visibles) o false(oculto)
	//Buscar los select que me interesa
	//Buscar en todos los objetos
	for (t=0;t<document.f1.length;t++)
		{
			if (document.f1[t].name=="boton") //comprueba si está el boton
				document.f1[t].disabled=Estado;
		}
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr><td align='left' class="style1b">
	* Este listado de temporadas depende del establecimiento seleccionado en la parte de arriba.
	</td></tr>	<tr><td align='center'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nuevo Servicio&nbsp;'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='&nbsp;Borrar Marcados&nbsp;' onclick='javascript:ABorrar();'>
	</td></tr>
	</table>
    <table width="250" height="71" border="0" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">SERVICIOS</div></td></tr>
  <tr><td valign="middle" class="tdTabla">
      <table width='650' border="0" align='center' cellpadding="0" cellspacing="0">
      <tr class='cabetabla'>
        <th>Borrar</th>
        <th>ID</th>
        <th align='left' class="colu_par">Nombre Servicio</th>
        <th align='center'>Temporada</th>
        <th align='center'>Colectivo</th>
        <th align='right'>Importe</th>
        <th align='center'>Tipo C&aacute;lculo</th>
      </tr>
      <%if haylista then
	mireg=-1
	for R=0 to ubound(RegLista,2)%>
      <tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
          <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
        </td>	  <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> </td>
        <td align='left' class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a> </td>
        <td align='center' class='<%=laColu(0)%>' >
          <%if RegLista(RTempo,r)=0 then 'Cualqiuer temporada
			response.write "Cualquiera"
		else 'Buscar fechas de la temporada
			for t=0 to ubound(RegTempos,2)
				if RegTempos(TCodi,t)=RegLista(RTempo,r) then 'Esta es%>
          <%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFFin,t))%>
          <%end if
			next
		end if%>
        </td>
        <td align='center' class='<%=laColu(0)%>' >
          <%if RegLista(RColec,r)=0 then 'Cualqiuer colectivo
			response.write "Cualquiera"
		else 'Buscar nombre colectivo
			for c=0 to ubound(RegColec,2)
				if RegColec(CCodi,c)=RegLista(RColec,r) then 'Esta es%>
          <%=RegColec(CNombre,c)%>
          <%end if
			next
		end if%>
        </td>
        <td align='right' class='<%=laColu(0)%>' >
          <%if not isnull(RegLista(RPelas,r)) then response.write formatnumber(RegLista(RPelas,r),2)%>
    &nbsp;&euro; </td>
        <td align='center' class="LineaTabla">
          <%select case RegLista(RTipo,r)
			case porpersona
				response.write "&nbsp;por persona" & vbcrlf
			case porreserva
				response.write "&nbsp;por reserva" & vbcrlf
			case pordia
				response.write "&nbsp;por d&iacute;a" & vbcrlf
			'case porpersonaydia
				'response.write "&nbsp;por persona y d&iacute;a" & vbcrlf
			case porhabitacion
				response.write "&nbsp;por habitación" & vbcrlf
		end select%>
        </td>
      </tr>
	<%next
	end if%>
      <tr>
        <td height='25' colspan='7'>    
      </tr>
    </table></td></tr>
</table></td></tr>
</table>

<div id='panel' style='position:absolute; z-index:10; top:50px; left:0px; width:750px; height:341px; visibility:hidden;' class='texto10BLANCO'>
<table border="0" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">NUEVO SERVICIO </div></td></tr>
  <tr><td class="tdTabla">
	<table width='730' border='0' align='center' cellpadding="0" cellspacing="2" class="tdTabla">
      <tr>
        <td height='20' align='center' class="bordecitobl">&nbsp;</td>
      </tr>
      <tr>
        <td align='center'>
          <table width='100%' border='0' cellspacing='0' class="tdTabla">
            <tr>
              <td align='left'>Servicio Esp.</td>
			  <td align='left'>Servicio Ita.</td>
			  <td align='left'>Servicio Ing.</td>
			  <td align='left'>Servicio Ale.</td>
			  <td align='left'>Servicio Fra.</td>
			</tr>
			<tr>
              <td align='left'><input type='text' style="width:145px" maxlength='75' name='nombre_es' value='<%=nombre_es%>'></td>
              <td align='left'><input type='text' style="width:145px" maxlength='75' name='nombre_it' value='<%=nombre_it%>'></td>
              <td align='left'><input type='text' style="width:145px" maxlength='75' name='nombre_en' value='<%=nombre_en%>'></td>
              <td align='left'><input type='text' style="width:145px" maxlength='75' name='nombre_de' value='<%=nombre_de%>'></td>
              <td align='left'><input type='text' style="width:145px" maxlength='75' name='nombre_fr' value='<%=nombre_fr%>'></td>
            </tr>
            <tr>
            <tr>
              <td align='left' colspan='5'> URL de informaci&oacute;n del Servicio<br>
              <input type='text' size='50' maxlength="75" name='url' value='<%=url%>'><br>
	          (si se deja en blanco no saldr&aacute; el enlace)</td>
            </tr>
            <tr>
              <td align='center' colspan='5'>
                <input name="bnuevo" type='button' id='bnuevo' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
                <input type='hidden' name='id' value='<%=laid%>'>
              </td>
            </tr>
            <tr>
              <td colspan='5' height='5'></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td align='center'>
          <%'TABLA DE PRECIOS%>
          <table width='98%' border='0' cellspacing='0' class="tdTabla" id='lineasprecio'>
            <tr class='CabeTabla'>
              <th align='center'>&nbsp;</th>
              <th align='center'><span class="style1">Temporada</span></th>
              <th align='center'><span class="style1">Colectivo</span></th>
              <th align='center'><span class="style1">Importe</span></th>
              <th align='center'><span class="style1">Tipo C&aacute;lculo</span></th>
            </tr>
            <%if hayprecios then 'Lista Precios
			for p=0 to ubound(RegPrecios,2)%>
            <tr>
              <td align='center'><input type='checkbox' name='pvpborrar' value='<%=RegPrecios(PId,p)%>'  style='height:13;border: 0px; width:13'></td>
              <td align='center'>
                <select name='temporada-<%=RegPrecios(PId,p)%>'>
                  <option value='0' <%if RegPrecios(PTempo,p)=0 then response.write "selected"%>> Cualquiera </option>
                  <%'Poner lista de temporadas y marcar la selecc.
						for t=0 to ubound(RegTempos,2)
							marca=""
							if RegTempos(Tcodi,t)=RegPrecios(PTempo,p) then marca="selected"%>
                  <option value='<%=RegTempos(Tcodi,t)%>' <%=marca%>> <%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t))%> </option>
                  <%next%>
                </select>
              </td>
              <td align='center'>
                <select name='colectivo-<%=RegPrecios(PId,p)%>'>
                  <option value='0' <%if RegPrecios(PColec,p)=0 then response.write "selected"%>> Cualquiera </option>
                  <%'Poner lista de Colectivos y marcar la selecc.
						for c=0 to ubound(RegColec,2)
							marca=""
							if RegColec(CCodi,c)=RegPrecios(PColec,p) then marca="selected"%>
                  <option value='<%=RegColec(CCodi,c)%>' <%=marca%>> <%=RegColec(CNombre,c)%> </option>
                  <%next%>
                </select>
              </td>
              <td align='center'>
                <input type='text' name='importe-<%=RegPrecios(PId,p)%>' value='<%=formatnumber(RegPrecios(PPelas,p),2)%>' size='4' maxlength="8">
              </td>
              <td align='center'>
                <%
				marca0=""
				marca1=""
				marca2=""
				marca3=""
				marca4=""
				select case clng(RegPrecios(PTipo,p))
					case porpersona
						marca0=" checked"
					case porreserva
						marca1=" checked"
					case pordia
						marca2=" checked"
					case porpersonaydia
						marca3=" checked"
					case porhabitacion
						marca4=" checked"
				end select
				
				%>
                <input type="radio" name="tipo-<%=RegPrecios(PId,p)%>"  style='height:13;border: 0px; width:13' value="0"<%=marca0%>>
                x persona &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="tipo-<%=RegPrecios(PId,p)%>"  style='height:13;border: 0px; width:13' value="1"<%=marca1%>>
                x reserva &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="tipo-<%=RegPrecios(PId,p)%>"  style='height:13;border: 0px; width:13' value="2"<%=marca2%>>
                x d&iacute;a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="tipo-<%=RegPrecios(PId,p)%>"  style='height:13;border: 0px; width:13' value="3"<%=marca3%>>
                x persona y d&iacute;a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="tipo-<%=RegPrecios(PId,p)%>"  style='height:13;border: 0px; width:13' value="4"<%=marca4%>>
                x habitación</td>
            </tr>
            <%next
	end if%>
            <tr>
              <td colspan='5' height='5'></td>
            </tr>
            <tr>
              <td colspan='5' align="center">
                <input name='boton' type='button' value="&nbsp;Nuevo Precio&nbsp;" onclick="javascript:VerSelect(false);DisabledBotones(true);document.getElementById('nuevoprecio').style.visibility='visible';document.f1.temporada.focus();">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name='boton' type='button' value="&nbsp;Actualizar Tabla&nbsp;" onclick='javascript:ModificarPrecios();'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name='boton' type='button' value="&nbsp;Borrar Marcados&nbsp;" onclick='javascript:BorrarPrecios();'>
              </td>
            </tr>
            <tr>
              <td colspan='5' height='10'></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="10"></td>
      </tr>
      <tr>
        <td align='center'>
          <input name='boton' type="button" value="&nbsp;Cerrar Ventana&nbsp;" onClick="javascript:VerSelect(false);document.getElementById('panel').style.visibility='hidden';" style='cursor:pointer'></td>
      </tr>
    </table></td></tr>
</table>
</div>

<div id='nuevoprecio' style='position:absolute; z-index:12; top:50px; left:50px; width:713px; height:294px; visibility:hidden; overflow:auto' class='texto10BLANCO'> 
  <div align="center">Precio
  </div>
    <table width="250" height="71" border="0" cellpadding="0" cellspacing="0">
    <tr><td><div align="center" class="tituloTabla">NUEVO PRECIO</div></td></tr>
    <tr><td valign="middle" class="tdTabla"><br>
        <table align='center' width='640' border='0' cellspacing="0" class="tdTabla">
        <tr class='CabeTabla'>
          <th align='center'>Temporada</th>
          <th align='center'>Colectivo</th>
          <th align='center'>Importe</th>
          <th align='center'>Tipo C&aacute;lculo</th>
        </tr>
        <tr>
          <td align='center'>
            <select name='temporada'>
              <option value='0'>Cualquiera</option>
              <%'Poner lista de temporadas
			for t=0 to ubound(RegTempos,2)%>
              <option value='<%=RegTempos(Tcodi,t)%>'> <%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t))%> </option>
              <%next%>
            </select>
          </td>
          <td align='center'>
            <select name='colectivo'>
              <option value='0'>Cualquiera</option>
              <%'Poner lista de Colectivos 
			for c=0 to ubound(RegColec,2)%>
              <option value='<%=RegColec(CCodi,c)%>'> <%=RegColec(CNombre,c)%> </option>
              <%next%>
            </select>
          </td>
          <td align='center'>
            <input type='text' name='importe' value='0' size='4' maxlength="8">
          </td>
          <td align='center'>
            <input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="0" checked>
            x persona &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="1">
            x reserva &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="2">
            x d&iacute;a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="3">
            x persona y d&iacute;a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="4">
            x habitación</td>

        </tr>
        <tr>
          <td colspan="4" height='10'></td>
        </tr>
        <tr>
          <td colspan="4" align='center'>
            <input name="button" type='button' onclick='javascript:NuevoPrecio();' value="A&ntilde;adir Precio">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type='button' onclick="javascript:VerSelect(true);DisabledBotones(false);document.getElementById('nuevoprecio').style.visibility='hidden';" value="Cerrar">
          </td>
        </tr>
        <tr>
          <td colspan="4" height='10'></td>
        </tr>
      </table></td></tr>
  </table>
</div>
<script language="JavaScript">
	//Centrar capa nuevoprecio en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('nuevoprecio').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('nuevoprecio').style.width)/2); //Pos. izquierda
	document.getElementById('nuevoprecio').style.top=t;
	document.getElementById('nuevoprecio').style.left=l;

	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	document.getElementById('panel').style.top=t+"px";
	document.getElementById('panel').style.left=(l-15)+"px";
	<%if laid<>0 then 
			response.write "document.getElementById('panel').style.visibility='visible';" & vbcrlf
	end if%>
</script>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
