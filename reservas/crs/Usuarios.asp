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
	cs="INSERT INTO " & precrsgen & "PermisosPorEsta (IdUsuario,CodigoEsta) VALUES ("
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
	cs="DELETE FROM " & precrsgen & "PermisosPorEsta WHERE " & cadena
	base.execute cs
end if

if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	select case modo
		case "borra"
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cadena=""
				for t=0 to ubound(queborro)
					cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
				next
				if right(cadena,4)=" OR " then 'Quitar el ultimo operador
					cadena=left(cadena,len(cadena)-4)
				end if	
				'Borrar en Usuaris
				cs="DELETE FROM Usuarios WHERE " & cadena
				base.execute cs
				
				'Borrar en permisos
				cadena=replace(cadena,"Id=","IdUsuario=")
				cs="DELETE FROM PermisosPorEsta WHERE " & cadena
				base.execute cs
			end if
		
		case "actu"
			nombre=QuitarApos(request.form("nombre"))
			nick=QuitarApos(request.form("nick"))
			pass=QuitarApos(request.form("pass"))
			nivel=request.form("nivel")
			cs="UPDATE " & precrsgen & "Usuarios SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "Usuario='" & nick & "',"
			cs=cs & "Clave='" & pass & "',"
			cs=cs & "Nivel=" & nivel & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			nombre=QuitarApos(request.form("nombre"))
			nick=QuitarApos(request.form("nick"))
			pass=QuitarApos(request.form("pass"))
			nivel=request.form("nivel")
			cs="INSERT INTO " & precrsgen & "Usuarios (Usuario,Clave,Nombre,Nivel,IdEmpresa) VALUES ('"
			cs=cs & nick & "','" & pass & "','" & nombre & "'," & nivel & "," & clng("0" & request.Cookies("IdEmpresa")) & ")"
			base.execute cs
			
			'Buscar el ult. registro
			cs="SELECT MAX(Id) as Ultimo FROM " & precrsgen & "Usuarios"
			rs.open cs,base
			if not rs.eof then
				laid=rs("Ultimo")
			end if
			rs.close
			
	end select


end if


'Tabla de usuarios
cs="SELECT Id,Usuario,Clave,Nombre,Nivel FROM " & precrsgen & "Usuarios "
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
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos ORDER BY Nombre"
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
	cs="SELECT * FROM " & precrsgen & "Usuarios WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		nick=rs("usuario")
		pass=rs("clave")
		nivel=rs("nivel")
	end if
	rs.close
	
	'Buscar hoteles del usuario
	cs="SELECT CodigoEsta FROM " & precrsgen & "PermisosPorEsta "
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
<html>
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
	palIframe(document.getElementById("verFicha"),400,240,0,0,"verUsuario.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),600,300,0,0,"verUsuario.asp?id="+id+"&recarga="+self.name);
}
var ultimoFrame="";
</script>
<body>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align='left' cellpadding="0" cellspacing="0">
	<tr><td align='center' width='100' valign='top'>
		<!--#include file="menuIzq.asp"--></td>
		<td align="left" width="700">
		
	<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
	<tr>
		<td align='right' colspan='5'>
		<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nuevo Usuario'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcados'>
		</td>
		</tr>
		<tr><td colspan="5" height="5"></td></tr>
	  <tr>
		<td class="tituloTabla" colspan="5" align="left" >Usuarios</td></tr>
          <tr>
            <th class="colu_par">Borrar</th>
            <th align='left' class="colu_impar">Nombre</th>
			<th align='left' class="colu_par">Nick</th>
			<th align='left' class="colu_impar">Password</th>
			<th align='left' class="colu_par">Nivel</th>
          </tr>
          <%if hayuser then
			  
		for R=0 to ubound(RegUser,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if
			%>
          <tr><td align="center" width='10' class='<%=laColu(0)%>'>
              <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegUser(UId,r)%>">
            </td>
			<td align="left" class='<%=laColu(0)%>'>
              <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNombre,r)%></a>
            </td>
			<td align="left" class='<%=laColu(0)%>'>
              <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNick,r)%></a>
            </td>
			<td align="left" class='<%=laColu(0)%>'>
              <%=RegUser(UPass,r)%>
            </td>
            <td align="left" class='<%=laColu(0)%>' >
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
	</td></tr>
</table>
</form>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
<iframe id='verBHotel' name='verBHotel' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</body>
</html>
