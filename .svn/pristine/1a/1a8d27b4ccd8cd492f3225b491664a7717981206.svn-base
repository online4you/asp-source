<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/funciones.asp"-->
<!--#include file="includes/datosEmpresa.asp"-->
<!--#include file="includes/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma segun variable lang

est=paClng(request.QueryString("est"))
idh=est
ids=paClng(request.QueryString("ids"))
fini=request.QueryString("fini")
ffin=request.QueryString("ffin")
noches=cdate(ffin)-cdate(fini)
rooms=request.QueryString("rooms")

'datos obligatorios
'est, fini, ffin, lang
'ids opcional (id del servicio)
%><!--#include file="CR_extrasHotel.asp" --><%

set base=server.createobject("ADODB.Connection")
base.Open Conecta
Set rs = server.CreateObject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla servicios
cs="SELECT Id,IdRegimen FROM " & precrs & "RegimenHotel RegimenHotel WHERE CodigoEsta=" & est
rs.open cs,base
HayRegis=false
if not rs.eof then
	RegRegis=rs.getrows
	ReId=0
	ReIdR=1
	hayRegis=true
end if
rs.close

set rs=nothing
base.close
set base=nothing

%>
<script language="javascript" type="text/javascript" src="js/formatoNumero.js"></script>
<script language="javascript" type="text/javascript">

function dolog(obj)
{
	if(typeof(console) == "object") console.log(obj);
}

<%if hayservis then 'pos eso%>
	nhabis=parseInt(parent.document.f1.cuantas.value, 10); //nº de habitaciones
	var totalASumar=0;
	habis=new Array();
	regis=new Array();
	adultos=new Array();
	ninos1=new Array();
	ninos2=new Array();
	guenExtra=new Array();
	
	adultos[0] = 0;
	ninos1[0] = 0;
	ninos2[0] = 0;
	for (x = 1; x <= nhabis; x++)
	{
		habis[x] = eval("parent.document.f1.habi_"+x+".value");
		elregi = eval("parent.document.f1.SU_"+x+".value");
		<%if hayRegis then 'buscar el idregimen
		for r = 0 to ubound(RegRegis,2) %>
		if (elregi == '<%=RegRegis(ReId,r)%>')
		{
			elregi = '<%=RegRegis(ReIdR,r)%>';
		}
		<%next 'r
		end if 'hayRegis%>
		regis[x]=elregi;
		adultos[x]=parseInt(eval("parent.document.f1.HC0_"+x+".value"),10);
		if (eval("parent.document.f1.HC1_"+x)) //hay niños 1
			ninos1[x]=parseInt(eval("parent.document.f1.HC1_"+x+".value"),10);
		else
			ninos1[x]=0;
		if (eval("parent.document.f1.HC2_"+x)) //hay niños 2
			ninos2[x]=parseInt(eval("parent.document.f1.HC2_"+x+".value"),10);
		else
			ninos2[x]=0;
	}
	
	//tx = '<%=objIdioma.getTraduccionHTML("i_textoservis") & "<br/>"%>';
	tx = "";
	
	<%	
	anteservi = 0
	
	for s=0 to ubound(RegServis,2)
		if anteservi<>RegServis(SCodi,s) then
			linea=0
		else
			linea=linea+1
		end if%>
		//comprobar marca anterior
		
		servi = "";
		
		marcada=false;
		if (parent.document.f1.servi_<%=ids%>_<%=linea%>){ 
			if (parent.document.f1.servi_<%=ids%>_<%=linea%>.checked) //estaba marcado
				marcada=true;
		}
		<%if RegServis(SObliga,s) and s=0 then %>
			//tx='<%=objIdioma.getTraduccionHTML("i_texto_obligado") & "<br/>"%>';
		<%end if
		if RegServis(SObliga,s) then %>
			servi = servi + "<input type='hidden' name='servi_<%=ids%>_<%=linea%>' id='servi_<%=ids%>_<%=linea%>' value='1'/>&nbsp;";

		<%else%>
			//servi = servi + "<span class='radio' style='background-position: 0pt 0px;' ></span>";
			servi = servi + "<input ";
			//servi = servi + "class='styled' ";
			servi = servi + " title='javascript:calculaServi(<%=ids%>,<%=linea%>)' type='checkbox' name='servi_<%=ids%>_<%=linea%>' id='servi_<%=ids%>_<%=linea%>' value='1' ";
			servi = servi + " onClick='javascript:calculaServi(<%=ids%>,<%=linea%>)' ";

			if (marcada)
				servi = servi+" checked/>&nbsp;";

			else
				servi = servi+" />&nbsp;";

		<%end if 'obligado%>

		lasHabis="<%=RegServis(SHabis,s)%>";		
		losRegis="<%=RegServis(SRegis,s)%>";
		
		guenaHabi=false;
		guenRegi=false;
		for (x=1; x<= nhabis; x++)
		{
			guenExtra[x] = false;
			
			
			
			
			if (lasHabis.lastIndexOf(habis[x]) != -1){
				guenaHabi = true;
				}
				//alert(losRegis.lastIndexOf(regis[x]));
			if (losRegis.lastIndexOf(regis[x]) != -1){
				guenRegi = true;
			}
			if (guenaHabi && guenRegi){
				guenExtra[x] = true;
			}
		}
		//alert(guenaHabi + ' ' + guenRegi);
		if (guenaHabi && guenRegi)
		{
			guena = true;
			
			tx = tx + servi
		}
		else
		{
			guena = false;
			if (!guenaHabi) mensaje = "<%=objIdioma.getTraduccionHTML("i_habi_nocomplemento") %>";
			if (!guenRegi) mensaje = "<%=objIdioma.getTraduccionHTML("i_regi_nocomplemento") %>";
			if (!guenaHabi && !guenRegi) mensaje = "<%= objIdioma.getTraduccionHTML("i_habiregi_nocomplemento") %>";

			//tx = tx + mensaje + "<br>";
		}
		
		son = 0; //po defecto


		if (guena)
		{
			
				incluiroferta = (<%=RegServis(SIncluidoEnOferta, s)%> == 1);
				descuento = (incluiroferta) ? eval("parent.document.f1.descuentopct_1.value") : 0;
				
		<%pelillas=""
		
		select case RegServis(STipo,s)
			case porpersona %>
				
				tx = tx + '<%=objIdioma.getTraduccionHTML("i_numeroservicios") & "&nbsp;"%>';
				
				<%if RegServis(SCColec,s)<>0 then%>
					tx = tx + "(<%=RegServis(SColectivo,s)%>)";

				<%end if 'colectivo
				if RegServis(SObliga,s) then 'calcula cuantos%>
					for (x=1;x<=nhabis;x++)
					{
						descuento = (incluiroferta) ? eval("parent.document.f1.descuentopct_" + x + ".value") : 0;
						
						if (guenExtra[x]){
						<%if RegServis(SCColec,s)=0 then 'todas las plazas%>
							son += adultos[x]+ninos1[x]+ninos2[x];
						<%else 'depende del colectivo 
							select case RegServis(SOrde,s)
								case 0 'adultos%>
								son += adultos[x];
								<%case 1 'ninos1%>
								son += ninos1[x];
								<%case 2 'ninos2%>
								son += ninos2[x];
							<%end select 'orde
						end if%>
						}
					}
					<%
					nServ=dateDiff("d",cdate(fini),cdate(ffin))
					diasDeServ=0
					for ser=0 to nServ
						if (RegServis(SFini, s)=dateAdd("d",cdate(fini),ser)) then
							diasDeServ=diasDeServ+1
						end if
					next
					%>
					//alert('<%=diasDeServ%>');
					son=son*<%=diasDeServ%>;
					tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' /><span> "+son+"</span>";

				<%else 'no obligado %>
					son = 0;
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' onKeyUp='javascript:calculaServi(<%=ids%>,<%=linea%>);'/>";

				<%end if 'obligado%>
				
				if(descuento > 0)
				{
					tx=tx+"&nbsp;X&nbsp;<b>(<%=formatnumber(RegServis(SPelas,s),2)%> &euro; - " + descuento + "%)</b> ";
				}
				else
				{
					tx=tx+"&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2)%> &euro;</b> ";
				}

			<%case porreserva%>
				son=1;
				tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' />";
				
				if(descuento > 0)
				{
					tx = tx+"1&nbsp;X&nbsp;<b>(<%=formatnumber(RegServis(SPelas,s),2)%> &euro - " + descuento + "%)</b> ";
				}
				else
				{
					tx = tx+"1&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2)%> &euro</b> ";
				}


			<%case pordia%>
				tx = tx + '<%=objIdioma.getTraduccionHTML("i_numerodias") & "&nbsp;"%>';

				son = <%=noches%>;
				
				<%if RegServis(SObliga,s) then %>
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' readonly/>";



				<%else 'no obligado %>
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' onKeyUp='javascript:calculaServi(<%=ids%>,<%=linea%>);'/>";



				<%end if 'obligado %>
				
				if(descuento > 0)
				{
					tx = tx + "&nbsp;X&nbsp;<b>(<%=formatnumber(RegServis(SPelas,s), 2)%> &euro; - " + descuento + " %)</b>";
				}
				else
				{
					tx = tx + "&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s), 2)%></b>";
				}

			<%case porhabitacion%>
				//son=nhabis*<%=noches%>;
				
				// <%=RegServis(SHabis, s)%>
				// <%=rooms%>
				<%
				roomsSplit = split(rooms, ",")
				RegServisSplit = split(RegServis(SHabis, s), ",")
				son=0
				for i = 0 to ubound(roomsSplit)
					for ii = 0 to ubound(RegServisSplit)
						response.Write("//roomsSplit(i)=" & roomsSplit(i) & vbcrlf)
						response.Write("//RegServisSplit(ii)=" & RegServisSplit(ii) & vbcrlf)
						if (Trim(roomsSplit(i))=Trim(RegServisSplit(ii))) then
							son=son+1
						end if
					next
				next

				
				nochesAux=0
				response.write "//RegServis(SFini, s)=" & RegServis(SFini, s) & vbcrlf
				response.write "//RegServis(SFfin, s)=" & RegServis(SFfin, s) & vbcrlf
				response.write "//cdate(fini)=" & cdate(fini) & vbcrlf
				response.write "//cdate(ffin)=" & cdate(ffin) & vbcrlf
				for noche = 1 to noches
					response.write "//DateAdd (d, noche, cdate(fini))=" & DateAdd ("d", noche, cdate(fini))& vbcrlf
					if ( DateAdd ("d", noche, cdate(fini))>=cdate(RegServis(SFini, s)) and DateAdd ("d", noche, cdate(fini))<=cdate(RegServis(SFfin, s))) then 
						nochesAux=nochesAux+1
					end if 
					response.write "//nochesAux=" & nochesAux & vbcrlf
				next
				response.write "//son=" & son & vbcrlf
				%>
				son=<%=son*nochesAux%>;
				tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"'/>";
				
				if(descuento > 0)
				{
					tx = tx + son + "&nbsp;X&nbsp;<b>(<%=formatnumber(RegServis(SPelas,s), 2)%> &euro; - " + descuento + " %)</b>";
				}
				else
				{
					tx = tx + son + "&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s), 2)%>&nbsp;&euro;&nbsp;</b>";
				}

	<%end select%>

		tx = tx + "<input type='hidden' id='descuento_<%=ids%>_<%=linea%>' name='descuento_<%=ids%>_<%=linea%>' value='"+descuento+"' />";
			
		pelas = <%=quitarComa(RegServis(SPelas,s))%>;
		
		importe_descuento = son * pelas * (descuento / 100);
		importe_descuento *= 100;
		importe_descuento = Math.round(importe_descuento);
		importe_descuento /= 100;
		
		tx = tx + "<input type='hidden' id='importedescuento_<%=ids%>_<%=linea%>' name='importedescuento_<%=ids%>_<%=linea%>' value='"+importe_descuento+"' />";
		
		//total = new oNumero(son * pelas);
		total = new oNumero((son * pelas) - importe_descuento);
		
		if (marcada){ //estaba marcado
				tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'>= "+total.formato(2,true)+"</span>";
				totalASumar=total.formato(2,true);
				}

			else{
				tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'></span>";
				totalASumar=0;
				}


		<%if RegServis(SObliga,s) then %>
			tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'>= "+total.formato(2,true)+"</span>";
			totalASumar=total.formato(2,true);

		<%end if%>
		tx=tx+"<input type='hidden' name='servipelas_<%=ids%>_<%=linea%>' id='servipelas_<%=ids%>_<%=linea%>' value='<%=RegServis(SPelas,s)%>'/><br/>";



		} //guena		
	
		<% anteservi = RegServis(SCodi,s)
	next ''s%>
	if (tx=='' || 1==1){
		parent.document.getElementById('complementos').style.visibility='hidden';
		parent.document.getElementById('complementos').style.position='absolute';
		parent.document.getElementById('complementos').style.top='0';
	} else {
		parent.document.getElementById('complementos').style.visibility='visible';
		parent.document.getElementById('complementos').style.position='relative';
		parent.document.getElementById('complementos').style.top='0';
	}
	
	//alert (tx);
	//alert (totalASumar);
	//alert ('inner_<%=ids%>');
	parent.document.getElementById('inner_<%=ids%>').innerHTML = tx ;
	parent.document.getElementById('importeExtras').value = totalASumar ;
	parent.document.getElementById('reservaButton').style.visibility = 'visible';
<%
	end if ''hayServis
%>
</script>
<%set objIdioma=nothing%>