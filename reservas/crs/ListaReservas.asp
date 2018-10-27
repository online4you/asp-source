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
cs="SELECT CodigoEsta,Nombre,Estado FROM " & precrs & "Establecimientos Establecimientos " & buscoHoteles
cs=cs & " ORDER BY nombre"
'response.write cs
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

modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			on error resume next
			base.BeginTrans
			
			'anular Reserva
			cs="UPDATE " & precrs & "Reservas SET Activa=0, Anulada=1,"
			cs=cs & "FechaModificacion=" & FechaMySQL(date) & " "
			cs=cs & "WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "Cod_res=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
		end if
		
	
	case "actu"
		MiId=request.form("id")
		activa=request.form("activa")
		tpelas=QuitarComa2(request.form("importe"))
		prepago=QuitarComa2(request.form("prepago"))
		obs=QuitarApos(request.form("obs"))
		
		on error resume next
		base.BeginTrans
			
		'Reservas
		cs="UPDATE " & precrs & "Reservas SET "
		cs=cs & "Activa=" & activa & ","
		cs=cs & "Importe=" & tpelas & ","
		cs=cs & "ImportePag=" & prepago & ","
		cs=cs & "Comentarios='" & obs & "' "
		cs=cs & "WHERE Cod_res=" & MiId
		'response.write cs & "<br>"
		base.execute cs
		
		'Actualizar los datos de la ficha
		apellidos=QuitarApos(request.form("apellidos"))
		nombre=QuitarApos(request.form("nombre"))
		direccion=QuitarApos(request.form("direccion"))
		cp=QuitarApos(request.form("cp"))
		poblacion=QuitarApos(request.form("poblacion"))
		provincia=QuitarApos(request.form("provincia"))
		pais=QuitarApos(request.form("pais"))
		telefono=QuitarApos(request.form("telefono"))
		fax=QuitarApos(request.form("fax"))
		email=QuitarApos(request.form("email"))
		
		cs="UPDATE " & precrs & "Fichas SET Apellidos='" & apellidos & "',"
		cs=cs & "Nombre='" & nombre & "',"
		cs=cs & "Direccion='" & direccion & "',"
		cs=cs & "CP='" & cp & "',"
		cs=cs & "Poblacion='" & poblacion & "',"
		cs=cs & "Provincia='" & provincia & "',"
		cs=cs & "NombrePais='" & pais & "',"
		cs=cs & "Telefono='" & telefono & "',"
		cs=cs & "Fax='" & fax & "',"
		cs=cs & "EMail='" & email & "' "
		cs=cs & "WHERE CodReserva=" & MiId
		base.execute cs
		controlRegistro(cs) 'guarda seguimiento
		
		if err.number<>0 then base.RollBackTrans
		base.CommitTrans
		on error goto 0
	
end select

'Quitar filtro
if request.QueryString("sf")="si" then response.Cookies("filtrores")=""

condicion=request.Cookies("filtrores")
if condicion="" then
	condicion="WHERE Reservas.CodigoEsta=" & est & " AND Anulada=0 AND YEAR(Reservas.FechaReserva)=" & anyo & " ORDER BY Cod_res DESC"
end if

hayPromocion=false
if instr(lcase(condicion),"codigopromocion")<>0 then 'filtra por promocion
	hayPromocion=true
end if

'Lista de registros
cs="SELECT Cod_res,Reservas.FechaReserva,Reservas.FechaIni,Reservas.FechaFin,Fichas.Apellidos as Ape1,"
cs=cs & "Fichas.Nombre as Nom,Fichas.Telefono,Reservas.Importe,Reservas.Activa,Establecimientos.Nombre,TipoVenta "
if not hayPromocion then 
	cs=cs & "FROM (" & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos " 
	cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) LEFT JOIN " & precrs & "Fichas Fichas "
	cs=cs & "ON Reservas.IdCliente=Fichas.Id "
else 'hay filtro por promocion
	cs=cs & "FROM (((" & precrs & "Reservas Reservas INNER JOIN " & precrs & "Establecimientos Establecimientos " 
	cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) LEFT JOIN " & precrs & "OfertasReserva OfertasReserva "
	cs=cs & "ON Reservas.Cod_Res=OfertasReserva.IdReserva) LEFT JOIN " & precrs & "Ofertas Ofertas "
	cs=cs & "ON OfertasReserva.IdOferta=Ofertas.Id) LEFT JOIN " & precrs & "Fichas Fichas "
	cs=cs & "ON Reservas.IdCliente=Fichas.Id "
end if 'hayPromocion
cs=cs & condicion
'response.write cs & "<br>"
rs.Open cs, base
haylista=false
if not rs.eof then
	RegLista=rs.GetRows
	RCodi=0
	RAlta=1
	RFIni=2
	RFFin=3
	RApe=4
	RNombre=5
	RTele=6
	RPelas=7
	RConfi=8
	REsta=9
	RTipoV=10
	haylista=true

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
	if Pag<1 then Pag=1
	if Pag>MaxP then Pag=MaxP

	IReg=(Pag*PorPag)-PorPag
	
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
		document.f1.action="<%=MiPag%>?modo=borra&p=<%=p%>";
		document.f1.submit();
	}
}

function SinFiltro(){
	window.location="<%=MiPag%>?sf=si";
}
function verFicha(id){
	top.creaFlotante("verListaReservas.asp?id="+id+"&recarga="+self.name,550,530,0,0);
}
function verFiltro(){
	top.creaFlotante("filtroListaReservas.asp?recarga="+self.name,510,240,0,0);
}

function grabaCSV(){
	document.getElementById('paCSV').src="csv_listareservas.asp";
}
</script>
</head>
<body>
<!--style="height:300px;width:300px;display: block"-->
<iframe id='paCSV' name="paCSV"   frameborder='0' src='vacio.htm' class='ficha'></iframe>
<!--#include file="capaRecarga.asp"-->
<!--#include file="includes/porPagina.asp"-->
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="760"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr> 
                <td align='right' colspan="10"> <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_filtralistado")%>' onclick="javascript:verFiltro();"> 
                  <input type='button' class="boton145Excel" value='<%=objIdioma.getTraduccionHTML("i_exportacsv")%>' onclick="javascript:grabaCSV();"> 
				  
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_anularmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr> 
                <td colspan="11" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_listareservas")%></td>
              </tr>
              <tr> 
                <th class="colu_par">&nbsp;</th>
                <th class="colu_par"><%=objIdioma.getTraduccionHTML("i_reserva")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_freserva")%></th>
                <th align='center' class="colu_par">Hotel</th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fllegada")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fsalida")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_apellidos")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nombre")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_importe")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_tipoventa")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_confir")%></th>
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
                <td align="center" width='10' class='<%=estilo%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=estilo%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a></td>
                <td align="center" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=VerFecha(RegLista(RAlta,r))%></a></td>
                <td align="center" class='<%=estilo%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(REsta,r)%></a></td>
                <td align="center" class='<%=estilo%>' > <%=VerFecha(RegLista(RFIni,r))%> 
                </td>
                <td align="center" class='<%=estilo%>' > <%=VerFecha(RegLista(RFFin,r))%> 
                </td>
                <td align="left" class='<%=estilo%>' > <%=server.HTMLEncode("" & RegLista(RApe,r))%>&nbsp;</td>
                <td align="left" class='<%=estilo%>' > <%=RegLista(RNombre,r)%>&nbsp;</td>
                <td align="right" class='<%=estilo%>' > <%=formatnumber(RegLista(RPelas,r),2)%></td>
                <td align="center" class='<%=estilo%>' > 
                  <%if RegLista(RTipoV,r)=0 or RegLista(RTipoV,r)=2 then 'OnLine
			response.write "OnLine"
		else
			response.write "OR"
		end if%>
                </td>
                <td align="center" class='<%=estilo%>' > 
                  <%if RegLista(RConfi,r) then 'COnfirmada
			response.write objIdioma.getTraduccionHTML("i_si")
		else
			response.write objIdioma.getTraduccionHTML("i_no")
		end if%>
                </td>
              </tr>
              <%
	next
end if%>
              <tr> 
                <td align="center" colspan="11" class="tituloTabla"> <!--#include file="controlPaginas.asp"--> </td>
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
