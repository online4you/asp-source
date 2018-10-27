<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Los hoteles
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos " & buscoHoteles
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

%><!--#include file="actuColectivos.asp"--><%

'Lista de registros
cs="SELECT CodigoColec,Nombre,Orde,Idioma,Traduccion, DesdeEdad, HastaEdad "
cs=cs & "FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia "
cs=cs & "AND Tabla='Colectivos' AND Campo='Nombre' "
cs=cs & "WHERE Colectivos.CodigoEsta=" & est & " ORDER BY Orde"
rs.Open cs, base
hayColec=false
if not rs.eof then
	RegColec=rs.GetRows
	RcCodi=0
	RcNombre=1
	RcOrde=2
	RcLang=3
	RcTradu=4
	RcDesde=5
	RcHasta=6
	hayColec=true
end if
rs.close

totalcampos=ubound(ListaIdiomas)+4 'los idiomas + la id + orden
haylista=false
if hayColec then
	dim RegLista()
	redim RegLista(totalcampos,0)
	RCodi=0
	RNombre=1
	ROrde=2
	hayLista=true
	'idiomas
	redim TIdiomas(ubound(ListaIdiomas))
	ridioma=3 'es el siguiente despues de RNombre
	for idi=1 to ubound(ListaIdiomas) 'el 0 es el langPorDefecto
		TIdiomas(idi)=rIdioma
		rIdioma=rIdioma+1
	next 'idi
	
	nlista=-1
	id_old=-1
	'se hace un array para hacer el listado (una linea por id, no por idioma)
	for t=0 to ubound(RegColec,2)
		if id_old<>RegColec(RcCodi,t) then 'crear linea
			nlista=nlista+1
			redim preserve RegLista(totalcampos,nlista)
			RegLista(RCodi,nlista)=RegColec(RcCodi,t)
			RegLista(RNombre,nlista)=RegColec(RcNombre,t)
			RegLista(ROrde,nlista)=RegColec(RcOrde,t)
			RegLista(RcDesde,nlista)=RegColec(RcDesde,t)
			RegLista(RcHasta,nlista)=RegColec(RcHasta,t)
		end if 'id_old
		id_old=RegColec(RcCodi,t)
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=RegColec(RcLang,t) then 'este
				RegLista(TIdiomas(idi),nlista)=RegColec(RcTradu,t)
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verColectivos.asp?id=0&est=<%=est%>&recarga="+self.name,450,200,0,0);
}
function verFicha(id){
	top.creaFlotante("verColectivos.asp?id="+id+"&est=<%=est%>&recarga="+self.name,450,200,0,0);
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
              <td colspan="<%=totalcampos+1%>" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_colectivos")%></td>
              </tr>
              <tr> 
                <th class="colu_par" align="center">ID</th>
                <th class="colu_par" align="left"><%=objIdioma.getTraduccionHTML("i_colectivos")%></th>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
				if li=maxLangListado then exit for%>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_tradu_" & ListaIdiomas(li))%></th>
                <%next%>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_desde")%></th>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_hasta")%></th>
                <th class="colu_par" align="center"><%=objIdioma.getTraduccionHTML("i_orden")%></th>
              </tr>
              <%if haylista then
			for R=IReg to IReg+PorPag-1
				if R>ubound(RegLista,2) then exit for
				if (r mod 2)=0 then 
					estilo="fila_par"
				else 
					estilo="fila_impar"
				end if%>
              <tr> 
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a> 
                </td>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
				if li=maxLangListado then exit for%>
                <td align="left" class='<%=estilo%>'> <%=RegLista(TIdiomas(li),r)%> 
                </td>
                <%next 'li %>
                <td align="left" class='<%=estilo%>'> <%=RegLista(RcDesde,r)%> 
                </td>
                <td align="left" class='<%=estilo%>'> <%=RegLista(RcHasta,r)%> 
                </td>
                <td align="center" class='<%=estilo%>'><%=RegLista(ROrde,r)%></td>
              </tr>
              <%
			next
			end if%>
              <tr>
                <td align="center" colspan="<%=totalcampos+1%>" class="tituloTabla"> 
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
