// JavaScript Document
function abreCalendar(esaFecha,elForm,capa,porDefecto,Idi){
	lafecha=eval("top."+capa+".document."+elForm+"."+esaFecha+".value");
	if (lafecha=="")
		lafecha=porDefecto;
	if (lafecha=="")
		lafecha=fechaWeb(new Date());
	laurl="calendario_Meses.asp?lang="+Idi+"&elForm="+elForm+"&valor="+esaFecha+"&"+esaFecha+"="+lafecha+"&capa="+capa;
	ptop=miY+dameTop(top.document.getElementById(capa)); //dameTop(elObj);
	ptop=ptop-130; //salga por encima de la posicion del raton
	if (ptop<0)
		ptop=5;
		
	pleft=miX+20+dameLeft(top.document.getElementById(capa)); //dameLeft(elObj)+20;
	//palIframe(top.document.getElementById('verCalendario'),220,120,ptop,pleft,laurl);
	top.creaFlotante(laurl,230,120,ptop,pleft);
}

function fechaWeb(lafecha2){
	Fdia=lafecha2.getDate();
	if (Fdia<10)
		Fdia="0"+Fdia;
	Fmes=lafecha2.getMonth()+1;
	if (Fmes<10)
		Fmes="0"+Fmes;
	Fany=lafecha2.getFullYear();
	return Fdia+"/"+Fmes+"/"+Fany;
}

var idReloj=0;
function cargaLista(){
	
	var mis_titulo_listas=$$('div.capa_lista');
	
	for(x=0;x<mis_titulo_listas.length;x++){
		mis_titulo_listas[x].addEvent("click",function(){
			var lista=$$("#"+this.id+" ul.lista");
			for (i=0;i<lista.length;i++) {
				ponLista(lista[i]);
			}
		});
		
		mis_titulo_listas[x].addEvent("mouseover",function(){
			var lista=$$("#"+this.id+" ul.lista");
			for (i=0;i<lista.length;i++) {
				clearTimeout(idReloj); //para el reloj si hay un mouseout
			}
		});

		mis_titulo_listas[x].addEvent("mouseout",function(){
			var lista=$$("#"+this.id+" ul.lista");
			for (i=0;i<lista.length;i++) {
				idReloj=setTimeout("quitaLista('"+lista[i].id+"')",200);
			}
		});

	}
}

function quitaLista(esa){
	$(esa).style.display='none';
}

function ponLista(esa){
	var mis_listas=$$('ul.lista');
	for(x=0;x<mis_listas.length;x++){
		mis_listas[x].style.display='none';
	}
	esa.style.display='block';	
}
