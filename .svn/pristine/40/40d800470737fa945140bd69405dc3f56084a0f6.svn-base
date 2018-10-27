<%@LANGUAGE='VBScript'%>
<%
lang="<vte=lang>"
est="<vte=est>"
est=clng(est)
%>
<!--#include virtual="/includes/constantes.asp"-->
<!--#include virtual="/includes/langweb.asp"-->
<!--#include virtual="/reservas/connections/lang.asp"-->
<%
'Indicar el nombre de la foto de cabecera
fotocabe="/img/fotodormir.jpg"
if session("PagAnterior")<>"" then
	atras=session("PagAnterior")
else
	atras="javascript:window.history.back();"
end if

'Para poner la fecha en cada idioma
lcid_es=3082
lcid_en=1033
lcid_de=1031
lcid_ca=1027
lcid_fr=1036
lcid_it=1040

select case lang
	case "es"
		session.LCID=lcid_es
	case "en"
		session.LCID=lcid_en
	case "de"
		session.LCID=lcid_de
	case "ca"
		session.LCID=lcid_ca
	case "fr"
		session.LCID=lcid_fr
	case "it"
		session.LCID=lcid_it
	case else
		session.lcid=lcid_en
end select

dim NombreMes(12)
arraymeses="new Array("
for m=1 to 12
	NombreMes(m)=MonthName(m)
	arraymeses=arraymeses & chr(34) & MonthName(m) & chr(34) & ","
next
'Quitar la ultima coma
arraymeses=left(arraymeses,len(arraymeses)-1)
arraymeses=arraymeses & ")"
diascortos="new Array("
diaslargos="new Array("
for d=1 to 7
	diascortos=diascortos & chr(34) & mid(WeekDayName(d,0,vbmonday),1,3) & chr(34) & ","
	diaslargos=diaslargos & chr(34) & WeekDayName(d,0,vbmonday) & chr(34) & ","
next
diascortos=left(diascortos,len(diascortos)-1)
diascortos=diascortos & ")"
diaslargos=left(diaslargos,len(diaslargos)-1)
diaslargos=diaslargos & ")"
session.LCID=lcid_es 'Sesion en formato español

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla de tipos de hotel
cs="SELECT Id,Nombre_" & lang & ",IdTipo FROM " & precrs & "TipoAlojamiento"
haytipoa=false
rs.open cs,base
if not rs.eof then
	RegTipoA=rs.getrows
	TaCodi=0
	TaNombre=1
	TaTipo=2
	haytipoa=true
end if
rs.close

'Tabla de categorias
cs="SELECT Id,Nombre_" & lang & ",IdTipo FROM " & precrs & "Categorias"
hayCate=false
rs.open cs,base
if not rs.eof then
	RegCate=rs.getrows
	CaCodi=0
	CaNombre=1
	CaTipo=2
	haycate=true
end if
rs.close

'Tabla de zonas
cs="SELECT Id,Zona_" & lang & " FROM " & precrs & "Zonas"
hayzona=false
rs.open cs,base
if not rs.eof then
	RegZona=rs.getrows
	ZCodi=0
	ZNombre=1
	hayzona=true
end if
rs.close

'Tabla de tipos habitaciones
cs="SELECT Id,ParaCapMax,ParaCapMin,ParaAdultMax,ParaNiMax,Nombre_" & lang & " "
cs=cs & "FROM " & precrs & "TipoHabita ORDER BY Orden"
haytipoh=false
rs.open cs,base
if not rs.eof then
	Regtipoh=rs.getrows
	HCodi=0
	HMax=1
	HMin=2
	HAMax=3
	HNMax=4
	HNombre=5
	haytipoh=true
end if
rs.close

'Prueba
'lang="es"
'est=clng("0" & request.QueryString("est"))

'Buscar datos del hotel
cs="SELECT Nombre,Categoria,PorCiento,Mindias,DiasAnulacion,Estado "
cs=cs & "FROM " & precrs & "DatosHotel DatosHotel INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON DatosHotel.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE DatosHotel.CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	nhotel=rs("nombre")
	categoria=rs("categoria")
	prepago=rs("porciento")
	nochesminimas=rs("mindias")
	diasanulacion=rs("diasanulacion")
	estado=rs("estado")
end if
rs.close
ficha=clng("0" & request.QueryString("ficha"))
if ficha=0 then ficha=1

select case ficha
	case 1 'Situacion
		cs="SELECT Texto1_" & lang & ",Foto1,Foto2 FROM " & precrs & "SituacionHotel SituacionHotel "
		cs=cs & "WHERE CodigoEsta=" & est
		rs.open cs,base
		if not rs.eof then
			texto=rs("texto1_" & lang)
			texto=saltoLinea(texto)
			foto1="" & rs("foto1")
			foto2="" & rs("foto2")
		end if
		rs.close
		tipoficha=ap("situacion")

	case 2 'Servicios
		cs="SELECT Texto1_" & lang & ",Foto1,Foto2 FROM " & precrs & "ServiciosHotel "
		cs=cs & "WHERE CodigoEsta=" & est
		rs.open cs,base
		if not rs.eof then
			texto=rs("texto1_" & lang)
			texto=saltoLinea(texto)
			foto1="" & rs("foto1")
			foto2="" & rs("foto2")
		end if
		rs.close
		tipoficha=ap("servicios")

	case 3 'Ofertas
		'Tabla de ofertas de ese alojamiento
		cs="SELECT Id,texto1_" & lang & " "
		cs=cs & "FROM " & precrs & "Ofertas "
		cs=cs & "WHERE CodigoEsta=" & est & " AND "
		cs=cs & "FechaFin>" & FechaMySQL(date) 
		rs.open cs,base
		hayoferta=false
		if not rs.eof then
			RegOferta=rs.getrows
			OCodi=0
			OTexto=1
			hayoferta=true
		end if
		rs.close

	case 4 'Tarifa Precios
		'Buscar temporadas
		cs="SELECT CodigoTemp,Nombre,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas INNER JOIN " & precrs & "TemporadasNomres TemporadasNomres "
		cs=cs & "ON Temporadas.CodigoTemp=TemporadasNomres.TempIdi "
		cs=cs & "WHERE CodigoEsta=" & est & "  AND Idioma='" & lang & "' AND "
		cs=cs & "FFinal>" & FechaMySQL(date) & " ORDER BY FInicio"
		rs.open cs,base
		haytempos=false
		if not rs.eof then 'Carga en tabla
			haytempos=true
			RegTempos=rs.getRows
			TCodi=0
			TNombre=1
			TFIni=2
			TFFin=3
		end if
		rs.close
		
		'Precios de las habitaciones 
		cs="SELECT IdHabita,Nombre_" & lang & ",Temporada,PrePreBase,PrePerHab "
		cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "ON TipoHabitaPrecios.IdHabita=TipoHabitaNombres.Id "
		cs=cs & "WHERE CodigoEsta=" & est & " ORDER BY Orden"
		rs.open cs,base
		hayhabis=false
		filashabi=1
		if not rs.eof then
			RegPvpHabi=rs.GetRows
			Hpvpcodi=0
			HPvpNombre=1
			HPvpTempo=2
			HPvpPrecio=3
			HPvpPorhab=4	
			hayhabis=true
			filashabi=ubound(RegPvpHabi,2)+1
		end if
		rs.close
	
		'Buscar Nombres colectivos
		cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
		cs=cs & "ON Colectivos.CodigoColec=ColectivosNomres.ColectivoIdi "
		cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='" & lang & "' AND "
		cs=cs & "Nombre<>'' ORDER BY CodigoColec"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.GetRows
			CCodi=0
			CNombre=1
		end if
		rs.close
		ColColec=ubound(RegColec,2)+1 'Nº de columnas en nombres de colectivos
		
		'Buscar Dtos colectivos
		cs="SELECT Colectivos.CodigoColec,Temporada,TipoHab,Prebase,Nombre_" & lang & " "
		cs=cs & "FROM (" & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
		cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec) "
		cs=cs & "INNER JOIN TipoHabitaNombres "
		cs=cs & "ON DescuentosColectivos.TipoHab=TipoHabitaNombres.Id "
		cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " ORDER BY Temporada,TipoHabitaNombres.Orden"
		rs.open cs,base
		haydtocolec=false
		if not rs.eof then
			RegDtoColec=rs.GetRows
			CdtoCodi=0
			CDtoTempo=1
			CDtoHabi=2
			CDtoValor=3
			CDtoNHabi=4
			haydtocolec=true
		end if
		rs.close

		'Buscar suplementos
		haysuples=false
		cs="SELECT Suplementos.CodigoSuple,CodigoHab,Precio,Nombre_" & lang & " as Suple,CodigoTempo "
		cs=cs & "FROM " & precrs & "Suplementos Suplementos INNER JOIN " & precrs & "SuplementosTempo SuplementosTempo "
		cs=cs & "ON Suplementos.CodigoSuple=SuplementosTempo.CodigoSuple "
		cs=cs & "WHERE Suplementos.CodigoEsta=" & est
		cs=cs & " ORDER BY CodigoTempo,CodigoHab,Suplementos.CodigoSuple"
		rs.open cs,base
		if not rs.eof then
			RegSuples=rs.GetRows
			SCodi=0
			SHabi=1
			SPrecio=2
			SNombre=3
			STempo=4
			haysuples=true
		end if
		rs.close


	case 5 'Galeria de Fotos
		cs="SELECT SituacionHotel.Foto1,SituacionHotel.Foto2,ServiciosHotel.Foto1 as Foto3,"
		cs=cs & "ServiciosHotel.Foto2 as Foto4,FotosHotel.Foto1 as Foto5,"
		cs=cs & "FotosHotel.Foto2 as Foto6,FotosHotel.Foto3 as Foto7,"
		cs=cs & "FotosHotel.Foto4 as Foto8,FotosHotel.Foto5 as Foto9,"
		cs=cs & "FotosHotel.Foto6 as Foto10 "
		cs=cs & "FROM (" & precrs & "SituacionHotel SituacionHotel INNER JOIN " & precrs & "ServiciosHotel ServiciosHotel "
		cs=cs & "ON SituacionHotel.CodigoEsta=ServiciosHotel.CodigoEsta) INNER JOIN FotosHotel "
		cs=cs & "ON SituacionHotel.CodigoEsta=FotosHotel.CodigoEsta "
		cs=cs & "WHERE SituacionHotel.CodigoEsta=" & est
		rs.open cs,base
		dim foto(10)
		if not rs.eof then
			foto(1)="" & rs("foto1")
			foto(2)="" & rs("foto2")
			foto(3)="" & rs("foto3")
			foto(4)="" & rs("foto4")
			foto(5)="" & rs("foto5")
			foto(6)="" & rs("foto6")
			foto(7)="" & rs("foto7")
			foto(8)="" & rs("foto8")
			foto(9)="" & rs("foto9")
			foto(10)="" & rs("foto10")
		end if
		rs.close
		tipoficha=ap("galeriafotos")
	
	
	

end select



set rs=nothing
base.close
set base=nothing

%>
<HTML>
<HEAD>
<TITLE><vte=nhotel> - Cala Ratjada</TITLE>
<meta name="keywords" content='<%=ap("metakeys")%>'>
<meta name="description" content='<%=ap("metadescri")%>'>
<meta name="copyright" content="Planeta-web 2004">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link href="/calendario.css" rel="stylesheet" type="text/css">
<link href="/global.css" rel="stylesheet" type="text/css">
</HEAD>
<script language="javascript" type="text/javascript" src="/includes/General.js"></script>
<script language="javascript" src="/includes/Calendario.js" type="text/javascript"></script>
<script language="javascript" src="/includes/imagezoom.js"></script>
<script language="javascript">
var pagina="";
function ponerFoto(esa){
	document.getElementById('fotogrande').src=esa;
}
function quePagina(yeso){
	sv=document.body.scrollTop;
	pagina=yeso.href+"&sv="+sv;
}
function descarga(){
	//alert(pagina);
	//alert(window.location);
	if (pagina!="")
		window.location=pagina;
}

textoOpcion=new Array (5);
textoOpcion[1]="<%=ap("situacion")%>";
textoOpcion[2]="<%=ap("servicios")%>";
textoOpcion[3]="<%=ap("ofertas")%>";
textoOpcion[4]="<%=ap("vertarifa")%>";
textoOpcion[5]="<%=ap("galeriafotos")%>";

marcaOpcion=new Array (5);
marcaOpcion[1]="/hoteles/img/palmera2.gif";
marcaOpcion[2]="/hoteles/img/cama2.gif";
marcaOpcion[3]="/hoteles/img/oferta2.gif";
marcaOpcion[4]="/hoteles/img/precio2.gif";
marcaOpcion[5]="/hoteles/img/camara2.gif";

function cambio(fotica,deesa,cuala){
	//La que esta ya marcada no se cambia
	if (deesa.id!="op<%=ficha%>"){
		if (fotica==""){ //mouseover
			deesa.src=marcaOpcion[cuala];
			//document.getElementById('texto').innerHTML=textoOpcion[cuala];
		}else{ //mouseout
			deesa.src=fotica;
			//document.getElementById('texto').innerHTML=textoOpcion[<%=ficha%>];
			}
	}
}

function fotoGrande(afoto){
	ancho=<%=fotoancho%>+20;
	alto=parseInt(ancho/1.33)+10;
	t=parseInt(screen.height/2)-(alto/2);
	l=parseInt(screen.width/2)-(ancho/2);
	//venti=window.open('/hoteles/fotogrande.asp?ft='+afoto,'',"top="+t+",left="+l+",height="+alto+",width="+ancho);
	venti=window.open('/hoteles/fotogrande.asp?ft='+afoto,'',"top="+t+",left="+l+",height="+alto+",width="+ancho);
	venti.focus();
}
</script>
<BODY BGCOLOR="#FFFFFF" class="fondo" onUnload='javascript:descarga();'>
<TABLE WIDTH='751' BORDER='0' align="center" CELLPADDING='0' CELLSPACING='0'>
<tr>
	<td align='center' colspan='3' valign="top">
	<!--#include virtual="/menusup.asp"-->
	</td>
</tr>
<tr class='fondoclaro'><td colspan='3'><img src="/img/transparente.gif" width='750' height="10"></td></tr>
<tr>
	<td align='center' colspan='3' valign="top" class='fondoclaro'>
		<table border='0' cellspacing="0" cellpadding="0" align='center' class='fondocabe'>
		<tr>
			<td align='left' valign="top">
				<form name='f2' method="post">
				<table border='0' cellspacing="0" cellpadding="0" align='left'>
				<tr><td align='left'><img src="/img/camita.gif" width='42' height="31" align="middle">
				<b><%=ap("disponibilidad")%></b></td></tr>
				<tr><td align='center'>
				<!--#include virtual="/disponibilidad.asp"-->
				</td></tr>
				</table>
				</form>
			</td>
			<td width='5'><img src="/img/transparente.gif" width="5" height="5"></td>
			<td align='center' valign="top" rowspan='2'><!--#include virtual="/fotocabecera.asp"--></td>
		</tr>
		<tr>
			<td align='left' valign="bottom"><img src="/img/bordeInfIzq.gif" width="19" height="24"></td>
			<td width='5'><img src="/img/transparente.gif" width="5" height="5"></td>
		</tr>
		</table>
	</td>
</tr>
<tr class='fondoclaro'><td colspan='3'><img src='/img/transparente.gif' width='750' height="5"></td></tr>
<tr class='fondoclaro'>
	<td align='center' valign="top">
	<!--#include virtual="/includes/idiomas.asp"--></td>
	<td width='5'><img src="/img/transparente.gif" width="5" height="5"></td>
	<td align='left' valign='bottom' class='fondocabe'>
		<table border='0' cellpadding="0" cellspacing="0">
		<tr>
		<td align='left' width='19'><img src="/img/bordenoticiasIzq.gif" width="19" height="18"></td>
		<td align='left' width='438'><!--#include virtual="/noticias.asp"--></td>
		<td align='left' width='16'><img src="/img/bordenoticiasDer.gif" width="16" height="18"></td>
		</tr>
		</table>
	</td>
</tr>
<tr><td colspan='3' bgcolor="#FFFFFF"><img src="/img/transparente.gif" width='750' height="5"></td></tr>
<tr>
	<td align='center' valign="top" width="273" class='fondoizq'>
		<!--#include virtual="/menuizq.asp"-->
		<img src="/img/transparente.gif" width='273' height="5"><br>
		<!--#include virtual="/contacto.asp"-->
		<img src="/img/transparente.gif" width='273' height="5"><br>
		<!--#include virtual="/newsletter.asp"-->
	</td>
	<td width='5' class='fondocontenido'><img src="/img/transparente.gif" width='5' height="5"></td>
	<td align='center' valign="top" width='473' class='fondocontenido'>
	<!-- DATOS DE CONTENIDO -->	
	
	<table border='0' width='473' align='center' cellspacing="0" cellpadding="0" class='fondolista1'>
	<tr>
		<td align='left' width='18'><img src="/img/SupIzqDatos.gif" width='18' height="37"></td>
		<td align='left' width='437' class='fondolista1'>
		<img src="/hoteles/img/logofirst.gif" width='36' height="36" align="middle">
		<span style="font-size:14px">&nbsp;<%=ucase(nhotel)%></span>
			<%'Buscar tipo categoria
			if haycate then
				for c=0 to ubound(RegCate,2)
					if RegCate(CaCodi,c)=categoria then 'Es esta
						tipoc="estrella.gif"
						if RegCate(CaTipo,c)=Llave then tipoc="llave.gif"
						numero=clng("0" & left(RegCate(CaNombre,c),1))
						for nu=1 to numero%>
							<img src="/img/<%=tipoc%>">
						<%next 
					end if
				next 'categoria
			end if%>
		</td>
		<td align='right' width='18'><img src="/img/SupDerDatos.gif" width='18' height="37"></td>
	</tr>
	</table>
	<table border='0' align='center' cellspacing="0" cellpadding="0" class='fondolista1'>
	<tr>
		<td align='left'><img src="/img/SupIzqListaInterior.gif" width='20' height="9"></td>
		<td align='center' height='9' class='fondocabelista'><img src="/img/transparente.gif" width='433' height="9"></td>
		<td align='right'><img src="/img/SupDerListaInterior.gif" width='20' height="9"></td>
	</tr>
	</table>
	<table border='0' width='473' align='center' cellspacing="0" cellpadding="0" class='fondolista1'>
	<tr>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
		<td align='left' class='fondocabelista' width='463'>
		<a href='<%=session("paganterior")%>' class='fondocabelista'>&nbsp;&lt;&lt;&nbsp;<%=ap("volver")%></a></td>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
	</tr>
	<tr><td colspan='3'><img src="/img/transparente.gif" width='473' height="2"></td></tr>
	<tr>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
		<td align='left' width='463'>
			<table border="0" cellpadding="0" cellspacing="0" class='fondocabelista'>
			<tr>
			<td align="center" valign="top">
			<a href='<%=MiPag%>?ficha=1' onclick='javascript:quePagina(this);' class='textobold'><img id='op1' src="/hoteles/img/palmera.gif" width='29' height="28" border="0" onmouseover="javascript:cambio('',this,1);" onMouseOut="javascript:cambio('/hoteles/img/palmera.gif',this,1);"><br>
			<%=ap("situacion")%></a></td>
			<td><img src="/hoteles/img/separador.gif" width='2' height="55" border="0"></td>
			<td align="center" valign="top">
			<a href='<%=MiPag%>?ficha=2' onclick='javascript:quePagina(this);' class='textobold'><img id='op2' src="/hoteles/img/cama.gif" width='38' height="28" border="0" onmouseover="javascript:cambio('',this,2);" onMouseOut="javascript:cambio('/hoteles/img/cama.gif',this,2);"><br>
			<%=ap("servicios")%></a></td>
			<td><img src="/hoteles/img/separador.gif" width='2' height="55" border="0"></td>
			<td align="center" valign="top">
			<a href='<%=MiPag%>?ficha=3' onclick='javascript:quePagina(this);' class='textobold'><img id='op3' src="/hoteles/img/oferta.gif" width='36' height="28" border="0" onmouseover="javascript:cambio('',this,3);" onMouseOut="javascript:cambio('/hoteles/img/oferta.gif',this,3);"><br>
			<%=ap("ofertas")%></a></td>
			<td><img src="/hoteles/img/separador.gif" width='2' height="55" border="0"></td>
			<td align="center" valign="top">
			<a href='<%=MiPag%>?ficha=4' onclick='javascript:quePagina(this);' class='textobold'><img id='op4' src="/hoteles/img/precio.gif" width='33' height="28" border="0" onmouseover="javascript:cambio('',this,4);" onMouseOut="javascript:cambio('/hoteles/img/precio.gif',this,4);"><br>
			<%=ap("vertarifa")%></a></td>
			<td><img src="/hoteles/img/separador.gif" width='2' height="55" border="0"></td>
			<td align="center" valign="top">
			<a href='<%=MiPag%>?ficha=5' onclick='javascript:quePagina(this);' class='textobold'><img id='op5' src="/hoteles/img/camara.gif" width='36' height="28" border="0" onmouseover="javascript:cambio('',this,5);" onMouseOut="javascript:cambio('/hoteles/img/camara.gif',this,5);"><br>
			<%=ap("fotos")%></a></td>
			<td><img src="/hoteles/img/separador.gif" width='2' height="55" border="0"></td>
			<td align='right' class='fondocabelista' width='281'>
			<%if estado<>0 then%>
				<div align='center' id='texto'  class="botonreserva"><br>
			<%if estado=onrequest then
					enlazar="/reservas/front-end/Formulario.asp?est=" & est & "&lang=" & lang
				else
					enlazar="/reservas/front-end/elegirForma.asp?est=" & est & "&lang=" & lang
				end if%>
				<a href='<%=enlazar%>' class='reserva'><%=ap("reservas")%></a></div>
			<%end if%></td>
			</tr>
			</table>
		</td>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
	</tr>
	<tr><td colspan='3'><img src="/img/transparente.gif" width='473' height="2"></td></tr>
	</table>
	
	<table border='0' width='473' align='center' cellspacing="0" cellpadding="0" class='fondolista1'>
	<tr>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
		<td align='left' class='textoficha' width='463'>
		<!--PROCESO-->
		<%select case ficha
			case 1,2 'Situacion y servicios%>
				<table class="textoficha" border='0' cellspacing="2" cellpadding="0" width='463'>
				<tr><td colspan='2' height='2'></td></tr>
				<tr>
				<%if foto1="" and foto2="" then
					response.write "<td colspan='2' align='left' valign='top'>" & vbcrlf
					response.write texto & vbcrlf
					response.write "</td>"
				end if
				if foto2="" and foto1<>"" then
					response.write "<td width='200'><img src='" & rutafotos & "Ficha_" & foto1 & "' vspace='2' onclick=" & chr(34) & "javascript:popImage('" & rutafotos & foto1 & "','" & ucase(nhotel) & " FIRSTSUNMALLORCA');" & chr(34) & " style='cursor:pointer'></td>" & vbcrlf
					response.write "<td align='justify' valign='top'>" & texto & "</td>" & vbcrlf
				end if
				if foto1="" and foto2<>"" then
					response.write "<td width='200'><img src='" & rutafotos & "Ficha_" & foto2 & "' vspace='2' onclick=" & chr(34) & "javascript:popImage('" & rutafotos & foto2 & "','" & ucase(nhotel) & " FIRSTSUNMALLORCA');" & chr(34) & " style='cursor:pointer'></td>" & vbcrlf
					response.write "<td align='justify' valign='top'>" & texto & "</td>" & vbcrlf
				end if
				if foto1<>"" and foto2<>"" then 'con dos fotos
					response.write "<td width='200'><img src='" & rutafotos & "Ficha_" & foto1 & "' vspace='2' onclick=" & chr(34) & "javascript:popImage('" & rutafotos & foto1 & "','" & ucase(nhotel) & " FIRSTSUNMALLORCA');" & chr(34) & " style='cursor:pointer'></td>" & vbcrlf
					response.write "<td align='justify' rowspan='2' valign='top'>" & texto & "</td>" & vbcrlf
					response.write "<tr><td width='200'><img src='" & rutafotos & "Ficha_" & foto2 & "' onclick=" & chr(34) & "javascript:popImage('" & rutafotos & foto2 & "','" & ucase(nhotel) & " FIRSTSUNMALLORCA');" & chr(34) & " style='cursor:pointer'></td>" & vbcrlf
				end if%>
				</tr>
				<tr><td colspan='2' height='5'></td></tr>
				</table>

			<%case 3 'Ofertas%>
				<table class="textoficha" border='0' cellspacing="4" cellpadding="0" width='463'>
				<tr><td height='2'></td></tr>
				<tr><td width='463' align='justify' valign="top">
					<%if hayoferta then
						for o=0 to ubound(RegOferta,2)%>
						-&nbsp;<%=saltoLinea(RegOferta(OTexto,o))%><br><br>
						<%next
					else
						response.write ap("noofertas") & "<br><br>"
					end if%>
					</td>
				</tr>
				<tr><td height='5'></td></tr>
				</table>

			<%case 4 'Tarifa Precios%>
				<table class="textoficha" border='0' cellspacing="0" cellpadding="0" width='463'>
				<tr><td height='2'></td></tr>
				<tr><td width='463' align='center' valign="top">
					<div style='width:458; text-align:justify'>
					<%=ap("diasminimos") & nochesminimas & "."%><br>
					<%=prepago & ap("anticipo")%><br>
					<%=ap("plazoanular1") & diasanulacion & ap("plazoanular2")%>
					</div>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr><td align='center' valign='top'>
				<!-- precios -->
					<br>
					<b><%=ucase(ap("preciohabita"))%></b>
					<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class='textoficha'>
					  <%'Precios Habitacion%>
					  <tr>
						<td align="left" class='fondocabelista'><b><%=ap("fechas")%></b></td>
						<td align="left" class='fondocabelista'><b><%=ap("tipohab")%></b></td>
						<td align="right" class='fondocabelista'><b><%=ap("precio")%></b></td>
					  </tr>
					  <% 'Temporadas
					  if haytempos then
					  for t=0 to ubound(RegTempos,2)
						if (t mod 2)=0 then
							fila="filapar2"
						else
							fila="filaimpar2"
						end if
						%>
						  <tr class='<%=fila%>'>
						  <td align='left' class='<%=fila%>' rowspan='<%=filashabi%>'><%=VerFecha(Regtempos(TFIni,t))%> - <%=VerFecha(regTempos(TFFin,t))%></td>
						  
						<%
						for h=0 to ubound(RegPvpHabi,2)%>
						 <td align='left' class='<%=fila%>'>
							<%if RegPvpHabi(HPvpTempo,h)=RegTempos(TCodi,t) then
								response.write RegPvpHabi(HPvpNombre,h) & "<br>" & vbcrlf
							end if%>
						</td>
						 <td align='right' class='<%=fila%>'>
							<%if RegPvpHabi(HPvpTempo,h)=RegTempos(TCodi,t) then
								response.write formatnumber(RegPvpHabi(HPvpPrecio,h),2) & " &euro; "
								if RegPvpHabi(HPvpPorhab,h)=true then 'Precio por hab
									response.write ap("xhabi") & "<br>" & vbcrlf
								else
									response.write ap("xpersona") & "<br>" & vbcrlf
								end if
							end if%>
						</td>
						</tr><tr>
						<%next 'h%>
						</tr>
					  <%next 'fin de tempo
					 end if%>
					</table>
					<br>
					
					<%if haydtocolec then 'Dtos Habitacion%>
						<b><%=ucase(ap("dtocamasuple"))%></b>
						<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class='textoficha'>
					  <tr>
						<td align="left" class='fondocabelista'><b><%=ap("fechas")%></b></td>
						<td align="left" class='fondocabelista'><b><%=ap("tipohab")%></b></td>
						<td align="center" class='fondocabelista'><b><%=ap("dtos")%></b></td>
					  </tr>
					<%for cc=0 to ubound(RegDtoColec,2)
							if (cc mod 2)=0 then
								fila="filapar2"
							else
								fila="filaimpar2"
							end if
						%>
					  <tr class='<%=fila%>'>
					  <%
					  if RegDtoColec(CDtoTempo,cc)=0 then 'Cualquier temporada %>
					  	<td align='left' class='<%=fila%>'><%=ap("cualquiera")%></td>
					<%else 'Buscar la temporada
					  if haytempos then
						  for t=0 to ubound(RegTempos,2)
						  	if RegTempos(TCodi,T)=RegDtoColec(CDtoTempo,cc) then%>
							  <td align='left' class='<%=fila%>'><%=VerFecha(Regtempos(TFIni,t))%> - <%=VerFecha(regTempos(TFFin,t))%></td>
							 <%end if
							next
						end if
					end if%>
						 <td align='left' class='<%=fila%>'>
							<%=RegDtoColec(CDtoNHabi,cc)%>
						</td>
						 <td align='right' class='<%=fila%>'>
						 	<%'Valores anteriores
							antetempo=RegDtoColec(CDtoTempo,cc)
							antehabi=RegDtoColec(CDtoHabi,cc)
							do while cc<=Ubound(RegDtoColec,2)
								if antetempo<>RegDtoColec(CDtoTempo,cc) or antehabi<>RegDtoColec(CDtoHabi,cc) then 'ha cambiado
									cc=cc-1
									exit do
								end if
								'buscar nombre de colectivo
								for c=0 to ubound(RegColec,2)
									if RegColec(CCodi,c)=RegDtoColec(CDtoCodi,cc) then
										response.write RegColec(CNombre,c) & ": "
									end if
								next 'c
								response.write RegDtoColec(CDtoValor,cc) & " %<br>"
								cc=cc+1
							loop%>
						</td>
						</tr>
					  <%next 'cc (dtos colec)%>
					 </table>
					 <%end if 'hay dtos colec%>
					<br>
					<%if haysuples then 'Suplementos%>
						<b><%=ucase(ap("suple"))%></b>
						<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" class='textoficha'>
					  <tr>
					  	<td align="left" class='fondocabelista'><b><%=ap("Suplemento")%></b></td>
						<td align="left" class='fondocabelista'><b><%=ap("fechas")%></b></td>
						<td align="left" class='fondocabelista'><b><%=ap("tipohab")%></b></td>
						<td align="center" class='fondocabelista'><b><%=ap("precio")%></b></td>
					  </tr>
					<%for s=0 to ubound(RegSuples,2)
							if (s mod 2)=0 then
								fila="filapar2"
							else
								fila="filaimpar2"
							end if
						'Comprobar si tiene temporada
						if RegSuples(STempo,s)<>0 then 'Buscar la temporada
							htempo=false
						  if haytempos then
							  for t=0 to ubound(RegTempos,2)
								if RegTempos(TCodi,T)=RegSuples(STempo,s) then
									 htempo=true
									 latempo=VerFecha(Regtempos(TFIni,t)) & " - " & VerFecha(regTempos(TFFin,t))
								end if
								next
							end if
						else 
							htempo=true
						end if
					if htempo then 'Poner linea%>
					  <tr class='<%=fila%>'>
					  <td align='left' class='<%=fila%>'><%=RegSuples(SNombre,s)%></td>
					  <%
					  if RegSuples(STempo,s)=0 then 'Cualquier temporada %>
					  	<td align='left' class='<%=fila%>'><%=ap("cualquiera")%></td>
						<%else 'Buscar la temporada%>
					  <td align='left' class='<%=fila%>'><%=latempo%></td>
					 <%end if%>
						 <td align='left' class='<%=fila%>'>
						 <%if RegSuples(SHabi,s)=0 then
						 	response.write ap("cualquiera")
						else 'busca tipo habitacion
						 for h=0 to ubound(RegPvpHabi,2)
								if RegPvpHabi(HPvpCodi,h)=RegSuples(SHabi,s) then
									response.write RegPvpHabi(HPvpNombre,h)
									exit for
								end if
							next
						end if%>
						</td>
						 <td align='right' class='<%=fila%>'>
						 	<%=RegSuples(SPrecio,s) & "&euro;"%>
						</td>
						</tr>
						<%end if
					  next 's (suplementos)%>
					 </table>
					 <%end if 'hay suples%>
				
				<!-- fin precios -->
				<img src="/img/transparente.gif" width='400' height='20'><br>
				</td></tr>
				<tr><td height='5'></td></tr>
				</table>

			<%case 5 'Galeria fotos%>
				<table class="textoficha" border='0' cellspacing="0" cellpadding="0" width='463'>
				<tr><td colspan='2' height='2'></td></tr>
				<tr><td width='80' align='left' valign="top">
					<!-- Galeria -->
					<table border='0' cellpadding="0" cellspacing="0" align='center' width="100%">
					<tr>
						<%son=0
						for f=1 to 10
							if foto(f)<>"" then 'poner la fotico 
								if primera="" then primera=foto(f) 'Pone la primera foto
								son=son+1%>
								<td align='center' width='40'>
								<a href="javascript:ponerFoto('<%=rutafotos & foto(f)%>');">
								<img src="<%=rutafotos & "Th_" & foto(f)%>" width='39' height="39" border='0'></a>
								</td>
								<%if son=2 then
									son=0
									response.write "</tr><tr><td colspan='2' height='1'></td><tr>"
								end if
							end if
						next%>
					</tr>
					</table>
					<!--FIN GALERIA-->
					</td>
					<td align='center' width='383' valign="top">
					<!-- La foto -->
					<img id='fotogrande' src="<%=rutafotos & primera%>">
					</td>
				</tr>
				<tr><td colspan='2' height='5'></td></tr>
				</table>
				
		<%end select%>
		
		<!--FIN PROCESO-->
		</td>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
	</tr>
	<tr>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
		<td width='463' class='fondolista1'><img src="/img/transparente.gif" width="463" height="5">		</td>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
	</tr>
	<tr>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
		<td width='463' class='fondolista1'>
			<img src="/img/transparente.gif" width="312" height="38" align='left'>
			<!--
			<table border='0' cellpadding="0" cellspacing="0">
			<tr><td align='center' valign="middle" class="botonreserva">
			<a href='/reservas/front-end/elegirForma.asp?est=<%=est%>&lang=<%=lang%>' class='reserva'><%=ap("reservas")%></a>
			</td></tr></table>-->
		</td>
		<td width='5' class='fondolista1'><img src="/img/transparente.gif" width="5" height="2"></td>
	</tr>
	</table>
	<table border='0' align='center' cellspacing="0" cellpadding="0" class='fondolista1'>
	<tr>
		<td align='left'><img src="/img/InfIzqListado.gif" width='14' height="13"></td>
		<td align='center'><img src="/img/transparente.gif" width='445' height="13"></td>
		<td align='right'><img src="/img/InfDerListado.gif" width='14' height="13"></td>
	</tr>
	</table>


	<!-- FIN CONTENIDO -->
	</td>
</tr>
</table>
<script language="javascript">
<%
sv=clng("0" & request.QueryString("sv"))
if sv<>0 then%>
	document.body.scrollTop=<%=sv%>;
<%end if%>
//Poner el texto de la ficha seleccionada
//document.getElementById('texto').innerHTML=textoOpcion[<%=ficha%>];
//Poner la imagen de la ficha seleccionada
document.getElementById('op<%=ficha%>').src=marcaOpcion[<%=ficha%>];

</script>
</BODY>
</HTML>