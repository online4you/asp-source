<%
pasalir=0
if request.form<>"" then 'Actualizar
	modo=request.QueryString("modo")
	etiqueta=request.form("etiqueta")
	texto_es=request.form("texto_es")
	texto_en=request.form("texto_en")
	texto_de=request.form("texto_de")
	texto_pt=request.form("texto_pt")
	texto_fr=request.form("texto_fr")
	texto_it=request.form("texto_it")
	detalle=request.form("detalle")
	select case modo
		case "borra"
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cadena=""
				for t=0 to ubound(queborro)
					objIdioma_es.borraTraduccion trim(queborro(t))
					objIdioma_en.borraTraduccion trim(queborro(t))
					objIdioma_de.borraTraduccion trim(queborro(t))
					objIdioma_pt.borraTraduccion trim(queborro(t))
					objIdioma_fr.borraTraduccion trim(queborro(t))
					objIdioma_it.borraTraduccion trim(queborro(t))
				next
			end if
		
		case "actu","nuevo"
			objIdioma_es.actuTraduccion etiqueta,texto_es,detalle
			if texto_en="" then texto_en=texto_es
			objIdioma_en.actuTraduccion etiqueta,texto_en,""
			if texto_de="" then texto_de=texto_es
			objIdioma_de.actuTraduccion etiqueta,texto_de,""
			if texto_pt="" then texto_pt=texto_es
			objIdioma_pt.actuTraduccion etiqueta,texto_pt,""
			if texto_fr="" then texto_fr=texto_es
			objIdioma_fr.actuTraduccion etiqueta,texto_fr,""
			if texto_it="" then texto_it=texto_es
			objIdioma_it.actuTraduccion etiqueta,texto_it,""
			pasalir=1
			
	end select
	
end if
%>