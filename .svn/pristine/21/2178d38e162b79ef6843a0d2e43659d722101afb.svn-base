<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open Conecta
'response.write "Conecta=" & Conecta & "<br>"

set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
rs.Open cs, base
HayHoteles=false
if not rs.eof then
	RegHoteles=rs.GetRows
	'Variables para la tabla RegHoteles
	HCodi=0
	HNombre=1
	HEstado=2
	HayHoteles=true
end if
rs.close

est=paClng(request.QueryString("est"))
if est=0 then est=paClng(request.Cookies("codiHotel"))
if est=0 and hayhoteles then 'Pongo el primero de la lista
	est=RegHoteles(HCodi,0)
end if
response.Cookies("codiHotel")=est

%><!--#include file="actuServicio.asp"--><%
	
'Lista de registros
cs="SELECT ServiciosExtras.Id,Nombre,Activo,Orden,Idioma,Traduccion "
cs=cs & "FROM " & precrs & "ServiciosExtras ServiciosExtras LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON ServiciosExtras.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='ServiciosExtras' AND Campo='Nombre' "
cs=cs & "LEFT JOIN " & precrs & "serviciosprecios precios on precios.IdServicio=ServiciosExtras.Id "
cs=cs & "WHERE (year(precios.FechaInicio)=" & anyo & " OR isNull(year(precios.FechaInicio)))  AND  ServiciosExtras.CodigoEsta=" & est & " OR ServiciosExtras.CodigoEsta=0 "
cs=cs & "group by  ServiciosExtras.Id,Nombre,Activo,Orden,Idioma,Traduccion  ORDER BY Orden"

'response.write cs

rs.Open cs, base
hayRegi=false
if not rs.eof then
	RegRegi=rs.GetRows
	RrCodi=0
	RrNombre=1
	RrActivo=2
	RrOrden=3
	RrLang=4
	RrTradu=5
	hayRegi=true
end if
rs.close

totalcampos=ubound(ListaIdiomas)+3 'los idiomas + la id + orden
haylista=false
if hayRegi then
	dim RegLista()
	redim RegLista(totalcampos,0)
	RCodi=0
	RNombre=1
	RActivo=2
	ROrden=3
	hayLista=true
	'idiomas
	redim TIdiomas(ubound(ListaIdiomas))
	ridioma=4 'es el siguiente despues de RNombre
	for idi=1 to ubound(ListaIdiomas) 'el 0 es el langPorDefecto
		TIdiomas(idi)=rIdioma
		rIdioma=rIdioma+1
	next 'idi
	
	nlista=-1
	id_old=-1
	'se hace un array para hacer el listado (una linea por id, no por idioma)
	for t=0 to ubound(RegRegi,2)
		if id_old<>RegRegi(RrCodi,t) then 'crear linea
			nlista=nlista+1
			redim preserve RegLista(totalcampos,nlista)
			RegLista(RCodi,nlista)=RegRegi(RrCodi,t)
			RegLista(RNombre,nlista)=RegRegi(RrNombre,t)
			RegLista(RActivo,nlista)=RegRegi(RrActivo,t)
			RegLista(ROrden,nlista)=RegRegi(RrOrden,t)
		end if 'id_old
		id_old=RegRegi(RzCodi,t)
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=RegRegi(RrLang,t) then 'este
				RegLista(TIdiomas(idi),nlista)=RegRegi(RrTradu,t)
				exit for
			end if
		next 'idi
	next 't

	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp

	TotReg=ubound(RegLista,2)+1
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
	
end if 'hayTradu

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("servicios/verServicio.asp?id=0&recarga="+self.name,1000,290,0,0);
}
function verFicha(id){
	top.creaFlotante("servicios/verServicio.asp?id="+id+"&recarga="+self.name,1000,580,0,0);
}

</script>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <td align='right' colspan="<%=totalcampos+2%>"> <input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevoservicio")%>'> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr> 
                <td colspan="<%=totalcampos+2%>" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_servicios")%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_par" align="center">ID</th>
                <th class="colu_par" align='left'><%=objIdioma.getTraduccionHTML("i_servicio")%></th>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
        if li=maxLangListado then exit for%>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_tradu_" & ListaIdiomas(li))%></th>
                <%next%>
                <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_activo")%></th>
                <th class="colu_par" align='center'><%=objIdioma.getTraduccionHTML("i_orden")%></th>
              </tr>
              <%if haylista then
		for R=IReg to IReg+PorPag-1
			if R>ubound(RegLista,2) then exit for
			if (R mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td width='20' class='<%=estilo%>' align="center"> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a></td>
                <td align="left" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'> 
                  <%=RegLista(RNombre,r)%></a> </td>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
			if li=maxLangListado then exit for%>
                <td align="left" class='<%=estilo%>'> <%=RegLista(TIdiomas(li),r)%> 
                </td>
                <%next 'li %>
                <td align="center" class='<%=estilo%>' > 
                  <%if RegLista(RActivo,r) then 
		  		response.write objIdioma.getTraduccionHTML("i_si")
          	else
            	response.write objIdioma.getTraduccionHTML("i_no")
            end if%>
                </td>
                <td align="center" class='<%=estilo%>' > <%=RegLista(ROrden,r)%> 
                </td>
              </tr>
              <%next
	end if%>
              <tr> 
                <td align="center" colspan="<%=totalcampos+2%>" class="tituloTabla"> 
                  <!--#include file="controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="idiomas/pieTraduccion.asp"-->
</body>
</html>
