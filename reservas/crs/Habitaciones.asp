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

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
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

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

%><!--#include file="monedaHotel.asp"--><%
%><!--#include file="actuHabitacion.asp"--><%

if multiTarifa then
	%><!--#include file="datosMultiTarifa.asp"--><%
end if 'multiTarifa

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") "
cs=cs & "ORDER BY FInicio"
'responseLog(cs & "<br>")
rs.open cs,base
haytempos=false
msgerror=""
if not rs.eof then
	RegTempos=rs.getrows
	TCodi=0
	TFIni=1
	TFFin=2
	haytempos=true
else
	msgerror=objIdioma.getTraduccionHTML("i_nohaytemporadas")
end if
rs.close

if msgerror="" then 'seguimos, hay temporadas
	'Lista habitaciones
	cs= "SELECT TipoHabitaNombres.Id,IF(ISNULL(traduc.Traduccion),TipoHabitaNombres.Nombre,traduc.Traduccion) AS Tradu "
	cs=cs & "FROM " & precrs & "TipoHabitaNombres TipoHabitaNombres "
	cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""TipoHabitaNombres"" And Campo = ""Nombre"" And Idioma = """ & lang & """)  AS traduc ON TipoHabitaNombres.Id = traduc.IdReferencia  "
	cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est
	cs=cs & " ORDER BY Orden,TipoHabitaNombres.Id"
	'responseLog(cs & "<br>")
	rs.open cs,base
	haylista=false
	if not rs.eof then
		RegLista=rs.getrows
		HCodi=0
		HNombre=1
		haylista=true
	end if
	rs.close
	
	cs= "SELECT TipoHabitaNombres.Id,Temporadas.FInicio,Temporadas.FFinal,IF(ISNULL(Traducciones.Traduccion),TipoHabitaNombres.Nombre,Traducciones.Traduccion) AS Tradu,Preprebase,Preperhab,CodigoTemp "
	cs=cs & "FROM ((" & precrs & "TipoHabitaNombres TipoHabitaNombres INNER JOIN " & precrs & "TipoHabitaPrecios TipoHabitaPrecios "
	cs=cs & "ON TipoHabitaNombres.Id=TipoHabitaPrecios.IdHabita) INNER JOIN " & precrs & "Temporadas Temporadas "
	cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp) LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON TipoHabitaNombres.Id=Traducciones.IdReferencia AND Tabla='TipoHabitaNombres' AND Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE TipoHabitaNombres.CodigoEsta=" & est & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") "
	cs=cs & "AND Tarifa=" & laTarifa
	cs=cs & " ORDER BY TipoHabitaNombres.Id,Temporadas.FInicio"
	'responseLog(cs & "<br>")
	rs.Open cs, base
	haylistaP=false
	if not rs.eof then
		RegHabis=rs.GetRows
		RCodi=0
		RFIni=1
		RFFin=2
		RNombre=3
		RPelas=4
		RPHab=5
		RTempo=6
		haylistaP=true
	end if
	rs.close
	
	'Dtos colectivos por habitacion y temporada, y establecimiento
	cs="SELECT Colectivos.CodigoColec,Temporada,TipoHab,Prebase,Precio,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) as Tradu "
	cs=cs & "FROM (" & precrs & "Colectivos Colectivos INNER JOIN " & precrs & "DescuentosColectivos DescuentosColectivos "
	cs=cs & "ON Colectivos.CodigoColec=DescuentosColectivos.CodigoColec) LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND Tarifa=" & laTarifa
	'responseLog(cs & "<br>")
	rs.open cs,base
	haydtos=false
	if not rs.eof then
		RegDtos=rs.getrows
		DCodi=0
		DTempo=1
		DHabi=2
		Ddto=3
		DPrecio=4
		DNombre=5
		haydtos=true
	end if
	rs.close
	
	'Precio Suplementos por temporadas
	cs="SELECT RegimenHotel.Id,IdRegimen,Precio,"
	cs=cs & "CodigoTempo,CodigoHab,Defecto,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion)  as Tradu "
	cs=cs & "FROM (" & precrs & "Regimen Regimen INNER JOIN " & precrs & "RegimenHotel RegimenHotel ON "
	cs=cs & "Regimen.Id=RegimenHotel.IdRegimen) LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND Tarifa=" & laTarifa
	cs=cs & " ORDER BY IdRegimen,CodigoTempo"
	'responseLog(cs & "<br>")
	rs.open cs,base
	haysuples=false
	if not rs.eof then
		RegSuples=rs.getrows
		STId=0
		STCodi=1
		STPelas=2
		STTempo=3
		STHabi=4
		STDefecto=5
		STNombre=6
		haysuples=true
	end if
	rs.close
	
	'Buscar los descuentos suplementos
	cs="SELECT RegimenHotel.Id,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion)  as Tradu,Descuento,RegimenDtos.Precio,CodigoTempo "
	cs=cs & "FROM ((" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "RegimenDtos RegimenDtos "
	cs=cs & "ON RegimenHotel.Id=RegimenDtos.IdRegimenHotel) INNER JOIN " & precrs & "Colectivos Colectivos "
	cs=cs & "ON RegimenDtos.CodigoColec=Colectivos.CodigoColec) LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
	cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND RegimenDtos.Tarifa=" & laTarifa
	cs=cs & " ORDER BY RegimenDtos.CodigoColec"
	rs.open cs,base
	haydtossuples=false
	if not rs.eof then
		RegDtosSuples=rs.getrows
		SDtoId=0
		SDtoColec=1
		SDtoDto=2
		SDtoPrecio=3
		SDtoTempo=4
		haydtossuples=true
	end if
	rs.close

end if 'msgerror

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
#milista td {
	border-bottom:1px solid #cccccc;
}
</style>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}
function ADuplicar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=duplica";
		document.f1.submit();
	}
}
function enBlanco(){
	top.creaFlotante("verHabitacionCMS.asp?id=0&est=<%=est%>&recarga="+self.name,980,620,0,0);
}
function verFicha(id){
	top.creaFlotante("verHabitacionCMS.asp?id="+id+"&est=<%=est%>&recarga="+self.name,980,620,0,0);
}
function cargaCupos(){
	top.creaFlotante("preciosTrimestre.asp?est=<%=est%>&tipoD=0",1000,600,0,0);
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> 
            <%if msgerror<>"" then%>
            <div style="margin-top:10px;"><b><%=msgerror%></b></div>
            <%else 'seguimos%>
            <div align="right" style="margin-top:10px;"> 
              <%if multiTarifa and hayTarifas then%>
              <p style="float:left"> <%=objIdioma.getTraduccionHTML("i_tarifa")%> 
                <select name='tarifa' onChange="javascript:cambioTarifa(this);">
                  <%for t=0 to ubound(RegTarifas,2)
			marca=""
			if RegTarifas(TaCodi,t)=laTarifa then marca=" selected"%>
                  <option value='<%=RegTarifas(TaCodi,t)%>'<%=marca%>><%=RegTarifas(TaNombre,t)%></option>
                  <%next 't%>
                </select>
              </p>
              <%end if%>
              <input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevahabitacion")%>'>   
              <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'>
              <input type='button' class="boton200" value='<%=objIdioma.getTraduccionHTML("i_dispocupos")%>' onClick="javascript:cargaCupos();">
			  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_duplicaMarcada")%>' onclick='javascript:ADuplicar();'>
              <!--
		<input type='button' class="boton86" value='Imprimir' onClick='javascript:window.open("TarifaImpre.asp?est=<%=est%>");'>-->
            </div>
            <div class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_habitaciones")%></div>
            <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" id='milista'>
              <tr> 
                <th class="colu_par">&nbsp;</th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_habitacion")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_temporada")%></th>
                <th align='center'class="colu_par"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
                <th align='center'class="colu_par"><%=objIdioma.getTraduccionHTML("i_dtocolec")%></th>
                <th align='left' class="colu_par" width="130"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_dtoregi")%></th>
              </tr>
              <%if haylista then
		for rr=0 to ubound(RegLista,2)
			if (rr mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" width='10' class='<%=estilo%>' rowspan="<%=ubound(RegTempos,2)+1%>"> 
                  <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(HCodi,rr)%>"> 
                </td>
                <td align="left" class='<%=estilo%>' rowspan="<%=ubound(RegTempos,2)+1%>"> 
                  <a href='javascript:verFicha(<%=RegLista(HCodi,rr)%>);'> <%=RegLista(HNombre,rr)%></a></td>
                <%if hayListaP then
		laPrimera=true
		for r=0 to ubound(RegHabis,2)
			if RegHabis(RCodi,r)=RegLista(HCodi,rr) then 'esta toca
				if not laPrimera then%>
              <tr> 
                <%end if
				laPrimera=false%>
                <td align="center" class='<%=estilo%>' nowrap> <%=VerFecha(RegHabis(RFIni,r))%> 
                  - <%=VerFecha(RegHabis(RFFin,r))%> </td>
                <td align="right" class='<%=estilo%>' nowrap> <%=formatNumber(RegHabis(RPelas,r),2)%><%=sufijoMoneda%> 
                  <%if RegHabis(RPHab,r) then 'Precio por hab.%>
                  &nbsp;<%=objIdioma.getTraduccionHTML("i_xhabitacion")%> 
                  <%else%>
                  &nbsp;<%=objIdioma.getTraduccionHTML("i_xpersona")%> 
                  <%end if%>
                </td>
                <td align="right" class='<%=estilo%>'> 
                  <%'descuentos en habitacion
				  if haydtos then
				  	for dt=0 to ubound(RegDtos,2)
						if (RegDtos(DTempo,dt)=0 OR RegDtos(DTempo,dt)=RegHabis(RTempo,r)) AND RegDtos(DHabi,dt)=RegHabis(RCodi,r) then
							if RegDtos(DDto,dt)<>0 then 'porcentaje
								response.write RegDtos(DNombre,dt) & ": " & RegDtos(DDto,dt) & "%<br/>"
							else
								response.write RegDtos(DNombre,dt) & ": " & RegDtos(DPrecio,dt) & sufijoMoneda & "<br/>"
							end if 'dto
						end if 'esa es
				  	next 'dtos
				  end if 'haydtos
				  %>
                </td>
                <td align="left" class='<%=estilo%>' colspan="2"> 
                  <%'regimen en habitacion
				  if haysuples then
				  	for dt=0 to ubound(RegSuples,2)
						if (RegSuples(STTempo,dt)=0 OR RegSuples(STTempo,dt)=RegHabis(RTempo,r)) AND (RegSuples(STHabi,dt)=0 OR RegSuples(STHabi,dt)=RegHabis(RCodi,r)) then
							response.Write("<div style='clear:both'><div style='float:left; width:130px;'>")
							response.write RegSuples(STNombre,dt) & ": " & RegSuples(STPelas,dt) & sufijoMoneda
							response.Write("</div>") & vbcrlf
							if hayDtosSuples then
							response.Write("<div style='float:left; text-align:right'>")
							for ss=0 to ubound(RegDtosSuples,2)
								if RegDtosSuples(SDtoId,ss)=RegSuples(STId,dt) then
									if RegDtosSuples(SDtoDto,ss)<>0 then 'porcentaje
										response.write RegDtosSuples(SDtoColec,ss) & ": " & RegDtosSuples(SDtoDto,ss) & "%<br/>"
									else
										response.write RegDtosSuples(SDtoColec,ss) & ": " & RegDtosSuples(SDtoPrecio,ss) & sufijoMoneda & "<br/>"
									end if 'dto
								end if
							next
							response.write("</div>")
							end if
							response.write("</div>")
						end if 'esa es
				  	next 'dtos
				  end if 'haydtos
				  %>
                </td>
              </tr>
              <%end if 'esa hab
			next 'r los precios
			end if 'listaP
		next 'rr hab
	end if%>
            </table>
            <%end if 'msgerror%>
          </td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
