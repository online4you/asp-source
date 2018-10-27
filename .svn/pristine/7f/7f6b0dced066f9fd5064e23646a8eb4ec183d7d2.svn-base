<!--#include virtual="/includes/FunGestion.asp"-->
<%
msgerror=""
Set Up = Server.CreateObject("aspSmartUpload.SmartUpload")  
Up.Upload  
	
ancho=paClng(up.form("up_ancho"))
alto=paClng(up.form("up_alto"))
carpeta=up.form("up_carpeta")
archivo=up.form("up_archivo")

if not up.Files.Item("file_archivo").IsMissing Then
	on error resume next
	up.files.item("file_archivo").SaveAs(carpeta & archivo)  
	if err.number<>0 then msgerror=err.description
	on error goto 0
	
	if alto<>0 or ancho<>0 then 'redimensionar
	
		original=server.MapPath(carpeta & archivo)
		tipoimg=-1
		if ucase(laExtension(original))="JPG" or ucase(laExtension(original))="JPEG" then
			tipoimg=1
		end if
		if ucase(laExtension(original))="PNG" then
			tipoimg=0
		end if
		if tipoimg>-1 then 'formato válido
			Set im = CreateObject("ActiveImage.Images.1")
			im.SetImageType tipoimg 'jpg o png
			im.ReadFromFile original
			alto_ori = im.GetHeight
			ancho_ori = im.GetWidth
			
			ratio=ancho_ori/alto_ori 'proporcion de la foto original
			if ancho<>0 then 'mantener el ancho
				ancho_new=ancho
				alto_new=(ancho_new/ratio) 'para que la foto mantenga la proporcion
			else 'mantener el alto
				alto_new=alto
				ancho_new=(alto_new*ratio) 'para que la foto mantenga la proporcion
			end if 'proporcion
			im.SetImage 1
			im.CreateImage cint(ancho_new),cint(alto_new)
			im.CopyImageResize 1,0,0,0,0,0,cint(ancho_new),cint(alto_new),ancho_ori,alto_ori
			
			im.WriteToFile server.MapPath(carpeta & archivo)
			im.DestroyImage 'destruye la copia

			im.SetImage 0
			im.DestroyImage 'destruye la original
			
			set im=nothing
		end if 'tipoimg		
	
	end if 'alto<>0, ancho<>0

else
 'no hay fichero
 msgError="No se incluido ningun fichero"	
end if
%>
<script language="javascript" type="text/javascript">
<%if msgerror="" then %>
	/*parent.document.getElementById("up_archivo").value="";
	parent.document.getElementById("file_archivo").value="";
	parent.document.getElementById("up_ancho").value="0";
	parent.document.getElementById("up_alto").value="0";
	parent.document.getElementById("espera").style.display='none';*/
	alert("Fichero subido correctamente");
	parent.window.location=parent.window.location;
<%else %>
	alert("<%=msgError%>");
<%end if%>
</script>