<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly


laid=Clng(request.QueryString("idh"))

if request.Form<>"" then 'actualizar
	titulo_es=quitarApos(request.form("titulo_es"))
	titulo_it=quitarApos(request.form("titulo_it"))
	titulo_en=quitarApos(request.form("titulo_en"))
	titulo_de=quitarApos(request.form("titulo_de"))
	titulo_fr=quitarApos(request.form("titulo_fr"))
	keys_es=quitarApos(request.form("keys_es"))
	keys_it=quitarApos(request.form("keys_it"))
	keys_en=quitarApos(request.form("keys_en"))
	keys_de=quitarApos(request.form("keys_de"))
	keys_fr=quitarApos(request.form("keys_fr"))
	descri_es=quitarApos(request.form("descri_es"))
	descri_it=quitarApos(request.form("descri_it"))
	descri_en=quitarApos(request.form("descri_en"))
	descri_de=quitarApos(request.form("descri_de"))
	descri_fr=quitarApos(request.form("descri_fr"))
	
	cs="UPDATE " & precrs & "MetasHotel SET "
	cs=cs & "Titulo_es='" & titulo_es & "',"
	cs=cs & "Titulo_it='" & titulo_it & "',"
	cs=cs & "Titulo_en='" & titulo_en & "',"
	cs=cs & "Titulo_de='" & titulo_de & "',"
	cs=cs & "Titulo_fr='" & titulo_fr & "',"
	cs=cs & "Keys_es='" & keys_es & "',"
	cs=cs & "Keys_it='" & keys_it & "',"
	cs=cs & "Keys_en='" & keys_en & "',"
	cs=cs & "Keys_de='" & keys_de & "',"
	cs=cs & "Keys_fr='" & keys_fr & "',"
	cs=cs & "Descri_es='" & descri_es & "',"
	cs=cs & "Descri_it='" & descri_it & "',"
	cs=cs & "Descri_en='" & descri_en & "',"
	cs=cs & "Descri_de='" & descri_de & "',"
	cs=cs & "Descri_fr='" & descri_fr & "' "
	cs=cs & "WHERE IdHotel=" & laId
	base.execute cs
	
	
end if

cs="SELECT MetasHotel.*,Nombre FROM " & precrs & "MetasHotel MetasHotel INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON MetasHotel.IdHotel=Establecimientos.CodigoEsta WHERE IdHotel=" & laid
rs.open cs,base
haymeta=false
if not rs.eof then
	haymeta=true
	nhotel=rs("Nombre")
	titulo_es=rs("titulo_es")
	titulo_it=rs("titulo_it")
	titulo_en=rs("titulo_en")
	titulo_de=rs("titulo_de")
	titulo_fr=rs("titulo_fr")
	keys_es=rs("keys_es")
	keys_it=rs("keys_it")
	keys_en=rs("keys_en")
	keys_de=rs("keys_de")
	keys_fr=rs("keys_fr")
	descri_es=rs("descri_es")
	descri_it=rs("descri_it")
	descri_en=rs("descri_en")
	descri_de=rs("descri_de")
	descri_fr=rs("descri_fr")
	rs.close
	
else 'crear nueva
	rs.close
	cs="INSERT INTO " & precrs & "MetasHotel(IdHotel) VALUES (" & laid & ")"
	base.execute cs
	
	'Volver a consultar
	cs="SELECT MetasHotel.*,Nombre FROM " & precrs & "MetasHotel MetasHotel INNER JOIN " & precrs & "Establecimientos Establecimientos "
	cs=cs & "ON MetasHotel.IdHotel=Establecimientos.CodigoEsta WHERE IdHotel=" & laid
	rs.open cs,base
	haymeta=false
	if not rs.eof then
		haymeta=true
		nhotel=rs("Nombre")
		titulo_es=rs("titulo_es")
		titulo_it=rs("titulo_it")
		titulo_en=rs("titulo_en")
		titulo_de=rs("titulo_de")
		titulo_fr=rs("titulo_fr")
		keys_es=rs("keys_es")
		keys_it=rs("keys_it")
		keys_en=rs("keys_en")
		keys_de=rs("keys_de")
		keys_fr=rs("keys_fr")
		descri_es=rs("descri_es")
		descri_it=rs("descri_it")
		descri_en=rs("descri_en")
		descri_de=rs("descri_de")
		descri_fr=rs("descri_fr")
	end if
	rs.close
end if


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

<body>
<form name='f1' method="post" action="<%=MiPag%>?idh=<%=laid%>">
<table align="center" border="0" cellpadding="2" cellspacing="1" width="100%">
<tr><td colspan="5" align="center"><b>METAS --> <%=ucase(nhotel)%></b></td></tr>
<tr><td colspan="5" height='5'></td></tr>
<tr>
	<td align="left">
	Titulo Cast.<br>
	<input type="text" name="titulo_es" maxlength="250" style="width:142px" value="<%=titulo_es%>">
	</td>
	<td align="left">
	Titulo Italiano<br>
	<input type="text" name="titulo_it" maxlength="250" style="width:142px" value="<%=titulo_it%>">
	</td>
	<td align="left">
	Titulo Ingles<br>
	<input type="text" name="titulo_en" maxlength="250" style="width:142px" value="<%=titulo_en%>">
	</td>
	<td align="left">
	Titulo Alemán<br>
	<input type="text" name="titulo_de" maxlength="250" style="width:142px" value="<%=titulo_de%>">
	</td>
	<td align="left">
	Titulo Francés<br>
	<input type="text" name="titulo_fr" maxlength="250" style="width:142px" value="<%=titulo_fr%>">
	</td>
</tr>
<tr><td colspan="5" height='5'></td></tr>
<tr>
	<td align="left">
	Keys Cast.<br>
	<input type="text" name="keys_es" maxlength="250" style="width:142px" value="<%=keys_es%>">
	</td>
	<td align="left">
	Keys Italiano<br>
	<input type="text" name="keys_it" maxlength="250" style="width:142px" value="<%=keys_it%>">
	</td>
	<td align="left">
	Keys Ingles<br>
	<input type="text" name="keys_en" maxlength="250" style="width:142px" value="<%=keys_en%>">
	</td>
	<td align="left">
	Keys Alemán<br>
	<input type="text" name="keys_de" maxlength="250" style="width:142px" value="<%=keys_de%>">
	</td>
	<td align="left">
	Keys Francés<br>
	<input type="text" name="keys_fr" maxlength="250" style="width:142px" value="<%=keys_fr%>">
	</td>
</tr>
<tr><td colspan="5" height='5'></td></tr>
<tr>
	<td align="left">
	Description Cast.<br>
	<textarea name='descri_es' style="width:142px; height:90px"><%=descri_es%></textarea>
	</td>
	<td align="left">
	Description Italiano<br>
	<textarea name='descri_it' style="width:142px; height:90px"><%=descri_it%></textarea>
	</td>
	<td align="left">
	Description Ingles<br>
	<textarea name='descri_en' style="width:142px; height:90px"><%=descri_en%></textarea>
	</td>
	<td align="left">
	Description Alemán<br>
	<textarea name='descri_de' style="width:142px; height:90px"><%=descri_de%></textarea>
	</td>
	<td align="left">
	Description Francés<br>
	<textarea name='descri_fr' style="width:142px; height:90px"><%=descri_fr%></textarea>
	</td>
</tr>
<tr><td colspan="5" height='10'></td></tr>
<tr><td colspan="5" align="center">
	<input type="submit" value="Actualizar" style="cursor:pointer">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="Cerrar" onclick="javascript:window.close();" style="cursor:pointer">
</td></tr>
</table>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
