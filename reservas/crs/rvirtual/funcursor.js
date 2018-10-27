// JavaScript Document
function posicionCursor(miCampo)
{
   var tb = document.getElementById(miCampo);
	var cursor = -1;
	alert("document.selection:"+document.selection);
	alert("tb.selectionStart:"+tb.selectionStart);
   
	// IE
	if (document.selection && (document.selection != 'undefined'))
	{
		var _range = document.selection.createRange();
		var contador = 0;
		while (_range.move('character', -1))
			contador++;
		cursor = contador;
	}
   // FF
	else if (tb.selectionStart >= 0)
		cursor = tb.selectionStart;

   return cursor;
}
function escribeTexto(miCampo,texto){
	//alert(miCampo);
	alert(posicionCursor(miCampo));
	posi=posicionCursor(miCampo);
	if (posi>0) {
		valor=document.getElementById(miCampo).value;
		alert(valor.substr(0,posi-1));
	}
}