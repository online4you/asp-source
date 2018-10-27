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

%><!--#include file="monedaHotel.asp"--><%

if request.form<>"" then
	modo=request.QueryString("modo")
	MiId=request.form("id")
	select case modo 
		case "borra" 'Borrar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs=""
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				
				on error resume next
				base.BeginTrans
				
				base.execute "DELETE FROM " & precrs & "Ofertas WHERE " & cs
				controlRegistro("DELETE FROM " & precrs & "Ofertas WHERE " & cs) 'guarda seguimiento
				
				'Borrar traducciones
				cs=replace(cs,"Id=","IdReferencia=")
				base.execute "DELETE FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='Ofertas'"
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
				
			end if
		case "duplica" 'Duplicar marcadas
			queborro=split(request.form("aborrar"),",")
			if ubound(queborro)>=0 then
				cs=""
				for t=0 to ubound(queborro)
					if clng(queborro(t))<>0 then 'Para no borrar la cero
						cs=cs & "Id=" & trim(queborro(t)) & " OR "
					end if
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				
				on error resume next
				base.BeginTrans
				columns=" CodigoEsta,IdHabitacion,AplicarEn,CodigoSuple,PorPersona, "
				columns=columns & "Colectivo,Texto,FechaInicio,FechaFin,Caduca,TotalNoches,Dto,Precio,Titulo, "
				columns=columns & "Foto1,Foto2,Destacada,Activa,Calcula,FechaReserva,DiasSemana,NochesGratis,CodigoPromocion, "
				columns=columns & "DiasAdelanto,Tarifa,Valida,CodigoOferta "

				toExex="insert into  " & precrs & "Ofertas (" & columns & ") select "
				toExex=toExex & columns
				toExex=toExex & "FROM " & precrs & "Ofertas WHERE " & cs

				base.execute toExex
				
				controlRegistro(toExex) 'guarda seguimiento
				
				'Borrar traducciones
				cs=replace(cs,"Id=","IdReferencia=")
				columns=" IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta "
				
				insertColumns=" (select max(id) from " & precrs & "Ofertas),Idioma,Tabla,Campo,Traduccion,CodigoEsta "
				
				toExex="insert into " & precrs & "Traducciones (" & columns & ") select "
				toExex=toExex & insertColumns
				toExex=toExex & " FROM " & precrs & "Traducciones WHERE " & cs & " AND Tabla='Ofertas'"
				'response.write   toExex
				'response.end()
				base.execute toExex
				
				if err.number<>0 then base.RollBackTrans
				base.CommitTrans
				on error goto 0
				
			end if	
	end select
end if

'Lista de registros
cs="SELECT Ofertas.Id,IF(ISNULL(Traducciones.Traduccion),Ofertas.Titulo,Traducciones.Traduccion)AS Tradu,"
cs=cs & "FechaInicio,FechaFin,APlicarEn,Dto,Precio,Caduca,Calcula,Activa,CodigoPromocion,Valida, CodigoOferta, "
cs=cs & " IF(ISNULL(tiphab.Nombre),'Todas',tiphab.Nombre) Nom "
cs=cs & "FROM " & precrs & "Ofertas Ofertas "
cs=cs & " left join jos_crs_tipohabitanombres tiphab on Ofertas.IdHabitacion=tiphab.id "
cs=cs & " LEFT JOIN " & precrs & "Traducciones Traducciones "
cs=cs & "ON Ofertas.Id=Traducciones.IdReferencia AND Tabla='Ofertas' AND Campo='Titulo' "
cs=cs & "AND Idioma='" & lang & "' "
cs=cs & "WHERE Ofertas.CodigoEsta=" & est
cs=cs & " AND (YEAR(FechaInicio)=" & anyo & " OR YEAR(FechaFin)=" & anyo & ") "
cs=cs & "ORDER BY FechaInicio"
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
	RPelas=6
	RCaduca=7
	RCalcula=8
	RActiva=9
	RPromo=10
	RValida=11
	RCodigoOferta=12
	RTipoHab=13
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
<script language="javascript">
function ABorrar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=borra";
		document.f1.submit();
	}
}
function ADuplicar(){
	if (confirm('<%=objIdioma.getTraduccion("i_seguro")%>')){
		document.f1.action="<%=MiPag%>?est=<%=est%>&modo=duplica";
		document.f1.submit();
	}
}
anchoWin=820;
<%if con_cms then%>
anchoWin=940;
<%end if%>
function enBlanco(){
	top.creaFlotante("verOfertas.asp?id=0&est=<%=est%>&recarga="+self.name,anchoWin,500,0,0);
}
function verFicha(id){
	top.creaFlotante("verOfertas.asp?id="+id+"&est=<%=est%>&recarga="+self.name,anchoWin,500,0,0);
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
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <table align='left' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <td align='right' colspan="12"> 
					<input type='button' class="boton145" onclick="javascript:ADuplicar();" value='<%=objIdioma.getTraduccionHTML("i_duplicar")%>'> 
					<input type='button' class="boton145" onclick="javascript:enBlanco();" value='<%=objIdioma.getTraduccionHTML("i_nuevaoferta")%>'> 
					<input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr> 
                <td colspan="13" align="left" class="tituloTabla" ><%=objIdioma.getTraduccionHTML("i_ofertas")%></td>
              </tr>
              <tr> 
                <th class="colu_par"></th>
                <th class="colu_par">Id</th> 
                <th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_titulo")%></th>
				<th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_tipohabi")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fechainicio")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fechafinal")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fvalida")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fcaduca")%></th>
                <!--
	<th align='left' class="colu_par"><%=objIdioma.getTraduccionHTML("i_aplicaoferta")%></th>-->
                <th align='center' class="colu_par">% <%=objIdioma.getTraduccionHTML("i_dto")%></th>
                <th align='right' class="colu_par"><%=objIdioma.getTraduccionHTML("i_precio")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_calcula")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_activa")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_promocion")%></th>
              </tr>
              <%if haylista then
		for R=0 to ubound(RegLista,2)
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" width='10' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a> 
                </td>
                <td align="left" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=mid(RegLista(RNom_es,r),1,70)%></a> 
                </td>
                <td align="center" class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RTipoHab,r)%></a> 
                </td>
 				<td align='center' class='<%=estilo%>' > <%=VerFecha(RegLista(RFIni,r))%> 
                </td>
                <td align='center' class='<%=estilo%>' > <%=VerFecha(RegLista(RFFin,r))%> 
                </td>
                <td align='center' class='<%=estilo%>' > <%=VerFecha(RegLista(RValida,r))%> 
                </td>
                <td align='center' class='<%=estilo%>' > <%=VerFecha(RegLista(RCaduca,r))%> 
                </td>
                <!--
	  <td align="left" class='<%=estilo%>' >
	  	<%select case RegLista(RAplicar,r)
				case 0
					texto=objIdioma.getTraduccionHTML("i_todo")
				case 1
					texto=objIdioma.getTraduccionHTML("i_habitacion")
				case 2
					texto=objIdioma.getTraduccionHTML("i_regimen")
			end select%>
			<%=texto%>
	</td>-->
                <td align="center" class='<%=estilo%>'> <%=RegLista(RDto,r) & " %"%> 
                </td>
                <td align="right" class='<%=estilo%>'> <%=formatnumber(RegLista(RPelas,r),2) & sufijoMoneda%> 
                </td>
                <td align="center" class='<%=estilo%>'>&nbsp; 
                  <%if RegLista(RCalcula,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
                </td>
                <td align="center" class='<%=estilo%>'>&nbsp; 
                  <%if RegLista(RActiva,r) then response.write objIdioma.getTraduccionHTML("i_si")%>
                </td>
                <td align="center" class='<%=estilo%>'>&nbsp; <%=RegLista(RCodigoOferta,r)%> 
                </td>
              </tr>
              <%
	next
	end if%>
              <tr> 
                <td align="center" colspan="13" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
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
