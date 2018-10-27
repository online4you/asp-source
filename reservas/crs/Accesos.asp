<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set base2=server.createobject("ADODB.Connection")
base2.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("acti")
MiId=clng("0" & request.QueryString("id"))
if est<>"" then 'viene un valor, hay que añadir
	cs="INSERT INTO " & precrsgen & "permisosporesta (IdUsuario,CodigoEsta) VALUES ("
	cs=cs & MiId & "," & est & ")"
	base.execute cs
end if

'Comprobar si hay que borrar permisos de hotel
queborro=split(request.form("elimina"),",")
if ubound(queborro)>=0 then
	cadena="("
	for t=0 to ubound(queborro)
		cadena=cadena & "CodigoEsta=" & trim(queborro(t)) & " OR "
	next
	if right(cadena,4)=" OR " then 'Quitar el ultimo operador
		cadena=left(cadena,len(cadena)-4)
	end if	
	cadena=cadena & ") AND IdUsuario=" & MiId
	'Borrar en permisos hotels
	cs="DELETE FROM " & precrsgen & "permisosporesta WHERE " & cadena
	base.execute cs
end if

%><!--#include file="actuAccesos.asp"--><%


'Tabla de usuarios
cs="SELECT Id,Usuario,Clave,Nombre,Nivel FROM " & precrsgen & "usuarios usuarios "
if clng("0" & request.Cookies("IdEmpresa"))=0 then 'the boss
	cs=cs & "ORDER BY IdEmpresa,Nombre"
else
	cs=cs & "WHERE IdEmpresa=" & request.Cookies("IdEmpresa") & " ORDER BY IdEmpresa,Nombre"
end if
rs.open cs,base
hayuser=false
if not rs.eof then
	RegUser=rs.getrows
	UId=0
	UNick=1
	UPass=2
	UNombre=3
	UNivel=4
	hayuser=true
end if
rs.close

'Tabla de Hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrsgen & "establecimientos ORDER BY Nombre"
rs.open cs,base2
hayhotel=false
if not rs.eof then
	RegHotel=rs.getrows
	HCodi=0
	HNombre=1
	hayhotel=true
end if
rs.close

laid=clng("0" & laid)
if laid=0 then
	laid=clng("0" & request.QueryString("id"))
end if
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrsgen & "usuarios WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		nick=rs("usuario")
		pass=rs("clave")
		nivel=rs("nivel")
	end if
	rs.close
	
	'Buscar hoteles del usuario
	cs="SELECT CodigoEsta FROM " & precrsgen & "permisosporesta "
	cs=cs & "WHERE IdUsuario=" & laid
	hayphotel=false
	rs.open cs,base
	if not rs.eof then
		RegPHotel=rs.getrows
		HPCodi=0
		hayphotel=true
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing
base2.close
set base2=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	palIframe(document.getElementById("verFicha"),650,290,0,0,"verUsuario.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),650,290,0,0,"verUsuario.asp?id="+id+"&recarga="+self.name);
}
var ultimoFrame="";

function nuevoHotel(){
	acti=document.f1.hotel.value;
	if (acti=='0'){
		alert("No se ha seleccionado Establecimiento");
		return false;
	}
	window.location="<%=MiPag%>?id=<%=laid%>&acti="+acti;
}

function borraHotel(){
	document.f1.action="<%=MiPag%>?id=<%=laid%>";
	document.f1.submit();
}

</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<div id='principal' style="width:600px;">
	<input type='button' value='Menu Anterior' onclick="javascript:window.location='../index.asp';" class="boton145">
	<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
		<tr><td align='right' colspan='5'>
		<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Usuario'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
		</td>
		</tr>
		<tr><td colspan="5" align="left" class="tituloTabla">Usuarios</td></tr>
		<tr>
		<th align="center" class='colu_par'>Borrar</th>
		<th align='left' class="colu_impar">Nombre</th>
		<th align='left' class="colu_par">Nick</th>
		<th align='left' class="colu_impar">Password</th>
		<th align='left' class="colu_par">Nivel</th>
		</tr>
		<%if hayuser then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=0 to ubound(RegUser,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
		<tr>
		<td align="center" class='<%=laColu(0)%>'>
		  <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegUser(UId,r)%>" class="<%=laColu(0)%>">
		</td>
		<td align="left" class='<%=laColu(1)%>'>
		  <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNombre,r)%></a>
		</td>
		<td align="left" class='<%=laColu(0)%>'>
		  <%=RegUser(UNick,r)%>
		</td>
		<td align="left" class='<%=laColu(1)%>'>
		  <%=RegUser(UPass,r)%>
		</td>
		<td align="left" class='<%=laColu(0)%>'>
		  <%=nombreNivel(RegUser(UNivel,r))%>
		</td>
		</tr>
		<%next
		end if%>
		<tr><td height='15' colspan='5'></td></tr>
		<tr><td align='right' colspan='5'>
		<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Usuario'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
		</td>
		</tr>
		
	</table>
</div> <!-- principal -->
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verBHotel' name='verBHotel' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>