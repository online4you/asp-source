<!--#include file="includes/FunGestion.asp"-->
<!--#include file="connections/creaHTM.asp"-->
<!--#include virtual="/includes/langweb.asp"-->
<!--#include virtual="/includes/transformaURL.asp"-->
<%
'creaHTM "http://www.come2mallorca.com/paginaHotel.asp?est=102&lang=en","/majorca-hotels/puerto-de-soller/hotel-aimia.html"
'response.End()

'Response.Charset = "ISO-8859-1"
Response.Charset = "iso-8859-1"
Dim xml
server.ScriptTimeout=800
'response.write "„All-Inklusiv“ "
'response.write asc("„") & "<br>"
'response.write server.HTMLEncode("„") & "<br>"
'response.End()

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

controlRegistro("Pasa fichas a HTML") 'guarda seguimiento

cs="SELECT CodigoEsta,Nombre,Zona,Nucleo_es,TipoAlojamiento "
cs=cs & "FROM " & precrs & "ConsultaHoteles ConsultaHoteles INNER JOIN " & precrs & "Nucleos Nucleos "
cs=cs & "ON ConsultaHoteles.Zona=Nucleos.Id "
laid=clng(request.QueryString("id"))
if laid<>0 then
	cs=cs & "WHERE CodigoEsta=" & laid & " "
end if
cs=cs & "ORDER BY Nombre"
rs.open cs,base
'response.write cs & "<br>" & rs.eof & "<br>"
if not rs.eof then
	RegHoteles=rs.getrows
	HCodi=0
	HNombre=1
	HZona=2
	HNZona=3
	HTipo=4
end if
rs.close

'Lista de registros
cs="SELECT Id,Nombre_es,Nombre_en,Nombre_de FROM " & precrs & "TipoAlojamiento "
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNom_es=1
	RNom_en=2
	RNom_de=3
	haylista=true
end if

set rs=nothing
base.close
set base=nothing

dim NIdioma(3)
NIdioma(1)="es"
NIdioma(2)="en"
NIdioma(3)="de"

'La de pruebas, es para evitar el primer error al procesar
creaHTM "/reservas/pruebaslista.asp","/hoteles-mallorca/ficha.html"
for h=0 to ubound(RegHoteles,2)
	for i=1 to ubound(NIdioma) 'para cada idioma
		lang=NIdioma(i)
		carpeta=ap("carpetaIdioma")
		
		for nficha=1 to 7
			texto=""
			tipoaloja=""
			nf=nficha
			mihotel="?est=" & RegHoteles(HCodi,h) & "&lang=" & NIdioma(i)
			if nf>1 then mihotel=mihotel & "&ficha=" & nf 'apartado
			anterior="http://www.come2mallorca.com/paginaHotel.asp" & mihotel
			'response.write anterior & "<br>"
			'Tipo Alojamiento
			if haylista then
				for rr=0 to ubound(RegLista,2)
					if RegLista(RCodi,rr)=RegHoteles(HTipo,h) then
						tipoaloja=RegLista(i,rr) 'tipo aloj.
					end if
				next
			end if
			zonahotel="" & RegHoteles(HNZona,h)
			if zonahotel="" then zonahotel="c2m"
			mifichero=carpeta & "/" & zonahotel & "/" & tipoaloja & "-" &  RegHoteles(HNombre,h)
			select case nf
				case 1 'Presentacion
					nuevoHTM=transformaURL(mifichero & ".html")
				case 2 'servicios
					nuevoHTM=transformaURL(mifichero & "-" & ap("servicios") & ".html")
				case 3 'galeria fotos
					nuevoHTM=transformaURL(mifichero & "-" & ap("fotos") & ".html")
				case 4 'como llegar
					nuevoHTM=transformaURL(mifichero & "-" & ap("comollegar") & ".html")
				case 5 'entorno
					nuevoHTM=transformaURL(mifichero & "-" & ap("entorno") & ".html")
				case 6 'tarifa
					nuevoHTM=transformaURL(mifichero & "-" & ap("vertarifa") & ".html")
				case 7 'ofertas
					nuevoHTM=transformaURL(mifichero & "-" & ap("ofertas") & ".html")
			end select
			
			'Procesando la pagina
			if nficha=1 then 'solo la primera
				response.write "Procesando: " & nuevoHTM & "<br/>"
			end if
			'Crear el HTM
			elbodi=""
			creaHTM anterior,nuevoHTM
			'Cambiar los enlaces de las fichas en la nueva pagina
			
			texto=elbodi 'valor HTM de la pagina creada
			'Cambiar enlaces
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=2",transformaURL(mifichero & "-" & ap("servicios") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=3",transformaURL(mifichero & "-" & ap("fotos") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=4",transformaURL(mifichero & "-" & ap("comollegar") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=5",transformaURL(mifichero & "-" & ap("entorno") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=6",transformaURL(mifichero & "-" & ap("vertarifa") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang & "&ficha=7",transformaURL(mifichero & "-" & ap("ofertas") & ".html"))
			texto=replace(texto,"/paginaHotel.asp?est=" & RegHoteles(HCodi,h) & "&lang=" & lang,transformaURL(mifichero & ".html"))

			on error resume next
			set FSO = Server.CreateObject("Scripting.FileSystemObject") 
			set oFichero=FSO.CreateTextFile(server.MapPath(nuevoHTM),true,false) 
			oFichero.write texto 'guardar cambios
			if err.number<>0 then
				response.write "***: " & err.description & "<br>"
			end if
			'Cerrar el fichero
			oFichero.close
			set oFichero=nothing
			set FSO=nothing
			on error goto 0
			response.Flush()

		next 'apartado fichas
	next 'idioma
	response.write "<br/>"
	'response.End()
next 'hoteles
%>
<center>
<br/>
<a href="javascript:window.close()">CERRAR</a>
</center>
