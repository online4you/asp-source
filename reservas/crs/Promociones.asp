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
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos " & busco
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

est=request.QueryString("est")
if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
est=clng(est)

if request.form<>"" then
	modo=request.QueryString("modo")
	codigo=request.form("codigo")
	agencia=request.form("agencia")
	codigoesta=request.form("codigoesta")
	prepago=request.form("prepago")
	descuento=request.form("descuento")
	pelas=request.form("importe")
	if pelas="" then pelas=0
	titulo_es=quitarApos(request.form("titulo_es"))
	titulo_it=quitarApos(request.form("titulo_it"))
	titulo_en=quitarApos(request.form("titulo_en"))
	titulo_de=quitarApos(request.form("titulo_de"))
	titulo_fr=quitarApos(request.form("titulo_fr"))
	activa=request.form("activa")
	if activa="" then activa=0
	fini=request.form("fechainicio")
	if fini="" or not isdate(fini) then
		errorfecha="Fechas Incorrectas"
	end if
	ffin=request.form("fechafinal")
	if ffin="" or not isdate(ffin) then
		errorfecha="Fechas Incorrectas"
	end if
	if modo<>"borra" then
		if errorfecha<>"" then 'Las fechas no son buenas
			response.write "<html><body><center><h3>" & errorfecha & "<br><br>" & vbcrlf
			response.write "<a href='javascript:window.history.back();'>VOLVER</a></center>" & vbcrlf
			response.Write "</body></html>"
	
			set rs=nothing
			base.close
			set base=nothing
			response.End()
		end if
	end if
	
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "Promociones WHERE "
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
			cs="INSERT INTO " & precrs & "Promociones (Codigo,Agencia,CodigoEsta,"
			cs=cs & "Titulo_es,Titulo_it,Titulo_en,Titulo_de,Titulo_fr,"
			cs=cs & "Activa,FechaInicio,FechaFin,Prepago,Descuento,Importe) VALUES ('"
			cs=cs & codigo & "'," & agencia & "," & codigoesta & ",'"
			cs=cs & titulo_es & "','" & titulo_it & "','" & titulo_en & "','"
			cs=cs & titulo_de & "','" & titulo_fr & "'," & activa & ","
			cs=cs & FechaMySQL(fini) & "," & FechaMySQL(ffin) & ","
			cs=cs & prepago & "," & descuento & "," & quitarComa(pelas) & ")"
			base.execute cs
			
		case "actu"
			MiId=request.form("id")
			cs="UPDATE " & precrs & "Promociones SET "
			cs=cs & "Codigo='" & codigo & "',"
			cs=cs & "CodigoEsta=" & codigoesta & ","
			cs=cs & "Agencia=" & agencia & ","
			cs=cs & "Titulo_es='" & titulo_es & "',"
			cs=cs & "Titulo_it='" & titulo_it & "',"
			cs=cs & "Titulo_en='" & titulo_en & "',"
			cs=cs & "Titulo_de='" & titulo_de & "',"
			cs=cs & "Titulo_fr='" & titulo_fr & "',"
			cs=cs & "FechaInicio=" & FechaMySQL(fini) & ","
			cs=cs & "FechaFin=" & FechaMySQL(ffin) & ","
			cs=cs & "Activa=" & activa & ","
			cs=cs & "Prepago=" & prepago & ","
			cs=cs & "Descuento=" & descuento & ","
			cs=cs & "Importe=" & quitarComa(pelas) & " "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs & "<br>"
			base.execute cs
			
			
			
	end select
end if 'request.Form

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * "
	cs=cs & "FROM " & precrs & "Promociones "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		codigo=rs("codigo")
		agencia=rs("agencia")
		titulo_es=rs("titulo_es")
		titulo_it=rs("titulo_it")
		titulo_en=rs("titulo_en")
		titulo_de=rs("titulo_de")
		titulo_fr=rs("titulo_fr")
		activa=rs("activa")
		fini=rs("fechainicio")
		ffin=rs("fechafin")
		prepago=rs("prepago")
		descuento=rs("descuento")
		pelas=rs("importe")
	end if
	rs.close
end if

'Lista de registros
cs="SELECT Promociones.Id,Codigo,Titulo_es,FechaInicio,FechaFin,Agencias.Nombre,Establecimientos.Nombre "
cs=cs & "FROM (" & precrs & "Promociones Promociones LEFT JOIN " & precrs & "Agencias Agencias "
cs=cs & "ON Promociones.Agencia=Agencias.Id) LEFT JOIN Establecimientos "
cs=cs & "ON Promociones.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE Promociones.CodigoEsta=" & est
cs=cs & " ORDER BY Promociones.Id DESC"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RId=0
	RCodi=1
	RTitu=2
	RFIni=3
	RFFin=4
	RAgencia=5
	RHotel=6
	haylista=true
end if
rs.close

'Tabla de agencias
cs="SELECT Id,Nombre FROM " & precrs & "Agencias ORDER BY Nombre"
rs.Open cs, base
hayagencias=false
if not rs.eof then
	RegAgencias=rs.GetRows
	ACodi=0
	ANombre=1
	hayagencias=true
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
	if (document.f1.codigoesta.value=="0" || document.f1.codigo.value==""){
		alert("faltan datos");
		return false;
		}

	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu";

	document.f1.submit();
}
function enBlanco(){
	document.f1.codigo.value="";
	document.f1.codigoesta.value="0";
	document.f1.agencia.value="0";
	document.f1.titulo_es.value="";
	document.f1.titulo_it.value="";
	document.f1.titulo_en.value="";
	document.f1.titulo_de.value="";
	document.f1.titulo_fr.value="";
	document.f1.fechainicio.value="";
	document.f1.fechafinal.value="";
	document.f1.prepago.value="0";
	document.f1.descuento.value="0";
	document.f1.activa.checked=true;
	document.getElementById('boton').value=" Añadir ";
	document.f1.id.value="";
	document.getElementById('panel').style.visibility='visible';
	document.f1.codigo.focus();
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
	<tr><td align='left' class="style1b">
	* Este listado de temporadas depende del establecimiento seleccionado en la parte de arriba.
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" onclick="javascript:enBlanco();" value='&nbsp;Nueva Promocion&nbsp;'><input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">PROMOCIONES</div></td></tr>
  <tr><td class="tdTabla">
      <table width='600' border="0" align='center' cellpadding="0" cellspacing="0" bordercolor="#F2f2f2">
      <tr class='cabetabla'>
        <th>&nbsp;</th>
		<th align="center">Código</th>
		<th align="left">Promoción</th>
		<th align="center">Fechas</th>
		<th align="left">Agencia</th>
		<th align="left">Hotel</th>
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
          <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RId,r)%>">
        </td>
        <td align="center" class='<%=laColu(0)%>' >
		<a href='<%=MiPag%>?est=<%=est%>&id=<%=RegLista(RId,r)%>'><%=RegLista(RCodi,r)%></a> </td>
        <td align="left" class='<%=laColu(0)%>' >
          <a href='<%=MiPag%>?est=<%=est%>&id=<%=RegLista(RId,r)%>'><%=RegLista(RTitu,r)%></a>
        </td>
        <td align="center" class='<%=laColu(0)%>' >
          <a href='<%=MiPag%>?est=<%=est%>&id=<%=RegLista(RId,r)%>'>
		  <%=VerFecha(RegLista(RFIni,r))%> - <%=VerFecha(RegLista(RFFin,r))%></a>
        </td>
        <td align="left" class='<%=laColu(0)%>' >
          <%=RegLista(RAgencia,r)%>
        </td>
        <td align="left" class='<%=laColu(0)%>' >
          <%=RegLista(RHotel,r)%>
        </td>
      </tr>
	<%next
	end if%>
      <tr>
        <td height='25' colspan='6'>    
      </tr>
    </table>
	</td></tr>
</table>
</td></tr>
</table>
<div id='panel' style='position:absolute; z-index:10; top:100; left:200px; width:300px; height:300px; visibility:hidden; overflow:visible'>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">PROMOCIÓN</div></td></tr>
  <tr><td class="tdTabla">
	<table align='center' width='350' border='0' cellpadding="0" cellspacing="2">
      <tr>
        <td align='right'>Código Prom.:</td>
        <td align='left'><input type='text' size='10' maxlength='15' name='codigo' value='<%=codigo%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Promoción Esp.:</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='titulo_es' value='<%=titulo_es%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Promoción It.:</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='titulo_it' value='<%=titulo_it%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Promoción Ing.:</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='titulo_en' value='<%=titulo_en%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Promoción Ale.:</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='titulo_de' value='<%=titulo_de%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Promoción Fra.:</td>
        <td align='left'><input type='text' size='50' maxlength='75' name='titulo_fr' value='<%=titulo_fr%>'>
		</td>
      </tr>
      <tr>
        <td align='right'>Desde d&iacute;a</td>
        <td align='left'>
          <input type='text' name="fechainicio" value='<%=verFecha(fini)%>' maxlength="10" size='8'>
&nbsp;&nbsp; Hasta d&iacute;a
      <input type='text' name="fechafinal" value='<%=verFecha(ffin)%>' maxlength="10" size='8'>
      (d&iacute;a/mes/a&ntilde;o)</td>
      </tr>
      <tr>
        <td align='right'>Agencia:</td>
        <td align='left'>
		<select name="agencia">
			<option value="0">Seleccionar</option>
			<%if hayagencias then
				for a=0 to ubound(RegAgencias,2)
					marca=""
					if agencia=RegAgencias(ACodi,a) then marca=" selected"%>
					<option value="<%=RegAGencias(ACodi,a)%>"<%=marca%>><%=RegAGencias(ANombre,a)%></option>
				<%next
			end if%>
		</select>
		</td>
      </tr>
      <tr>
        <td align='right'>Hotel:</td>
        <td align='left'>
		<select name="codigoesta">
			<option value="0">Seleccionar</option>
			<%if hayhoteles then
				for h=0 to ubound(RegHoteles,2)
					marca=""
					if est=RegHoteles(HCodi,h) then marca=" selected"%>
					<option value="<%=RegHoteles(HCodi,h)%>"<%=marca%>><%=RegHoteles(HNombre,h)%></option>
				<%next
			end if%>
		</select>
		</td>
      </tr>
	<tr>
        <td align='right'>Prepago:</td>
        <td align='left'><input type='text' size='5' maxlength='8' name='prepago' value='<%=prepago%>'> %
		</td>
      </tr>	  
	<tr>
        <td align='right'>Descuento:</td>
        <td align='left'><input type='text' size='5' maxlength='8' name='descuento' value='<%=descuento%>'> %  o Importe <input type='text' size='5' maxlength='8' name='importe' value='<%=pelas%>'> &euro;
		</td>
      </tr>	  
	<tr>
        <td align='right'>Activa:</td>
        <td align='left'><input type='checkbox' name='activa' value="1"<%if activa then response.write " checked"%>>
		</td>
      </tr>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" type='button' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
          <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
      </tr>
    </table>
	</td></tr>
</table>

</div>

<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
