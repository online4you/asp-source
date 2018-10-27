<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

server.ScriptTimeout=1000

nerrores=0
asunto=quitarApos(request.Form("asunto"))
mensaje=quitarApos(request.Form("mensaje"))
remite=quitarApos(request.Form("remite"))

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open conecta

'poner el filtro
cs=request.Cookies("envioFiltro")
cs=cs & " ORDER BY EMail"
'response.write cs & "<br>"
rs.open cs,base
if not rs.eof then
	LosReg=rs.GetRows 'Los pongo en la tabla
	CCodi=0
	CEmail=1
	
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
	cond=request.Cookies("envioFiltro")
	'Buscar la tabla dentro de cond
	if instr(lcase(cond),"codigovip<>''")<>0 then 'es VIP
		latabla="VIP"
	else
		latabla="Fichas"
	end if
	
	'INSERTO MENSAJE
	cs="INSERT INTO " & precrs & "ResumenEMails (Asunto,Mensaje,Filtro,errores,correctos,fechaenvio,Tabla) values('"
	cs=cs & asunto &  "','" & mensaje & "','" & quitarApos(cond) & "',0,0,"
	cs=cs & FechaMySQL(date) & ",'" & latabla & "')"
	'response.write cs
	base.execute cs
	'Busco el ult. mensaje
	cs="SELECT MAX(Id) as IdMensaje FROM " & precrs & "ResumenEMails"
	rs.open cs,base
	nid=clng("0" & rs("idmensaje"))
	rs.close
	
	'Nuevo error
	cs="SELECT MAX(id) as nuevaid FROM " & precrs & "ErrorEMails"
	rs.open cs,base
	nuevaid=clng("0" & rs("nuevaid"))
	rs.close
	
	'contador
	guenos=0
	malos=0

else 'cargar del form
	nid=clng("0" & request.form("idm"))
	nuevaid=clng("0" & request.form("ide"))
	'contador
	guenos=clng("0" & request.form("guenos"))
	malos=clng("0" & request.form("malos"))
	latabla=request.form("latabla")

end if

set rs=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <table border="0" align='left' cellpadding="0" cellspacing="0">
      <tr> 
        <td align="left" width="750"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
            <tr> 
              <td colspan="3" align="left" class="tituloTabla">Envio de EMails: 
                <%=ubound(losreg,2)+1%> registros</td>
            </tr>
            <tr> 
              <th align="center" class="colu_impar">Id</th>
              <th align="left" class="colu_par">EMail</th>
              <th align="left" class="colu_impar"></th>
            </tr>
            <%
	'Realizar el envio
	ideerr=nuevaid
	miemail="----"
	for R=IReg to IReg+PorPag-1
		if R>ubound(LosReg,2) then exit for
		
		email=losreg(CEmail,R)
		if miemail<>email then
			if email<>"" then 'Envio
				response.write "<tr><td align='center'>" & losReg(CCodi,r) & "</td>" & vbcrlf
				response.write "<td align='left'>" & email & "</td>" & vbcrlf
				respuesta=""
				respuesta=sendemailto(email,asunto,remite,mensaje)
				if respuesta="" then 'No hay error al envio
					guenos=guenos+1
					response.write "<td align='left'>Envio Correcto</td></tr>" & vbcrlf
				else
					response.write "<td align='left'>Error de envio (" & respuesta & ")</td></tr>" & vbcrlf
					malos=malos+1
					ideerr=ideerr +1
					cs="INSERT INTO ErrorEMails(idmensaje,idcliente,email,Descripcion,Tabla) VALUES("
					cs=cs & nid & "," & losreg(CId,r) & ",'" & email & "','" & quitarApos(respuesta)
					cs=cs & "','" & latabla & "')"
					base.execute cs
				end if
			end if
			response.Flush()
		end if
	miemail=email
	next%>
          </table>
          <form name="siguiente" method="post" action="<%=MiPag%>?P=<%=pag+1%>">
            <input type="hidden" name="asunto" value='<%=asunto%>'>
            <input type="hidden" name="remite" value='<%=remite%>'>
            <textarea name="mensaje" style="height:1px; width:1px;"><%=mensaje%></textarea>
            <input type="hidden" name="guenos" value='<%=guenos%>'>
            <input type="hidden" name="malos" value='<%=malos%>'>
            <input type="hidden" name="idm" value='<%=nid%>'>
            <input type="hidden" name="ide" value='<%=ideerr%>'>
            <input type="hidden" name="latabla" value='<%=latabla%>'>
          </form>
          <%if Pag<MaxP then 'cargar otra pagina
		base.close
		set base=nothing
		%>
          <script language="javascript" type="text/javascript">
			document.siguiente.submit();
		</script> 
          <%end if%>
          <%
	'Guardar resumen
	cs="UPDATE ResumenEMails SET errores=" & malos & ",correctos=" & guenos
	cs=cs & " WHERE Id=" & nid
	base.execute cs
	
	base.close
	set base=nothing
	%>
        </td>
      <tr> 
        <td height="10"></td>
      </tr>
      <tr> 
        <td class="tituloTabla"> Correctos: <%=guenos%>&nbsp;&nbsp;&nbsp;&nbsp;Errores: 
          <%=malos%></td>
      </tr>
      <tr> 
        <td height="10"></td>
      </tr>
    </table>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
</body>
</html>
