<!--#include file="../Connections/FunGestion.asp"-->
<%
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

if clng(request.querystring("err")) <> 0 then
	'tabla errores
	cs="SELECT * FROM " & precrs & "detallerr WHERE idmensaje=" & clng(request.querystring("id")) & " order by id"
	rs.Open cs,base
	if not rs.eof then
		Cid=0
		Cidmen=1
		Cidcli=2
		Cnom=3
		Cape=4
		Cmail=5
		CDescri=6
		Regerr=rs.getrows
		PorPag=100
	TotReg=ubound(Regerr,2)+1
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
end if
%>
<html>
<head>

<script language="javascript" type="text/javascript">
function ACerrar(){
	window.close();
}


</script>
<title><%=request.Cookies("MetaTitulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<link href="../<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
</head>

<body>
<table align='center' width="700">
<tr><td height='10'></td></tr>
<tr><td align='center'>
	<input type='button' style='cursor:pointer' value='&nbsp;Cerrar listado&nbsp;' onclick='javascript:ACerrar();'>
</td></tr>
<tr><td height='10'></td></tr>
</table>
&nbsp;
<table border="0" cellpadding="0" cellspacing="0" width='700' align='center'>
	<tr class="cabetabla">
		   <th height="10">&nbsp;</th>
		   <th>ID</th>
		   <th align='left'>Id Cliente</th>
		   <th align='left'>Nombre</th>
		   <th align='left'>Apellidos</th>
		   <th align='left'>Email</th>
			<th align='left'>Descrip. error</th>
	</tr>
	<%	
	for R=IReg to IReg+PorPag-1
	if R>ubound(Regerr,2) then exit for
	%>
	<tr>
	  <td align="center" width='10' class='lineatabla'>
		<input type="checkbox" style='border:none' name="aborrar" value="<%=Regerr(Cid,r)%>"></form>
	  </td>
	  <td align="center" width='40' class='lineatabla'>
		<%=Regerr(Cid,r)%>&nbsp;
	  </td>
	  <td align="left" width='100' class='lineatabla'>
		<a href='ListaClientes.asp?id=<%=Regerr(CIdcli,r)%>'><%=Regerr(Cidcli,r)%></a>&nbsp;
	  </td>
	  <td align="left" width='150' class='lineatabla'>
		<a href='ListaClientes.asp?id=<%=Regerr(CIdcli,r)%>'><%=Regerr(Cnom,r)%>&nbsp;</a>
	  </td>
	  <td align="left" width='250' class='lineatabla'>
		<a href='ListaClientes.asp?id=<%=Regerr(CIdcli,r)%>'><%=Regerr(Cape,r)%>&nbsp;</a>
	  </td>
	  <td align="left" width='250' class='lineatabla'>
		<%=Regerr(Cmail,r)%>&nbsp;
	  </td>
	  <td align="left" width='350' class='lineatabla'>
		<%=Regerr(CDescri,r)%>
	  </td>

	  </tr>
	<%next%>
	<tr><td height='25' colspan='7'>
	<b></b>Total Registros: <%=TotReg%></b><br></td></tr>
	<tr>
	  <td align='center' class='cabetabla' colspan="7"> 
		<%if pag=1 or pag="" then%>
		<%=FlechaLeft%>Página Anterior 
		<%else%>
		<a href="<%=MiPag%>?ord=<%=ord%>&tp=<%=tipo%>&P=<%=Pag-1%>&filtro=<%=cint(usafiltro)%>" class='CabeTabla'><%=FlechaLeft%>Página Anterior</a> 
		<%end if%>
		&nbsp;&nbsp;&nbsp;<%=Pag%>/<%=MaxP%>&nbsp;&nbsp;&nbsp; 
		<%if pag=MaxP or MaxP=1 then%>
		Página Siguiente<%=FlechaRight%>
		<%else%>
		<a href="<%=MiPag%>?ord=<%=ord%>&tp=<%=tipo%>&P=<%=Pag+1%>&filtro=<%=cint(usafiltro)%>" class='CabeTabla'>Página 
		Siguiente<%=FlechaRight%></a> 
		<%end if%>
	  </td>
	</tr>

	<tr><td height='25' colspan='7'></td></tr>
	<%'end if
	%>
	</table>
</body>
</html>
