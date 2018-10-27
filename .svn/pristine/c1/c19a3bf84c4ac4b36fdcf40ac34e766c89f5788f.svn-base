<!--#include file="includes/FunGestion.asp"-->
<%
Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.SaveToMemory

ruta=server.mappath(rutafotos)
id=Upload.form("id")
ver=Upload.form("ver")
queborro=Upload.form("quitar")
maxfoto=2
if ver="fh" then maxfoto=6
Path = ruta & "\"
cadena=""
for nfoto=1 to maxfoto
	Set File = Upload.Files("foto" & nfoto)
	filefoto=false
	If Not File Is Nothing Then
		afoto=SoloElFichero(file.Path)
		'file.saveAs(path & afoto)
		'filefoto=true

		if UBound(Split(afoto, ".", -1, 1))=0 then Ext=""
		if UBound(Split(afoto, ".", -1, 1))>0 then Ext="." & Split(afoto, ".", -1, 1)(1)
		select case ver
			case "sh" 'Situacion
				nuevo="H" & id & "Situ_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Situ_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Situ_foto" & nfoto & Ext
			case "seh" 'Servicios
				nuevo="H" & id & "Servi_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Servi_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Servi_foto" & nfoto & Ext
			case "pre" 'Presentacion
				nuevo="H" & id & "Presen_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Presen_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Presen_foto" & nfoto & Ext
			case "hah" 'Habitaciones
				nuevo="H" & id & "Habi_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Habi_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Habi_foto" & nfoto & Ext
			case "enh" 'Entorno
				nuevo="H" & id & "Entorno_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Entorno_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Entorno_foto" & nfoto & Ext
			case "fh" 'Galeria
				nuevo="H" & id & "Gale_foto" & nfoto & Ext
				nuevo_ficha="Ficha_H" & id & "Gale_foto" & nfoto & Ext
				nuevo_th="Th_H" & id & "Gale_foto" & nfoto & Ext
		end select				

		file.saveAs(path & nuevo)
		filefoto=true
		
		'Crear las fotos pequeñas
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		Jpeg.Open Path & nuevo

		' Cambiar tamaño
		if Jpeg.OriginalWidth>fotoancho then
			Jpeg.Width = fotoancho 'Ancho foto grande
			Jpeg.Height = Jpeg.OriginalHeight * fotoancho / Jpeg.OriginalWidth 'Mantenie el ratio
		end if
		'grabar en el disco
		Jpeg.Save Path & nuevo
		
		' Cambiar tamaño
		if Jpeg.OriginalWidth>th_ficha then
			Jpeg.Width = th_ficha 'Ancho de la ficha
			Jpeg.Height = Jpeg.OriginalHeight * th_ficha / Jpeg.OriginalWidth 'Mantenie el ratio
		end if
		' grabar en disco
		Jpeg.Save Path & nuevo_ficha

		' Cambiar tamaño
		if Jpeg.OriginalWidth>th_galeria then
			Jpeg.Width = th_galeria 'Ancho en la galeria
			Jpeg.Height = Jpeg.OriginalHeight * th_galeria / Jpeg.OriginalWidth 'Mantenie el ratio
		end if
		'grabar en el disco
		Jpeg.Save Path & nuevo_th

		set Jpeg=nothing
		
		cadena=cadena & "foto" & nfoto & "='" & nuevo & "',"
	end if 'no es fichero
next

set upload=nothing

set base=server.createobject("ADODB.Connection")
base.Open Conecta

'Comprobar si hay valor para borrar
dim lafoto(6)
'queborro=Upload.form("quitar")
if queborro<>"" then 'Quitar lo que sea
	select case ver
		case "sh"'Situacion
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Situ_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Situ_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Situ_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Situ_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Situ_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Situ_" & queborro & ".gif"
			
			cs="UPDATE SituacionHotel SET " & queborro & "='' "

		case "pre"'Presentacion
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Presen_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Presen_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Presen_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Presen_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Presen_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Presen_" & queborro & ".gif"
			
			cs="UPDATE PresentacionHotel SET " & queborro & "='' "

		case "hah"'Habitaciones
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Habi_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Habi_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Habi_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Habi_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Habi_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Habi_" & queborro & ".gif"
			
			cs="UPDATE HabitacionesHotel SET " & queborro & "='' "

		case "enh"'Entorno
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Entorno_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Entorno_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Entorno_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Entorno_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Entorno_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Entorno_" & queborro & ".gif"
			
			cs="UPDATE EntornoHotel SET " & queborro & "='' "
			
		case "seh" 'Servicios
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Servi_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Servi_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Servi_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Servi_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Servi_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Servi_" & queborro & ".gif"
			
			cs="UPDATE ServiciosHotel SET " & queborro & "='' "
		case "fh"'Situacion
			'Nombre de la foto del servidor
			lafoto(1)="H" & id & "Gale_" & queborro & ".jpg"
			lafoto(2)="Ficha_H" & id & "Gale_" & queborro & ".jpg"
			lafoto(3)="Th_H" & id & "Gale_" & queborro & ".jpg"
			lafoto(4)="H" & id & "Gale_" & queborro & ".gif"
			lafoto(5)="Ficha_H" & id & "Gale_" & queborro & ".gif"
			lafoto(6)="Th_H" & id & "Gale_" & queborro & ".gif"
		
			cs="UPDATE FotosHotel SET " & queborro & "='' "
	end select
	cs=cs & "WHERE CodigoEsta=" & id 
	base.execute cs
	
	'Borrar la foto
	Set Fs = Server.CreateObject("Scripting.FileSystemObject")
	for f=1 to 6
		if Fs.FileExists(Path & lafoto(f))  then
			'borrar
			Call Fs.DeleteFile(Path & lafoto(f), True)
		end if
	next
	Set Fs = Nothing	
	
end if

'Actualizar en la tabla
if cadena<>"" then
	if right(cadena,1)="," then 'Quitar el ultimo operador
		cadena=left(cadena,len(cadena)-1)
	end if	
	select case ver
		case "pre"'Presentacion
			cs="UPDATE PresentacionHotel SET " & cadena
		case "enh"'Entorno
			cs="UPDATE EntornoHotel SET " & cadena
		case "sh"'Situacion
			cs="UPDATE SituacionHotel SET " & cadena
		case "hah"'Habitaciones
			cs="UPDATE HabitacionesHotel SET " & cadena
		case "seh" 'Servicios
			cs="UPDATE ServiciosHotel SET " & cadena
		case "fh"'Situacion
			cs="UPDATE FotosHotel SET " & cadena
	end select
	cs=cs & " WHERE CodigoEsta=" & id
	base.execute cs
end if

base.close
set base=nothing
'server.Transfer("Fotos.asp?idf=" & id)
response.Redirect "FotosHotel.asp?idf=" & id & "&ver=" & ver
%>