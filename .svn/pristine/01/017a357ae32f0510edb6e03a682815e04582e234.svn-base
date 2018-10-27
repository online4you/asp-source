<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))

pasalir=0
%>
<!--#include file="ActuTextosHabitacion.asp"-->
<%
redim TIdiomas(ubound(ListaIdiomas))
laid=paClng(request.QueryString("idh"))
if laid<>0 then 'Busco el registro
	cs="SELECT Texto,Idioma,Traduccion FROM " & precrs & "HabitacionesHotel HabitacionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
	cs=cs & "ON HabitacionesHotel.IdHabitacion=Traducciones.IdReferencia "
	cs=cs & "AND Tabla='HabitacionesHotel' AND Campo='Texto' "
	cs=cs & "WHERE IdHabitacion=" & laid
	rs.open cs,base
	if not rs.eof then
		do while not rs.eof
			TIdiomas(0)="" & rs("Texto") 'idi principal
			for idi=1 to ubound(ListaIdiomas)
				if ListaIdiomas(idi)=rs("idioma") then 'este
					TIdiomas(idi)=rs("traduccion")
					exit for
				end if
			next 'idi
			rs.movenext
		loop
	else
		'crear registro
		cs="INSERT INTO " & precrs & "HabitacionesHotel (CodigoEsta,IdHabitacion) VALUES (" & est & "," & laid & ")"
		base.execute cs
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing

'calcula ancho del textarea
maxAncho=970 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>2 then 'hay mas de cuatro y sólo pongo 4 idiomas por fila
	anchoColu=paClng(anchoDispo/4)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript">
function Modificar(){
	document.f1.action="<%=MiPag%>?idh=<%=laid%>";
	document.f1.submit();
}

function cerrar(){
	parent.cerrar();
}


</script>
</head>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="post">
<table align='center' width='<%=anchoDispo%>' border='0' cellpadding="0" cellspacing="2">
	<tr>
    <%
	colu=1
	maxColu=4
	for idi=0 to ubound(listaIdiomas)%>
		<td align='left'>
		<%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_<%=listaIdiomas(idi)%>',680,450);"><br/>        
		<textarea name="texto_<%=listaIdiomas(idi)%>" id='texto_<%=listaIdiomas(idi)%>' style="width:<%=anchoColu%>px; height:140px;"><%=TIdiomas(Idi)%></textarea>
        </td>
        <%colu=colu+1
		if colu>maxColu then
			response.write "</tr><tr>"
			colu=1
		end if
    next 'idi%>
    </tr>
</table>
<center>
    <input id='boton' type='button' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();">	
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="hidden" value="<%=laid%>" name="id">
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
