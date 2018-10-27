<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'ht=request.Querystring("ht")
'pro=request.QueryString("pro")
cnt=request.querystring("cnt")
modo=request.Querystring("modo")
'recojo datos del form de contactos y establecimientos
nombre=QuitarApos(request.form("nombre"))
apellidos=QuitarApos(request.form("apellidos"))
cargo=QuitarApos(request.form("cargo"))
idpro=request.form("cadena")
idest=request.form("hotel")

select case modo
	case "borra" ' borrar marcados
		queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "contactos WHERE "
				cs1="DELETE FROM " & precrs & "numeros WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
						cs1=cs1 & "Idcont=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				if right(cs1,4)=" OR " then 'Quitar el ultimo operador
					cs1=left(cs1,len(cs1)-4)
				end if	
				base.execute cs
				base.execute cs1
			end if
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest 
	case "actu" 'actualizar contacto
			
			'Actualiza Nombres
			cs="UPDATE " & precrs & "contactos SET "
			cs=cs & "nombre='" & nombre & "',"
			cs=cs & "apellidos='" & apellidos & "',"
			cs=cs & "cargo='" & cargo & "',"
			cs=cs & "idpro=" & clng(idpro) & ","
			cs=cs & "idest=" & clng(idest) & " "
			cs=cs & "WHERE Id=" & clng(cnt)
			base.execute cs
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest 
			
	case "nuevo" 'modificar datos de contacto
			nombre=QuitarApos(request.form("nombre"))
			apellidos=QuitarApos(request.form("apellidos"))
			cargo=QuitarApos(request.form("cargo"))
			idpro=request.form("cadena")
			idest=request.form("hotel")
			
			'Añadir
			cs="INSERT INTO " & precrs & "contactos (nombre,apellidos,cargo,idpro,idest)"

			cs=cs & " VALUES ('" & nombre & "','" & apellidos & "','" & cargo & "'," & clng(idpro) & ","
			cs=cs & clng(idest) & ")"
			base.execute cs
			response.write cs
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest 
end select
response.write cs
%>