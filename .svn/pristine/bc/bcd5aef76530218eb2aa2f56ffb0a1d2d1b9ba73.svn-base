<!--#include file="includes/FunGestion.asp"-->
<!--#include file="include/vwd_imgbounds.asp"-->
<%
set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=request.QueryString("est")

modo=request.QueryString("modo")
if modo<>"" then
	Set Upload = Server.CreateObject("Persits.Upload.1")
	Upload.SaveToMemory

	Set File = Upload.Files("grafico")
	filegrafico=false
	If Not File Is Nothing Then
		grafico="nucleo_" & SoloElFichero(file.Path)
		file.saveAs(server.MapPath(rutafotos) & "\" & grafico)
		filegrafico=true		
		
	end if
	set file=nothing

	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(upload.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "Nucleos WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
			end if
			
		case "nuevo" 'Añadir
				idSZona=upload.form("idSZona")
				nombre_es=QuitarApos(upload.form("nombre_es"))
				nombre_en=QuitarApos(upload.form("nombre_en"))
				nombre_de=QuitarApos(upload.form("nombre_de"))
				cs="INSERT INTO Nucleos (IdSZona,Nucleo_es,Nucleo_en,Nucleo_de,grafico) VALUES ("
				cs=cs & idSZona & ",'"
				cs=cs & nombre_es & "','"& nombre_en & "','"
				cs=cs & nombre_de & "','"  & grafico &  "')"
				'response.write "cs: " & cs & "<br>"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			
		case "actu"
			MiId=upload.form("id")
			idSZona=upload.form("idSZona")
			nombre_es=QuitarApos(upload.form("nombre_es"))
			nombre_en=QuitarApos(upload.form("nombre_en"))
			nombre_de=QuitarApos(upload.form("nombre_de"))
			cs="UPDATE Nucleos SET "
			if filegrafico then
				cs=cs & "grafico='" & grafico & "',"
			end if
			cs=cs & "IdSZona=" & idSZona & ","
			cs=cs & "nucleo_es='" & nombre_es & "',"
			cs=cs & "nucleo_en='" & nombre_en & "',"
			cs=cs & "nucleo_de='" & nombre_de & "' "
			cs=cs & "WHERE id=" & MiId
			'response.write "cs: " & cs & "<br>"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
	end select
end if 'session(hotelboss)

'pa quitar graficos
quitar=request.QueryString("quitar")
if quitar<>"" then
	Set Upload = Server.CreateObject("Persits.Upload.1")
	Upload.SaveToMemory
	id=Upload.Form("id")
	if quitar="grafico" then
		cs="UPDATE " & precrs & "Nucleos SET "
		cs=cs & "grafico='' "
		cs=cs & "WHERE id=" & Id
	end if
	base.execute cs
	set upload=nothing
end if 'quitar


laid=clng(request.QueryString("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT * FROM " & precrs & "Nucleos WHERE id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre_es=rs("nucleo_es")
		idSZona=rs("idSZona")
		nombre_en=rs("nucleo_en")
		nombre_de=rs("nucleo_de")
		grafico=rs("grafico")
end if
	rs.close
end if

cs="SELECT Nucleos.id,Nucleo_es,SubZonas.SZona_es,Grafico "
cs=cs & "FROM " & precrs & "Nucleos Nucleos INNER JOIN " & precrs & "SubZonas SubZonas ON Nucleos.idSzona=SubZonas.Id ORDER BY Nucleos.id"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RN_es=1
	RN_SZona=2
	RFoto=3
	haylista=true
end if
rs.close

'SubZonas
cs="SELECT SubZonas.id,Szona_es "
cs=cs & "FROM SubZonas"
rs.Open cs, base
haySZonas=false
if not rs.eof then
	RegSZonas=rs.GetRows
	ZCodi=0
	ZNombre=1
	haySZonas=true
end if
rs.close

set rs=nothing
base.close
set base=nothing

%>
<html>
<head>
<title><%=request.Cookies("MetaTitulo")%></title>
<link href="<%=request.Cookies("HojaEstilos")%>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript" src="js/funciGrafica.js"></script>
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}

function Mandar(){
	document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	document.f1.submit();
}

function Modificar(){
	if (document.f1.id.value=="")
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=nuevo";
	else
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=actu";

	document.f1.submit();
}
function enBlanco(){
	document.f1.nombre_es.value='';
	document.f1.nombre_en.value='';
	document.f1.nombre_de.value='';
	document.getElementById('boton').value=" Añadir ";
	document.f1.id.value="";
	document.f1.grafico.text='';
	document.f1.lagrafico.src='img/tr.gif';
	document.getElementById('panel').style.visibility='visible';
	document.f1.nombre_es.focus();
}

function Quitargrafico(cualo){
	document.f1.action="<%=MiPag%>?quitar="+cualo+"&est=<%=est%>";
	document.f1.submit();
}

function Subir(){
	document.f1.lagrafico.src=document.f1.grafico.value;
}

function Subiendo(){
	document.getElementById('quitagrafico').value='Subiendo grafico';
	document.getElementById('quitagrafico').style.visibility='hidden';
	reloj=setTimeout('parpadeo()',100);
}
var texto=true;
function parpadeo(){
	if (texto)
		document.getElementById('quitagrafico').style.visibility='visible';
	else
		document.getElementById('quitagrafico').style.visibility='hidden';
	
	texto=!(texto);
	reloj=setTimeout('parpadeo()',600);
}

</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' enctype="multipart/form-data" action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<br>

    <table border="0" cellpadding="0" cellspacing="0" style="margin-top:48px; ">
		<tr><td align="right">
		<input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='&nbsp;Nueva SubZona&nbsp;'>

<input type='button' class="boton145" style='cursor:pointer' value='&nbsp;Borrar Marcados&nbsp;' onclick='javascript:ABorrar();'>
	</td></tr>
      <tr><td><div align="center" class="tituloTabla">NÚCLEOS TURÍSTICOS</div></td></tr>
      <tr>
        <td valign="top" class="tdTabla">
		
		<table width='500' border="0" align='center' cellpadding="0" cellspacing="0" class="tdTabla">
          <tr class='cabetabla'>
            <th>Borrar</th>
            <th>ID</th>
			<th align='center'>Foto</th>
            <th align='left' class="colu_par">Núcleo</th>
			<th align='left' class="colu_par">SubZona</th>
          </tr><%if haylista then
			function laColu(esa)
				if esa=0 then
					laColu=estilo
				else
					laColu=estilo & esa
				end if
			end function
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
          <tr>	  <td align="center" width='10' class='<%=laColu(0)%>'>
              <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>">
            </td>	  <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> </td>
			<td align="center" class='<%=laColu(0)%>' width="100">&nbsp;
			<%if RegLista(RFoto,r)<>"" then%>
				<a href='<%=MiPag%>?id=<%=RegLista(RId,r)%>'>
				<img src='<%=rutafotos & RegLista(RFoto,r)%>' width="100" border="0" vspace="2" hspace="2">
				</a>
			<%end if%>
			</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
              <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RN_es,r)%></a>
            </td>
            <td align="left" class='<%=laColu(0)%>' >
              <%=RegLista(RN_SZona,r)%>
            </td>
          </tr>
	<%next
	end if%>
        </table></td></tr>
    </table></td></tr>
</table>

<div id='panel' style='position:absolute; z-index:10; top:100px; left:200px; width:350px; height:300px; visibility:hidden;'>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td><div align="center" class="tituloTabla">SUBZONA</div></td></tr>
  <tr><td valign="middle" class="tdTabla"><br>
      <table width='100%' border='0' align='center' cellpadding="0" cellspacing="2">
      <tr>
        <td align='right'>Nombre Esp.</td>
        <td align='left'><input type='text' size='30' maxlength='75' name='nombre_es' value='<%=nombre_es%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Ing.</td>
        <td align='left'><input type='text' size='30' maxlength='75' name='nombre_en' value='<%=nombre_en%>'></td>
      </tr>
      <tr>
        <td align='right'>Nombre Ale.</td>
        <td align='left'><input type='text' size='30' maxlength='75' name='nombre_de' value='<%=nombre_de%>'></td>
      </tr>
      <tr>
        <td align='right'>SubZona:</td>
        <td align='left'>
			<select name="idSZona">
			<option value="0">Seleccionar</option>
			<%if haySZonas then
				for z=0 to ubound(RegSZonas,2)
				marca=""
				if RegSZonas(ZCodi,z)=idSZona then marca=" selected"%>
				<option value="<%=RegSZonas(ZCodi,z)%>"<%=marca%>><%=RegSZonas(ZNombre,z)%></option>
			<%next
			end if%>
			</select>
		</td>
      </tr>
	  <tr><td colspan="2" align="center">
	  		Tamaño 141 x 121 px en la home<br/>
			<%if grafico<>"" then%>
				<img id='lagrafico' <%=vwdImageBounds(rutafotos & grafico,141,121)%> border="1" src="<%=rutafotos & grafico%>">
			<%else%>
				<img id='lagrafico' border='1' src="img/tr.gif" width="141" height="121" />
			<%end if%>
			<br />
			<input name='grafico' type="file" size='30' onChange="javascript:checkOneFileUpload(this,'GIF,JPG,JPEG,BMP,PNG',false,100,'','','','','','');Subir();"><br><br>	
			<input id='quitagrafico' type="button" value='Quitar grafico' onclick="javascript:Quitargrafico('grafico');" style='cursor:pointer'>
	  </td></tr>
      <tr>
        <td align='center' colspan='2'>
          <input name="boton" type='button' id='boton' style='cursor:pointer' onclick="javascript:Modificar();" value='Actualizar'>
          <input type='hidden' name='id' value='<%=laid%>'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="button3" type="button" class='boton86' onClick="javascript:cerrar();" value="Cerrar"></td>
      </tr>
    </table></td></tr>
</table>

</div>

<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
