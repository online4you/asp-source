<!--#include file="includes/FunGestion.asp"-->
<!--#include file="Connections/correopaHM.asp"-->
<%
est=request.querystring("est")
usafiltro=request.querystring("filtro")
if usafiltro="" then usafiltro=false
hotel=clng("0" & request.QueryString("hotel"))

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos " & busco
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HayHoteles=true
end if
rs.close

'Tabla agencias
cs="SELECT Id,Nombre FROM " & precrs & "Agencias "
rs.Open cs, base
HayAge=false
if not rs.eof then
	RegAgencias=rs.GetRows
	AgCodi=0
	AgNombre=1
	HayAge=true
end if
rs.close



modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			'Anular Reserva
			cs="UPDATE " & precrs & "Reservas SET Activa=0 WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "Cod_res=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			
			if session("codagencia")<>"" then 'mensaje a HM
				mensaje="La agencia " & ucase(session("nomagencia")) & " ha anulado la reserva "
				for t=0 to ubound(queborro)
					mensaje=mensaje & trim(queborro(t)) & ", "
				next 't
				mensaje=mensaje & "ahora están como NO CONFIRMADAS."
				correopaHM "Anulación de reservas de " & session("nomagencia"),mensaje
			end if
			
		end if
		
	
	case "actu"
		MiId=request.form("id")
		fini=request.form("fllegada")
		ffin=request.form("fsalida")
		if not isdate(fini) or not isdate(ffin) then 'Fechas incorrectas
			response.write "<html><body><h2>Fechas Incorrectas</h2>"
			response.write "<br><br><input type='button' value='volver' onclick='javascript:window.history.back();'"
			response.write "</body></html>"
			response.End()
		end if
		finisql=year(fini) & "/" & month(fini) & "/" & day(fini)
		ffinsql=year(ffin) & "/" & month(ffin) & "/" & day(ffin)
		noches=cdate(ffin)-cdate(Fini)
		apellidos=QuitarApos(request.form("apellidos"))
		nombre=QuitarApos(request.form("nombre"))
		direccion=QuitarApos(request.form("direccion"))
		cp=QuitarApos(request.form("cp"))
		poblacion=QuitarApos(request.form("poblacion"))
		provincia=QuitarApos(request.form("provincia"))
		telefono=QuitarApos(request.form("telefono"))
		email=QuitarApos(request.form("email"))
		fax=QuitarApos(request.form("fax"))
		obs=QuitarApos(request.form("obs"))
		pais=request.form("pais")
		activa=request.form("activa")
		tpelas=QuitarComa(request.form("importe"))
		prepago=QuitarComa(request.form("prepago"))

		'TipoReserva		
		cs="UPDATE " & precrs & "TipoReserva SET "
		cs=cs & "FechaInicio=CONVERT(DATETIME,'" & finisql & "', 102),"
		cs=cs & "FechaFinal=CONVERT(DATETIME,'" & ffinsql & "', 102) "
		cs=cs & "WHERE IdReserva=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		
		'Fichas
		cs="UPDATE " & precrs & "Fichas SET "
		cs=cs & "Apellidos='" & apellidos & "',"
		cs=cs & "Nombre='" & nombre & "',"
		cs=cs & "Direccion='" & direccion & "',"
		cs=cs & "Poblacion='" & poblacion & "',"
		cs=cs & "Provincia='" & provincia & "',"
		cs=cs & "cp='" & cp & "',"
		cs=cs & "Telefono='" & telefono & "',"
		cs=cs & "Fax='" & fax & "',"
		cs=cs & "EMail='" & email & "',"
		cs=cs & "Pais='" & pais & "',"
		cs=cs & "FechaLlegada=CONVERT(DATETIME,'" & finisql & "', 102),"
		cs=cs & "FechaSalida=CONVERT(DATETIME,'" & ffinsql & "', 102),"
		cs=cs & "Confirmado=" & activa & " "
		cs=cs & "WHERE CodReserva=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		
		'Reservas
		cs="UPDATE " & precrs & "Reservas SET "
		cs=cs & "FechaIni=CONVERT(DATETIME,'" & finisql & "', 102),"
		cs=cs & "FechaFin=CONVERT(DATETIME,'" & ffinsql & "', 102),"
		cs=cs & "Activa=" & activa & ","
		cs=cs & "Importe=" & tpelas & ","
		cs=cs & "ImportePag=" & prepago & ","
		cs=cs & "Comentarios='" & obs & "',"
		cs=cs & "NumDias=" & noches & " "
		cs=cs & "WHERE Cod_res=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		if session("codagencia")<>"" then 'mensaje a HM
			mensaje="La agencia " & ucase(session("nomagencia"))
			mensaje=mensaje & " ha modificado la reserva " & MiId & "."
			correopaHM "Modificacion de reservas de " & session("nomagencia"),mensaje
		end if

	
end select

if request.form("filtro")<>"" then 'Realizar el filtro de la página
	usafiltro=-1

	hotel=clng("0" & request.form("hotel"))
	if hotel=0 then
		bhotel="CodigoEsta<>0 "
	else
		bhotel="CodigoEsta=" & hotel & " "
	end if
	cres=request.form("codres")
	if cres<>"" then bres="Cod_Res=" & cres & " "
	confi=request.form("confi")
	if confi="1" then bconfi="activa=0 " 'no cnfirma
	if confi="-1" then bconfi="activa=1 " 'si confirmadas
	frmayor=request.Form("frmayor")
	if frmayor<>"" then bfrmayor="(FechaAlta>=" & FechaMySQL(frmayor) & ") "
	frmenor=request.Form("frmenor")
	if frmenor<>"" then bfrmenor="(FechaAlta<=" & FechaMySQL(frmenor) & ") "

	femayor=request.Form("femayor")
	if femayor<>"" then bfemayor="(FechaIni>=" & FechaMySQL(femayor) & ") "
	femenor=request.Form("femenor")
	if femenor<>"" then bfemenor="(FechaIni<=" & FechaMySQL(femenor) & ") "
	
	agencia=clng("0" & request.Form("agencia"))
	if session("codagencia")<>"" then agencia=clng("0" & session("codagencia"))
	if agencia=0 then
		condicion="WHERE Activa=1 AND Agencia<>0 AND "
	else
		condicion="WHERE Activa=1 AND Agencia=" & agencia & " AND "
	end if

	if bhotel<>"" then condicion=condicion & bhotel & "AND "
	if bres<>"" then condicion=condicion & bres & "AND "
	if bconfi<>"" then condicion=condicion & bconfi & "AND "
	if frmayor<>"" then condicion=condicion & bfrmayor & "AND "
	if frmenor<>"" then condicion=condicion & bfrmenor & "AND "
	if femayor<>"" then condicion=condicion & bfemayor & "AND "
	if femenor<>"" then condicion=condicion & bfemenor & "AND "
	
	if right(condicion,4)="AND " then 'Quitar el ultimo operador
		condicion=left(condicion,len(condicion)-4)
	end if
	if right(condicion,6)="WHERE " then 'Quitar la condicion
		condicion=""
	end if
	
	'Crear consulta fija
	'set base=server.createobject("ADODB.Connection")
	'base.Open CONN
	on error resume next
	cs="DROP VIEW filtradoreserva" 'Borra la anterior consulta
	base.execute cs
	on error goto 0
		
	cs="CREATE VIEW " & precrs & "filtradoreserva AS "
	cs=cs & "SELECT Cod_res,FechaAlta,Cod_Cancel,FechaIni,FechaFin,Fichas.Apellidos,"
	cs=cs & "Fichas.Nombre,Fichas.Telefono,Importe,Activa,CodigoEsta,ImportePag "
	cs=cs & "FROM " & precrs & "Reservas LEFT JOIN Fichas "
	cs=cs & "ON Reservas.Cod_res=Fichas.CodReserva "
	cs=cs & condicion
	
	base.execute cs 'Crear consulta nueva
	'base.close
	'set base=nothing
	msg=cs

end if





laid=request.QueryString("id")
if laid="" then laid=0
laid=clng(laid)
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Cod_res,CodigoEsta,FechaAlta,Cod_Cancel,FechaIni,FechaFin,Fichas.Apellidos,"
	cs=cs & "Fichas.Nombre,Fichas.Telefono,Fichas.Email,Activa,Importe,ImportePag,"
	cs=cs & "Numdias,Reservas.Servicios,Fichas.Direccion,Fichas.Poblacion,Fichas.Provincia,"
	cs=cs & "Fichas.cp,Fichas.Fax,Comentarios,Fichas.Pais,TpvCodAprobacion,TpvIdTrans,TpvCodError "
	cs=cs & "FROM " & precrs & "Reservas Reservas LEFT JOIN " & precrs & "Fichas Fichas "
	cs=cs & "ON Reservas.Cod_res=Fichas.CodReserva "
	cs=cs & "WHERE Cod_res=" & laid
	rs.open cs,base
	if not rs.eof then
		falta=rs("fechaalta")
		ccancel=rs("cod_cancel")
		fini=rs("fechaini")
		ffin=rs("fechafin")
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		tele=rs("telefono")
		email=rs("email")
		confi=rs("activa")
		tpelas=rs("importe")
		prepago=rs("importepag")
		noches=rs("numdias")
		servis=rs("Servicios")
		fax=rs("fax")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		cp=rs("cp")
		observaciones=rs("comentarios")
		pais=rs("pais")
		tpvapro=rs("TpvCodAprobacion")
		tpvtran=rs("TpvIdTrans")
		tpverror=rs("TpvCodError")
		est=rs("codigoesta")
		rs.close
		
		'Buscar en tiposreserva
		cs="SELECT IdTipoHabitacion,CuantasHabis,NumAdultos,NumBebes,NumNinos1,NumNinos2,"
		cs=cs & "Suplementos,Nombre_es "
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
		
		'Buscar nombre colectivos
		cs="SELECT CodigoColec,Nombre,Orde FROM " & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "ColectivosNomres ColectivosNomres "
		cs=cs & "ON Colectivos.CodigoColec=ColectivosNomres.ColectivoIdi "
		cs=cs & "WHERE CodigoEsta=" & est & " AND Idioma='es' ORDER BY orde"
		rs.open cs,base
		if not rs.eof then
			RegColec=rs.getrows
			ColCodi=0
			CNombre=1
			ColOrde=2
		end if
		rs.close
		
		'Buscar Suplementos de la reserva
		cs="SELECT RegimenHotel.Id,Nombre_es "
		cs=cs & "FROM " & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
		cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id "
		cs=cs & "WHERE CodigoEsta=" & est
		rs.open cs,base
		haysuples=false
		if not rs.eof then
			RegSuples=rs.getrows
			SCodi=0
			SNombre=1
			haysuples=true
		end if
		rs.close
		
		'Buscar los servicios reservados
		cs="SELECT Nombre_es,Cuantas,Pelas "
		cs=cs & "FROM " & precrs & "ReservaServicio ReservaServicio INNER JOIN " & precrs & "ServiciosExtras ServiciosExtras "
		cs=cs & "ON ReservaServicio.CodServicio=ServiciosExtras.Id "
		cs=cs & "WHERE CodReserva=" & laid 
		rs.open cs,base
		hayservis=false
		if not rs.eof then
			RegServis=rs.getrows
			SeNombre=0
			SeCuantas=1
			SePelas=2
			hayservis=true
		end if
		rs.close

		'Nombre de paises
		cs="SELECT Cod_Pais,Nombre_es FROM " & precrs & "Pais Order BY Nombre_es"
		rs.open cs,base
		haypais=false
		if not rs.eof then
			RegPais=rs.getrows
			PCodi=0
			PNombre=1
			haypais=true
		end if
		rs.close
		
	else
		rs.close
	end if 'eof

end if 'laid<>""

if usafiltro then 'Usar el filtro
	cs="SELECT * FROM filtradoreserva ORDER BY Cod_res"
else 'todas
	'Lista de registros
	cs="SELECT Cod_res,FechaAlta,Cod_Cancel,FechaIni,FechaFin,Fichas.Apellidos,"
	cs=cs & "Fichas.Nombre,Fichas.Telefono,Importe,Activa,CodigoEsta,ImportePag "
	cs=cs & "FROM " & precrs & "Reservas Reservas LEFT JOIN " & precrs & "Fichas Fichas "
	cs=cs & "ON Reservas.Cod_res=Fichas.CodReserva "
	cs=cs & "WHERE Activa=1 AND "
	if session("codagencia")<>"" then 'es una agencia
		cs=cs & "Agencia=" & session("codagencia")
		if est<>"" then
			cs=cs & " AND CodigoEsta=" & est
		end if
	else
		cs=cs & "CodigoEsta=" & est
		cs=cs & " AND Agencia<>0"
	end if
	 cs=cs & " ORDER BY Cod_res"
end if
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RAlta=1
	RCancel=2
	RFIni=3
	RFFin=4
	RApe=5
	RNombre=6
	RTele=7
	RPelas=8
	RConfi=9
	REsta=10
	RComis=11
	haylista=true

	PorPag=38
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("P")
	if Pag="" then Pag=MaxP 'Para que ponga la ultima
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close
set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra&filtro=<%=usafiltro%>&hotel=<%=hotel%>";
		document.f1.submit();
	}
}

function Modificar(){
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu&filtro=<%=usafiltro%>&hotel=<%=hotel%>";
	document.f1.submit();
}
function SinFiltro(){
	window.location="<%=MiPag%>?est=<%=est%>";
}

</script>
<body>
<form name='f1' action="<%=MiPag%>?est=<%=est%>&filtro=<%=usafiltro%>&hotel=<%=hotel%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='780'>
<tr>
	<td align='center' width='100' valign='top'>
	<%if session("codagencia")="" then 'es una HM%>
		<!--#include file="botonera.asp"-->
	<%end if%>
	</td>
	<td align='center' valign='top'>
		<!--#include file="Seleccionado.asp"-->
	<table align='center' width="600">
	<tr><td align='left' class="style1b">
	* Este listado de reservas depende del establecimiento seleccionado en la parte de arriba.
	</td></tr>
	<tr><td align='center'>
		<input type='button' class="boton145" value='&nbsp;Filtrar Listado&nbsp;' onClick="javascript:document.getElementById('filtro').style.visibility='visible';">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="boton145" value='&nbsp;Anular reservas Marcadas&nbsp;' onclick='javascript:ABorrar();'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">LISTA DE RESERVAS 
	<%if session("codagencia")<>"" then response.write "DE " &  ucase(session("nomagencia"))%>
	&nbsp;&nbsp;&nbsp;(Sólo confirmadas)</div></td></tr>
  <tr><td valign="bottom" class="tdTabla">
	
      <table width='652' border="0" align='center' cellpadding="0" cellspacing="0" class="tdTabla">
      <tr class='cabetabla'>
        <th>&nbsp;</th>
        <th>Reserva</th>
		<%if hotel=0 then%>
			<th align='left' class="colu_par">Hotel</th>
		<%end if%>
        <th align='center'>F.Reserva</th>
        <!--<th>Cod. Cancel.</th>-->
        <th align='center'>F.Llegada</th>
        <th align='center'>F.Salida</th>
        <th align='left' class="colu_par">Apellidos</th>
        <th align='left' class="colu_par">Nombre</th>
        <!--<th align='left' class="colu_par">Tel&eacute;fono</th>-->
        <th align='right'>Importe</th>
        <th align='right'>Comis.</th>
      </tr>
      <%if haylista then
	  	tcomis=0
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
        <!--<td align="center" width='50' class='<%=laColu(0)%>' > <%=RegLista(RCancel,r)%> </td>-->
        <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFIni,r))%> </td>
        <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFFin,r))%> </td>
        <td align="left" class='<%=laColu(0)%>' > <%=RegLista(RApe,r)%> </td>
        <td align="left" class='<%=laColu(0)%>' > <%=RegLista(RNombre,r)%> </td>
        <!--<td align="left" width='150' class='<%=laColu(0)%>' >
	  	<%=RegLista(RTele,r)%>
	  </td>-->
        <td align="right" class='<%=laColu(0)%>' ><%=formatnumber(RegLista(RPelas,r),2)%></td>
        <td align="right" class='<%=laColu(0)%>' ><%=formatnumber(RegLista(RComis,r),2)%></td>
      </tr>
      <%
	  	tcomis=tcomis+RegLista(RComis,r)
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

<div id='panel' style='position:absolute; z-index:10; top:100px; left:200px; width:500px; height:400px; visibility:hidden; overflow:hidden;background-color:#F2F2F2' class='texto10BLANCO'>
<table width="100%" height="71" border="0" cellpadding="0" cellspacing="0">
  <tr><td background="img/corners/a_c.gif">
		<table align='center' width='100%' border='0' cellpadding="0" cellspacing="1">
		<tr>
			<td width="33%">&nbsp;</td>
			<td width='33%' align='center'><div align="center" class="style1">RESERVA</div>
			</td>
			<td width='33%' align='right'><input name='cierre2' type='button' value='X Cerrar' style='cursor:pointer; height:14; margin-top:2' onClick="javascript:document.getElementById('panel').style.visibility='hidden';">
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
						if RegSuples(SCodi,s)=clng("0" & tsuples(ts)) then
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
          <td align='left' colspan="2"> Cod. Cancel: <%=ccancel%> </td>
        </tr>
        <tr>
          <td align='left'> F. Reserva: <%=VerFecha(falta)%> </td>
          <td align='left'> F. Llegada
              <input type='text' value="<%=VerFecha(fini)%>" size='8' name='fllegada'>
          </td>
          <td align='left'> F. Salida
              <input type='text' value="<%=VerFecha(ffin)%>" size='8' name="fsalida">
          </td>
          <td align='left'> N. Noches
              <input type='text' value="<%=noches%>" size='3' name='noches'>
          </td>
        </tr>
      </table>
      <%if hayservis then%>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr>
          <td align='left'><b>SERVICIOS EXTRAS</b></td>
        </tr>
        <%
		for ts=0 to ubound(RegServis,2)%>
			<tr>
			  <td align='left'>
				<%response.write " - " & RegServis(SeNombre,ts) & " (" & RegServis(SeCuantas,ts) & " x " & RegServis(SePelas,ts) & " &euro;)"%>
			  </td>
			</tr>
		<%next 'ts	%>
        <tr>
          <td colspan='2' height="10"></td>
        </tr>
      </table>      
      <%end if 'servis<>""%>
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr>
          <td>Apellidos:</td>
          <td><input type='text' name='apellidos' value="<%=apellidos%>" size='50' maxlength="50">
          </td>
        </tr>
        <tr>
          <td >Nombre:</td>
          <td ><input type='text' name='nombre' value="<%=nombre%>" size='50' maxlength="50"></td>
        </tr>
        <tr>
          <td>Direcci&oacute;n:</td>
          <td><input type='text' name='direccion' value="<%=direccion%>" size='50' maxlength="50"></td>
        </tr>
        <tr>
          <td >Poblaci&oacute;n:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" size='50' maxlength="50">
&nbsp;&nbsp;&nbsp;&nbsp; C.P.:
      <input type='text' name='cp' value="<%=cp%>" size='5' maxlength="5"></td>
        </tr>
        <tr>
          <td >Provincia:</td>
          <td ><input type='text' name='provincia' value="<%=provincia%>" size='40' maxlength="50">
&nbsp;&nbsp;&nbsp; Pa&iacute;s:
      <select name="pais" style='width:130;'>
        <%if haypais then
			for p=0 to ubound(RegPais,2)
					marca=""
					if RegPais(PCodi,p)=pais then marca="selected"%>
        <option value='<%=RegPais(PCodi,p)%>' <%=marca%>><%=RegPais(PNombre,p)%></option>
        <%next
		end if%>
    </select></td>
        </tr>
        <tr>
          <td>Tel&eacute;fono:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" size='25' maxlength="25">
&nbsp;&nbsp;&nbsp;&nbsp; Fax:
      <input type='text' name='fax' value="<%=fax%>" size='25' maxlength="25"></td>
        </tr>
        <tr>
          <td>EMail:</td>
          <td><input type='text' name='email' value="<%=email%>" size='50' maxlength="75"></td>
        </tr>
        <tr>
          <td>&iquest;Estancia<br>
            Confirmada?:</td>
          <td>
            <select name='activa'>
              <option value='0' <%if not confi then response.write "selected"%>>No</option>
              <option value='-1' <%if confi then response.write "selected"%>>S&iacute;</option>
            </select>
          </td>
        </tr>
        <tr>
          <td valign='top'>Observaciones:</td>
          <td><textarea name='obs' cols="52" rows='4'><%=observaciones%></textarea></td>
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
            <input name="button" type='button' id='button' style='cursor:pointer' onClick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</div>
</form>

<div id='filtro' style='position:absolute; z-index:10; top:100; left:200; width:415px; height:200px; visibility:hidden; overflow:visible;'>
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
			<%if session("codagencia")="" then 'es HM %>
			<!--
			<tr>
				<td align='right'>¿Confirmada?:</td>
				<td align='left'>
					<select name='confi'>
						<option value='0'>Todas</option>
						<option value='-1'>S&iacute;</option>
						<option value='1'>No</option>
					</select>
				</td>
			</tr>-->
			<tr>
				<td align='right'>Agencia:</td>
				<td align='left'>
					<select name='agencia'>
						<option value='0'>Todas</option>
						<%if hayage then
							for k=0 to ubound(RegAgencias,2)%>
							<option value="<%=RegAgencias(AgCOdi,k)%>"><%=RegAgencias(AgNombre,k)%></option>
							<%next
						end if%>
					</select>
				</td>
			</tr>
			<%end if%>
			<tr><td align='center' colspan='2'>
				<input type="hidden" value='-1' name='filtro'>
				<input type='submit' value='Filtrar' style='cursor:pointer'>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='button' value='Sin Filtro' onClick="javascript:SinFiltro();" style='cursor:pointer'>
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
	document.getElementById('panel').style.top=35;
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
