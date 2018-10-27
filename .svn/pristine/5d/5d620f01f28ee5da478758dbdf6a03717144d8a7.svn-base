<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
lang=request.QueryString("lang")
if lang="" then lang=request.Cookies("idiomaCR")
if lang="" then lang="es"
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

session.Timeout=90
if request.QueryString("salir")="Si" then
%><!--#include file="limpiaCookies.asp"--><%
end if 'salir

If Request.ServerVariables("HTTPS")="off" Then
	strRedirURL = "https://" & Request.ServerVariables("SERVER_NAME")
	strRedirURL = strRedirURL & request.servervariables("SCRIPT_NAME")
	Response.Redirect strRedirURL
End If

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2
'ConectaMDB = "provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=D:\XVRT\planetaweb.es\data\EmpresasReservas.mdb"
ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=qcu151;pwd=Planeta2007;Initial Catalog=qcu151;Data Source=lwda241.servidoresdns.net"

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if request.form<>"" then
	'Cambiar apostrofe por acento, para datos en SQL
	function QuitarApos(eso)
		QuitarApos=replace(eso,"'","´")
	end function
	
	
	user=QuitarApos(request.form("user"))
	pass=QuitarApos(request.form("pass"))

	%><!--#include file="limpiaCookies.asp"--><%

	if user<>"" and pass<>"" then
		cs="SELECT Usuarios.Id,Empresas.Id as IdEmp,Empresas.Nombre as Empresa,ConexionBD,UserBD,PwdBD,HojaEstilos,"
		cs=cs & "MetaTitulo,Modulos,RutaFotos,RutaDocu,MySQL "
		cs=cs & "FROM Usuarios LEFT JOIN Empresas "
		cs=cs & "ON Usuarios.IdEmpresa=Empresas.Id "
		cs=cs & "WHERE Usuario='" & user & "' AND Clave='" & pass & "'"
		'response.write(cs & "<br/>")
		rs.open cs,base
		if not rs.eof then
			if request.form("recordarme")="1" then 'guarda cookie
				response.Cookies("userCR")=user
				response.cookies("userCR").expires=DateAdd("yyyy",1,date) 
				response.Cookies("pwdCR")=pass
				response.cookies("pwdCR").expires=DateAdd("yyyy",1,date) 	
			else
				if request.Cookies("userCR")<>user then 'ponemos la cookie
					'Solo pa un dia
					response.Cookies("userCR")=user
					response.Cookies("pwdCR")=pass
				end if
			end if 'recordarme
			idusu=rs("id")
			response.Cookies("IDCR")=idusu
			'Guarda cookie en fichero			
			set objCookies = new clsCookie 'carga la clase para las cookies con la id usuario
			objCookies.setCookie "Empresa",paClng(rs("Empresa")) 'guarda cookie
			if rs("MySQL") then	mysqlBD=true else mysqlBD=false
			objCookies.setCookie "mysqlBD",mysqlBD 'guarda cookie
			objCookies.setCookie "conexBD",rs("ConexionBD")
			objCookies.setCookie "userBD",rs("userBD") 'guarda cookie
			objCookies.setCookie "pwdBD",rs("pwdBD") 'guarda cookie
			objCookies.setCookie "modulosCR",rs("modulos") 'guarda cookie
			objCookies.setCookie "hojaEstilos",rs("hojaEstilos") 'guarda cookie
			objCookies.setCookie "metaTitulo",rs("metaTitulo") 'guarda cookie
			objCookies.setCookie "rutaFotos",rs("rutaFotos") 'guarda cookie
			objCookies.setCookie "rutaDocu",rs("rutaDocu") 'guarda cookie
			objCookies.setCookie "idEmp",paClng(rs("IdEmp")) 'guarda cookie
			adminBoss=false
			if paClng(rs("IdEmp"))=0 then
				adminBoss=true
			end if
			rs.close 
			objCookies.setCookie "adminBoss",adminBoss
		
			hotelboss="0"		
			cs = "SELECT CodigoEsta FROM PermisosPorEsta "
			cs=cs & "WHERE IdUsuario=" & request.Cookies("IDCR")
			rs.Open cs,base
			'Cargar los hoyteles que tiene, el adminst. no tiene hoteles espec.
			listaH=""
			do while not rs.eof
				listaH=listaH & rs("CodigoEsta") & ";"
				rs.MoveNext
			loop
			if not rs.eof then 'quitar el ;
				listaH=left(listaH,len(listaH)-1)
			end if
			if adminBoss then listaH="0"
			if listaH="" then listaH="0"
			objCookies.setCookie "hotelBoss",listaH
			rs.close
			
			response.Cookies("idiomaCR")=lang
			response.cookies("idiomaCR").expires=DateAdd("yyyy",1,date) 
			
			set objCookies=nothing
			
			
			
			'response.write "hotelBoss:"& request.Cookies("hotelboss")
			'response.End()
			
		else
			rs.close
			depur="Nombre de usuario o contraseña no válidos"
		end if
	
	end if 'user<>"" and pass<>""
	'response.write request.Cookies("okCr") & "<br>"
	'response.End()

end if 'form<>""

'Admin general
adminBoss=false
if adminBoss then 'tabla empresa
	cs="SELECT Id,Nombre FROM Empresas ORDER BY Nombre"
	rs.open cs,base
	hayempre=false
	if not rs.eof then
		RegEmpre=rs.getrows
		EmCodi=0
		EmNombre=1
		hayempre=true
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
<script language="javascript" type="text/javascript" src="includes/losFrames.js"></script>
<script language="javascript" type="text/javascript" src="includes/moverFrames.js"></script>
<script language="javascript" type="text/javascript">
	function getCookie(name) {
		var cname=name + "=";
		var dc=document.cookie;
		if (dc.length>0){
			begin=dc.indexOf(cname);
			if (begin!=-1){
				begin+=cname.length;
				end=dc.indexOf(";",begin);
				if(end==-1)
					end=dc.length;
				return(dc.substring(begin,end));
			}
		}
		return "";
	}
	
	function noIframe()
	{
		try
		{
			if( window.parent!=window && !parent.noIframe() )
				return false;
			else
				return true;
		}
		catch(e){}	
	}
	if (!noIframe())
		top.location.href = self.document.location;

</script>

</head>
<body style="background-image:none; margin-top:40px;">
<center>
<%if Clng("0" & request.Cookies("IDCR"))=0 then %>
<table width="250" border="0" cellpadding="0" cellspacing="0" class="caja">
  <tr><td align="center" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_usuarioypwd")%></td></tr>
  <tr><td class="tdTabla">
  	<form name="login" action="indexVte.asp?lang=<%=lang%>" method="post">
      <table width="100%" border="0" cellpadding="0" cellspacing="2" class="tdTabla">
        <tr>
          <td colspan="2" align="center" class="style2"><b><%=(depur)%></b></td>
        </tr>
        <tr>
          <td colspan="2" align="center" class="style2">
		  <a href="index.asp">Espa&ntilde;ol</a>&nbsp;&nbsp;&nbsp;
		  <a href="index.asp?lang=en">English</a>&nbsp;&nbsp;&nbsp;
		  <a href="index.asp?lang=de">Deutsch</a>
		  </td>
        </tr>
        <tr>
          <td align="right" class="style2"><%=objIdioma.getTraduccionHTML("i_usuario")%>:</td>
          <td class="texto11" align="left"><input name="User" type="text" id="User" size="20">
          </td>
        </tr>
        <tr>
          <td align="right" class="style2"><%=objIdioma.getTraduccionHTML("i_pwd")%>:</td>
          <td class="texto11" align="left"><input name="Pass" type="password" id="Pass" size="20"></td>
        </tr>
		<tr><td align="right"></td>
			<td align="left" class="style2">
			<input type="checkbox" name='recordarme' value="1"> <%=objIdioma.getTraduccionHTML("i_recordarme")%>.</td>
		</tr>
        <tr>
          <td class="texto11" align="center" colspan="2">
              <input class="boton145" type="submit" name="Submit4" value="<%=objIdioma.getTraduccionHTML("i_entrar")%>">
          </td>
        </tr>
      </table>
    </form>
	</td></tr>
</table>	
<script language="javascript">
	//recogel las galletas
	document.login.User.value=getCookie("userCR");
	document.login.Pass.value=getCookie("pwdCR");
	document.login.User.focus();
</script>
<%else
	if hotelboss<>"0" then
		response.Redirect("cr.asp?lang=" & lang)
	else
		response.Redirect("inicio.asp?lang=" & lang)
	end if
end if%>		
</center>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
