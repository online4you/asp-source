	<%
			mostrarServicioTitulo="style=""visibility: hidden; position:absolute; top:0;"""
			mostrarServicioTitulo="style=""visibility: hidden;"""
			for h=0 to ubound(RegServis,2)
				if (RegServis(SObliga,h)=0) then
					mostrarServicioTitulo="style=""visibility: visible;"""
				end if
			next
	mostrarServicioTitulo="style=""visibility: hidden; position:absolute; top:0;"""
	'mostrarServicioTitulo="style=""visibility: visible;"""
	if hayServis then 'complementos %>
	<div id='complementos' class="listaPhotel" <%=mostrarServicioTitulo%> >
		<h3><span><%=objIdioma.getTraduccionHTML("i_complementos")%></span></h3>
		<%anteservi=0
		for h=0 to ubound(RegServis,2)
			mostrarServicio=""
			if anteservi<>RegServis(SId,h) then
		  		if (RegServis(SObliga,h)) then
		 		 	mostrarServicio="style=""visibility: hidden; position:absolute; top:0;"""
				end if
			mostrarServicio=""
			%>
			<div class='habita' <%=mostrarServicio%>>
            	<%if RegServis(SFoto,h)<>"" then 'hay foto
					mifoto=split(RegServis(SFoto,h),";")
					if mifoto(0)<>"" then 'pinta foto%>
				<div class='capaFoto'>
				<%if RegServis(SURL,h)<>"" then%>
				<a href="<%=RegServis(SURL,h)%>" target="_blank">
				<img id='miFoto-<%=RegServis(SId,h)%>' src="<%=mifoto(0)%>" alt="" width="100" style="cursor:pointer" border="0"/></a>
				<%else 'no tiene enlace%> 
				<img id='miFoto-<%=RegServis(SId,h)%>' src="<%=mifoto(0)%>" alt="" width="100" border="0"/>
				<%end if 'tiene url%>
				</div> <!-- capaFoto -->
                	<%end if 'mifoto
                end if 'hayfoto%>
				<div class='textoHabi'>
					<p class='elTitu'><b><%= RegServis(SNombre,h) %></b></p>
					<p class="elTexto"><%=RegServis(STexto,h)%></p>
				</div> <!-- textoHabi -->
					<div class='pelasServi' id='inner_<%=RegServis(SId,h)%>' ></div> <!-- pelasServi -->
                <% response.write "<!-- SID: " & SId & ", h: " & h & " | " & RegServis(SId, h) & "-->" %>
			</div> <!-- habita -->
			<iframe id='fr_servi_<%=RegServis(SId,h)%>' name='fr_servi_<%=RegServis(SId,h)%>' frameborder="0" src="" scrolling='no' class='capaIframe'></iframe>

            <%end if 'anteservi
			anteservi=RegServis(SId,h)
		next 'h%>
		
	</div> <!-- complementos -->
	<script language="javascript" type="text/javascript" src="js/formatoNumero.js"></script>
	<script language="javascript" type="text/javascript">
	
	function calculaServi(elServi, lalinea)
	{
		if (document.getElementById('servi_' + elServi + '_' + lalinea).checked) //comprobar marca
		{ 
			unidades = parseInt(document.getElementById('cuantos_' + elServi + "_" + lalinea).value, 10);
			pasta = document.getElementById('servipelas_' + elServi + "_" + lalinea).value;
			pelas = parseFloat(pasta.replace(",", "."), 10);
			
			descuento = document.getElementById('descuento_' + elServi + "_" + lalinea).value;
			importe_descuento = unidades * (pelas * (descuento / 100));			
			importe_descuento *= 100;
			importe_descuento = Math.round(importe_descuento);
			importe_descuento /= 100;
			
			total = new oNumero((unidades * pelas) - importe_descuento);
			
			document.getElementById('importedescuento_' + elServi + "_" + lalinea).value = importe_descuento;
			document.getElementById('totalservi_' + elServi + "_" + lalinea).innerHTML = "= " + total.formato(2, true);
		}
		else
		{
			document.getElementById('totalservi_' + elServi + "_" + lalinea).innerHTML = "= 0,00";
		}
	}
	
	function cargaServi(){
		//Calcular servicios
		var rooms;
		rooms='';
		<%if hayServis then
		anteservi=0
		for h=0 to ubound(RegServis,2)
			if anteservi<>RegServis(SId,h) then%>
			 <% for i=1 to numHabs %>
				rooms+=document.getElementById('habi_<%=i%>').value + ',';
			<% next %>
			rooms=rooms.substring(0, rooms.length-1);
			document.getElementById('fr_servi_<%=RegServis(SId,h)%>').src="controlServis.asp?ide=<%=idEmpresa%>&ids=<%=RegServis(SId,h)%>&est=<%=idh%>&fini=<%=fini%>&ffin=<%=ffin%>&rooms=" + rooms ;
			//document.getElementById('fr_servi_<%=RegServis(SId,h)%>').style.display="block";
			//alert(document.getElementById('fr_servi_<%=RegServis(SId,h)%>').src);
			<%end if
			anteservi=RegServis(SId,h)
		next
		end if%>

		if (parent.location != window.location) {
			eval("parent.autoResize('iframe<%=iFrameId%>')");
		}
		//alert(document.getElementById('fr_servi_'+ese).src);
	}
	//cargaServi();
	
	function setStyled(){
		var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
		for(a = 0; a < inputs.length; a++) {
			
			if((inputs[a].type == "checkbox" || inputs[a].type == "radio") && inputs[a].className == "styled" && inputs[a].name.substring(0,5)== "servi"  ) {
				span[a] = document.createElement("span");
				span[a].className = inputs[a].type;

				if(inputs[a].checked == true) {
					if(inputs[a].type == "checkbox") {
						position = "0 -" + (checkboxHeight*2) + "px";
						span[a].style.backgroundPosition = position;
					} else {
						position = "0 -" + (radioHeight*2) + "px";
						span[a].style.backgroundPosition = position;
					}
				}
				inputs[a].parentNode.insertBefore(span[a], inputs[a]);
				inputs[a].onchange = Custom.clear;
				if(!inputs[a].getAttribute("disabled")) {
					span[a].onmousedown = Custom.pushed;
					span[a].onmouseup = Custom.check;
				} else {
					span[a].className = span[a].className += " disabled";
				}
			}
		}

	}
	</script>
	<%end if 'hayServis%>
