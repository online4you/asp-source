<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../fechasCalendario.asp"-->
<!--#include file="constantesMenus.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
dim TIdiomas() 'titulo traduccion
redim TIdiomas(ubound(ListaIdiomas))

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana

%><!--#include file="actuMenu.asp"--><%

laid=paClng(request.QueryString("id"))
if laid<>0 then 'Busco el registro para modificar
	cs="SELECT Id,IdPadre,TipoEnlace,TipoOpen,URL,Ancho,Alto,Scroll,FechaInicio,FechaCaduca,Orden,NivelAcceso,Activo"
	for idi=0 to ubound(ListaIdiomas)
		cs=cs & ",ISNULL(dbo.fnGetTraduccion('Menus','Titulo',Id,'" & ListaIdioma(idi) & "'),Nombre) AS Titulo_" & ListaIdioma(idi)
	next
	cs=cs & " FROM " & precrs & "Menus "
	cs=cs & "WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		IdPadre=rs("IdPadre")
		tipoEnlace=rs("TipoEnlace")
		TipoOpen=rs("TipoOpen")
		laURL=rs("URL")
		Ancho=rs("Ancho")
		Alto=rs("Alto")
		scroll=rs("scroll")
		FInicio=rs("FechaInicio")
		FCaduca=rs("FechaCaduca")
		Orden=rs("Orden")
		Nivel=rs("NivelAcceso")
		activo=rs("Activo")
		
		for idi=0 to ubound(ListaIdiomas)
			TIdiomas(idi)=rs("titulo_" & ListaIdioma(idi))
		next 'idi
		
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing

'calcula ancho del textarea
maxAncho=1000 'ancho total iframe
anchoDispo=maxAncho-30-((ubound(listaIdiomas)+1)*4) 'quitar scroll y espacio entre celdas
if ubound(listaIdiomas)>4 then 'hay mas de cinco y sólo pongo 5 idiomas por fila
	anchoText=paClng(anchoDispo/5)
else
	anchoText=paClng(anchoDispo/(ubound(listaIdiomas)+1))
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
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
	<div class="nombreFicha">Men&uacute; -> <%=TIdiomas(0)%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="post">
<table class="tdTabla" border="0" align="center" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px; line-height:22px">
	<%if laid<>0 then %>
    <tr><td align='left' colspan="3">Id: <b><%=laId%></b></td></tr>
    <%end if%>
  <tr>
    <td colspan="3">
		
        <table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
        <tr>
        <%
        colu=1
        maxColu=5
        for idi=0 to ubound(listaIdiomas)
            titulo=TIdiomas(Idi)%>
            <td align='left'>
            <%=objIdioma.getTraduccionHTML("i_titulo_" & listaIdiomas(idi))%>:<br/>
            <input type="text" maxlength="75" style="width:<%=anchoText%>px" value='<%=titulo%>' name="titulo_<%=listaIdiomas(idi)%>">
            </td>
            <%colu=colu+1
            if colu>maxColu then
                response.write "</tr><tr>"
                colu=1
            end if
        next 'idi%>
        </tr>
        </table>
    
    </td>
	</tr>
	<tr>
		<td align='right'>Nivel Superior:</td>
        <td align="left" colspan="2">
        </td>
    </tr>
	<tr>
		<td align='right'>Tipo Enlace:</td>
        <td align="left">
        <select name="tipoenlace">
        <option value="<%=c_tipoNoEnlaza%>"<%if tipoEnlace=c_tipoNoEnlaza then response.write " selected"%>>no enlaza</option>
        <option value="<%=c_tipoContenido%>"<%if tipoEnlace=c_tipoContenido then response.write " selected"%>>a contenido</option>
        <option value="<%=c_tipoBanner%>"<%if tipoEnlace=c_tipoBanner then response.write " selected"%>>a banner</option>
        <option value="<%=c_tipoURL%>"<%if tipoEnlace=c_tipoURL then response.write " selected"%>>URL</option>
        </select>
        </td>
        <td align="left">URL: <input type="text" name="url" value="<%=laURL%>" maxlength="200" style="width:250px"></td>
    </tr>
	<tr>
		<td align='right'>abre enlace:</td>
        <td align="left">
        <select name="tipoOpen">
        <option value="<%=c_tipoMisma%>"<%if tipoOpen=c_tipoMisma then response.write " selected"%>>misma ventana</option>
        <option value="<%=c_tipoOtra%>"<%if tipoOpen=c_tipoOtra then response.write " selected"%>>otra ventana</option>
        <option value="<%=c_tipoVentana%>"<%if tipoOpen=c_tipoVentana then response.write " selected"%>>en ventana emergente</option>
        </select>
        </td>
        <td align="left" id='size'>
        Tamaño ventana:  ancho <input type="text" maxlength="5" name="ancho" value="<%=ancho%>" style="width:40px"> 
        alto <input type="text" maxlength="5" name="alto" value="<%=alto%>" style="width:40px"> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        con scroll <input type="checkbox" name="scroll" value='1'<%if scroll then response.write " checked"%>>
        </td>
    </tr>
	<tr>
		<td align='right'>Fecha Inicio:</td>
        <td align="left"><input type="text" name="finicio" value="<%=finicio%>" maxlength="10" style="width:90px"></td>
        <td align="left">
        Fecha Caduca: <input type="text" name="fcaduca" value="<%=fcaduca%>" maxlength="10" style="width:90px">
        </td>
    </tr>
	<tr>
		<td align='right'>Nivel Acceso:</td>
        <td align="left">
        <select name="nivelacceso">
        <option value="<%=c_nivelPublico%>"<%if nivel=c_nivelPublico then response.write " selected"%>>Público</option>
        <option value="<%=c_nivelPrivado%>"<%if nivel=c_nivelPrivado then response.write " selected"%>>Privado</option>
        </select>
        </td>
        <td align="left">
        Orden visual: <input type="text" name="orden" value="<%=orden%>" maxlength="5" style="width:40px">
        </td>
    </tr>
    <tr><td align="right">Activo:</td>
    	<td align="left" colspan="2"><input type="checkbox" name="activo" value="1"<%if activo then response.write " checked"%>>
	</td></tr>
	<tr><td align='center' colspan='3'>
		<input id='boton' type='button' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();">	
		<input type='hidden' name='id' value='<%=laid%>'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
    </td></tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.titulo_<%=langPorDefecto%>.focus();
</script>
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>