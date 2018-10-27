<!--#include file="funciones.asp"-->
<html>
<head>
<title>Son Palou</title>
<link href="css.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
server.ScriptTimeout=900
smtpserver="smtp.planetaweb.es"
remitente="info@sonpalou.com"
cond=request.Cookies("cookieFiltroW")
if cond="" then cond="WHERE EMail<>'' " 'por defecto
nerrores=0
function sendemailto(para,asunto,remite,hosth,body)
	Set mail = Server.CreateObject("Persits.MailSender")
	mail.Host = hosth
	mail.From = remite
	Mail.Username = "GBL056C"
	Mail.Password = "123456"
	mail.AddAddress para
	mail.Subject = asunto
	mail.Body = body
	mail.IsHTML = true
	On Error Resume Next
	mail.send
	set mail=nothing
	if err.number<>0 then 
		sendemailto=err.description
		err.clear
	end if
	on error goto 0
end function

asunto=quitarApos(request.Form("asunto"))
mensaje=quitarApos(request.Form("mensaje"))

'response.write mensaje

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open conectaMDB
set basemailing = server.createobject("ADODB.Connection")
set rse=server.createobject("ADODB.Recordset")
basemailing.Open CONmailing

'COmpruebo si hay filtro y caso contrario se añaden todas
cs="SELECT nombre,apellidos,email,Id FROM FormulariosWeb "
cs= cs & cond & " ORDER BY email"
rs.open cs,base
if rs.eof then
	errormsg="No hay registros selecionados, vaya al listado de clientes y haga un filtrado"
	
else
	CNom=0
	CApe=1
	CEmail=2
	CCodi=3
	dim LosReg
	LosReg=rs.GetRows 'Los pongo en la tabla
	
	PorPag=100
	TotReg=ubound(LosReg,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=clng("0" & request.querystring("P"))
	if Pag<=0 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
end if
rs.close

if pag=1 then 'la primero creo los registros
	'INSERTO MENSAJE
	cond=QuitaApos(cond)
	fenvio=FechaSQL(date())
	cs="INSERT INTO " & precrs & "resum (Asunto,Mensaje,Filtro,errores,correctos,fechaenvio) values('"
		cs=cs & asunto &  "','" & mensaje & "','" & cond & "',0,0,"  & fenvio & ")"
		basemailing.execute cs
	'Busco el ult. mensaje
	cs="SELECT MAX(Id) as IdMensaje FROM " & precrs & "resum"
	rse.open cs,basemailing
	if isnull(rse("idmensaje")) then
		nid=1
	else
		nid=rse("idmensaje")
	end if
	rse.close
	'Nuevo error
	cs="SELECT MAX(id) as nuevaid FROM " & precrs & "detallerr"
	rse.open cs,basemailing
	if isnull(rse("nuevaid")) then
		nuevaid=1
	else
		nuevaid=rse("nuevaid")
	end if
	rse.close
	
	'contador
	guenos=0
	malos=0

else 'cargar del form
	nid=clng("0" & request.form("idm"))
	nuevaid=clng("0" & request.form("ide"))
	'contador
	guenos=clng("0" & request.form("guenos"))
	malos=clng("0" & request.form("malos"))

end if

set rse=nothing

%>

<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top' width="680" style="padding-left:5px;">
		<img src="img/transparente.gif" width="2" height="35"><br />
	<table align='center' width="770" cellspacing='0'>
	<tr><td height='10' colspan='2'></td></tr>
	  <tr> 
		<td class="bordecito" colspan='2'><font color="#FFFFFF" size="-2">&nbsp;&middot;<strong> 
		  Total E-Mails: <%=ubound(losreg,2)+1%></strong></font></td>
	  </tr>
	<tr><td>
	<div align='left' style='width:770px; height:450px; overflow:auto'>
	<table width='100%' border='0' cellpadding="0" cellspacing="0">
	<%
	'Realizar el envio
	ideerr=nuevaid
	miemail="----"
	for R=IReg to IReg+PorPag-1
		if R>ubound(LosReg,2) then exit for
		
		email=losreg(CEMail,R)
		if miemail<>email then
			if email<>"" then 'Envio
				response.write "<tr><td align='left'>" & vbcrlf
				'server.Transfer "funciones/funcionmail.asp"
				respuesta=""
				respuesta=sendemailto(email,asunto,remitente,smtpserver,mensaje)
				response.write losreg(CApe,R) & ", " & losreg(CNom,R) & "</td>" & vbcrlf
				response.write "<td align='left'>" & email & "</td>" & vbcrlf
				if respuesta="" then 'No hay error al envio
					guenos=guenos+1
					response.write "<td align='left'>Envio Correcto</td></tr>" & vbcrlf
					'Guardar en la base datos de enviados
					
				else
					response.write "<td align='left'>Error de envio (" & respuesta & ")</td></tr>" & vbcrlf
					malos=malos+1
					ideerr=ideerr +1
					nom=losreg(cnom,r)& " " &  losreg(cape,r)
					cs="INSERT INTO " & precrs & "detallerr(idmensaje,idcliente,nombre,apellidos,email,Descripcion) VALUES("
					cs=cs & nid & "," & losreg(ccodi,r) & ",'" & losreg(cnom,r) & "','" & losreg(cape,r) & "','" & losreg(CEmail,r) & "','" & quitarApos(respuesta) & "')"
					basemailing.execute cs
				end if
			end if
			response.Flush()
		end if
	miemail=email
	next%>
	</table>
	<form name="siguiente" method="post" action="<%=MiPag%>?P=<%=pag+1%>">
		<input type="hidden" name="asunto" value='<%=asunto%>'>
		<textarea name="mensaje" style="height:1px; width:1px;"><%=mensaje%></textarea>
		<input type="hidden" name="guenos" value='<%=guenos%>'>
		<input type="hidden" name="malos" value='<%=malos%>'>
		<input type="hidden" name="idm" value='<%=nid%>'>
		<input type="hidden" name="ide" value='<%=ideerr%>'>
	</form>
	<%if Pag<MaxP then 'cargar otra pagina%>
		<script language="javascript" type="text/javascript">
			//window.location='<%=MiPag%>?P=<%=pag+1%>';
			document.siguiente.submit();
		</script>
	<%end if%>
	
	<%
	'Guardar resumen
	cs="UPDATE resum SET errores=" & malos & ",correctos=" & guenos
	cs=cs & " WHERE ID="
	cs=cs & nid
	basemailing.execute cs
	
	base.close
	set base=nothing

	basemailing.close
	set basemailing=nothing
	

	%>
	</div>
	</td></tr>
	<tr><td height="10" colspan="2"></td></tr>
	<tr> 
		<td class="bordecito" colspan='2'><font color="#FFFFFF" size="-2">&nbsp;&middot;<strong> 
		  Correctos: <%=guenos%>&nbsp;&nbsp;&nbsp;&nbsp;Errores: <%=malos%></strong></font></td>
	  </tr>

	<tr><td height="10" colspan="2"></td></tr>
	</table>

	</td>
	</tr>
</table>
</body>
</html>
