<%
class clsUpload
	private formUpload 'object
	dim Loaded
	dim forms,files
	
	Private Sub Class_Initialize()
		Loaded=false 'default
		on error resume next
		Set formUpload = Server.CreateObject("Persits.Upload.1")
		formUpload.save 'load in memory
		set forms=formUpload.form 'colection forms
		set files=formUpload.files 'colection files
		if err.number=0 then Loaded=true
		on error goto 0
		Path=""
    End Sub 'Class_Initialize
	'-----------------------------------------------------------------------------------------------------------
	   
    Private Sub Class_Terminate()
    	Set formUpload = Nothing
    End Sub 'Class_Terminate
	'-----------------------------------------------------------------------------------------------------------
	
	'Function to search value from a form input
	public Function getForm(eti)
		getForm=formUpLoad.form(eti)
	end function 'getForm
	'---------------------------------------------------------------------------------------------

	'Function to search name from a form file
	public Function getFile(eti)
		getFile=""
		Set File = formUpload.Files(eti)
		If Not File Is Nothing Then
		   getFile=File.FileName
		End If 
	end function 'getFile
	'---------------------------------------------------------------------------------------------
	
	'save one file into disk (object file)
	public Function saveAs(ItemFile,FileName)
		saveAs=false
		on error resume next
		ItemFile.SaveAs transformaURL(FileName)
		if err.number=0 then saveAs=true
		on error goto 0
	end Function
	'----------------------------------------------------------------------------------------
	
	'save all the files into disk
	public Function saveFiles(thePathDisk)
		saveFiles=false
		'verify path web
		on error resume next
		pathResult=server.MapPath(thePathDisk)
		if err.number<>0 then pathResult=thePathDisk 'is path disk
		err.clear
		if right(trim(pathResult),1)<>"\" then pathResult=pathResult & "\"
		For Each File in formUpload.Files
			File.SaveAs pathResult & transformaURL(File.FileName)
		next
		if err.number=0 then saveFiles=true
		on error goto 0
	end Function
	'----------------------------------------------------------------------------------------

	'save all the files into disk with parameters overWrite,Prefix,Sufix
	public Function saveFilesRename(thePathDisk,overWrite,Prefix,Sufix,Width,Height)
		saveFilesRename=false
		'verify path web
		on error resume next
		pathResult=server.MapPath(thePathDisk)
		if err.number<>0 then pathResult=thePathDisk 'is path disk, not path web
		err.clear
		if right(trim(pathResult),1)<>"\" then pathResult=pathResult & "\"
		For Each File in formUpload.Files
			theFile=Prefix & replace(File.OriginalFileName,File.Ext,"") & Sufix & File.Ext 'add prefix and sufix
			theFile=transformaURL(theFile)
			if not overWrite then 'verify file, not overWrite
				If not Upload.FileExists(pathResult & theFile) Then
					File.SaveAs pathResult & theFile
				end if 'not exist
			else 'overWrite
				File.SaveAs pathResult & theFile
			end if 'overWrite
			if Width<>0 or Height<>0 then 'resize image
				guena=ReSizeImg(pathResult & theFile,"",Width,Height)
			end if 'resize image
		next
		if err.number=0 then saveFilesRename=true
		on error goto 0
	end Function
	'----------------------------------------------------------------------------------------

	'resize de file IMG Original with Prefix and proportional Width or Height
	public Function ReSizeImg(Original,Prefix,Width,Height)
		ReSizeImg=false
		tipoimg=-1
		if ucase(laExtension(original))="JPG" or ucase(laExtension(original))="JPEG" then
			tipoimg=1
		end if
		if ucase(laExtension(original))="PNG" then
			tipoimg=0
		end if
		if tipoimg>-1 then 'valid format
			Set im = CreateObject("ActiveImage.Images.1")
			im.SetImageType tipoimg 'jpg o png
			im.ReadFromFile original
			alto_ori = im.GetHeight
			ancho_ori = im.GetWidth
			
			ratio=ancho_ori/alto_ori 'proporcion de la foto original
			ancho_new=width
			alto_new=height
			if width<>0 then 'mantener ancho
				alto_new=(ancho_new/ratio) 'para que la foto mantenga la proporcion
			else 'mantener el alto
				ancho_new=(alto_new*ratio) 'para que la foto mantenga la proporcion
			end if 'proporcion
			im.SetImage 1
			im.CreateImage cint(ancho_new),cint(alto_new)
			im.CopyImageResize 1,0,0,0,0,0,cint(ancho_new),cint(alto_new),ancho_ori,alto_ori
			laFoto=SoloElFichero(Original)
			myPath=replace(Original,laFoto,"") 'quita el nombre fichero
			im.WriteToFile myPath & Prefix & laFoto
			im.DestroyImage 'destruye la copia

			im.SetImage 0
			im.DestroyImage 'destruye la original
			
			set im=nothing
			ReSizeImg=true
		end if 'tipoimg		
		
	end function 'ReSizeImg
	'------------------------------------------------

end class 'clsUpload

'Funciones utilizadas
'Funcion para sacar el nombre del fichero a una ruta entera
Function SoloElFichero(Todo)
	dim p,ult
	ult=0
	p=instr(1,todo,"\") 'La primera \
	do while p<>0
		ult=p
		p=instr(p+1,todo,"\")
	loop
	if ult<>0 then
		SoloElFichero=mid(todo,ult+1)
	else
		SoloElFichero=Todo
	end if
End Function


function laExtension(mifichero)
	laExtension=""
	'Buscar extension
	if trim(mifichero)<>"" then
		ficheExt=Split(mifichero,".")
		if ubound(ficheExt)>=0 then laExtension=ficheExt(ubound(ficheExt))
	end if
end function

function esGrafico(elFiche) 'true en caso de ser un fichero grafico
	esGrafico=false
	select case lcase(laExtension(elFiche))
		case "gif","png","jpg","jpeg","bmp"
			esGrafico=true
	end select
end function

Function transformaURL(laURL)
	laURL=lcase(laURL) 'paso a minusculas
	Dim regEx
	Set regEx=New RegExp ' Crea una expresión regular. 
	regEx.Global=true   
	regEx.Pattern="[áâàä]" 'Establece el modelo.    
	resultado=regEx.Replace(laURL,"a") 'Realiza el reemplazo
	regEx.Pattern="[éêèë]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"e") 'Realiza el reemplazo
	regEx.Pattern="[íïìî]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"i") 'Realiza el reemplazo
	regEx.Pattern="[óöòô]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"o") 'Realiza el reemplazo
	regEx.Pattern="[úüùû]" 'Establece el modelo.    
	resultado=regEx.Replace(resultado,"u") 'Realiza el reemplazo
	regEx.Pattern="[ñ]"
	resultado=regEx.Replace(resultado,"n") 'Realiza el reemplazo
	regEx.Pattern="[ç]"
	resultado=regEx.Replace(resultado,"c") 'Realiza el reemplazo
	regEx.Pattern="[ß]"
	resultado=regEx.Replace(resultado,"b") 'Realiza el reemplazo
	regEx.Pattern="[\s|""|'|´|&|?|¿|@|*|%|$|+|!|¡|º|ª|\|(|)]"
	resultado=regEx.Replace(resultado,"_") 'Realiza el reemplazo
	set regEx = nothing
	transformaURL=resultado
End Function


%>