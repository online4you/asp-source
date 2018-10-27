<!--#include file="includes/claseUpload.asp"-->
<%
modo=request.QueryString("modo")
if modo<>"" then 'hay que actualizar
	
	set baseCR=server.createobject("ADODB.Connection")
	baseCR.Open ConectaMDB

	'Comprobar si tienen diferentes tamaños de fotos
	cs="SELECT Ancho,Alto,Prefijo,ProporcionAncho FROM " & precrsgen & "sizegraficos WHERE IdEmpresa=" & idempresa
	cs=cs & " ORDER BY Ancho DESC"
	rs.open cs,baseCR
	haySize=false
	if not rs.eof then
		RegSize=rs.getrows
		RegAncho=0
		RegAlto=1
		RegPrefi=2
		RegPAncho=3
		haySize=true
	end if
	rs.close
	
	baseCR.close
	set baseCR=nothing
	
	Set objUpload = new clsUpload
	if objUpload.Loaded then 'cargado correctamente

		for each foto in objUpload.files	
			
			idf=paClng(request.QueryString("idf"))
			sufijo="_" & idh
			archivo=replace(foto.OriginalFileName,foto.Ext,"") & sufijo & foto.Ext 'add sufix
			archivo=transformaURL(archivo)
			
			if haySize then 'hay que redimensionar las fotos
				for sz=0 to ubound(RegSize,2)
					guena=objUpload.saveFilesRename(rutafotos,true,RegSize(RegPrefi,sz),Sufijo,RegSize(RegAncho,sz),RegSize(RegAlto,sz))
				next 'sz
			end if 'haySize

			select case modo
				case "nuevo"
					cs="INSERT INTO " & precrs & "FotosHabitacion (IdHabitacion,Foto,Orden) VALUES ("
					cs=cs & laid & ",'" & QuitarApos(archivo) & "',0)"
					base.execute cs
					controlRegistro(cs)
				
				case "actu"
					cs="UPDATE " & precrs & "FotosHabitacion SET Foto='" & QuitarApos(archivo) & "' "
					cs=cs & "WHERE Id=" & idf
					base.execute cs
					controlRegistro(cs)
					
			end select
		
		next 'fotos
		
		
	end if 'loaded
	set objUpload=nothing
	
	pasalir=0 'no sale
end if 'modo

qf=paClng(request.QueryString("qf"))
if qf<>0 then 'hay que quitar la foto
	cs="DELETE FROM " & precrs & "FotosHabitacion WHERE Id=" & qf
	base.execute cs
	controlRegistro(cs)
	
end if

%>