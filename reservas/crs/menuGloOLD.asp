<script language="javascript" type="text/javascript">
	function cargaEmpresa(){
		document.fe.action="cargaEmpresa.asp"
		document.fe.submit();
	}
	function iR(ande){
		if (GetCookie("Empresa")=="" || GetCookie("Empresa")==null){
			alert("Hay que seleccionar la empresa");
			return;
		}
		switch (ande) {
			case "usuariosF.asp":
				cargaFrame("usuariosF.asp","Usuarios");
				break;
			case "registro.asp":
				cargaFrame("registro.asp","Accesos");
				break;
				
			default:
				window.location=ande;
		}
		
	}
	
</script>
<div id='logo'>&nbsp;</div>
<div id="botonera">
	<div id="imgIzqBotonera"></div>
	<div id='dentroBotonera' style="padding-top:10px;">
	<%if adminBoss then%>
		<a href='javascript:cargaFrame("modulosF.asp","Módulos");'>
		<div class='fila_menu'>Gesti&oacute;n de Módulos</div></a>
		<a href='javascript:cargaFrame("empresas.asp","Empresas");'>
		<div class='fila_menu'>Gesti&oacute;n de Empresas</div></a>
		<a href='javascript:cargaFrame("consultassql.asp","Modif. SQL");'>
		<div class='fila_menu'>Modificacion SQL</div></a>
	<%end if%>
		<a href='javascript:iR("usuariosF.asp");'>
		<div class='fila_menu'>Gesti&oacute;n de usuarios</div></a>
		<a href='javascript:iR("registro.asp");'>
		<div class='fila_menu'>Registro de Accesos</div></a>
		<a href="javascript:iR('cr.asp');">
		<div class='fila_menu'>Gesti&oacute;n de hoteles</div></a>
		<a href="#">
		<div class='fila_menu'>Recepcionista Virtual</div></a>
		<a href="index.asp?salir=Si">
		<div class='fila_menu'>Cerrar Sesión</div></a>
	
	<form name="fe" method="post">
	<%if adminBoss then%>
		<div align="center" style="margin-top:15px;">Seleccionar Empresa:<br/>
		<select name="laempre" onChange="javascript:cargaEmpresa();">
			<option value="0">seleccionar</option>
			<%if hayempre then
				for e=0 to ubound(RegEmpre,2)
					marca=""
					if RegEmpre(EmCodi,e)=clng("0" & request.Cookies("IdEmpresa")) then marca=" selected"%>
				<option value="<%=RegEmpre(EmCodi,e)%>"<%=marca%>><%=RegEmpre(EmNombre,e)%></option>
				<%next
			end if%>
		</select>
	  </div>
	<%end if%>
	</form>
	</div>
</div>

