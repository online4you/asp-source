			<div class="contenidoHotel">
	        	<h2><%=objIdioma.getTraduccionHTML("i_situacion")%></h2>
				<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAA5HtCtsdXDjN6siIvj3IkpxSFdWORbeINMojXKQi-ASISzlrnrBRBqKFYsBaY2mR8_Rmy8Uu9bxV4bg" type="text/javascript" charset='utf-8'></script>
				<div class="gmap" id="map_canvas"></div>
				<script type="text/javascript">
                //GMAP
                //39.571, 2.966
				latitud=<%=quitarComa(valor_x)%>;
				longitud=<%=quitarComa(valor_y)%>;
				zoom=<%=mapazoom%>;
                if (GBrowserIsCompatible()) {
                var map = new GMap2(document.getElementById("map_canvas"));
                map.setCenter(new GLatLng(latitud,longitud),zoom);
                map.setUIToDefault();
                }
                marker1=new GMarker(new GLatLng(latitud,longitud));
                map.addOverlay(marker1);
                
                GEvent.addListener(marker1, "click", function() {
                  marker1.openInfoWindowHtml("<%=mapatexto%>");
                });
				
				map.disableScrollWheelZoom();
				GEvent.addListener(map, "click", function() {
                  map.enableScrollWheelZoom();
                });
				GEvent.addListener(map, "mouseout", function() {
                  map.disableScrollWheelZoom();
                });

                </script>
			</div> <!--contenidoHotel-->
