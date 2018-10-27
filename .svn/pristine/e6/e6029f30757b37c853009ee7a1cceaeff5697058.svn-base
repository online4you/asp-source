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
		movil=rs("movil")
		direccion=rs("direccion")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		cp=rs("cp")
		pais=rs("Pais")
		codigoVIP=rs("codigoVIP")
		obs=rs("observaciones")
		publicidad=rs("informacion")
		fechanac=rs("fechanac")
		idiomaweb=rs("IdiomaWeb")
		fechaAlta=rs("fechaalta")
		activo=rs("activo")
		beneficiario1=rs("beneficiario1")
		tfamilia1=rs("tfamilia1")
		fechanac1=rs("fechanac1")
		beneficiario2=rs("beneficiario2")
		tfamilia2=rs("tfamilia2")
		fechanac2=rs("fechanac2")
		beneficiario3=rs("beneficiario3")
		tfamilia3=rs("tfamilia3")
		fechanac3=rs("fechanac3")
	end if
	rs.close

else 'busco el nuevo registro

	cs="SELECT MAX(CONVERT(int,CodigoVIP)) AS Ulti FROM " & precrs & "Fichas"
	rs.open cs,base
	if not rs.eof then
		codigoVIP=paClng(rs("ulti"))+1
	end if
	rs.close
	
end if

	
set rs=nothing
base.close
set base=nothing

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Tabla Paises
cs="SELECT IdCountry,CountryName FROM " & precrs & "tbl_Paises WHERE IdLanguage='es'"
rs.open cs,base
haypais=false
if not rs.eof then
	RegPais=rs.getrows
	PCodi=0
	PNombre=1
	hayPais=true
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="../metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	//poner le numero de iframe flotante a cerrar
	parent.cerrar();
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	top.frames['<%=recarga%>'].location="fichas.asp?p=<%=pag%>";
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
<body class="laFicha">
<div id='conteAmigo' style="overflow:hidden; height:auto; width:100%;">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tdTabla">
    
      <table align='left' width='320' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr>
          <td>Codigo Amigo:</td>
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
          <td>Poblaci&oacute;n:</td>
          <td><input type='text' name='poblacion' value="<%=poblacion%>" style='width:200px' maxlength="50">
          </td>
       	</tr>
        <tr>
        	<td>C.P.:</td>
            <td><input type='text' name='cp' value="<%=cp%>" size='10' maxlength="15"></td>
        </tr>
        <tr>
          <td>Provincia:</td>
          <td><input type='text' name='provincia' value="<%=provincia%>" style='width:150px' maxlength="50">
          </td>
        </tr>
        <tr>
          <td>Pais:</td>
			<td>
			<select name='pais'>
				<option value=''>Seleccione</option>
			<%if haypais then
            for p=0 to ubound(RegPais,2)
                marca=""
                if RegPais(PCodi,p)=pais then marca=" selected"%>
                <option value='<%=RegPais(PCodi,p)%>'<%=marca%>><%=RegPais(PNombre,p)%></option>
            <%next
            end if%>
			</select>
            </td>
        </tr>
        <tr>
          <td>Tel&eacute;fono:</td>
          <td><input type='text' name='telefono' value="<%=tele%>" style='width:150px' maxlength="25"></td>
        </tr>
        <tr>
          <td>Móvil:</td>
          <td><input type='text' name='movil' value="<%=movil%>" style='width:150px' maxlength="25"></td>
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
          <td>Comprobado:</td>
          <td><input type='checkbox' name='activo' value="1" style='border:none'<%if activo then response.write " checked"%>>
          &nbsp;&nbsp;&nbsp;&nbsp;Publicidad:<input type='checkbox' name='publicidad' value="1" style='border:none'<%if publicidad then response.write " checked"%>></td>
        </tr>
        <tr>
          <td valign='top'>Observaciones:</td>
          <td><textarea name='obs' style='width:280px; height:60px'><%=obs%></textarea></td>
        </tr>
        <tr>
          <td colspan="2" height='5'></td>
        </tr>
      </table>   
      
      <table align='left' width='300' border='0' cellpadding="0" cellspacing="1" class="tdTabla">
        <tr><td colspan="2"></td></tr>
        <tr><td colspan="2">
        	<fieldset>
            	<legend>Beneficiario 1</legend>
                <table width="100%" cellpadding="0" cellspacing="2">
                <tr><td>Beneficiario:</td>
                	<td><input type='text' name='beneficiario1' value="<%=beneficiario1%>" style='width:200px' maxlength="75"></td>
                </tr>
                <tr><td>T. Familia:</td>
                	<td><input type='text' name='tfamilia1' value="<%=tfamilia1%>" style='width:100px' maxlength="50"></td>
                </tr>
                <tr><td>Fecha Nac.:</td>
                	<td><input type='text' name='fechanac1' value="<%=fechanac1%>" style='width:80px' maxlength="15"></td>
                </tr>
                </table>
            </fieldset>
        </td></tr>
        <tr><td colspan="2">
        	<fieldset>
            	<legend>Beneficiario 2</legend>
                <table width="100%" cellpadding="0" cellspacing="2">
                <tr><td>Beneficiario:</td>
                	<td><input type='text' name='beneficiario2' value="<%=beneficiario2%>" style='width:200px' maxlength="75"></td>
                </tr>
                <tr><td>T. Familia:</td>
                	<td><input type='text' name='tfamilia2' value="<%=tfamilia2%>" style='width:100px' maxlength="50"></td>
                </tr>
                <tr><td>Fecha Nac.:</td>
                	<td><input type='text' name='fechanac2' value="<%=fechanac2%>" style='width:80px' maxlength="15"></td>
                </tr>
                </table>
            </fieldset>
        </td></tr>
        <tr><td colspan="2">
        	<fieldset>
            	<legend>Beneficiario 3</legend>
                <table width="100%" cellpadding="0" cellspacing="2">
                <tr><td>Beneficiario:</td>
                	<td><input type='text' name='beneficiario3' value="<%=beneficiario3%>" style='width:200px' maxlength="75"></td>
                </tr>
                <tr><td>T. Familia:</td>
                	<td><input type='text' name='tfamilia3' value="<%=tfamilia3%>" style='width:100px' maxlength="50"></td>
                </tr>
                <tr><td>Fecha Nac.:</td>
                	<td><input type='text' name='fechanac3' value="<%=fechanac3%>" style='width:80px' maxlength="15"></td>
                </tr>
                </table>
            </fieldset>
        </td></tr>

      </table>
      
      
    </td>
   	</tr>
    <tr><td align="center">
            <input name="botonet" type='button' class="boton86" id='botonet' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
            <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar">
	</td></tr>
</table>
</form>
</div>
<script language="javascript" type="text/javascript">
	//alert(document.getElementById('conteReserva').offsetHeight);
	/*
	alto=(document.getElementById('conteAmigo').offsetHeight-500); //tamaño capa
	top.document.getElementById(this.name).style.height=(top.document.getElementById(this.name).offsetHeight+alto)+"px";
	*/
	<%if laid=0 then%>
		document.getElementById('botonet').value='Añadir';
	<%end if%>
	document.f1.codigovip.focus();
</script>
</div>
</body>
</html>
