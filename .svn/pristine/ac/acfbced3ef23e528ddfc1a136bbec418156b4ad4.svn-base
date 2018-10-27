// JavaScript Document
function abreCalendar(esaFecha,elForm,capa,porDefecto,Idi){
	lafecha=eval("top."+capa+".document."+elForm+"."+esaFecha+".value");
	if (lafecha=="")
		lafecha=porDefecto;
	if (lafecha=="")
		lafecha=fechaWeb(new Date());
	laurl="calendario_Meses.asp?lang="+Idi+"&elForm="+elForm+"&valor="+esaFecha+"&"+esaFecha+"="+lafecha+"&capa="+capa;
	ptop=miY+dameTop(top.document.getElementById(capa)); //dameTop(elObj);
	//if ((ptop+130)>(document.body.scrollHeight-document.body.scrollTop)) //pa que  no se vaya por debajo del scroll
	ptop=ptop-130; //salga por encima de la posicion del raton
		
	pleft=miX+20+dameLeft(top.document.getElementById(capa)); //dameLeft(elObj)+20;
	//alert(document.body.scrollHeight);
	//alert(ptop);
	palIframe(top.document.getElementById('verCalendario'),220,120,ptop,pleft,laurl);
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
var rapTime;
var ultLista="lista";
function verLista(laLista){
	clearTimeout(rapTime);
	document.getElementById(laLista).style.visibility='visible';
	ultLista=laLista;
}
function quitaLista(){
	rapTime=setTimeout('fueraLista();',400);
	//document.getElementById('lista').style.visibility='hidden';
}
function fueraLista()
{
	topLista=dameTop(document.getElementById(ultLista));
	YMaxLista=topLista+document.getElementById(ultLista).offsetHeight; //posicion y max en la lista top
	leftLista=dameLeft(document.getElementById(ultLista));
	XMaxLista=leftLista+document.getElementById(ultLista).offsetWidth+20; //posicion x max en la lista left
	//alert("la Y Max:"+YMaxLista+"\n la X Max:"+XMaxLista);
	//alert("la Y :"+posicY+"\n la X :"+posicX);
	if (miY>YMaxLista || miX>XMaxLista || miY<topLista || miX<leftLista)
		document.getElementById(ultLista).style.visibility='hidden';
	else
		rapTime=setTimeout('fueraLista();',400);

}
