<script language="javascript" type="text/javascript">
	function cargaEmpresa(){
		document.fe.action="cargaEmpresa.asp"
		document.fe.submit();
	}
	function iR(ande){
		if (GetCookie("IdEmpresa")=="" || GetCookie("IdEmpresa")==null){
			alert("Hay que seleccionar la empresa");
			return;
		}
		switch (ande) {
			case "usuariosF.asp":
				creaFrame("usuariosF.asp?lang=<%=lang%>","<%=objIdioma.getTraduccionHTML("i_usuarios")%>");
				break;
			case "Idiomas/traducciones.asp":
				creaFrame("Idiomas/traducciones.asp","Idiomas");
				break;
			case "Idiomas/traduccionesWeb.asp":
				creaFrame("Idiomas/traducciones.asp?tipo=web","Texto Web");
				break;
			case "registro.asp":
				creaFrame("registro.asp?lang=<%=lang%>","Accesos");
				break;
				
			default:
				window.location=ande+"?lang=<%=lang%>";
		}
		
	}
	
</script>
<div id='logo'>&nbsp;</div>
<div id="botonera">
	<div id="imgIzqBotonera"></div>
	<div id='dentroBotonera' style="padding-top:10px;">
	<%if adminBoss then%>
		<a href='javascript:creaFrame("modulosF.asp?lang=<%=lang%>","M&oacute;dulos");'>
		<div class='fila_menu'>Gesti&oacute;n de M&oacute;dulos</div></a>
		<a href='javascript:creaFrame("empresas.asp?lang=<%=lang%>","Empresas");'>
		<div class='fila_menu'>Gesti&oacute;n de Empresas</div></a>
		<a href='javascript:creaFrame("consultassql.asp?lang=<%=lang%>","Modif. SQL");'>
		<div class='fila_menu'>Modificacion SQL</div></a>
		<a href='javascript:iR("Idiomas/traducciones.asp");'>
		<div class='fila_menu'>Traducciones Panel</div></a>
		<a href='javascript:iR("Idiomas/traduccionesWeb.asp");'>
		<div class='fila_menu'>Traducciones Web</div></a>
	<%end if 'adminboss%>
	<%if haymodulos then
		for m=0 to ubound(RegModulos,2)
			if instr(modulos," " & RegModulos(MCodi,m) & ",")<>0 then 'tiene acceso%>
			<a href='javascript:iR("<%=RegModulos(MPrograma,m)%>");'>
			<div class='fila_menu'><%=RegModulos(MModulo,m)%></div></a>
			<%end if 'accesos
		next
	end if%>
<!--	<a href="index.asp?salir=Si">
	<div class='fila_menu'>Cerrar Sesi&oacute;n</div></a>-->
	<a href="javascript: self.close();">
	<div class='fila_menu'>Cerrar</div></a>
	
	<form name="fe" method="post">
	<%if adminBoss then%>
		<div align="center" style="margin-top:15px;">Seleccionar Empresa:<br/>
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

