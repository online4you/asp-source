<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Lista de hoteles de esta empresa
cs="SELECT Establecimientos.CodigoEsta,Nombre,Zona FROM Establecimientos "
cs=cs & "INNER JOIN DatosHotel ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta "
cs=cs & "WHERE Estado<>" & noventa
if buscoHoteles<>"" then cs=cs & " AND " & buscoHoteles
cs=cs & " ORDER BY Orde"
'response.write cs
rs.open cs,base
hayHoteles=false
if not rs.eof then
	RegHoteles=rs.getrows
	HCodi=0
	HNombre=1
	HZona=2
	hayHoteles=true
end if
rs.close

'lista zonas
cs="SELECT Zonas.Id,ISNULL(Traduccion,Zona) AS Tradu "
cs=cs & "FROM Zonas LEFT JOIN Traducciones "
cs=cs & "ON Zonas.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='Zonas' AND Campo='Zona' AND Idioma='" & lang & "'"
rs.open cs,base
hayZonas=false
if not rs.eof then
	RegZonas=rs.getrows
	ZCodi=0
	ZNombre=1
	hayZonas=true
end if
rs.close


'Buscar Tipos Alojamientos
cs="SELECT TipoAlojamiento.Id,IdTipo,ISNULL(Traduccion,Nombre) AS Tradu "
cs=cs & "FROM (TipoAlojamiento INNER JOIN DatosHotel "
cs=cs & "ON TipoAlojamiento.Id=DatosHotel.TipoAlojamiento) LEFT JOIN Traducciones "
cs=cs & "ON TipoAlojamiento.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoAlojamiento' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "GROUP BY TipoAlojamiento.Id,IdTipo,ISNULL(Traduccion,Nombre)"
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
cs="SELECT Categorias.Id,IdTipo,ISNULL(Traduccion,Nombre) AS Tradu "
cs=cs & "FROM Categorias LEFT JOIN Traducciones "
cs=cs & "ON Categorias.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='Categorias' AND Campo='Nombre' AND Idioma='" & lang & "'"
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

idh=paClng(request.QueryString("idh"))
if idh=0 then idh=paClng(request.Form("bhotel"))

idz=paClng(request.QueryString("idz"))
if idz=0 then idz=paClng(request.Form("bzona"))

nombreZona=objIdioma.getTraduccionHTML("i_todas")
if idz<>0 then
	if hayzonas then
	for z=0 to ubound(RegZonas,2)
		if RegZonas(ZCodi,z)=idz then
			nombreZona=RegZonas(ZNombre,z)
			exit for
		end if
	next
	end if 'hayzonas
end if 'idz<>0

tipoa=paClng(request.QueryString("ta"))
if tipoa=0 then tipoa=paClng(request.Form("btipo"))

nombreTipo=objIdioma.getTraduccionHTML("i_todos")
if tipoa<>0 then
	if haytipos then
	for z=0 to ubound(RegTipos,2)
		if RegTipos(TId,z)=tipoa then
			nombreTipo=RegTipos(TTradu,z)
			exit for
		end if
	next
	end if 'hayzonas
end if 'idz<>0



th=paClng(request.QueryString("th"))
if th=0 then th=paClng(request.Form("th"))

fini=request.QueryString("fini")
if fini="" then fini=request.form("fini")
if fini="" then fini=date()+1

ffin=request.QueryString("ffin")
if ffin="" then ffin=request.form("ffin")
if ffin="" then ffin=date()+2

fini=cdate(fini)
ffin=cdate(ffin)
noches=ffin-fini

adultos=paClng(request.QueryString("ad"))
if adultos=0 then adultos=paClng(request.form("ad"))
if adultos=0 then adultos=2 'por defecto

ninos=paClng(request.QueryString("ni"))
if ninos=0 then ninos=paClng(request.form("ni"))
plazas=adultos+ninos
bebes=paClng(request.QueryString("be"))
if bebes=0 then bebes=paClng(request.form("be"))



nombreHotel=objIdioma.getTraduccionHTML("i_todos")
if idh<>0 then 'estoy en un hotel
	'Buscar datos del hotel
	cs="SELECT Establecimientos.Nombre,Direccion,EMail,CP,Poblacion,Telefono,Fax,Foto,CodigoISO,URL "
	cs=cs & "FROM (Establecimientos INNER JOIN DatosHotel ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta) "
	cs=cs & "INNER JOIN TiposMoneda ON Establecimientos.Moneda=TiposMoneda.Id "
	cs=cs & "WHERE Establecimientos.CodigoEsta=" & idh
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		nombreHotel=nombre
		direccion=rs("direccion")
		email=rs("email")
		cp=rs("cp")
		poblacion=rs("poblacion")
		telefono=rs("telefono")
		fax=rs("fax")
		logohotel=rutaFotos & rs("foto")
		monedaHotel=rs("CodigoISO")
		monedaDefecto=rs("CodigoISO")
		laweb="" & rs("url")
		if laweb<>"" then 'comprobar que esté bien
			if instr(lcase(laweb),"http://")=0 then
				laweb="http://" & lcase(laweb)
			end if
		end if
	end if
	rs.close
end if 'idh<>0

'Ofertas destacadas
cs="SELECT Ofertas.Id,Ofertas.CodigoEsta,FechaInicio,FechaFin,ISNULL(Traduccion,Titulo) as Tradu "
cs=cs & "FROM Ofertas LEFT JOIN Traducciones "
cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND Campo='Titulo' "
cs=cs & "AND Idioma='" & lang & "' "
cs=cs & "WHERE Activa<>0 AND Caduca>=" & fechaSQLServer(date) & " AND Destacada<>0 AND CodigoPromocion='' "
cs=cs & " ORDER BY FechaInicio"
'response.write cs
rs.open cs, base
hayofertas=false
if not rs.eof then
	RegOfertas=rs.getrows
	OCodi=0
	OHotel=1
	OFIni=2
	OFFin=3
	OTitulo=4
	hayOfertas=true
end if
rs.close

'Caracteriscticas generales
cs="SELECT Caracteristicas.Id,ISNULL(Traduccion,Caracteristica) AS Tradu "
cs=cs & "FROM Caracteristicas LEFT JOIN Traducciones "
cs=cs & "ON Caracteristicas.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='Caracteristicas' AND Campo='Caracteristica' AND Idioma='" & lang & "' "
cs=cs & "WHERE Destacada<>0 ORDER BY Orden"
'response.write cs & "<br>"
rs.Open cs,base
hayCaracter=false
if not rs.eof then
	RegCaracter=rs.GetRows
	RcCodi=0
	RcNombre=1
	hayCaracter=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="includes/metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="js/eventosHome.js"></script>
</head>
<body>
<iframe name="paProcesos" id='paProcesos' class="capaIframe" frameborder="0"></iframe>
<input type="hidden" id='ide' name="ide" value="<%=idEmpresa%>" />
<input type="hidden" id='lang' name="lang" value="<%=lang%>" />
<div id='capaPrincipal'>
	<div id='capaCabecera'>
    	<!--#include file="cabecera.asp"-->
        <!--#include file="idiomas.asp"-->
    </div> <!--capaCabecera-->
    <div id='capaLateral'>
    	<!--#include file="buscador.asp"-->
        <%if es_IE then response.write "<br class='clear' />" & vbcrlf%>
        <!--#include file="ofertas.asp"-->
    </div> <!--capaLateral-->
    <div id='capaProceso'>
    	<%
		pr=request.QueryString("pr") 'proceso de reserva
		url="paso1.asp"
		query="?ide=" & idEmpresa & "&amp;idh=" & idh & "&amp;lang=" & lang
		select case pr
			case "paso1":url="paso1.asp" 'buscador de hoteles
			case "paso2":url="paso2.asp" 'habitaciones de ese hotel
			case "ficha":url="ficha.asp" 'ficha de un hotel
		end select
		'url=url & "?" & server.HTMLEncode(request.QueryString) 'paso los parametros que me han pasado
		
		'Coger todas las variables de la pagina anterior
		datos=split(request.form,"&")
		for v=0 to ubound(datos)
			'Separar nombre y valor
			camposC=split(datos(v),"=")
			nombreC=camposC(0)
			if instr(query,"&amp;" & nombreC & "=")=0 then 'no hay un campo con ese nombre
				valorC=request.form(nombreC)
				query=query & "&amp;" & nombreC & "=" & valorC
			end if
		next
		
		url=url & query
		%>
    	<iframe name="iframeContenido" id='iframeContenido' src="<%=url%>" frameborder="0"></iframe>
    </div> <!--capaProceso-->
    <div id='capaPie'>
    	<p>Kubik CRS ver 3.5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&copy;&nbsp;2009 Emarketing Planeta Web</p>
    </div> <!--capaPie-->
</div> <!-- principal -->
<%set objIdioma=nothing%>
</body>
</html>
