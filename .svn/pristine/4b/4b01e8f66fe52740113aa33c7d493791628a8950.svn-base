<%
if request.form<>"" then 'Actualizar
est=request.QueryString("est")

	modo=request.QueryString("modo")
	MiId=request.querystring("id")
	'response.write MiId	& "--><br>"		
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "proveedores WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
			end if
			
		case "nuevo" 'Añadir
			nombre=QuitarApos(request.form("nombre"))
			direccion=QuitarApos(request.form("direccion"))
			cp=request.form("cp")
			nomfiscal=QuitarApos(request.form("nomfiscal"))
			dirfiscal=QuitarApos(request.form("dirfiscal"))
			cpfiscal=request.form("cpfiscal")
			cif=request.form("cif")
			web=request.form("web")
			comision=request.form("comision")
			prepago=request.form("prepago")
			localidad=QuitarApos(request.form("loc"))
			'Añadir
			cs="INSERT INTO " & precrs & "Proveedores (nombre,direccion,cp,nomfiscal,dirfiscal,cpfiscal,cif,"
			cs=cs & "webcadena,localidad,Comision,Prepago)"

			cs=cs & " VALUES ('" & nombre & "','" & direccion & "','" & cp & "','" & nomfiscal & "','"
			cs=cs & dirfiscal & "','" & cpfiscal & "','" & cif & "','" & web & "','"
			cs=cs & localidad & "'," & quitarComa(comision) & "," & quitarComa(prepago) & ")"
			'response.write cs
			base.execute cs
			Response.Redirect(mipag) 		
		case "actu"
			nombre=QuitarApos(request.form("nombre"))
			direccion=QuitarApos(request.form("direccion"))
			cp=request.form("cp")
			nomfiscal=QuitarApos(request.form("nomfiscal"))
			dirfiscal=QuitarApos(request.form("dirfiscal"))
			cpfiscal=request.form("cpfiscal")
			cif=request.form("cif")
			web=request.form("web")
			comision=request.form("comision")
			prepago=request.form("prepago")
			localidad=QuitarApos(request.form("loc"))
			'Actualiza Nombres
			cs="UPDATE " & precrs & "Proveedores SET "
			cs=cs & "nombre='" & nombre & "',"
			cs=cs & "direccion='" & direccion & "',"
			cs=cs & "cp='" & cp & "',"
			cs=cs & "nomfiscal='" & nomfiscal & "',"
			cs=cs & "dirfiscal='" & dirfiscal & "',"
			cs=cs & "cpfiscal='" & cpfiscal & "',"
			cs=cs & "cif='" & cif & "',"
			cs=cs & "webcadena='" & web & "',"
			cs=cs & "Comision=" & quitarComa(comision) & ","
			cs=cs & "Prepago=" & quitarComa(prepago) & ","
			cs=cs & "localidad='" & localidad & "' "
			cs=cs & "WHERE Id=" & MiId
			response.write cs
			base.execute cs
			Response.Redirect(mipag)
	end select

	pasalir=1

end if

%>