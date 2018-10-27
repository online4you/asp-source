<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))

if request.Form<>"" then
	paroni=request.form("inicioparon")
	paronf=request.form("finalparon")
	elcupo=paClng(request.form("cupo"))
	lashabis=request.form("thabi")
	
	if not isdate(paroni) or not isdate(paronf) then
		msgerror="<center><h3>Error en las fechas</h3></center>"
	
	else 'parar venta
		paroni=cdate(paroni)
		paronf=cdate(paronf)
		'Buscar los tipos de habitaciones
		set rs2=server.createobject("ADODB.Recordset")
		rs2.CursorLocation = adUseServer
		rs2.CursorType=adOpenForwardOnly
		rs2.LockType=adLockReadOnly
	
		'buscar que habis
		listahabis=split(request.form("lashabis"),",")
		cadena=""
		for t=0 to ubound(listahabis)
			if trim(listaHabis(t))="0" then 'todas
				cadena=""
				exit for
			end if
			cadena=cadena & "Id=" & trim(listahabis(t)) & " OR "
		next
		if right(cadena,4)=" OR " then 'Quitar el ultimo operador
			cadena=left(cadena,len(cadena)-4)
		end if	
				
		'Guarda seguimiento
		controlRegistro("Cupo ventas de " & paroni & " hasta " & paronf & " de Hab. " & lashabis & " - cupo:" & elcupo) 'guarda seguimiento
	
		cs= "SELECT Id "
		cs=cs & "FROM " & precrs & "TipoHabitaNombres "
		cs=cs & "WHERE CodigoEsta=" & est 
		if cadena<>"" then 'poner las habitaciones
			cs=cs & " AND (" & cadena & ")"
		end if
		'response.write cs & "<br><br>"
		rs2.open cs,base
		do while not rs2.eof	
		
			for fechaparon=paroni to paronf
				'Si existe, actualizarlo
				cs="SELECT Dia FROM " & precrs & "Cupos WHERE Dia=" & FechaMySQL(fechaparon)
				cs=cs & " AND CodigoHab=" & rs2("Id")
				rs.open cs,base
				if not rs.eof then 'Actualizar
					cs="UPDATE " & precrs & "Cupos SET Cupo=" & elcupo
					cs=cs & " WHERE Dia=" & FechaMySQL(fechaparon) & " AND CodigoHab=" & rs2("Id")
					base.execute cs
				else 'Añadir
					cs="INSERT INTO " & precrs & "Cupos (CodigoHab,CodigoEsta,Dia,Cupo) VALUES ("
					cs=cs & rs2("Id") & "," & est & "," & FechaMySQL(fechaparon) & "," & elcupo & ")"
					base.execute cs
				end if 'rs2.eof
				rs.close
			
			next
			controlRegistro("Paron ventas de "&paroni&" hasta "&paronf) 'guarda seguimiento
			rs2.movenext
		loop
		rs2.close
		set rs2=nothing
		msgerror="<center><h3>Fechas Actualizadas</h3></center>"
	
	end if 'guenas fechas
end if 'form<>""

'Lista habitaciones
cs= "SELECT Id,Nombre_es "
cs=cs & "FROM " & precrs & "TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
cs=cs & " ORDER BY Orden,Id"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.getrows
	HCodi=0
	HNombre=1
	haylista=true
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
	/*encogeCapa(parent.document.getElementById('verFicha'));
	parent.document.getElementById('verFicha').style.visibility='hidden';*/
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?ff=<%=ff%>&fc=<%=fc%>&est=<%=est%>";
	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">CUPO GENERAL</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table cellpadding="0" cellspacing="2" border="0">
	<%if request.Form="" then%>
	<tr><td colspan="2" align="left">
		Cambia el cupo de las habitaciones de este hotel.</td></tr>	
	<tr><td align="right" valign="top">Habitaciones:</td>
		<td align="left">
			<div style="height:95px; overflow-y:scroll; overflow-x:hidden">
			<input type="checkbox" name="thabi" value="0" checked>Todas<br/>
			<%if haylista then
			for h=0 to ubound(RegLista,2)%>
			<input type="checkbox" name="thabi" value="<%=RegLista(HCodi,h)%>"><%=RegLista(HNombre,h)%><br/>
			<%next
			end if%>		
			</div>
		</td>
	</tr>
	<tr><td align="right">Fecha Inicial:</td>
		<td align="left"><input type="text" name="inicioparon" maxlength="12" size="12"> (dd/mm/aa)&nbsp;
		<img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('inicioparon','f1',self.name,'');" style="cursor:pointer">
		</td></tr>
	<tr><td align="right">Fecha Final:</td>
		<td align="left"><input type="text" name="finalparon" maxlength="12" size="12"> (dd/mm/aa)&nbsp;
		<img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('finalparon','f1',self.name,document.f1.inicioparon.value);" style="cursor:pointer">
		</td></tr>
	<tr><td align='right'>Cupo:</td>
		<td align='left'>
		<input type="text" name="cupo" maxlength="5" size="4" value="0"> valor numérico (0=cierra ventas)
		</td>
	</tr>
	<tr><td colspan="2" height="5"></td></tr>
	<%else%>
		<tr><td align='left' colspan='2'><%=msgerror%></td></tr>
	<%end if%>
      <tr>
        <td align='center' colspan='2'>
          <input name="button" type='button' class='boton86' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='Aceptar'>
          <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
      </tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	document.f1.inicioparon.focus();
</script>
</body>
</html>