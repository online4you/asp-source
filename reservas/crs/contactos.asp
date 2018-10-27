<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

idpro=request.querystring("pro")
ht=request.querystring("ht")
cnt=request.querystring("cnt")
blanco=request.querystring("bEd")

if idpro<>"" then buscoEd=" WHERE idpro=" & idpro
if ht<>"" then buscoEd=" WHERE idest=" & ht
if blanco then
	cnt=""
end if
cs="SELECT CodigoEsta,Nombre from " & precrs & "Establecimientos"'WHERE idpro=" & idpro
	rs.open cs,base
	hayesta=false
	if  not rs.eof then
		RegEsta=rs.getrows
		REid=0
		REnombre=1
		Hayesta=true
	end if
	rs.close
'filtros por establecimiento y cadena
cs="SELECT id,nombre,apellidos,cargo,idpro,idest FROM " & precrs & "Contactos" & buscoEd
rs.open cs,base
Haycontactos=false
if not rs.eof then
	RegContactos=rs.getrows
	RCid=0
	RCnombre=1
	RCapellidos=2
	RCcargo=3
	RCidpro=4
	RCidest=5
	haycontactos=true
end if
rs.close
'carga de proveedores
	cs="SELECT id,Nombre FROM " & precrs & "Proveedores"
	cs=cs & " ORDER BY nombre"
	rs.Open cs, base
	HayProvee=false
	if not rs.eof then
		Regprovee=rs.GetRows
		'Variables para la tabla RegProvee
		PCodi=0
		PNombre=1
		Hayprovee=true
	end if
	rs.close
'response.write ubound(regcontactos,2)
'contacto determinado visualizado en panel
if cnt<>"" then
	cs="SELECT id,nombre,apellidos,cargo,idpro,idest FROM " & precrs & "Contactos WHERE id=" & clng(cnt)
	'response.write "<br>" & cs
	rs.open cs,base
	RCNTid=clng(rs("id"))
	RCNTnombre=rs("nombre")
	RCNTapellidos=rs("apellidos")
	RCNTcargo=rs("cargo")
	RCNTidpro=rs("idpro")
	RCNTidest=rs("idest")
	rs.close
	
	'carga de hoteles
	cs="SELECT CodigoEsta,Nombre from " & precrs & "Establecimientos"'WHERE idpro=" & idpro
	rs.open cs,base
	hayesta=false
	if  not rs.eof then
		RegEsta=rs.getrows
		REid=0
		REnombre=1
		Hayesta=true
	end if
	rs.close

	cs="SELECT id,numero FROM " & precrs & "Numeros WHERE tipo='telefono' and idcont=" & cnt
	rs.open cs,base
	haytelf1=false
	t=0
	if not rs.eof then
		regtelf1=rs.getrows
		telfid=0
		telfnum=1
		t=ubound(regtelf1,2)
		haytelf1=true
	end if
	rs.close
	cs="SELECT id,numero FROM " & precrs & "Numeros WHERE tipo='movil' and idcont=" & cnt
	rs.open cs,base
	haymov1=false
	mv=0
	if not rs.eof then
		regmov1=rs.getrows
		movid=0
		movnum=1
		mv=ubound(regmov1,2)
		haymov1=true
	end if
	rs.close
	cs="SELECT id,numero FROM " & precrs & "Numeros WHERE tipo='fax' and idcont=" & cnt
	rs.open cs,base
	hayfax1=false
	f=0
	if not rs.eof then
		regfax1=rs.getrows
		faxid=0
		faxnum=1
		f=ubound(regfax1,2)
		hayfax1=true
	end if
	rs.close
	cs="SELECT id,numero FROM " & precrs & "Numeros WHERE tipo='email' and idcont=" & cnt
	rs.open cs,base
	haymail1=false
	ml=0
	if not rs.eof then
		regmail1=rs.getrows
		mailid=0
		mailnum=1
		ml=ubound(regmail1,2)
		haymail1=true
	end if
	rs.close

end if
%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script>
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="actucontactos.asp?pro=<%=idpro%>&modo=borra";
		document.f1.submit();
	}
}
function Modificar(){
//alert  ("cnt="+document.f1.cnt.value);
	if (document.f1.cnt.value==""){
		//alert  ("cnt='' ");
		document.f1.action="actucontactos.asp?pro=<%=Idpro%>&modo=nuevo";
	}else{
		document.f1.action="actucontactos.asp?cnt=<%=cnt%>&modo=actu";
		}
	document.f1.submit();
}
function insertarnum(){
//alert  ("cnt="+document.f1.cnt.value);
	document.f1.action="actunumeros.asp?cnt=<%=cnt%>&modo=nuevo";
	document.f1.submit();
	document.getElementById('NewEdnumero').style.height=1;
}
function borrarnum(){
if (confirm("¿Está seguro/a?")){
	document.f1.action="actunumeros.asp?cnt=<%=cnt%>&modo=borra";
	document.f1.submit();}
}
function Modificarnum(){
//alert  ("cnt="+document.f1.cnt.value);
	document.f1.action="actunumeros.asp?cnt=<%=cnt%>&modo=actu";
	document.f1.submit();
}
</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600" cellpadding="0" cellspacing="0" border="0">
	<tr><td align='left'>
	* Este listado de contactos depende de lo seleccionado en la parte de arriba.
	</td></tr>	
	<tr><td align='right'>
		<input type='button' class="boton145" onclick='javascript:document.location.href="contactos.asp?bEd=true&pro=<%=idpro%>"' value='&nbsp;Nuevo Contacto&nbsp;'>&nbsp;<input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">CONTACTO</div></td></tr>
	  <tr><td class="tdTabla">
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr class="cabetabla">
				<th class="colu_par" align="center">Borrar</th>
				<th class="colu_impar" align="center">Nombre</th>
				<th class="colu_par" align="center">cargo</th>
				<th class="colu_impar" width='50' align='center'>Teléfono</th>
				<th class="colu_par" width='50' align='center'>Móvil</th>
				<th class="colu_impar" width='50' align='center'>Fax</th>
				<th class="colu_par" width='50' align='center'>E-mail</th>
			</tr>
			<%if haycontactos then
				for v=0 to ubound(regcontactos,2)%>
			<tr>
				<td valign='top' align='center'><input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=Regcontactos(RCid,v)%>"></td>
				<td valign='top'><a href='<%=mipag%>?cnt=<%=regcontactos(RCid,v)%>&pro=<%=regcontactos(RCidpro,v)%>'><%=regcontactos(RCapellidos,v) & ", " & regcontactos(RCnombre,v)%></a>&nbsp;</td>
				<td valign='top'><%=regcontactos(rccargo,v)%>&nbsp;</td>
				<td valign='top'><%cs="SELECT numero FROM " & precrs & "Numeros WHERE idcont=" & regcontactos(RCid,v)
					cs=cs & " AND tipo='telefono'"
					rs.open cs,base
					haytelf=false
					if not rs.eof then
						regtelf=rs.getrows
						haytelf=true
					end if
					rs.close
					If haytelf then
						for u=0 to ubound(regtelf,2)%>
							<%=regtelf(0,u)%>&nbsp;<br>
						<%next
					end if%>
				</td>
				<td valign='top'><%cs="SELECT numero FROM " & precrs & "Numeros WHERE idcont=" & regcontactos(RCid,v)
					cs=cs & " AND tipo='movil'"
					rs.open cs,base
					haymov=false
					if not rs.eof then
					regmov=rs.getrows
					haymov=true
					end if
					rs.close
					If haymov then
						for m=0 to ubound(regmov,2)%>
							<%=regmov(0,m)%>&nbsp;<br>
						<%next
					end if%>
				</td>
				<td valign='top'><%cs="SELECT numero FROM " & precrs & "Numeros WHERE idcont=" & regcontactos(RCid,v)
					cs=cs & " AND tipo='fax'"
					rs.open cs,base
					hayfax=false
					if not rs.eof then
					regfax=rs.getrows
					hayfax=true
					end if
					rs.close
					If hayfax then
						for m=0 to ubound(regfax,2)%>
							<%=regfax(0,m)%>&nbsp;<br>
						<%next
					end if%>
				</td>
				<td valign='top'><%cs="SELECT numero FROM " & precrs & "Numeros WHERE idcont=" & regcontactos(RCid,v)
					cs=cs & " AND tipo='email'"
					rs.open cs,base
					haymail=false
					if not rs.eof then
					regmail=rs.getrows
					haymail=true
					end if
					rs.close
					If haymail then
						for u=0 to ubound(regmail,2)%>
							<a href="mailto:<%=regmail(0,u)%>"><%=regmail(0,u)%>&nbsp;</a><br>
						<%next
					end if
					%>
				</td>
			</tr>
			<%next
			end if%>
		</table>
		</td></tr>
</table>
<!--panel de contactos-->
<div id='panel' style='position:absolute; z-index:10; top:100px; left:20px; width:900px; height:370px;visibility:hidden; overflow:visible' class='texto10BLANCO'>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">*** CONTACTO ***</div></td></tr>
  <tr><td class="tdTabla"background="img/corners/i.gif">&nbsp;</td>
  <td class="tdTabla">
			<table align='center'  border='0' cellpadding="0" cellspacing="2">
				<tr><td align='right'>Nombre:</td><input type='hidden' id='cnt' value='<%=cnt%>'>
					<td align='left'><input type="text" maxlength="75" style="width:200px" value='<%=RCNTnombre%>' name="nombre"></td>
				</tr>
				<tr>
					<td align='right'>Apellidos</td>
					<td align='left'><input type="text" maxlength="75" style="width:200px" value='<%=RCNTapellidos%>' name="apellidos"></td>
				</tr>
				<tr><td align='right'>Cargo:</td>
					<td align='left'><input type="text" maxlength="75" style="width:200px" value='<%=RCNTcargo%>' name="cargo"></td>
				</tr>
				<tr><td align='right'>Cadena:</td>
					<td align='left'>
					<select name='cadena'>
					<option value='0'>vinvular a proveedor</option>
					<% if hayprovee then
					for p=0 to ubound(Regprovee,2)%>
					<option value='<%=regprovee(Pcodi,p)%>'<%if (RCNTidpro=regprovee(Pcodi,p) or (clng(idpro)=regprovee(Pcodi,p))) then response.write "selected"%>><%=regprovee(Pnombre,p)%></option>
					<%next%>
					</select>
					<%end if%>
					</td>
				</tr>
				<tr><td align='right'>Hotel:</td>
					<td align='left'><select name='hotel'>
					<option value='0'>vinvular a hotel</option>
					<% if hayesta then
					for e=0 to ubound(Regesta,2)%>
					<option value='<%=regesta(REid,e)%>' <%if RCNTidest=clng(regesta(REid,e)) then response.write "selected" %>><%=regesta(REnombre,e)%></option>
					<%next%>
					</select>
					<%end if%></td>
				</tr>
				<tr><td colspan='2' height='10'></td></tr>
				<tr><td colspan='2' align='center'>
				<% if not blanco then%>
				<input id='newNum' type='button' value='Agregar número' onclick="javascript:document.getElementById('NewEdnumero').style.height=65;" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>
				<%else%>
				<input id='agregar' type='button' value='Agregar' onclick="javascript:Modificar();" style='cursor:pointer'>
				<%end if%>
				</td></tr>
				<tr><td colspan='2' align='center'>
				<div id='NewEdnumero'>
					<table cellspacing='0' cellpadding='0' border='0'>
						<tr><td colspan='3' height='10'></td></tr>
						<tr>
							<td align='center' class='CabeTabla'>Tipo</td>
							<td>&nbsp;&nbsp;</td>
							<td align='center' class='CabeTabla'>Número</td>
						</tr>
						<tr>
							<td align='center'>
								<select name='NewEdtipo' style='width:100'>
								<option value='telefono'>Teléfono</option>
								<option value='movil'>Móvil</option>
								<option value='fax'>Fax</option>
								<option value='email'>E-Mail</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;</td>
							<td align='center'>
								<input type='text' name='NewEdnum' style='width:200px' maxlength='75'>
							</td>
						</tr>
						<tr><td colspan='3' height='10'></td></tr>
						<tr><td colspan='3' height='10' align='center'><input id='SaveNum' type='button' value='Agregar' onclick="javascript:insertarnum();" style='cursor:pointer'>
					</table>
				</div>
				</td></tr>
				
				<tr><td colspan='2'>
					<table cellpadding='0' cellspacing='0' border='0' width='100%'>
					<tr><td colspan='3' height='10'></td></tr>
					<tr><td valign='top'>
					<!--telefonos del contacto-->
							<table cellspacing='0' cellpadding='0' border='0'>
						<%if haytelf1 then%>
							<tr><td colspan='2' align='center'>Teléfonos</td></tr>
						<%for tt=0 to ubound(regtelf1,2)%>
							<tr>
							<td ><input type='checkbox' name='NewEdborrar' style='border:none' value='<%=regtelf1(telid,tt)%>'></td><td><input type='text' name='Num<%=regtelf1(telfid,tt)%>' value='<%=regtelf1(telfnum,tt)%>'></td></tr>
						<%next%>
							<tr><td colspan='2' align='center'></td></tr>
						<%end if%>
							</table></td>
						<td valign='top'>
						<!--moviles del contacto-->
							<table cellspacing='0' cellpadding='0' border='0'>
						<%if haymov1 then%>
							<tr><td colspan='2' align='center'>Móviles</td></tr>
						<% for mm=0 to ubound(regmov1,2)%>
							<tr>
							<td><input type='checkbox' name='NewEdborrar' style='border:none' value='<%=regmov1(movid,mm)%>'></td><td><input type='text' name='Num<%=regmov1(movid,mm)%>' value='<%=regmov1(movnum,mm)%>'></td></tr>
						<%next
						end if%>
							</table></td>
							<!--faxes del contacto-->
						<td valign='top'>
							<table cellspacing='0' cellpadding='0' border='0'>
						<%if hayfax1 then%>
							<tr><td colspan='2' align='center'>Faxes</td></tr>
						<% for ff=0 to ubound(regfax1,2)%>
							<tr>
							<td><input type='checkbox' name='NewEdborrar' style='border:none' value='<%=regfax1(faxid,ff)%>'></td><td><input type='text' name='Num<%=regfax1(faxid,zff)%>' value='<%=regfax1(faxnum,ff)%>'></td></tr>
						<%next
						end if%>
							</table></td></tr>
	
						<!--mails del contacto-->
						<tr><td colspan='3' align='center'>
					<table cellspacing='0' cellpadding='0' border='0'>
						<%if haymail1 then%>
						<tr><td colspan='3' align='center'>E-mails</td></tr>
						<%for eml=0 to ubound(regmail1,2)%>
						<tr>
						<td ><input type='checkbox' name='NewEdborrar' style='border:none' value='<%=regmail1(mailid,eml)%>'></td><td><input type='text' name='Num<%=regmail1(mailid,eml)%>' value='<%=regmail1(mailnum,eml)%>' style='width:200px'></td></tr>
						<%next%>
						<%end if%>
					</table>
				</td></tr>
				<tr><td colspan='3' height='10'></td></tr>
				<%if haytelf1 or haymov1 or hayfax1 or haymail1 then%>
				<tr><td colspan='3' align='center'><input id='ActuN' type='button' value='Actualizar' onclick="javascript:Modificarnum();" style='cursor:pointer'>&nbsp;&nbsp;<input id='boton' type='button' value='Borrar' onclick="javascript:borrarnum();" style='cursor:pointer'></td></tr>
				<tr><td colspan='3' height='10'></td></tr>
				<%end if%>
				<tr><td colspan='3' align='center'><input id='cerrar' type='button' value='X  Cerrar Panel' onclick="javascript:document.getElementById('panel').style.visibility='hidden';" style='cursor:pointer;background-color:#DE6D21;color:#FFFFFF'></td></tr>
				</table>
				<tr><td align='center' colspan='2'>
				</td>
					 <td class="tdTabla"></td>
				</tr>
			</table>
	</td>
    <td class="tdTabla"></td>
  </tr>
</table>
</div>

<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
<%
set rs=nothing
base.close
set base=nothing
%>
