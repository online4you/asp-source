<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")
if request.Cookies("HotelBoss")="" and request.form<>"" then 'Solo modifica el administrador
	modo=request.QueryString("modo")
	nombre=QuitarApos(request.form("nombre"))
	email=QuitarApos(request.form("email"))
	direccion=QuitarApos(request.form("direccion"))
	cp=QuitarApos(request.form("cp"))
	poblacion=QuitarApos(request.form("poblacion"))
	provincia=QuitarApos(request.form("provincia"))
	pais=QuitarApos(request.form("pais"))
	telefono=QuitarApos(request.form("telefono"))
	fax=QuitarApos(request.form("fax"))
	contacto=QuitarApos(request.form("contacto"))
	bal=QuitarApos(request.form("bal"))
	nif=QuitarApos(request.form("nif"))
	comision=QuitarComa(Request.form("comision"))
	usuario=QuitarApos(request.form("usuario"))
	clave=QuitarApos(request.form("clave"))
	activa=request.form("activa")
	if activa="" then activa=0
	sistema=request.form("sistema")
	if sistema="" then sistema=0
	
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "Agencias WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
			end if
			
		case "nuevo" 'Añadir
			
			'Añadir
			cs="INSERT INTO " & precrs & "Agencias (Nombre,EMail,Direccion,CP,Poblacion,Provincia,Pais,"
			cs=cs & "NIF,Telefono,Fax,Contacto,Observaciones,BAL,Comision,Usuario,Clave,Activa,Sistema) VALUES ('"
			cs=cs & nombre & "','" & email & "','" & direccion & "','" & cp & "','"
			cs=cs & poblacion & "','" & provincia & "','" & pais & "','" & nif & "','"
			cs=cs & telefono & "','" & fax & "','" & contacto & "','" & observaciones & "','"
			cs=cs & bal & "'," & comision & ",'" & usuario & "','" & clave & "',"
			cs=cs & activa & "," & sistema & ")"
			base.execute cs
			
			
		case "actu"
			MiId=request.form("id")
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Agencias SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "EMail='" & email & "',"
			cs=cs & "Direccion='" & direccion & "',"
			cs=cs & "CP='" & cp & "',"
			cs=cs & "Poblacion='" & poblacion & "',"
			cs=cs & "Provincia='" & provincia & "',"
			cs=cs & "Pais='" & pais & "',"
			cs=cs & "NIF='" & nif & "',"
			cs=cs & "Telefono='" & telefono & "',"
			cs=cs & "Fax='" & fax & "',"
			cs=cs & "Contacto='" & contacto & "',"
			cs=cs & "Observaciones='" & observaciones & "',"
			cs=cs & "BAL='" & bal & "',"
			cs=cs & "Comision=" & comision & ","
			cs=cs & "Usuario='" & usuario & "',"
			cs=cs & "Clave='" & clave & "',"
			cs=cs & "Activa=" & activa & ","
			cs=cs & "Sistema=" & sistema & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
	
			
	end select
end if 'Administrador

laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Agencias "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		email=rs("email")
		direccion=rs("direccion")
		cp=rs("cp")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		pais=rs("pais")
		nif=rs("nif")
		telefono=rs("telefono")
		fax=rs("fax")
		contacto=rs("contacto")
		observaciones=rs("observaciones")
		bal=rs("bal")
		comision=rs("comision")
		usuario=rs("usuario")
		clave=rs("clave")
		activa=rs("activa")
		sistema=Clng(rs("sistema"))
	end if
	rs.close
end if

'Lista de registros
cs="SELECT Id,Nombre,EMail,Contacto,Telefono FROM " & precrs & "Agencias ORDER BY Id DESC"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNom=1
	REMail=2
	RConta=3
	RTele=4
	haylista=true
end if
rs.close

'Nombre de paises
cs="SELECT Cod_Pais,Nombre_es FROM Pais Order BY Nombre_es"
rs.open cs,base
haypais=false
if not rs.eof then
	RegPais=rs.getrows
	PCodi=0
	PNombre=1
	haypais=true
end if
rs.close


set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}

function Modificar(){
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu";

	document.f1.submit();
}
function enBlanco(){
	document.f1.nombre.value='';
	document.f1.email.value='';
	document.f1.direccion.value='';
	document.f1.cp.value='';
	document.f1.poblacion.value='';
	document.f1.provincia.value='';
	document.f1.pais.value='';
	document.f1.contacto.value='';
	document.f1.observaciones.value='';
	document.f1.telefono.value='';
	document.f1.fax.value='';
	document.f1.nif.value='';
	document.f1.bal.value='';
	document.f1.comision.value='10';
	document.f1.usuario.value='';
	document.f1.clave.value='';
	document.f1.activa.checked=false;
	document.getElementById('boton').value=" Añadir ";
	document.f1.id.value="";
	document.getElementById('panel').style.visibility='visible';
	document.f1.nombre.focus();
}

</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770' align="left">
<tr>
	<td align='center' width='110' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<br>
	<table align='center' width="600">
	<tr><td align='center'>
		<%if request.Cookies("HotelBoss")<>"" then%>
			<b>(NO SE PERMITE MODIFICAR ESTE APARTADO)</b>
		<%end if%>
	</td></tr>
	</table>

    <table border="0" cellpadding="0" cellspacing="0" style="margin-top:21px; ">
		<tr><td align="right">
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nueva Agencia&nbsp;'><input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">AGENCIAS</div></td></tr>
  <tr><td class="tdTabla">
	<!-- tabla -->
<table border="0" cellpadding="0" cellspacing="0" width='650' align='center'>
	<tr class='cabetabla'>
	 <th>Borrar</th>
	<th>ID</th>
	<th align='left' class="colu_par">Agencia</th>
	<th align='left' class="colu_par">EMail</th>
	<th align='left' class="colu_par">Contacto</th>
	<th align='left' class="colu_par">Teléfono</th>
	</tr><%if haylista then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
	<tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
		<input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
	  </td>	  <td align="center" width='40' class='<%=laColu(1)%>'>
		<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a>
	  </td>
	  <td align="left" class='<%=laColu(0)%>' >
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom,r)%></a>
	</td>
	  <td align="left" class='<%=laColu(0)%>' >
	  	<%=RegLista(REMail,r)%>
	</td>
	  <td align="left" class='<%=laColu(0)%>' >
	  	<%=RegLista(RConta,r)%>
	</td>
	  <td align="left" class='<%=laColu(0)%>' >
	  	<%=RegLista(RTele,r)%>
	</td>
	  </tr>
	  <%
	next
	end if%></table>
	</td></tr>
</table>
	
</td></tr>
</table>

<div id='panel' style='position:absolute; z-index:10; top:0px; left:0px; width:470px; height:250px; visibility:hidden;' class='texto10BLANCO'>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">AGENCIA</div></td></tr>
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='450' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right'>Agencia:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='75' name='nombre' value='<%=nombre%>'></td>
		<td width="5"></td>
		<td align='right'>EMail:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='75' name='email' value='<%=email%>'></td>
	</tr>
	<tr><td align='right'>Dirección:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='75' name='direccion' value='<%=direccion%>'></td>
		<td width="5"></td>
		<td align='right'>Población:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='50' name='poblacion' value='<%=poblacion%>'></td>
	</tr>
	<tr><td align='right'>CP:</td>
		<td align='left'><input type='text' style='width:80px;' maxlength='10' name='cp' value='<%=cp%>'></td>
		<td width="5"></td>
		<td align='right'>Provincia:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='50' name='provincia' value='<%=provincia%>'></td>
	</tr>
	<tr><td align='right'>Pais:</td>
		<td align='left'>
		<select name="pais" style='width:130px;'>
        <%if haypais then
			for p=0 to ubound(RegPais,2)
					marca=""
					if RegPais(PCodi,p)=pais then marca="selected"%>
        <option value='<%=RegPais(PCodi,p)%>' <%=marca%>><%=RegPais(PNombre,p)%></option>
        <%next
		end if%>
    	</select></td>
		<td width="5"></td>
		<td align='right'>NIF:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='25' name='nif' value='<%=nif%>'></td>
	</tr>
	<tr><td align='right'>Teléfono:</td>
		<td align='left'><input type='text' style='width:100px;' maxlength='25' name='telefono' value='<%=telefono%>'></td>
		<td width="5"></td>
		<td align='right'>Fax:</td>
		<td align='left'><input type='text' style='width:100px;' maxlength='25' name='fax' value='<%=fax%>'></td>
	</tr>
	<tr><td align='right'>BAL:</td>
		<td align='left'><input type='text' style='width:100px;' maxlength='25' name='bal' value='<%=bal%>'></td>
		<td width="5"></td>
		<td align='right'>Comisión:</td>
		<td align='left'><input type='text' style='width:50px;' maxlength='10' name='comision' value='<%=comision%>'></td>
	</tr>
	<tr><td align='right'>Contacto:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='75' name='contacto' value='<%=contacto%>'></td>
		<td width="5"></td>
		<td align='right'>Usuario:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='25' name='usuario' value='<%=usuario%>'></td>
	</tr>
	<tr><td align='right'>Activa:</td>
		<td align='left'><input type="checkbox" value='1' name='activa' <%if activa then response.write "checked"%>></td>
		<td width="5"></td>
		<td align='right'>Clave:</td>
		<td align='left'><input type='text' style='width:150px;' maxlength='25' name='clave' value='<%=clave%>'></td>
	</tr>
	<tr><td align="right" valign="top">Sistema Reserva<br>(Por defecto)</td>
		<td align="left" valign="top" colspan="4">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr><td align="right"><input type="radio" name="sistema" value="1" <%if sistema=1 then response.write "checked"%>></td>
				<td align="left">La Agencia lo cobra todo, y paga a HM Hotels el neto.</td>
			</tr>
			<tr><td align="right"><input type="radio" name="sistema" value="2" <%if sistema=2 then response.write "checked"%>></td>
				<td align="left">La Agencia cobra su comisión, el resto lo paga el cliente en el Hotel.</td>
			</tr>
			<tr><td align="right"><input type="radio" name="sistema" value="3" <%if sistema=3 then response.write "checked"%>></td>
				<td align="left">El cliente los paga todo en el Hotel.</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr><td align="right" valign="top">Observaciones:</td>
		<td align="left" colspan="4">
		<textarea name="observaciones" style='width:300px; height:80px'><%=observaciones%></textarea>
		</td>
	</tr>
	<tr><td height="10" colspan='5'></td></tr>
	<tr><td align='center' colspan='5'>
		<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>	
		<input type='hidden' name='id' value='<%=laid%>'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"value="Cerrar" onClick="javascript:cerrar();" style='cursor:pointer'></td></tr>
</table>

	</td></tr>
</table>

</div>
<script language="JavaScript">
	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	document.getElementById('panel').style.top=t+"px";
	document.getElementById('panel').style.left=l+"px";
	<%if laid<>0 then %>
			document.getElementById('panel').style.visibility='visible';
	<%end if	%>
</script>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
