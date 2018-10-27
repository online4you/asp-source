<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

MiId=clng(request.querystring("est"))
if request.form<>"" then
	texto_es=quitarApos(request.form("texto_es"))
	texto_en=quitarApos(request.form("texto_en"))
	texto_de=quitarApos(request.form("texto_de"))
	nodos=replace(request.form("nodos"),"/>","/>" & vbcrlf)
	cs="UPDATE " & precrs & "ComoLlegar SET Texto1_es='" & texto_es & "',"
	cs=cs & "Texto1_en='" & texto_en & "',"
	cs=cs & "Texto1_de='" & texto_de & "',"
	cs=cs & "Nodos='" & nodos & "' "
	cs=cs & "WHERE CodigoEsta=" & MiId
	base.execute cs

end if

cs="SELECT * FROM " & precrs & "ComoLlegar WHERE CodigoEsta=" & MiId
rs.open cs,base
if not rs.eof then
	texto_es=rs("texto1_es")
	texto_en=rs("texto1_en")
	texto_de=rs("texto1_de")
	nodos=rs("nodos")
	rs.close
else 'crear registro
	rs.close
	cs="INSERT INTO " & precrs & "ComoLlegar (CodigoEsta) VALUES (" & MiId & ")"
	base.execute cs
	'Carga registro
	cs="SELECT * FROM " & precrs & "ComoLlegar WHERE CodigoEsta=" & MiId
	rs.open cs,base
	if not rs.eof then
		texto_es=rs("texto1_es")
		texto_en=rs("texto1_en")
		texto_de=rs("texto1_de")
		nodos=rs("nodos")
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <title>flashmapa</title>
  <script language="javascript">
  <!--
    // llamado desde flash
    function savedata(str) {
      document.f1.nodos.value = str;
    }
  -->
  </script>
  <style type="text/css">
<!--
.tapao {
	/*visibility:hidden;
	height:10px;
	width:100px;*/
}
.area {
	width:150px;
	height:100px;
}
-->
  </style>
</head>
<body bgcolor="#ecf29c">

<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="488" height="237" id="flashmapa" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="/mapaFlash/flashmapa.swf?editar=6502&datafile=../reservas/mapaHotelxml.asp//id=<%=MiId%>" />
<param name="quality" value="high" />
<param name="scale" value="noscale" />
<param name="salign" value="lt" />
<param name="bgcolor" value="#ecf29c" />
<embed src="/mapaFlash/flashmapa.swf?editar=6502&datafile=../reservas/mapaHotelxml.asp//id=<%=MiId%>" quality="high" scale="noscale" salign="lt" bgcolor="#ecf29c" width="488" height="237" name="flashmapa" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>

<form method="post" name="f1" action="<%=MiPag%>?est=<%=MiId%>">
  <textarea name="nodos" class="tapao"><%=nodos%></textarea>
<table width="100%" border="0" cellpadding="0" cellspacing="2">
<tr>
	<td align="left">Texto Flash en Español<br/>
		<textarea name="texto_es" class='area'><%=texto_es%></textarea>
	</td>
	<td align="left">Texto Flash en Inglés<br/>
		<textarea name="texto_en" class='area'><%=texto_en%></textarea>
	</td>
	<td align="left">Texto Flash en Alemán<br/>
		<textarea name="texto_de" class='area'><%=texto_de%></textarea>
	</td>
</tr>
<tr><td colspan="3" height="10"></td></tr>
<tr><td colspan="3" align="center">
	<input type="submit" value="Guardar Flash y textos">
</td></tr>
</table>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
