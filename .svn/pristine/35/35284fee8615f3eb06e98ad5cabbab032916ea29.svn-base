<!--#include file="includes/constantes.asp"-->
<%
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	MiId=request.form("id")
	nombre=QuitarApos(request.form("nombre"))
	conexionBD=QuitarApos(request.form("conexionBD"))
	nombreBD=QuitarApos(request.form("nombreBD"))
	userBD=QuitarApos(request.form("userBD"))
	pwdBD=QuitarApos(request.form("pwdBD"))
	estilos=QuitarApos(request.form("estilos"))
	titulo=QuitarApos(request.form("titulo"))
	rutafotosBD=QuitarApos(request.form("rutafotos"))
	rutadocuBD=QuitarApos(request.form("rutadocu"))
	modulos=" " & request.form("modulos") & ","
	nick=QuitarApos(request.form("nick"))
	pass=QuitarApos(request.form("pass"))
	mysql=paClng(request.form("mysql"))
	smtpserver=request.form("smtpserver")
	remitecuenta=request.form("remitecuenta")
	logincuenta=request.form("logincuenta")
	pwdcuenta=request.form("pwdcuenta")
	creatablas=request.form("creatablas")
	idiomas=request.form("ellang")
	if idiomas<>"" then idiomas=idiomas & ","
	cms=paClng(request.form("cms"))
	googlemaps=paClng(request.form("googlemaps"))
	multitarifa=paClng(request.form("multitarifa"))
	miCharSet=request.form("charset")
	
	select case modo
		case "actu"
			cs="UPDATE " & precrsgen & "empresas SET "
			cs=cs & "Nombre='" & nombre & "',"
			cs=cs & "ConexionBD='" & conexionBD & "',"
			cs=cs & "MySQL=" & mysql & ","
			cs=cs & "nombreBD='" & nombreBD & "',"
			cs=cs & "userBD='" & userBD & "',"
			cs=cs & "pwdBD='" & pwdBD & "',"
			cs=cs & "HojaEstilos='" & estilos & "',"
			cs=cs & "MetaTitulo='" & titulo & "',"
			cs=cs & "RutaFotos='" & rutafotosBD & "',"
			cs=cs & "RutaDocu='" & rutadocuBD & "',"
			cs=cs & "Modulos='" & modulos & "',"
			cs=cs & "Idiomas='" & idiomas & "',"
			cs=cs & "SMTPServer='" & smtpserver & "',"
			cs=cs & "RemiteCuenta='" & remitecuenta & "',"
			cs=cs & "LoginCuenta='" & logincuenta & "',"
			cs=cs & "PWDCuenta='" & pwdcuenta & "',"
			cs=cs & "CMS=" & cms & ","
			cs=cs & "GoogleMaps=" & googlemaps & ","
			cs=cs & "Multitarifa=" & multitarifa & ", "
			cs=cs & "CharSet='" & miCharSet & "' "
			cs=cs & "WHERE Id=" & MiId
			'response.write cs
			base.execute cs
			
		case "nuevo"
			cs="INSERT INTO " & precrsgen & "empresas (Nombre,ConexionBD,NombreBD,UserBD,PwdBD,HojaEstilos,"
			cs=cs & "MetaTitulo,Modulos,Idiomas,RutaFotos,RutaDocu,MySQL,"
			cs=cs & "SMTPServer,RemiteCuenta,LoginCuenta,PWDCuenta,CMS,GoogleMaps,MultiTarifa,CharSet) VALUES ('"
			cs=cs & nombre & "','" & conexionBD & "','" & nombreBD & "','" & userBD & "','" & pwdBD & "','"
			cs=cs & estilos & "','" & titulo & "','" & modulos & "','" & idiomas & "','" & rutafotosBD & "','"
			cs=cs & rutadocuBD & "'," & mysql & ",'" & smtpserver & "','" & remitecuenta & "','"
			cs=cs & logincuenta & "','" & pwdcuenta & "'," & cms & "," & googlemaps & ","
			cs=cs & multitarifa & ",'" & miCharSet & "')"
			base.execute cs
			
			'Buscar el ult. registro para crear el usuario
			cs="SELECT MAX(Id) as Ultimo FROM " & precrsgen & "empresas"
			rs.open cs,base
			if not rs.eof then
				laid=rs("Ultimo")
			end if
			rs.close
			
			cs="INSERT INTO " & precrsgen & "usuarios (Usuario,Clave,Nombre,Nivel,IdEmpresa) VALUES ('"
			cs=cs & nick & "','" & pass & "','" & nombre & "',0," & laid & ")"
			base.execute cs
			
			if creatablas="1" then 'crear las tablas segun .sql
			
				ConectaEso = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=" & userBD & ";pwd=" & pwdBD & ";Initial Catalog=" & nombreBD & ";Data Source=" & conexionBD
				'Cargar fichero .sql
				set FSO = Server.CreateObject("Scripting.FileSystemObject") 
				'Abrir fichero plantilla
				set oFichero = FSO.OpenTextFile(server.MapPath("TablasSQLNueva.sql")) 
				cssql=oFichero.ReadAll  'Paso los datos a una variable
				'Cerrar el fichero
				oFichero.close
				set oFichero=nothing
				set FSO=nothing
				'Ejecutar las todas las instrucciones, estan separadas por ;
				'response.write conectaESO & "<br>"
				set basecs = server.createobject("ADODB.Connection")
				basecs.open ConectaEso
				cs=split(cssql,";") 'las instrucciones están separadas por ;
				if ubound(cs)>=0 then
					for c=0 to ubound(cs)
						cadena=trim(cs(c))
						if cadena<>"" then 'hacer consulta
							basecs.execute cadena
							'response.write cadena & "<br>"
						end if 'cadena<>""
					next 'cs
				end if 'hay cs
				
				'Añadir registros por defecto
				%><!--#include file="registrosNuevaEmpresa.asp"--><%
				basecs.close
				set basecs = nothing

			
			end if 'creatablas
			
	end select
	pasalir=1

end if
%>