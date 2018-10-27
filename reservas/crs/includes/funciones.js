// JavaScript Document
function centrarCapa(laCapa,miAncho,miAlto,posiTop,posiLeft){
	elancho=document.body.clientWidth;
	elalto=screen.height; //document.body.clientHeight;
	if(posiLeft==0){
		l=(elancho/2)-(parseInt(miAncho/2)); //Pos. izquierda
		//l=l-15;
		posiLeft=l;
	}
	if (posiTop==0){
		t=(elalto/2)-(parseInt(miAlto/2)); //Pos. superior
		t=t-70; //Quito por la barra del navegador
		//añadir scroll
		t=t+document.body.scrollTop;
		if (es_IE)
			t=t+document.documentElement.scrollTop;
		else
			t=t+self.pageYOffset;
		if (t<0) 
			t=0;
		posiTop=t;
	}
	laCapa.style.left=posiLeft+"px";
	laCapa.style.top=posiTop+"px";
}

/* Funcion AjaxXocolait */
function palIframe(capita,ancho,alto,posiTop,posiLeft,url){
	capita.style.height=alto+"px";
	capita.style.width=ancho+"px";
	if (posiTop==0 || posiLeft==0){
		centrarCapa(capita,ancho,alto,posiTop,posiLeft);
	}else{
		if (posiTop<0) posiTop=0; //valor -1
		if (posiLeft<0) posiLeft=0; //valor -1
		capita.style.top=posiTop+"px";
		capita.style.left=posiLeft+"px";
	}
	capita.src=url;
	capita.style.visibility="visible";
}

function encogeCapa(esa){
	esa.style.width="1px";
	esa.style.height="1px";
}

//Pa mover los iframes por ahí
var capaM = null;
difX=0;
difY=0;
var es_IE = navigator.userAgent.indexOf("MSIE") != -1;

if (!es_IE) document.captureEvents(Event.MOUSEMOVE);
document.onmousemove = posicRatonXY;
var posicX = 0;
var posicY = 0;
var miX = 0;
var miY = 0;
sigueme=false;
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
	top.muevete(posicX,posicY);
	return true;
} 

function pulsada(obj) {
	difX=posicX-obj.offsetLeft;
	difY=posicY-obj.offsetTop;
	top.marcaCapa(obj,difX,difY);
}

function ponEti(miTexto){
	document.getElementById('capilla').innerHTML=miTexto;
	document.getElementById('capilla').style.top=(posicY-100)+"px";
	document.getElementById('capilla').style.left=(posicX+14)+"px";
	document.getElementById('capilla').style.visibility='visible';
	sigueme=true;
}
function quitaEti(){
	document.getElementById('capilla').style.visibility='hidden';	
	sigueme=false;
}


var ultimaVisible="";
function verCapa(esa){
	if (ultimaVisible!="")
		document.getElementById(ultimaVisible).style.visibility='hidden';
	
	document.getElementById(esa).style.visibility='visible';
	ultimaVisible=esa;
}

function dameTop(obj){
	var curtop = 0;
	if (obj.offsetParent){
		while (obj.offsetParent)
		{
		curtop += obj.offsetTop;
		obj = obj.offsetParent;
		}
	}else if (obj.y){
		curtop += obj.y;
	}
	return curtop;
}
function dameLeft(obj){
	var curLeft = 0;
	if (obj.offsetParent){
		while (obj.offsetParent)
		{
		curLeft += obj.offsetLeft;
		obj = obj.offsetParent;
		}
	}else if (obj.x){
		curLeft += obj.x;
	}
	return curLeft;
}

ultSubMenu=0;
function verSubMenu(ese){
	clearTimeout(rapTime);
	if (ultSubMenu!=0){ //quitar anterior
		document.getElementById('capaOpcion'+ultSubMenu).style.visibility='hidden';
	}
	//posicion top
	posT=dameTop(document.getElementById('opcion'+ese))+document.getElementById('opcion'+ese).offsetHeight;
	posT=posT-document.getElementById('capaGeneral').offsetTop-2; //
	//posicion Left
	posL=dameLeft(document.getElementById('opcion'+ese));
	posL=posL-document.getElementById('capaGeneral').offsetLeft; //
	document.getElementById('capaOpcion'+ese).style.top=posT+'px';
	document.getElementById('capaOpcion'+ese).style.left=posL+'px';
	ultSubMenu=ese;
	document.getElementById('capaOpcion'+ese).style.visibility='visible';

}

rapTime=-1;
function tiempoFuera()
{
	if (ultSubMenu!=0)
		document.getElementById('capaOpcion'+ultSubMenu).style.visibility='hidden';
}
function quitarCapa(esa)
{
	rapTime=setTimeout('tiempoFuera();',200);
}

function runSWF(archivo, ancho, alto, version, bgcolor, id, menu, FlashVars, quality, allowScriptAccess) { // tutorial by IVI CONCEPT - www.ivi-concept.com
if(version!=""){
var version_data=version;
}else{
var version_data="6,0,0,0";
}
if(menu!=""){
menu_data=menu;
}else{
menu_data=false;
}
if(bgcolor!=""){
var bgcolor_data=bgcolor;
}else{
var bgcolor_data="#FFFFFF";
}
if(id!=""){
id_data=id;
}else{
id_data="flashMovie";
}
if(quality!=""){
quality_data=quality;
}else{
quality_data="high";
}
if(allowScriptAccess!=""){
allowScriptAccess_data=allowScriptAccess;
}else{
allowScriptAccess_data="always";
}
var quality="high"; // calidad de visualización de la peli
document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase= "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version= '+version_data+'" width='+ancho+' height='+alto+' id='+id_data+'>\n');
document.write('<param name="movie" value='+archivo+'>\n');
document.write('<param name= "allowScriptAccess" value= '+allowScriptAccess_data+'>\n');
document.write('<param name="quality" value='+quality_data+'>\n');
document.write('<param name="FlashVars" value='+FlashVars+'>\n');
document.write('<param name="bgcolor" value='+bgcolor_data+'>\n');
document.write('<param name="wmode" value="transparent">\n');
document.write('<param name="menu" value='+menu_data+' >\n');
document.write('<embed src='+archivo+' bgcolor='+bgcolor_data+' FlashVars='+FlashVars+' menu='+menu_data+' allowScriptAccess='+allowScriptAccess_data+' quality='+quality_data+' pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width='+ancho+' height='+alto+' swLiveConnect=true name='+id_data+' wmode="transparent"></embed>');
document.write('</object>\n');
}

var elMini=25; //px de alto el titulo
function cambiaForma() {
	esaCapa=self.name;
	miCapa=top.document.getElementById(esaCapa);
	if (miCapa.offsetHeight!=elMini+2) { //está grande, hay que minimizar (2 pixels por el borde)
		altoOLD=miCapa.offsetHeight; //valor del alto actual
		miCapa.style.height=elMini+"px";
		eval("top."+esaCapa+".document.body.style.height="+elMini+"+'px'");
		eval("top."+esaCapa+".document.body.style.overflow='hidden'");
		//Cambia el icono
		eval("top."+esaCapa+".document.getElementById('iconoForma').src='/img/Maxi.gif'");
		eval("top."+esaCapa+".document.getElementById('iconoForma').alt='Maximizar'");
		//guardar el alto actual
		eval("top."+esaCapa+".document.getElementById('iconoForma').name='"+altoOLD+"'");
	}else{ //Maximizar
		eseAlto=eval("top."+esaCapa+".document.getElementById('iconoForma').name");
		miCapa.style.height=eseAlto+"px";
		//Cambia el icono
		eval("top."+esaCapa+".document.getElementById('iconoForma').src='/img/Mini.gif'");
		eval("top."+esaCapa+".document.getElementById('iconoForma').alt='Minimizar'");
		eval("top."+esaCapa+".document.body.style.overflow='visible'");
	}
}

//controla el evento de un ID para IE y para FireFox
function controlEvento(objeto,evento, funcion) {
    //objeto = document.getElementById(objeto);
    if (objeto.addEventListener)  // W3C DOM
        objeto.addEventListener(evento,funcion,false);
    else if (objeto.attachEvent) { // IE DOM
        var r = objeto.attachEvent("on"+evento, funcion);
		return r;
    }
}