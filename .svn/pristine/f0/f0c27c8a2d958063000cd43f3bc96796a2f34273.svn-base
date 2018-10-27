// JavaScript Document


function ajustaIFrame(){
	alto=$("#principalFrame").height();
	if (top.$('#iframeContenido')) {
		top.$('#iframeContenido').css("height",(alto+20)+"px");
	}
}

function cargaInicio() {
	montarSelect();
	//comprobar si es diferente servidor
	//alert(top);
	
	//ajustaIFrame();
	
	$("#codpromo").keypress(function(event) {
		if (event.keyCode == '13') {
			cargaPromo();
			return false; //para evitar el submit
		}
	});
} //cargaInicio

$(document).ready(cargaInicio);
