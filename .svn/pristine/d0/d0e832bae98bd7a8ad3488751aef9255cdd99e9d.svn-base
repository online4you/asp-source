<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

pasalir=0
recarga=request.QueryString("recarga") 'id del frame de la ventana
%>
<!--#include file="actuEmpresa.asp"-->
<%

laid=paClng(request.QueryString("id"))
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrsgen & "empresas WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		conexionBD=rs("conexionBD")
		nombreBD=rs("nombreBD")
		userBD=rs("userBD")
		pwdBD=rs("pwdBD")
		estilos=rs("hojaEstilos")
		titulo=rs("metaTitulo")
		rutafotosBD=rs("rutafotos")
		rutadocuBD=rs("rutadocu")
		modulos=rs("modulos")
		mysql=rs("MySQL")
		smtpserver=rs("SMTPServer")
		logincuenta=rs("LoginCuenta")
		pwdcuenta=rs("PWDCuenta")
		remitecuenta=rs("RemiteCuenta")
		idiomas="" & rs("idiomas")
		cms=rs("cms")
		googlemaps="" & rs("googlemaps")
		multitarifa=rs("multitarifa")
		miCharSet=rs("CharSet")
	end if
	rs.close
	
	'Buscar administrador
	cs="SELECT Usuario,Clave FROM " & precrsgen & "usuarios "
	cs=cs & "WHERE IdEmpresa=" & laid & " AND Nivel=0 ORDER BY Id limit 1 "
	rs.open cs,base
	if not rs.eof then
		nick=rs("usuario")
		pass=rs("clave")
	end if
	rs.close
	
end if

'Lista modulos
cs="SELECT P1.Id,P1.Modulo,P2.Id,P2.Modulo "
cs=cs & "FROM " & precrsgen & "modulos as P1 LEFT JOIN " & precrsgen & "modulos as P2 "
cs=cs & "ON P1.Id=P2.ModuloSuperior "
cs=cs & "WHERE P1.ModuloSuperior=0 "
cs=cs & "ORDER BY P1.Orden"
rs.open cs,base
haymodulos=false
if not rs.eof then
	RegModulos=rs.getrows
	MCodi=0
	MModulo=1
	MIdSub=2
	MSubModulo=3
	haymodulos=true
end if
rs.close


set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();

<%else%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}


var idReloj=0;
function cargaLista(){
	
	var mis_titulo_listas=$$('div.capa_lista');
	
	for(x=0;x<mis_titulo_listas.length;x++){
		mis_titulo_listas[x].addEvent("click",function(){
			var lista=$$("#"+this.id+" div.lista");
			for (i=0;i<lista.length;i++) {
				ponLista(lista[i]);
			}
		});
		
		mis_titulo_listas[x].addEvent("mouseover",function(){
			var lista=$$("#"+this.id+" div.lista");
			for (i=0;i<lista.length;i++) {
				clearTimeout(idReloj); //para el reloj si hay un mouseout
			}
		});

		mis_titulo_listas[x].addEvent("mouseout",function(){
			var lista=$$("#"+this.id+" div.lista");
			for (i=0;i<lista.length;i++) {
				idReloj=setTimeout("quitaLista('"+lista[i].id+"')",200);
			}
		});

	}
	
	//control de los checkbox
	var mis_checkbox=$$('div.capa_lista input');
	for(x=0;x<mis_checkbox.length;x++){
		mis_checkbox[x].addEvent("click",function(){
			controlCheckBox(this);
		});
	}
	//ponerSeleccion();
	
	<%if laid=0 then%>
	$('boton').value='Añadir';
	<%end if%>
	document.f1.nombre.focus();
	alto=document.body.offsetHeight+10;
	top.document.getElementById(self.name).style.height=alto+"px";

	//eventos de cms
	$("cms").addEvent("click",function() {
		if (this.checked)
			$("extrasCMS").style.visibility='visible';
		else
			$("extrasCMS").style.visibility='hidden';
	});

}

function quitaLista(esa){
	document.getElementById(esa).style.display='none';
}

function ponLista(esa){
	var mis_listas=$$('div.lista');
	for(x=0;x<mis_listas.length;x++){
		mis_listas[x].style.display='none';
	}
	esa.style.display='block';	
}

function ponerSeleccion(){
	//ellang
	cuantos=parseInt(document.f1.ellang.length,10); //n de checkbox iguales
	texto="";
	for (x=0;x<cuantos;x++) {
		if (document.f1.ellang[x].checked)
			texto+=document.f1.ellang[x].value+", ";
	}
	if (texto=="")
		texto="Todos";
	document.getElementById("ellang_select").innerHTML=texto;
	
}
function controlCheckBox(ese) {
	//alert(ese.value);
	valor=ese.value;
	mi_checkbox=ese.name;
	if (valor!='<%=langPorDefecto%>') {
		cuantos=parseInt(eval("document.f1."+mi_checkbox+".length"),10); //n de checkbox iguale
		texto="";
		for (x=0;x<cuantos;x++){
			if (eval("document.f1."+mi_checkbox+"["+x+"].checked"))
				texto+=eval("document.f1."+mi_checkbox+"["+x+"].value")+", "; //desmarca todas las opciones
		}
		document.getElementById(mi_checkbox+"_select").innerHTML=texto;
	
	} else {
		ese.checked=true;
	}
}
function verTextosEmpresa(id){
	top.creaFlotante("verCondicionesEmpresa.asp?id="+id,970,350,0,0);
}

function gestionSizeGraficos(){
	top.creaFlotante("sizeGraficos.asp?ide=<%=laid%>",470,280,0,0);
}

window.addEvent('domready',cargaLista);

<%end if 'pasalir%>
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">EMPRESA</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
    <td valign="top" class="tdTabla">
      <table width='100%' border='0' align='center' cellpadding="0" cellspacing="2" class="tdTabla">
	  <tr><td align='left' valign="top">
	  			<br>
			  <table border='0' align='center' cellpadding="0" cellspacing="2" class="tdTabla">
			  <tr>
				<td align='right' width="200">Nombre:</td>
				<td align='left' width="250"><input type='text' style='width:200px;' maxlength='50' name='nombre' value='<%=nombre%>'></td>
			</tr>
			  <tr>
				<td align='right'>Conexi&oacute;n Base Datos:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='conexionbd' value='<%=conexionBD%>'>
				</td>
			</tr>
			  <tr>
				<td align='right'>Nombre Base Datos:</td>
				<td align='left'><input type='text' size='20' maxlength='25' name='nombrebd' value='<%=nombreBD%>'></td>
			</tr>
			  <tr>
				<td align='right'>Usuario Base Datos:</td>
				<td align='left'><input type='text' size='20' maxlength='25' name='userbd' value='<%=userBD%>'></td>
			</tr>
			  <tr>
				<td align='right'>Password Base Datos:</td>
				<td align='left'><input type='text' size='20' maxlength='25' name='pwdbd' value='<%=pwdBD%>'></td>
			</tr>
			  <tr>
				<td align='right'>Hoja Estilos:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='50' name='estilos' value='<%=estilos%>'></td>
			</tr>
			  <tr>
				<td align='right'>T&iacute;tulo P&aacute;gina:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='50' name='titulo' value='<%=titulo%>'></td>
			</tr>
			  <tr>
				<td align='right'>Ruta Fotos:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='rutafotos' value='<%=rutafotosBD%>'></td>
			</tr>
			  <tr>
				<td align='right'>Ruta Documentos:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='rutadocu' value='<%=rutadocuBD%>'></td>
			</tr>
            <tr>
				<td align='right' valign="top">&iquest;Con gestor CMS?:</td>
				<td align='left' valign="top">
                <input type="checkbox" name="cms" id='cms' value="1" style="float:left"<%if cms then response.write " checked"%>>
                <span id='extrasCMS' style='float:left; margin-left:20px; text-align:right;<%if not cms then response.write " visibility:hidden"%>'>
                &iquest;incluye Google Maps?&nbsp;
                <input type="checkbox" name="googlemaps" value="1"<%if googlemaps then response.write " checked"%>><br>
                	<%if laid<>0 then 'está en modificacion%>
                	<input type="button" class="boton86" value="Tamaño fotos" onClick="javascript:gestionSizeGraficos();">
                	<%end if 'laid<>0%>
                </span>
                </td>
			</tr>
            <tr>
				<td align='right' valign="top">&iquest;MultiTarifa?:</td>
				<td align='left' valign="top">
                <input type="checkbox" name="multitarifa" id='multitarifa' value="1"<%if multitarifa then response.write " checked"%>>
                </td>
			</tr>
			  <tr>
				<td align='right'>Nick Administrador:</td>
				<td align='left'><input type='text' size='20' maxlength='25' name='nick' value='<%=nick%>'></td>
			</tr>
			 <tr>
				<td align='right'>Pwd Administrador:</td>
				<td align='left'><input type='text' size='20' maxlength='25' name='pass' value='<%=pass%>'></td>
			</tr>
            <tr>
				<td align='right'>Idiomas:</td>
				<td align='left'>
                <div id='capa_lista1' class='capa_lista'>
					<span class='titulo_lista' id='ellang_select' style="width:126px;"><%=idiomas%></span>
					<div id='lista1' class='lista'>
						<span><input type="checkbox" value="es" name='ellang'<%if instr(idiomas,"es,")<>0 then response.write " checked"%>  />Espa&ntilde;ol</span>
                        <span><input type="checkbox" value="ca" name='ellang'<%if instr(idiomas,"ca,")<>0 then response.write " checked"%> />Catal&aacute;n</span>
                        <span><input type="checkbox" value="en" name='ellang'<%if instr(idiomas,"en,")<>0 then response.write " checked"%> />Ingl&eacute;s</span>
                        <span><input type="checkbox" value="de" name='ellang'<%if instr(idiomas,"de,")<>0 then response.write " checked"%> />Alem&aacute;n</span>
                        <span><input type="checkbox" value="fr" name='ellang'<%if instr(idiomas,"fr,")<>0 then response.write " checked"%> />Franc&eacute;s</span>
                        <span><input type="checkbox" value="it" name='ellang'<%if instr(idiomas,"it,")<>0 then response.write " checked"%> />Italiano</span>
                        <span><input type="checkbox" value="pt" name='ellang'<%if instr(idiomas,"pt,")<>0 then response.write " checked"%> />Portugu&eacute;s</span>
                        <span><input type="checkbox" value="bg" name='ellang'<%if instr(idiomas,"bg,")<>0 then response.write " checked"%> />B&uacute;lgaro</span>
                        <span><input type="checkbox" value="ru" name='ellang'<%if instr(idiomas,"ru,")<>0 then response.write " checked"%> />Ruso</span>
					</div>
				</div>
                </td>
            </tr>
            <tr>
				<td align='right'>CharSet:</td>
				<td align='left'>
                <select name="charset">
                <option value="ISO-8859-1"<%if miCharSet="ISO-8859-1" then response.write " selected"%>>ISO-8859-1</option>
                <option value="UTF-8"<%if miCharSet="UTF-8" then response.write " selected"%>>UTF-8</option>
                </td>
            </tr>

			<tr><td colspan='2' height='5'></td></tr>
		  <tr>
				<td align='right'>Servidor SMTP:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='smtpserver' value='<%=smtpserver%>'></td>
			</tr>
		  <tr>
				<td align='right'>Cuenta Remite:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='remitecuenta' value='<%=remitecuenta%>'></td>
			</tr>
		  <tr>
				<td align='right'>Login Cuenta:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='logincuenta' value='<%=logincuenta%>'></td>
			</tr>
		  <tr>
				<td align='right'>PWD Cuenta:</td>
				<td align='left'><input type='text' style='width:200px;' maxlength='75' name='pwdcuenta' value='<%=pwdcuenta%>'></td>
			</tr>
		<%if laid=0 then 'alta%>
		  <tr>
				<td align='right'>Crear tablas en la BD?</td>
				<td align='left'><input type="checkbox" style='border:none' name='creatablas' value='1'></td>
			</tr>
		<%end if 'laid=0%>
			<tr><td colspan='2' height='10'></td></tr>
			</table>
	</td>
	<td width='250' align='left' valign='top' id='photel'>
		<b>M&oacute;dulos Activos</b>
		<div style="width:240px; overflow-y:scroll; overflow-x:hidden; border:1px solid #666666; padding:5px; height:320px;">
		<%if haymodulos then
		idmod=0
		for m=0 to ubound(RegModulos,2)
			ies=""
			if idmod<>RegModulos(MCodi,m) then 'es modulo principal
				if instr(modulos," " & RegModulos(MCodi,m) & ",")<>0 then ies=" checked"%>
				<input type="checkbox" name="modulos" value="<%=RegModulos(MCodi,m)%>"<%=ies%>> <%=RegModulos(MModulo,m)%><br/>
				<%if RegModulos(MSubModulo,m)<>"" then 'hay submodulo
					ies=""
					if instr(modulos," " & RegModulos(MIdSub,m) & ",")<>0 then ies=" checked"%>
					&nbsp;&nbsp;&nbsp;<input type="checkbox" name="modulos" value="<%=RegModulos(MIdSub,m)%>"<%=ies%>> <%=RegModulos(MSubModulo,m)%><br/>
				<%end if 'submodulo
			else 'SubModulo
				ies=""
				if instr(modulos," " & RegModulos(MIdSub,m) & ",")<>0 then ies=" checked"%>
				&nbsp;&nbsp;&nbsp;<input type="checkbox" name="modulos" value="<%=RegModulos(MIdSub,m)%>"<%=ies%>> <%=RegModulos(MSubModulo,m)%><br/>
			<%end if
			idmod=RegModulos(MCodi,m)
		next
		end if%>
		</div>
		<input name="ssboton" type='button' class="boton145" onclick="javascript:verTextosEmpresa(<%=laid%>);" value='Condiciones Empresa' style="margin-bottom:0px;">
	</td>
	</tr>
	  <tr>
		<td align='center' colspan='2'>
			<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" class="boton86">
			<input type='hidden' name='id' value='<%=laid%>'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
		</td>
	  </tr>

	</table>

</td></tr>
</table>
</form>
</body>
</html>