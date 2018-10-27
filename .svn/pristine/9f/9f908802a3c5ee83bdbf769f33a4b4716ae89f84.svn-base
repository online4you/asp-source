// JavaScript Document
var menuFlota=0;
var numeroFrame=0;
var solapaActiva=0;
var maxFrames=7; //nº maximos de frames del centro
var maxZIndex=10;

function quitaFrame(ese){
	//la solapa
	var solapa=$("solapa"+ese);
	var padre=solapa.parentNode;
	padre.removeChild(solapa); 

	var miFrame=$("elFrame"+ese);
	var padre=miFrame.parentNode;
	padre.removeChild(miFrame); 

	//enfocar el ultimo puesto
	solapaActiva=0;
	var pestanyas=$$('div.tituSolapa');
	if (pestanyas.length>0) {
		esa=pestanyas[pestanyas.length-1].parentNode.id; //la ultima solapa creada
		esa=esa.replace("solapa",""); //dejo sólo el numero
		solapaActiva=esa;
		activaSolapa(solapaActiva);
	}
}

function creaFrame(ese,titulo){
	numeroFrame++; //seguimos sumando

	cuantos=parseInt(document.getElementById ("contenido").childNodes.length,10);
	if (cuantos<maxFrames) {
		var newFrame = new Element('iframe', {
		'id': 'elFrame'+numeroFrame,
		'name': 'elFrame'+numeroFrame,
		'frameBorder':'0',
		'class': 'fichaIframe',
		'styles': {
			'zIndex': 2
		},
		'src': 'vacio.htm'
		});
		$('contenido').appendChild(newFrame);
		
		creaSolapa(numeroFrame,titulo);
		palIframe($("elFrame"+numeroFrame),800,555,-1,-1,ese);
		activaSolapa(numeroFrame);
	
	}else{
		alert("No hay solapas libres, cierre alguna");
	}
}


function creaSolapa(esaId,titulo){
	var newDiv = new Element('div', {
    'id': 'solapa'+esaId,
    'class': 'laSolapa'});
	$('solapas').appendChild(newDiv);
	$("solapa"+esaId).innerHTML='<div class="tituSolapa" onclick="javascript:activaSolapa('+esaId+');">'+titulo+'</div><div class="botonSolapa" onclick="javascript:quitaFrame('+esaId+');"></div></div>';

}

function activaSolapa(cuala){
	//la anterior
	if (solapaActiva!=0) {
		$("solapa"+solapaActiva).className="laSolapa";
		$("elFrame"+solapaActiva).style.display='none';
	}
	$("solapa"+cuala).className="laSolapaOver";
	$("elFrame"+cuala).style.display='block';
	solapaActiva=cuala;
	if (top.frames["elFrame"+cuala].enfoca)
		setTimeout('top.frames["elFrame'+cuala+'"].enfoca()',500);
}

function creaFlotante(esa,ancho,alto,elTop,elLeft){
	menuFlota++; //seguimos sumando
	crearIFrame(menuFlota);
	palIframe($("verFicha"+menuFlota),ancho,alto,elTop,elLeft,esa+"&ff="+solapaActiva+"&fc="+menuFlota);
}

function crearIFrame(nuevo) {
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
