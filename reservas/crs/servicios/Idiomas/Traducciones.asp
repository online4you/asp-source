<!--#include file="includes/FunGestion.asp"-->
<!--#include file="claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
elCharSet="iso-8859-1"
elCodePage="1252" 'por defecto
'encoding de la pagina
response.Charset=elCharSet 'las traducciones del administrador en ISO-8859-1
session.CodePage=elCodePage

tipo=request.QueryString("tipo")
if tipo="web" then rutaXML=server_path & "reservas/bookingFront/IdiomaXML/"

set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set objIdioma = new clsIdioma 'lang actual

lang="es"
set objIdioma_es = new clsIdioma 'español
lang="en"
set objIdioma_en = new clsIdioma 'ingles
lang="de"
set objIdioma_de = new clsIdioma 'Bulgarian
lang="pt"
set objIdioma_pt = new clsIdioma 'Portugues
lang="pt"
set objIdioma_fr = new clsIdioma 'Portugues
lang="pt"
set objIdioma_it = new clsIdioma 'Portugues

lang="es" 'por defecto

%><!--#include file="actuTraduccion.asp"--><%

'RegListaB=objIdioma_es.buscaTraduccion("hab") 'array con los registros
'response.write isArrayVacio(RegListaB)


haylista=false
if objIdioma_es.nRegistros>0 then
	hayLista=true
	RegLista=objIdioma_es.listaTraduccion() 'array con los registros
	'Campos del array
	LEti=0
	LTradu=1
	LDetalle=2

	'PorPag=paClng(objCookies.getCookie(lcase(MiPag)))
	PorPag=999999
	if PorPag=0 then PorPag=RegPorPag 'valor por defecto
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
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra&tipo=<%=tipo%>";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("idiomas/verTraduccion.asp?id=&tipo=<%=tipo%>&recarga="+self.name,600,480,0,0);
}
function verFicha(id){
	top.creaFlotante("idiomas/verTraduccion.asp?id="+id+"&tipo=<%=tipo%>&recarga="+self.name,600,480,0,0);
}

function elIntro(oEvento){
     var iAscii;
     if (oEvento.keyCode)
         iAscii = oEvento.keyCode;
     else if (oEvento.which)
         iAscii = oEvento.which;

     if (iAscii == 13) buscaPalabra();
}

function buscaPalabra(){
	busca=document.getElementById('busco').value;
	if (busca!=""){
		top.creaFlotante("idiomas/buscadorPalabras.asp?busco="+busca+"&tipo=<%=tipo%>&recarga="+self.name,600,400,0,0);
	}

}
function cargaPalabra(eso){
	losvalores=eso.split(";"); //vienen los datos separados por ;
	elcodi=losvalores[0]; //etiqueta
	verFicha(elcodi);
}
</script>
<body>
<!--#include file="capaRecarga.asp"-->

<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <table border="0" align='left' cellpadding="0" cellspacing="0">
      <tr> 
        <td align="left" width="740"> 
          <input type="hidden" id='busco' name="busco" style="width:150px" onKeyPress="javascript:elIntro(event);"> 
          <input type="hidden" value="Buscar" class="boton86" onClick="javascript:buscaPalabra();" style="margin-bottom:0px;"> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <%if adminBoss then 'sólo pal jefe%>
          <input type='button' class="boton145" onClick="javascript:enBlanco();" value='Nueva Traducci&oacute;n'> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type='button' class="boton145" onClick='javascript:ABorrar();' value='Borrar Marcadas'> 
          <%end if%>
          <form name='f1' action="<%=MiPag%>" method="POST">
            <table width='100%' border='0' cellpadding="0" cellspacing="0">
              <tr>
                <td class="tituloTabla" colspan="5" align="left" >Traducciones</td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th align='center' class="colu_impar">Etiqueta</th>
                <th align='left' class="colu_par">Espa&ntilde;ol</th>
                <th align='left' class="colu_impar">Ingl&eacute;s</th>
                <th align='left' class="colu_par">Portugu&eacute;s</th>
              </tr>
              <%if hayLista then
			for R=IReg to IReg+PorPag-1
			if R>ubound(RegLista,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if
			%>
              <tr> 
                <td align="center" width='10' class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(LEti,r)%>"> 
                </td>
                <td align="center" class='<%=laColu(1)%>'> <a href='javascript:verFicha("<%=RegLista(LEti,r)%>");' title="<%=RegLista(LDetalle,r)%>">
                  <%=RegLista(LEti,r)%>
                  </a> </td>
                <td align="left" class='<%=laColu(0)%>'> <a href='javascript:verFicha("<%=RegLista(LEti,r)%>");' title="<%=RegLista(LDetalle,r)%>"> 
                  <%=mid(RegLista(LTradu,r),1,40)%>
                  </a> </td>
                <td align="left" class='<%=laColu(1)%>'> <a href='javascript:verFicha("<%=RegLista(LEti,r)%>");' title="<%=RegLista(LDetalle,r)%>"> 
                  <%=mid(objIdioma_en.getTraduccionHTML(RegLista(LEti,r)),1,40)%>
                  </a> </td>
                <td align="left" class='<%=laColu(0)%>' > <a href='javascript:verFicha("<%=RegLista(LEti,r)%>");' title="<%=RegLista(LDetalle,r)%>"> 
                  <%=mid(objIdioma_pt.getTraduccionHTML(RegLista(LEti,r)),1,40)%>
                  </a> </td>
              </tr>
              <%next
	end if%>
              <tr>
                <td align="center" colspan="5" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
              </tr>
            </table>
          </form></td>
      </tr>
    </table>
  </div>
</div>
<script language="javascript" type="text/javascript">
document.getElementById('busco').focus();
</script>
<!--#include file="pieFrame.asp"-->
<!--#include file="pieTraduccion.asp"-->
</body>
</html>
