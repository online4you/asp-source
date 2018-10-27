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

if request.Form<>"" then
	if request.QueryString("modo")="borra" then 'pa borrar
		
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM " & precrs & "RegimenDtos WHERE "
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
			
		end if

	
	else 'actualiza
	
		'Actualizar precios
		'Buscar la lista 
		cs="SELECT RegimenDtos.Id "
		cs=cs & "FROM (" & precrs & "RegimenDtos RegimenDtos LEFT JOIN " & precrs & "RegimenHotel RegimenHotel "
		cs=cs & "ON RegimenDtos.IdRegimenHotel=RegimenHotel.Id) LEFT JOIN " & precrs & "Temporadas Temporadas "
		cs=cs & "ON RegimenHotel.CodigoTempo=Temporadas.CodigoTemp "
		cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND (CodigoHab=" & laId & " OR CodigoHab=0)"
		cs=cs & " AND RegimenHotel.Tarifa=" & laTarifa & " ORDER BY RegimenHotel.IdRegimen,CodigoColec,FInicio"
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
				regimen=paClng(request.form("regimen-" & RegIds(RgId,r)))
				colectivo=paClng(request.form("colectivo-" & RegIds(RgId,r)))
				dto=paDbl(request.form("dto-" & RegIds(RgId,r)))
				pelas=paDbl(request.form("precio-" & RegIds(RgId,r)))
				desdeplazas=paClng(request.form("desdeplazas-" & RegIds(RgId,r)))
				hastaplazas=paClng(request.form("hastaplazas-" & RegIds(RgId,r)))
				
				cs="UPDATE " & precrs & "RegimenDtos SET "
				cs=cs & "IdRegimenHotel=" & regimen & ","
				cs=cs & "CodigoColec=" & colectivo & ","
				cs=cs & "Descuento=" & quitarComa(dto) & ","
				cs=cs & "Precio=" & QuitarComa(pelas) & ","
				cs=cs & "DesdePlazas=" & desdeplazas & ","
				cs=cs & "HastaPlazas=" & hastaplazas & " "
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

'Regimen
'Precio Dtos Suplementos por temporadas
cs="SELECT RegimenDtos.Id,CodigoColec,Descuento,RegimenDtos.Precio,FInicio,FFinal,RegimenHotel.IdRegimen,RegimenHotel.Id,"
cs=cs & "DesdePlazas,HastaPlazas FROM (" & precrs & "RegimenDtos RegimenDtos LEFT JOIN " & precrs & "RegimenHotel RegimenHotel "
cs=cs & "ON RegimenDtos.IdRegimenHotel=RegimenHotel.Id) LEFT JOIN " & precrs & "Temporadas Temporadas "
cs=cs & "ON RegimenHotel.CodigoTempo=Temporadas.CodigoTemp "
cs=cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND (CodigoHab=" & laId & " OR CodigoHab=0)"
cs=cs & " AND RegimenHotel.Tarifa=" & laTarifa & " ORDER BY RegimenHotel.IdRegimen,CodigoColec,FInicio,RegimenDtos.Id"



rs.open cs,base
hayDsuples=false
if not rs.eof then
	RegDSuples=rs.getrows
	SDId=0
	SDColec=1
	SDDto=2
	SDPelas=3
	SDFIni=4
	SDFFin=5
	SDRegimen=6
	SDIdRHotel=7
	SDDesde=8
	SDHasta=9
	hayDsuples=true
end if
rs.close

'Tabla regimenes
cs="SELECT Regimen.Id,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) as Tradu FROM " & precrs & "Regimen Regimen LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "' "
rs.open cs,base
haysuples=false
if not rs.eof then
	RegSuples=rs.getrows
	SId=0
	SNombre=1
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
	font-size:10px;
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
function nuevoDtoSuple(){
	rutaPadre=parent.parent.self.name;
	rutaPadre=rutaPadre+"."+parent.self.name;
	rutaPadre=rutaPadre+"."+self.name;
	top.creaFlotante("nuevoDtoSupleHabi.asp?idh=<%=laId%>&est=<%=est%>&recarga="+rutaPadre,500,300,0,0);
}
</script>
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>">
<div class="tituloTabla" style="margin:0px"><%=objIdioma.getTraduccionHTML("i_dtosregimen")%></div>
<div id='listaHabi' style="height:150px; overflow-x:hidden; overflow-y:scroll">
<table align='center' border="0" cellpadding="0" cellspacing="1" width="96%">
      <tr>
	  	<th class="colu_par"></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_regimen")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_colectivo")%></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_plazas")%></th>
		<th class="colu_par" align="center">% <%=objIdioma.getTraduccionHTML("i_dto")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
      </tr>
	  <%if hayDsuples then
		for R=0 to ubound(RegDSuples,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
      <tr>	 
			<td align="left" class='<%=estilo%>'>
			<input type='checkbox' name='aborrar' value='<%=RegDSuples(SDId,r)%>'></td>
			<td align="left" class="<%=estilo%>">
			<%
			if haysuples then
			for s=0 to ubound(RegSuples,2)
				if RegSuples(SId,s)=RegDSuples(SDRegimen,r) then
					response.write RegSuples(SNombre,s)
				end if
			next 's
			end if 'haysuples
			
			if not isnull(RegDSuples(SDFini,r)) then
				response.write " (" & verFecha(RegDSuples(SDFini,r)) & "-" & verFecha(RegDSuples(SDFFin,r)) & ")"
			end if
			%>
			</td>
			<td align="center" class="<%=estilo%>">
			<select name='colectivo-<%=RegDSuples(DSId,r)%>' style="width:90px;">
				<%'Poner lista de Colectivos y marcar la selecc.
				for c=0 to ubound(RegColec,2)
					marca=""
					if RegColec(CCodi,c)=RegDSuples(SDColec,r) then marca=" selected"%>
					<option value='<%=RegColec(CCodi,c)%>'<%=marca%>>
						<%=RegColec(CNombre,c)%>
					</option>
				<%next%>
			</select>
			<input type="hidden" name="regimen-<%=RegDSuples(SDId,r)%>" value="<%=RegDSuples(SDIdRHotel,r)%>">
			</td>
            <td align="center" class='<%=estilo%>'>
            <input type='text' name='desdeplazas-<%=RegDSuples(SDId,r)%>' value='<%=RegDSuples(SDDesde,r)%>' style='width:12px' maxlength="2"> -
            <input type='text' name='hastaplazas-<%=RegDSuples(SDId,r)%>' value='<%=RegDSuples(SDHasta,r)%>' style='width:12px' maxlength="2">
			</td>
			<td align="center" class='<%=estilo%>'>
			<input type='text' name='dto-<%=RegDSuples(SDId,r)%>' value='<%=RegDSuples(SDDto,r)%>' style="width:30px">
			</td>
			<td align="center" class='<%=estilo%>'>
			<input type='text' name='precio-<%=RegDSuples(SDId,r)%>' value='<%=RegDSuples(SDPelas,r)%>' style="width:30px">
			</td>
      </tr>
	<%next
	end if%>
</table>
</div>
<div align='center' style='height:20px;'>
	<input name='boton4' type='button' value="<%=objIdioma.getTraduccionHTML("i_nuevo")%>" onclick="javascript:nuevoDtoSuple();" class="boton145">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton5' type='submit' value="<%=objIdioma.getTraduccionHTML("i_modificar")%>" class="boton86">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton7' type='button' value="<%=objIdioma.getTraduccionHTML("i_borrar")%>" onclick='javascript:ABorrar();' class="boton86">
</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
