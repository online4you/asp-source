<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()
%>
<!-- #Include File="Connections/Functions.asp"-->
<%
nest=request.QueryString("nest")
codest=request.QueryString("est")
if codest="" then
	errormsg="Datos no válidos"
end if

'Comprobar si actualizamos
elmodo=request.form("modo")
if elmodo<>"" then 'ay qe actualizar o dar de alta
	est=request.form("codest")
	email=replace(request.form("email"),"'","´")
	dire=replace(request.form("direccion"),"'","´")
	cp=replace(request.form("cp"),"'","´")
	pobla=replace(request.form("poblacion"),"'","´")
	tele=replace(request.form("telefono"),"'","´")
	fax=replace(request.form("fax"),"'","´")
	if lcase(request.form("aviso"))="on" then
		aviso=-1
	else
		aviso=0
	end if

	if elmodo="actu" then 'Actualizar
		cs="UPDATE " & precrs & "DatosHotel SET email='" & email & "',"
		cs=cs & "direccion='" & dire & "',"
		cs=cs & "cp='" & cp& "',"
		cs=cs & "poblacion='" & pobla & "',"
		cs=cs & "telefono='" & tele & "',"
		cs=cs & "fax='" & fax & "',"
		cs=cs & "aviso=" & aviso & " "
		cs=cs & "WHERE CodigoEsta=" & est
		
		cmdDC.CommandText = cs
		cmdDC.Execute
		errormsg="Datos Actualizados"
		'response.write cs & "<br>"
		'response.End()
		
	else 'Alta
		cs="INSERT INTO " & precrs & "DatosHotel (CodigoEsta,email,direccion,cp,poblacion,telefono,fax,aviso) VALUES ("
		cs=cs & est & ",'" & email & "','" & dire & "','" & cp & "','"
		cs=cs & pobla & "','" & tele & "','" & fax & "'," & aviso & ")"
		
		cmdDC.CommandText = cs
		cmdDC.Execute
		errormsg="Datos Añadidos"
		'response.write cs
		'response.End()
	
	end if
end if


'Visualizacion de la ficha
if errormsg="" then 'Buscar

	'Comprobar si está ese hotel
	cs="SELECT Email,Direccion,cp,Poblacion,Telefono,Fax,Aviso "
	cs=cs & "FROM " & precrs & "DatosHotel WHERE CodigoEsta=" & codest
	
	cmdDC.CommandText = cs
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open cmdDC, , 2, 2
	if not rs.eof then
		email=rs("email")
		dire=rs("direccion")
		cp=rs("cp")
		pobla=rs("poblacion")
		tele=rs("telefono")
		fax=rs("fax")
		aviso=rs("aviso")
		modo="actu"
	else
		modo="alta"
	end if
	rs.close
	set rs=nothing
end if

%>
<html>
<head>
<title>Datos Alojamiento</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css1.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
	function Envia()
	{
		document.f1.action="<%=MiPag%>";
		document.f1.submit();
	}
</script>

<body bgcolor="#d7ecF7" alink="#ffffff" vlink="#ffffff" link="#ffffff">
<form name='f1' method="post">
<%if errormsg="" then 'Ver la ficha %>
<table width='400' align='center' border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFE1">
 <tr>
 	<td align='left' colspan='2' height='10'></td>
</tr>
 <tr>
 	<td align='center' colspan='2'><b><%=nest%></b></td>
</tr>
 <tr>
 	<td align='left' colspan='2' height='10'></td>
</tr>
 <tr>
 	<td align='right'>EMail:</td>
	<td align='left'>
		<input type="text" name='email' value="<%=email%>" size='50' maxlength='75'></td></tr>
 <tr  >
 	<td align='right'>Dirección:</td>
	<td align='left'>
		<input type="text" name='direccion' value="<%=dire%>" size='50' maxlength='50'></td></tr>
 <tr  >
 	<td align='right'>CP:</td>
	<td align='left'>
		<input type="text" name='cp' value="<%=cp%>" size='6' maxlength='5'></td></tr>
 <tr  >
 	<td align='right'>Población:</td>
	<td align='left'>
		<input type="text" name='poblacion' value="<%=pobla%>" size='50' maxlength='50'></td></tr>
 <tr  >
 	<td align='right'>Teléfono:</td>
	<td align='left'>
		<input type="text" name='telefono' value="<%=tele%>" size='25' maxlength='25'></td></tr>
 <tr  >
 	<td align='right'>Fax:</td>
	<td align='left'>
		<input type="text" name='fax' value="<%=fax%>" size='25' maxlength='25'></td></tr>
 <tr  >
 	<td align='left' colspan='2'>&nbsp;Mandar aviso al hotel por E-Mail 
	<%if aviso then marca=" checked"%>
	<input type="checkbox" name='aviso' <%=marca%>></td>
</tr>
 <tr>
 	<td align='left' colspan='2' height='15'></td>
</tr>
 <tr  >
 	<td align='center' colspan='2'>
	<input type='button' value="Actualizar" onclick="javascript:Envia();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type='button' value="Salir" onclick="javascript:window.close();">
	</td>
</tr>
 <tr>
 	<td align='left' colspan='2' height='15'>
	<input type='hidden' name='codest' value='<%=codest%>'>
	<input type='hidden' name='modo' value='<%=modo%>'>
	</td>
</tr>
</table>
<%else
	response.write "<h2>"&errormsg&"</h2>"%>
	<input type='button' value="Salir" onclick="javascript:window.close();">
<%end if%>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
