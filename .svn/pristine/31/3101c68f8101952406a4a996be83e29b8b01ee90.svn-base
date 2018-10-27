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

recarga=request.QueryString("recarga") 'id del frame de la ventana
est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
deleteTemporal="false"
%><!--#include file="actuTemporadas.asp"--><%

laid=paClng(request.QueryString("id"))

redim NombreOfertaIdiomas(ubound(ListaIdiomas))

if laid <> 0 then 'Busco el registro para modificar
	cs = "SELECT Finicio,FFinal,ReleaseHab,Minimo,CodigoEsta,Prepago"
	
	if idEmpresa = 98 then
		cs = cs & ", Oferta"
	end if
	
	cs = cs & " FROM " & precrs & "Temporadas "
	cs = cs & "WHERE CodigoTemp=" & laid
	rs.open cs,base
	if not rs.eof then
		fini=rs("FInicio")
		ffin=rs("FFinal")
		release=rs("ReleaseHab")
		minimo=paClng(rs("minimo"))
		est=rs("codigoesta")
		prepago=paDbl(rs("prepago"))
		
		if idEmpresa = 98 then
			oferta = rs("Oferta")
		end if
	end if
	rs.close


	'Busco las traducciones
	cs = "SELECT Idioma, Traduccion "
	cs = cs & "FROM " & precrs & "Traducciones "
	cs = cs & " WHERE IdReferencia =" & laid & " AND Tabla = 'Temporada'"
	
	rs.Open cs, base
	
	haynombres = false
	if not rs.eof then
		NombreTrad = rs.GetRows
		NTIdioma = 0
		NTTraduccion = 1

		haynombres = true		
	
		rs.close
	
		for i = 0 to ubound(NombreTrad, 2)		
			'Buscamos el indice en ListaIdiomas para este idioma
			idi = NombreTrad(NTIdioma, i)
			
			ind = -1
			
			for j = 0 to ubound(ListaIdiomas)			
				if(ListaIdiomas(j) = idi) then
					ind = j
					exit for
				end if
			next
			
			if ind <> -1 then
				NombreOfertaIdiomas(ind) = NombreTrad(NTTraduccion, i)
			end if		
		next
	end if
else 'por defecto
	release=1
	minimo=1	
	'buscar prepago del hotel
	cs="SELECT PorCiento FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & est
	rs.open cs,base
	if not rs.eof then
		prepago=paDbl(rs("porciento"))
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="<%=relative_url%>/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrameNoDelete('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar()
{
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&est=<%=est%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&est=<%=est%>&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">
		<%= ucase(objIdioma.getTraduccionHTML("i_temporada")) %>
        
        <% if fini <> "" then %>        
			-> <%= fini & " - " & ffin%>
        <% end if %>
    </div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>

<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px">
  <tr>
    <td class="tdTabla">

	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
    	<%if msgerror<>"" then 'problemas%>
        <tr><td colspan="2"><b><%=msgerror%></b></td></tr>       
        <%end if 'msgerror%>
      <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_desdedia")%></td>
        <td align='left'>
          <input type='text' name="fechainicio" value='<%=fini%>' maxlength="10" size='8'>
		  <img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('fechainicio','f1',self.name,'','<%=lang%>');" style="cursor:pointer">
&nbsp;&nbsp; <%=objIdioma.getTraduccionHTML("i_hastadia")%>
      	<input type='text' name="fechafinal" value='<%=ffin%>' maxlength="10" size='8'>
		<img src="img/calendar.gif" alt="" width="16" border="0" align="absmiddle" onClick="javascript:abreCalendar('fechafinal','f1',self.name,document.f1.fechainicio.value,'<%=lang%>');" style="cursor:pointer">&nbsp;<%=objIdioma.getTraduccionHTML("i_diamesanyo")%></td>
      </tr>
      <tr>
        <td align='right'>Release</td>
        <td align='left'>
		<input type='text' name="release" value='<%=release%>' maxlength="5" size='5'></td>
      </tr>
	  <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_estanciaminima")%></td>
        <td align='left'>
		<input type='text' name="minimo" value='<%=minimo%>' maxlength="5" size='5'></td>
      </tr>
	  <tr>
        <td align='right'><%=objIdioma.getTraduccionHTML("i_prepago")%></td>
        <td align='left'>
		<input type='text' name="prepago" value='<%=prepago%>' maxlength="6" size='5'></td>
      </tr>
		<%
			' Algunas empresas tienen esta característica
		  	if idEmpresa = 98 then
		%>		  
                <tr>
                    <td align='right'><%=objIdioma.getTraduccionHTML("i_es_oferta")%></td>
                    
                    <td align='left'>
	                    <input type="checkbox" name="oferta" value="1" maxlength="6" <% if oferta then %> checked <% end if %> size='5'>
					</td>
                </tr>
                
				<%
					for i = 0 to ubound(ListaIdiomas)
				%>
						<tr>
							<td align='right'><%=objIdioma.getTraduccionHTML("i_nombre_" & ListaIdiomas(i))%></td>
                            <td align='left'><input type="text" name="nombre_<%=ListaIdiomas(i) %>" value="<%=NombreOfertaIdiomas(i)%>" style="width: 300px" /></td>
						</tr>
				<%
					next
				%>
		<%			
			end if
		%>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" class='boton86' type='button' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccion("i_modificar")%>'>
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
	document.f1.fechainicio.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
