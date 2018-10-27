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

modo=request.QueryString("modo")
select case modo 
	case "borra" 'Borrar marcadas
		queborro=split(request.form("aborrar"),",")
		if ubound(queborro)>=0 then
			cs="DELETE FROM " & precrs & "TipoReserva TipoReserva WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "IdReserva=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			'Borrar Reserva
			cs="DELETE FROM " & precrs & "Reservas WHERE "
			for t=0 to ubound(queborro)
				if clng(queborro(t))<>0 then 'Para no borrar la cero
					cs=cs & "Cod_res=" & trim(queborro(t)) & " OR "
				end if
			next
			if right(cs,4)=" OR " then 'Quitar el ultimo operador
				cs=left(cs,len(cs)-4)
			end if	
			base.execute cs
			
		end if
		
	
	case "actu"
		MiId=request.form("id")
		activa=request.form("activa")
		tpelas=QuitarComaMiles(request.form("importe"))
		prepago=QuitarComaMiles(request.form("prepago"))
		obs=QuitarApos(request.form("obs"))

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
	
end select

'Quitar filtro
if request.QueryString("sf")="si" then response.Cookies("filtroresAge")=""

condicion=request.Cookies("filtroresAge")
codagencia=paClng(session("codagencia"))
'response.write condicion
if condicion=""  then
	if codagencia=0 then
		condicion="WHERE Reservas.CodigoEsta=" & est & " AND YEAR(FechaReserva)=" & anyo & " AND codAgencia<>0 ORDER BY Cod_res DESC"
	else
		condicion="WHERE Reservas.CodigoEsta=" & est & " AND YEAR(FechaReserva)=" & anyo & " AND codAgencia=" & codagencia & " ORDER BY Cod_res DESC"
	end if
end if

'Lista de registros
cs="SELECT Cod_res,FechaReserva,FechaIni,FechaFin,Fichas.Apellidos as Ape1,"
cs=cs & "Fichas.Nombre as Nom,Fichas.Telefono,Importe,Reservas.Activa,Establecimientos.Nombre,TipoVenta,Agencias.Nombre "
cs=cs & "FROM ((" & precrs & "Reservas Reservas LEFT JOIN " & precrs & "Fichas Fichas "
cs=cs & "ON Reservas.IdCliente=Fichas.Id) INNER JOIN Establecimientos " 
cs=cs & "ON Reservas.CodigoEsta=Establecimientos.CodigoEsta) "
cs=cs & "INNER JOIN Agencias on Reservas.codAgencia=Agencias.Id " & condicion
'responseLog(cs & "<br>")
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
	RAnombre=11
	haylista=true

	PorPag=19
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
<!--#include file="../metasCabecera.asp"-->
<link href="../nuevaF.css" rel="stylesheet" type="text/css">
</head>
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
	top.creaFlotante("verListaReservas.asp?id="+id+"&recarga="+self.name,530,530,0,0);
}
function verFiltro(){
	//palIframe(document.getElementById("verFiltro"),510,200,0,0,"filtroListaReservas.asp");
	top.creaFlotante("filtroListaReservas.asp?p=<%=pag%>&recarga="+self.name,510,240,0,0);
}
</script>
<body>
<div id='iframePrincipal'>
	<div id='imgDerecha'></div>
	
  <div id='iframeConte'> 
    <form name='f1' method="post">
      <table border="0" align='left' cellpadding="0" cellspacing="0">
        <tr> 
          <td align="left" width="740"> <!--#include file="seleccionado.asp"--> <table align='center' border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:10px">
              <tr>
                <td align='right' colspan="12"> <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_filtralistado")%>' onclick="javascript:verFiltro();"> 
                  <input type='button' class="boton145" value='<%=objIdioma.getTraduccionHTML("i_borrarmarcadas")%>' onclick='javascript:ABorrar();'> 
                </td>
              </tr>
              <tr>
                <td colspan="12" align="left" class="tituloTabla"><%=objIdioma.getTraduccionHTML("i_listareservas")%></td>
              </tr>
              <tr> 
                <th class="colu_par">&nbsp;</th>
                <th class="colu_impar"><%=objIdioma.getTraduccionHTML("i_reserva")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_agencia")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_freserva")%></th>
                <th align='center' class="colu_par">Hotel</th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_fllegada")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_fsalida")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_apellidos")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_nombre")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_importe")%></th>
                <th align='center' class="colu_par"><%=objIdioma.getTraduccionHTML("i_tipoventa")%></th>
                <th align='center' class="colu_impar"><%=objIdioma.getTraduccionHTML("i_confir")%></th>
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
			if R>ubound(RegLista,2) then exit for
			if (r mod 2)=0 then
				estilo="fila_par"
			else 
				estilo="fila_impar"
			end if%>
              <tr> 
                <td align="center" width='10' class='<%=laColu(0)%>'> <input type="checkbox" style='border:none' class='inputCheck' name="aborrar" value="<%=RegLista(RCodi,r)%>"> 
                </td>
                <td align="center" width='40' class='<%=laColu(1)%>'> <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RCodi,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(RAnombre,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=VerFecha(RegLista(RAlta,r))%></a></td>
                <td align="center" class='<%=laColu(1)%>' > <a href='javascript:verFicha(<%=RegLista(RCodi,r)%>);'><%=RegLista(REsta,r)%></a></td>
                <td align="center" class='<%=laColu(0)%>' > <%=VerFecha(RegLista(RFIni,r))%> 
                </td>
                <td align="center" class='<%=laColu(1)%>' > <%=VerFecha(RegLista(RFFin,r))%> 
                </td>
                <td align="left" class='<%=laColu(0)%>' > <%=RegLista(RApe,r)%>&nbsp;</td>
                <td align="left" class='<%=laColu(1)%>' > <%=RegLista(RNombre,r)%>&nbsp;</td>
                <td align="right" class='<%=laColu(0)%>' > <%=formatnumber(RegLista(RPelas,r),2)%></td>
                <td align="center" class='<%=laColu(1)%>' > 
                  <%if RegLista(RTipoV,r)=0 or RegLista(RTipoV,r)=2 then 'OnLine
			response.write "OnLine"
		else
			response.write "OR"
		end if%>
                </td>
                <td align="center" class='<%=laColu(0)%>' > 
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
                <td align="center" colspan="12" class="tituloTabla"> <!--#include file="../controlPaginas.asp"--> </td>
              </tr>
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
