<%
if request.form<>"" then 'Actualizar
	'valores form
	ancho=paClng(request.form("ancho"))
	alto=paClng(request.form("alto"))
	prefijo=quitarApos(request.form("prefijo"))
	pancho=paClng(request.form("pancho"))
	palto=paClng(request.form("palto"))

	modo=request.QueryString("modo")
	select case modo 
		case "nuevo" 'Añadir
			'Añadir
			cs="INSERT INTO " & precrsgen & "sizegraficos (IdEmpresa,Ancho,Alto,Prefijo,ProporcionAncho,ProporcionAlto) VALUES ("
			cs=cs & ide & "," & ancho & "," & alto & ",'" & prefijo & "'," & pancho & "," & palto & ")"
			base.execute cs
			
		case "actu"
			MiId=request.form("id")
			
			'Actualiza 
			cs="UPDATE " & precrsgen & "sizegraficos SET "
			cs=cs & "Ancho=" & ancho & ","
			cs=cs & "Alto=" & alto & ","
			cs=cs & "Prefijo='" & prefijo & "',"
			cs=cs & "ProporcionAncho=" & pancho & ","
			cs=cs & "ProporcionAlto=" & palto & " "
			cs=cs & "WHERE Id=" & MiId
			base.execute cs
		
	end select
	pasalir=1
end if 'form<>""
%>