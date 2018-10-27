<%
modo=request.QueryString("modo")
if modo<>"" then 'hay que actualizar
	Set Up = Server.CreateObject("aspSmartUpload.SmartUpload")  
	Up.Upload

	'Valores del form
	'response.write Upload.form("aborrar") & "<br>"
	idf=paClng(request.QueryString("idf")) 'id foto
	ids=paClng(request.QueryString("ids")) 'id referencia
				
	filefoto=false
	If NOT up.Files.Item("foto_" & idf).IsMissing Then
		archivo=up.files.item("foto_" & idf).FileName
		archivo=transformaURL(archivo)
		
		'Añadir la id hotel al nombre de la foto
		sufijo="_" & idf
		archivo=replace(archivo,"." & laExtension(archivo),sufijo & "." & laExtension(archivo))
		
		up.files.item("foto_" & idf).SaveAs(rutafotos & archivo)
		
		filefoto=true
		
	
	end if

	set up=nothing

	select case modo 
			
		case "nuevo" 'Añadir
			cs="INSERT INTO " & precrs & "ServiciosFotos (IdServicio,Foto) VALUES (" & ids & ",'" & archivo & "')"
			'response.Write cs & "<br>"
			base.execute cs
			
		case "actu"
			if filefoto then
				cs="UPDATE " & precrs & "ServiciosFotos SET "
				cs=cs & "Foto='" & archivo & "' "
				cs=cs & "WHERE id=" & Idf
				base.execute cs
			end if
			
	end select
	pasalir=0 'no sale
end if 'modo

qf=paClng(request.QueryString("qf"))
if qf<>0 then 'hay que quitar la foto
	cs="DELETE FROM ServiciosFotos WHERE Id=" & qf
	base.execute cs
	
end if

%>