<!--#include file="../includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuFicha.asp"--><%

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
laid=paClng(request.QueryString("id"))
if laid<>0 then 
	'Buscar datos cliente
	cs="SELECT * FROM " & precrs & "Fichas WHERE Id=" & laid
	rs.open cs,base
	if not rs.eof then
		apellidos=rs("apellidos")
		nombre=rs("nombre")
		tele=rs("telefono")
		email=rs("email")
		fax=rs("fax")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		cp=rs("cp")
		pais=rs("NombrePais")
		codigoVIP=rs("codigoVIP")
		obs=rs("observaciones")
		publicidad=rs("informacion")
		fechanac=rs("fechanac")
		idiomaweb=rs("IdiomaWeb")
		fechaAlta=rs("fechaalta")
		activo=rs("activo")
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
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['elFrame<%=ff%>'].location="fichas.asp?p=<%=pag%>";
	cerrar();
<%end if%>

function Modificar(){
	if (document.f1.id.value=="0")
		document.f1.action="<%=MiPag%>?modo=nuevo&ff=<%=ff%>&recarga="+self.name;
	else
		document.f1.action="<%=MiPag%>?modo=actu&ff=<%=ff%>&recarga="+self.name;
		
	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha">CLIENTE VIP</div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
      <table align='center' width='97%' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr>
          <td>Codigo VIP:</td>
          <td><input type='text' name='codigovip' value="<%=codigovip%>" style='width:100px' maxlength="50">
          </td>
        </tr>
        <tr>
          <td>Apellidos:</td>
          <td><input type='text' name='apellidos' value="<%=apellidos%>" style='width:200px' maxlength="50">
          </td>
        </tr>
        <tr>
          <td>Nombre:</td>
          <td><input type='text' name='nombre' value="<%=nombre%>" style='width:200px' maxlength="50"></td>
        </tr>
        <tr>
          <td>Direcci&oacute;n:</td>
          <td><input type='text' name='direccion' value="<%=direccion%>" style='width:200px' maxlength="50"></td>
        </tr>
        <tr>
          <td >Poblaci&oacute;n:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" style='width:200px' maxlength="50">
&nbsp;&nbsp;&nbsp;&nbsp; C.P.:
      <input type='text' name='cp' value="<%=cp%>" size='10' maxlength="15"></td>
        </tr>
        <tr>
          <td >Provincia:</td>
          <td ><input type='text' name='provincia' value="<%=provincia%>" style='width:150px' maxlength="50">
&nbsp;&nbsp;&nbsp; Pa&iacute;s: <input type='text' name='pais' value="<%=pais%>" style='width:150px' maxlength="50"></td>
        </tr>
        <tr>
          <td>Tel&eacute;fono:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" style='width:150px' maxlength="25">
&nbsp;&nbsp;&nbsp;&nbsp; Fax:
      <input type='text' name='fax' value="<%=fax%>" style='width:150px' maxlength="25"></td>
        </tr>
        <tr>
          <td>EMail:</td>
          <td><input type='text' name='email' value="<%=email%>" style='width:200px' maxlength="75"></td>
        </tr>
        <tr>
          <td>Idioma Web:</td>
          <td>
			<select name="idiomaweb">
			<option value="es"<%if idiomaweb="es" then response.write " selected"%>>Español</option>
			<option value="en"<%if idiomaweb="en" then response.write " selected"%>>Inglés</option>
			<option value="de"<%if idiomaweb="de" then response.write " selected"%>>Alemán</option>
			<option value="fr"<%if idiomaweb="fr" then response.write " selected"%>>Francés</option>
			<option value="it"<%if idiomaweb="it" then response.write " selected"%>>Italiano</option>
			</select>
		  </td>
        </tr>
        <tr>
          <td>Fecha Nacimiento:</td>
          <td><input type='text' name='fechanac' value="<%=fechanac%>" style='width:80px' maxlength="15"></td>
        </tr>
        <tr>
          <td>Activo:</td>
          <td><input type='checkbox' name='activo' value="1" style='border:none'<%if activo then response.write " checked"%>></td>
        </tr>
        <tr>
          <td>Publicidad:</td>
          <td><input type='checkbox' name='publicidad' value="1" style='border:none'<%if publicidad then response.write " checked"%>></td>
        </tr>
		
        <tr>
          <td valign='top'>Observaciones:</td>
          <td><textarea name='obs' style='width:350px; height:60px'><%=obs%></textarea></td>
        </tr>
        <tr>
          <td colspan="2" height='5'></td>
        </tr>
      </table>      
      <table align='center' width='95%' border='0' cellpadding="0" cellspacing="1">
        <tr>
          <td align='center'>
            <input name="botonet" type='button' class="boton86" id='botonet' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	  </td>
        </tr>
      </table>
	  
	  </td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	<%if laid=0 then%>
		document.getElementById('botonet').value='Añadir';
	<%end if%>
	document.f1.codigovip.focus();
</script>
</div>
</body>
</html>
