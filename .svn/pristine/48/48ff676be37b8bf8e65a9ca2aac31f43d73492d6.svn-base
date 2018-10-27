<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set base2=server.createobject("ADODB.Connection")
base2.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

busco=""
if request.Form<>"" then 'datos
	if request.QueryString("filtro")="1" then 'filtrar
		busco="WHERE "
		buser=request.Form("buser")
		if buser<>"" then busco=busco & "IdUsuario=" & buser & " AND "
		bhotel=request.Form("bhotel")
		if bhotel<>"" then busco=busco & "Registro.CodigoEsta=" & bhotel & " AND "
		bproceso=request.Form("bproceso")
		if bproceso<>"" then busco=busco & "Proceso LIKE '%" & bproceso & "%' AND "
		desdef=request.form("desdef")
		hastaf=request.form("hastaf")
		if isdate(desdef) and isdate(hastaf) then
			busco=busco & "(Fecha BETWEEN " & FechaMySQL(desdef) & " AND " & FechaMySQL(cdate(hastaf)+1) & ") AND "
		elseif isdate(desdef) and not isdate(hastaf) then
			busco=busco & "Fecha>=" & FechaMySQL(desdef) & " AND "
		elseif not isdate(desdef) and isdate(hastaf) then
			busco=busco & "Fecha<=" & FechaMySQL(cdate(hastaf)+1) & " AND "
		end if
		
		'Quitar el where o el AND
		if right(busco,4)="AND " then busco=left(busco,len(busco)-4)
		if right(busco,6)="WHERE " then busco=left(busco,len(busco)-6)
		'response.write busco
		response.Cookies("filtroAcceso")=busco
	end if
	if request.QueryString("filtro")="0" then 'no filtrar
		response.Cookies("filtroAcceso")=""
	end if
	
	if request.QueryString("del")="1" then 'Borrar registros
		desde=request.Form("desde")
		hasta=request.Form("hasta")
		if isdate(desde) and isdate(hasta) then
			cs="DELETE FROM " & precrs & "Registro Registro WHERE Fecha BETWEEN " & FechaMySQL(desde) & " AND " & FechaMySQL(cdate(hasta)+1)
			base.execute cs
		end if
	end if 'del=1
		
end if 'form<>""

busco=request.Cookies("filtroAcceso")

'Tabla de registros
cs="SELECT Id,Registro.Nombre,Fecha,Proceso,Establecimientos.Nombre "
cs=cs & "FROM " & precrs & "Registro Registro LEFT JOIN " & precrs & "Establecimientos Establecimientos "
cs=cs & "ON Registro.CodigoEsta=Establecimientos.CodigoEsta "
if busco<>"" then cs=cs & busco
cs=cs & " ORDER BY Id DESC"
rs.open cs,base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RId=0
	RNombre=1
	RFecha=2
	RProceso=3
	RHotel=4
	haylista=true
	
	porp=objCookies.getCookie(MiPag)
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	'PorPag=19
	TotReg=ubound(RegLista,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=request.querystring("p")
	if Pag="" then Pag=1
	Pag=clng(Pag)
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP
	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close

'Tablas para el filtro
cs="SELECT CodigoEsta,Nombre FROM " & precrs & "Establecimientos Establecimientos ORDER BY Nombre"
rs.open cs,base
hayhoteles=false
if not rs.eof then
	RegHoteles=rs.getrows
	HCodi=0
	HNombre=1
	hayhoteles=true
end if
rs.close

'Tablas para el filtro
cs="SELECT Id,Nombre FROM " & precrs & "Usuarios WHERE IdEmpresa=" & IdEmpresa & " ORDER BY Nombre"
rs.open cs,base2
hayusers=false
if not rs.eof then
	RegUsers=rs.getrows
	UCodi=0
	UNombre=1
	hayusers=true
end if
rs.close

laid=paClng(request.QueryString("id"))
if laid<>0 then 'busca registro
	cs="SELECT Id,Registro.Nombre as elusu,Fecha,Proceso,Establecimientos.Nombre as elhotel "
	cs=cs & "FROM " & precrs & "Registro Registro LEFT JOIN " & precrs & "Establecimientos Establecimientos "
	cs=cs & "ON Registro.CodigoEsta=Establecimientos.CodigoEsta "
	cs=cs & "WHERE Id=" & laid
	'response.write cs
	rs.open cs,base
	if not rs.eof then
		elusu=rs("elusu")
		fecha=rs("fecha")
		proceso=rs("proceso")
		elhotel=rs("elhotel")
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<style type="text/css">
table td {
	white-space:normal;
}
</style>
<script language="javascript" type="text/javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?del=1&recarga="+self.name;
		document.f1.submit();
	}
}
function quitaFiltro(){
	document.fb.action="<%=MiPag%>?filtro=0";
	document.fb.submit();
}
function verFicha(id){
	//palIframe(document.getElementById("verFicha"),450,200,0,0,"verZonas.asp?id="+id+"&est=<%=est%>");
	top.creaFlotante("verRegistro.asp?id="+id+"&recarga="+self.name,600,300,0,0);
}

</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <table align='left' cellpadding="0" cellspacing="0" border="0">
      <tr> 
        <td align='left' width="740"> <table width='100%' border='0' cellpadding="0" cellspacing="0" style="margin-top:10px;">
            <tr> 
              <td width='33%' align='left'> <form name='f1' action="<%=MiPag%>" method="POST">
                  <div style="float:left;"> &nbsp;<b>Eliminar registros</b><br/>
                    desde fecha 
                    <input type="text" name="desde" style="width:60px" value="dd/mm/aa">
                    &nbsp;hasta&nbsp; 
                    <input type="text" name="hasta" style="width:60px" value="dd/mm/aa">
                    <br/>
                    <input type='button' onclick="javascript:ABorrar();" value='Borrar Registros' class="boton145" style="float:none">
                  </div>
                </form></td>
              <td align='left' colspan="2"> <form name='fb' action="<%=MiPag%>?filtro=1" method="POST">
                  <div style="float:right; margin-right:5px; line-height:20px"> 
                    Filtrar por 
                    <select name="buser">
                      <option value="">Cualquiera</option>
                      <%if hayusers then
					for u=0 to ubound(RegUsers,2)%>
                      <option value="<%=RegUsers(UCodi,u)%>"><%=RegUsers(UNombre,u)%></option>
                      <%next
					end if%>
                    </select>
                    &nbsp;&nbsp;&nbsp; desde fecha 
                    <input type="text" name="desdef" style="width:60px" value="dd/mm/aa">
                    &nbsp;hasta&nbsp; 
                    <input type="text" name="hastaf" style="width:60px" value="dd/mm/aa">
                    <br/>
                    Hotel 
                    <select name="bhotel">
                      <option value="">Cualquiera</option>
                      <%if hayhoteles then
						for h=0 to ubound(RegHoteles,2)%>
                      <option value="<%=RegHoteles(HCodi,h)%>"><%=RegHoteles(HNombre,h)%></option>
                      <%next
					end if%>
                    </select>
                    <br/>
                    Proceso 
                    <select name="bproceso">
                      <option value="">Cualquiera</option>
                      <!--<option value="entrada">Entrada Acceso</option>-->
                      <option value="insert">Añadir Registro</option>
                      <option value="update">Modificar Registro</option>
                      <option value="delete">Borrar Registro</option>
                    </select>
                    <br/>
                    <p align="right"> 
                      <input type='button' onclick="javascript:document.fb.submit();" value='Filtrar' class="boton145">
                      &nbsp;&nbsp;&nbsp; 
                      <input type='button' onclick="javascript:quitaFiltro();" value='Quitar Filtro' class="boton145">
                    </p>
                  </div>
                </form></td>
            </tr>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" width="740">
            <tr> 
              <td class="tituloTabla" colspan="5" align="left">REGISTRO</td>
            </tr>
            <tr> 
              <th align="center" class='colu_par'>Id</th>
              <th align="center" class='colu_impar'>Usuario</th>
              <th align="center" class='colu_par'>Fecha</th>
              <th align="center" class='colu_impar'>Hotel</th>
              <th align="left" class='colu_par'>&nbsp;Proceso</th>
            </tr>
            <%if haylista then
		  		function laColu(esa)
					if esa=0 then
						laColu=estilo
					else
						laColu=estilo & esa
					end if
				end function
				for R=IReg to IReg+PorPag-1
					if R>ubound(RegLista,2) then exit for
					if (R mod 2)<>0 then
						estilo="fila_par"
					else
						estilo="fila_impar"
					end if%>
            <tr> 
              <td align="center" class='<%=laColu(0)%>'> <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'> 
                <%=RegLista(RId,r)%></a> </td>
              <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RId,r)%>);'> 
                <%=RegLista(RNombre,r)%></a> </td>
              <td align="center" class='<%=laColu(0)%>'> <%=VerFechaHora(RegLista(RFecha,r))%> 
              </td>
              <td align="center" class='<%=laColu(1)%>'> 
                <%if isnull(RegLista(RHotel,r)) then
					  		response.write "No determinado"
						else
							response.write RegLista(RHotel,r)
						end if%>
              </td>
              <td align="left" class='<%=laColu(0)%>'> &nbsp;<%=mid(RegLista(RProceso,r),1,75)%> 
              </td>
            </tr>
            <%next
			end if%>
            <tr> 
              <td colspan="5" align="center" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
            </tr>
          </table></td>
      </tr>
    </table>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>