// JavaScript Document
var plantillaSolapa="<div id='solapaVte' class='laSolapa'><div class='tituSolapa' onclick='javascript:cambiaFrame(Vte);'>titulo</div><div class='botonSolapa' onclick='javascript:quitaFrame(Vte);'></div></div><!--&nbsp;-->";

var ultimaMovida="";
var menuActi=0;
var menuFlota=0;
var solapaActiva=0;
var maxZIndex=10;

function quitaFrame(ese){
	//pa las solapas
	capitas=$("solapas").innerHTML.split("<!--&nbsp;-->");
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
	$("solapas").innerHTML=textoCapa;
	//pa los iframes
	$("elFrame"+ese).style.display='none';
	$("elFrame"+ese).style.zIndex=1;
	$("elFrame"+ese).src='/vacio.htm';
	//enfocar el ultimo puesto
	hayActi=false;
	for (s=7;s>=1;s--){
		laurl=$("elFrame"+s).src;
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
		laurl=$(capi).src;
		if (laurl.indexOf('vacio.htm')!=-1)  //este está libre
			return x;
	}
	return 0; //no hay libres
}

function cargaFrame(ese,titulo){
	menuActi=dameLibre("elFrame"); //devuelve el id del frame libre
	if (menuActi!=0){ //hay libre
		creaSolapa(menuActi,titulo);
		palIframe($("elFrame"+menuActi),800,555,-1,-1,ese); //top=0, left=0
		if (solapaActiva!=0)
			cambiaFrame(menuActi);
		else
			activaSolapa(menuActi);
	}else{ //no hay libres
		alert("No hay solapas libres, cierre alguna");
	}
}

function creaSolapa(esaId,titulo){
	antes=$("solapas").innerHTML;
	eseFrame=plantillaSolapa.replace(/Vte/g,esaId);
	eseFrame=eseFrame.replace("titulo",titulo);
	$("solapas").innerHTML=antes+eseFrame;
}

function cambiaFrame(eso){
	if (solapaActiva!=0) {
		$("elFrame"+solapaActiva).style.display="none";
		$("elFrame"+eso).style.display="block";
		activaSolapa(eso);
	}
}
function activaSolapa(cuala){
	//la anterior
	if (solapaActiva!=0)
		$("solapa"+solapaActiva).className="laSolapa";

	$("solapa"+cuala).className="laSolapaOver";
	solapaActiva=cuala;
}

function creaFlotante(esa,ancho,alto,elTop,elLeft){
	menuFlota++; //seguimos sumando
	crearIFrame(menuFlota);
	palIframe($("verFicha"+menuFlota),ancho,alto,elTop,elLeft,esa+"&ff="+solapaActiva+"&fc="+menuFlota);
}

function crearIFrame(nuevo) {
    /*var newFrame=document.createElement("IFRAME");
    newFrame.id="verFicha"+nuevo;
	newFrame.name="verFicha"+nuevo;
	newFrame.frameBorder='0';
    newFrame.src="vacio.htm";
	newFrame.className="ficha";
	newFrame.style.zIndex=maxZIndex++;
    document.getElementById('capaFrames').appendChild(newFrame);*/
	
	var newFrame = new Element('iframe', {
    'id': 'verFicha'+nuevo,
	'name': 'verFicha'+nuevo,
	'frameBorder':'0',
    'class': 'ficha',
	'styles': {
        'zIndex': maxZIndex
    },
    'src': 'vacio.htm'
	});
	document.getElementById('capaFrames').appendChild(newFrame);

}  

function quitaFlota(ese){
	//pa las flotantes
	var flota=document.getElementById(ese);
	var padre=flota.parentNode;
	padre.removeChild(flota); 
	//document.getElementById('capaFrames').removeChild(flota);
}
