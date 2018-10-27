<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

if request.form<>"" then 'actualiza
	modo=request.QueryString("modo")
	if modo<>"borra" then
		fini=request.form("fechainicio")
		ffin=request.form("fechafinal")
		if not isdate(fini) or not isdate(ffin) then 'Fechas incorrectas
			response.write "<html><body><h2>Fechas Incorrectas</h2>"
			response.write "<br><br><input type='button' value='volver' onclick='javascript:window.history.back();'"
			response.write "</body></html>"
			response.End()
		end if
		extra_es=quitarApos(request.form("extra_es"))
		extra_it=quitarApos(request.form("extra_it"))
		extra_en=quitarApos(request.form("extra_en"))
		extra_de=quitarApos(request.form("extra_de"))
		extra_fr=quitarApos(request.form("extra_fr"))
		importe=quitarcoma(request.form("importe"))
		if importe="" then importe=0
		descuento=quitarcoma(request.form("descuento"))
		if descuento="" then descuento=0
		colectivo=request.form("colectivo")
		if colectivo="" then colectivo=0
		porpersona=request.form("porpersona")
		if porpersona="" then porpersona=0
		tiposuple=request.form("tiposuple")
		tipohabi=request.form("tipohabi")
	end if	

	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM Extras WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "nuevo" 'Añadir
			cs="INSERT INTO " & precrs & "Extras (CodigoEsta,FInicio,FFinal,"
			cs=cs & "Extra_es,Extra_it,Extra_en,Extra_de,Extra_fr,"
			cs=cs & "porPersona,Importe,Colectivo,Descuento,TipoSuple,TipoHabi) VALUES ("
			cs=cs & est & "," & FechaMySQL(Fini) & "," & FechaMySQL(FFin) & ",'"
			cs=cs & extra_es & "','" & extra_it & "','" & extra_en & "','" & extra_de & "','"
			cs=cs & extra_fr & "'," & porpersona & "," & importe & ","
			cs=cs & colectivo & "," & descuento & ",'" & tiposuple & "','" & tipohabi & "')"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			MiId=request.form("id")
			cs="UPDATE " & precrs & "Extras SET "
			cs=cs & "FInicio=" & FechaMySQL(fini) & ","
			cs=cs & "FFinal=" & FechaMySQL(ffin) & ","
			cs=cs & "Extra_es='" & extra_es & "',"
			cs=cs & "Extra_it='" & extra_it & "',"
			cs=cs & "Extra_en='" & extra_en & "',"
			cs=cs & "Extra_de='" & extra_de & "',"
			cs=cs & "Extra_fr='" & extra_fr & "',"
			cs=cs & "Importe=" & importe & ","
			cs=cs & "Colectivo=" & colectivo & ","
			cs=cs & "Descuento=" & descuento & ","
			cs=cs & "porPersona=" & porpersona & ","
			cs=cs & "TipoSuple='" & tiposuple & "',"
			cs=cs & "TipoHabi='" & tipohabi & "' "
			cs=cs & "WHERE Id=" & MiId
			'response.write "cs: " & cs & "<br>"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
end if 'form<>""

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "Extras "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		fini=rs("FInicio")
		ffin=rs("FFinal")
		extra_es=rs("extra_es")
		extra_it=rs("extra_it")
		extra_en=rs("extra_en")
		extra_de=rs("extra_de")
		extra_fr=rs("extra_fr")
		importe=rs("importe")
		colectivo=rs("colectivo")
		descuento=rs("descuento")
		porpersona=rs("porpersona")
		tiposuple=rs("tiposuple")
		tipohabi=rs("tipohabi")
	end if
	rs.close
end if

'Lista de registros
cs="SELECT Id,Finicio,FFinal,Extra_es,Importe FROM " & precrs & "Extras "
cs=cs & "WHERE CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo & " ORDER BY FInicio"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RFIni=1
	RFFin=2
	RExtra=3
	RPelas=4
	haylista=true
end if
rs.close

'Lista de registros
cs="SELECT CodigoColec,Nombre FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
cs=cs & "ON Colectivos.CodigoColec=ColectivosNomres.ColectivoIdi "
cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' ORDER BY CodigoColec"
rs.Open cs, base
haycolec=false
if not rs.eof then
	RegColec=rs.GetRows
	CCodi=0
	CNombre=1
	haycolec=true
end if
rs.close

'Suplementos de este hotel
cs="SELECT RegimenHotel.Id,Nombre_es,CodigoTempo "
cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	STempo=2
	haysuples=true
end if
rs.close

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND YEAR(FInicio)=" & anyo
cs=cs & " ORDER BY FInicio"
rs.open cs,base
haytempos=false
if not rs.eof then
	RegTempos=rs.getrows
	TCodi=0
	TFIni=1
	TFFin=2
	haytempos=true
end if
rs.close

'Habitaciones de este hotel
cs= "SELECT Id,Nombre_es "
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
cs=cs & "WHERE CodigoEsta=" & est
cs=cs & " ORDER BY Orden"
rs.Open cs, base
hayhabis=false
if not rs.eof then
	RegHabis=rs.GetRows
	HCodi=0
	HNombre=1
	hayhabis=true
end if
rs.close

'Buscar OBS
cs="SELECT Obs FROM " & precrs & "Establecimientos Establecimientos WHERE CodigoEsta=" & est
rs.open cs,base
if not rs.eof then
	lasObs="" & rs("obs")
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
	palIframe(document.getElementById("verFicha"),450,400,0,0,"verExtras.asp?id=0&p=<%=pag%>&est=<%=est%>");
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),510,400,0,0,"verExtras.asp?id="+id+"&est=<%=est%>");
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
	<table align='center' border="0" cellpadding="0" cellspacing="0" width="500">
	<tr><td align='left'>
	* Este listado de Extras depende del establecimiento seleccionado en la parte de arriba.<br/>
	* Son suplementos obligatorios, se suman al total de la reserva.
	</td></tr>
	<tr><td align='right'>
		<input type='button' class="boton145" style='cursor:hand' onclick="javascript:enBlanco();" value='&nbsp;Nuevo Extra&nbsp;'>
		<input type='button' class="boton145" style='cursor:hand' value='&nbsp;Borrar Marcados&nbsp;' onclick='javascript:ABorrar();'>
	</td></tr>
  <tr><td><div align="center" class="tituloTabla">Extras</div></td></tr>
  <tr><td class="tdTabla">
<table border="0" cellpadding="0" cellspacing="0" width='650' align='center'>
	<tr class='cabetabla'>
        <th class="colu_par"></th>
        <th class="colu_impar">ID</th>
		<th align="center" class="colu_par">Fecha</th>
		<th align="left" class="colu_impar">Concepto</th>
		<th align="right" class="colu_par">Importe</th>
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
        </td>	  <td align="center" width='40' class='<%=laColu(1)%>'><a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> </td>
        <td align="center" class='<%=laColu(0)%>' >
			<%=verFecha(RegLista(RFini,r)) & " - " & verFecha(RegLista(RFFin,r))%>
		</td>
		<td align="left" class='<%=laColu(0)%>' >
		<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=regLista(RExtra,r)%></a></td>
		<td align="right" class='<%=laColu(0)%>' ><%=regLista(RPelas,r)%> &euro;</td>
      </tr>
      <%next
	end if%></table></td></tr>
</table>

</td></tr>
</table>


<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
