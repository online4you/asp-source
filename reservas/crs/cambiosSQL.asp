<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

cs="SELECT Id,Nombre FROM " & precrsgen & "Empresas ORDER BY Nombre"
rs.open cs,base
hayempre=false
if not rs.eof then
	RegEmpre=rs.getrows
	EmCodi=0
	EmNombre=1
	hayempre=true
end if
rs.close

laempre=clng("0" & request.Form("laempre"))
dim lidioma(5)
lidioma(1)="es"
lidioma(2)="it"
lidioma(3)="en"
lidioma(4)="de"
lidioma(5)="fr"

	cs="SELECT ConexionBD, userBD, PwdBD FROM " & precrsgen & "Empresas "
	if laempre<>0 then
		cs = cs & "WHERE Id= " & laempre
	end if
	rs.open cs,base
	if not rs.eof then
		RgEmpre=rs.getrows
		conexBD=0
		userBD=1
		pwdBD=2
	end if
	rs.close
	
	for e=0 to ubound(RgEmpre,2)
		Conecta = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=" & RgEmpre(userBD,e) & ";pwd=" & RgEmpre(pwdBD,e) & ";Initial Catalog=" & RgEmpre(userBD,e) & ";Data Source=" & RgEmpre(conexBD,e)
		response.write conecta & "<br>"
		set basecs = server.createobject("ADODB.Connection")
		basecs.open Conecta
		
		for i=1 to 5 'idiomas
			cs="SELECT ColectivoIdi,Nombre FROM " & precrs & "ColectivosNomres WHERE Idioma='" & lidioma(i) & "'"
			rs.open cs,basecs
			do while not rs.eof 
				cs="UPDATE " & precrs & "Colectivos SET Nombre_" & lidioma(i) & "='" & rs("nombre") & "' "
				cs=cs & "WHERE CodigoColec=" & rs("ColectivoIdi")
				basecs.execute cs
				
				rs.movenext
			loop
			rs.close
			
		next
		
		
		'basecs.execute cssql
		basecs.close
		set basecs = nothing
	next


set rs = nothing
base.close
set base = nothing

%>

<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<body style="background-image:none;">

<form action="<%=MiPag%>" method="post" name="f1">

<div style="margin:20px;"><input type='button' class="boton145" value='Menu Anterior' onclick="javascript:window.location='index.asp';" style="cursor:pointer">
<div align="center" class="tituloTabla">CONSULTAS SQL</div>
</div>
<%if adminBoss then%>
<div align="center" style="margin-bottom:10px;">Seleccionar Empresa:<br/>
	<select name="laempre">
		<option value="0">Todas</option>
		<%if hayempre then
			for e=0 to ubound(RegEmpre,2)
				marca=""
				if RegEmpre(EmCodi,e)=clng("0" & laempre) then marca=" selected"%>
					<option value="<%=RegEmpre(EmCodi,e)%>"<%=marca%>><%=RegEmpre(EmNombre,e)%></option>
			<%next
		end if%>
	</select>
</div>
<div align="center" style="margin-bottom:10px;"><textarea name="consulta" cols="80" rows="15"></textarea></div>
<div align="center"><input type="submit" value="Enviar consulta" class="boton145"></div>
<%end if%>

</form>

</body>
</html>