<script language="JavaScript">

function palFrameIndi(quehabi, queTipoHabi){
	document.getElementById("espera_"+quehabi+'_'+queTipoHabi).style.display="block";
	document.getElementById("priceToload").value="verimporte_"+quehabi+'_'+queTipoHabi;
	document.getElementById("promoToLoad").value="Promo_"+quehabi+'_'+queTipoHabi;
	document.getElementById("esperaToload").value="espera_"+quehabi+'_'+queTipoHabi;
	document.getElementById("porPersonaToload").value="porPersona_"+quehabi+'_'+queTipoHabi;
	document.getElementById("verimporte_"+quehabi+'_'+queTipoHabi).innerHTML="";
	palFrame(quehabi, queTipoHabi);
	
	//setText(document.getElementById("verimporte_"+quehabi+'_'+queTipoHabi),getText(document.getElementById("verimporte_"+quehabi)));
 

}

function getText(n)
{
  if('textContent' in n) {
    return n.textContent;
  } else if('innerText' in n) {
    return n.innerText;
  } else {
    // Call a custom collecting function, throw an error, something like that.
  }
}
function setText(n,txt)
{
  if('textContent' in n) {
    n.textContent=txt;
  } else if('innerText' in n) {
    n.innerText=txt;
  } else {
    // Call a custom collecting function, throw an error, something like that.
  }
}
function getCheck (cuala,codiRegi,queTipoHabi, e) {
	if(e.checked==true && document.getElementById("working").value==''){
		cambiaRegiIndi(cuala,codiRegi,queTipoHabi);}
	else{
		e.checked=false;
		document.getElementById("radio_"+cuala+"_0").checked=true;}
}
function cambiaRegiIndi(cuala,codiRegi,queTipoHabi) {
	eval(document.getElementById("href_"+cuala+"_"+queTipoHabi).title);
	//buscar nombre suple
	nombreRegi=""
	for (s=0;s<suplecodi.length;s++){
		if (suplecodi[s]==codiRegi){
			nombreRegi=suplenombre[s];
			break;
		}
	}

	var lista=$("#sRegi_"+cuala+" span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=nombreRegi; //poner la seleccion en el select
	var lista=$("#sRegi_"+cuala+'_'+queTipoHabi+" span.titulo_lista");
	for (i=0;i<lista.length;i++)
		lista[i].innerHTML=nombreRegi; //poner la seleccion en el select*/
	
	eval("document.f1.SU_"+cuala+".value="+codiRegi);
	eval("document.f1.nombresuple_"+cuala+".value='"+nombreRegi+"'");
	eval("document.f1.SU_"+cuala+"_"+queTipoHabi+".value="+codiRegi);
	eval("document.f1.nombresuple_"+cuala+"_"+queTipoHabi+".value='"+nombreRegi+"'");
	
	palFrameIndi(cuala,queTipoHabi);
	
	<% if hayservis then %>
		cargaServi();
	<% end if %>
}
function setOferta(oferta, capa ) {
	if (oferta!='0'){
		document.getElementById(capa + '_blank').style.display="none";
		document.getElementById(capa).style.display="block";
		
	}
}

</script>
<%if hayhabis then
	 radioselected=""
	  noches=dateDiff("d",fini,ffin)%>
	  
	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <%if (hh=1) then%>		
			<tr>
				<td class="PhotelCeldaCabecera"><div class="PhotelTextoCabecera">&nbsp;</div></td>
				<td class="PhotelCeldaCabecera"><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_tipohab")%> </div></td>
				<td class="PhotelCeldaCabecera"><div class="PhotelTextoCabecera" ><%=objIdioma.getTraduccionHTML("i_regimen")%> </div></td>
				<td class="PhotelCeldaCabecera"><div class="PhotelTextoCabecera" ><%=objIdioma.getTraduccionHTML("i_precioNoche")%> </div></td>
				<td class="PhotelCeldaCabecera"><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_importetotal")%> </div></td>
				<td  class="PhotelCeldaCabecera" align="center"><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_seleccione")%> </div></td>
			</tr>
		<%else%>
			<tr style="visibility: hidden; height: 0px;">
				<td ><div class="PhotelTextoCabecera">&nbsp;</div></td>
				<td ><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_tipohab")%> </div></td>
				<td ><div class="PhotelTextoCabecera" ><%=objIdioma.getTraduccionHTML("i_regimen")%> </div></td>
				<td ><div class="PhotelTextoCabecera" ><%=objIdioma.getTraduccionHTML("i_precioNoche")%> </div></td>
				<td ><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_importetotal")%> </div></td>
				<td   align="center"><div class="PhotelTextoCabecera"><%=objIdioma.getTraduccionHTML("i_seleccione")%> </div></td>
			</tr>

		<%end if%>
				
		<%		
		if (hh=1)then
						adultostmp=adultos
						ni1tmp=ninos
						ni2tmp=ninos2
						bebestmp=bebes
					end if
					if (hh=2) then
						adultostmp=adultos_2
						ni1tmp=ninos_2
						ni2tmp=ninos2_2
						bebestmp=bebes_2
					end if
					if (hh=3) then
						adultostmp=adultos_3
						ni1tmp=ninos_3
						ni2tmp=ninos2_3
						bebestmp=bebes_3
					end if
					if (hh=4) then
						adultostmp=adultos_4
						ni1tmp=ninos_4
						ni2tmp=ninos2_4
						bebestmp=bebes_4
					end if
					
		if (adultostmp<>0) then strOcupaci=adultostmp & " " & objIdioma.getTraduccionHTML("i_adultos") 
		if (ni1tmp+ni2tmp<>0)then strOcupaci=strOcupaci & " + " & ni1tmp+ni2tmp & " " & objIdioma.getTraduccionHTML("i_ninos") 
		if (bebestmp<>0)then strOcupaci=strOcupaci & " + " & bebestmp & " " & objIdioma.getTraduccionHTML("i_bebes") 

%>
		<tr>
		<td colspan="6">
		<div>

		<span style="color: #919191;font-size: 13px;"><b><%= objIdioma.getTraduccionHTML("i_habitacion") & ": " & hh & ": "%></b><%=strOcupaci%></span></div>
		<br>
		</td>
		</tr>

		<!--
		<tr>
		<td colspan="6">
		<div>

		<span style="color: #919191;font-size: 13px;"><b><%= objIdioma.getTraduccionHTML("i_habitacion") & ": " & hh & ": "%></b><%=replace(request.QueryString("ocupacion_" & hh),"ñ","&ntilde;")%></span></div>
		<br>
		</td>
		</tr>
	-->
	  <%for h=0 to ubound(RegHabis,2)
				
				
					if (hh=1)then
						adultostmp=adultos
						ni1tmp=ninos
						ni2tmp=ninos2
						bebestmp=bebes
					end if
					if (hh=2) then
						adultostmp=adultos_2
						ni1tmp=ninos_2
						ni2tmp=ninos2_2
						bebestmp=bebes_2
					end if
					if (hh=3) then
						adultostmp=adultos_3
						ni1tmp=ninos_3
						ni2tmp=ninos2_3
						bebestmp=bebes_3
					end if
					if (hh=4) then
						adultostmp=adultos_4
						ni1tmp=ninos_4
						ni2tmp=ninos2_4
						bebestmp=bebes_4
					end if
					

				maxPlazas=adultostmp+ni1tmp+ni2tmp
				if (RegHabis(HaCunaOcupa,h)=1) then
					maxPlazas=maxPlazas+bebestmp
				end if
				
				if (radioselected="" and maxPlazas<=RegHabis(HaCapMax,h)) then 
					radioselected="checked"
				else 
					radioselected=""
				end if
radioselected=""
				tdStyle="style=""border-bottom: 1px solid #919191;"""
				myLink=""
				nombreRegiAux=""
				tRegAux=""
				nombreRegiInit=""
				tRegInit=""
				for s=0 to ubound(RegSuples,2)
					if (RegSuples(SHabi,s)=0 or RegSuples(SHabi,s)=RegHabis(HaCodi,h)) then 
						if (nombreRegiInit="") then
							tRegInit=RegSuples(SCodi,s)
							nombreRegiInit=RegSuples(SNombre,s) 
						end if
						if (tReg=RegSuples(SCodi,s)) then
							tRegAux=RegSuples(SCodi,s)
							nombreRegiAux=RegSuples(SNombre,s) 
						end if
						myLink= myLink & "<a href='javascript:cambiaRegiIndi(" & hh & "," & RegSuples(SCodi,s)  & "," & h & ")'>" & RegSuples(SNombre,s) & "</a>"
					end if
				next
				'response.write "request.querystring(tr)=" & request.querystring("tr") & "<br>"
				if ((request.querystring("tr")="" or tRegAux<>"") and (maxPlazas<=RegHabis(HaCapMax,h) and maxPlazas>=RegHabis(HaCapMin,h)) and (adultostmp<=RegHabis(HaAduMax,h) and adultostmp>=RegHabis(HaAduMin,h)) and ((ni1tmp+ni2tmp)<=RegHabis(HaNinMax,h))) then 
					if (request.querystring("tr")="") then
						tRegAux=tRegInit
						nombreRegiAux=nombreRegiInit
					end if				
					%>

								
					<tr >
						<td <%=tdStyle%>>
						<div class="PhotelTexxtoFila" style="text-align: center;">
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<div id="Promo_<%=hh%>_<%=h%>" style="display:none; float: right; width: 50px; height: 33px;background-image: url('css/img/Promo_<%=lang%>.png'); background-position: right top; background-repeat: no-repeat;">&nbsp;</div>
									<div id="Promo_<%=hh%>_<%=h%>_blank" style="display:block; float: right; width: 50px; height: 33px; background-position: right top; background-repeat: no-repeat;">&nbsp;</div>
								</td>
								<td>
									<span tyle="font-size: 11px;" >&nbsp;</span>	
								</td>
							</tr>
							</table>

						
						
						</div></td>
						<td <%=tdStyle%>>
							
							<!--<a id="href_<%=hh%>_<%=h%>" name="datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>)" href="javascript:datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>);palFrameIndi(<%=hh%>,<%=h%>);"> 
							<%=RegHabis(HaNombre,h)%></a>-->
							<div id="href_<%=hh%>_<%=h%>" title="datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>)" class="PhotelTexxtoFila" style="width: 150px;"><span style="font-size: 11px;" >
							<%=RegHabis(HaNombre,h)%>
							</span></div>
						</td>	  
						<td <%=tdStyle%>>

							  <div id='sRegi_<%=hh%>_<%=h%>' class='capa_lista'> <span class='titulo_lista'><%=nombreRegiAux%></span> 
								<div id='listaRegis_<%=hh%>_<%=h%>' class="lista">
								<%=myLink%>
								</div>
								<input type="hidden" name="SU_<%=hh%>_<%=h%>" id="SU_<%=hh%>_<%=h%>" value='<%=tRegAux%>' />
								<input type="hidden" name="nombresuple_<%=hh%>_<%=h%>" id='nombresuple_<%=hh%>_<%=h%>' value="<%=nombreRegiAux%>">
							  </div>
							  <!--sRegi_-->
							
						</td >
						<!--#include file="Frame_calculoHabiIndi.asp"-->
						<!--<td <%=tdStyle%>>					
							<div class="PhotelTexxtoFila">
								<span style="font-size: 11px" id='porPersona_<%=hh%>_<%=h%>'></span>
							</div>
						</td>
						<td <%=tdStyle%>>
							 <div class="PhotelTexxtoFila">
								<img id='espera_<%=hh%>_<%=h%>' style="display: block" src="img/espera.gif" width="16" height="16" class="espera"/>
								<span tyle="font-size: 11px" id='verimporte_<%=hh%>_<%=h%>'></span>
							</div>
						</td>-->

						
						<td align="center">
							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>&nbsp;
								</td>
								<td>
									<input id="radio_<%=hh%>_<%=h%>" type="radio" class="styled"  name="radio_<%=hh%>" title="getCheck(<%=hh%>,document.getElementById('SU_<%=hh%>_<%=h%>').value,<%=h%>,document.getElementById('radio_<%=hh%>_<%=h%>'))" <%=radioselected%> >
								</td>
							</tr>
							</table>
					<tr>
				<%else%>
					<tr>
						<td colspan="6" height="0px">
							<div <%=mostrarTodasLasHabis%>>

								<div id="href_<%=hh%>_<%=h%>" title="datosHabi(<%=hh%>,<%=RegHabis(HaCodi,h)%>)" style="font-size: 11px;"><span tyle="font-size: 11px;" >
									<%=RegHabis(HaNombre,h)%>
									</span>
								</div>
							  <div id='sRegi_<%=hh%>_<%=h%>'> <span class='titulo_lista'><%=nombreRegi%></span> 
								<div id='listaRegis_<%=hh%>_<%=h%>' ></div>
								<input type="hidden" name="SU_<%=hh%>_<%=h%>" id="SU_<%=hh%>_<%=h%>" value='<%=tReg%>' />
								<input type="hidden" name="nombresuple_<%=hh%>_<%=h%>" id='nombresuple_<%=hh%>_<%=h%>' value="<%=nombreRegi%>">
							  </div>
							  <!--sRegi_-->
							
							<div style="font-size: 11px;">
								<span style="font-size: 11px" id='porPersona_<%=hh%>_<%=h%>'></span>
							</div>
							 <div style="font-size: 11px;" >
								<img id='espera_<%=hh%>_<%=h%>' style="display: block" src="img/espera.gif" width="16" height="16" class="espera"/>
								<span tyle="font-size: 11px" id='verimporte_<%=hh%>_<%=h%>'></span>
									<input id="radio_<%=hh%>_<%=h%>" type="radio" class="styled"  name="radio_<%=hh%>" title="getCheck(<%=hh%>,document.getElementById('SU_<%=hh%>_<%=h%>').value,<%=h%>,document.getElementById('radio_<%=hh%>_<%=h%>'))" <%=radioselected%> >
									<div id="Promo_<%=hh%>_<%=h%>_blank" style="display:none; float: right; width: 50px; height: 33px;background-image: url('css/img/Promo.png'); background-position: right top; background-repeat: no-repeat;">&nbsp;</div>
									<div id="Promo_<%=hh%>_<%=h%>" style="display:none; float: right; width: 50px; height: 33px;background-image: url('css/img/Promo.png'); background-position: right top; background-repeat: no-repeat;">&nbsp;</div>
							</div>

							</div>
							
						</td>
					<tr>
				<%end if%>
	  <%next%>
	  </table>
	  </div>
 <% end if 'hayhabis%>
