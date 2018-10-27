<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<!--#include file="../includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta

btabla=request.QueryString("bt")

modo=request.QueryString("modo")
if request.form<>"" then
	if modo="borra" then
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE " & precrs & "ResumenEMails ResumenEMails WHERE " 
			for t=0 to ubound(queborro)
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
		end if

	end if 'borra

end if 'request.form 

'tabla de emailing
cs="SELECT id,Asunto,Errores,Correctos,FechaEnvio,Tabla FROM " & precrs & "ResumenEmails ResumenEmails "
if btabla<>"" then cs=cs & "WHERE Tabla='" & btabla & "' "
cs=cs & "ORDER BY FechaEnvio DESC,Id DESC"
rs.Open cs, base
haylista=false
if not rs.eof then
	Rid=0
	Rasun=1
	Rerr=2
	Rcorr=3
	Rfecha=4
	RTabla=5
	haylista=true
	LosReg=rs.getrows
	
	porp=objCookies.getCookie(lcase(MiPag))
	if porp="" then porp=RegPorPag 'valor por defecto
	PorPag=porp
	TotReg=ubound(LosReg,2)+1
	if (totreg/porpag)=int(totreg/porpag) then
		MaxP=int(totreg/porpag)
	else
		MaxP=int(totreg/porpag)+1
	end if

	Pag=paClng(request.querystring("P"))
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
end if
rs.close

'Agrupar las tablas
cs="SELECT Tabla FROM " & precrs & "ResumenEmails ResumenEmails GROUP BY Tabla"
rs.open cs,base
haytablas=false
if not rs.eof then
	RegTablas=rs.getrows
	ReTabla=0
	hayTablas=true
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
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" type="text/javascript">
function verEMail(id){
	top.creaFlotante("verEnvio.asp?id="+id+"&recarga="+self.name,460,420,0,0);
}
function verErrores(id){
	top.creaFlotante("verListaErrores.asp?id="+id+"&recarga="+self.name,460,420,0,0);
}

function ABorrar(){
	if (confirm("¿Está seguro/a?")){
		document.f1.action="<%=MiPag%>?modo=borra&bt=<%=btabla%>&recarga="+self.name;
		document.f1.submit();
	}
}

function cambiaTabla(esa){
	window.location="<%=MiPag%>?bt="+esa.value;
}
function marcado(ese){
	marcar=false;
	if (ese.checked) marcar=true;
	for (t=0;t<document.f1.length;t++)
	{
		if (document.f1[t].name=='aborrar'){
			if (marcar)
				document.f1[t].checked=true;
			else
				document.f1[t].checked=false;
		}
	}
}


</script>
<body>
<!--#include file="../capaRecarga.asp"-->
<!--#include file="../includes/porPagina.asp"-->
<iframe id='paCSV' name="paCSV" frameborder='0' hspace='0' vspace='0' src='../vacio.htm' class='ficha'></iframe>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' action="<%=MiPag%>" method="POST">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="750"> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <td align='right' colspan="7"> <input type='button' class="boton145" value='Borrar marcados' onclick='javascript:ABorrar();' style="float:right"> 
                  <div style="margin-top:5px; float:right; margin-right:30px"> 
                    Filtrar por : 
                    <select name="btabla" onChange="javascript:cambiaTabla(this);">
                      <option value="">Todas</option>
                      <%if haytablas then
				for t=0 to ubound(RegTablas,2)
				marca=""
				if RegTablas(ReTabla,t)=btabla then marca=" selected"%>
                      <option value="<%=RegTablas(ReTabla,t)%>"<%=marca%>><%=RegTablas(ReTabla,t)%></option>
                      <%next
			end if%>
                    </select>
                  </div></td>
              </tr>
              <tr> 
                <td colspan="7" align="left" class="tituloTabla">Lista EMails 
                  enviados</td>
              </tr>
              <tr> 
                <th class="colu_par" align="center"> <input type="checkbox" style='border:none' name="orrar" onClick="javascript:marcado(this);"></th>
                <th align="center" class="colu_impar">Id</th>
                <th align="center" class="colu_par">Fecha Envio</th>
                <th align="left" class="colu_impar">Asunto</th>
                <th align="center" class="colu_par">Correctos</th>
                <th align="center" class="colu_impar">Errores</th>
                <th align="center" class="colu_par">Tabla</th>
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
			if R>ubound(LosReg,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" class='<%=laColu(1)%>'><input type="checkbox" style='border:none' name="aborrar" value="<%=losreg(RId,r)%>"></td>
                <td align="center" class='<%=laColu(0)%>'> <%=LosReg(RId,r)%></td>
                <td align="center" class='<%=laColu(1)%>'> <%=verFecha(LosReg(RFecha,r))%></td>
                <td align="left" class='<%=laColu(0)%>'> <%=LosReg(RAsun,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=LosReg(RCorr,r)%></td>
                <td align="center" class='<%=laColu(0)%>'><%=LosReg(RErr,r)%></td>
                <td align="center" class='<%=laColu(1)%>'><%=LosReg(RTabla,r)%></td>
              </tr>
              <%next%>
              <%end if%>
              <tr> 
                <td align="center" colspan="7" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="../pieFrame.asp"-->
</body>
</html>