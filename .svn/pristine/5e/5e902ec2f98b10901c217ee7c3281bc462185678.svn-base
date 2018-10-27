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

ids=paClng(request.QueryString("ids")) 'id seccion
idh=paClng(request.QueryString("idh")) 'codigo hotel
pasalir=0
dim TIdiomas() 'texto traduccion

if request.Form<>"" then 'actulizar y salir

	texto=QuitarApos(request.form("texto_" & langPorDefecto))
	laid=paClng(request.form("id"))
	
	redim TIdiomas(ubound(ListaIdiomas))
	for idi=1 to ubound(ListaIdiomas)
		TIdiomas(idi)=QuitarApos(request.form("texto_" & listaIdiomas(idi)))
	next 'idi

	on error resume next
	base.BeginTrans

	'Buscar si existe
	cs="SELECT Id FROM " & precrs & "TextosHotel WHERE IdSeccion=" & ids
	rs.open cs,base
	if not rs.eof then
		laid=rs("id")
		rs.close
		
		cs="UPDATE " & precrs & "TextosHotel SET "
		cs=cs & "Texto='" & texto & "' "
		cs=cs & "WHERE Id=" & laid
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
	
	else 'crear registro
		cs="INSERT INTO " & precrs & "TextosHotel (CodigoEsta,IdSeccion,Texto) VALUES (" & idh & "," & ids & ",'" & texto & "')"
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
		'Buscar ultimo registro
		rs.close
		cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TextosHotel"
		rs.open cs,base
		if not rs.eof then
			laid=paClng(rs("ulti"))
		end if
		rs.close
	end if 'not eof
	
			
	'Actu traduccion
	for idi=1 to ubound(ListaIdiomas)
		if TIdiomas(idi)<>"" then 'buscar si existe
			cs="SELECT Id FROM " & precrs & "Traducciones WHERE Tabla='TextosHotel' AND Campo='Texto' AND "
			cs=cs & "Idioma='" & ListaIdiomas(idi) & "' AND IdReferencia=" & laid
			rs.open cs,base
			if not rs.eof then
				cs="UPDATE " & precrs & "Traducciones SET Traduccion='" & TIdiomas(Idi) & "' "
				cs=cs & "WHERE Id=" & rs("id")
				base.execute cs
			
			else
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion) VALUES ("
				cs=cs & laid & ",'" & listaIdiomas(idi) & "','TextosHotel','Texto','"
				cs=cs & TIdiomas(idi) & "')"
				base.execute cs
			end if 'eof
			rs.close
		else 'borrarlo si esta en blanco
			
			cs="DELETE FROM " & precrs & "Traducciones WHERE Tabla='TextosHotel' AND Campo='Texto' "
			cs=cs & "AND Idioma='" & ListaIdiomas(Idi) & "' AND IdReferencia=" & laid
			base.execute cs
			
		end if
	next 'idi
	
	if err.number<>0 then base.RollBackTrans
	base.CommitTrans
	on error goto 0



end if 'Form<>""

laid=0
redim TIdiomas(ubound(ListaIdiomas))
cs="SELECT TextosHotel.Id,Texto,Idioma,Traduccion "
cs=cs & "FROM " & precrs & "TextosHotel TextosHotel LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TextosHotel.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TextosHotel' AND Campo='Texto' WHERE TextosHotel.IdSeccion=" & ids
rs.open cs,base
haytexto=false
do while not rs.eof
	haytexto=true
	laid=rs("id")
	Texto_es=rs("texto")
	TIdiomas(0)=texto_es
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
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	parent.cerrar(); //quito esa ventana
}

function Modificar(){
	document.f1.action="<%=MiPag%>?modo=actu&ids=<%=ids%>&idh=<%=idh%>";
	document.f1.submit();
}
function cargaTexto(campo,valor){
	//document.getElementById('capa'+campo).innerHTML=valor;
	document.getElementById(campo).value=valor;
}
</script>
</head>
<body class="laFicha">
<form name='f1' action="<%=MiPag%>" method="post">
<div style="height:380px; width:<%=maxAncho%>px; overflow-x:hidden; overflow-y:scroll;">		
	<table align='center' width='<%=anchoDispo%>' border='0' cellpadding="0" cellspacing="2">
    <%
	colu=1
	maxColu=4
	for idi=0 to ubound(listaIdiomas)%>
		<td align='left'>
		<%=objIdioma.getTraduccionHTML("i_tradu_" & listaIdiomas(idi))%>: <input type="button" value="Editor" class="boton86" onClick="javascript:abreEditor('texto_<%=listaIdiomas(idi)%>',680,420);"><br/>   
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
</div>
<center>
    <input id='boton' type='button' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();">	
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="hidden" name="id" value="<%=laid%>">
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
</form>
</body>
</html>