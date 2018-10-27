<!--#include file="validoUser.asp"-->
<!--#include file="Funciones.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open ConectaMDB

filtro=request.QueryString("filtro")
if filtro="0" then 'quitar filtro
	'Quitar filtro anterior
	response.Cookies("cookieFiltroW")=""
	filtro="" 'pa que no filtre
end if


ord=request.querystring("ord")
if ord="" then ord="Id"
ord=lcase(ord)
tp=request.querystring("tp")
if tp="" then tp="desc"
tipo=tp
masurl="&ord=" & ord & "&tp=" & tp
condicion=""
if request.form<>"" and filtro<>"" then 'Realizar el filtro de la página
	'Quitar filtro anterior
	response.Cookies("cookieFiltroW")=""
	
	nom=request.form("bnombre")
	if nom<>"" then nom="nombre LIKE '%" & ControlAcentos(quitaApos(nom)) & "%' "
	bape=request.form("bape")
	if bape<>"" then bape="apellidos LIKE '%" & ControlAcentos(quitaApos(bape)) & "%' "
	fadesde=request.Form("fadesde")
	fahasta=request.Form("fahasta")
	if isdate(fadesde) and not isdate(fahasta) then nfalta="(FechaAlta>=" & FechaSQL(fadesde) & ") "
	if not isdate(fadesde) and isdate(fahasta) then nfalta="(FechaAlta<=" & FechaSQL(fahasta) & ") "
	if isdate(fadesde) and isdate(fahasta) then nfalta="(FechaAlta BETWEEN " & FechaSQL(fadesde) & " AND " & fechaSQL(fahasta) & ") "
	bidioma=request.Form("bidioma")
	if bidioma<>"" then
		nidioma="Idioma='" & bidioma & "' "
	end if
	btipo=request.form("btipo")
	if btipo<>"" then ntipo="Peticion=" & btipo & " "
	
	condicion="WHERE EMail<>'' AND "

	if nom<>"" then condicion=condicion & nom & "AND "
	if bape<>"" then condicion=condicion & bape & "AND "
	If nfalta<>"" then condicion=condicion & nfalta & " AND "
	If nidioma<>"" then condicion=condicion & nidioma & " AND "
	If ntipo<>"" then condicion=condicion & ntipo & " AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
	if right(condicion,6)="WHERE " then 'Quitar la condicion
		condicion=""
	end if

	'guardar consulta fija
	response.Cookies("cookieFiltroW")=condicion

end if

condicion=request.Cookies("cookieFiltroW")
if condicion="" then condicion="WHERE EMail<>'' " 'por defecto
cs="SELECT Id,Nombre,Apellidos,Email,Peticion,Confirmada,FechaAlta "
cs=cs & "FROM " & precrs & "FormulariosWeb FormulariosWeb "
cs=cs & condicion
cs=cs & "ORDER BY " & ord & " " & tp
'response.write cs
rs.Open cs, base
hayfichas=false
if not rs.eof then
	hayfichas=true
	dim LosReg
	LosReg=rs.GetRows

	PorPag=50
	TotReg=ubound(losreg,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("P")
	if Pag="" then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag

	RId=0
	RNom=1
	RApe=2
	REMail=3
	RPeti=4
	RConfi=5
	RFAlta=6
end if
rs.close

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'cargar datos la ficha

	cs="SELECT * FROM " & precrs & "FormulariosWeb FormulariosWeb "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		apellidos=rs("apellidos")
		email=rs("email")
		fecha=rs("fechaalta")
		llegada=rs("llegada")
		salida=rs("salida")
		idiomaweb=rs("idioma")
		telefono=rs("telefono")
		FIni=rs("Llegada")
		FFin=rs("Salida")
		adultos=rs("adultos")
		ninos=rs("ninos")
		tipohab=rs("TipoHabitacion")
		regimen=rs("suplementos")
		obs=rs("comentarios")
		peticion=rs("peticion")
		rentcar=rs("rentcar")
		confirmada=rs("confirmada")
	end if
	rs.close

end if 'laid<>0

'Tipos Hab
cs="SELECT Id,TipoHab_es FROM " & precrs & "TiposHabitacion ORDER BY Id"
rs.open cs,base
hayhabis=false
if not rs.eof then
	RegHabis=rs.getrows
	HCodi=0
	HNombre=1
	hayhabis=true
end if 
rs.close

cs="SELECT Id,Suplemento_es FROM " & precrs & "Suplementos ORDER BY Id"
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<html>
<head>
<title>Son Palou</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function pulsada(oEvento){
	var teclaCodigo;
	teclaCodigo = oEvento.keyCode;
	if (teclaCodigo==13) { //tecla intro
		oEvento.keyCode=0
		buscar();
		}
}

function buscar(){
	busco=document.f1.buscalo.value;
	if (busco!=""){
		//Abrir ventana de busqueda
		var vent;
		ancho=400;
		alto=280;
		//centrar
		t=(screen.availHeight/2)-(alto/2);
		l=(screen.availWidth/2)-(ancho/2);
		url="buscado.asp?cualo="+busco+"&pag=<%=MiPag%>";
		vent=open(url,"Resultado","width="+ancho+",height="+alto+",top="+t+",left="+l+",Resizable=yes");
		vent.focus();
	}
}

function filtrar(){
	document.f1.action="<%=MiPag%>?filtro=1";
	document.f1.submit();
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="post">
<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<img src="img/transparente.gif" width="2" height="10"><br />
		<div style="padding-bottom:10px;">Base de Datos: <b><%=ucase(request.Cookies("laBD"))%></b></div>
		<table align='center' width="700">
		<tr><td align='center'>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input name="button32" type='button' style='cursor:pointer; width:75px;' onClick="javascript:document.getElementById('pfiltro').style.visibility='visible';" value='Filtrar Lista'>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input name="button32" type='button' style='cursor:pointer; width:75px;' onClick='javascript:window.location="<%=MiPag%>?filtro=0";' value='Quitar Filtro'>
		</td>
		</tr>
		<!--
		<tr><td height='10'></td></tr>
		<tr><td align="left">Ocultar emails repetidos <input type="checkbox" value="1" name="ocultarepe"></td></tr>-->
		<tr><td height='10'></td></tr>
		</table>            
	<table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8"><img src="img/corners/a_i.gif" alt="" width="8" height="20"></td>
        <td background="img/corners/a_c.gif" class="texto10BLANCO"><div align="center">CLIENTES WEB SON PALOU</div></td>
        <td width="8"><div align="right"><img src="img/corners/a_d.gif" alt="" width="8" height="20"></div></td>
      </tr>
      <tr>
        <td background="img/corners/i.gif">&nbsp;</td>
        <td valign="middle" bgcolor="#f1f1f1">
		
		 <table width='700' border="0" align='center' cellpadding="0" cellspacing="0" bgcolor="#f1f1f1">
          <tr class="cabetabla">
			<%
			flechaId="&nbsp;"
			flechaNombre="&nbsp;"
			flechaApe="&nbsp;"
			flechaEMail="&nbsp;"
			flechaAlta="&nbsp;"
			if tp="asc" then 
				flecha=FlechaDown
				tp="desc"
			else
				Flecha=FlechaUp
				tp="asc"
			end if
			if ord="id" then
				flechaId=Flecha
			end if
			if ord="fechaalta" then
				flechaFecha=Flecha
			end if
			if ord="nombre" then
				flechaNombre=Flecha
			end if
			if ord="apellidos" then
				flechaApe=Flecha
			end if
			if ord="email" then
				flechaEMail=Flecha
			end if
			%>
			<th align='right'>
			<a class='cabetabla2' href="<%=MiPag%>?ord=id&tp=<%=tp%>">Id<%=flechaId%>&nbsp;</a>
			</th>
			<th align='center'>
			<a class='cabetabla2' href="<%=MiPag%>?ord=fechaalta&tp=<%=tp%>">&nbsp;Fecha Alta<%=flechaFecha%></a>
			</th>
			<th align='left'>
			<a class='cabetabla2' href="<%=MiPag%>?ord=nombre&tp=<%=tp%>">&nbsp;Nombre<%=flechaNombre%></a>
			</th>
			<th align='left'>
			<a class='cabetabla2' href="<%=MiPag%>?ord=apellidos&tp=<%=tp%>">&nbsp;Apellidos<%=flechaApe%></a>
			</th>
			<th align='left'>
			<a class='cabetabla2' href="<%=MiPag%>?ord=email&tp=<%=tp%>">&nbsp;EMail<%=flechaEMail%></a>
			</th>
			<th align="center">Tipo</th>
          </tr>
          <%if hayfichas then
			for R=IReg to IReg+PorPag-1
			if R>ubound(losreg,2) then exit for
			miestilo="LineaTabla"%>
          <tr>
		  	<td align="right" class='<%=miestilo%>'>
			<a href="<%=MiPag%>?id=<%=LosReg(RId,r) & masurl & "&P=" & pag%>"><%=LosReg(RId,r)%>&nbsp;</a></td>
			<td align="center" class='<%=miestilo%>'>&nbsp;
			<a href="<%=MiPag%>?id=<%=LosReg(RId,r) & masurl & "&P=" & pag%>">
			<%=verFecha(LosReg(RFAlta,r))%></a></td>
            <td align="left" class='<%=miestilo%>'>&nbsp;
			<a href="<%=MiPag%>?id=<%=LosReg(RId,r) & masurl & "&P=" & pag%>"><%=LosReg(RNom,r)%></a></td>
			<td align="left" class='<%=miestilo%>'>&nbsp;
			<a href="<%=MiPag%>?id=<%=LosReg(RId,r) & masurl & "&P=" & pag%>"><%=LosReg(RApe,r)%></a></td>
			<td align="left" class='<%=miestilo%>'>&nbsp;<%=LosReg(REmail,r)%></td>
			<td align="center" class='<%=miestilo%>'>&nbsp;
			<%if LosReg(RPeti,r) then
				response.write "Reserva"
			else
				response.write "Contacto"
			end if%>
			</td>
          </tr>
	<%next%>
		<tr><td height='25' colspan='6'>
			<b></b>Total Registros: <%=TotReg%></b><br></td></tr>
		<tr>
		  <td align='center' colspan="6"> 
		  	<!--#include file="controlPaginas.asp"-->
		  </td>
		</tr>
	
	<%end if%>
          <tr>
            <td height='25' colspan='6'></td>
          </tr>
		  
        </table>
		</td>
        <td background="img/corners/d.gif"><div align="right"></div></td>
      </tr>
      <tr>
        <td valign="top"><img src="img/corners/b_i.gif" alt="" width="8" height="8"></td>
        <td background="img/corners/b_c.gif">&nbsp;</td>
        <td width="8" valign="top"><div align="right"><img src="img/corners/b_d.gif" alt="" width="8" height="8"></div></td>
      </tr>
    </table>
	</td></tr>
</table>




<div id='pfiltro' style='position:absolute; z-index:10; top:0px; left:0px; width:400px; height:200px; visibility:hidden;'>
<table border="0" cellpadding="0" cellspacing="0" class="tdTabla" width="100%">
  <tr>
    <td width="8"><img src="img/corners/a_i.gif" alt="" width="8" height="20"></td>
    <td background="img/corners/a_c.gif" class="texto10BLANCO"><div align="center">FILTRAR LISTA</div></td>
    <td width="8"><div align="right"><img src="img/corners/a_d.gif" alt="" width="8" height="20"></div></td>
  </tr>
  <tr>
    <td background="img/corners/i.gif" width="8">&nbsp;</td>
	<td valign="top" align="center" width="100%">
		<table width='100%' border='0' cellspacing='2' ALIGN='center' class="texto10BLANCO">
		<tr>
			<td align='right'>Nombre:</td>
			<td align='left'>
				<input type='text' style='width:200px' maxlength='25' name='bnombre' value=''>
			</td>
		</tr>
		<tr>
			<td align='right'>Apellidos:</td>
			<td align='left'>
				<input type='text' style='width:200px' maxlength='25' name='bape' value=''>
			</td>
		</tr>
		<tr>
			<td align="right">Fecha Alta:</td>
			<td align="left">
			<input name="fadesde" type="text" style="width:80px" maxlength="14">&nbsp;hasta &nbsp;
			<input name="fahasta" type="text" style="width:80px" maxlength="14"> (dd/mm/aa)
			</td>
		</tr>
		<tr>
			<td align="right">Tipo Ficha:</td>
			<td align="left">
			<select name="btipo">
				<option value="">Todas</option>
				<option value="-1">Formulario Reserva</option>
				<option value="0">Formulario Contacto</option>
			</select>
			</td>
		</tr>
		<tr>
			<td align="right">Idioma Cliente:</td>
			<td align="left">
			<select name="bidioma">
				<option value="">Todos</option>
				<option value="ES">Español</option>
				<option value="EN">Inglés</option>
				<option value="DE">Alemán</option>
				<option value="NL">Holandés</option>
				<option value="SW">Sueco</option>
			</select>
			Pais:
			<input type='text' style='width:200px' maxlength='25' name='bpais' value=''>
			</td>
		</tr>
		</table>

	</td>
	<td background="img/corners/d.gif" width="8"><div align="right"></div></td>
	</tr>
	<tr>
		<td background="img/corners/i.gif">&nbsp;</td>
		<td height="5"></td>
		<td background="img/corners/d.gif">&nbsp;</td>
	</tr>
	<tr>
		<td background="img/corners/i.gif">&nbsp;</td>
		<td align="center">
		<input type='button' id='botonsA' style='cursor:pointer' onclick="javascript:filtrar();" value='Filtrar'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<input name="button3" type="button" style='cursor:pointer' value="Quitar Filtro" onClick='javascript:window.location="<%=MiPag%>?filtro=0";'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<input name="button3" type="button" style='cursor:pointer' value="Cerrar" onClick="javascript:document.getElementById('pfiltro').style.visibility='hidden';">
	  </td>
		<td background="img/corners/d.gif"><div align="right"></div></td>
    </tr>
	<tr>
    <td valign="top"><img src="img/corners/b_i.gif" alt="" width="8" height="8"></td>
    <td background="img/corners/b_c.gif">&nbsp;</td>
    <td width="8" valign="top"><div align="right"><img src="img/corners/b_d.gif" alt="" width="8" height="8"></div></td>
  </tr>	
  
 </table>
</div>

<div id='panel' style='position:absolute; z-index:10; top:0px; left:0px; width:500px; height:300px; overflow:visible; visibility:hidden;'>
<table border="0" cellpadding="0" cellspacing="0" class="tdTabla" width="100%" align="center">
	<tr>
        <td width="8"><img src="img/corners/a_i.gif" alt="" width="8" height="20"></td>
        <td background="img/corners/a_c.gif" class="texto10BLANCO"><div align="center">FICHA CLIENTE</div></td>
        <td width="8"><div align="right"><img src="img/corners/a_d.gif" alt="" width="8" height="20"></div></td>
      </tr>
  <tr>
	<td background="img/corners/i.gif" width="8">&nbsp;</td>
	<td valign="top" align="center" width="100%">

			<table width='100%' border='0' cellspacing='2' ALIGN='center' class="texto10BLANCO">
			<tr>
				<td align='right'>Id:</td>
				<td align='left'><input type='text' style='width:50px' value='<%=laid%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>Fecha Alta:</td>
				<td align='left'><input type='text' style='width:100px' value='<%=verFecha(fecha)%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>Nombre:</td>
				<td align='left'><input type='text' style='width:250px' value='<%=nombre%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>Apellidos:</td>
				<td align='left'><input type='text' style='width:250px' value='<%=apellidos%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>Teléfono:</td>
				<td align='left'><input type='text' style='width:250px' value='<%=telefono%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>EMail:</td>
				<td align='left'><input type='text' style='width:250px' value='<%=email%>' readonly></td>
			</tr>
			<tr>
				<td align="right">Idioma:</td>
				<td align="left">
				<select name='idiomaweb'>
					<option>No seleccionado</option>
					<option value="es"<%if idiomaWeb="es" then response.write " selected"%>>Castellano</option>
					<option value="en"<%if idiomaWeb="en" then response.write " selected"%>>Inglés</option>
					<option value="de"<%if idiomaWeb="de" then response.write " selected"%>>Alemán</option>
					<option value="nl"<%if idiomaWeb="nl" then response.write " selected"%>>Holandés</option>
					<option value="sw"<%if idiomaWeb="sw" then response.write " selected"%>>Sueco</option>
				</select>
		  </td>
			</tr>
			<tr>
				<td align='right'>F. Llegada:</td>
				<td align='left'><input type='text' style='width:100px' value='<%=llegada%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>F. Salida:</td>
				<td align='left'><input type='text' style='width:100px' value='<%=salida%>' readonly></td>
			</tr>
			<tr>
				<td align='right'>Adultos:</td>
				<td align='left'><input type='text' style='width:50px' value='<%=adultos%>' readonly>
				&nbsp;&nbsp;&nbsp;&nbsp;
				Niños: <input type='text' style='width:50px' value='<%=ninos%>' readonly>
				</td>
			</tr>
			<tr><td align="right">Tipo Habitación:</td>
				<td align="left">
				<select name="tipohab">
					<option value="0">No determinado</option>
					<%if hayhabis then
						for h=0 to ubound(RegHabis,2)
							marca=""
							if tipohab=RegHabis(HaCodi,h) then marca=" selected"%>
						<option value="<%=RegHabis(HCodi,h)%>"<%=marca%>><%=RegHabis(HNombre,h)%></option>
						<%next
					end if%>
				</select>
				</td>
			</tr>
			<tr><td align="right">Tipo Régimen:</td>
				<td align="left">
				<select name="regimen">
					<option value="0">No determinado</option>
					<%if haysuples then
						for h=0 to ubound(RegSuples,2)
							marca=""
							if regimen=RegSuples(SCodi,h) then marca=" selected"%>
						<option value="<%=RegSuples(SCodi,h)%>"<%=marca%>><%=RegSuples(SNombre,h)%></option>
						<%next
					end if%>
				</select>
				</td>
			</tr>
			<tr>
				<td align='right'>Comentarios:</td>
				<td align='left'>
				<textarea name="obs" style="width:250px; height:80px;"><%=obs%></textarea>
				</td>
			</tr>
			<tr><td height="15" align="center" colspan="2"></td></tr>
			<tr>
				<td colspan='2' align="center">
			  <input type='hidden' name='id' value='<%=laid%>'>
			<input name="button3" type="button" style='cursor:pointer' onClick="javascript:document.getElementById('panel').style.visibility='hidden';" value="Cerrar">
			</td>
			</tr>
			</TABLE>

		</td>
		<td background="img/corners/d.gif" width="8"><div align="right"></div></td>
		</tr>
		<tr>
			<td background="img/corners/i.gif">&nbsp;</td>
			<td height="5"></td>
			<td background="img/corners/d.gif">&nbsp;</td>
		</tr>
		<tr>
		<td valign="top"><img src="img/corners/b_i.gif" alt="" width="8" height="8"></td>
		<td background="img/corners/b_c.gif">&nbsp;</td>
		<td width="8" valign="top"><div align="right"><img src="img/corners/b_d.gif" alt="" width="8" height="8"></div></td>
	  </tr>
	</table>		
</div> 


</form>
<script language="JavaScript" type="text/javascript">
	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	l=l-10;
	document.getElementById('panel').style.top=t+"px";
	document.getElementById('panel').style.left=l+"px";
	<%if laid<>0 then %>
			document.getElementById('panel').style.visibility='visible';
	<%end if%>

	//filtro
	t=(screen.availHeight/2)-(parseInt(document.getElementById('pfiltro').style.height)/2); //Pos. superior
	t=t-120; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('pfiltro').style.width)/2); //Pos. izquierda
	l=l-10;
	document.getElementById('pfiltro').style.top=t+"px";
	document.getElementById('pfiltro').style.left=l+"px";
</script>

</body>
</html>
