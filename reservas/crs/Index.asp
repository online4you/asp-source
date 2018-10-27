<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<!--#include file="includes/constantes.asp"-->
<%
'Nivel usuarios
const TAdmin=0 'administrador
const TCadena=2 'Cadena hotelera
const TRecepcion=5 'Recepcion
const TComercial=7 'Comercial sólo precios
const TRelacion=10 'Relaciones publicas
const TAgencia=15 'Agencias

lang=request.QueryString("lang")
if lang="" then lang=request.Cookies("idiomaCR")
if lang="" then lang="es"
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

session.Timeout=90
if request.QueryString("salir")="Si" then
%><!--#include file="limpiaCookies.asp"--><%
end if 'salir

noSoportado=false
navegador=request.ServerVariables("HTTP_USER_AGENT")
if instr(navegador,"MSIE 6.0")<>0 or instr(navegador,"MSIE 5")<>0 then noSoportado=true

adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2
'ConectaMDB = "provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=C:\Users\gpuigros\Desktop\Joomla\Aplicaciones\CRS\CRS_general.accdb"
'ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=jupiter.planeta-web.com"
'ConectaMDB = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\gpuigros\Desktop\Joomla\Aplicaciones\CRS\CRS_general.accdb;Persist Security Info=False;"
ConectaMDB = "Driver={MySQL ODBC 5.1 Driver};Server=ddbb.online4youhotels.com;Database=" & split(Request.ServerVariables("SERVER_NAME"),".")(0) & ";Uid=reservas;Pwd=O4u7612;"
'response.Write(ConectaMDB)

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
		cs="SELECT usuarios.Id,empresas.Id as IdEmp,empresas.Nombre as Empresa,ConexionBD,UserBD,PwdBD,HojaEstilos,"
		cs=cs & "MetaTitulo,Modulos,RutaFotos,RutaDocu,MySQL,Nivel "
		cs=cs & "FROM " & precrsgen & "usuarios usuarios LEFT JOIN " & precrsgen & "empresas empresas "
		cs=cs & "ON usuarios.IdEmpresa=empresas.Id "
		cs=cs & "WHERE Usuario='" & user & "' AND Clave='" & pass & "' AND Activo<>0"
		response.write(cs & "<br/>")
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
			response.Cookies("IdEmpresa")=paClng(rs("IdEmp"))
			response.Cookies("nivelCR")=rs("nivel")
			response.Cookies("tarifa")=1 'tarifa general
			rs.close
			response.Cookies("IDCR")=idusu
			cs = "SELECT CodigoEsta FROM " & precrsgen & "permisosporesta "
			cs=cs & "WHERE IdUsuario=" & idusu
			'response.write cs
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
			if listaH="" then listaH="0"
			hotelboss=listaH
			rs.close
			
			if listaH="0" and paClng(request.Cookies("nivelCR"))<>TAdmin then 
				response.Cookies("IDCR")=0
				depur="No tiene autorizaci&oacute;n"
			end if
			response.Cookies("idiomaCR")=lang
			response.cookies("idiomaCR").expires=DateAdd("yyyy",1,date) 
			'response.write "hotelBoss:"& request.Cookies("hotelboss")
			'response.End()
			if paClng(request.Cookies("nivelCR"))=TAgencia then 'ir al modulo de Agencia
				response.Redirect("agencias/agencias.asp?lang=es")
			end if
			if paClng(request.Cookies("nivelCR"))=TRelacion then 'ir al modulo de rel. publicas
				select case paClng(request.Cookies("IdEmpresa"))
					case 82 'intertur
					response.Redirect("InterturAmigos/vip.asp?lang=es")
					case else
					response.Redirect("rvirtual/rvirtual.asp?lang=es")
				end select
			end if
			
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
<%if paClng(request.Cookies("IDCR"))=0 then %>
<table width="320" border="0" cellpadding="0" cellspacing="0" class="caja">
  <tr><td align="center" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_usuarioypwd")%></td></tr>
  <tr><td class="tdTabla">
  	<form name="login" action="index.asp?lang=<%=lang%>" method="post">
      <table width="100%" border="0" cellpadding="0" cellspacing="2" class="tdTabla">
        <tr>
          <td colspan="2" align="center" class="style2"><b><%=depur%></b></td>
        </tr>
        <tr>
          <td colspan="2" align="center" class="style2">
		  <a href="index.asp?lang=es">Espa&ntilde;ol</a>&nbsp;&nbsp;&nbsp;
		  <a href="index.asp?lang=en">English</a>&nbsp;&nbsp;&nbsp;
		  <a href="index.asp?lang=de">Deutsch</a>&nbsp;&nbsp;&nbsp;
          <!--<a href="index.asp?lang=bg">български</a>-->
          <a href="index.asp?lang=pt">Portugu&ecirc;s</a>
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
	<%if noSoportado then%>
	alert("Nuestro sistema ha detectado que su navegador no es el apropiado para controlar esta aplicación. No están soportados los navegadores por debajo de Internet Explorer 7.0. \nSi está seguro de que su navegador cumple con este requisito, puede continuar. En caso contrario, debería actualizar su navegador a la versión 7.0 o 8.0.\nDisculpe las molestias.");
	<%end if%>	
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
