<%if elCharSet="" then elCharSet="UTF-8"%>
<title><%=MetaTitulo%></title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=elCharSet%>">
<meta HTTP-EQUIV="pragma" content="no-cache">
<meta HTTP-EQUIV="expires" content="0">
<link href="<%=relative_url%>nueva.css" rel="stylesheet" type="text/css">
<%if HojaEstilos<>"" then%>
<link href="<%=relative_url%><%=HojaEstilos%>" rel="stylesheet" type="text/css">
<%end if%>
<!--[if IE]> 
<link href="/nueva_ie.css" rel="stylesheet" type="text/css" />
<![endif]-->
 	<script type="text/javascript" src="<%=relative_url%>js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript">
		$.noConflict();
		var $j=jQuery;
		// Code that uses other library's $ can follow here.
	</script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/funciones.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/cookies.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/calendario.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/mootools.js"></script>
<script language="javascript" type="text/javascript" src="<%=relative_url%>js/eventosVentana.js"></script>