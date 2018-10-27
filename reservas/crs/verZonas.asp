<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

dim TIdiomas() 'texto traduccion

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

%><!--#include file="actuZonas.asp"--><%

redim TIdiomas(ubound(ListaIdiomas))
laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Zonas.Id,Zona"
	for idi=1 to ubound(ListaIdiomas)
		'cs=cs & ",ISNULL(dbo.fnGetTraduccion('Zonas','Zona',Id,'" & listaIdiomas(idi) & "'),Zona) AS Zona_" & listaIdiomas(idi)
		cs=cs & ",IF(ISNULL(traduc.Traduccion),Zonas.Zona,traduc.Traduccion) AS Zona_" & listaIdiomas(idi)
	next 'idi
	cs=cs & ",IdPadre "
	cs=cs & "FROM " & precrs & "Zonas Zonas LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""Zonas"" And Campo = ""Zona"" And Idioma = """ & idioma & """)  AS traduc ON Zonas.Id = traduc.IdReferencia "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		IdPadre=rs("IdPadre")
		TIdiomas(0)=rs("Zona")
		for idi=1 to ubound(ListaIdiomas)
			TIdiomas(idi)=rs("Zona_" & ListaIdiomas(Idi))
		next 'idi
	end if
	rs.close
end if

ZCodi=0
ZNombre=1
ZPadre=2
ZNivel=3
set claseZona=new clsListadoZonas
RegZonas=claseZona.cargaListaZonas(0,0,lang) '(idpadre,nivel,idioma)
set claseZona=nothing

'dim RegZonas()
'estructuraZonas 0,0 'todas
'RegZonas=registrosZona()

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";

	document.f1.submit();
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_zona")%> -> <%=TIdiomas(0)%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
	
	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
    <%for idi=0 to ubound(listaIdiomas)%>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>:</td>
		<td align='left'><input type='text' size='30' maxlength='75' name='nombre_<%=listaIdiomas(idi)%>' value='<%=TIdiomas(Idi)%>'></td>
	</tr>
    <%next 'idi%>
    <tr><td align="right">Zona Superior</td>
    	<td>
        <select name="idpadre">
        <option value="0">Ninguna</option>
        <%
		if not isnull(RegZonas) then
		for z=0 to ubound(RegZonas,2)
			marca=""
			tabZona="padding-left:" & (10*RegZonas(ZNivel,z)+3) & "px"
			laZona=RegZonas(ZNombre,z)
			if RegZonas(ZNivel,z)>0 then laZona="- " & laZona
			if RegZonas(ZCodi,z)=IdPadre then marca=" selected"%>
          	<option style="<%=tabZona%>" value="<%=RegZonas(ZCodi,z)%>"<%=marca%>><%=laZona%></option>  
		<%next
		end if 'zonas %>
        </select>
        </td>
    </tr>
	<tr><td align='center' colspan='2'>
	<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>"></table>

	</td>
  </tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.nombre_<%=langPorDefecto%>.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
