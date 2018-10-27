<%
'Compruebo la solapa activa
split_name=split(MiPag,"/")
if ubound(split_name)=-1 then 'No hay ruta
	NombrePagina=MiPag
else
	NombrePagina=split_name(ubound(split_name)) 'Esto es para coger solo el nombre de la pagina
end if
'Comprobra las pagina de estadisticas
if instr(NombrePagina,"Estadistica")<>0 then
	NombrePagina="EstadisticaMes.asp"
end if
function Marcada(pagina)
	if ucase(pagina)=ucase(NombrePagina) then
		Marcada="fila_act"
	else
		Marcada="fila_menu"
	end if
end function
%>
<script language="javascript" type="text/javascript">
	function cargaEmpresa(){
		document.f1.action="cargaEmpresa.asp"
		document.f1.submit();
	}
	function iR(ande){
		if (GetCookie("Empresa")==""){
			alert("Hay que seleccionar la empresa");
			return;
		}
		window.location=ande;
	}
</script>
<img src="img/transparent.gif" width='100' height='80'><br/>
<div id="botonera">
<div>
<%if adminBoss then%>
	<a href='modulos.asp'>
	<div class='<%=Marcada("modulos.asp")%>'>Gesti&oacute;n de Módulos</div></a>
	<a href='empresas.asp'>
	<div class='<%=Marcada("empresas.asp")%>'>Gesti&oacute;n de Empresas</div></a>
	<a href='consultassql.asp'>
	<div class='<%=Marcada("consultassql.asp")%>'>Modificacion SQL</div></a>
<%end if%>
	<a href="javascript:iR('Usuarios.asp');">
	<div class='<%=Marcada("usuarios.asp")%>'>Gesti&oacute;n de usuarios</div></a>
	<a href="javascript:iR('alojamientos.asp');">
	<div class='<%=Marcada("alojamientos.asp")%>'>Gesti&oacute;n de hoteles</div></a>
	<a href="javascript:iR('RVirtual/ListaClientes.asp');">
	<div class='<%=Marcada("listaClientes.asp")%>'>Recepcionista Virtual</div></a>
	<!--<a href="index.asp?salir=si">
	<div class='<%=Marcada("index.asp")%>'>Cerrar Sesión</div></a>-->
	<a href="javascript: self.close();">
	<div class='fila_menu'>Cerrar</div></a>
aaaa
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
</div>
</div>

