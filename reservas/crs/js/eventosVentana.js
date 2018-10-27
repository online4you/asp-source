// JavaScript Document
if (!es_IE) document.addEventListener("mousemove", posicRatonXY, true);
document.onmousemove = posicRatonXY;
var posicX = 0;
var posicY = 0;
var miX = 0;
var miY = 0;
sigueme=false;
var capaM=null;
function posicRatonXY(e) {
	scrolTop=0;
	scrolLeft=0;
	if (es_IE) { 
		if (document.documentElement && document.documentElement.scrollTop){
		  // Explorer 6 Strict
		  scrolTop = document.documentElement.scrollTop;
		  scrolLeft = document.documentElement.scrollLeft;
		} else if (document.body){
		  // all other Explorers
		  scrolTop = document.body.scrollTop;
		  scrolLeft = document.body.scrollLeft;
		}
		miX = window.event.clientX + scrolLeft;
		miY = window.event.clientY + scrolTop;
		posicX = window.event.screenX;
		posicY = window.event.screenY;
	} else { 
		miX = e.pageX;
		miY = e.pageY;
		posicX = e.screenX;
		posicY = e.screenY;
	}
	if (posicX < 0) posicX = 0;
	if (posicY < 0) posicY = 0;
	if (sigueme)
		muevete(posicX,posicY);
	return true;
} 

function muevete(laX,laY) {
	capaM.style.top = (laY-difY)+"px"; //(parseInt(capaM.style.top,10)+(posicY-difY))+"px";
	capaM.style.left = (laX-difX)+"px"; //(parseInt(capaM.style.left,10)+(posicX-difX))+"px";
}


function cargaInicio(){
	//eventos de la ventana
	/**/
	try {
		$("tituloFicha").addEvent("mousedown",pulsada);
		$("tituloFicha").addEvent("mouseup",liberaCapa);
		$("tituloFicha").addEvent("dblclick",cambiaForma);
		
		$("laX").addEvent("click",cerrar);
		
		$("iconoForma").addEvent("click",cambiaForma);
		
		ajustaVentana(); //ajusta tamaño ventana, pa que se vea to
		controlUpdate(); //cambia el color del boton actualizar al modificar un input
	  }catch(err){}
}
function ajustaVentana() {
	if (top.document.getElementById(self.name)) {
		alto=document.body.offsetHeight;
		//alert(alto);
		top.document.getElementById(self.name).style.height=(alto+10)+"px";
		//alert(self.name);
	}
}
function pulsada() {
	capaM=top.document.getElementById(self.name);
	capaM.style.zIndex=top.maxZIndex++;
	difX=posicX-capaM.offsetLeft;
	difY=posicY-capaM.offsetTop;
	sigueme=true;
}


function liberaCapa() {
	sigueme=false;
}


var elMini=25; //px de alto el titulo
function cambiaForma() {
	//esaCapa=self.name;
	var esaCapa=top.document.getElementById(self.name);
	if (esaCapa.offsetHeight!=elMini+2) { //está grande, hay que minimizar (2 pixels por el borde)
		altoOLD=esaCapa.offsetHeight; //valor del alto actual
		esaCapa.style.height=elMini+"px";
		//Cambia el icono
		document.getElementById('iconoForma').src='/img/Maxi.gif';
		document.getElementById('iconoForma').alt='Maximizar';
		//guardar el alto actual
		document.getElementById('iconoForma').name=altoOLD;
		esaCapa.style.overflow='hidden';
	}else{ //Maximizar
		eseAlto=document.getElementById('iconoForma').name;
		esaCapa.style.height=eseAlto+"px";
		//Cambia el icono
		document.getElementById('iconoForma').src='/img/Mini.gif';
		document.getElementById('iconoForma').alt='Minimizar';
		esaCapa.style.overflow='visible';
	}
	
}

window.addEvent('domready',cargaInicio);
//window.addEvent('load',cargaInicio);