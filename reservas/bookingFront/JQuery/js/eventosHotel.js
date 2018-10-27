// JavaScript Document

function cargaFotoFicha(esa){
	$("#fotoPrincipal").attr("src",esa);
	setTimeout("ajustaIFrame()",200); //el IE es así de cachondo (lento de cojones)
}

function montaGaleria() {
	var enlaces_fotos=$('div#fotosHotel a.thumbnail');
	
	for(x=0;x<enlaces_fotos.length;x++){
		enlace=enlaces_fotos[x].href;
		enlaces_fotos[x].href="javascript:cargaFotoFicha('"+enlace+"');";
	} //for

} //montaGaleria

montaGaleria();