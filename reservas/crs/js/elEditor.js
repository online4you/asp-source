// JavaScript Document
function abreEditor(cualo,ancho,alto){
	texto=eval("document.getElementById('"+cualo+"').value");
	//texto=escape(texto);
	ww=ancho;
	hh=alto;
	t=(screen.height/2)-(alto/2);
	l=(screen.width/2)-(ancho/2);
	esaventa=window.open("conformato.asp?campo="+cualo+"&an="+ww+"&al="+hh,"","top="+t+",left="+l+",width="+ww+",height="+hh);
}
