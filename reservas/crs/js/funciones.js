// JavaScript Document
//Pa mover los iframes por ahí
var capaM = null;
difX=0;
difY=0;
var es_IE = navigator.userAgent.indexOf("MSIE") != -1;

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
	capita.style.display="block";
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

function abreEditor(cualo,ancho,alto){
	ww=ancho+10;
	hh=alto+70;
	var recarga="";
	//comprueba 4 niveles de recarga (nivel de frames)
	if (parent.parent.parent.name!="")
		recarga+="."+parent.parent.parent.name;
	if (parent.parent.name!="")
		recarga+="."+parent.parent.name;
	if (parent.name!="")
		recarga+="."+parent.name;
	recarga+="."+self.name;		
	top.creaFlotante("/conformato.asp?campo="+cualo+"&an="+ancho+"&al="+alto+"&recarga="+recarga,ww,hh,0,0);
}

//funcion para controlar si se modifican los inputs
function controlUpdate() {
	var los_inputs=$$('form input');
	for(x=0;x<los_inputs.length;x++){
		los_inputs[x].addEvent("change",pintaUpdate);
	}
}
function pintaUpdate(){
	if ($("boton")!=null){
		$("boton").className="botonUpdate";
	}
}
function recargaFrame(ese) {
	url=eval("top."+ese+".location");
	eval("top."+ese+".location='"+url+"'");
}
function recargaFrameNoDelete(ese) {
	url=eval("top."+ese+".location");
	url+='&deleteTemporal=false';
	eval("top."+ese+".location='"+url+"'");
}
function cargaTexto(campo,valor){ //el texto que viene del editor html
	$(campo).value=valor;
}
function searchByName(){
	if($j('#ajaxHot').val()!=''){
		$j.get ("/reservas/crs/ajaxGetHotelIdByName.asp","query="+$j('#ajaxHot').val(),
			function (event){
				$j('#HSeleccionado').val(event);
				CambioHotel(document.getElementById('HSeleccionado'));
			});
	
	}
}
function searchByNameFiltro(){
	if($j('#ajaxHot').val()!=''){
		$j.get ("/reservas/crs/ajaxGetHotelIdByName.asp","query="+$j('#ajaxHot').val(),
			function (event){
				$j('#HSeleccionado').val(event);
				cambiaFiltro();
			});
	
	}
}