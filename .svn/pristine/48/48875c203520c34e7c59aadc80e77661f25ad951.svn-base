<%
modo=request.QueryString("modo")
if modo<>"" then 'hay que actualizar
	
	set baseCR=server.createobject("ADODB.Connection")
	baseCR.Open ConectaMDB

	'Comprobar si tienen diferentes tamaños de fotos
	cs="SELECT Ancho,Alto,Prefijo,ProporcionAncho FROM " & precrsgen & "sizegraficos WHERE IdEmpresa=" & idempresa
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
	
	Set Up = Server.CreateObject("aspSmartUpload.SmartUpload")  
	Up.Upload

	'Valores del form
	'response.write Upload.form("aborrar") & "<br>"
	'idhotel=Upload.Form("id")
	idf=paClng(request.QueryString("idf"))
				
	If NOT up.Files.Item("foto_" & idf).IsMissing Then
		archivo=up.files.item("foto_" & idf).FileName
		archivo=transformaURL(archivo)
		
		'Añadir la id hotel al nombre de la foto
		sufijo="_" & idh
		archivo=replace(archivo,"." & laExtension(archivo),sufijo & "." & laExtension(archivo))
		
		up.files.item("foto_" & idf).SaveAs(rutafotos & archivo)  
		
		select case modo
			case "nuevo"
				cs="INSERT INTO " & precrs & "FotosHotel (CodigoEsta,IdSeccion,Foto,Orden) VALUES ("
				cs=cs & idh & "," & ids & ",'" & QuitarApos(archivo) & "',0)"
				base.execute cs
				controlRegistro(cs)
			
			case "actu"
				cs="UPDATE " & precrs & "FotosHotel SET Foto='" & QuitarApos(archivo) & "' "
				cs=cs & "WHERE Id=" & idf
				base.execute cs
				controlRegistro(cs)
				
		end select

		if haySize then 'hay que redimensionar las fotos
			original=server.MapPath(rutafotos & archivo)
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
				for sz=0 to ubound(RegSize,2)
					if RegSize(RegPAncho,sz) then 'mantener el ancho
						ancho_new=RegSize(RegAncho,sz)
						alto_new=(ancho_new/ratio) 'para que la foto mantenga la proporcion
					else 'mantener el alto
						alto_new=RegSize(RegAlto,sz)
						ancho_new=(alto_new*ratio) 'para que la foto mantenga la proporcion
					end if 'proporcion
					im.SetImage 1
					im.CreateImage cint(ancho_new),cint(alto_new)
					im.CopyImageResize 1,0,0,0,0,0,cint(ancho_new),cint(alto_new),ancho_ori,alto_ori
					
					im.WriteToFile server.MapPath(rutafotos) & "/" & trim(RegSize(RegPrefi,sz)) & archivo
					im.DestroyImage 'destruye la copia
				next 'sz
				im.SetImage 0
				im.DestroyImage 'destruye la original
				
				set im=nothing
			end if 'tipoimg		
		end if 'haySize
		
	end if
	
	set up = nothing
	
	pasalir=0 'no sale
end if 'modo

qf=paClng(request.QueryString("qf"))
if qf<>0 then 'hay que quitar la foto
	cs="DELETE FROM FotosHotel WHERE Id=" & qf
	base.execute cs
	controlRegistro(cs)
	
end if

%>