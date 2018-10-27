<!--#include virtual="/includes/FunGestion.asp"-->
<!--#include virtual="/idiomas/claseIdioma.asp"-->
<!--#include virtual="/includes/claseCookie.asp"-->
<!--#include file="vwd_imgbounds.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

'Array de carpetas de imagenes
dim carpetaIMG(0)
carpetaIMG(0)=lcase(rutafotos) 'solo tenemos esa

rutaCarpeta=request.QueryString("cpt") 'id de la carpeta y nivel seleccionado
if rutaCarpeta="" then rutaCarpeta=carpetaIMG(0) 'la primera

'rutafotos carpeta donde estan las fotos
Set fs = Server.CreateObject("Scripting.FileSystemObject")
Set lista_archivos = fs.GetFolder(Server.MapPath(rutaCarpeta))

dim listaIMG()
LNombre=0
LFecha=1
LSize=2

nlista=-1
For each filefound in lista_archivos.files
	if esGrafico(filefound.name) then 'la funcion está en funGestion.asp
		nlista=nlista+1
		redim preserve listaIMG(2,nlista)
		listaIMG(LNombre,nlista)=filefound.name
		listaIMG(LFecha,nlista)=filefound.dateCreated
		listaIMG(LSize,nlista)=filefound.size
		'response.write listaIMG(LNombre,f) & " - " & listaIMG(LFecha,f) & " - " & listaIMG(LSize,f) & "<br>"
	end if 'esGrafico
next 'f

set lista_archivos=nothing
set fso=nothing

if nlista>-1 then
	PorPag=10
	TotReg=ubound(listaIMG,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("p"))
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
end if 'nlista

sub ponerSubcarpetas(ruta)
	dim rutaWeb,raiz
	dim guena,fs,lista_archivos
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	Set lista_archivos = fs.GetFolder(Server.MapPath(ruta))
	guena=true
	raiz=false
	if lista_archivos.subFolders.count=0 then guena=false
	'Comprobar si son las raices principales
	for car=0 to ubound(carpetaIMG)
		if carpetaIMG(car)=ruta then
			guena=true
			raiz=true
			exit for
		end if
	next
	if guena then
		marca="carpeta"
		if instr(rutaCarpeta,ruta)<>0 then marca="carpetaAbierta"
		if raiz then
			response.write "<ul class='" & marca & "'>" & vbcrlf
			response.write "<a href='" & MiPag & "?cpt=" & ruta & "'>" & lista_archivos.name & "</a>" & vbcrlf
		end if 'raiz
		For each subcarpeta in lista_archivos.subFolders
			rutaWeb=lcase(replace(subcarpeta.path,"\","/"))
			posdesde=instr(rutaWeb,ruta)
			rutaWeb=mid(rutaWeb,posdesde) & "/"
			marca="carpeta"
			if instr(rutaCarpeta,rutaWeb)<>0 then marca="carpetaAbierta"
			response.write "<li class='" & marca & "'>"
			response.write "<a href='" & MiPag & "?cpt=" & rutaWeb & "'>" & subcarpeta.name & "</a>" & vbcrlf
			response.write "<ul>"
			ponerSubCarpetas(rutaWeb)
			response.write "</ul></li>" & vbcrlf
		next 'f
		if raiz then response.write "</ul>" & vbcrlf
	end if 'guena
	set lista_archivos=nothing
	set fs=nothing
end sub
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Galerias de fotos</title>
<link href="css/advimage.css" rel="stylesheet" type="text/css" />
<link href="css/cssvte.css" rel="stylesheet" type="text/css" />
<%if es_ie then%>
<link href="css/cssvte_ie.css" rel="stylesheet" type="text/css" />
<%end if%>
</head>
<iframe name="paProcesos" id="paProcesos" class="capaIframe"></iframe>
<body id="advimage">
	<div id='capa_izq'>
    	<div id='capa_carpetas'>
        	<div class="titulo_thumbnail">Seleccionar carpeta</div>
            <%for c=0 to ubound(carpetaIMG)
				ponerSubCarpetas(carpetaIMG(c))
            next 'c %>
        </div>
    	<div id='capa_upfichero'>
        	<div class="titulo_thumbnail">Subir fichero a la galeria</div>
            <form name="f1" method="post" enctype="multipart/form-data" target="paProcesos" action="subirImg.asp">
            <p>Carpeta: <br/>
            <b><%=rutaCarpeta%></b><br />
            (para subir en otra carpeta seleccionar en el panel de arriba)</p>
            <input type="hidden" name="up_carpeta" id="up_carpeta" value="<%=rutaCarpeta%>" />
            <p>
            El nombre de la foto es conveniente que no tenga espacios en blanco ni carácteres especiales (acentos).<br/>
            Archivo: <input type="text" name="up_archivo" id='up_archivo' style='width:200px' class="texto" readonly="readonly"><br />
            </p>
            <div class='capaFile'>
            <input type="file" name="file_archivo" id='file_archivo' onChange="cargaFile(this)" />
            <img src="img/espera.gif" id='espera' width="16" height="16" />
            </div>
            <p>
            Si desea cambiar el tamaño de la imagen, puede indicar una de las medidas.<br/>
            Ancho: <input type="text" name="up_ancho" id="up_ancho" style='width:40px' class="texto" value="0">
            &nbsp;x&nbsp;Alto: <input type="text" name="up_alto" id="up_alto" style='width:40px' class="texto" value="0">
            </p>
            <p align="center">
            <input type="button" name="botonet" value="Subir imagen" class="boton" onClick="subeFichero();" />
            </p>
            </form>
        </div>
    </div> <!-- capa_izq -->
    
	<div id='capa_centro'>
		<div id="capa_thumbnail">
			<div class="titulo_thumbnail">Galeria: <b><%=rutaCarpeta%></b></div>
            <div class="paginas">
				<%if pag>1 then%>
                <a href="<%=MiPag%>?cpt=<%=rutacarpeta%>&p=<%=Pag-1%>" class='enlacePagina'><%=FlechaLeft%></a> 
                <%end if%>
                &nbsp;
                <select name="laspaginas" onChange="cambiaPagina(this);">
                <%for yy=1 to Maxp
					marca=""
					if yy=pag then marca=" selected"%>
                    <option value="<%=yy%>"<%=marca%>><%=yy%></option>
                <%next%>
                </select>
                &nbsp;
                <%if pag<MaxP then%>
                <a href="<%=MiPag%>?cpt=<%=rutacarpeta%>&p=<%=Pag+1%>" class='enlacePagina'><%=FlechaRight%></a> 
                <%end if%>
            </div> <!-- paginas -->
            <%if nlista>-1 then
			for f=IReg to IReg+PorPag-1
				if f>ubound(listaIMG,2) then exit for
					vwdImageBounds rutaCarpeta & listaIMG(LNombre,f),maxWidth,maxHeight
					texto=listaIMG(LNombre,f) & "<br/>"
					textoSinNombre=ori_width & " x " & ori_height & "&nbsp;px&nbsp;"
					textoSinNombre=textoSinNombre & "(" & formatnumber((listaIMG(LSize,f) / 1024),2,-1,0) & " Kb)"
					texto=texto & textoSinNombre%>
            	<div align="center" class="thumbnail">
				<img src="<%=rutaCarpeta & listaIMG(LNombre,f)%>" onClick="cambiaFoto(this,'<%=texto%>');" alt="<%=textoSinNombre%>" />
               	<p><%=listaIMG(LNombre,f)%></p>
            	</div>
                <%if ((f+1) mod 5)=0 then response.write "<br class='clear' />"
			next
			end if 'nlista%>
		</div> <!-- capa_thumbnail -->
		<div id='capa_foto'>
		<%if nlista>-1 then%>
        	<div align="center" style="float:left; width:400px; margin-left:5px">
			<img id='lafoto' src="<%=rutaCarpeta & listaIMG(LNombre,IReg)%>"  />
            <%
			vwdImageBounds rutaCarpeta & listaIMG(LNombre,IReg),maxWidth,maxHeight
			texto=listaIMG(LNombre,IReg) & "<br/>"
			texto=texto & ori_width & " x " & ori_height & "&nbsp;px&nbsp;"
			texto=texto & "(" & formatnumber((listaIMG(LSize,IReg) / 1024),2,-1,0) & " Kb)"%>
			<p id='tx_foto'><%=texto%></p>
            </div>
		<%end if%>		
            <div id='capa_botones'>
            <input type="button" id="insert" name="insert" class="boton" value="Insertar foto" onClick="insertaFoto()" />
            <input type="button" id="cancel" name="cancel" class="boton" value="Cerrar" onClick="cerrar()" style="margin-top:30px;" />
            </div>
		</div> <!-- capa_foto -->
	</div> <!-- capa_centro -->
    
	<script language="javascript" type="text/javascript">
	function cambiaFoto(esa,texto) {
		afoto=esa.src;
		document.getElementById('lafoto').src=afoto;
		document.getElementById('tx_foto').innerHTML=texto;
	}
	function cambiaPagina(esa) {
		window.location="<%=MiPag%>?cpt=<%=rutaCarpeta%>&p="+esa.value;
	}
	function cargaFile(elFile) {
		document.getElementById("paProcesos").src="nombreFichero.asp?file="+elFile.value;
		//document.getElementById("up_archivo").value=elFile.value;
	}
	function subeFichero(){
		document.getElementById("espera").style.display='block';
		document.f1.submit();
	}
	function insertaFoto(){
		opener.document.getElementById("src").value=document.getElementById("lafoto").src;
		opener.ImageDialog.showPreviewImage(document.getElementById("lafoto").src);
		cerrar();
	}
	function cerrar(){
		window.close();
	}
	</script>
</body> 
</html> 
