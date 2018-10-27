<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

'ConectaMDB= "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=crs_general;pwd=PlanetaWeb09;Initial Catalog=crs_general;Data Source=localhost"

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'buscar tabla paises
cs="select IdCountry,CountryName FROM " & precrsgen & "tbl_Paises where IdLanguage='" & lang & "'"
rs.open cs,base
haypais=false
if not rs.eof then
	RegPais=rs.getrows
	PCodi=0
	PNombre=1
	Haypais=true
end if
rs.close

base.close

base.Open Conecta

%><!--#include file="actuCliente.asp"--><%

recarga=request.QueryString("recarga") 'id del frame de la ventana
pag=request.QueryString("p") 'pagina del padre
laid=paClng(request.querystring("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT * FROM " & precrs & "Fichas WHERE Id=" & laid
	rs.Open cs, base
	if not rs.eof then
		nombre=rs("nombre")
		apellidos=rs("apellidos")
		direccion=rs("direccion")
		cp=rs("cp")
		poblacion=rs("poblacion")
		provincia=rs("provincia")
		tele=rs("telefono")
		fax=rs("fax")
		email=rs("email")
		pais=rs("Pais")
		nombrepais=rs("NombrePais")
		chotel=rs("hotel")
		idiomaW=rs("idiomaweb")
		sexo=rs("sexo")
		fecha=rs("fechaAlta")
		FIni=rs("fechallegada")
		FFin=rs("Fechasalida")
		contacto=rs("comocontacto")
		Info=rs("informacion")
		Confi=rs("confirmado")
		FNac=rs("FechaNac")
		obs=rs("Observaciones")
		codreserva=rs("codreserva")
	end if
	rs.close
end if

'Tabla de Paises
'cs="SELECT Cod_Pais,Nombre_" & lang & " FROM Pais ORDER BY Nombre_" & lang
'haypais=false
'rs.open cs,base
'if not rs.eof then
'	RegPais=rs.getrows
'	PCodi=0
'	PNombre=1
'	Haypais=true
'end if
'rs.close


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
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame('<%=recarga%>');
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?modo=actu&recarga=<%=recarga%>";
	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccion("i_cliente") & " -> " & apellidos & ", " & nombre%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="../img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px">
  <tr>
    <td class="tdTabla">

	<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2">
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_nombre")%>:</td>
        <td align='left'>
          <input type='text' name="nombre" value='<%=nombre%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_apellidos")%>:</td>
        <td align='left'>
          <input type='text' name="apellidos" value='<%=apellidos%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'>EMail:</td>
        <td align='left'>
          <input type='text' name="email" value='<%=email%>' maxlength="75" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_direccion")%>:</td>
        <td align='left'>
          <input type='text' name="direccion" value='<%=direccion%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_cp")%>:</td>
        <td align='left'>
          <input type='text' name="cp" value='<%=cp%>' maxlength="15" style='width:50px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_poblacion")%>:</td>
        <td align='left'>
          <input type='text' name="poblacion" value='<%=poblacion%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_provincia")%>:</td>
        <td align='left'>
          <input type='text' name="provincia" value='<%=provincia%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_pais")%>:</td>
        <td align='left'>
			<select name="pais">
			<%if haypais then
				for p=0 to ubound(RegPais,2)
					marca=""
					if RegPais(PCodi,p)=lcase(pais) then marca=" selected"%>
					<option value="<%=RegPais(PCodi,p)%>"<%=marca%>><%=RegPais(PNombre,p)%></option>
				<%next
			end if%>
			</select>
            <!--
            <input type='text' name="nombrepais" value='<%=nombrepais%>' maxlength="25" style='width:150px'>-->
            </td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_telefono")%>:</td>
        <td align='left'>
          <input type='text' name="tele" value='<%=tele%>' maxlength="25" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'>Fax:</td>
        <td align='left'>
          <input type='text' name="fax" value='<%=fax%>' maxlength="50" style='width:250px'></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_publicidad")%>:</td>
        <td align='left'>
          <input type='checkbox' name="info" value='1'<%if info then response.write " checked"%>></td>
      </tr>
      <tr>
        <td align='right'><%=objIdioma.getTraduccion("i_observaciones")%>:</td>
        <td align='left'>
			<textarea name="obs" style="width:250px; height:70px;"><%=obs%></textarea></td>
      </tr>
	  
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" class='boton86' type='button' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='<%=objIdioma.getTraduccion("i_modificar")%>'>
          <input type='hidden' name='id' value='<%=laid%>'>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	<input name="button" type="button" class='boton86' onClick="javascript:cerrar();" value="<%=objIdioma.getTraduccion("i_cerrar")%>"></td>
      </tr>
    </table>
	</td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	document.f1.nombre.focus();
</script>
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>
