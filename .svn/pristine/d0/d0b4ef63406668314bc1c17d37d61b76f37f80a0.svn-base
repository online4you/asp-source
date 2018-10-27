<!--#include file="../../../includes/FunGestion.asp"-->
<%
rfotos=rutafotos
ruta=server.mappath(rfotos) & "\"

Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.SaveToMemory
alto=paClng(Upload.Form("alto"))
ancho=paClng(Upload.Form("ancho"))
Set File = Upload.Files("foto1")
If Not File Is Nothing Then
	FDatos=File.Path
	'response.write file.path
	FDatos=soloElFichero(FDatos)
	'response.write FDatos 
	'response.End()
	'response.write ruta & FDatos
	file.saveAs(ruta & FDatos)
	'Upload.save(path & FDatos)

	if ancho<>0 or alto<>0 then 'Cambiar los tamaños
		'Crear las fotos pequeñas
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		Jpeg.Open ruta & FDatos
		' Cambiar tamaño
		if Jpeg.OriginalWidth>ancho and ancho<>0 then 'primero el ancho
			Jpeg.Width = ancho 'Ancho en la galeria
			Jpeg.Height = Jpeg.OriginalHeight * ancho / Jpeg.OriginalWidth 'Mantenie el ratio
		end if
		'grabar en el disco
		Jpeg.Save ruta & FDatos
		
		' Cambiar tamaño
		if Jpeg.OriginalHeight>alto and alto<>0 then 'comprobar el alto
			Jpeg.Height = alto 'Ancho de la ficha
			Jpeg.Width = Jpeg.OriginalWidth * alto / Jpeg.OriginalHeight 'Mantenie el ratio
		end if
		' grabar en disco
		Jpeg.Save ruta & FDatos

		set Jpeg=nothing
	end if 'cambio tamaño
	
end if
set file=nothing

set upload=nothing

response.Redirect "CargaImg.asp?img=" & FDatos
%>