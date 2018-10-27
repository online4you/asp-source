<!--#include file="includes/claseUpload.asp"-->
<%

Set objUpload = new clsUpload
if objUpload.Loaded then 'cargado correctamente
	
	'recoge los form input directamente con el name del input
	textoAlt=objUpload.getForm("textoAlt")
	'se puede recorrer la coleccion de inputs
	for each Campo in objUpload.forms
		response.write Campo.name & "= " & Campo.value & "<br>" 'propiedades name y value
	next

	'nombre fichero puesto en el input tipo file directamente con el name del input
	Nombrefichero=objUpload.getFile("adjunto")
	'se puede recorrer la coleccion de inputs file
	for each Fichero in objUpload.files
		response.write Fichero.Path & " - " 'ruta completa en el disco
		response.write Fichero.FileName & " - " 'nombre del fichero
		response.write Fichero.Size & "<br>" 'tamaño
		'se pueden usar todas las propiedades y metodos del objeto file de Persits Upload
		'http://www.aspupload.com/object_file.html
		
		'graba el objeto file en el disco, se indica el nombre y la ruta del disco
		guena=objUpload.saveAs(Fichero,"d:\aplicaciones\crs\fotos\micasa.jpg") 'devuelve true o false
		
		'redimensiona una foto indicando el prefijo, ancho y alto. Se pone la ruta del disco
		guena=objUpload.ReSizeImg(Fichero.Path,"Th_",120,0) 'ajusta a 120 px de ancho
		guena=objUpload.ReSizeImg(Fichero.Path,"Ficha_",0,200) 'ajusta a 200 px de alto
		guena=objUpload.ReSizeImg(Fichero.Path,"",700,200) 'ajusta a 700 px de ancho la foto original (no hay prefijo), no tiene en cuenta el 200 de alto, el ancho tiene preferencia.
		
	next
	
	'Graba todos los objetos file en una carpeta, se puede poner ruta web o ruta del disco
	'los guarda en la carpeta pero no cambia el nombre del fichero
	'no hace falta recorrer la coleccion de files
	guena=objUpload.saveFiles("/fotos") 'devuelve true o false
	
	'saveFilesRename(thePathDisk,overWrite,Prefix,Sufix,Width,Height)
	'renombra todos los objetos files con prefijo y sufijo, se guardan en la carpeta indicada (puede ser ruta de disco).
	'Opcion de NO sobreescribir el fichero
	'si se pone ancho o alto, redimensiorá si es una imagen.
	guena=objUpload.saveFilesRename("/fotos",true,"Th_","_23",120,0)
	guena=objUpload.saveFilesRename("/fotos",true,"Ficha_","_23",420,0)
	guena=objUpload.saveFilesRename("/fotos",true,"","_23",700,0)
	

end if 'loaded
set objUpload=nothing

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Clase Upload</title>
</head>
<body>
<form name="f1" method="post" enctype="multipart/form-data">
Seccion: <input type="text" name="Seccion"><br>
Texto Alt: <input type="text" name="textoAlt"><br>
Adjunto: <input type="file" name="adjunto"><br>
Foto: <input type="file" name="foto"><br>
<br />
<input type="submit" value="enviar" />
</form>
</body>
</html>
