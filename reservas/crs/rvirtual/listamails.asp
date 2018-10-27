<!--#include file="../Connections/FunGestion.asp"-->
<%
function PonerApos(texto)
	if not isnull(texto) then
		PonerApos=replace(texto,"´","'")
	else
		PonerApos=""
	end if
end function

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

if request.QueryString("modo")="borra" then 'Borrar marcadas
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cs="DELETE FROM " & precrs & "detallerr WHERE "
		for t=0 to ubound(queborro)
			cs=cs & "id=" & trim(queborro(t)) & " OR "
		next
		if right(cs,4)=" OR " then 'Quitar el ultimo operador
			cs=left(cs,len(cs)-4)
		end if	
		base.execute cs
	end if
end if

	'tabla errores
	cs="SELECT * FROM " & precrs & "resum WHERE id=" & clng(request.querystring("id"))
	rs.Open cs,base
	if not rs.eof then
		Pid=0
		Pasunto=1
		Pmensaje=2
		Pfiltro=3
		Perrores=4
		Pcorrectos=5
		Pfechaenvio=6
		Regplant=rs.getrows
		PorPag=100
	TotReg=ubound(Regplant,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=clng("0" & request.querystring("P"))
	if Pag=0 then Pag=2 'provisional
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	end if
filtro=Regplant(Pfiltro,0)
filtro=PonerApos(filtro)
%>
<html>
<head>

<script language="javascript" type="text/javascript">
function SetCookie (name, value){
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (2 < argc) ? argv[2] : null;
	var path = (3 < argc) ? argv[3] : null;
	var domain = (4 < argc) ? argv[4] : null;
	var secure = (5 < argc) ? argv[5] : false;
	document.cookie = name + "=" + escape (value) +
	((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
	((path == null) ? "" : ("; path=" + path)) +
	((domain == null) ? "" : ("; domain=" + domain)) +
	((secure == true) ? "; secure" : "");
}
function ACerrar(){
	window.close();
}
function NuevoEmail(){
var filtro="<%=filtro%>";
//document.cookie = "condicion" + "=" + filtro + "; path=/";
SetCookie("cookieFiltroE",filtro,null,"/");
window.opener.location="ListaClientes.asp?filtro=1";
window.close();
}


</script>
<title><%=request.Cookies("MetaTitulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<link href="../<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
</head>

<body>
<table align='center' width="470">
<tr><td height='10'></td></tr>
<tr><td align='center'>
	<input type='button' style='cursor:pointer' value='&nbsp;Cerrar listado&nbsp;' onclick='javascript:ACerrar();'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type='button' style='cursor:pointer' value='&nbsp;Aplicar mismo Filtro&nbsp;' onclick='javascript:NuevoEmail();'>
</td></tr>
<tr><td height='10'></td></tr>
</table>
&nbsp;
<table border="0" cellpadding="0" cellspacing="0" width='620' align='center'>
	<tr class="cabetabla">
		   <th height="10">&nbsp;</th>
		   <th>ID</th>
		   <th align='left'>Asunto</th>
		   <th align='left'>Correctos</th>
		   <th align='left'>Errores</th>
		   <th align='left'>Fecha envio</th>
			
	</tr>
	<tr>
	  <td align="center" width='10' class='lineatabla'>
		<input type="checkbox" style='border:none' name="aborrar" value=""></form>
	  </td>
	  <td align="center" width='40' class='lineatabla'>
		<%=Regplant(Pid,0)%>&nbsp;
	  </td>
	  <td align="left" width='100' class='lineatabla'>
		<%=Regplant(Pasunto,0)%>&nbsp;
	  </td>
	  <td align="left" width='150' class='lineatabla'>
		<%=Regplant(Pcorrectos,0)%>&nbsp;
	  </td>
	  <td align="left" width='250' class='lineatabla'>
		<%=Regplant(Perrores,0)%>&nbsp;
	  </td>
	  <td align="left" width='250' class='lineatabla'>
		<%=Regplant(Pfechaenvio,0)%>&nbsp;
	  </td>

	  </tr>

	<tr><td height='25' colspan='7'>&nbsp;
	</td></tr>
	<tr><td height='25' colspan='7'>
	<iframe frameborder="0" scrolling="auto" height="750" width="620" src="creaPagina.asp?id=<%=Regplant(Pid,0)%>"></iframe>
	</td></tr>
	<tr><td height='25' colspan='7'></td></tr>
	</table>
	
</body>
</html>
