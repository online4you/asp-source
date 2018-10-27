<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuReservas.asp"--><%
if lang="" then lang ="es"

ff=request.QueryString("ff") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
est=paClng(request.QueryString("est"))
empEd=paClng(request.Cookies("idEmpresa"))
'response.write " el ide " & IdCliente
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Cod_res,FechaReserva,FechaIni,FechaFin,Activa,Importe,ImportePag,"
	cs=cs & "Numdias,Servicios,Comentarios,TpvCodAprobacion,TpvIdTrans,TpvCodError,IdCliente,codAgencia "
	cs=cs & "FROM " & precrs & "Reservas "
	cs=cs & "WHERE Cod_res=" & laid
	rs.open cs,base
	if not rs.eof then
		falta=rs("fechareserva")
		fini=rs("fechaini")
		ffin=rs("fechafin")
		confi=rs("activa")
		tpelas=rs("importe")
		prepago=rs("importepag")
		noches=rs("numdias")
		servis=rs("Servicios")
		observaciones=rs("comentarios")
		tpvapro=rs("TpvCodAprobacion")
		tpvtran=rs("TpvIdTrans")
		tpverror=rs("TpvCodError")
		idcliente=rs("idcliente")
		codAgencia=rs("codAgencia")
		rs.close

		'Buscar datos cliente
		if idcliente<>0 then 'busca en fichas
			cs="SELECT * FROM Fichas WHERE Id=" & idcliente
			rs.open cs,base
			if not rs.eof then
				apellidos=rs("apellidos")
				nombre=rs("nombre")
				tele=rs("telefono")
				email=rs("email")
				fax=rs("fax")
				direccion=rs("direccion")
				poblacion=rs("poblacion")
				provincia=rs("provincia")
				cp=rs("cp")
				pais=rs("NombrePais")
			end if
			rs.close
		end if
		

		'Buscar en tiposreserva
		cs="SELECT IdTipoHabitacion,CuantasHabis,NumAdultos,NumBebes,NumNinos1,NumNinos2,"
		cs=cs & "Suplementos,Nombre " 'Nuevo. En la BDD está como nombre y no nombre_es 01/07/10
		'cs=cs & "Suplementos,Nombre_es "
		cs=cs & "FROM " & precrs & "TipoReserva TipoReserva INNER JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
		cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id "
		cs=cs & "WHERE IdReserva=" & laid
		rs.open cs,base
		hayhabis=false
		if not rs.eof then 'Cargar tabla
			RegHabis=rs.getrows
			HaCodi=0
			HaCanti=1
			HaAdultos=2
			HaBebes=3
			HaNinos1=4
			HaNinos2=5
			Hasuples=6
			HaNombre=7
			hayhabis=true
		end if
		rs.close

		'Buscar nombre colectivos si solo es una tabla
		cs="SELECT CodigoColec, Nombre ,Orde FROM " & precrs & "Colectivos  " 'Nuevo. En la BDD está como nombre y no nombre_es 01/07/10
		'cs="SELECT CodigoColec, Nombre_" & lang & ",Orde FROM Colectivos  "
		cs=cs & "WHERE CodigoEsta=" & est & "  ORDER BY orde"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			ColCodi=0
			CNombre=1
			ColOrde=2
		end if
		rs.close
					
		'Buscar Suplementos
		cs="SELECT RegimenHotel.Id,Nombre "  'Nuevo. En la BDD está como nombre y no nombre_es 01/07/10
		'cs="SELECT RegimenHotel.Id,Nombre_es "
		cs=cs & "FROM " & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel "
		cs=cs & "ON Regimen.Id=RegimenHotel.IdRegimen "
		cs=cs & "WHERE CodigoEsta=" & est & " AND Anyo=" & anyo
		rs.open cs,base
		if not rs.eof then
			RegSuples=rs.getrows
			SCodi=0
			SNombre=1
		end if
		rs.close
		'Buscar la agencia
		if codAgencia<>"" then
			cs="SELECT Id, Nombre FROM " & precrs & "Agencias WHERE Id=" & codAgencia
			rs.open cs,base
			if not rs.Eof then
				ANombre=rs("Nombre")
			end if
		end if 
		
		
	else
		rs.close
	end if 'eof

end if 'laid<>""

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['elFrame<%=ff%>'].location="Reservas_agencias.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?modo=actu&ff=<%=ff%>&recarga="+self.name;
	document.f1.submit();
}
function verReserva(esa){
	window.open("verReserva.asp?id="+esa);
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">RESERVA <%="-" & Anombre%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div style="overflow:scroll; height:500px; width:510px;">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
      <table align='center' width='100%' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
        <tr class="CabeTabla">
          <th align='left' class="colu_par">Habitaciones</th>
          <th align='left' class="colu_impar">Personas</th>
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
          <td><input type='text' name='apellidos' value="<%=apellidos%>" size='50' maxlength="50" class="paReadOnly">
          </td>
        </tr>
        <tr>
          <td>Nombre:</td>
          <td><input type='text' name='nombre' value="<%=nombre%>" size='50' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>
          <td>Direcci&oacute;n:</td>
          <td><input type='text' name='direccion' value="<%=direccion%>" size='50' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>
          <td >Poblaci&oacute;n:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" size='50' maxlength="50" class="paReadOnly">
&nbsp;&nbsp;&nbsp;&nbsp; C.P.:
      <input type='text' name='cp' value="<%=cp%>" size='10' maxlength="15" class="paReadOnly"></td>
        </tr>
        <tr>
          <td >Provincia:</td>
          <td ><input type='text' name='provincia' value="<%=provincia%>" size='35' maxlength="50" class="paReadOnly">
&nbsp;&nbsp;&nbsp; Pa&iacute;s:
      		<input type='text' name='pais' value="<%=pais%>" size='20' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>
          <td>Tel&eacute;fono:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" size='25' maxlength="25" class="paReadOnly">
&nbsp;&nbsp;&nbsp;&nbsp; Fax:
      <input type='text' name='fax' value="<%=fax%>" size='25' maxlength="25" class="paReadOnly"></td>
        </tr>
        <tr>
          <td>EMail:</td>
          <td><input type='text' name='email' value="<%=email%>" size='50' maxlength="75" class="paReadOnly"></td>
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
          <td><textarea name='obs' cols="52" rows='4' class="paReadOnly"><%=observaciones%></textarea></td>
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
            <input name="button" type='button' class="boton86" id='button' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	  <!--
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" class="boton86" style="cursor:pointer" onClick="javascript:verReserva(<%=laid%>);" value="Imprimir Reserva">
	  -->
	  </td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</form>
</div>
</body>
</html>
