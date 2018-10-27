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
		
		queborro=split(request.form("dtoborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM " & precrs & "DescuentosColectivos WHERE "
			for t=0 to ubound(queborro)
				'Buscar los datos
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
		end if

	
	else 'actualiza
	
		'Actualizar precios
		'Buscar la lista de ids de serviciostemporadas
		cs="SELECT DescuentosColectivos.Id "
		cs=cs & "FROM (" & precrs & "DescuentosColectivos DescuentosColectivos LEFT JOIN " & precrs & "Colectivos Colectivos "
		cs=cs & "ON DescuentosColectivos.CodigoColec=Colectivos.CodigoColec) LEFT JOIN " & precrs & "Temporadas Temporadas "
		cs=cs & "ON DescuentosColectivos.Temporada=Temporadas.CodigoTemp "
		cs=cs & "WHERE TipoHab=" & laId & " AND Anyo=" & anyo & " AND Tarifa=" & laTarifa & " ORDER BY Colectivos.Orde,FInicio"
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
				colec=paClng(request.form("colectivo-" & RegIds(RgId,r)))
				tempo=paClng(request.form("temporada-" & RegIds(RgId,r)))
				dto=paDbl(request.form("dto-" & RegIds(RgId,r)))
				pelas=paDbl(request.form("precio-" & RegIds(RgId,r)))
				desdeplazas=paClng(request.form("desdeplazas-" & RegIds(RgId,r)))
				hastaplazas=paClng(request.form("hastaplazas-" & RegIds(RgId,r)))
				cs="UPDATE " & precrs & "DescuentosColectivos SET "
				cs=cs & "CodigoColec=" & colec & ","
				cs=cs & "Temporada=" & Tempo & ","
				cs=cs & "PreBase=" & QuitarComa(dto) & ","
				cs=cs & "Precio=" & QuitarComa(pelas) & ","
				cs=cs & "DesdePlazas=" & QuitarComa(desdeplazas) & ","
				cs=cs & "HastaPlazas=" & QuitarComa(hastaplazas) & " "
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

'Dtos colectivos por habitacion y temporada, y establecimiento
cs="SELECT DescuentosColectivos.CodigoColec,Temporada,Prebase,Precio,DescuentosColectivos.Id,DesdePlazas,HastaPlazas "
cs=cs & "FROM (" & precrs & "DescuentosColectivos DescuentosColectivos LEFT JOIN " & precrs & "Colectivos Colectivos "
cs=cs & "ON DescuentosColectivos.CodigoColec=Colectivos.CodigoColec) LEFT JOIN " & precrs & "Temporadas Temporadas "
cs=cs & "ON DescuentosColectivos.Temporada=Temporadas.CodigoTemp "
cs=cs & "WHERE TipoHab=" & laId & " AND Anyo=" & anyo & " AND Tarifa=" & laTarifa & " ORDER BY Colectivos.Orde,Temporadas.FInicio"
rs.open cs,base
haydtos=false
if not rs.eof then
	RegDtos=rs.getrows
	DCodi=0
	DTempo=1
	Ddto=2
	DPrecio=3
	DId=4
	DDesde=5
	DHasta=6
	haydtos=true
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
</style>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&id=<%=laid%>&est=<%=est%>";
		document.f1.submit();
	}
}

function nuevoDto3(){
	rutaPadre=parent.parent.self.name;
	rutaPadre=rutaPadre+"."+parent.self.name;
	rutaPadre=rutaPadre+"."+self.name;
	top.creaFlotante("nuevoDto3Habi.asp?idh=<%=laId%>&est=<%=est%>&recarga="+rutaPadre,400,350,0,0);
}
</script>
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>">
<div class="tituloTabla" style="margin:0px"><%=objIdioma.getTraduccionHTML("i_dtocamahabitacion")%></div>
<div id='listaHabi' style="height:150px;">
<table align='center' border="0" cellpadding="0" cellspacing="1" width="100%">
      <tr>
	  	<th class="colu_par"></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_colectivo")%></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_plazas")%></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_temporada")%></th>
		<th class="colu_par" align="center">% <%=objIdioma.getTraduccionHTML("i_dto")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
      </tr>
	  <%if haydtos then
		for R=0 to ubound(RegDtos,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
		<tr>
				<td align="center" class='<%=estilo%>'><input type='checkbox' name='dtoborrar' value='<%=RegDtos(DId,r)%>'></td>
				<td align="center" class='<%=estilo%>'>
					<select name='colectivo-<%=RegDtos(DId,r)%>'>
				<%'Poner lista de Colectivos y marcar la selecc.
						for c=0 to ubound(RegColec,2)
							marca=""
							if RegColec(CCodi,c)=RegDtos(DCodi,r) then marca=" selected"%>
							<option value='<%=RegColec(CCodi,c)%>'<%=marca%>>
								<%=RegColec(CNombre,c)%>
							</option>
						<%next%>
					</select>
				</td>
                <td align="center" class='<%=estilo%>'>
				<input type='text' name='desdeplazas-<%=RegDtos(DId,r)%>' value='<%=RegDtos(DDesde,r)%>' style='width:15px' maxlength="2">
                -
				<input type='text' name='hastaplazas-<%=RegDtos(DId,r)%>' value='<%=RegDtos(DHasta,r)%>' style='width:15px' maxlength="2">
				</td>
				<td align="center" class='<%=estilo%>'>
					<select name='temporada-<%=RegDtos(DId,r)%>'>
						<option value='0'><%=objIdioma.getTraduccionHTML("i_cualquiera")%></option>
						<%'Poner lista de temporadas y marcar la selecc.
						for t=0 to ubound(RegTempos,2)
							marca=""
							if RegTempos(Tcodi,t)=RegDtos(DTempo,r) then marca=" selected"%>
							<option value='<%=RegTempos(Tcodi,t)%>'<%=marca%>>
								<%=VerFecha(RegTempos(TFini,t)) & " - " & VerFecha(RegTempos(TFfin,t))%>
							</option>
						<%next%>
					</select>
				</td>
				<td align="center" class='<%=estilo%>'>
				<input type='text' name='dto-<%=RegDtos(DId,r)%>' value='<%=RegDtos(DDto,r)%>' style='width:30px' maxlength="8">
				</td>
				<td align="center" class='<%=estilo%>'>
				<input type='text' name='precio-<%=RegDtos(DId,r)%>' value='<%=RegDtos(DPrecio,r)%>' style="width:30px" maxlength="8">
				</td>
      </tr>
	<%next
	end if%>
</table>
</div>
<div align='center' style='height:22px; overflow:hidden'>
	<input name='boton4' type='button' value="<%=objIdioma.getTraduccionHTML("i_nuevo")%>" onclick="javascript:nuevoDto3();" class="boton86">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton5' type='submit' value="<%=objIdioma.getTraduccionHTML("i_modificar")%>" class="boton86">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input name='boton7' type='button' value="<%=objIdioma.getTraduccionHTML("i_borrar")%>" onclick='javascript:ABorrar();' class="boton86">
</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
