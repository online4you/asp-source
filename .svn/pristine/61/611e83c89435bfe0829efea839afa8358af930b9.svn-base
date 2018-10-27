<!-- #Include File="Connections/Functions.asp"-->
<%
If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()

CodigoEsta=request.querystring("codesta")
idservi=request.QueryString("idservi")
idi=request.QueryString("idi")

'Comporobar la accion a hacer
modo=request.form("modo")
if modo<>"" then 'Modificar,añadir o borrar
	'Pasar variables
	CodigoEsta=request.form("CodigoEsta")
	idservi=request.form("idservi")
	id=request.form("idsertem")
	idi=request.form("idioma")
	idtempo=request.form("idtemporada")
	idcolec=request.form("idcolectivo")
	pelas=replace(request.form("importe"),",",".")
	pp=request.form("tipo")
	
	select case modo
		case "alta"
			cs="INSERT INTO " & precrs & "ServiciosTemporadas (Idservicio,IdTemporada,IdColectivo,Importe,tipo) "
			cs=cs & "VALUES (" & idservi & "," & idtempo & "," & idcolec & "," & pelas & "," & pp & ")"
			'response.write cs & "<br>"
			cmdDC.CommandText = cs
			cmdDC.Execute
		
		case "actu"
			cs="UPDATE " & precrs & "ServiciosTemporadas SET IdTemporada=" & idtempo & ","
			cs=cs & "IdColectivo=" & idcolec & ","
			cs=cs & "Importe=" & pelas & ","
			cs=cs & "tipo=" & pp & " "
			cs=cs & "WHERE id=" & id
			'response.write cs & "<br>"
			cmdDC.CommandText = cs
			cmdDC.Execute
			
		case "borra"
			for i=1 to request.form("aborrar").count
				cs= "DELETE FROM " & precrs & "ServiciosTemporadas WHERE "
				cs= cs & "id=" & request.form("aborrar")(i)
				cmdDC.CommandText = cs
				cmdDC.Execute
			next
			
	end select
	
end if

'Desactivar controles cuando esta en idioma
function Desactiva()
	if  idi<>"es" and  idi<> "" then response.Write("Disabled")
end function

'Buscar nombre servicio
nservicio="Servicio no seleccionado"
if isnumeric(idservi) then
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql="SELECT nombre FROM " & precrs & "ServiciosNombres "
	sql=sql & "WHERE IdServicio=" & idservi & " AND idioma='" & idi & "'"
	cmdDC.CommandText = sql
	rs.Open cmdDC, , 2, 2
	if not rs.eof then
		nservicio=rs("nombre")
	end if
	rs.close
	set rs=nothing
end if
%>
<html>
<head>
<title>Servicios Temporadas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css1.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<script language='JavaScript'>
	function AltaActu()
	{
		document.f1.submit();
	}
	function Borrar()
	{
		document.f1.modo.value="borra";
		document.f1.submit();
	}
	function VerFicha(id,idt,idc,pelas,modo){
		//Poner los valores
		listat=document.f1.idtemporada.options;
		for (x=0;x<listat.length;x++){
			if (listat[x].value==idt)
				listat[x].selected=true;
		}
		listac=document.f1.idcolectivo.options;
		for (x=0;x<listac.length;x++){
			if (listac[x].value==idc)
				listac[x].selected=true;
		}

		document.f1.importe.value=pelas;
		if (modo==0)
			document.f1.tipo[0].checked;
		if (modo==1)
			document.f1.tipo[1].checked;
		if (modo==2)
			document.f1.tipo[2].checked;
		if (modo==3)
			document.f1.tipo[3].checked;
			
		document.f1.boton.value=" Modificar ";
		document.f1.modo.value="actu";
		document.f1.idsertem.value=id;
		document.all.panel.style.visibility='visible';
	}
	function DarAlta(){
		//Poner los valores a cero
		document.f1.idtemporada.options[0].selected=true;
		document.f1.idcolectivo.options[0].selected=true;
		document.f1.importe.value='0';
		document.f1.tipo[0].checked;
		document.f1.idsertem.value="";
		document.f1.boton.value=" Añadir ";
		document.f1.modo.value="alta";
		document.all.panel.style.visibility='visible';
	}
</script>
</head>

<body bgcolor="#FFF8DD" link="#ffffff" vlink="#ffffff" alink="#ffffff">
<%
if CodigoEsta<>"" and isnumeric(idservi) then
	'Relleno las tablas de nombres de temporadas
	Set rs = Server.CreateObject("ADODB.Recordset")
	dim Tempos()
	cs="SELECT nombre,codigotemp FROM " & precrs & "TemporadasNomres INNER JOIN Temporadas "
	cs=cs & "ON TemporadasNomres.TempIdi=Temporadas.CodigoTemp "
	cs=cs & "WHERE codigoesta=" & CodigoEsta & " AND Idioma='" & idi & "' "
	cs=cs & "ORDER BY codigotemp DESC"
	cmdDC.CommandText = cs
	rs.Open cmdDC, , 2, 2
	if not rs.eof then
		redim Tempos(rs("codigotemp"))
		Tempos(0)="Cualquier Temporada"
		do while not rs.eof
			Tempos(rs("codigotemp"))=rs("nombre")
			rs.movenext
		loop
	end if
	rs.close

	'Relleno las tablas de nombres de colectivos
	dim Colec()
	cs="SELECT nombre,codigocolec FROM " & precrs & "ColectivosNomres INNER JOIN Colectivos "
	cs=cs & "ON ColectivosNomres.ColectivoIdi=Colectivos.codigocolec "
	cs=cs & "WHERE codigoesta=" & CodigoEsta & " AND Idioma='" & idi & "' "
	cs=cs & "ORDER BY codigocolec DESC"
	cmdDC.CommandText = cs
	rs.Open cmdDC, , 2, 2
	if not rs.eof then
		redim Colec(rs("codigocolec"))
		Colec(0)="Cualquier Colectivo"
		do while not rs.eof
			Colec(rs("codigocolec"))=rs("nombre")
			rs.movenext
		loop
	end if
	rs.close
%>
<form name='f1' method="post" action="<%=MiPag%>">
<table bgcolor="#FFF8DD" width='500' align='center' border="0" cellspacing="2" cellpadding="0">
  <tr> 
	<td height="17" colspan="6" bgcolor="#FFCC99"><div align="center"><strong>Precios 
		Servicios</strong></div></td>
  </tr>
  <tr><td height='10' colspan='6'></td></tr>
  <tr> 
	<td bgcolor="#FFF8DD" align='center' colspan='6'><%=nservicio%></td>
  </tr>
	<tr bgcolor="#FFCC99">
	<td width='10'></td>
	<td align='center'>Código</td>
	<td align='left'>Temporada</td>
	<td align='left'>Colectivo</td>
	<td align='right'>Importe</td>
	<td align='center'>Modo Cálculo</td></tr>
<%	
	'Abrir base de serviciostemporadas
	cs="SELECT id,IdTemporada,IdColectivo,Importe,tipo FROM " & precrs & "ServiciosTemporadas "
	cs=cs & "WHERE IDServicio=" & idservi
	cmdDC.CommandText = cs
	rs.Open cmdDC, , 2, 2
	do while not rs.eof
		response.write "<tr><td align='center' width='10'>" & vbcrlf
		response.write "<input type='checkbox' name='aborrar' value='" & rs("id") & "'></td>"& vbcrlf
		response.write "<td align='center'>" & vbcrlf
		datos=rs("id") & "," & rs("idtemporada") & "," & rs("idcolectivo") & "," &chr(34)& rs("importe") & chr(34)&"," & clng(rs("tipo"))
		response.write "<a href='javascript:VerFicha(" & datos & ");'>&nbsp;" & rs("id") & "&nbsp;</a></td>" & vbcrlf	
		response.write "<td align='left'>" & vbcrlf
		response.write Tempos(rs("IdTemporada")) & "</td>" & vbcrlf	
		response.write "<td align='left'>" & vbcrlf
		response.write Colec(rs("IdColectivo")) & "</td>" & vbcrlf	
		response.write "<td align='right'>" & vbcrlf
		response.write rs("Importe") & "</td>" & vbcrlf	
		response.write "<td align='center'>" & vbcrlf
		select case rs("tipo")
			case 0
				response.write "Por Persona</td></tr>" & vbcrlf	
			case 1
				response.write "Por Reserva</td></tr>" & vbcrlf	
			case 2
				response.write "Por Día</td></tr>" & vbcrlf	
			case 3
				response.write "Por Persona y Día</td></tr>" & vbcrlf	
		end select
		rs.movenext
	loop
	rs.close
	set rs=nothing
%>	
	<tr><td colspan='6' align='center'>
<input type="button" value="Nuevo" onclick="Javascript:DarAlta();">
&nbsp;&nbsp;
<input type="button" value="Borrar marcados" onclick="javascript:Borrar();">
	</td></tr>
</table><br><br>
<div id="panel" align='center' style="visibility:hidden;">
<table align='center' border='1'>
	<tr><td align='left'>
	Temporada 
	<select name='idtemporada'>
		<option value='0'>Cualquier Temporada</option>
		<%for t=1 to ubound(Tempos)
			if Tempos(t)<>"" then
				response.write "<option value='" & t & "'>" & Tempos(t) & "</option>" & vbcrlf
			end if
		next%>
	</select></td></tr>
	<tr><td align='left'>
	Colectivo
	<select name='idcolectivo'>
		<option value='0'>Cualquier Colectivo</option>
		<%for c=1 to ubound(Colec)
			if Colec(c)<>"" then
				response.write "<option value='" & c & "'>" & Colec(c) & "</option>" & vbcrlf
			end if
		next%>
	</select></td></tr>
	<tr><td align='left'>Importe:
	<input type='text' name='importe' size='10'></td></tr>
	<tr><td align='left'>Modo cálculo:
	<input type="radio" name="tipo"  value="0" checked> x Por persona
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="tipo"  value="1"> x Por reserva
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="tipo"  value="2"> x Por día
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="tipo"  value="3"> x Por persona y día
	</td>
	</tr>
	<tr><td align='center'>
		<input id='boton' type='button' value='Aceptar' onclick="Javascript:AltaActu();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' value='Cerrar' onclick="Javascript:document.all.panel.style.visibility='hidden';">
	</td></tr>
</table>
</div>
<input type='hidden' name='CodigoEsta' value='<%=CodigoEsta%>'>
<input type='hidden' name='idioma' value='<%=idi%>'>
<input type='hidden' name='idservi' value='<%=idservi%>'> 
<input type='hidden' name='idsertem'>
<input type='hidden' name='modo'>

</form>
<%end if 'cuando no hay marcado hotel%>
</body>
</html>
