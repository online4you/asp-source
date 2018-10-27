<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

modo=request.QueryString("modo")
if modo="borra" then
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cadena=""
		for t=0 to ubound(queborro)
			cadena=cadena & "Id=" & trim(queborro(t)) & " OR "
		next
		if right(cadena,4)=" OR " then 'Quitar el ultimo operador
			cadena=left(cadena,len(cadena)-4)
		end if	
		'Borrar en empresas
		cs="DELETE FROM " & precrsgen & "Empresas WHERE " & cadena
		base.execute cs

		'Borrar en usuarios
		cs="DELETE FROM " & precrsgen & "Usuarios WHERE " & replace(cadena,"Id=","IdEmpresa=")
		base.execute cs
		
	end if
end if 'modo=borra
		

'Tabla de usuarios
cs="SELECT DISTINCT empresas.Id,empresas.Nombre,HojaEstilos,Usuario "
cs=cs & "FROM " & precrsgen & "empresas empresas INNER JOIN " & precrsgen & "usuarios usuarios "
cs=cs & "ON empresas.Id=usuarios.IdEmpresa WHERE Nivel=0 ORDER BY empresas.Nombre"

responsedebug(cs)

rs.open cs,base
hayuser=false
if not rs.eof then
	RegUser=rs.getrows
	UId=0
	UNombre=1
	UHoja=2
	UNick=3
	hayuser=true
	
	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	TotReg=ubound(RegUser,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("P"))
	if Pag=0 then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
	
	
end if
rs.close

laid=clng("0" & request.QueryString("id"))

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verEmpresa.asp?id=0&recarga="+self.name,700,530,0,0);
}
function verFicha(id){
	top.creaFlotante("verEmpresa.asp?id="+id+"&recarga="+self.name,700,530,0,0);
}
</script>
<body>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	<div id='iframeConte'>

<form name='f1' action="<%=MiPag%>" method="POST">
<table border="0" align='left' cellpadding="0" cellspacing="0">
		<tr>
			<td align="left" width="750">
			
			<table width='100%' border="0" align='center' cellpadding="0" cellspacing="0">
			<tr>
			<td align='right' colspan='4'>
			<input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nueva Empresa'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcadas'>
			</td>
			</tr>
			<tr><td colspan="4" align="left" class="tituloTabla">Empresas</td></tr>
			<tr>
			<th align="center" class='colu_par'>Borrar</th>
			<th align='left' class="colu_impar">Nombre Empresa</th>
			<th align='left' class="colu_par">Hoja Estilos</th>
			<th align='left' class="colu_impar">Administrador</th>
			</tr>
          <%if hayuser then
		  		function laColu(esa)
					if esa=0 then
						laColu=estilo
					else
						laColu=estilo & esa
					end if
				end function
				ante=0
			for R=IReg to IReg+PorPag-1
				if R>ubound(RegUser,2) then exit for

				if (r mod 2)=0 then
					estilo="fila_par" 
				else 
					estilo="fila_impar"
				end if
				if ante<>RegUser(UId,r) then%>
          <tr><td align="center" width='10' class='<%=laColu(0)%>'>
              <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegUser(UId,r)%>">
            </td>
			<td align="left" class='<%=laColu(1)%>'>
              <a href='javascript:verFicha(<%=RegUser(UId,r)%>);'><%=RegUser(UNombre,r)%></a>
            </td>
			<td align="left" class='<%=laColu(0)%>'>
              <%=RegUser(UHoja,r)%>
            </td>
			<td align="left" class='<%=laColu(1)%>'>
              <%=RegUser(UNick,r)%>
            </td>
          </tr>
		  	<%end if 'misma empresa
				ante=RegUser(UId,r)
			next
			end if%>
        <tr><td align="center" colspan="4" class="tituloTabla">
				<!--#include file="controlPaginas.asp"-->
				</td>
				</tr>
				<tr><td align="center" colspan="4" height='10'></td></tr>
			</table>
		</td>
	</tr>
</table>
</form>
	</div> <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>