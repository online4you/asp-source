// JavaScript Document
//Pa mover los iframes por ahí
var capaM = null;
difX=0;
difY=0;
var es_IE = navigator.userAgent.indexOf("MSIE") != -1;

if (!es_IE) document.addEventListener("mousemove", posicRatonXY, true);
document.onmousemove = posicRatonXY;
var posicX = 0;
var posicY = 0;
var miX = 0;
var miY = 0;
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
} 


function centrarCapa(laCapa,miAncho,miAlto,posiTop,posiLeft){
	elancho=document.body.clientWidth;
	elalto=screen.height; //document.body.clientHeight;
	if(posiLeft==0){
		l=(elancho/2)-(parseInt(miAncho/2)); //Pos. izquierda
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


function cambiaMoneda(esa){
	SetCookie("coin",esa,null,"/"); //esta funcion esta en cookies.js
	SetCookie("miCambio","0",null,"/"); //esta funcion esta en cookies.js
	window.location.reload();
}
function cambiaIdioma(idioma){
	var url=window.location.href.toLowerCase();
	pos=url.indexOf("lang=");
	if (pos!=-1) { //encontrado
		eso=url.substring(pos,pos+7);
		url=url.replace(eso,"lang="+idioma);
	} else { //no está la variable lang
		if (url.indexOf("?")==-1) //no hay ?
			url=url+"?lang="+idioma;
		else
			url=url+"&lang="+idioma;

	}
	window.location.href=url;
}


/*funcion para controlar capas DIV como select HTML */

function quitaLista(esa){
	$(esa).css("display",'none');
}

var idReloj;
var listaActual="";
function montarSelect() 
{
	var lista_select=$("div.capa_lista");
	for(x=0; x < lista_select.length; x++)
	{
		$("#" + lista_select[x].id).click(function()
		{	  
			//alert("click")
			var lista=$("#"+this.id+" div.lista");
			//alert(lista.length)
			for (i = 0; i < lista.length; i++) 
			{
				if (lista[i].style.display == "none" || lista[i].style.display == "") 
				{ 
					//alert(lista[i].id + " - " + lista[i].style.display);
					//alert("NO ESTA VISIBLE")
					//no está visible
					lista[i].style.display = "block";
					//$("#" + lista[i].id).css("display", "block");
					//$("#" + lista[i].id).css("position", "");
					
					//$("#" + lista[i].id).css("display", "block");
					//alert(lista[i].style.display)
					listaActual=this.id; //para controlar el cierre
					//esto es por culpa del IE
					//ancho=this.offsetWidth-4; //lista[i].offsetWidth-4;
					//var enlaces=$("#"+lista[i].id+" a");
					//for (x=0;x<enlaces.length;x++) 
						//enlaces[x].style.width = ancho+"px";
						
				}
				else
				{ 
					//alert("YA ESTA VISIBLE")
					//ya está visible
					lista[i].style.display = "none";
					listaActual="";
				}
			}
		});
		//$("#"+lista_select[x].id).hover(function()
		//{
			//if (listaActual==this.id)
			//	clearTimeout(idReloj); //detiene el reloj si hay un mouseout
		//}, function()
		//{
			//var lista=$("#"+this.id+" div.lista");
			//idReloj=setTimeout("quitaLista('#"+lista[0].id+"')",200);
		//});
	} //for
}