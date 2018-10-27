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
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM TiposServicio WHERE "
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
			
	end select
end if 'session(hotelboss)

laid=clng("0" & request.QueryString("id"))
if laid<>0 then 'Busco el registro
	cs="SELECT * FROM " & precrs & "TiposServicio WHERE id=" & laid
	rs.open cs,base
	if not rs.eof then
		nombre_es=rs("Nombre_es")
		nombre_it=rs("Nombre_it")
		nombre_en=rs("Nombre_en")
		nombre_de=rs("Nombre_de")
		nombre_fr=rs("Nombre_fr")
		foto=rs("foto")
	end if
	rs.close
end if

cs="SELECT id,Nombre_es,Nombre_en,Nombre_de,Foto FROM " & precrs & "TiposServicio ORDER BY id"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RN_es=1
	RN_en=2
	RN_de=3
	RFoto=4
	haylista=true
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
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}
function enBlanco(){
	palIframe(document.getElementById("verFicha"),450,350,0,0,"verTipoServicio.asp?id=0&recarga="+self.name);
}
function verFicha(id){
	palIframe(document.getElementById("verFicha"),450,350,0,0,"verTipoServicio.asp?id="+id+"&est=<%=est%>");
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='f1' action="<%=MiPag%>" method="POST">
<table border='0' cellpadding="0" cellspacing="0" width='770'>
<tr>
	<td align='center' width='100' valign='top'>
		<!--#include file="botonera.asp"--></td>
	<td align='center' valign='top'>
		<br>
	<table align='center' width="600">
	<tr><td align='center'>
		<%if request.Cookies("HotelBoss")<>"" then%>
			<b>(NO SE PERMITE MODIFICAR ESTE APARTADO)</b>
		<%end if%>
	</td></tr>
	</table>
    <table border="0" cellpadding="0" cellspacing="0" style="margin-top:21px; ">
		<tr><td align="right">
		<input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='&nbsp;Nuevo Tipo Servicio&nbsp;'>
<input name="button2" type='button' class="boton145" onClick='javascript:ABorrar();' value='&nbsp;Borrar Marcados&nbsp;'>	</td></tr>
  <tr>
    <td><div align="center" class="tituloTabla">TIPOS SERVICIO</div></td></tr>
      <tr>
        <td valign="top" class="tdTabla">
		
		<table width='650' border="0" align='center' cellpadding="0" cellspacing="0" class="tdTabla">
          <tr class='cabetabla'>
            <th class="colu_par">Borrar</th>
            <th class="colu_impar">ID</th>
			<th align='center' class="colu_par">Foto</th>
            <th align='left' class="colu_impar">Nombre Esp.</th>
			<th align='left' class="colu_par">Nombre Ing.</th>
			<th align='left' class="colu_impar">Nombre Ale.</th>
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
			<td align="center" class='<%=laColu(0)%>' width="85">&nbsp;
			<%if RegLista(RFoto,r)<>"" then%>
				<a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'>
				<img src='<%=rutafotos & RegLista(RFoto,r)%>' width="85" border="0" vspace="2" hspace="2">
				</a>
			<%end if%>
			</td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
              <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RN_es,r)%></a>
            </td>	  <td align="left" width='150' class='<%=laColu(1)%>'>
              <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RN_en,r)%></a>
            </td>	  <td align="left" width='150' class='<%=laColu(0)%>'>
              <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RN_de,r)%></a>
            </td>
          </tr>
	<%next
	end if%>
        </table></td></tr>
    </table></td></tr>
</table>
</form>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</body>
</html>
