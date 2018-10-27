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
est=paClng(request.QueryString("est"))

%><!--#include file="actuPrecioServicio.asp"--><%

'Lista de registros
cs = "SELECT Id,FechaInicio,FechaFinal,IdColectivo,Tipo,Importe,Obligatorio"
cs = cs & ", IncluirEnOferta"


cs = cs & " FROM " & precrs & "ServiciosPrecios "
cs = cs & "WHERE IdServicio=" & ids 
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RFIni=1
	RFFin=2
	RColec=3
	RTipo=4
	RPelas=5
	RObliga=6
	RIncluir=7
	haylista=true
end if
rs.close

'Bucar los nombres colectivos de este hotel
cs="SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion)  as Tradu,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND "
cs=cs & "Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
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
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra&ids=<%=ids%>&est=<%=est%>";
		document.f1.submit();
	}
}

function enBlanco(){
	//palIframe(document.getElementById("verFicha"),450,250,0,0,"verTemporadas.asp?id=0&p=<%=pag%>&est=<%=est%>");
	top.creaFlotante("servicios/verPrecioServicio.asp?id=0&ids=<%=ids%>&recarga="+parent.self.name,550,300,0,0);
}
function verFicha(id){
	//palIframe(document.getElementById("verFicha"),510,250,0,0,"verTemporadas.asp?id="+id+"&est=<%=est%>");
	top.creaFlotante("servicios/verPrecioServicio.asp?id="+id+"&ids=<%=ids%>&recarga="+parent.self.name,550,300,0,0);
}

</script>
<body>
<form name='f1' method="post" action="<%=MiPag%>">
	<div style="height:195px; overflow:hidden; margin-top:10px;">
	<table border="0" align='center' cellpadding="0" cellspacing="0" width="80%">
      <tr>
	  	<th class="colu_par"></th>
        <th class="colu_par">ID</th>
        <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_fechainicio")%></th>
		<th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_fechafinal")%></th>
        <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_colectivo")%></th>
        <th class="colu_par" align='right'><%=objIdioma.getTraduccionHTML("i_importe")%></th>
        <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_tipocalculo")%></th>
		<th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_obligado")%></th>
		
		<%  ' Algunas empresas tienen esta característica
			if idEmpresa = 98 then %>
        		<th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_incluirloenoferta")%></th>
		<%  end if %>
        
      </tr>
	  <%if haylista then
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
      <tr>	 
	  <td width='20' class='<%=estilo%>' align="center">
          <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
        </td>
		<td align="center" class='<%=estilo%>'>
		<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a></td>
		<td align="center" class='<%=estilo%>'>
		<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RFIni,r)%></a></td>
		<td align="center" class='<%=estilo%>'>
		<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RFFin,r)%></a></td>
        <td align="center" class='<%=estilo%>' >
			<%if RegLista(RColec,r)=0 then 'Cualqiuer colectivo
				response.write objIdioma.getTraduccionHTML("i_cualquiera")
			else 'Buscar nombre colectivo
				for c=0 to ubound(RegColec,2)
					if RegColec(CCodi,c)=RegLista(RColec,r) then 'Esta es%>
						<%=RegColec(CNombre,c)%>
			  		<%end if
				next
			end if%>
        </td>
        <td align="right" class='<%=estilo%>' >
          <%=formatNumber(paDbl(RegLista(RPelas,r)),2)%>
        </td>
        <td align="center" class='<%=estilo%>'>
			<%select case RegLista(RTipo,r)
			case porpersona
				response.write "por persona" & vbcrlf
			case porreserva
				response.write "por reserva" & vbcrlf
			case pordia
				response.write "por d&iacute;a" & vbcrlf
			'case porpersonaydia
				'response.write "&nbsp;por persona y d&iacute;a" & vbcrlf
			case porhabitacion
				response.write "por habitación" & vbcrlf
		end select%>
		</td>
		<td align="center" class='<%=estilo%>' >
          <%if RegLista(RObliga,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
        </td>
        
        <% ' Algunas empresas tienen esta característica
			if idEmpresa = 98 then %>
                <td align="center" class='<%=estilo%>' >
					<%if RegLista(RIncluir,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
                </td>
		<% end if %>
      </tr>
	<%next
	end if%>
	</table>
	</div>
	<div align="center">
		<input name='boton' type='button' value="Nuevo Precio" onclick="javascript:enBlanco();" class='boton86'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input name='boton' type='button' value="Borrar Marcados" onclick='javascript:ABorrar();' class='boton86'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input name='boton' type='button' value="Cerrar" onclick='javascript:parent.cerrar();' class='boton86'>
	</div>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
