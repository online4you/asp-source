<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

%><!--#include file="actuTarifa.asp"--><%

'Lista de registros
cs="SELECT Id,Nombre_es,Nombre_it,Nombre_en,Nombre_de,Nombre_fr FROM " & precrs & "Tarifas Tarifas "
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RNom_es=1
	RNom_it=2
	RNom_en=3
	RNom_de=4
	RNom_fr=5
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
<link href="nuevaF.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	//palIframe(document.getElementById("verFicha"),450,200,0,0,"verTiposHotel.asp?id=0&recarga="+self.name);
	top.creaFlotante("verTarifa.asp?id=&recarga="+self.name,450,320,0,0);
}
function verFicha(id){
	//palIframe(document.getElementById("verFicha"),510,200,0,0,"verTiposHotel.asp?id="+id+"&est=<%=est%>");
	top.creaFlotante("verTarifa.asp?id="+id+"&recarga="+self.name,450,200,0,0);
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
          <td align="left" width="760"> <table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
              <tr>
                <td align="right" colspan="7"> <input type='button' class="boton145" style='cursor:pointer' onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevatarifa")%>'> 
                  <input type='button' class="boton145" style='cursor:pointer' value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="7" align="left" class="tituloTabla"><%=Ucase(objIdioma.getTraduccionHTML("i_tarifas"))%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_impar" align="center">ID</th>
                <th align='left' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_nombre_esp")%></th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nombre_ita")%></th>
                <th align='left' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_nombre_ing")%></th>
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nombre_ale")%></th>
                <th align='left' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_nombre_fra")%></th>
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
                <td align="center" width='20' class='<%=laColu(0)%>'> 
                  <%if RegLista(RCodi,r)<>1 then 'la tarifa general no se puede borrar%>
                  <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                  <%end if%>
                </td>
                <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNom_es,r)%></a> 
                </td>
                <td align="left" class='<%=laColu(0)%>'> <%=RegLista(RNom_it,r)%> 
                </td>
                <td align="left" class='<%=laColu(1)%>'> <%=RegLista(RNom_en,r)%> 
                </td>
                <td align="left" class='<%=laColu(0)%>'> <%=RegLista(RNom_de,r)%> 
                </td>
                <td align="left" class='<%=laColu(1)%>'> <%=RegLista(RNom_fr,r)%> 
                </td>
              </tr>
              <%
			next
			end if%>
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
