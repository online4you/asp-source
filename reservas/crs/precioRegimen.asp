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

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
laid=paClng(request.QueryString("id"))
fa=request.QueryString("fa")

if request.Form<>"" then
	if request.QueryString("modo")="borra" then 'pa borrar
		
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM " & precrs & "RegimenHotel WHERE "
			cadena=""
			for t=0 to ubound(queborro)
				'Buscar los datos
				cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
			next
			if right(cadena,4)=" OR " then 'Quitar el ultimo operador
				cadena=left(cadena,len(cadena)-4)
			end if	
			base.execute cs & cadena
			controlRegistro(cs & cadena) 'guarda seguimiento
			
			cadena=replace(cadena,"Id=","IdRegimenHotel=")
			cs="DELETE FROM " & precrs & "RegimenDtos WHERE " & cadena
			base.execute cs
			
		end if

	
	else 'actualiza
	
		'Actualizar precios
		'Buscar la lista 
		cs="SELECT RegimenHotel.Id "
		cs=cs & "FROM (" & precrs & "Regimen Regimen LEFT JOIN " & precrs & "RegimenHotel RegimenHotel ON "
		cs=cs & "Regimen.Id=RegimenHotel.IdRegimen) LEFT JOIN " & precrs & "Temporadas Temporadas "
		cs=cs & "ON RegimenHotel.CodigoTempo=Temporadas.CodigoTemp "
		cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND (CodigoHab=" & laId & " OR CodigoHab=0)"
		cs=cs & " AND Tarifa=" & laTarifa & " ORDER BY IdRegimen,FInicio"
		rs.open cs,base
		hayregis=false
		if not rs.eof then
			RegIds=rs.getrows
			RgId=0
			hayregis=true
		end if
		rs.close
		
		'Solo se puede actualizar
		if hayregis then 'Actualizar todos los registros
			for r=0 to ubound(RegIds,2)
				habitacion=paClng(request.form("habitacion-" & RegIds(RgId,r)))
				tempo=paClng(request.form("temporada-" & RegIds(RgId,r)))
				pelas=paDbl(request.form("precio-" & RegIds(RgId,r)))
				defecto=request.form("defecto-" & RegIds(RgId,r))
				if defecto="" then defecto=0
				
				cs="UPDATE " & precrs & "RegimenHotel SET "
				cs=cs & "CodigoHab=" & habitacion & ","
				cs=cs & "CodigoTempo=" & Tempo & ","
				cs=cs & "Defecto=" & defecto & ","
				cs=cs & "Precio=" & QuitarComa(pelas) & " "
				cs=cs & "WHERE Id=" & RegIds(RgId,r)
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
			next
			
		end if 'hayregis

	end if 'modo=borra
end if

'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) as Tradu,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
end if
rs.close

'Temporadas de ese hotel
cs="SELECT CodigoTemp,FInicio,FFinal FROM " & precrs & "Temporadas Temporadas "
cs=cs & "WHERE CodigoEsta=" & est & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") "
cs=cs & " ORDER BY FInicio"
rs.open cs,base
haytempos=false
if not rs.eof then
	RegTempos=rs.getrows
	TCodi=0
	TFIni=1
	TFFin=2
	haytempos=true
end if
rs.close

'Regimen
'Precio Suplementos por temporadas
cs="SELECT RegimenHotel.Id,IdRegimen,Precio,"
cs=cs & "CodigoTempo,CodigoHab,Defecto,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) as Tradu "
cs=cs & " FROM ((" & precrs & "Regimen Regimen LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "') LEFT JOIN " & precrs & "RegimenHotel RegimenHotel ON "
cs=cs & "Regimen.Id=RegimenHotel.IdRegimen) LEFT JOIN " & precrs & "Temporadas Temporadas "
cs=cs & "ON RegimenHotel.CodigoTempo=Temporadas.CodigoTemp "
cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND (CodigoHab=" & laId & " OR CodigoHab=0)"
cs=cs & " AND Tarifa=" & laTarifa & " ORDER BY IdRegimen,FInicio"
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SId=0
	SCodi=1
	SPelas=2
	STempo=3
	SHabi=4
	SDefecto=5
	SNombre=6
	haysuples=true
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
td {
	height:17px;
}
input {
	height:12px;
}
.fila_impar, .fila_par {
	white-space:nowrap;
}
</style>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&id=<%=laid%>&est=<%=est%>";
		document.f1.submit();
	}
}
function nuevoSuple(){
	rutaPadre=parent.parent.self.name;
	rutaPadre=rutaPadre+"."+parent.self.name;
	rutaPadre=rutaPadre+"."+self.name;
	top.creaFlotante("nuevoSuple.asp?idh=<%=laId%>&est=<%=est%>&recarga="+rutaPadre,600,150,0,0);
}
</script>
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>">
<div class="tituloTabla" style="margin:0px"><%=ucase(objIdioma.getTraduccionHTML("i_regimenhabitacion"))%></div>
<div id='listaHabi' style="height:150px; overflow-x:hidden; overflow-y:scroll">
<table align='center' border="0" cellpadding="0" cellspacing="1" width="96%">
      <tr>
	  	<th class="colu_par"></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_habitacion")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_temporada")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_incluido")%></th>
      </tr>
	  <%if haysuples then
		for R=0 to ubound(RegSuples,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
      <tr>	 
			<td align="left" class='<%=estilo%>'><input type='checkbox' name='aborrar' value='<%=RegSuples(SId,r)%>'>&nbsp;<%=RegSuples(SNombre,r)%></td>
			<td align="center" class='<%=estilo%>'>
			<select name='habitacion-<%=RegSuples(SId,r)%>'>
			  <option value='0'<%if RegSuples(SHabi,r)=0 then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
			  <option value='<%=laid%>'<%if RegSuples(SHabi,r)=laid then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_estahab")%></option>
			</select>
			</td>
			<td align="center" class='<%=estilo%>'>
				<select name='temporada-<%=RegSuples(SId,r)%>'>
					<option value='0'><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
					<%'Poner lista de temporadas y marcar la selecc.
					for t=0 to ubound(RegTempos,2)
						marca=""
						if RegTempos(Tcodi,t)=RegSuples(STempo,r) then marca=" selected"%>
						<option value='<%=RegTempos(Tcodi,t)%>'<%=marca%>>
							<%=VerFecha(RegTempos(TFini,t)) & "-" & VerFecha(RegTempos(TFfin,t))%>
						</option>
					<%next%>
				</select>
			</td>
			<td align="center" class='<%=estilo%>'>
			<input type='text' name='precio-<%=RegSuples(SId,r)%>' value='<%=RegSuples(SPelas,r)%>' style="width:30px">
			</td>
			<td align="center" class='<%=estilo%>'>
			<input type="checkbox" name="defecto-<%=RegSuples(SId,r)%>" style="border:none" value="-1" <%if RegSuples(SDefecto,r) then response.write "checked"%>>
			</td>
      </tr>
	<%next
	end if%>
</table>
</div>
<div align='center' style='height:20px;'>
	<input name='boton4' type='button' value="<%=objIdioma.getTraduccionHTML("i_nuevo")%>" onclick="javascript:nuevoSuple();" class="boton145">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton5' type='submit' value="<%=objIdioma.getTraduccionHTML("i_modificar")%>" class="boton86">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton7' type='button' value="<%=objIdioma.getTraduccionHTML("i_borrar")%>" onclick='javascript:ABorrar();' class="boton86">
</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
