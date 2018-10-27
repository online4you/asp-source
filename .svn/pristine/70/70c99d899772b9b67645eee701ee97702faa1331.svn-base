<!--#include file="../includes/FunGestion.asp"-->
<!--#include file="../idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

server.ScriptTimeout=900 

if request.form<>"" then
	modo=request.QueryString("modo")
	MiId=request.form("id")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM OfertasVIP WHERE "
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
	end select
end if

'Lista de registros
cs="SELECT Id,Titulo_" & lang & ",FechaInicio,FechaFin,APlicarEn,Dto,Caduca,Calcula,Activa "
cs=cs & "FROM " & precrs & "OfertasVIP ORDER BY FechaInicio"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNom_es=1
	RFIni=2
	RFFin=3
	RAplicar=4
	RDto=5
	RCaduca=6
	RCalcula=7
	RActiva=8
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
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	//palIframe(document.getElementById("verFicha"),800,410,0,0,"verOfertas.asp?id=0&p=<%=pag%>&est=<%=est%>");
	top.creaFlotante("verOfertaVIP.asp?id=0&est=<%=est%>&recarga="+self.name,820,465,0,0);
}
function verFicha(id){
	//palIframe(document.getElementById("verFicha"),800,410,0,0,"verOfertas.asp?id="+id+"&est=<%=est%>");
	top.creaFlotante("verOfertaVIP.asp?id="+id+"&est=<%=est%>&recarga="+self.name,820,465,0,0);
}
</script>
</head>
<body>
<!--#include file="capaRecarga.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <table align='left' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="10"> <input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccion("i_nuevaoferta")%>'> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccion("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="9" align="left" class="tituloTabla"><%=objIdioma.getTraduccion("i_ofertas")%></td>
              </tr>
              <tr> 
                <th class="colu_impar"></th>
                <th class="colu_par">Id</th>
                <th align='left' class="colu_impar"><%=objIdioma.getTraduccion("i_titulo")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccion("i_fechainicio")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccion("i_fechafinal")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccion("i_fcaduca")%></th>
                <th align='center' class="colu_par">% <%=objIdioma.getTraduccion("i_dto")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccion("i_calcula")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccion("i_activa")%></th>
              </tr>
              <%if haylista then
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
              <tr> 
                <td align="center" width='10' class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" class='<%=laColu(1)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=mid(RegLista(RNom_es,r),1,70)%></a> 
                </td>
                <td align='center' class='<%=laColu(1)%>' > <%=VerFecha(RegLista(RFIni,r))%> 
                </td>
                <td align='center' class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFFin,r))%> 
                </td>
                <td align='center' class='<%=laColu(1)%>' > <%=VerFecha(RegLista(RCaduca,r))%> 
                </td>
                <td align="center" class='<%=laColu(1)%>'> <%=RegLista(RDto,r) & " %"%> 
                </td>
                <td align="center" class='<%=laColu(1)%>'>&nbsp; 
                  <%if RegLista(RCalcula,r) then response.write objIdioma.getTraduccion("i_si")%>
                </td>
                <td align="center" class='<%=laColu(0)%>'>&nbsp; 
                  <%if RegLista(RActiva,r) then response.write objIdioma.getTraduccion("i_si")%>
                </td>
              </tr>
              <%
	next
	end if%>
              <tr>
                <td align="center" colspan="10" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->	
<!--#include file="../idiomas/pieTraduccion.asp"-->
</body>
</html>
