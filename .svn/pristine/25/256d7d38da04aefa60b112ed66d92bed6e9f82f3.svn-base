<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<!--#include file="includes/claseCookie.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
dim TIdiomas() 'texto para idiomas

set objCookies = new clsCookie 'carga la clase para las cookies con la cookie (IDCR) id usuario

set base=server.createobject("ADODB.Connection")
base.Open Conecta
'responseLog(Conecta & "<br>")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

modo=request.QueryString("modo")
if modo="borra" then 'Borrar marcadas
	queborro=split(request.form("aborrar"),",")
	if ubound(queborro)>=0 then
		cs="("
		for t=0 to ubound(queborro)
			if clng(queborro(t))<>0 then 'Para no borrar la cero
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			end if
		next
		if right(cs,4)=" OR " then 'Quitar el ultimo operador
			cs=left(cs,len(cs)-4)
		end if
		cs=cs & ")"
		
		on error resume next
		base.BeginTrans
			
		base.execute "DELETE FROM " & precrs & "Caracteristicas WHERE " & cs
		controlRegistro("DELETE FROM " & precrs & "Caracteristicas WHERE " & cs) 'guarda seguimiento
		
		'Borrar traducciones
		cs=replace(cs,"Id=","IdReferencia=")
		base.execute "DELETE FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='Caracteristicas'"
		
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0
		
	end if

	'borra grupos
	queborro=split(request.form("aborrarG"),",")
	if ubound(queborro)>=0 then
		cs="("
		for t=0 to ubound(queborro)
			if clng(queborro(t))<>0 then 'Para no borrar la cero
				cs=cs & "Id=" & trim(queborro(t)) & " OR "
			end if
		next
		if right(cs,4)=" OR " then 'Quitar el ultimo operador
			cs=left(cs,len(cs)-4)
		end if
		cs=cs & ")"
		
		on error resume next
		base.BeginTrans
			
		base.execute "DELETE FROM " & precrs & "GrupoCaracteristicas WHERE " & cs
		controlRegistro("DELETE FROM " & precrs & "GrupoCaracteristicas WHERE " & cs) 'guarda seguimiento
		
		'Borrar traducciones
		cs=replace(cs,"Id=","IdReferencia=")
		base.execute "DELETE FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='GrupoCaracteristicas'"
		
		cs=replace(cs,"IdReferencia=","IdGrupo=")
		'buso las caracteristicas para borrar las traducciones
		sql="SELECT Id FROM " & precrs & "Caracteristicas WHERE " & cs
		rs.open sql,base
		hayregis=false
		if not rs.eof then
			RegRegis=rs.getrows
			hayregis=true
		end if
		rs.close
		
		'Borrar las caracteristicas de ese grupo
		base.execute "DELETE FROM " & precrs & "Caracteristicas WHERE " & cs
		
		if hayregis then
		for r=0 to ubound(RegRegis,2)
			'Borrar traducciones
			base.execute "DELETE FROM " & precrs & "Traducciones WHERE IdReferencia=" & RegRegis(0,r) & " AND Tabla='Caracteristicas'"
		next
		end if 'hayregis
				
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0
		
	end if



end if 'modo=borra

'Lista de registros
cs="SELECT "
cs=cs & "GrupoCaracteristicas.Id, "
cs=cs & "IF(ISNULL(traducgrupocarac.Traduccion),GrupoCaracteristicas.Nombre,traducgrupocarac.Traduccion) AS Grupo, "
cs=cs & "Caracteristicas.Id, "
cs=cs & "IF(ISNULL(traduccarac.Traduccion),Caracteristicas.Caracteristica,traduccarac.Traduccion) AS Caracter, "
cs=cs & "Caracteristicas.Orden, "
cs=cs & "Caracteristicas.Destacada  "
cs=cs & "FROM  "
cs=cs & "" & precrs & "GrupoCaracteristicas GrupoCaracteristicas  "
cs=cs & "LEFT JOIN " & precrs & "Caracteristicas Caracteristicas ON GrupoCaracteristicas.Id=Caracteristicas.IdGrupo  "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""GrupoCaracteristicas"" And Campo = ""Nombre"" And Idioma = ""es"")  AS traducgrupocarac ON GrupoCaracteristicas.Id = traducgrupocarac.IdReferencia  "
cs=cs & "LEFT JOIN (SELECT Traduccion,IdReferencia FROM " & precrs & "Traducciones Traducciones WHERE Tabla = ""GrupoCaracteristicas"" And Campo = ""Caracteristica"" And Idioma = ""es"")  AS traduccarac ON Caracteristicas.Id = traduccarac.IdReferencia  "
cs=cs & "ORDER BY GrupoCaracteristicas.Orden,GrupoCaracteristicas.Id, Caracteristicas.Orden DESC,Caracteristicas.ID DESC "


'responseLog(cs & "<br>")
rs.Open cs, base
hayLista=false
if not rs.eof then
	RegLista=rs.GetRows
	RIdGrupo=0
	RGrupo=1
	RCodi=2
	RNombre=3
	ROrden=4
	RDesta=5
	hayLista=true
	
	PorPag=paClng(objCookies.getCookie(lcase(MiPag)))
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
	
end if 'eof
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
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?modo=borra";
		document.f1.submit();
	}
}

function enBlanco(){
	top.creaFlotante("verCaracter.asp?id=0&recarga="+self.name,450,250,0,0);
}
function nuevoGrupo(){
	top.creaFlotante("verGrupo.asp?id=0&recarga="+self.name,450,250,0,0);
}
function verFicha(id){
	top.creaFlotante("verCaracter.asp?id="+id+"&recarga="+self.name,450,250,0,0);
}
function verGrupo(id){
	top.creaFlotante("verGrupo.asp?id="+id+"&recarga="+self.name,450,250,0,0);
}
</script>
<body>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <table border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;" width="100%">
              <tr> 
                <td align="right" colspan="8"> <input type='button' class="boton145" onclick="javascript:nuevoGrupo();" value='<%=objIdioma.getTraduccionHTML("i_nuevogrupo")%>'> 
                  <input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevacaracteristica")%>'> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcados")%>' onclick='javascript:ABorrar();'>	
                </td>
              </tr>
              <tr> 
                <td colspan="8" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_caracter")%></td>
              </tr>
              <tr> 
                <th class='colu_par'></th>
                <th class='colu_par' align="center">ID</th>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_grupocaracter")%></th>
                <th class='colu_par'></th>
                <th class='colu_par' align="center">Id</th>
                <th align='left' class='colu_par'><%=objIdioma.getTraduccionHTML("i_caracter")%></th>
                <th align='center' class='colu_par'><%=objIdioma.getTraduccionHTML("i_orden")%></th>
                <th align='center' class='colu_par'><%=objIdioma.getTraduccionHTML("i_destacada")%></th>
              </tr>
              <%if haylista then
		anteGrupo=0
		for R=IReg to IReg+PorPag-1
			if R>ubound(RegLista,2) then exit for
			if (r mod 2)=0 then 
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <%if anteGrupo<>RegLista(RIdGrupo,r) then 
			anteEstilo=estilo
			estilo=estilo & " rallita"%>
                <td align="center" width='20' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrarG" value="<%=RegLista(RIdGrupo,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verGrupo(<%=RegLista(RIdGrupo,r)%>);'><%=RegLista(RIdGrupo,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verGrupo(<%=RegLista(RIdGrupo,r)%>);'><%=RegLista(RGrupo,r)%></a> 
                </td>
                <%else 'es el mismo %>
                <td class='<%=anteEstilo%>' colspan="3"></td>
                <%end if%>
                <td align="center" width='20' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RNombre,r)%></a> 
                </td>
                <td align="center" class='<%=estilo%>'><%=RegLista(ROrden,r)%></td>
                <td align="center" class='<%=estilo%>'> 
                  <%if RegLista(RDesta,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
                </td>
              </tr>
              <%
	  	anteGrupo=RegLista(RIdGrupo,r)
	next
	end if%>
              <tr> 
                <td align="center" colspan="8" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
  </div>
  <!-- iframeConte -->
</div> <!-- iframePrincipal -->
<!--#include file="pieFrame.asp"-->
</body>
</html>
