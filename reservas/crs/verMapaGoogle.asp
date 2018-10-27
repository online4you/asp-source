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
dim TIdiomas() 'texto traduccion

'Datos del hotel
cs="SELECT Nombre,Direccion,CP,Poblacion "
cs=cs & "FROM " & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "DatosHotel DatosHotel "
cs=cs & "ON Establecimientos.CodigoEsta=DatosHotel.CodigoEsta "
cs=cs & "WHERE Establecimientos.CodigoEsta=" & laid
rs.open cs,base
if not rs.eof then
	nombreHotel=rs("nombre")
	direHotel=rs("direccion")
	cpHotel=rs("cp")
	poblaHotel=rs("poblacion")
	
	localizacionHotel=direHotel & " " & cpHotel & " " & poblaHotel
end if
rs.close

if request.form<>"" then
	laX=quitarComa(request.form("laX"))
	laY=quitarComa(request.form("laY"))
	zoom=paClng(request.form("zoom"))
	texto=quitarApos(request.form("texto_" & langPorDefecto))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi

	
	cs="SELECT Id FROM " & precrs & "GMapsHotel WHERE CodigoEsta=" & laid
	rs.open cs,base
	hayGmap=false
	if not rs.eof then
		hayGmap=true
		GMid=rs("id")
	end if
	rs.close
	if hayGmap then
		on error resume next
		base.BeginTrans
			
		cs="UPDATE " & precrs & "GMapsHotel SET laX=" & laX & ","
		cs=cs & "laY=" & laY & ","
		cs=cs & "Texto='" & texto & "',"
		cs=cs & "Zoom=" & zoom & " "
		cs=cs & "WHERE Id=" & GMid
		'response.write cs
		base.execute cs
		
		'Actu traduccion
		for idi=1 to ubound(ListaIdiomas)
			if TIdiomas(idi)<>"" then 'buscar si existe
				cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='GMapsHotel' AND Campo='Texto' AND "
				cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & GMid
				rs.open cs,base
				if not rs.eof then
					cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
					cs=cs & "WHERE Id=" & rs("id")
					base.execute cs
				
				else
					cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
					cs=cs & GMId & ",'" & listaIdiomas(idi) & "','GMapsHotel','Texto','"
					cs=cs & TIdiomas(idi) & "')"
					base.execute cs
				end if 'eof
				rs.close
			else 'borrarlo si esta en blanco
				
				cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='GMapsHotel' AND Campo='Texto' "
				cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & GMId
				base.execute cs
				
			end if
		next 'idi
		
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0

		
		
	else
	
		on error resume next
		base.BeginTrans
		
		cs="INSERT INTO " & precrs & "GmapsHotel (CodigoEsta,LaX,LaY,Zoom,Texto,Icono) VALUES("
		cs=cs & laid & "," & laX & "," & laY & "," & zoom & ",'" & texto & "','')" 
		'response.write cs
		base.execute cs
		
		cs="SELECT MAX(Id) as Ulti FROM " & precrs & "GmapsHotel"
		rs.open cs,base
		if not rs.eof then
			MiId=rs("Ulti")
		end if
		rs.close
		
		'Añadir traducciones
		for idi=1 to ubound(ListaIdiomas)
			if TIdiomas(idi)<>"" then 'crear registro
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
				cs=cs & MiId & ",'" & listaIdiomas(idi) & "','GmapsHotel','Texto','"
				cs=cs & TIdiomas(idi) & "')"
				base.execute cs
				'response.write cs & "<br>"
			end if
		next 'idi
		
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0	
		
	end if
end if

redim TIdiomas(ubound(ListaIdiomas))
cs="SELECT GMapsHotel.Id,laX,laY,Zoom,Texto,Icono,Idioma,Traduccion "
cs=cs & "FROM " & precrs & "GMapsHotel GMapsHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON GMapsHotel.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='GMapsHotel' AND Campo='Texto' WHERE GMapsHotel.CodigoEsta=" & laid
rs.open cs,base
hayGpunto=false
do while not rs.eof
	hayGpunto=true
	GMid=rs("id")
	GMx=rs("laX")
	GMy=rs("laY")
	Zoom=rs("zoom")
	Texto=rs("texto")
	Icono=rs("Icono")
	TIdiomas(0)=rs("texto")
	for idi=1 to ubound(ListaIdiomas)
		if ListaIdiomas(idi)=rs("idioma") then 'este
			TIdiomas(idi)=rs("traduccion")
			exit for
		end if
	next 'idi
	
	rs.movenext
loop
rs.close
	
if hayGpunto then
	x=quitarComa(GMx)
	y=quitarComa(GMy)
else
	'buscar posicion por defecto en la zona del hotel
	cs="SELECT PosTop,PosLeft,Zoom FROM " & precrs & "Zonas Zonas INNER JOIN " & precrs & "DatosHotel DatosHotel "
	cs=cs & "ON Zonas.Id=DatosHotel.Zona WHERE CodigoEsta=" & laid
	rs.open cs,base
	if not rs.eof then
		if rs("posTop")<>0 then
			xDefaultMaps=rs("posTop")
			yDefaultMaps=rs("posLeft")
			zoomDefaultMaps=rs("zoom")
		end if
	end if
	rs.close
	
	x=quitarComa(xDefaultMaps)
	y=quitarComa(yDefaultMaps)
	zoom=zoomDefaultMaps
end if
if paClng(zoom)=0 then zoom=10

'calcula ancho del textarea
maxAncho=960 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>2 then 'hay mas de cuatro y sólo pongo 4 idiomas por fila
	anchoColu=paClng(anchoDispo/4)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
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
<%if pasalir=1 then%>
	cerrar();
<%end if%>

function Modificar(){
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&idh=<%=laid%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&idh=<%=laid%>";

	document.f1.submit();
}

</script>
<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=<%=key_googlemap%>" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    //<![CDATA[
	var zoom;
	var center;
	var baseIcon;
	var rectIcon;
	var wheelZooming;
	var marker;

    function doLoad() {
      if (GBrowserIsCompatible()) {
		//variables
		zoom = <%=zoom%>;
		center = new GLatLng(<%=x%>,<%=y%>);
		baseIcon = new GIcon();
		baseIcon.iconSize=new GSize(100,100);
		baseIcon.iconAnchor=new GPoint(50,50);
		rectIcon = new GIcon(baseIcon);
		rectIcon.image="img/target.png"
		wheelZooming = false;
		marker;
		  
	  	container = document.getElementById("mapa");
 		map = new GMap2(container, {draggableCursor:"crosshair"});
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		GEvent.addListener(map, 'mousemove', mouseMove);
		GEvent.addListener(map, "moveend", moveEnd);
		GEvent.addListener(map, "zoomend", zoomEnd);
        map.setCenter(center, zoom);
		map.addControl(new GOverviewMapControl());
		marker = new GMarker(center, {draggable: true});
        GEvent.addListener(marker, "dragstart", function() {
        map.closeInfoWindow();
        });

        GEvent.addListener(marker, "dragend", function() {
		eso=marker.getPoint();
		  eso=eso.toString();
		  eso=eso.replace("(","");
		  eso=eso.replace(")","");
		  xy= eso.split(",");
          marker.openInfoWindowHtml("<font size='2'>Coloque el marcador donde quiera situar su establecimiento...<br><center>coord x:"+xy[0]+"<br>coord y:"+xy[1]+"</font></center>");
		  	document.getElementById("laX").value=xy[0];
			document.getElementById("laY").value=xy[1];
        });
        map.addOverlay(marker);
		map.enableDoubleClickZoom(); 
		map.enableContinuousZoom();
		GEvent.addDomListener(container, "DOMMouseScroll", wheelZoom);
		GEvent.addDomListener(container, "mousewheel", wheelZoom); 
		
		geocoder = new GClientGeocoder();
      }
    }
	
	function buscaDireccion() {
		dire=document.f1.localizacion.value;
		geocoder.getLocations(dire, addAddressToMap);  
	}
	
	function addAddressToMap(response) {  
		if (!response || response.Status.code != 200) {  
			alert("Lo sentimos, no se ha encontrado su direcci&ocute;n");  
		} else {  
			//map.clearOverlays();  
			place = response.Placemark[0];  
			point = new GLatLng(place.Point.coordinates[1], place.Point.coordinates[0]);   
			document.f1.laX.value=place.Point.coordinates[1];
			document.f1.laY.value=place.Point.coordinates[0];
			map.setCenter(point, 15);  
			marker.setLatLng(point);
			/*marker = new GMarker(point);  
			map.addOverlay(marker);  
			marker.openInfoWindowHtml(place.address);  
			document.getElementById("punto").value = marker.getLatLng().toUrlValue();  
			generateKML(place.address, place.Point.coordinates[0], place.Point.coordinates[1]);  */
		}  
	}  
	
function wheelZoom(event) {
	if (wheelZooming) {
		return;
	}
	wheelZooming = true;
	zoomRect = new GMarker(mouseLatLng,{icon:rectIcon});
	map.addOverlay(zoomRect);
	if (event.cancelable) {
		event.preventDefault();
	}
	map.closeInfoWindow(); 

	if((event.detail || -event.wheelDelta) < 0) {
		window.setTimeout(function(){
			map.removeOverlay(zoomRect);
			map.zoomIn(mouseLatLng,true,true);
			wheelZooming = false;
		},200);
	} 
	else {
		window.setTimeout(function(){
			map.removeOverlay(zoomRect);
			map.zoomOut(mouseLatLng,true);
			wheelZooming = false;
		},200);
	}
	return false; 
}
function moveEnd() {
	updateStatusBar();
}

function zoomEnd(oldZ,zoom) {
	updateStatusBar();
}


function updateStatusBar() {
	var center = map.getCenter();
	var zoom = map.getZoom();
	document.getElementById("zoom").value=zoom;
	var bounds = map.getBounds();
	var SW = bounds.getSouthWest();
	var NE = bounds.getNorthEast();
}



function mouseMove(mousePt) {
	mouseLatLng = mousePt;
	var zoom = map.getZoom();
}

//]]>
function centra() {
	map.setCenter(center, zoom);
}
window.addEvent('load',doLoad);
</script>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="post">
  	<div style="clear:both; height:280px;">
		<div id="mapa" name="mapa" style="width:600px; height:280px; border:1px solid #666666; float:left"></div>
		<div style='text-align:center; float:left; margin-left:10px;'><!--div xy-->
			coordenada x <br/>
			<input id='laX' name='laX' type='text' style='width:120px' value='<%=x%>'>
			<br/><br/>
			coordenada y <br/>
			<input id='laY' name='laY' type='text' style='width:120px' value='<%=y%>'>
			<br/><br/>
			Zoom:<br/>
			<input id='zoom' name='zoom' type='text' style='width:120px' value='<%=zoom%>'>

            <div style="clear:both; margin-top:20px;">
            <%=objIdioma.getTraduccionHTML("i_localizacionhotel")%>:<br/>
            <input id='localizacion' name='localizacion' type='text' style='width:200px' value='<%=localizacionHotel%>'>
            <br>
            <input type="button" value="Buscar posición según dirección Hotel" onClick="javascript:buscaDireccion();" class="boton200">
            </div>
		</div><!--div xy-->
	</div>
	<div style='height:auto; margin-top:10px; clear:both'><!--div de campos-->
        <table align='center' width='<%=anchoDispo%>' border='0' cellpadding="0" cellspacing="2">
        <%
        colu=1
        maxColu=4
        for idi=0 to ubound(listaIdiomas)%>
            <td align='left'>
            <%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_<%=listaIdiomas(idi)%>',680,420);"><br/>   
            <textarea name="texto_<%=listaIdiomas(idi)%>" id='texto_<%=listaIdiomas(idi)%>' style="width:<%=anchoColu%>px; height:70px;"><%=TIdiomas(Idi)%></textarea>      
            </td>
            <%colu=colu+1
            if colu>maxColu then
                response.write "</tr><tr>"
                colu=1
            end if
        next 'idi%>
        </tr>
       </table>
	</div><!--fin div de campos-->
	<center><input type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' class='boton86' onclick='javascript:Modificar()'>
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="id" value="<%=laid%>">
		<input type='button' value='<%=objIdioma.getTraduccionHTML("i_cerrar")%>' class='boton86' onclick='javascript:cerrar()'>
	</center>
</form>
<script type="text/javascript">
	alto=self.document.body.offsetHeight;
	parent.document.getElementById('contenidoNew').style.height=alto+10+"px";
	//alert(parent.document.getElementById('contenidoNew').offsetHeight);
	altoFrame=parent.document.body.offsetHeight;
	top.document.getElementById(parent.name).style.height=altoFrame+10+"px";
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>