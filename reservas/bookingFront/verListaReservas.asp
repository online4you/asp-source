<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuListaReservas.asp"--><%
		
		cs="select max(IF(ISNULL(numfact),1,numfact+1)) factura from " & precrs & "Reservas WHERE YEAR(FechaReserva)=YEAR(current_date)"
		rs.open cs,base
		if not rs.eof then
			factura= rs("factura")
		end if
		rs.close

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
est=paClng(request.QueryString("est"))
empEd=paClng(request.Cookies("idEmpresa"))
'response.write " el ide " & IdCliente
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("id"))
if (laid=0) then
	laid=MiId
end if

if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Cod_res,FechaReserva,FechaIni,FechaFin,Activa,Importe,ImportePag,CodigoEsta,"
	cs=cs & "Numdias,Servicios,Comentarios,TpvCodAprobacion,TpvIdTrans,TpvCodError,IdCliente,HoraLlegada,CodigoVIP,numfact, idi "
	cs=cs & "FROM " & precrs & "Reservas "
	cs=cs & "WHERE Cod_res=" & laid
	'response.write cs & "<br>"
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
		est=rs("codigoEsta")
		horallegada=rs("horallegada")
		idamigo=rs("CodigoVIP")
		numfact=rs("numfact")
		langWeb=rs("idi")
		rs.close

		'Buscar datos cliente
		if idcliente<>0 then 'busca en fichas
			cs="SELECT * FROM " & precrs & "Fichas WHERE Id=" & idcliente
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
				checkFactura=rs("checkFactura")
				factNombre=rs("factNombre")
				factCifNif=rs("factCifNif")
				factCP=rs("factCP")
				factDir=rs("factDir")
				factLoc=rs("factLoc")
				factProv=rs("factProv")
				factEmail=rs("factEmail")
				typeOfPaymentID=rs("typeOfPaymentID")
				
				checkPersonaContacto=rs("checkPersonaContacto")
				apeContact=rs("apeContact")
				nomContact=rs("nomContact")
				telcontact=rs("telcontact")
				tipoDocu=rs("tipoDocu")
				documento=rs("documento")
				
				
				deseoRecibirOfertas=rs("deseoRecibirOfertas")
				acepto=rs("acepto")
				informacion=rs("informacion")
				
				
			end if
			rs.close
		end if
		

		'Buscar en tiposreserva
		cs="SELECT IdTipoHabitacion,CuantasHabis,NumAdultos,NumBebes,NumNinos1,NumNinos2,"
		cs=cs & "Suplementos,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu "
		cs=cs & "FROM " & precrs & "TipoReserva TipoReserva LEFT JOIN " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON TipoHabitaNombres.id=Traducciones.IdReferencia "
		cs=cs & "AND Tabla='TipoHabitaNombres' AND Campo='Nombre' AND Idioma='" & lang & "' "

		cs=cs & "ON TipoReserva.IdTipoHabitacion=TipoHabitaNombres.Id "
		cs=cs & "WHERE IdReserva=" & laid
		'response.write(cs)

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
		
		cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) AS Tradu,Orde FROM " & precrs & "Colectivos  Colectivos "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia "
		cs=cs & "AND Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "

		cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
		
		
		'response.write(cs)

		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			CCodi=0
			CNombre=1
			COrde=2
		end if
		rs.close

					
		'Buscar Suplementos
		cs="SELECT Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) AS Tradu "
		cs=cs & "FROM " & precrs & "Regimen Regimen "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON Regimen.id=Traducciones.IdReferencia "
		cs=cs & "AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "' "

		rs.open cs,base
		'response.write cs
		haysuples=false
		if not rs.eof then
			RegSuples=rs.getrows
			SCodi=0
			SNombre=1
			haysuples=true
		end if
		rs.close

		'Buscar servicios extras
		cs="SELECT IF(ISNULL(Traducciones.Traduccion),ServiciosExtras.Nombre,Traducciones.Traduccion) AS Tradu, Cuantas,Pelas "
		cs=cs & "FROM (" & precrs & "ReservaServicio ReservaServicio INNER JOIN " & precrs & "ServiciosExtras ServiciosExtras "
		cs=cs & "ON ReservaServicio.IdServicio=ServiciosExtras.Id) "
		cs=cs & "LEFT JOIN " & precrs & "Traducciones Traducciones "
		cs=cs & "ON ServiciosExtras.id=Traducciones.IdReferencia "
		cs=cs & "AND Tabla='ServiciosExtras' AND Campo='Nombre' AND Idioma='" & lang & "' "

		cs=cs & "WHERE CodReserva=" & laid 	
		'response.write cs & "<br>"
		rs.open cs,base
		hayservis=false
		if not rs.eof then
			RegServis=rs.getrows
			SerNombre=0
			SerCuantas=1
			SerPelas=2
			hayservis=true
		end if
		rs.close
		
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
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir="1" then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="ListaReservas.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function Modificar(){
	document.getElementById('pasalir').value='1';
	document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";
	document.f1.submit();
}
function ModificarYEnviar(){
	document.getElementById('pasalir').value='0';
	document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";
	document.f1.submit();
}
function verReserva(esa){
	window.open("verReserva.asp?id="+esa);
}

</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_reserva")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<div id='conteReserva' style="overflow:hidden; height:auto; width:100%;">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="left" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td class="tdTabla">
      <table align='center' width='100%' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
        <tr class="CabeTabla">
          <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_habitaciones")%></th>
          <th align='left' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_plazas")%></th>
          <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
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
			response.write objIdioma.getTraduccionHTML("i_bebes") & ":" & RegHabis(HBebes,h) & "<br>"
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
			if haysuples then
			for s=0 to ubound(RegSuples,2)
				if RegSuples(SCodi,s)=paClng(suples) then
					response.write RegSuples(SNombre,s) & "<br>"
				end if
			next 's
			end if
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
		<%if hayservis then%>
		<tr class="CabeTabla">
          <th align='left' class="colu_par" colspan="3"><%=objIdioma.getTraduccionHTML("i_servicios")%></th>
        </tr>
		<%for se=0 to ubound(RegServis,2)%>
		<tr>
			<td><%=RegServis(SerNombre,se)%></td>
			<td align="right"><%=RegServis(SerCuantas,se) & " x " & RegServis(SerPelas,se) & "="%></td>
			<td><%=RegServis(SerCuantas,se)*RegServis(SerPelas,se)%></td>
		</tr>
		<%next 'se%>
        <tr>
          <td colspan='3' height="10"></td>
        </tr>
		<%end if 'hayservis%>
      </table>
	  
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
         <tr>
          <td><%=objIdioma.getTraduccionHTML("i_numFactura")%>:</td>
          <td align='left'><input type='text' name='numFact' id='numFact' value="<%=numFact%>" size='5' maxlength="10">
		             <input name="button" type='button' class="boton86" id='button' style='cursor:pointer' onclick="javascript:document.getElementById('numFact').value='<%=factura%>';" value='<%=objIdioma.getTraduccionHTML("i_numFactura")%>'>

	  		</td>
        </tr>

		<tr>
          <td align='left' colspan="2"><%=objIdioma.getTraduccionHTML("i_reserva")%>: <%=laid%> </td>
          <td align='left' colspan="2"><b>
		  	<%if idamigo<>"" then%>
			  	Id. Amigo: <%=idamigo%>
			   <%else%>
            	Id. Cliente: <%=idcliente%>
			<%end if%>
			 </b>
			</td>
        </tr>
		<%if empEd = 82 and idamigo= "" then %>
         <tr>
          <td align='center' colspan="4" style="padding-left:95px"><b><%=objIdioma.getTraduccionHTML("i_no_amigo")%></b></td>
         </tr>
        <%end if%>
        <tr>
          <td align='left'><%=objIdioma.getTraduccionHTML("i_freserva")%>: <%=VerFecha(falta)%> </td>
          <td align='left'><%=objIdioma.getTraduccionHTML("i_fllegada")%>
              <input type='text' value="<%=VerFecha(fini)%>" size='9' name='fllegada' class="paReadOnly">
          </td>
          <td align='left'><%=objIdioma.getTraduccionHTML("i_fsalida")%>
              <input type='text' value="<%=VerFecha(ffin)%>" size='9' name="fsalida" class="paReadOnly">
          </td>
          <td align='left'><%=objIdioma.getTraduccionHTML("i_noches")%>
              <input type='text' value="<%=noches%>" size='3' name='noches' readonly class="paReadOnly">
          </td>
        </tr>
      </table>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_apellidos")%>:</td>
          <td><input type='text' name='apellidos' value="<%=apellidos%>" size='50' maxlength="50" class="paReadOnly">
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_nombre")%>:</td>
          <td><input type='text' name='nombre' value="<%=nombre%>" size='50' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_tipoDocu")%>:</td>
          <td>
            <select name='tipoDocu'>
              <option value='1' <%if ucase(tipoDocu)=ucase("NIF") then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_nif")%></option>
              <option value='2' <%if ucase(tipoDocu)=ucase("Pasaporte") then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_namePasaporte")%></option>
              <option value='3' <%if ucase(tipoDocu)=ucase("Otros") then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_otros")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_documento")%>:</td>
          <td><input type='text' name='documento' value="<%=documento%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>

<!--        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
          <td><input type='text' name='direccion' value="<%=direccion%>" size='50' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>
          <td ><%=objIdioma.getTraduccionHTML("i_poblacion")%>:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" size='50' maxlength="50" class="paReadOnly">
&nbsp;&nbsp;&nbsp;&nbsp; C.P.:
      <input type='text' name='cp' value="<%=cp%>" size='10' maxlength="15" class="paReadOnly"></td>
        </tr>
        <tr>
          <td ><%=objIdioma.getTraduccionHTML("i_pais")%>:</td>
          <td ><input type='text' name='pais' value="<%=pais%>" size='20' maxlength="50" class="paReadOnly"></td>
        </tr>
        <tr>-->
          <td><%=objIdioma.getTraduccionHTML("i_telefono")%>:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" size='25' maxlength="25" class="paReadOnly">
<!--&nbsp;&nbsp;&nbsp;&nbsp; Fax:
      <input type='text' name='fax' value="<%=fax%>" size='25' maxlength="25" class="paReadOnly">
	  -->
	  </td>
        </tr>
        <tr>
          <td>EMail:</td>
          <td><input type='text' name='email' value="<%=email%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_idioma")%>:</td>
          <td>
		     <select name='idiWeb'>
              <option value='es' <%if langWeb="es" then response.write "selected"%>>es</option>
              <option value='en' <%if langWeb="en" then response.write "selected"%>>en</option>
              <option value='de' <%if langWeb="de" then response.write "selected"%>>de</option>
            </select>

        </tr>
        <tr>
          <td colspan="2"><hr></td>
        </tr>



        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_deseoFactura")%>:</td>
          <td>
            <select name='checkFactura'>
              <option value='0' <%if not checkFactura then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if checkFactura then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_razonSocial")%>:</td>
          <td><input type='text' name='factNombre' value="<%=factNombre%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_CifNif")%>:</td>
          <td><input type='text' name='factCifNif' value="<%=factCifNif%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_cp")%>:</td>
          <td><input type='text' name='factCP' value="<%=factCP%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_direccion")%>:</td>
          <td><input type='text' name='factDir' value="<%=factDir%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_localidad")%>:</td>
          <td><input type='text' name='factLoc' value="<%=factLoc%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_provincia")%>:</td>
          <td><input type='text' name='factProv' value="<%=factProv%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_emailFactura")%>:</td>
          <td><input type='text' name='factEmail' value="<%=factEmail%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td colspan="2"><hr></td>
        </tr>

        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_personaContacto")%>:</td>
          <td>
            <select name='checkPersonaContacto'>
              <option value='0' <%if not checkPersonaContacto then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if checkPersonaContacto then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_apellidos")%>:</td>
          <td><input type='text' name='apeContact' value="<%=apeContact%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_nombre")%>:</td>
          <td><input type='text' name='nomContact' value="<%=nomContact%>" size='50' maxlength="75" class="paReadOnly"></td>
       </tr>
	           <tr>	

          <td><%=objIdioma.getTraduccionHTML("i_telefono")%>:</td>
          <td><input type='text' name='telcontact' value="<%=telcontact%>" size='50' maxlength="75" class="paReadOnly"></td>
        </tr>

		<tr>
          <td colspan="2"><hr></td>
        </tr>

        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_deseoRecibirOfertas")%>:</td>
          <td>
            <select name='deseoRecibirOfertas'>
              <option value='0' <%if not deseoRecibirOfertas then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if deseoRecibirOfertas then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_acepto")%>:</td>
          <td>
            <select name='informacion'>
              <option value='0' <%if not informacion then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if informacion then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_aceptoprivacidad")%>:</td>
          <td>
            <select name='acepto'>
              <option value='0' <%if not acepto then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if acepto then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_estaconfirmada")%>:</td>
          <td>
            <select name='activa'>
              <option value='0' <%if not confi then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_no")%></option>
              <option value='1' <%if confi then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_si")%></option>
            </select>
            <!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%=objIdioma.getTraduccionHTML("i_horallegada")%>:
            <input type='text' name='horallegada' value="<%=horallegada%>" style='width:160px' maxlength="50" class="paReadOnly">     
			-->       
          </td>
        </tr>
        <tr>
          <td valign='top'><%=objIdioma.getTraduccionHTML("i_observaciones")%>:</td>
          <td><textarea name='obs' cols="52" rows='4' class="paReadOnly"><%=observaciones%></textarea></td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_formapago")%>:</td>
          <td>
            <select name='typeOfPaymentID'>
              <option value='0' <%if not typeOfPaymentID=1 then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_tarjetacredito")%></option>
              <option value='1' <%if typeOfPaymentID=2 then response.write "selected"%>><%=objIdioma.getTraduccionHTML("i_transferencia")%></option>
            </select>
          </td>
        </tr>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_totalreserva")%>:</td>
          <td align='left'><input type='text' name='importe' value="<%=tpelas%>" size='10' maxlength="10">
		&nbsp;&nbsp;&nbsp;&nbsp; <%=objIdioma.getTraduccionHTML("i_prepago")%>:
   		<input type='text' name='prepago' value="<%=prepago%>" size='10' maxlength="10">

	  </td>
        </tr>

		<%if confi then 'es confirmada%>
        <tr>
          <td><%=objIdioma.getTraduccionHTML("i_codigostpv")%></td>
          <td align='left'>
		  <%=objIdioma.getTraduccionHTML("i_codaprovacion")%>: <%=tpvapro%> 
		  &nbsp;&nbsp;&nbsp;&nbsp; <%=objIdioma.getTraduccionHTML("i_codtransaccion")%>: <%=tpvtran%>
		  </td>
        </tr>
		<%end if%>
        <tr>
          <td colspan="2" height='5'></td>
        </tr>
      </table>      
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr>
          <td align='center'>
            <input name="button" type='button' class="boton86" id='button' style='cursor:pointer' onclick="javascript:ModificarYEnviar();" value='<%=objIdioma.getTraduccionHTML("i_ModificarYenviar")%>'>
            <input type='hidden' name='pasalir' id='pasalir' value='1'>
	 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="button" type='button' class="boton86" id='button' style='cursor:pointer' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>'>
            <input type='hidden' name='id' value='<%=laid%>'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value='<%=objIdioma.getTraduccionHTML("i_cerrar")%>'>
	  <!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" class="boton86" style="cursor:pointer" onClick="javascript:verReserva(<%=laid%>);" value='<%=objIdioma.getTraduccionHTML("i_imprimirreserva")%>'>-->
	  </td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</form>
</div>
<%if modo="actu" and pasalir="0" then %>
<script language="javascript" type="text/javascript">
function openReservation(){
		var str = "<div id='result' style='visibility: hidden'><form name='f1' method='post' target='_self' action='/reservas/bookingFront/composicionCorreo.asp?num_operacion=<%=laid%>&lang=<%=langWeb%>'>";
		str += "<input type='text' name='codres' value='<%=laid%>'>";
		str += "</form></div>";
		//alert(str);
		var windowToOpen=window.open("", '_blank', 'toolbar=no,location=no,directories=no,resizable=yes,scrollbars=yes');
		windowToOpen.document.write(str); 
		windowToOpen.document.f1.submit();
		
	}
	openReservation();
</script>
<%end if%>
<script language="javascript" type="text/javascript">
//alert(document.getElementById('conteReserva').offsetHeight);

alto=(document.getElementById('conteReserva').offsetHeight-500); //tamaño capa
top.document.getElementById(this.name).style.height=(top.document.getElementById(this.name).offsetHeight+alto)+"px";

</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
