<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
'elCharSet="utf-8"
'response.Charset=elCharSet 'los datos estan en utf-8

set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set base2=server.createobject("ADODB.Connection")

base2.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

recarga=request.QueryString("recarga") 'id del frame de la ventana
laid=0
%><!--#include file="actuUsuario.asp"--><%

'Tabla de Hoteles
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos ORDER BY Nombre"
rs.open cs,base2
hayhotel=false
if not rs.eof then
	RegHotel=rs.getrows
	HCodi=0
	HNombre=1
	hayhotel=true
end if
rs.close

if laid=0 then laid=paClng(request.QueryString("id"))
if laid<>0 then 'buscar el registro
	cs="SELECT * FROM " & precrsgen & "usuarios WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre=rs("nombre")
		nick=rs("usuario")
		pass=rs("clave")
		nivel=rs("nivel")
		activo=rs("activo")
	end if
	rs.close
	
	'Buscar hoteles del usuario
	cs="SELECT CodigoEsta FROM " & precrsgen & "permisosporesta "
	cs=cs & "WHERE IdUsuario=" & laid
	hayphotel=false
	rs.open cs,base
	if not rs.eof then
		RegPHotel=rs.getrows
		HPCodi=0
		hayphotel=true
	end if
	rs.close
end if

set rs=nothing
base.close
set base=nothing
base2.close
set base2=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function nuevoHotel(){
	//palIframe(top.document.getElementById("verBHotel"),400,320,0,0,"bHotel.asp?id=<%=laid%>");
	pflota=this.name.replace("verFicha","");
	top.creaFlotante("verBHotel.asp?id=<%=laid%>&idf="+pflota+"&recarga=<%=recarga%>",400,320,0,0);
}

function borraHotel(){
	document.f1.action="<%=MiPag%>?id=<%=laid%>&recarga=<%=recarga%>";
	document.f1.submit();
}

function cerrar(){
	recargaFrame('<%=recarga%>');
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	cerrar();
<%end if%>

function cambioAconsulta(){
	top.document.getElementById(self.name).style.width="615px";
	top.document.getElementById(self.name).style.height="300px";
	//parent.location="usuarios.asp?p=<%=pag%>";
}

function Modificar(){
	if (document.f1.nick.value=="" || document.f1.pass.value=="" || document.f1.nombre.value==""){
		alert('<%=objIdioma.getTraduccion("i_obligados")%>');
		return false;
	}
	
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&id=<%=laid%>&recarga=<%=recarga%>";
	else
		document.f1.action="<%=MiPag%>?modo=actu&id=<%=laid%>&recarga=<%=recarga%>";

	document.f1.submit();
}

</script>
<body class='laFicha'<%if modo="nuevo" and msgError="" then response.write " onload='cambioAconsulta();'"%>>
<form name='f1' action="<%=MiPag%>" method="POST">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=ucase(objIdioma.getTraduccionHTML("i_usuario"))%> -> <%=nombre%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<table width='100%' border='0' align='center' cellpadding="0" cellspacing="2" style="margin-top:10px;">
	  <tr><td align='left' valign="top">
	  
			  <table  border='0' align='center' cellpadding="0" cellspacing="2">
              <%if msgError<>"" then%>
			  <tr>
				<td align='center' colspan="2"><b><%=msgError%></b></td>
			</tr>
              <%end if%>
			  <tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_nombre")%>:</td>
				<td align='left'><input type='text' size='30' maxlength='50' name='nombre' value='<%=nombre%>'></td>
			</tr>
			  <tr>
				<td align='right'>Nick:</td>
				<td align='left'><input type='text' size='15' maxlength='15' name='nick' value='<%=nick%>'></td>
			</tr>
			  <tr>
				<td align='right'>Password:</td>
				<td align='left'><input type='text' size='15' maxlength='15' name='pass' value='<%=pass%>'></td>
			</tr>
			  <tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_nivelacceso")%>:</td>
				<td align='left'>
				<select name="nivel">
				<option value="<%=TAdmin%>"<%if nivel=TAdmin then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_administrador")%></option>
				<option value="<%=TRecepcion%>"<%if nivel=TRecepcion then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_recepcion")%></option>
				<option value="<%=TComercial%>"<%if nivel=TComercial then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_comercial")%></option>
				<option value="<%=TRelacion%>"<%if nivel=TRelacion then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_relpublicas")%></option>
				<option value="<%=TAgencia%>"<%if nivel=TAgencia then response.write " selected"%>><%=objIdioma.getTraduccionHTML("i_agencias")%></option>
				</select>
				</td>
			</tr>
			  <tr>
				<td align='right'><%=objIdioma.getTraduccionHTML("i_activo")%>:</td>
				<td align='left'><input type="checkbox" name="activo" value="1"<%if activo then response.write " checked"%>></td>
			</tr>
		</table>
	</td>
	<%if laid<>0 then 'está consultando%>
	<td width='320' align='left' valign='top' id='photel'>
		<b><%=objIdioma.getTraduccionHTML("i_alojamientos")%>:</b>
		<div style="width:320px; height:150px; overflow:hidden; border: 1px solid #000000;">

		<table border='0' cellpadding="0" cellspacing="2">
		<%if hayphotel then
			for a=0 to ubound(RegpHotel,2)%>
				<tr>
				<td align='center' width='25'>
				<input type="checkbox" style='border:none' name="elimina" value="<%=RegpHotel(HpCodi,a)%>">
				</td>
				<td align='left'>
				<% 'busca nombre hotel
				if hayhotel then
					for f=0 to ubound(RegHotel,2)
						if RegPHotel(HpCodi,a)=RegHotel(HCodi,f) then
							response.write RegHotel(HNombre,f)
							exit for
						end if
					next 'f
				end if%>
				</td>
				</tr>
			<%next
		end if%>
		</table>
		</div>
		<p align="center">
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_anadirhotel")%>" style="cursor:pointer" onclick="javascript:nuevoHotel();" class="boton145">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>" style="cursor:pointer" onClick="javascript:borraHotel();" class="boton145">		
		</p>
		</td>
	<%end if 'laid<>0 %>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>
	<tr><td colspan="2" align="center">
	<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_modificar")%>' onclick="javascript:Modificar();" class="boton86">
	<input type='hidden' name='id' value='<%=laid%>'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>">
	</td>
</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('boton').value='<%=objIdioma.getTraduccion("i_anadir")%>';
	<%end if%>
	document.f1.nombre.focus();
</script>
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>