// JavaScript Document

//Pa mover los iframes por ahí
var capaM = null;
difX=0;
difY=0;
var es_IE = navigator.userAgent.indexOf("MSIE") != -1;

if (!es_IE) document.captureEvents(Event.MOUSEMOVE);
document.onmousemove = posicRatonXY;
var posicX = 0;
var posicY = 0;
function posicRatonXY(e) {
	if (es_IE) { 
		if (document.documentElement && document.documentElement.scrollTop){
		  // Explorer 6 Strict
		  scrolTop = document.documentElement.scrollTop;
		} else if (document.body){
		  // all other Explorers
		  scrolTop = document.body.scrollTop;
		}
		/*posicX = window.event.clientX + document.body.scrollLeft;
		posicY = window.event.clientY + scrolTop;*/
		posicX = window.event.screenX;
		posicY = window.event.screenY;
	} else { 
		/*posicX = e.pageX;
		posicY = e.pageY;*/
		posicX = e.screenX;
		posicY = e.screenY;
	}
	if (posicX < 0) posicX = 0;
	if (posicY < 0) posicY = 0;
	muevete(posicX,posicY);
	return true;
} 


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
