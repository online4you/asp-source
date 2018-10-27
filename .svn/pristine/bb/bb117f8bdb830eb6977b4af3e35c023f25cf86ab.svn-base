// JavaScript Document

//Pa mover los iframes por ahí
var capaM = null;
difX=0;
difY=0;
var es_IE = navigator.userAgent.indexOf("MSIE") != -1;


function liberaCapa() {
	capaM = null;
}

function marcaCapa(obj,laX,laY) {
	capaM = obj; // obj.parentNode;
	if (top.ultimaMovida!=""){
		top.document.getElementById(top.ultimaMovida).style.zIndex=20;
	}
	capaM.style.zIndex=30;
	top.ultimaMovida=capaM.id;
	difX=laX;
	difY=laY;	
	
}

function muevete(laX,laY) {
	if (capaM != null) {
		capaM.style.top = (laY-difY)+"px"; //(parseInt(capaM.style.top,10)+(posicY-difY))+"px";
		capaM.style.left = (laX-difX)+"px"; //(parseInt(capaM.style.left,10)+(posicX-difX))+"px";
	}
}
