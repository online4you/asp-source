<% 
dim TIdioma(5)
TIdioma(1)="it"
TIdioma(2)="es"
TIdioma(3)="en"
TIdioma(4)="de"
TIdioma(5)="fr"


cs="SELECT Nombre,NombrePagina "
cs=cs & "FROM DatosHotel INNER JOIN Establecimientos "
cs=cs & "ON DatosHotel.CodigoEsta=Establecimientos.CodigoEsta "
cs=cs & "WHERE DatosHotel.CodigoEsta=" & MiId
rs.open cs,base
hayficha=false
if not rs.eof then
	hayficha=true
	nhotel=rs("nombre")
	pagina=rs("nombrepagina")
end if
rs.close

if hayficha then
	sub GenerarHTM(fichero,idioma,nidi)
		nuevo=server.MapPath("/hoteles") &  "\" & fichero & "_" & idioma & ".asp"
		set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		'Call FSO.CopyFile("plantilla.htm",nuevo, True)
		
		'Abrir fichero plantilla
		set oFichero = FSO.OpenTextFile(server.MapPath("PlantillaHotel.asp")) 
		
		Archivo = oFichero.ReadAll  'Paso los datos a una variable
		
		'Cerrar el fichero
		oFichero.close
		set oFichero=nothing
		
		'Empezar a reemplazar
		Archivo = Replace(Archivo, "<vte=lang>",idioma) 
		Archivo = Replace(Archivo, "<vte=est>",MiId) 
		Archivo = Replace(Archivo, "<vte=nhotel>",nhotel) 
		
		
		set MiFiche=FSO.CreateTextFile(nuevo,true) 
		MiFiche.write Archivo
		miFiche.close
		set MiFiche=nothing
		
		set FSO=nothing

	end sub
	
	'Generar las paginas
	for ti=1 to ubound(TIdioma)
		GenerarHTM pagina,TIdioma(ti),ti
	next
end if 'hayficha
%> 
