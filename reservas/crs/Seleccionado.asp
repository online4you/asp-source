<script language="javascript">
function cambioAnyo(esa){
	//Guardar en cookie el anyo
	SetCookie("anyo",esa.value,null,"/");
	//recarga la pagina y substituir si lleva el anyo
	url=self.location.href;
	pos=url.indexOf('any='); //a�o actual
	if (pos>-1) {
		anterior=url.substring(pos,pos+8);
		url=url.replace(anterior,"any="+esa.value)
	}
	pos=url.indexOf('cp='); //compara a�o
	if (pos>-1) {
		anterior=url.substring(pos,pos+7);
		url=url.replace(anterior,"cp="+(parseInt(esa.value,10)-1)); //un a�o menos
	}
	window.location.href=url;
}

function cambioTarifa(esa){
	//Guardar en cookie el anyo
	SetCookie("tarifa",esa.value,null,"/");
	//recarga la pagina
	recargaFrame(self.name);
}

function elIntro(oEvento){
     var iAscii;
     if (oEvento.keyCode)
         iAscii = oEvento.keyCode;
     else if (oEvento.which)
         iAscii = oEvento.which;

     if (iAscii == 13) buscaHotel();
}

function CambioHotel(lista){
	document.location="<%=MiPag%>?est="+lista.value+"<%=masquery%>";
}

function buscaHotel(){
	busco=document.f1.bhnombre.value;
	if (busco!=""){
		//Abrir ventana de busqueda
		var vent;
		ancho=400;
		alto=250;
		//centrar
		t=(screen.availHeight/2)-(alto/2);
		l=(screen.availWidth/2)-(ancho/2);
		url="buscohotel.asp?cualo="+busco+"&pag=<%=MiPag%>";
		vent=window.open(url,"Resultado","width="+ancho+",height="+alto+",top="+t+",left="+l);
	}

}
function cargaEmpresa(){
	document.f1.action="cargaEmpresa.asp"
	document.f1.submit();
}
function enfoca() {
	$("bhnombre").focus();
}
</script>
<table cellspacing='0' cellpadding="0" border="0" id='laseleccion'>
<tr><td align="right"><b><%=ucase(objIdioma.getTraduccionHTML("i_anyo"))%>:</b></td>
	<td align="left" colspan="2">
		<select name='HAnyo' onchange="Javascript:cambioAnyo(this);">
		<option value="<%=anyo-1%>"><%=anyo-1%></option>
		<option value="<%=anyo%>" selected><%=anyo%></option>
		<option value="<%=anyo+1%>"><%=anyo+1%></option>
		</select>
	</td>
	<td align="left" colspan="3"></td>
</tr>
<tr>
	<td align='right'><%=objIdioma.getTraduccionHTML("i_seleccionar")%>:</td>
	<td align='left'>
		<select name='HSeleccionado' onchange="Javascript:CambioHotel(this);" style="width:230px">
		<%if hayHoteles then
			for h=0 to ubound(RegHoteles,2)
				marca=""
				select case RegHoteles(HEstado,h)
					case noventa
						nestado=" (" & objIdioma.getTraduccionHTML("i_noventa") & ")"
					case onrequest
						nestado=" (On Request)"
					case online
						nestado=" (On Line)"
				end select
				if RegHoteles(HCodi,h)=clng(est) then marca=" selected"%>
				<option value='<%=RegHoteles(HCodi,h)%>'<%=marca%>><%=transformaHTML(RegHoteles(HNombre,h) & nestado)%></option>
			<%next
		end if%>
		</select>
	</td>
	<td width="20"></td>
	<td align='left'>
		<%=objIdioma.getTraduccionHTML("i_buscahotel")%>:
		<input type="text" name="bhnombre" id='bhnombre' style="width:110px;" maxlength="25" onKeyDown="javascript:elIntro(event);">
	</td>
	<td align="left">
		&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="boton86" value="<%=objIdioma.getTraduccionHTML("i_buscar")%>" onclick='javascript:buscaHotel();'>
	</td>
</tr>
</table>
