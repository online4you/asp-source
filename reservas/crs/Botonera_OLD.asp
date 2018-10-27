<script language="javascript" type="text/javascript">
	function cargaEmpresa(){
		document.fe.action="cargaEmpresa.asp?lang=<%=lang%>"
		document.fe.submit();
	}
	function cargaPrecios(){
		top.creaFlotante("verMesPrecios.asp?est=<%=est%>&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaCupos(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=0&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaMinimos(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=2&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaRelease(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=3&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaEstado(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=4&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaCheckin(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=5&lang=<%=lang%>",1000,600,0,0);
	}
	function cargaPreciosDia(){
		top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=1&lang=<%=lang%>",1000,600,0,0);
	}
</script>
<div id='logo'>&nbsp;</div>
<div id="botonera">
	<div id="imgIzqBotonera"></div>
	<div id='dentroBotonera'>
		<%if esAdmin then %>
			<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_datosgenerales"))%></div>
			<a href='javascript:cargaFrame("tiposMoneda.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapatipomoneda")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_tiposmoneda")%></div></a>
			<a href='javascript:cargaFrame("tiposHotel.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapatipoaloja")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_tipoaloja")%></div></a>
			<a href='javascript:cargaFrame("categorias.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapacategorias")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_categorias")%></div></a>
			<a href='javascript:cargaFrame("zonas.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_zonas")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_zonas")%></div></a>
			<a href='javascript:cargaFrame("TiposHabitacion.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapatipohab")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_tipohab")%></div></a>
			<a href='javascript:cargaFrame("regimen.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_regimenes")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_regimenes")%></div></a>
			<%if con_cms then 'gestor contenidos%>
            <a href='javascript:cargaFrame("caracter.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapacaracter")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_caracter")%></div></a>
			<%end if 'con_cms %>
			<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_infohotel"))%></div>
			<a href='javascript:cargaFrame("alojamientos.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_alojamientos")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_alojamientos")%></div></a>
		<%else%>
			<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_infohotel"))%></div>
			<a href='javascript:cargaFrame("alojamientos.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_alojamientos")%>");'>
			<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_alojamientos")%></div></a>
		<%end if%>
		<a href='javascript:cargaFrame("temporadas.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_temporadas")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_temporadas")%></div></a>
		<a href='javascript:cargaFrame("colectivos.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_colectivos")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_colectivos")%></div></a>
		<a href='javascript:cargaFrame("Habitaciones.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapaprecioshabitacion")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_precioshabitacion")%></div></a>
		<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_inventario"))%></div>
		<a href='javascript:cargaCupos();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_disponibilidad")%></div>
		</a>
		<a href='javascript:cargaMinimos();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_estanciaminima")%></div>
		</a>
		<a href='javascript:cargaPreciosDia();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_preciosdia")%></div>
		</a>
		<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_comercial"))%></div>
		<a href='javascript:cargaRelease();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_releasehab")%></div>
		</a>
		<a href='javascript:cargaEstado();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_estadohab")%></div>
		</a>
		<a href='javascript:cargaCheckin();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_limitecheckin")%></div>
		</a>
		<a href='javascript:cargaPrecios();'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_yieldmanagement")%></div></a>
		<a href='javascript:cargaFrame("ofertas.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_ofertas")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_ofertas")%></div></a>
		<div class="titulo_menu"><%=ucase(objIdioma.getTraduccionHTML("i_informes"))%></div>
		<a href='javascript:cargaFrame("InformeDisponibilidad.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_solapadispo")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_informedispo")%></div></a>
		<a href='javascript:cargaFrame("listareservas.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_listareservas")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_listareservas")%></div></a>
		<a href='javascript:cargaFrame("estadisticaMes.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_estadisticas")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_estadisticas")%></div></a>
		<a href='javascript:cargaFrame("estadisticaGAnyoPelas.asp?est=<%=est%>&lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_estadisticas")%>");'>
		<div class='fila_menu'><%=objIdioma.getTraduccionHTML("i_estadisticasgraficas")%></div></a>
		<%if haySubmodulos then
		antmodu=""
		for m=0 to ubound(RegSubModulos,2)
			if instr(modulosCR," " & RegSubModulos(SId,m) & ",")<>0 then 'tiene acceso
				if antmodu<>RegSubModulos(SModulo,m) then 'primero o cambia%>
					<div class="titulo_menu"><%=ucase(RegSubModulos(SModulo,m))%></div>
				<%end if%>
				<a href='javascript:cargaFrame("<%=RegSubModulos(SPrograma,m)%>","<%=RegSubModulos(SBoton,m)%>");'>
				<div class='fila_menu'><%=RegSubModulos(SBoton,m)%></div></a>
			<%antmodu=RegSubModulos(SModulo,m)
			end if 'accesos
		next
		end if%>
		<div style="height:10px; overflow:hidden"></div>
		<%if esAdmin then 'Administrador %>
			<a href='inicio.asp' ><div style="margin-top:1px;" class='fila_menu'><%=objIdioma.getTraduccionHTML("i_menuanterior")%></div></a>
		<%else%>
			<a href="index.asp?salir=Si"><div style="margin-top:1px;" class='fila_menu'><%=objIdioma.getTraduccionHTML("i_cerrarsesion")%></div></a>
		<%end if%>	
        
	<form name="fe" method="post">
	<%if adminBoss then%>
		<div align="center" style="margin-top:15px;">Seleccionar Empresa:<%=idEmpresa%><br/>
		<select name="laempre" onChange="javascript:cargaEmpresa();">
			<option value="0">seleccionar</option>
			<%if hayempre then
				for e=0 to ubound(RegEmpre,2)
					marca=""
					if RegEmpre(EmCodi,e)=IdEmpresa then marca=" selected"%>
				<option value="<%=RegEmpre(EmCodi,e)%>"<%=marca%>><%=RegEmpre(EmNombre,e)%></option>
				<%next
			end if%>
		</select>
	  </div>
	<%end if%>
	</form>
	</div>
</div>
<div id='capilla'></div> <!--capa para texto alternativo-->
