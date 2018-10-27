<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseUpload.asp"-->
<%

set objUpload=new clsUpload
if objUpload.Loaded then 'cargado correctamente
	response.write "Nombre: " & objUpload.getForm("nombre") & "<br>"
	response.write "Apellidos: " & objUpload.getForm("apellidos") & "<br>"
	response.write "Adjunto: " & objUpload.getFile("adjunto") & "<br>"
	
	
	eso=objUpload.saveFiles("D:\Aplicaciones\CRS\fotos") 'sobreescribe
	
	eso=objUpload.saveFilesRename("/fotos",true,"","_eso") 'sobreescribe con sufijo
	
	
	For Each Item in objUpload.Forms
		response.write Item.name & ": " & Item.value & "<br>"
	next
	For Each Item in objUpload.files
		response.write Item.name & ": " & Item.Path & " - " & Item.Size & "<br>"
		eso=objUpload.saveAs(Item,server.MapPath("/fotos") & "\pescao.jpg")
		eso=objUpload.ReSizeImg(Item.Path,"Th_",100,0)
	next

end if 'loaded
set objUpload=nothing


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<div>
	<div id='centro'>
    <form name="f1" method="post" enctype="multipart/form-data">
		Nombre: <input type="text" name="nombre"><br>
        Apellidos: <input type="text" name="apellidos"><br>
        Fichero: <input type="file" name="adjunto"><br>
        <br>
        <input type="submit" value="Enviar">
    </form>
	</div>
</div>
</body>
</html>