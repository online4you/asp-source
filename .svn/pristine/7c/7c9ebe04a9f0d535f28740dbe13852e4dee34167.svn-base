<!-- #Include File="Connections/FunctionesVte.asp"-->
<!-- #Include File="Connections/lang.asp"-->
<%
idicaixa=request.querystring("Ds_ConsumerLanguage")
select case idicaixa
	case "1"
		idi=2
		lang="es"
	case "3"
		idi=1
		lang="ca"
	case "2"
		idi=3
		lang="en"
	case "5"
		idi=4
		lang="de"
	case else
		idi=2
		lang="es"
end select

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

reserva=clng("0" & request.querystring("ds_order"))
cs="SELECT Reservas.CodigoEsta,Nombre,Importe FROM " & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE Cod_Res=" & reserva
rs.open cs,base
if not rs.eof then
	est=rs("codigoesta")
	nhotel=rs("nombre")
	pelas=rs("importe")
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Hoteles Saint Michel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/main.css" rel="stylesheet" type="text/css" />
<link href="css/reservas.css" rel="stylesheet" type="text/css" />
<script src="/__utm.js"></script>
</head>
<BODY>
<center>
<div align="center" style='width:188px; height:78px; margin-top:20px;'>
<img src="img/logo.gif" width="135" height="48" border="0"></div>
<img src="img/tr.gif" width='400' height="15"><br/>

<table border='0' width='300' align='center' cellspacing="0" cellpadding="0" class='peazoborde'>
	<tr>
		<td align='center' width='300' valign='top' class='fondolista1'>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td align='left' class='fondolista1'>
			<%response.write "&nbsp;" & ucase(nhotel) & " - " & ucase(ap("reservas")) & " ON-LINE"%>
			</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr><td class="fondolista1"><hr size="1" width="100%" class="style1"></td></tr>
	<tr>
		<td align='center' valign='top' class='fondocabelista'>
		<%=ap("gracias")%></td>
	</tr>
	<tr><td height="20" class='fondocabelista'></td></tr>
	<tr>
		<td align="center" class='fondocabelista'>
		<input type='button' value='<%=ap("cerrar")%>' onclick="javascript:window.close();" class="botonRes"></td>
	</tr>
	<tr><td height="20" class='fondocabelista'></td></tr>
</table>
</center>
<!-- Google Code for purchase Conversion Page -->
<script language="JavaScript" type="text/javascript">
<!--
var google_conversion_id = 1061435327;
var google_conversion_language = "<%=lang%>";
var google_conversion_format = "1";
var google_conversion_color = "666666";
if (1) {
  var google_conversion_value = 1;
}
var google_conversion_label = "purchase";
//-->
</script>
<script language="JavaScript" src="http://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<img height=1 width=1 border=0 src="http://www.googleadservices.com/pagead/conversion/1061435327/imp.gif?value=1&label=purchase&script=0">
</noscript>
</body>
</html>

