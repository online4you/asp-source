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

%><!--#include file="actuTiposHotel.asp"--><%

'Lista de registros
cs="SELECT TipoAlojamiento.Id,Nombre,Idioma,Traduccion "
cs=cs & "FROM " & precrs & "TipoAlojamiento TipoAlojamiento LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON TipoAlojamiento.Id=Traducciones.IdReferencia "
cs=cs & "AND Tabla='TipoAlojamiento' AND Campo='Nombre' "
cs=cs & "ORDER BY TipoAlojamiento.Id"
rs.Open cs, base
hayTHotel=false
if not rs.eof then
	RegTHotel=rs.GetRows
	RtCodi=0
	RtNombre=1
	RtLang=2
	RtTradu=3
	hayTHotel=true
end if
rs.close

totalcampos=ubound(ListaIdiomas)+1 'los idiomas + la id + orden
haylista=false
if hayTHotel then
	dim RegLista()
	redim RegLista(totalcampos,0)
	RCodi=0
	RNombre=1
	hayLista=true
	'idiomas
	redim TIdiomas(ubound(ListaIdiomas))
	ridioma=2 'es el siguiente despues de RNombre
	for idi=1 to ubound(ListaIdiomas) 'el 0 es el langPorDefecto
		TIdiomas(idi)=rIdioma
		rIdioma=rIdioma+1
	next 'idi
	
	nlista=-1
	id_old=-1
	'se hace un array para hacer el listado (una linea por id, no por idioma)
	for t=0 to ubound(RegTHotel,2)
		if id_old<>RegTHotel(RtCodi,t) then 'crear linea
			nlista=nlista+1
			redim preserve RegLista(totalcampos,nlista)
			RegLista(RCodi,nlista)=RegTHotel(RtCodi,t)
			RegLista(RNombre,nlista)=RegTHotel(RtNombre,t)
		end if 'id_old
		id_old=RegTHotel(TrCodi,t)
		for idi=1 to ubound(ListaIdiomas)
			if ListaIdiomas(idi)=RegTHotel(RtLang,t) then 'este
				RegLista(TIdiomas(idi),nlista)=RegTHotel(RtTradu,t)
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
	top.creaFlotante("verTiposHotel.asp?id=0&recarga="+self.name,450,200,0,0);
}
function verFicha(id){
	top.creaFlotante("verTiposHotel.asp?id="+id+"&recarga="+self.name,450,200,0,0);
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
          <td align="left" width="760"> <table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
              <tr>
                <td align="right" colspan="<%=totalcampos+2%>"> <input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevotipoaloj")%>'> 
                  <input type='button' class="boton145" style='cursor:pointer' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="<%=totalcampos+2%>" align="left" class="tituloTabla"><%=Ucase(objIdioma.getTraduccionHTML("i_tipoaloja"))%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_par" align="center">ID</th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_tipoaloja")%></th>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
				if li=maxLangListado then exit for%>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_tradu_" & ListaIdiomas(li))%></th>
                <%next%>
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
                <td align="center" width='20' class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(0)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a> 
                </td>
                <%for li=1 to ubound(ListaIdiomas) 'el 0 es langPorDefecto 
				if li=maxLangListado then exit for%>
                <td align="left" class='<%=estilo%>'> <%=RegLista(TIdiomas(li),r)%> 
                </td>
                <%next 'li %>
              </tr>
              <%
			next
			end if 'haylista%>
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
