<!--#include file="includes/FunGestion.asp"-->
<!--#include file="Connections/Lang.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")
lax=request.QueryString("x")
lay=request.QueryString("y")
cs="Select id,coordx,coordy from " & precrs & "Gmaps WHERE idest=" & clng("" & est)
rs.open cs,base
hayGpunto=false
if not rs.eof then
	hayGpunto=true
	GMid=rs("id")
	GMx=rs("coordx")
	GMy=rs("coordy")
end if
rs.close
if hayGpunto then
	x=GMx
	y=GMy
else
	x="39.6437675734185"
	y= "2.92236328125"
end if

if lax<>"" then
	x=request.QueryString("x")
	y=request.QueryString("y")
	texto_es=quitarApos(request.QueryString("texto_es"))
	texto_en=quitarApos(request.QueryString("texto_en"))
	texto_de=quitarApos(request.QueryString("texto_de"))
	texto_fr=quitarApos(request.QueryString("texto_fr"))
	texto_it=quitarApos(request.QueryString("texto_it"))
	cs="Select id from Gmaps WHERE idest=" & clng("" & est)
	rs.open cs,base
	hayGmap=false
	if not rs.eof then
		hayGmap=true
		GMid=rs("id")
	end if
	rs.close
	if hayGmap then
		cs="update Gmaps set coordx='" & x & "',"
		cs=cs & "coordy='" & y & "',"
		cs=cs & "texto_es='" & texto_es & "',"
		cs=cs & "texto_en='" & texto_en & "',"
		cs=cs & "texto_de='" & texto_de & "',"
		cs=cs & "texto_it='" & texto_de & "',"
		cs=cs & "texto_fr='" & texto_de & "' "
		cs=cs & "WHERE id=" & GMid
		'response.write cs
		base.execute cs
	else
		cs="INSERT into " & precrs & "Gmaps(idest,coordx,coordy,texto_es,texto_en,texto_de,texto_fr,texto_it) VALUES("
		cs=cs & est & ",'" & x & "','" & y & "','" & texto_es & "','" & texto_en & "','" & texto_de & "','" & texto_fr & "','" & texto_it & "')" 
		base.execute cs
	end if
end if
cs="Select id,coordx,coordy,texto_es,texto_en,texto_de,texto_fr,texto_it from " & precrs & "Gmaps WHERE idest=" & clng("" & est)
'response.write cs
rs.open cs,base
hayGpunto=false
if not rs.eof then
	hayGpunto=true
	GMid=rs("id")
	GMx=rs("coordx")
	GMy=rs("coordy")
	Gmtxt_es=rs("texto_es")
	Gmtxt_en=rs("texto_en")
	Gmtxt_de=rs("texto_de")
	Gmtxt_fr=rs("texto_fr")
	Gmtxt_it=rs("texto_it")
end if
rs.close

cs="SELECT nombre,direccion,poblacion,tipoalojamiento FROM ((" & precrs & "Establecimientos Establecimientos left JOIN " & precrs & "datosHotel datosHotel ON establecimientos.codigoesta=datosHotel.codigoesta)) WHERE establecimientos.codigoEsta=" & clng("" & est)
rs.open cs,base
haydatos=false
if not rs.eof then 
	haydatos=true
	hnombre=rs("nombre")
	hdir=rs("direccion")
	hpob=rs("poblacion")
	htipo=rs("tipoalojamiento")
end if
rs.close
'tipo alojamiento
cs="SELECT nombre_es,nombre_en,nombre_de,nombre_fr,nombre_it FROM " & precrs & "tipoalojamiento where id=" & clng("0" & htipo)
rs.open cs,base
if not rs.eof then
	tipo_es=rs("nombre_es")
	tipo_en=rs("nombre_en")
	tipo_de=rs("nombre_de")
	tipo_fr=rs("nombre_fr")
	tipo_it=rs("nombre_it")
end if 
rs.close
server.HTMLEncode(ap("direccion"))
if hayGpunto then
	x=GMx
	y=GMy
else
	if InStr(hnombre,tipo_es)=0 then
		hnombre_es="<b>" & tipo_es & "</b>&nbsp;" & hnombre
	else
		hnombre_es=hnombre 
	end if
	if InStr(hnombre,tipo_en)=0 then
		hnombre_en="<b>" & tipo_en & "</b>&nbsp;" & hnombre 
	else
		hnombre_en=hnombre
	end if
	if InStr(hnombre,tipo_de)=0 then
		hnombre_de="<b>" & tipo_de & "</b>&nbsp;" & hnombre 
	else
		hnombre_de=hnombre
	end if
	if InStr(hnombre,tipo_fr)=0 then
		hnombre_fr="<b>" & tipo_fr & "</b>&nbsp;" & hnombre 
	else
		hnombre_fr=hnombre
	end if
	if InStr(hnombre,tipo_es)=0 then
		hnombre_it="<b>" & tipo_it & "</b>&nbsp;" & hnombre 
	else
		hnombre_it=hnombre
	end if
	response.write htipo
	x="39.6437675734185"
	y= "2.92236328125"	
	Gmtxt_es=hnombre_es & "<br><b>" & application("es.direccion") & ":&nbsp;</b>" &  hdir  & "<br><b>" &  application("es.localidad") & ":&nbsp;</b>" & hpob
	Gmtxt_en=hnombre_en & "<br><b>" & application("en.direccion") & ":&nbsp;</b>" &  hdir  & "<br><b>" & application("en.localidad") & ":&nbsp;</b>" & hpob
	Gmtxt_de=hnombre_de & "<br><b>" & application("de.direccion") & ":&nbsp;</b>" &  hdir  & "<br><b>" & application("de.localidad") & ":&nbsp;</b>" & hpob
	Gmtxt_fr=hnombre_fr & "<br><b>" & application("fr.direccion") & ":&nbsp;</b>" &  hdir  & "<br><b>" & application("fr.localidad") & ":&nbsp;</b>" & hpob
	Gmtxt_it=hnombre_it & "<br><b>" & application("it.direccion") & ":&nbsp;</b>" &  hdir  & "<br><b>" & application("it.localidad") & ":&nbsp;</b>" & hpob
end if
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <script language="javascript" type="text/javascript" src="js/elEditor.js"></script>
  <link href="saintmichel/css.css" rel="stylesheet" type="text/css">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Google Maps</title>
	<script language="JavaScript" >
	function guardaPunto(){
	alert("Guardando  nueva posición");
	document.NewEd.action="correcGmap.asp?est=<%=est%>";
	document.NewEd.submit();
	}
	</script>
     <script id="google_script" src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAA61ykho4SfNoarNe--jnihRS1E7B4JNwVybn0-U7k3Cp9mPiDehSy1QBp2-edmA2rYH4QcVMA371TUQ" type="text/javascript"></script>

    <script type="text/javascript">
    //<![CDATA[
	var zoom = 10;
	var center = new GLatLng(<%=x%>,<%=y%>);
	var baseIcon = new GIcon();
	baseIcon.iconSize=new GSize(100,100);
	baseIcon.iconAnchor=new GPoint(50,50);
	var rectIcon = new GIcon(baseIcon);
	rectIcon.image="img/target.png"
	var wheelZooming = false;
	function load(){
	doLoad();
	container = document.getElementById("mapa");
	}

    function doLoad() {
      if (GBrowserIsCompatible()) {
	  	container = document.getElementById("mapa");
 		map = new GMap2(container, {draggableCursor:"crosshair"});
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		GEvent.addListener(map, 'mousemove', mouseMove);
		GEvent.addListener(map, "moveend", moveEnd);
		GEvent.addListener(map, "zoomend", zoomEnd);
        map.setCenter(center, zoom);
		map.addControl(new GOverviewMapControl());
		var marker = new GMarker(center, {draggable: true});
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
		  document.getElementById("x").value=xy[0];
			document.getElementById("y").value=xy[1];
        });
        map.addOverlay(marker);
		map.enableDoubleClickZoom(); 
		map.enableContinuousZoom();
		GEvent.addDomListener(container, "DOMMouseScroll", wheelZoom);
		GEvent.addDomListener(container, "mousewheel", wheelZoom); 
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

	var bounds = map.getBounds();
	var SW = bounds.getSouthWest();
	var NE = bounds.getNorthEast();
}





function mouseMove(mousePt) {
	mouseLatLng = mousePt;
	var zoom = map.getZoom();
}

//]]>
    </script>
  </head>

  <body onLoad="load();"  onUnload="GUnload()">
  <div style='margin:auto'>
  	<div style='height:30px;'></div>
 	<div style='text-align:center'>
	<div style='font-size:16px;font-weight:bold;text-align:center'><%=hnombre%></div><br>
		<div id="mapa" name="mapa" style="width: 750px; height: 390px;border:ridge 1px #090909"></div>
		<form id='NewEd' name='NewEd'>
		<div style='text-align:center'>
			coordenada x <input id='x' name='x' type='text' style='width:150px' value='<%=x%>'>
			coordenada y <input id='y' name='y' type='text' style='width:150px' value='<%=y%>'>
		</div>
		<div id="message" style='padding-top:0px'></div>
		
		<div style='width:770px;text-align:left'>
			
		
		<b>Direcci&oacute;n:</b>&nbsp;<%=hdir%><br>
		<b>Localidad:</b>&nbsp;<%=hpob%>
			<input type='hidden' name='est' value='<%=est%>'><br><br>
			<div style='float:left;padding-left:5px'><span style='vertical-align:top;font-weight:bold'>Texto cast: <input type="button" value="Editor" onclick="javascript:abreEditor('texto_es',600,430);" style="cursor:pointer; width: 80px;"></span><br><br><textarea name='texto_es' id='texto_es' style='height:75px;width:145px'><%=Gmtxt_es%></textarea></div>
			<div style='float:left;padding-left:5px'><span style='vertical-align:top;font-weight:bold'>Texto In: <input type="button" value="Editor" onclick="javascript:abreEditor('texto_en',600,430);" style="cursor:pointer; width: 80px;"></span><br><br><textarea name='texto_en' id='texto_en' style='height:75px;width:145px'><%=Gmtxt_en%></textarea></div>
			<div style='float:left;padding-left:5px'><span style='vertical-align:top;font-weight:bold'>Texto al: <input type="button" value="Editor" onclick="javascript:abreEditor('texto_de',600,430);" style="cursor:pointer; width: 80px;"></span><br><br><textarea name='texto_de' id='texto_de' style='height:75px;width:145px'><%=Gmtxt_de%></textarea></div>
			<div style='float:left;padding-left:5px'><span style='vertical-align:top;font-weight:bold'>Texto fr: <input type="button" value="Editor" onclick="javascript:abreEditor('texto_fr',600,430);" style="cursor:pointer; width: 80px;"></span><br><br><textarea name='texto_fr' id='texto_fr' style='height:75px;width:145px'><%=Gmtxt_fr%></textarea></div>
			<div style='float:left;padding-left:5px'><span style='vertical-align:top;font-weight:bold'>Texto it: <input type="button" value="Editor" onclick="javascript:abreEditor('texto_it',600,430);" style="cursor:pointer; width: 80px;"></span><br><br><textarea name='texto_it' id='texto_it' style='height:75px;width:145px'><%=Gmtxt_it%></textarea></div>
			<div style='clear:both;height:20px;'></div>
			<center><input type='button' value='guardar' style='cursor:pointer' onclick='javascript:guardaPunto()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' value='cerrar ventana' style='clear:both;width:100px;background-color:#E1DCC9;cursor:pointer' onclick='javascript:window.close()'></center>
			</form>
		</div>
	</div>
	</div>
  </body>
</html>
</html>
