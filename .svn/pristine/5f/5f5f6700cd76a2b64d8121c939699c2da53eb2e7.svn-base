<%
adOpenForwardOnly=0
adLockReadOnly=1
adUseClient=3
adUseServer=2
'Const ConectaMDB = "provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=D:\XVRT\planetaweb.es\data\EmpresasReservas.mdb"
ConectaCR= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=qcu151;pwd=Planeta2007;Initial Catalog=qcu151;Data Source=lwda241.servidoresdns.net"

set base=server.createobject("ADODB.Connection")
base.Open ConectaCR
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
	ide=clng("0" & request.QueryString("ide"))

	response.cookies("okCR")="no"
	response.Cookies("adminBoss")=""
	if user<>"" and pass<>"" then
		cs="SELECT Usuarios.Id,Empresas.Id as IdEmp,Empresas.Nombre as Empresa,ConexionBD,UserBD,PwdBD,HojaEstilos,"
		cs=cs & "MetaTitulo,Modulos,RutaFotos,RutaDocu,MySQL "
		cs=cs & "FROM Usuarios LEFT JOIN Empresas "
		cs=cs & "ON Usuarios.IdEmpresa=Empresas.Id "
		cs=cs & "WHERE Usuario='" & user & "' AND Clave='" & pass & "' AND Activo<>0 AND IdEmpresa=" & ide
		'response.write(cs & "<br/>")
		rs.open cs,base
		if not rs.eof then
			'Solo pa un dia
			response.Cookies("userCR")=user
			response.Cookies("pwdCR")=pass
			response.Cookies("okCR")="si"
			response.Cookies("conexBD")="" & rs("ConexionBD")
			response.Cookies("mysqlBD")="" & rs("MySQL")
			response.Cookies("userBD")="" & rs("userBD")
			response.Cookies("pwdBD")="" & rs("PwdBD")
			response.Cookies("modulosCR")="" & rs("Modulos")
			if isnull(rs("hojaestilos")) then
				response.Cookies("hojaEstilos")=""
			else
				response.Cookies("hojaEstilos")="" & rs("hojaEstilos")
			end if
			if isnull(rs("metatitulo")) then
				response.Cookies("MetaTitulo")="Planeta Web, central de reservas"
			else
				response.Cookies("MetaTitulo")="" & rs("MetaTitulo")
			end if
			response.Cookies("Empresa")="" & rs("Empresa")
			response.Cookies("IdEmpresa")="" & rs("IdEmp")
			adminBoss=false
			if clng("0" & rs("IdEmp"))=0 then adminBoss=true
			response.Cookies("adminBoss")=adminBoss
			response.Cookies("hotelboss")=""
			idusu=rs("Id")
			response.Cookies("IDCR")=idusu 'pa los permisos
			rs.close
	
			cs = "SELECT CodigoEsta FROM PermisosPorEsta "
			cs=cs & "WHERE IdUsuario=" & idusu
			rs.Open cs,base
			'Cargar los hoyteles que tiene, el adminst. no tiene hoteles espec.
			listaH=""
			do while not rs.eof
				listaH=listaH & rs("CodigoEsta") & ";"
				rs.MoveNext
			loop
			if not rs.eof then 'qiutar el ;
				listaH=left(listaH,len(listaH)-1)
			end if
			if adminBoss then listaH=""
			response.Cookies("hotelboss")=listaH
			rs.close
			
			if request.Cookies("hotelboss")<>"" then
				response.Redirect("cr.asp")
			else
				response.Redirect("inicio.asp")
			end if

			
		else
			rs.close
			response.write "Nombre de usuario o contraseña no válidos"
		end if
	
	end if 'user<>"" and pass<>""
	'response.write request.Cookies("okCr") & "<br>"
	'response.End()

end if 'form<>""

set rs=nothing
base.close
set base=nothing
%>