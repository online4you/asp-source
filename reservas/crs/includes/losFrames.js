// JavaScript Document
var plantillaSolapa="<div id='solapaVte' class='laSolapa'><div class='tituSolapa' onclick='javascript:cambiaFrame(Vte);'>titulo</div><div class='botonSolapa' onclick='javascript:quitaFrame(Vte);'></div></div><!--&nbsp;-->";

var ultimaMovida="";
var menuActi=0;
var menuFlota=0;
var solapaActiva=0;

function quitaFrame(ese){
	//pa las solapas
	capitas=document.getElementById("solapas").innerHTML.split("<!--&nbsp;-->");
	textoCapa=""
	for (x=0;x<capitas.length;x++){
		//sólo se guardan las que no son
		if (capitas[x].indexOf("solapa"+ese)==-1){ //está no ta
			if (capitas[x]!="undefined" && capitas[x]!=""){
				//alert(capitas[x]);
				textoCapa=textoCapa+capitas[x]+"<!--&nbsp;-->";
			}
		}
	}
	document.getElementById("solapas").innerHTML=textoCapa;
	//pa los iframes
	document.getElementById("elFrame"+ese).style.visibility='hidden';
	document.getElementById("elFrame"+ese).style.zIndex=1;
	document.getElementById("elFrame"+ese).src='/vacio.htm';
	//enfocar el ultimo puesto
	hayActi=false;
	for (s=7;s>=1;s--){
		laurl=document.getElementById("elFrame"+s).src;
		if (laurl.indexOf("vacio.htm")==-1){ //no tiene vacio.htm
			//esta vale
			if (solapaActiva==ese) //se ha quitado la solapa que estaba activa
				solapaActiva=s;

			cambiaFrame(s);
			hayActi=true;
			break;
		}
	}
	if (!hayActi){
		solapaActiva=0;
		menuActi=0;
	}
}

function dameLibre(esa){
	for (x=1;x<=7;x++){
		capi=esa+x.toString();
		laurl=document.getElementById(capi).src;
		if (laurl.indexOf('vacio.htm')!=-1)  //este está libre
			return x;
	}
	return 0; //no hay libres
}

function cargaFrame(ese,titulo){
	menuActi=dameLibre("elFrame"); //devuelve el id del frame libre
	if (menuActi!=0){ //hay libre
		creaSolapa(menuActi,titulo);
		palIframe(document.getElementById("elFrame"+menuActi),800,555,-1,-1,ese); //top=0, left=0
		if (solapaActiva!=0)
			cambiaFrame(menuActi);
		else
			activaSolapa(menuActi);
	}else{ //no hay libres
		alert("No hay solapas libres, cierre alguna");
	}
}
function creaSolapa(esaId,titulo){
	antes=document.getElementById("solapas").innerHTML;
	eseFrame=plantillaSolapa.replace(/Vte/g,esaId);
	eseFrame=eseFrame.replace("titulo",titulo);
	document.getElementById("solapas").innerHTML=antes+eseFrame;
}

function cambiaFrame(eso){
	if (solapaActiva!=0) {
		document.getElementById("elFrame"+solapaActiva).style.visibility="hidden";
		document.getElementById("elFrame"+solapaActiva).style.zIndex=1;
		document.getElementById("elFrame"+eso).style.visibility="visible";
		document.getElementById("elFrame"+eso).style.zIndex=20;
		activaSolapa(eso);
	}
}
function activaSolapa(cuala){
	//la anterior
	if (solapaActiva!=0)
		document.getElementById("solapa"+solapaActiva).className="laSolapa";

	document.getElementById("solapa"+cuala).className="laSolapaOver";
	solapaActiva=cuala;
}

function creaFlotante(esa,ancho,alto,elTop,elLeft){
	menuFlota=dameLibre("verFicha"); //devuelve el id del frame libre
	palIframe(document.getElementById("verFicha"+menuFlota),ancho,alto,elTop,elLeft,esa+"&ff="+solapaActiva+"&fc="+menuFlota);
}

function quitaFlota(ese){
	//encoger la capa porque el IE es tocapelotas
	encogeCapa(document.getElementById("verFicha"+ese));
	
	//pa las flotantes
	document.getElementById("verFicha"+ese).style.visibility='hidden';
	document.getElementById("verFicha"+ese).src='/vacio.htm';
	//Comprueba si queda alguna
	hayActi=false;
	for (s=1;s<=10;s++){
		//alert(document.getElementById("verFicha"+s).src);
		laurl=document.getElementById("verFicha"+s).src;
		if (laurl.indexOf("vacio.htm")==-1){ //no tiene vacio.htm
			//esta vale
			hayActi=true;
			ultimaMovida="verFicha"+s; //dejo esta capa como si fuera la ultima que se ha movido
			break;
		}
	}
	if (!hayActi){
		menuFlota=0;
		ultimaMovida="";
	}

}


/*
if (!es_IE) document.captureEvents(Event.CLICK);
document.onclick= miClick;
var tPulsada=0; //codigo de la tecla pulsada
function miClick(e){
	tPulsada=e.ctrlKey;
	//alert(oEvento.ctrlKey);
	if (e.modifiers && Event.ALT_MASK)
      alert ("La tecla ALT estaba pulsada cuando se produjo el evento.");
	 e.ctrlKey=false;
}*/
