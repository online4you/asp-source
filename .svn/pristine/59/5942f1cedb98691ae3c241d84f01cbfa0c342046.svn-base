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

if request.Form<>"" then 'actualizar y salir

	tipoFPago=request.form("tipoFPago")
	codcomercio=QuitarApos(request.form("codcomercio"))
	terminal=QuitarApos(request.form("terminal"))
	acquirerBIN=QuitarApos(request.form("acquirerBIN"))
	clave=QuitarApos(request.form("clave"))
	clavexor=QuitarApos(request.form("clavexor"))
	produccion=request.form("produccion")
	if produccion="" then produccion=0
	
	on error resume next
	base.BeginTrans

	cs="UPDATE " & precrs & "FPagoHotel SET "
	cs=cs & "TipoFPago=" & tipoFPago & ", "
	cs=cs & "CodComercio='" & codcomercio & "', "
	cs=cs & "AcquirerBIN='" & acquirerBIN & "', "
	cs=cs & "Terminal='" & terminal & "', "
	cs=cs & "Clave='" & clave & "', "
	cs=cs & "ClaveXor='" & clavexor & "', "
	cs=cs & "Produccion=" & produccion & " "
	cs=cs & "WHERE CodigoEsta=" & idh
	base.execute cs
	controlRegistro(cs) 'guarda seguimiento
	
	
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

cs="SELECT * "
cs=cs & "FROM " & precrs & "FPagoHotel "
cs=cs & "WHERE CodigoEsta=" & idh
rs.open cs,base
if not rs.eof then

	tipoFPago=paClng(rs("tipoFPago"))
	codcomercio=rs("codcomercio")
	acquirerBIN="" & rs("acquirerBIN")
	terminal=rs("terminal")
	clave=rs("clave")
	clavexor=rs("clavexor")
	produccion=rs("produccion")

else

	'crea registro
	cs="INSERT INTO " & precrs & "FPagoHotel (CodigoEsta,tipoFPago,CodComercio,Terminal,Clave,ClaveXor,Produccion,AcquirerBIN) VALUES ("
	cs=cs & idh & ",0,'','','','',0,'" & acquirerBIN & "')"
	base.execute cs
	
	tipoFPago=0
	produccion=false
	
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

function controlDatos(tipo) {
	switch(tipo.value) {
		case "0": //formulario verificacion
		$("codcomercio").style.visibility='hidden';
		$("acquirerBIN").style.visibility='hidden';
		$("terminal").style.visibility='hidden';
		$("clave").style.visibility='hidden';
		$("clavexor").style.visibility='hidden';
		$("produccion").style.visibility='hidden';
		break;
		
		case "1": //ceca
		$("codcomercio").style.visibility='visible';
		$("acquirerBIN").style.visibility='visible';
		$("terminal").style.visibility='visible';
		$("clave").style.visibility='visible';
		$("clavexor").style.visibility='hidden';
		$("produccion").style.visibility='visible';
		break;
		
		case "2": //sermepa
		case "3": //4b
		$("codcomercio").style.visibility='visible';
		$("acquirerBIN").style.visibility='hidden';
		$("terminal").style.visibility='visible';
		$("clave").style.visibility='visible';
		$("clavexor").style.visibility='hidden';
		$("produccion").style.visibility='visible';
		break;

		case "4": //BBVA
		$("codcomercio").style.visibility='visible';
		$("terminal").style.visibility='visible';
		$("clave").style.visibility='visible';
		$("clavexor").style.visibility='visible';
		$("produccion").style.visibility='visible';
		break;

	}
}
</script>
</head>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_formapago"))%> -> <%=nombreHotel%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
	<tr><td align='left'><%=objIdioma.getTraduccionHTML("i_formapago")%>:</td>
    	<td><select name="tipofpago" id='tipofpago' onChange="controlDatos(this);">
        	<option value="0"<%if tipofpago=0 then response.write " selected"%>>
			<%=objIdioma.getTraduccionHTML("i_verificacion")%></option>
        	<option value="1"<%if tipofpago=1 then response.write " selected"%>>
			<%=objIdioma.getTraduccionHTML("i_tpvCECA")%></option>
        	<option value="2"<%if tipofpago=2 then response.write " selected"%>>
			<%=objIdioma.getTraduccionHTML("i_tpvSERMEPA")%></option>
        	<option value="3"<%if tipofpago=3 then response.write " selected"%>>
			<%=objIdioma.getTraduccionHTML("i_tpv4B")%></option>
        	<option value="4"<%if tipofpago=4 then response.write " selected"%>>
			<%=objIdioma.getTraduccionHTML("i_tpvBBVA")%></option>
        	</select>
    	</td>
    </tr>
    <tr id='codcomercio'>
    	<td align='left'><%=objIdioma.getTraduccionHTML("i_codcomercio")%>:</td>
        <td><input type="text" name="codcomercio" value="<%=codcomercio%>" style="width:200px"></td>
    </tr>
    <tr id='terminal'>
    	<td align='left'><%=objIdioma.getTraduccionHTML("i_terminal")%>:</td>
        <td><input type="text" name="terminal" value="<%=terminal%>" style="width:200px"></td>
    </tr>
    <tr id='clave'>
    	<td align='left'><%=objIdioma.getTraduccionHTML("i_clave")%>:</td>
        <td><input type="text" name="clave" value="<%=clave%>" style="width:200px"></td>
    </tr>
    <tr id='clavexor'>
    	<td align='left'><%=objIdioma.getTraduccionHTML("i_clavexor")%>:</td>
        <td><input type="text" name="clavexor" value="<%=clavexor%>" style="width:200px"></td>
    </tr>
    <tr id='acquirerBIN'>
    	<td align='left'>AcquirerBIN:</td>
        <td><input type="text" name="acquirerBIN" value="<%=acquirerBIN%>" maxlength="25" style="width:200px"></td>
    </tr>
    <tr id='produccion'>
    	<td align='left'><%=objIdioma.getTraduccionHTML("i_produccion")%>:</td>
        <td><input type="checkbox" name="produccion" value="1" style="border:none"<%if produccion then response.write " checked"%>>
        <%=objIdioma.getTraduccionHTML("i_textoproduccion")%></td>
    </tr>
</table>
<center>
    <input id='boton' type='button' class="boton86" value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();">	
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class="boton86" onClick="javascript:cerrar();">
</center>
<script language="javascript" type="text/javascript">
	controlDatos(document.getElementById("tipofpago"));
</script>
</form>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>