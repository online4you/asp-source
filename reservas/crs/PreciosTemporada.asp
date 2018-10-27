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
	'Actualizar precios
	'Buscar la lista de ids de serviciostemporadas
	cs="SELECT Temporada,FInicio,FFinal FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "Temporadas Temporadas "
	cs=cs & " ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
	cs=cs & " WHERE IdHabita=" & laId & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") AND Tarifa=" & laTarifa
	cs=cs & " ORDER BY FInicio"
	'response.Write(cs & "<br>")
	rs.open cs,base
	hayregis=false
	if not rs.eof then
		RegIds=rs.getrows
		RgTempo=0
		RgFIni=1
		RgFFin=2
		hayregis=true
	end if
	rs.close
	
	'on error resume next
	base.BeginTrans
	
	'Solo se puede actualizar
	if hayregis then 'Actualizar todos los registros
		for r=0 to ubound(RegIds,2)
		
			pelas=request.form("importe_" & RegIds(RgTempo,r))
			'response.write quitarComaMiles(pelas) & "<br>"
			tipo=request.form("tipo_" & RegIds(RgTempo,0))
			cs="UPDATE " & precrs & "TipoHabitaPrecios SET "
			cs=cs & "PrePreBase=" & QuitarComaMiles(pelas) & ","
			cs=cs & "PreperHab=" & QuitarComa(tipo) & " "
			cs=cs & "WHERE IdHabita=" & laId & " AND Temporada=" & RegIds(RgTempo,r) & " AND Tarifa=" & laTarifa
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actualiza en cupos los precios
			cs="UPDATE " & precrs & "Cupos SET Precio=" & QuitarComaMiles(pelas)
			cs=cs & " WHERE CodigoHab=" & laId & " AND (Dia BETWEEN " & FechaMySQL(RegIds(RgFIni,r)) 
			cs=cs & " AND " & FechaMySQL(RegIds(RgFFin,r)) & ") AND Tarifa=" & laTarifa
			'response.write cs
			base.execute cs

			
		next 'registro temporadas
		
	end if
	if err.number<>0 then base.RollBackTrans
	base.CommitTrans
	on error goto 0

end if

'Busco los precios de esa habitacion
cs= "SELECT IdHabita,Temporada,Preprebase,Preperhab,FInicio,FFinal "
cs=cs & "FROM " & precrs & "TipoHabitaPrecios TipoHabitaPrecios INNER JOIN " & precrs & "Temporadas Temporadas "
cs=cs & "ON TipoHabitaPrecios.Temporada=Temporadas.CodigoTemp "
cs=cs & "WHERE IdHabita=" & laid & " AND (YEAR(FInicio)=" & anyo & " OR YEAR(FFinal)=" & anyo & ") AND Tarifa=" & laTarifa
cs=cs & " ORDER BY FInicio"
'response.write cs
rs.open cs,base
hayprecios=false
if not rs.eof then
	RegPrecios=rs.getrows
	PCodi=0
	PTempo=1
	PPrecio=2
	PPorH=3
	PFIni=4
	PFFin=5
	hayprecios=true
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
	font-size:11px;
	height:12px;
}
</style>
</head>
<body>
<form name='f1' method="post" action="<%=MiPag%>?id=<%=laid%>&est=<%=est%>">
<div class="tituloTabla" style="margin:0px"><%=objIdioma.getTraduccionHTML("i_preciostemporada")%></div>
<div id='listaHabi' style="height:150px; overflow-x:hidden; overflow-y:scroll">
<table align='center' border="0" cellpadding="0" cellspacing="1" width="100%">
      <tr>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_temporada")%></th>
        <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
		<th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_tipocalculo")%></th>
      </tr>
	  <%if hayprecios then
		for R=0 to ubound(RegPrecios,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
      <tr>	 
		<td align="center" class='<%=estilo%>'>
			<%=verFecha(RegPrecios(PFIni,r)) & " - " & verFecha(RegPrecios(PFFin,r))%>
		</td>
        <td align="center" class='<%=estilo%>'>
          <input type="text" name="importe_<%=RegPrecios(PTempo,r)%>" value="<%=formatnumber(RegPrecios(PPrecio,r),2)%>" style="width:50px">
        </td>
		<%if r=0 then 'solo aparece en la primera%>
		<td align='center' class='<%=estilo%>' rowspan="<%=ubound(RegPrecios,2)+1%>">
			<%
			marca0=""
			marca1=""
			if RegPrecios(PPorH,p) then 'Marca la opcion
				marca1=" checked"
			else
				marca0=" checked"
			end if				
			%>
			<input type="radio" name="tipo_<%=RegPrecios(PTempo,r)%>"  style='height:13px;border:none; width:13px' value="0"<%=marca0%>>
			<%=objIdioma.getTraduccionHTML("i_xpersona")%>
			&nbsp;&nbsp;
			<input type="radio" name="tipo_<%=RegPrecios(PTempo,r)%>"  style='height:13px;border:none; width:13px' value="-1"<%=marca1%>>
			<%=objIdioma.getTraduccionHTML("i_xhabitacion")%>
		</td>
		<%end if%>
      </tr>
	<%next
	end if%>
</table>
</div>
<div align='center' style='height:20px;'>
	<input name='boton' type='submit' value="<%=objIdioma.getTraduccionHTML("i_actuprecios")%>" class="boton145">
</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
