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

idh=paClng(request.QueryString("idh"))
pasalir=0
dim TIdiomas() 'texto traduccion

if request.Form<>"" then 'actualizar y salir

	texto=QuitarApos(request.form("texto_" & langPorDefecto))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi

	on error resume next
	base.BeginTrans

	'Buscar si existe
	cs="SELECT CodigoEsta FROM " & precrs & "CondicionesHotel WHERE CodigoEsta=" & idh
	rs.open cs,base
	if not rs.eof then
		cs="UPDATE CondicionesHotel SET "
		cs=cs & "Texto='" & texto & "' "
		cs=cs & "WHERE CodigoEsta=" & idh
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	
	else 'crear registro
		cs="INSERT INTO " & precrs & "CondicionesHotel (CodigoEsta,Texto) VALUES (" & idh & ",'" & texto & "')"
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	end if 'not eof
	rs.close	
			
	'Actu traduccion
	for idi=1 to ubound(ListaIdiomas)
		if TIdiomas(idi)<>"" then 'buscar si existe
			cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='CondicionesHotel' AND Campo='Texto' AND "
			cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & idh
			rs.open cs,base
			if not rs.eof then
				cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
				cs=cs & "WHERE Id=" & rs("id")
				base.execute cs
			
			else
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & idh & ",'" & listaIdiomas(idi) & "','CondicionesHotel','Texto','"
				cs=cs & TIdiomas(idi) & "'," & idh & ")"
				base.execute cs
			end if 'eof
			rs.close
		else 'borrarlo si esta en blanco
			
			cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='CondicionesHotel' AND Campo='Texto' "
			cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & idh
			base.execute cs
			
		end if
	next 'idi
	
	if err.number<>0 then base.RollBackTrans
	base.CommitTrans
	on error goto 0

	pasalir=1


end if 'Form<>""

'Nombre del hotel
cs="SELECT Nombre FROM " & precrs & "Establecimientos WHERE CodigoEsta=" & idh
rs.open cs,base
if not rs.eof then
	NombreHotel=rs("nombre")
end if
rs.close

redim TIdiomas(ubound(ListaIdiomas))
cs="SELECT CondicionesHotel.CodigoEsta,Texto,Idioma,Traduccion "
cs=cs & "FROM " & precrs & "CondicionesHotel CondicionesHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON CondicionesHotel.CodigoEsta=Traducciones.IdReferencia "
cs=cs & "AND Tabla='CondicionesHotel' AND Campo='Texto' WHERE CondicionesHotel.CodigoEsta=" & idh
rs.open cs,base
do while not rs.eof
	Texto_es="" & rs("Texto")
	for idi=1 to ubound(ListaIdiomas)
		if ListaIdiomas(idi)=rs("idioma") then 'este
			TIdiomas(idi)=rs("traduccion")
			exit for
		end if
	next 'idi
	
	rs.movenext
loop
rs.close

'calcula ancho del textarea
maxAncho=960 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>2 then 'hay mas de cuatro y sólo pongo 4 idiomas por fila
	anchoColu=paClng(anchoDispo/4)
else
	anchoColu=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if


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
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?idh=<%=idh%>";
	document.f1.submit();
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_condicioneshotel"))%> -> <%=nombreHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table align='center' width='<%=anchoDispo%>' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left'><%=objIdioma.getTraduccionHTML("i_textoseccion")%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_es',680,450);"><br/>
    	<textarea name="texto_es" id='texto_es' style="width:<%=anchoColu%>px; height:140px;"><%=texto_es%></textarea>
        </td>
    <%
	colu=2
	maxColu=4
	for idi=1 to ubound(listaIdiomas)%>
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
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>