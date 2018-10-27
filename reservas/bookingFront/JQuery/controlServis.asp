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
cs="SELECT Id,IdRegimen FROM RegimenHotel WHERE CodigoEsta=" & est
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
<%if hayservis then 'pos eso%>
	nhabis=parseInt(parent.document.f1.cuantas.value,10); //nº de habitaciones
	habis=new Array();
	regis=new Array();
	adultos=new Array();
	ninos1=new Array();
	ninos2=new Array();
	guenExtra=new Array();
	for (x=1;x<=nhabis;x++){
		habis[x]=eval("parent.document.f1.habi_"+x+".value");
		elregi=eval("parent.document.f1.SU_"+x+".value");
		<%if hayRegis then 'buscar el idregimen
		for r=0 to ubound(RegRegis,2)%>
		if (elregi=='<%=RegRegis(ReId,r)%>'){
			elregi='<%=RegRegis(ReIdR,r)%>';
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
	tx='<%=objIdioma.getTraduccionHTML("i_textoservis") & "<br/>"%>';
	<%
	anteservi=0
	for s=0 to ubound(RegServis,2)
		if anteservi<>RegServis(SCodi,s) then
			linea=0
		else
			linea=linea+1
		end if%>
		//comprobar marca anterior
		marcada=false;
		if (parent.document.f1.servi_<%=ids%>_<%=linea%>){ 
			if (parent.document.f1.servi_<%=ids%>_<%=linea%>.checked) //estaba marcado
				marcada=true;
		}
		<%if RegServis(SObliga,s) and s=0 then %>
			tx='<%=objIdioma.getTraduccionHTML("i_texto_obligado") & "<br/>"%>';
		<%end if
		if RegServis(SObliga,s) then %>
			tx=tx+"<input type='hidden' name='servi_<%=ids%>_<%=linea%>' id='servi_<%=ids%>_<%=linea%>' value='1'/>&nbsp;";
		<%else%>
			tx=tx+"<input type='checkbox' name='servi_<%=ids%>_<%=linea%>' id='servi_<%=ids%>_<%=linea%>' value='1' style='border:none' onclick='javascript:calculaServi(<%=ids%>,<%=linea%>);'";
			if (marcada)
				tx=tx+" checked/>&nbsp;";
			else
				tx=tx+" />&nbsp;";
		<%end if 'obligado%>

		lasHabis="<%=RegServis(SHabis,s)%>";
		losRegis="<%=RegServis(SRegis,s)%>";
		guenaHabi=false;
		guenRegi=false;
		for (x=1;x<=nhabis;x++){
			guenExtra[x]=false;
			if (lasHabis.lastIndexOf(habis[x])!=-1)
				guenaHabi=true;
			if (losRegis.lastIndexOf(regis[x])!=-1)
				guenRegi=true;
			if (guenaHabi && guenRegi)
				guenExtra[x]=true;
		}
		if (guenaHabi && guenRegi){
			guena=true;
		}else{
			guena=false;
			if (!guenaHabi) mensaje="<%=objIdioma.getTraduccionHTML("i_habi_nocomplemento")%>";
			if (!guenRegi) mensaje="<%=objIdioma.getTraduccionHTML("i_regi_nocomplemento")%>";
			if (!guenaHabi && !guenRegi) mensaje="<%=objIdioma.getTraduccionHTML("i_habiregi_nocomplemento")%>";
			tx=mensaje+"<br>";
		}
		son=0; //po defecto
		if (guena){

		<%pelillas=""
		select case RegServis(STipo,s)
			case porpersona%>
				tx=tx+'<%=objIdioma.getTraduccionHTML("i_numeroservicios") & "&nbsp;"%>';
				<%if RegServis(SCColec,s)<>0 then%>
					tx=tx+"(<%=RegServis(SColectivo,s)%>)";
				<%end if 'colectivo
				if RegServis(SObliga,s) then 'calcula cuantos%>
					for (x=1;x<=nhabis;x++){
						if (guenExtra[x]){
						<%if RegServis(SCColec,s)=0 then 'todas las plazas%>
							son=adultos[x]+ninos1[x]+ninos2[x];
						<%else 'depende del colectivo 
							select case RegServis(SOrde,s)
								case 0 'adultos%>
								son=adultos[x];
								<%case 1 'ninos1%>
								son=ninos1[x];
								<%case 2 'ninos2%>
								son=ninos2[x];
							<%end select 'orde
						end if%>
						}
					}
					tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' /><span> "+son+"</span>";
				<%else 'no obligado %>
					son=0;
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' onKeyUp='javascript:calculaServi(<%=ids%>,<%=linea%>);'/>";
				<%end if 'obligado%>
				tx=tx+"&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2)%>&nbsp;&euro;&nbsp;</b>";
			
			<%case porreserva%>
				son=1;
				tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' />";
				tx=tx+"1&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2)%>&nbsp;&euro;&nbsp;</b>";
			
			<%case pordia%>
				tx=tx+'<%=objIdioma.getTraduccionHTML("i_numerodias") & "&nbsp;"%>';
				son=<%=noches%>;
				<%if RegServis(SObliga,s) then %>
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' readonly/>";
				<%else 'no obligado %>
					tx=tx+"<input type='text' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"' style='width:20px;' onKeyUp='javascript:calculaServi(<%=ids%>,<%=linea%>);'/>";
				<%end if 'obligado %>
				tx=tx+'&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2) & "&nbsp;&euro;&nbsp;</b>"%>';
			
			<%case porhabitacion%>
				son=1;
				tx=tx+"<input type='hidden' name='cuantos_<%=ids%>_<%=linea%>' id='cuantos_<%=ids%>_<%=linea%>' value='"+son+"'/>";
				tx=tx+"1&nbsp;X&nbsp;<b><%=formatnumber(RegServis(SPelas,s),2)%>&nbsp;&euro;&nbsp;</b>";
			
		<%end select%>

		pelas=<%=quitarComa(RegServis(SPelas,s))%>;
		total=new oNumero(son*pelas);
		if (marcada) //estaba marcado
				tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'>= "+total.formato(2,true)+"</span>";
			else
				tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'></span>";

		<%if RegServis(SObliga,s) then %>
			tx=tx+"<span id='totalservi_<%=ids%>_<%=linea%>'>= "+total.formato(2,true)+"</span>";
		<%end if%>
		tx=tx+"<input type='hidden' name='servipelas_<%=ids%>_<%=linea%>' id='servipelas_<%=ids%>_<%=linea%>' value='<%=RegServis(SPelas,s)%>'/><br/>";
		} //guena		
	
		<%anteservi=RegServis(SCodi,s)
	next ''s%>
	parent.document.getElementById('inner_<%=ids%>').innerHTML=tx;
	//alert(tx);

<%end if ''hayServis%>
</script>
<%set objIdioma=nothing%>