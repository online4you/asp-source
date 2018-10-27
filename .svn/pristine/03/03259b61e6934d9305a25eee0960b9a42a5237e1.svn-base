<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.form<>"" then
	modo=request.QueryString("modo")
	MiId=request.querystring("id")
	'response.write MiId	& "--><br>"		
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "proveedores WHERE "
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
			nombre=QuitarApos(request.form("nombre"))
			direccion=QuitarApos(request.form("direccion"))
			cp=request.form("cp")
			nomfiscal=QuitarApos(request.form("nomfiscal"))
			dirfiscal=QuitarApos(request.form("dirfiscal"))
			cpfiscal=request.form("cpfiscal")
			cif=request.form("cif")
			web=request.form("web")
			comision=request.form("comision")
			prepago=request.form("prepago")
			localidad=QuitarApos(request.form("loc"))
			'Añadir
			cs="INSERT INTO " & precrs & "Proveedores (nombre,direccion,cp,nomfiscal,dirfiscal,cpfiscal,cif,"
			cs=cs & "webcadena,localidad,Comision,Prepago)"

			cs=cs & " VALUES ('" & nombre & "','" & direccion & "','" & cp & "','" & nomfiscal & "','"
			cs=cs & dirfiscal & "','" & cpfiscal & "','" & cif & "','" & web & "','"
			cs=cs & localidad & "'," & quitarComa(comision) & "," & quitarComa(prepago) & ")"
			'response.write cs
			base.execute cs
			Response.Redirect(mipag) 		
		case "actu"
			nombre=QuitarApos(request.form("nombre"))
			direccion=QuitarApos(request.form("direccion"))
			cp=request.form("cp")
			nomfiscal=QuitarApos(request.form("nomfiscal"))
			dirfiscal=QuitarApos(request.form("dirfiscal"))
			cpfiscal=request.form("cpfiscal")
			cif=request.form("cif")
			web=request.form("web")
			comision=request.form("comision")
			prepago=request.form("prepago")
			localidad=QuitarApos(request.form("loc"))
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Proveedores SET "
			cs=cs & "nombre='" & nombre & "',"
			cs=cs & "direccion='" & direccion & "',"
			cs=cs & "cp='" & cp & "',"
			cs=cs & "nomfiscal='" & nomfiscal & "',"
			cs=cs & "dirfiscal='" & dirfiscal & "',"
			cs=cs & "cpfiscal='" & cpfiscal & "',"
			cs=cs & "cif='" & cif & "',"
			cs=cs & "webcadena='" & web & "',"
			cs=cs & "Comision=" & quitarComa(comision) & ","
			cs=cs & "Prepago=" & quitarComa(prepago) & ","
			cs=cs & "localidad='" & localidad & "' "
			cs=cs & "WHERE Id=" & MiId
			response.write cs
			base.execute cs
			Response.Redirect(mipag)
	end select
end if
'Los proveedores
cs="SELECT id,Nombre,nomfiscal,cp,cif,Comision FROM " & precrs & "Proveedores " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayProvee=false
if not rs.eof then
	Regprovee=rs.GetRows
	'Variables para la tabla RegProvee
	PCodi=0
	PNombre=1
	Pnomfiscal=2
	Pcp=3
	Pcif=4
	PComis=5
	Hayprovee=true
end if
rs.close

laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Proveedores "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		direccion=rs("direccion")
		cp=rs("cp")
		nomfiscal=rs("nomfiscal")
		dirfiscal=rs("dirfiscal")
		cpfiscal=rs("cpfiscal")
		cif=rs("cif")
		web=rs("webcadena")
		localidad=rs("localidad")
		comision=rs("comision")
		prepago=rs("prepago")
	end if
	rs.close
	cs="SELECT id,nombre,apellidos,cargo FROM " & precrs & "contactos WHERE idpro=" & laid 
	rs.open cs,base
	Haycontactos=false
	if not rs.eof then
	RegContactos=rs.getrows
		RCid=0
		RCnombre=1
		RCapellidos=2
		RCcargo=3
		haycontactos=true
	end if
	rs.close
	cs="SELECT establecimientos.CodigoEsta,nombre FROM " & precrs & "establecimientos INNER JOIN datoshotel ON establecimientos.codigoesta=datoshotel.codigoesta WHERE Idpro=" & laid
	rs.open cs,base
	Hayhotelencadena=false
	if not rs.eof then
		Reghotelcad=rs.getrows
		RhCid=0
		RhCnombre=1
		Hayhotelencadena=true
	end if
	'response.write hayhotelencadena & " --- " & Reghotelcad(RhCid,0)
	rs.close
end if


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
		document.f1.action="<%=MiPag%>?id=<%=MiId%>&modo=borra";
		document.f1.submit();
	}
}

function Modificar(){
	//alert ("modo");
	if (document.f1.id.value==""){
	//alert ("modo nuevo");
		document.f1.action="<%=MiPag%>?id=<%=laid%>&modo=nuevo";
	}else{
	//	alert ("modo actualizar");
		document.f1.action="<%=MiPag%>?id=<%=laid%>&modo=actu";
	}
	document.f1.submit();
}
function enBlanco(){
	palIframe(document.getElementById("verFicha"),450,370,0,0,"verProveedor.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),510,370,0,0,"verProveedor.asp?id="+id+"&est=<%=est%>");
}

function queAplica(){
	//Funcion para desactivar habit. o suple. si no se usa
	valor=document.f1.aplicar.value;

	switch(valor) {
		case "0": //Todos
		  document.f1.habi.options[0].text="Cualquiera";
		  document.f1.suple.options[0].text="Cualquiera";
		  document.f1.habi.value='0';
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=false;
		  break;

		case "1": //Habitacion
			if (document.f1.habi.value=="0"){
				  document.f1.habi.options[0].text="Cualquiera";
				  document.f1.habi.value='0';				  
				 }
		  document.f1.suple.options[0].text="No se usa";
		  document.f1.suple.value='0';
		  document.f1.habi.disabled=false;
		  document.f1.suple.disabled=true;
		  break;
	
		case "2": //Suplemento
		  document.f1.habi.options[0].text="No se usa";
		  document.f1.habi.value='0';
			if (document.f1.suple.value=="0"){
				  document.f1.suple.options[0].text="Cualquiera";
				  document.f1.suple.value='0';
				 }
		  document.f1.habi.disabled=true;
		  document.f1.suple.disabled=false;
		  break;
    }	
	

}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
	<br>
		<!--#'include file="Seleccionado.asp"-->
	<table align="center" border="0" cellpadding="0" cellspacing="0" style="margin-top:48px;">
	<!--<tr><td align='left'>-->
	<!--* Este listado de temporadas depende del establecimiento seleccionado en la parte de arriba.-->
	<!--</td></tr>-->
	<tr><td align='right'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nuevo Proveedor&nbsp;'>
		<input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">PROVEEDORES</div></td></tr>
  <tr><td class="tdTabla">
	<!-- tabla -->
<table border="0" cellpadding="0" cellspacing="0" width='650' align='center'>
	<tr class='cabetabla'>
	 <th class="colu_par">Borrar</th>
	<th align='left' class="colu_impar">Nombre</th>
	<th align='left' class="colu_par">Nombre fiscal</th>
	<th align='center' class="colu_impar">Cif</th>
	<th align='right' class="colu_par">Comision</th>
	</tr>
	<%if Hayprovee then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=0 to ubound(Regprovee,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>

	<tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
		<input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=Regprovee(PCodi,r)%>">
	  </td>
	  <td align="left" class='<%=laColu(1)%>' >
	  	<a href='javascript:verFicha(<%=Regprovee(PCodi,r)%>)'><%=RegProvee(Pnombre,r)%></a>
	</td>
	<td align="left" class='<%=laColu(0)%>' >
	  	<a href='javascript:verFicha(<%=Regprovee(PCodi,r)%>)'><%=RegProvee(Pnomfiscal,r)%></a>
	</td>
	<td align="left" class='<%=laColu(1)%>' >
	  	<a href='javascript:verFicha(<%=Regprovee(PCodi,r)%>)'><%=RegProvee(Pcif,r)%></a>
	</td>
	<td align="right" class='<%=laColu(0)%>' >
	  	<%=RegProvee(PComis,r)%>
	</td>
	</tr>
	<%next
	end if%></table>
	</td></tr>
</table>
	
</td></tr>
</table>

<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
