	<%if hayServis then 'complementos %>
	<div id='complementos'>
		<h3><span><%=objIdioma.getTraduccionHTML("i_complementos")%></span></h3>
		<%anteservi=0
		for h=0 to ubound(RegServis,2)
			if anteservi<>RegServis(SId,h) then%>
			<div class='habita'>
				<div class='capaFoto'>
				<%if RegServis(SFoto,h)<>"" then 'hay foto
					mifoto=split(RegServis(SFoto,h),";")
				else
					mifoto=split("images/tr.gif",";")
				end if
				if RegServis(SURL,h)<>"" then%>
				<a href="<%=RegServis(SURL,h)%>" target="_blank">
				<img id='miFoto-<%=RegServis(SId,h)%>' src="<%=mifoto(0)%>" alt="" width="100" style="cursor:pointer" border="0"/></a>
				<%else 'no tiene enlace%> 
				<img id='miFoto-<%=RegServis(SId,h)%>' src="<%=mifoto(0)%>" alt="" width="100" border="0"/>
				<%end if 'tiene url%>
				</div> <!-- capaFoto -->
				<div class='textoHabi'>
					<p class='elTitu'><b><%= RegServis(SNombre,h) %></b></p>
					<p class="elTexto"><%=RegServis(STexto,h)%></p>
					<div class='pelasServi' id='inner_<%=RegServis(SId,h)%>'>
					</div> <!-- pelasServi -->
				</div> <!-- textoHabi -->
			</div> <!-- habita -->
            <iframe id='fr_servi_<%=RegServis(SId,h)%>' name='fr_servi_<%=RegServis(SId,h)%>' frameborder="0" src="" scrolling='no' class='elframe'></iframe>
			<hr/>
            <%end if 'anteservi
			anteservi=RegServis(SId,h)
		next 'h%>
		
	</div> <!-- complementos -->
	<script language="javascript" type="text/javascript" src="js/formatoNumero.js"></script>
	<script language="javascript" type="text/javascript">
	function calculaServi(elServi,lalinea){
		if (document.getElementById('servi_'+elServi+'_'+lalinea).checked) { //comprobar marca
			unidades=parseInt(document.getElementById('cuantos_'+elServi+"_"+lalinea).value,10);
			pasta=document.getElementById('servipelas_'+elServi+"_"+lalinea).value;
			pelas=parseFloat(pasta.replace(",","."),10);
			total = new oNumero(unidades*pelas);
			document.getElementById('totalservi_'+elServi+"_"+lalinea).innerHTML="= "+total.formato(2,true);
		}else{
			document.getElementById('totalservi_'+elServi+"_"+lalinea).innerHTML="= 0";
		}
	}
	function cargaServi(){
		//Calcular servicios
		<%if hayServis then
		anteservi=0
		for h=0 to ubound(RegServis,2)
			if anteservi<>RegServis(SId,h) then%>
			document.getElementById('fr_servi_<%=RegServis(SId,h)%>').src="controlServis.asp?ide=<%=idEmpresa%>&ids=<%=RegServis(SId,h)%>&est=<%=idh%>&fini=<%=fini%>&ffin=<%=ffin%>";
			<%end if
			anteservi=RegServis(SId,h)
		next
		end if%>
		
		//alert(document.getElementById('fr_servi_'+ese).src);
	}
	cargaServi();
	</script>
	<%end if 'hayServis%>
