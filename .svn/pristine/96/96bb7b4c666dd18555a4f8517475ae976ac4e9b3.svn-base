<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

if not esAdmin then 'Usuario con hotel
	busco="WHERE "
	buenos=split(request.Cookies("HotelBoss"),";")
	for b=0 to ubound(buenos)
		if isnumeric(buenos(b)) then
			busco=busco & "CodigoEsta=" & buenos(b) & " OR "
		end if
	next
	busco=left(busco,len(busco)-4)
else
	busco="" 'es administrado saca todos los hoteles
end if

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

if est="" and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if

if request.Form<>"" then
	fini=request.Form("fechai")
	ffin=request.Form("fechaf")
	if not isdate(fini) or not isdate(ffin) then
		errorfecha="fechas incorrectas"
	else 'buscar
		fini=cdate(fini)
		ffin=cdate(ffin)
		cs="SELECT CodigoEsta,Nombre,CodigoHab,Dia,Cupo "
		cs=cs & "FROM " & precrs & "Establecimientos Establecimientos INNER JOIN " & precrs & "Cupos Cupos "
		cs=cs & "ON Establecimientos.CodigoEsta=Cupos.CodigoEsta "
		cs=cs & "WHERE Estado=2 AND Cupo<>0 AND (Dia BETWEEN " & FechaMySQL(fini)
		cs=cs & " AND " & FechaMySQL(ffin)
		
	
	end if
end if



set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style></head>
<script language="javascript">
function Modificar(){
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu&hotel=<%=hotel%>";
	document.f1.submit();
}
function SinFiltro(){
	window.location="<%=MiPag%>?est=<%=est%>&sf=si";
}
function verReserva(esa){
	window.open("verReserva.asp?id="+esa);
}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>?est=<%=est%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr><td align='left'>
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" value='&nbsp;Filtrar Listado&nbsp;' onclick="javascript:document.getElementById('filtro').style.visibility='visible';">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='&nbsp;Borrar Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">LISTA DE RESERVAS </div></td></tr>
  <tr><td valign="bottom" class="tdTabla">
	
      <table width='652' border="0" align='center' cellpadding="0" cellspacing="0" class="tdTabla">
      <tr class='cabetabla'>
        <th>&nbsp;</th>
        <th>Reserva</th>
		<%if hotel=0 then%>
			<th align='left' class="colu_par">Hotel</th>
		<%end if%>
        <th align='center'>F.Reserva</th>
        <th align='center'>F.Llegada</th>
        <th align='center'>F.Salida</th>
        <th align='left' class="colu_par">Apellidos</th>
        <th align='left' class="colu_par">Nombre</th>
        <th align='right'>Importe</th>
        <th align='center'>Confir.</th>
      </tr>
      <%if haylista then
	for R=IReg to IReg+PorPag-1
		if R>ubound(RegLista,2) then exit for%>
      <tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
          <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
        </td>	  <td align="center" width='40' class='<%=laColu(1)%>'> <a href='<%=MiPag%>?est=<%=est%>&id=<%=RegLista(RCodi,r)%>&p=<%=pag%>&filtro=<%=usafiltro%>'><%=RegLista(RCodi,r)%></a> </td>
		<%if hotel="0" then
			for h=0 to ubound(RegHoteles,2)
				if RegHoteles(HCodi,h)=RegLista(REsta,r) then%>
					<td align="left" class='<%=laColu(0)%>' ><%=RegHoteles(HNombre,h)%> </td>
				<%end if
			next 'h
		end if%>
        <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RAlta,r))%> </td>
        <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFIni,r))%> </td>
        <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFFin,r))%> </td>
        <td align="left" class='<%=laColu(0)%>' > <%=RegLista(RApe,r)%>&nbsp;</td>
        <td align="left" class='<%=laColu(0)%>' > <%=RegLista(RNombre,r)%>&nbsp;</td>
        <td align="right" class='<%=laColu(0)%>' > <%=formatnumber(RegLista(RPelas,r),2)%></td>
        <td align="center" class='<%=laColu(0)%>' >
          <%if RegLista(RConfi,r) then 'COnfirmada
			response.write "S&iacute;"
		else
			response.write "No"
		end if%>
        </td>
      </tr>
      <%
	next
end if%>
      <tr>
        <td height='10' colspan='10'>    
      </tr>
      <tr>
        <td align='center' colspan="10">
          <%if pag=1 or pag="" then%>
          <%=FlechaLeft%>P&aacute;gina Anterior
          <%else%>
          <a href="<%=MiPag%>?est=<%=est%>&P=<%=Pag-1%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>"><%=FlechaLeft%>P&aacute;gina Anterior</a>
          <%end if%>
&nbsp;&nbsp;&nbsp;<%=Pag%>/<%=MaxP%>&nbsp;&nbsp;&nbsp;
      <%if pag=MaxP or MaxP=1 then%>
      P&aacute;gina Siguiente<%=FlechaRight%>
      <%else%>
      <a href="<%=MiPag%>?est=<%=est%>&P=<%=Pag+1%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>">P&aacute;gina Siguiente<%=FlechaRight%></a>
      <%end if%>
        </td>
      </tr>
    </table></td></tr>
</table></td></tr>
</table>

<div id='panel' style='position:absolute; z-index:10; top:100px; left:200px; width:500px; height:400px; visibility:hidden; overflow:visible; background-color:#F2F2F2' class='texto10BLANCO'>
<table width="100%" height="71" border="0" cellpadding="0" cellspacing="0">
  <tr><td background="img/corners/a_c.gif">
		<table align='center' width='100%' border='0' cellpadding="0" cellspacing="1">
		<tr>
			<td width="33%">&nbsp;</td>
			<td width='33%' align='center'><div align="center" class="style1">RESERVA</div>
			</td>
			<td width='33%' align='right'><input name='cierre2' type='button' value='X Cerrar' style='cursor:pointer; height:14; margin-top:2' onclick="javascript:document.getElementById('panel').style.visibility='hidden';">
			</td>
		</tr>
		</table>
	</td></tr>
  <tr><td class="tdTabla">

      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr class="CabeTabla">
          <th align='left' class="colu_par">Habitaciones</th>
          <th align='left' class="colu_par">Personas</th>
          <th align='left' class="colu_par">Suplementos</th>
        </tr>
        <%if hayhabis then
	for h=0 to ubound(RegHabis,2)%>
        <tr>
          <td align='left'> <%=RegHabis(HaCanti,h)%>&nbsp;-&nbsp;<%=RegHabis(HaNombre,h)%> </td>
          <td align='left'>
            <%
			'for t=0 to ubound(RegColec,2)
				'response.write "Colectivo: " & RegColec(ColCodi,t) & " - " & t & " " & RegColec(CNombre,t) & " Orde:" & RegColec(ColOrde,t) & "<br>"
			'next
		if RegHabis(HaAdultos,h)<>0 then
			response.write RegColec(CNombre,0) & ":" & RegHabis(HaAdultos,h) & "<br>"
		end if
		if RegHabis(HaBebes,h)<>0 then
			response.write "Beb&eacute;s:" & RegHabis(HBebes,h) & "<br>"
		end if
		if RegHabis(HaNinos1,h)<>0 then
			response.write RegColec(CNombre,1) & ":" & RegHabis(HaNinos1,h) & "<br>"
		end if
		if RegHabis(HaNinos2,h)<>0 then
			response.write RegColec(CNombre,2) & ":" & RegHabis(HaNinos2,h) & "<br>"
		end if
		%>
          </td>
          <td align='left'>
            <%
		suples=RegHabis(HaSuples,h)
		if suples<>"" then 'Buscar nombre suplementos
			tsuples=split(suples,";")
			for ts=0 to ubound(tsuples)-1 'el ultimo est&aacute; en blanco
				'buscar el nombre del suplemento
				if haysuples then
					for s=0 to ubound(RegSuples,2)
						if RegSuples(SCodi,s)=clng(tsuples(ts)) then
							response.write RegSuples(SNombre,s) & "<br>"
						end if
					next 's
				end if
			next 'ts
		end if 'suples<>""
		%>
          </td>
        </tr>
        <%if h<>ubound(RegHabis,2) then 'Si no es la ultima pongo linea%>
        <tr>
          <td colspan='3'><hr size='1'></td>
        </tr>
        <%end if
	next 'Reghabis
end if 'hay Habis%>
        <tr>
          <td colspan='3' height="10"></td>
        </tr>
      </table>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr>
          <td align='left' colspan="2"> Cod. Reserva: <%=laid%> </td>
          <td align='left' colspan="2"><b>
		  	<%if idcliente<>0 then%>
			   Id Ficha: <%=idcliente%>
			  <%else%>
			  	Cod. Amigo: <%=idamigo%>
			 <%end if%>
			 </b>
			</td>
        </tr>
        <tr>
          <td align='left'> F. Reserva: <%=VerFecha(falta)%> </td>
          <td align='left'> F. Llegada
              <input type='text' value="<%=VerFecha(fini)%>" size='9' name='fllegada' readonly class="paReadOnly">
          </td>
          <td align='left'> F. Salida
              <input type='text' value="<%=VerFecha(ffin)%>" size='9' name="fsalida" readonly class="paReadOnly">
          </td>
          <td align='left'> N. Noches
              <input type='text' value="<%=noches%>" size='3' name='noches' readonly class="paReadOnly">
          </td>
        </tr>
      </table>
      <%if servis<>"" then%>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr class="CabeTabla">
          <th align='left' class="colu_par">Servicios</th>
        </tr>
        <%
	tservis=split(servis,"-")
	for ts=0 to ubound(tservis)
		if tservis(ts)<>"" then 'Buscar servicio
			'Buscar hasta el parentesis para sacar el cod.
			pos=instr(tservis(ts),"(")
			if pos<>0 then%>
        <tr>
          <td align='left'>
            <%codiservi=left(tservis(ts),pos-1)
				cuantos=mid(tservis(ts),pos+1,instr(tservis(ts),")")-pos-1)
				for se=0 to ubound(RegServis,2)
					if RegServis(SeCodi,se)=clng(codiservi) then
						response.write cuantos & "&nbsp;-&nbsp;" & RegServis(SeNombre,se) & "<br>"
					end if
				next 'se%>
          </td>
        </tr>
        <%end if 'pos<>0
		end if 'tservis<>""
	next 'ts	%>
        <tr>
          <td colspan='2' height="5"></td>
        </tr>
      </table>      
      <%end if 'servis<>""%>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr>
          <td>Apellidos:</td>
          <td><input type='text' name='apellidos' value="<%=apellidos%>" size='50' maxlength="50" readonly class="paReadOnly">
          </td>
        </tr>
        <tr>
          <td>Nombre:</td>
          <td><input type='text' name='nombre' value="<%=nombre%>" size='50' maxlength="50" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td>Direcci&oacute;n:</td>
          <td><input type='text' name='direccion' value="<%=direccion%>" size='50' maxlength="50" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td >Poblaci&oacute;n:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" size='50' maxlength="50" readonly class="paReadOnly">
&nbsp;&nbsp;&nbsp;&nbsp; C.P.:
      <input type='text' name='cp' value="<%=cp%>" size='5' maxlength="5" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td >Provincia:</td>
          <td ><input type='text' name='provincia' value="<%=provincia%>" size='35' maxlength="50" readonly class="paReadOnly">
&nbsp;&nbsp;&nbsp; Pa&iacute;s:
      		<input type='text' name='pais' value="<%=pais%>" size='20' maxlength="50" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td>Tel&eacute;fono:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" size='25' maxlength="25" readonly class="paReadOnly">
&nbsp;&nbsp;&nbsp;&nbsp; Fax:
      <input type='text' name='fax' value="<%=fax%>" size='25' maxlength="25" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td>EMail:</td>
          <td><input type='text' name='email' value="<%=email%>" size='50' maxlength="75" readonly class="paReadOnly"></td>
        </tr>
        <tr>
          <td>&iquest;Estancia<br>
            Confirmada?:</td>
          <td>
            <select name='activa'>
              <option value='0' <%if not confi then response.write "selected"%>>No</option>
              <option value='1' <%if confi then response.write "selected"%>>S&iacute;</option>
            </select>
          </td>
        </tr>
        <tr>
          <td valign='top'>Observaciones:</td>
          <td><textarea name='obs' cols="52" rows='4' readonly class="paReadOnly"><%=observaciones%></textarea></td>
        </tr>
        <tr>
          <td>Importe Reserva:</td>
          <td align='left'><input type='text' name='importe' value="<%=formatnumber(tpelas,2)%>" size='10' maxlength="10">
&nbsp;&nbsp;&nbsp;&nbsp; Prepago:
      <input type='text' name='prepago' value="<%=formatnumber(prepago,2)%>" size='10' maxlength="10"></td>
        </tr>
        <tr>
          <td>C&oacute;digos TPV</td>
          <td align='left'> Cod. Aprovaci&oacute;n: <%=tpvapro%> &nbsp;&nbsp;&nbsp;&nbsp; Cod. Transaccion: <%=tpvtran%> &nbsp;&nbsp;&nbsp;&nbsp; Cod. Error: <%=tpverror%> &nbsp;&nbsp;&nbsp;&nbsp; </td>
        </tr>
        <tr>
          <td colspan="2" height='5'></td>
        </tr>
      </table>      
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr>
          <td align='center'>
            <input name="button" type='button' id='button' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" style="cursor:pointer" onClick="javascript:verReserva(<%=laid%>);" value="Imprimir Reserva">
	  </td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</div>
</form>

<div id='filtro' style='position:absolute; z-index:10; top:100; left:200; width:415px; height:200px; visibility:hidden; overflow:hidden; background-color: #F2F2F2; border: none;' class='texto10BLANCO'>
<form name='f2' action="<%=MiPag%>?est=<%=est%>&filtro=-1" method="POST">
<table border="0" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">FILTRO DEL LISTADO</div></td></tr>
  <tr><td class="tdTabla">

		<table align='center' width='400' border='0' cellpadding="0" cellspacing="0">
			<tr><td height='10' colspan='2'></td></tr>
			<tr>
				<td align='right'>Establecimiento:</td>
				<td align='left'>
					<select name='hotel'>
						<option value='0'>Todos</option>
						<%for h=0 to ubound(RegHoteles,2)%>
							<option value='<%=RegHoteles(HCodi,h)%>'><%=RegHoteles(HNombre,h)%></option>
						<%next%>
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'>Cod. Reserva:</td>
				<td align='left'><input type='text' size='15' maxlength='10' name='codres'></td>
			</tr>
			<tr>
				<td align='right'>Fecha Reserva:</td>
				<td align='left'>Mayor o igual a <input type='text' size='15' maxlength='10' name='frmayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'>Menor o igual a <input type='text' size='15' maxlength='10' name='frmenor'></td>
			</tr>
			<tr>
				<td align='right'>Fecha Llegada:</td>
				<td align='left'>Mayor o igual a <input type='text' size='15' maxlength='10' name='femayor'></td>
			</tr>
			<tr>
				<td align='right'></td>
				<td align='left'>Menor o igual a <input type='text' size='15' maxlength='10' name='femenor'></td>
			</tr>
			<tr>
				<td align='right'>¿Confirmada?:</td>
				<td align='left'>
					<select name='confi'>
						<option value='0'>Todas</option>
						<option value='-1'>S&iacute;</option>
						<option value='1'>No</option>
					</select>
				</td>
			</tr>
			<tr><td align='center' colspan='2'>
				<input type="hidden" value='-1' name='filtro'>
				<input type='submit' value='Filtrar' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='Sin Filtro' onclick="javascript:SinFiltro();" style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="Cerrar" onClick="javascript:document.getElementById('filtro').style.visibility='hidden';" style='cursor:pointer'></td></tr>
		</table>
		
	</td></tr>
</table>
		
</form>
</div>

<script language="JavaScript">
	//Central capa panel en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('panel').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('panel').style.width)/2); //Pos. izquierda
	document.getElementById('panel').style.top=50;
	document.getElementById('panel').style.left=l;
	<%if laid<>0 then 
			response.write "document.getElementById('panel').style.visibility='visible';" & bvcrlf
		end if	
	%>

	//Central capa filtro en la pantalla
	t=(screen.availHeight/2)-(parseInt(document.getElementById('filtro').style.height)/2); //Pos. superior
	t=t-100; //Quito por la barra del navegador
	l=(screen.availWidth/2)-(parseInt(document.getElementById('filtro').style.width)/2); //Pos. izquierda
	document.getElementById('filtro').style.top=t;
	document.getElementById('filtro').style.left=l;
	
</script>
</body>
</html>
