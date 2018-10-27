<!--#include file="connections/FunGestionNE.asp"-->
<!--#include file="connections/lang.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")
lang=request.QueryString("lang")
if lang="" then lang="es"
cs="Select id,coordx,coordy,texto_" & lang & " as texto from " & precrs & "Gmaps WHERE idest=" & clng("" & est)
rs.open cs,base
hayGpunto=false
if not rs.eof then
	hayGpunto=true
	GMid=rs("id")
	GMx=rs("coordx")
	GMy=rs("coordy")
	GMtexto=rs("texto")
end if
rs.close
if hayGpunto then
	x=GMx
	y=GMy
else
	x="39.6437675734185"
	y= "2.92236328125"
end if
cs="SELECT nombre,direccion,poblacion FROM (" & precrs & "Establecimientos establecimientos left JOIN " & precrs & "DatosHotel datosHotel ON establecimientos.codigoesta=datosHotel.codigoesta) WHERE establecimientos.codigoEsta=" & clng("" & est)
'response.write cs

rs.open cs,base
haydatos=false
if not rs.eof then 
	haydatos=true
	hnombre=rs("nombre")
	hdir=rs("direccion")
	hpob=rs("poblacion")
end if
rs.close
dir=ap("direccion")
pob=ap("localidad")

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Google Maps JavaScript API Example</title>
	
     <script id="google_script" src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAA61ykho4SfNoarNe--jnihRS1E7B4JNwVybn0-U7k3Cp9mPiDehSy1QBp2-edmA2rYH4QcVMA371TUQ" type="text/javascript"></script>

    <script type="text/javascript">
    //<![CDATA[
	var zoom = 10;
	var center = new GLatLng(<%=x%>,<%=y%>);
	var baseIconNE = new GIcon();
	baseIconNE.iconSize=new GSize(100,100);
	baseIconNE.iconAnchor=new GPoint(50,50);
	var rectIcon = new GIcon(baseIconNE);
	rectIcon.image="http://www.planetaweb.es/reservas/saintmichel/img/target.png"
	var wheelZooming = false;
	function load(){
	doLoad();
	container = document.getElementById("mapa");
	}
    function doLoad() {
      if (GBrowserIsCompatible()) {
	    container = document.getElementById("mapa");
 		map = new GMap2(container, {draggableCursor:"crosshair"});//hasta aki para el wm
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		map.addControl(new GOverviewMapControl());
		
		GEvent.addListener(map, 'mousemove', mouseMove);
		GEvent.addListener(map, "moveend", moveEnd);
		GEvent.addListener(map, "zoomend", zoomEnd);
		
        var center = new GLatLng(<%=x%>,<%=y%>);
		var ap= new GLatLng(39.55011817080809, 2.72735595703125);
		var pp=new GLatLng(39.5519381323617, 2.627749443054199);
		var pa=new GLatLng(39.83612393180558, 3.1418752670288086);
        map.setCenter(center, zoom);
		
				
		var IconA = new GIcon();
		IconA.shadow ='';
		IconA.iconSize = new GSize(24, 27);
		IconA.shadowSize = new GSize(37 , 34);
		IconA.iconAnchor = new GPoint(9, 34);
		IconA.infoWindowAnchor = new GPoint(20, 34);
		IconA.infoShadowAnchor = new GPoint(5, 1);
		var icon1 = new GIcon(IconA);
		icon1.image = "http://www.planetaweb.es/reservas/saintmichel/img/avion.png";
		
		
		var IconB = new GIcon();
		IconB.shadow ='';
		IconB.iconSize = new GSize(50, 50);
		IconB.iconAnchor = new GPoint(70, 20);
		var icon2 = new GIcon(IconB);
		icon2.image = "http://www.planetaweb.es/reservas/saintmichel/img/puerto.png";
		
		//map.addOverlay( new GMarker(pp,icon2));
		
		var markerManager = new GMarkerManager( map, { trackMarkers:true } );
        var markerNE = new GMarker( pa,icon2 );
		var markerNEpP=new GMarker(pp,icon2);
        markerManager.addMarker( markerNE, 13); 
		markerManager.addMarker(markerNEpP,13);
		
		var baseIcon = new GIcon();
		baseIcon.shadow ='';
		baseIcon.iconSize = new GSize(54, 39);
		baseIcon.shadowSize = new GSize(37 , 34);
		baseIcon.iconAnchor = new GPoint(27, 39);
		baseIcon.infoWindowAnchor = new GPoint(9, 0);
		baseIcon.infoShadowAnchor = new GPoint(5, 1);
		var icon = new GIcon(baseIcon);
		icon.image = "http://www.planetaweb.es/reservas/saintmichel/img/hsm.png";
		
		map.addOverlay( new GMarker(ap,icon1));
		
        var marker = new GMarker(center,icon);
		GEvent.addListener(marker, "click", function() {
          marker.openInfoWindowHtml("<%=GMtexto %>");
        });

        map.addOverlay(marker);
// Mouse wheel zoom - Attach event handlers -----
		map.enableDoubleClickZoom(); 
		map.enableContinuousZoom();
		GEvent.addDomListener(container, "DOMMouseScroll", wheelZoom);
		GEvent.addDomListener(container, "mousewheel", wheelZoom); 
		
// ----------------------------------------------
     }
    }
function wheelZoom(event) {
	if (wheelZooming) {
		return;
	}

	wheelZooming = true;

	// zoomRect and rectIcon are global variables!!!

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
// End event handler -----



// Nothing related to mouse wheel zoom below this line ---------------------------


function moveEnd() {
	updateStatusBar();
}

function zoomEnd(oldZ,zoom) {
	updateStatusBar();
}


function updateStatusBar() {
	var center = map.getCenter();
	var zoom = map.getZoom();

	var bounds = map.getBounds();
	var SW = bounds.getSouthWest();
	var NE = bounds.getNorthEast();

	//var oCoords = document.getElementById("coords");
	//oCoords.innerHTML = 'Map center: (' + center.y.toFixed(6) + ',' + center.x.toFixed(6) + ') - zoom: ' + zoom;
	//oCoords.innerHTML += '<br> ';
	//oCoords.innerHTML += 'SW: ' + SW.y.toFixed(6) + ', ' + SW.x.toFixed(6);
	//oCoords.innerHTML += '<br> ';
	//oCoords.innerHTML += 'NE: ' + NE.y.toFixed(6) + ', ' + NE.x.toFixed(6);

}





function mouseMove(mousePt) {
	mouseLatLng = mousePt;
	var zoom = map.getZoom();
	//var oStatusDiv = document.getElementById("mouseTrack")	
	//var mousePx = normalProj.fromLatLngToPixel(mousePt, zoom);
	//oStatusDiv.innerHTML = 'Mouse LatLng: ' + mousePt.y.toFixed(6) + ', ' + mousePt.x.toFixed(6) ;
	//oStatusDiv.innerHTML += '<br> ';
	//oStatusDiv.innerHTML += 'Mouse Px: ' + mousePx.x + ', ' + mousePx.y;
	//oStatusDiv.innerHTML += '<br>';
	//oStatusDiv.innerHTML += 'Tile: ' + Math.floor(mousePx.x / 256) + ', ' + Math.floor(mousePx.y / 256);
}
    //]]>
    </script>
  </head>

  <body style="margin:0" onLoad="load()" onUnload="GUnload()">
 	<div style='height:345px;width:653px;overflow:hidden'>
		<div id="mapa" style="width:653px; height: 345px;"></div>
		<div id="message" style='padding-top:20px'></div>
	</div>
  </body>
</html>
</html>
