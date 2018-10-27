<!--#include file="includes/FunGestion.asp"-->
<!-- #Include File="Connections/JSFunctionsUsers.js"-->
<%
If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
%>
<!-- #Include File="Connections/UsersFunctions.asp"--> 
<%
SQLAccess

if ubound(split(session.Contents("QuinsHotels"),";",-1,vbTextCompare))=0 and session.Contents("QuinsHotels")<>"" then 
	valors(0,1)=session.Contents("QuinsHotels")
	cs= "SELECT Idioma FROM " & precrs & "LocalParameters"
	rs.open cs,base
	if session.Contents("idiomafet")="" then valors(6,1)=rs.Fields(0)
	session.Contents("idiomafet")=rs.Fields(0)
	rs.Close
end if
'Funció per actualitzar/Gravar dades
'SQLAccess
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Hotel-Hoteles.com - Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
.style1 {color: #000000}
.style2 {color: #9933CC}
.style3 {color: #FFFFFF}
-->
</style></head>

<body link="#ffffff" vlink="#ffffff" alink="#ffffff">
<center>
<table width="250" height="71" border="0" cellpadding="0" cellspacing="0">
  <tr><td background="img/corners/a_c.gif"><div align="center" class="style3">CENTRAL DE RESERVAS ONLINE </div></td></tr>
  <tr><td class="tdTabla"><table border=0 cellpadding=0 cellspacing=0  class="tdTabla" class="bordecito1px">
      <tr>
        <td colspan="2" align="center" class="bordecitobl" style="color:#ffffff;font-size:10pt;">&nbsp;</td>
      </tr>
      <tr>
        <td  valign="top">
          <form name="users">
            <table width="363" height="100"border="0" cellpadding="0" cellspacing="0" bgcolor="#e1e1e1">
              <tr>
                <td height="18" colspan="4" class="CabeTabla" style="color:#ffffff;"> &nbsp;Usuarios</td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td >&nbsp; </td>
                <td >&nbsp; </td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;
                    <select name="cbuser" id="select3"  onChange="document.forms.actualizar.hcbuser.value=document.forms.users.cbuser.value;usersname();comprovar ();">
                      <option value="sel" selected>Seleccione</option>
                      <option value="new">Nueva</option>
                      <%
				'cmdDC.CommandText = "SELECT  Usuaris.UserName, Usuaris.Pass, Usuaris.Nom, PermisosPorEsta.CodigoEsta FROM Usuaris LEFT OUTER JOIN PermisosPorEsta ON Usuaris.UserName = PermisosPorEsta.Username"
				cs = "SELECT  Usuaris.UserName, Usuaris.Pass, Usuaris.Nom FROM Usuaris WHERE(UserName <> N'THBHOTELS')"
				rs.open cs,base
				i=1
				ii=1
				do while not rs.eof
					ii=ii+1
					rs.Movenext
				loop
				ReDim Preserve Usernames(ii,4)
				if ii>1 then rs.moveFirst()
				do while not rs.eof
					Usernames(i-1,0)=rs(0)
					Usernames(i-1,1)=rs(1)
					Usernames(i-1,2)=rs(2)
					i=i+1
					if cstr(rs(0)) = cstr(valors(0,1)) then  
						response.Write("<option value=""" & rs(0) & """ SELECTED>" & rs(0) &  "</option>")
					else
						response.Write("<option value=""" & rs(0) & """>" & rs(0) & "</option>")
					end if
					rs.movenext
				loop
				rs.close
				%>
                    </select>
                    <%	
				response.Write("<script>")
					for cont=0 to i-2
						response.Write("Usernames['" & Usernames(cont,0) & "']=new Array ();")
						response.Write("Usernames['" & Usernames(cont,0) & "'][0]='" & Usernames(cont,1) & "';")
						response.Write("Usernames['" & Usernames(cont,0) & "'][1]='" & Usernames(cont,2) & "';")
					next
				response.Write("var Usernamesc=" & cont & ";</script>")
			%></td>
                <td>Nombre</td>
                <td><input name="txtnombre" type="text" id="txtnombre2"   value="<%=Valors(1,1)%>" size="20"></td>
                <td><input type="button" name="Submit42" value="Actualizar" onClick="return reloadpage('Esta acci&oacute;n recargar&aacute; la p&aacute;gina perdiendo los datos no guardados a excepci&oacute;n de los introducidos en USUARIOS.\nSi desea continuar pulse Aceptar.','Usuarios','act')">
                </td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;</td>
                <td>Usuario</td>
                <td><input name="txtuser" type="text" maxlength="10" id="txtuser2"   value="<%=Valors(1,1)%>" size="20"></td>
                <td><input type="button" name="Submit23" value="Borrar"  onClick="return reloadpage('Borrar un establecimiento supone la eliminaci&oacute;n de los permisos asociados a &eacute;ste.\nSi desea continuar pulse Aceptar.','Usuarios','borr')"></td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;</td>
                <td>Contrase&ntilde;a</td>
                <td><input name="txtpass" type="text" id="txtpass2"   value="<%=Valors(1,1)%>" size="20"></td>
                <td>&nbsp; </td>
              </tr>
            </table>
        </form></td>
        <td valign="top">
          <form name="establecimiento">
            <table  width="363" height="100" border="0" cellpadding="0" cellspacing="0" bgcolor="#e1e1e1">
              <tr>
                <td height="18" colspan="5" class="CabeTabla" style="color:#ffffff;">&nbsp;Establecimientos</td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td w>&nbsp;</td>
                <td w>&nbsp; </td>
                <td >&nbsp; </td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;Establecimientos</td>
                <td ><select name="cbestables" id="select6"  onChange="document.forms.actualizar.hcbestables.value=document.forms.establecimiento.cbestables.value;">
                    <option value="sel" selected>Seleccione</option>
                    <%
				cs= "SELECT Establecimientos.CodigoEsta, Establecimientos.Nombre FROM " & precrs & "Establecimientos"
				rs.open cs,base
				i=0
				do while not rs.eof
					if cstr(rs(0)) = cstr(valors(0,1)) then  
						response.Write("<option value=""" & rs(0) & """ SELECTED>" & rs(1) & "</option>")
					else
						response.Write("<option value=""" & rs(0) & """>" & rs(1) & "</option>")
					end if
					Redim preserve estable(i+1)
					estable(i)=rs(0)
					i=i+1
					rs.movenext
				loop
				rs.close
				%>
                  </select>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="button" name="Submit43" value="Actualizar" onClick="return reloadpage('Esta acci&oacute;n recargar&aacute; la p&aacute;gina perdiendo los datos no guardados a excepci&oacute;n de los introducidos en ESTABLECIMIENTO.\nSi desea continuar pulse Aceptar.','Establecimientos','act')">
                </td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;Estable. del usuario</td>
                <td><select name="cbesta"   onChange="document.forms.actualizar.hcbestables.value=document.forms.establecimiento.cbestables.value;">
                    <%
				cs= "SELECT Establecimientos.CodigoEsta, Establecimientos.Nombre FROM " & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "PermisosPorEsta PermisosPorEsta ON Establecimientos.CodigoEsta = PermisosPorEsta.CodigoEsta WHERE (PermisosPorEsta.Username = N'" & Valors(0,1) & "')"
				rs.open cs,base
				i=0
				do while not rs.eof
					if cstr(rs(0)) = cstr(valors(0,1)) then  
						response.Write("<option value=""" & rs(0) & """ SELECTED>" & rs(1) & "</option>")
					else
						response.Write("<option value=""" & rs(0) & """>" & rs(1) & "</option>")
					end if
					Redim preserve estable(i+1)
					estable(i)=rs(0)
					i=i+1
					rs.movenext
				loop
				rs.close
				if i=0 and Valors(0,1)<>"new" and Valors(0,1)<>"" and Valors(0,1)<>"sel" then response.Write("<option value="""">" & "Todos" & "</option>")
				%>
                </select></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="button" name="Submit232" value="Borrar"  onClick="return reloadpage('Va a borrar los permisos sobre el establecimiento.\nSi desea continuar pulse Aceptar.','Establecimientos','borr')"></td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
        </form></td>
      </tr>
      <tr>
        <td  valign="top">
          <form name="avisos">
            <table  width="363" height="91"  border="0" cellpadding="0" cellspacing="0" bgcolor="#e1e1e1">
              <tr>
                <td height="18" colspan="2" class="CabeTabla" style="color:#ffffff;">&nbsp;Avisos</td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;</td>
                <td>&nbsp; </td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;
                    <select name="cbavisos" id="select"  onChange="document.forms.actualizar.hcbavisos.value=document.forms.avisos.cbavisos.value;">
                      <%
				cs = "SELECT Avisos FROM " & precrs & "LocalParameters;"
				rs.open cs,base
				%>
                      <option value="-1" <%if rs.Fields(0)=-1 then response.Write("Selected")%>>Activados</option>
                      <option value="0" <%if rs.Fields(0)=0 then response.Write("Selected")%>>Desactivados</option>
                      <%rs.Close
				%>
                  </select></td>
                <td>&nbsp;
                    <input type="button" name="Submit4" value="Actualizar" onClick="return reloadpage('Esta acci&oacute;n recargar&aacute; la p&aacute;gina perdiendo los datos no guardados a excepci&oacute;n de los introducidos en Avisos.\nSi desea continuar pulse Aceptar.','Avisos','act')"></td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
        </form></td>
        <td  valign="top">
          <form name="idiomas">
            <table  width="363" height="91"  border="0" cellpadding="0" cellspacing="0" bgcolor="#e1e1e1">
              <tr bgcolor="#FFFFF">
                <td height="18" colspan="2" class="CabeTabla" style="color:#ffffff;">&nbsp;Idioma por defecto</td>
              </tr>
              <tr class="tdTabla">
                <td width="44"  height="17">&nbsp;</td>
                <td width="188" >&nbsp; </td>
              </tr>
              <tr class="tdTabla">
                <td >&nbsp;
                    <select name="cbidioma" id="select"  onChange="document.forms.actualizar.hcbidioma.value=document.forms.idiomas.cbidioma.value;">
                      <%
				cs = "SELECT Idioma FROM " & precrs & "LocalParameters"
				rs.open cs,base
				valors(6,1)=rs.Fields(0)
				rs.Close
				cs = "SELECT * FROM " & precrs & "Idiomas;"
				rs.open cs,base
				i=0
				do while not rs.eof
					if cstr(rs(0)) = cstr(valors(6,1)) then  
						response.Write("<option value=""" & rs(0) & """ SELECTED>" & rs(1) & "</option>")
					else
						response.Write("<option value=""" & rs(0) & """>" & rs(1) & "</option>")
					end if
					Redim preserve Idiomas(i+1)
					Idiomas(i)=rs(0)
					i=i+1
					rs.movenext
				loop
				rs.close
				response.Write("<script>var idiomas=new Array(" & i & ");var iditot=" & i & ";")
				for cont=0 to i-1
					response.Write("idiomas[" & cont & "]='" & Idiomas(cont) & "';")
				next
				response.Write("</script>")
				%>
                  </select></td>
                <td>&nbsp;
                    <input type="button" name="Submit4" value="Actualizar" onClick="return reloadpage('Esta acci&oacute;n recargar&aacute; la p&aacute;gina perdiendo los datos no guardados a excepci&oacute;n de los introducidos en IDIOMA POR DEFECTO.\nSi desea continuar pulse Aceptar.','idioma','act')"></td>
              </tr>
              <tr class="tdTabla">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
          </form>
      </tr>
      <tr>
        <td>
          <div align="left" class="texto10 style1">&nbsp;&nbsp;&nbsp;<a href="Users.asp" class="style1">Gesti&oacute;n de usuarios</a></div></td>
        <td><div align="right" class="texto10 style2"><a href="alojamientos.asp"><span class="style1">Gesti&oacute;n de Hoteles</span></a>&nbsp;</div></td>
      </tr>
    </table></td></tr>
</table>
<form action="Users.asp" method="post" name="actualizar">
  <input name="hcbuser" type="hidden"  value="<%=Valors(0,1)%>">
  <input name="htxtnombre" type="hidden" value="<%=Valors(1,1)%>">
  <input name="htxtuser" type="hidden" value="<%=Valors(2,1)%>">
  <input type="hidden" name="htxtpass" value="<%=Valors(3,1)%>">
  <input name="hcbesta" type="hidden" id="hcbesta" value="<%=Valors(4,1)%>">
  <input name="hcbestables" type="hidden" id="hcbestables" value="<%=Valors(5,1)%>">
  <input type="hidden" name="hcbidioma" value="<%=Valors(6,1)%>">
  <input name="hcbavisos" type="hidden" id="hcbavisos" value="<%=Valors(7,1)%>">
  <input type="hidden" name="hqui" value="<%=Valors(8,1)%>">
  <input type="hidden" name="hque" value="<%=Valors(9,1)%>">
</form>
</center>
</body>
<script>
	usersname();
</script>
<%
set rs=nothing
base.close
set base=nothing
%>
</html>

