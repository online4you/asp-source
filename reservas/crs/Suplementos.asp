<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if not esAdmin then 'Usuario con hotel
	busco="WHERE "
	buenos=split(request.Cookies("HotelBoss"),";")
	for b=0 to ubound(buenos)
		if isnumeric(buenos(b)) then
			busco=busco & "CodigoEsta=" & buenos(b) & " OR "
		end if
	next
	busco=left(busco,len(busco)-4)
else
	busco="" 'es administrado saca todos los hoteles
end if
'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM Suplementos WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "CodigoSuple=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			
			'Borrar en Suplelemtos precios
			cs="DELETE FROM " & precrs & "SuplementosTempo SuplementosTempo WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "CodigoSuple=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs

			'Borrar en Dtos suple
			cs="DELETE FROM " & precrs & "DescuentosSuple DescuentosSuple WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "CodigoSuple=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs

		end if
		
	case "nuevo" 'Añadir
		nombre_es=QuitarApos(request.form("nombre_es"))
		nombre_it=QuitarApos(request.form("nombre_it"))
		nombre_en=QuitarApos(request.form("nombre_en"))
		nombre_de=QuitarApos(request.form("nombre_de"))
		nombre_fr=QuitarApos(request.form("nombre_fr"))
		
		'Añadir en suplementos
		cs="INSERT INTO " & precrs & "Suplementos (CodigoEsta,Nombre_es,Nombre_it,Nombre_en,"
		cs=cs & "Nombre_de,Nombre_fr) VALUES ("& est & ",'"
		cs=cs & nombre_es & "','" & nombre_it & "','" & nombre_en & "','" & nombre_de & "','"
		cs=cs & nombre_fr & "')"
		base.execute cs
		
		
	case "actu"
		MiId=request.form("id")
		nombre_es=QuitarApos(request.form("nombre_es"))
		nombre_it=QuitarApos(request.form("nombre_it"))
		nombre_en=QuitarApos(request.form("nombre_en"))
		nombre_de=QuitarApos(request.form("nombre_de"))
		nombre_fr=QuitarApos(request.form("nombre_fr"))
		
		'Actualiza Nombres
		cs="UPDATE " & precrs & "Suplementos SET "
		cs=cs & "Nombre_es='" & nombre_es & "',"
		cs=cs & "Nombre_it='" & nombre_it & "',"
		cs=cs & "Nombre_en='" & nombre_en & "',"
		cs=cs & "Nombre_de='" & nombre_de & "',"
		cs=cs & "Nombre_fr='" & nombre_fr & "' "
		cs=cs & "WHERE CodigoSuple=" & MiId
		base.execute cs

		
end select

laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Suplementos "
	cs=cs & "WHERE CodigoSuple=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre_es=rs("nombre_es")
		nombre_it=rs("nombre_it")
		nombre_en=rs("nombre_en")
		nombre_de=rs("nombre_de")
		nombre_fr=rs("nombre_fr")
	end if
	rs.close
end if

'Lista de registros
cs="SELECT CodigoSuple,Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr FROM " & precrs & "Suplementos "
cs=cs & "WHERE CodigoEsta=" & est
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNom_es=1
	RNom_it=2
	RNom_en=3
	RNom_de=4
	RNom_fr=5
	haylista=true
end if
rs.close
set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
body {
	background-color: #F2f2f2;
}
-->
</style>

</head>
<script language="javascript">
function ABorrar(){
	if (confirm("Este proceso también borra los ficheros\nrelacionados con el suplemento.\n¿Está seguro/a?")){
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
	palIframe(document.getElementById("verFicha"),450,200,0,0,"verTiposHotel.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),510,200,0,0,"verTiposHotel.asp?id="+id+"&est=<%=est%>");
}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr><td align='left'>
	* Este listado de suplementos depende del establecimiento seleccionado en la parte de arriba.<br>
	<b>* Los precios de los suplementos se indicarán en el módulo de habitaciones.</b>
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nuevo Suplemento&nbsp;'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='&nbsp;Borrar Marcados&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">SUPLEMENTOS</div></td></tr>
  <tr><td class="tdTabla">
	<!-- tabla -->
<table border="0" cellpadding="0" cellspacing="0" width='650' align='center'>
	<tr class='cabetabla'>
	 <th>Borrar</th>
	<th>ID</th>
	<th align='left' class="colu_par">Nombre Esp.</th>
	<th align='left' class="colu_par">Nombre Ita.</th>
	<th align='left' class="colu_par">Nombre Ing.</th>
	<th align='left' class="colu_par">Nombre Ale.</th>
	<th align='left' class="colu_par">Nombre Fr.</th>
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
	  </td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_es,r)%></a>
	</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_it,r)%></a>
	</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_en,r)%></a>
	</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_de,r)%></a>
	</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
	  	<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_fr,r)%></a>
	</td>
	  </tr>
	  <%
	next
	end if%>
	
	<tr><td height='25' colspan='6'></tr>
	</table>
	</td></tr>
</table>
	
</td></tr>
</table>

<div id='panel' style='position:absolute; z-index:10; top:100; left:200; width:360; height:160; visibility:hidden;' class='texto10BLANCO'>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">SUPLEMENTO</div></td></tr>
  <tr>
    <td height="33" class="tdTabla" background="img/corners/i.gif">&nbsp;</td>
    <td class="tdTabla">

<table align='center' width='350' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='right'>Nombre Esp.:</td>
		<td align='left'><input type='text' size='60' maxlength='75' name='nombre_es' value='<%=nombre_es%>'></td></tr>
	<tr><td align='right'>Nombre Ita.:</td>
		<td align='left'><input type='text' size='60' maxlength='75' name='nombre_it' value='<%=nombre_it%>'></td></tr>
	<tr><td align='right'>Nombre Ing.:</td>
		<td align='left'><input type='text' size='60' maxlength='75' name='nombre_en' value='<%=nombre_en%>'></td></tr>
	<tr><td align='right'>Nombre Ale.:</td>
		<td align='left'><input type='text' size='60' maxlength='75' name='nombre_de' value='<%=nombre_de%>'></td></tr>
	<tr><td align='right'>Nombre Fr.:</td>
		<td align='left'><input type='text' size='60' maxlength='75' name='nombre_fr' value='<%=nombre_fr%>'></td></tr>
	<tr><td align='center' colspan='2'>
		<input id='boton' type='button' value='Actualizar' onclick="javascript:Modificar();" style='cursor:pointer'>	
		<input type='hidden' name='id' value='<%=laid%>'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"value="Cerrar" onClick="javascript:cerrar();" style='cursor:pointer'></td></tr>
</table>

	</td>
    <td class="tdTabla"><div align="right"></div></td>
  </tr>
</table>

</div>

<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
