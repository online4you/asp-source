<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

cnt=request.querystring("cnt")

'para actualizar
cs="SELECT id FROM " & precrs & "numeros WHERE idcont='" & cnt &"';"
rs.open cs,base
hayn=false
if not rs.eof then
	NewEdDatos=rs.getrows
	Ndato=0
	hayn=true
end if
'response.write cs & " esto es la consulta   " & hayn & "---" & ubound(NewEdDatos,2) & "<br>"
rs.close

id=request.querystring("IdN")
modo=request.Querystring("modo")
'response.write modo & "-----" & request.form("NewEdborrar")
'recojo datos del form de contactos y establecimientos
numero=QuitarApos(request.form("NewEdnum"))
tipo=request.form("NewEdtipo")
idpro=request.form("cadena")
idest=request.form("hotel")

select case modo
	case "borra" ' borrar marcados
		queborro=split(request.form("NewEdborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "numeros WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro (t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if
				base.execute cs
			end if
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest & "&cnt=" & cnt 
	case "actu" 'actualizar numeros
			if hayn then
				for d=0 to ubound(NewEdDatos,2)
				campo="Num" & NewEdDatos(Ndato,d)
				eso=request.form(campo)
					cs="UPDATE " & precrs & "numeros SET "
					cs=cs & "numero='" & eso & "'"
					cs=cs & " WHERE Id=" & NewEdDatos(Ndato,d)
					base.execute cs
					'response.write cs & "---------------------->>" & campo & "<br>"
				next
			end if
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest 
			
	case "nuevo" 'modificar datos de contacto
			'Añadir
			cs="INSERT INTO " & precrs & "numeros (idcont,tipo,numero)"
			cs=cs & " VALUES ('" & cnt & "','" & tipo & "','" & numero & "')"
			base.execute cs
			'response.write cs
			if idpro=0 then idpro=""
			if idest=0 then idest=""
			Response.Redirect "contactos.asp?pro=" & idpro & "&ht=" & idest & "&cnt=" & cnt
end select
set rs=nothing
base.close
set base=nothing
%>