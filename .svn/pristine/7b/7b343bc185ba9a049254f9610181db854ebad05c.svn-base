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

ids=paClng(request.QueryString("ids"))
laid=paClng(request.QueryString("id"))
recarga=request.QueryString("recarga")

%><!--#include file="actuPrecioServicio.asp"--><%

incluirloenoferta = true
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT * FROM " & precrs & "ServiciosPrecios "
	cs=cs & "WHERE id=" & laid
	rs.open cs,base
	if not rs.eof then
		finicio=rs("fechaInicio")
		ffinal=rs("fechaFinal")
		IdColectivo=rs("IdColectivo")
		importe=rs("importe")
		tipo=rs("tipo")
		regimen=rs("regimen")
		arrayRegi=split("" & regimen,",")
		habitaciones=rs("habitaciones")
		arrayHabi=split("" & habitaciones,",")
		obligatorio=rs("obligatorio")
		
		if idEmpresa = 98 then
			incluirloenoferta = rs("IncluirEnOferta")
		end if		
	end if
	rs.close

else 'nuevo
	elanyo=anyo
end if

'Buscar el hotel del servicio
cs="SELECT ServiciosExtras.CodigoEsta,IF(ISNULL(Traducciones.Traduccion),ServiciosExtras.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON ServiciosExtras.Id=Traducciones.IdReferencia AND Tabla='ServiciosExtras' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE ServiciosExtras.Id=" & ids
rs.open cs,base
if not rs.eof then
	est=rs("codigoesta")
	nservicio=rs("tradu")
end if
rs.close

'Tabla de habitaciones
cs="SELECT TipoHabitaNombres.Id,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est
hayhabis=false
rs.open cs,base
if not rs.eof then
	RegHabis=rs.getrows
	HCodi=0
	HNombre=1
	hayhabis=true
end if
rs.close

'Tabla de Suplementos
cs="SELECT Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) AS Tradu "
cs=cs & "FROM (" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
cs=cs & "ON RegimenHotel.IdRegimen=Regimen.Id) LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND "
cs=cs & "Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo
cs=cs & " GROUP BY Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion)"
haysuples=false
rs.open cs,base
if not rs.eof then
	RegSuples=rs.getrows
	SCodi=0
	SNombre=1
	haysuples=true
end if
rs.close


'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) as Tradu,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND "
cs=cs & "Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
rs.open cs,base
hayColec=false
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
	hayColec=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="<%=relative_url%>/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner el numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].document.getElementById('frame1').src="precioServicio.asp?ids=<%=ids%>&est=<%=est%>";
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&id=<%=laid%>&ids=<%=ids%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&id=<%=laid%>&ids=<%=ids%>&recarga=<%=recarga%>";

	document.f1.submit();
}

controlEvento(window,"load",ajustaVentana);
function ajustaVentana(){
	//alert("F1: "+document.f1.offsetHeight);
	//alert("Body: "+document.body.offsetHeight);
	mialto=document.body.offsetHeight+10;
	top.document.getElementById(self.name).style.height=(mialto)+"px";
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_precio")%> -> <%=nservicio%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>?id=<%=laid%>&ids=<%=ids%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px">
  <tr>
    <td class="tdTabla">

	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
		<tr><td align="right"><%=objIdioma.getTraduccionHTML("i_fechainicio")%>:</td>
			<td align="left">
			<input type='text' name='finicio' size='10' maxlength="12" value="<%=finicio%>">
			<img src="../img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('finicio','f1',self.name,'','<%=lang%>');" style="cursor:pointer">
			</td>
            
			<% 
				span = 6
				' Algunas empresas tienen esta característica
				if idEmpresa = 98 then
					span = 7
            	end if
			%>
            
			<td rowspan="<%=span %>" valign="top" width="40%">
			<%=objIdioma.getTraduccionHTML("i_regimen")%>:<br/>
			<%if haysuples then
			for s=0 to ubound(RegSuples,2)%>
				<input type="checkbox" value="<%=RegSuples(SCodi,s)%>" name="regimen"<%if busca_en_array(arrayRegi,RegSuples(SCodi,s)) then response.write " checked"%>/><%=RegSuples(SNombre,s)%><br/>
			<%next 's
			end if 'haysuples%>
			<br/>
			<%=objIdioma.getTraduccionHTML("i_habitaciones")%>:<br/>
			<%if hayhabis then
			for h=0 to ubound(RegHabis,2)%>
				<input type="checkbox" value="<%=RegHabis(HCodi,h)%>" name="habitaciones"<%if busca_en_array(arrayHabi,RegHabis(HCodi,h)) then response.write " checked"%>/><%=RegHabis(HNombre,h)%><br/>
			<%next 's
			end if 'haysuples%>
			</td>
		</tr>
		<tr><td align="right"><%=objIdioma.getTraduccionHTML("i_fechafinal")%>:</td>
			<td align="left">
			<input type='text' name='ffinal' size='10' maxlength="12" value="<%=ffinal%>">
			<img src="../img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('ffinal','f1',self.name,'','<%=lang%>');" style="cursor:pointer">
			</td>
		</tr>
		<tr>
		  <td align='right'><%=objIdioma.getTraduccionHTML("i_colectivo")%>:</td>
		  <td align="left">
		  	<select name='colectivo'>
              <option value='0'><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
              <%'Poner lista de Colectivos 
			  if hayColec then
			for c=0 to ubound(RegColec,2)
				marca=""
				if RegColec(CCodi,c)=IdColectivo then marca=" selected"%>
              <option value='<%=RegColec(CCodi,c)%>'<%=marca%>><%=RegColec(CNombre,c)%></option>
              <%next
			  end if%>
            </select>
		  </td>
		 </tr>
		<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_importe")%>:</td>
			<td align="left">
			<input type='text' name='importe' size='4' maxlength="8" value="<%=importe%>">
			</td>
		</tr>
		<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tipocalculo")%>:</td>
			<td align="left">
			<input type="radio" name="tipo"  style='height:13px;border: 0px; width:13px' value="0"<%if tipo=0 then response.write " checked"%>><%=objIdioma.getTraduccionHTML("i_porpersona")%><br/>
            <!--<input type="radio" name="tipo"  style='height:13px;border: 0px; width:13px' value="1"<%if tipo=1 then response.write " checked"%>><%=objIdioma.getTraduccionHTML("i_porreserva")%><br/>
            <input type="radio" name="tipo"  style='height:13px;border: 0px; width:13px' value="2"<%if tipo=2 then response.write " checked"%>><%=objIdioma.getTraduccionHTML("i_pordia")%><br/>
			
            <input type="radio" name="tipo"  style='height:13;border: 0px; width:13' value="3">
            x persona y d&iacute;a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
			<input type="radio" name="tipo"  style='height:13px;border: 0px; width:13px' value="4"<%if tipo=4 then response.write " checked"%>><%=objIdioma.getTraduccionHTML("i_porhabitacion")%>
			</td>
		</tr>
		<tr><td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_obligado")%>:</td>
			<td align="left">
			<input type="checkbox" name="obligatorio" value="1"<%if obligatorio then response.write " checked"%>><br/>
			(<%=objIdioma.getTraduccionHTML("i_texto_obligado")%>)
			</td>
		</tr>

		<%  ' Algunas empresas tienen esta característica
			if idEmpresa = 98 then
		%>
                <tr>
                    <td align='right' valign="top"><%=objIdioma.getTraduccionHTML("i_incluirloenoferta")%>:</td>
                    
                    <td align="left">
                        <input type="checkbox" name="incluirloenoferta" value="1" <%if incluirloenoferta then response.write " checked"%>><br/>
                    </td>
                </tr>
		<%
			end if
		%>
		<tr><td colspan="3" height="10"></td></tr>
      <tr>
        <td align='center' colspan='3'>
          <input name="boton" class='boton86' type='button' id='boton' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>'>
          <input type='hidden' name='id' value='<%=laid%>'>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>"></td>
      </tr>
    </table>
	</td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.finicio.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>