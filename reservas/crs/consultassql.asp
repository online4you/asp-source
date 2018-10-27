<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

cs="SELECT Id,Nombre FROM " & precrsgen & "empresas ORDER BY Nombre"
rs.open cs,base
hayempre=false
if not rs.eof then
	RegEmpre=rs.getrows
	EmCodi=0
	EmNombre=1
	hayempre=true
end if
rs.close

laempre=request.Form("laempre")

cssql = request.Form("consulta")
if cssql<>"" then
	if laempre="-1" then 'base central
		
		set basecs = server.createobject("ADODB.Connection")
		basecs.open ConectaMDB
		cs=split(cssql,";")
		if ubound(cs)>=0 then
			for c=0 to ubound(cs)
				cadena=trim(cs(c))
				if cadena<>"" then 'hacer consulta
					basecs.execute cadena
				end if 'cadena<>""
			next 'cs
		end if 'hay cs
		basecs.close
		set basecs = nothing
			
	else 'las otras empresas

		cs="SELECT ConexionBD, NombreBD, userBD, PwdBD, MySQL FROM " & precrs & "Empresas "
		if laempre<>0 then
			cs = cs & "WHERE Id= " & laempre
		end if
		rs.open cs,base
		if not rs.eof then
			RgEmpre=rs.getrows
			conexBD=0
			nombreBD=1
			userBD=2
			pwdBD=3
			mySQL=4
		end if
		for e=0 to ubound(RgEmpre,2)
			if not RgEmpre(mySQL,e) then 'sql server
				Conecta = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=" & RgEmpre(userBD,e) & ";pwd=" & RgEmpre(pwdBD,e) & ";Initial Catalog=" & RgEmpre(nombreBD,e) & ";Data Source=" & RgEmpre(conexBD,e)
			else 'my sql
				Conecta="Driver={MySQL ODBC 5.1 Driver};Server=" & RgEmpre(conexBD,e) & ";Database=" & RgEmpre(nombreBD,e) & ";Uid=" & RgEmpre(userBD,e) & ";Pwd=" & RgEmpre(pwdBD,e) & ";Extended Properties='OPTION=16387'"
			end if
			response.write conecta & "<br>"
			set basecs = server.createobject("ADODB.Connection")
			basecs.open Conecta
			cs=split(cssql,";")
			if ubound(cs)>=0 then
				for c=0 to ubound(cs)
					cadena=trim(cs(c))
					if cadena<>"" then 'hacer consulta
						basecs.execute cadena
					end if 'cadena<>""
				next 'cs
			end if 'hay cs
			basecs.close
			set basecs = nothing
		next
		rs.close
	
	
	end if 'laempre
	
end if 'cssql<>""
set rs = nothing
base.close
set base = nothing

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form action="<%=MiPag%>" method="post" name="f1">
      <div style="margin:20px;"> 
        <input type='button' class="boton145" value='Menu Anterior' onclick="javascript:window.location='index.asp';" style="cursor:pointer">
        <div align="center" class="tituloTabla">CONSULTAS SQL</div>
      </div>
      <%if adminBoss then%>
      <div align="center" style="margin-bottom:10px;">Seleccionar Empresa:<br/>
        <select name="laempre">
          <option value="0">Todas</option>
          <option value="-1">Base Central</option>
          <%if hayempre then
				for e=0 to ubound(RegEmpre,2)
					marca=""
					if RegEmpre(EmCodi,e)=paClng(laempre) then marca=" selected"%>
          <option value="<%=RegEmpre(EmCodi,e)%>"<%=marca%>><%=RegEmpre(EmNombre,e)%></option>
          <%next
			end if%>
        </select>
      </div>
      <div align="center" style="margin-bottom:10px;"> 
        <textarea name="consulta" cols="80" rows="15"></textarea>
      </div>
      <div align="center"> 
        <input type="submit" value="Enviar consulta" class="boton145">
      </div>
      <%end if%>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>