<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #Include File="Connections/Functions.asp"-->
<%
If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()

CodigoEsta=request.querystring("codesta")
idservi=request.QueryString("idservi")
idi=request.QueryString("idi")

if request.form("CodigoEsta")<>"" then 'Tengo que actualizar o borrar
	CodigoEsta=request.form("CodigoEsta")
	idservi=request.form("idservi")
	idi=request.form("idi")
	idservitempo=request.form("idservitempo")
	idservicolec=request.form("idservicolec")
	precio=request.form("txtprecio")
	if precio="" then precio="0"
	if not isnumeric(precio) then precio="0"
	precio=replace(precio,",",".")
	porperso=request.Form("porperso")
	
	if request.Form("modo")="act" then 'actuliza o añade
		'Si no existe añado
		cs="SELECT IdServicio FROM " & precrs & "ServiciosTemporadas "
		cs=cs & "WHERE IdServicio=" & idservi & " AND IdTemporada=" & idservitempo
		cmdDC.CommandText = cs
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open cmdDC, , 2, 2
		if rs.eof then 'Añadir registro
			rs.close
			set rs=nothing
			cs="INSERT INTO " & precrs & "ServiciosTemporadas (IdServicio,IdTemporada,IdColectivo,Importe,Porpersona) "
			cs=cs & " VALUES (" & idservi & "," & idservitempo & ",0," & precio & "," & porperso & ")"
			cmdDC.CommandText = cs
			cmdDC.Execute
		
		else 'Actualizar registro
			rs.close
			set rs=nothing
			cs="UPDATE " & precrs & "ServiciosTemporadas SET "
			cs=cs & "IdServicio=" & idservi
			cs=cs & ",IdTemporada=" & idservitempo
			cs=cs & ",Importe=" & precio
			cs=cs & ",Porpersona=" & porperso
			cs=cs & " WHERE IdServicio=" & idservi & " AND IdTemporada=" & idservitempo
			cmdDC.CommandText = cs
			cmdDC.Execute
		
		end if
	else 'Borrar
		cs="DELETE FROM " & precrs & "ServiciosTemporadas "
		cs=cs & "WHERE IdServicio=" & idservi & " AND IdTemporada=" & idservitempo
		cmdDC.CommandText = cs
		cmdDC.execute
	
	end if
end if

Function ArrayDatosServiTempo()
	if CodigoEsta<>"" and isnumeric(idservi) then 
		'Codigos temporadas en el servicio
		Set rs = Server.CreateObject("ADODB.Recordset")
		Set rss= Server.CreateObject("ADODB.Recordset")
		sql="SELECT idtemporada FROM ServiciosTemporadas "
		sql=sql & "WHERE IdServicio=" & idservi
		cmdDC.CommandText = sql
		rs.Open cmdDC, , 2, 2
		response.write "<script language='javascript'>" & vbcrlf
		do while not rs.eof
			response.Write "servitempo[" & rs("IdTemporada") & "]=new Array ();"
			'Datos por cada temporada
			sql="SELECT IdColectivo,Importe,PorPersona FROM " & precrs & "ServiciosTemporadas "
			sql=sql & "WHERE IdServicio=" & idservi & " AND IdTemporada=" & rs("idtemporada")
			cmdDC.CommandText = sql
			rss.Open cmdDC, , 2, 2
			i=0
			do while not rss.eof
				response.Write("servitempo[" & rs("IdTemporada") & "][" & i & "]=new Array ();") & vbcrlf
				response.Write("servitempo[" & rs("IdTemporada") & "][" & i & "][0]='" & rss("IDColectivo") & "';" & chr (13))
				response.Write("servitempo[" & rs("IdTemporada") & "][" & i & "][1]='" & rss("Importe") & "';" & chr (13))
				response.Write("servitempo[" & rs("IdTemporada") & "][" & i & "][2]='" & rss("porpersona") & "';" & chr (13))
				i=i+1
				rss.movenext
			loop
			rss.close
			rs.MoveNext()
		loop
		rs.Close()
		set rs = nothing
		set rss=nothing
		response.Write("</script>")

	end if
end function

'Desactivar controles cuando esta en idioma
function Desactiva()
	if  idi<>"es" and  idi<> "" then response.Write("Disabled")
end function

'Buscar nombre servicio
nservicio="Servicio no seleccionado"
if isnumeric(idservi) then
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql="SELECT nombre FROM " & precrs & "ServiciosNombres "
	sql=sql & "WHERE IdServicio=" & idservi & " AND idioma='" & idi & "'"
	cmdDC.CommandText = sql
	rs.Open cmdDC, , 2, 2
	if not rs.eof then
		nservicio=rs("nombre")
	end if
	rs.close
	set rs=nothing
end if
%>

<html>
<head>
<title>Servicios Temporadas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css1.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
function reloadpage(modo){
	document.f1.modo.value=modo;
	document.f1.submit();
}
</script>
<body bgcolor="#FFF8DD" link="#ffffff" vlink="#ffffff" alink="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="f1" method="post" action="Servitempo.asp">
                <table bgcolor="#FFF8DD" width="375" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td height="17" colspan="4" bgcolor="#FFCC99"><div align="center"><strong>Precios 
                        Servicios</strong></div></td>
                  </tr>
                  <tr> 
                    <td height="17" bgcolor="#FFF8DD">&nbsp;</td>
                    <td bgcolor="#FFF8DD">&nbsp;</td>
                    <td bgcolor="#FFF8DD" clspan='2'><%=nservicio%></td>
                  </tr>
                  <tr> 
                    <td width="10%" height="17" bgcolor="#FFF8DD">&nbsp;</td>
                    <td width="25%" bgcolor="#FFF8DD">Temporada</td>
                    <td width="38%" bgcolor="#FFF8DD"><select name="idservitempo">
					<option value='0'>En todas las temporadas</option>
                        <%
				i=0
				if CodigoEsta<>"" then 
					sql="SELECT CodigoTemp,Nombre FROM " & precrs & "Temporadas INNER JOIN TemporadasNomres "
					sql=sql & "ON Temporadas.CodigoTemp=TemporadasNomres.TempIdi "
					sql=sql & "WHERE CodigoEsta=" & CodigoEsta & " AND Idioma='" & idi & "' "
					sql=sql & "ORDER BY nombre"
					cmdDC.CommandText = sql
					Set rs = Server.CreateObject("ADODB.Recordset")
					rs.Open cmdDC, , 2, 2
					dim marca
					marca=""
					do while not rs.eof
						if rs("codigotemp")=idservitempo then marca="selected"
						response.Write "<option value='" & rs("CodigoTemp") & "' " & marca & ">" & rs("Nombre") & "</option>" & vbcrlf
						marca=""
						rs.movenext
					loop
					rs.close
					set rs=nothing
					
				end if%>
                      </select>
					 <%ArrayDatosServiTempo 'Carga en una tabla idcole,importe,porpersona %>
					 </td>
                    <td width="5%" bgcolor="#FFF8DD">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td width="10%" height="17" bgcolor="#FFF8DD">&nbsp;</td>
                    <td width="25%" bgcolor="#FFF8DD">Colectivo</td>
                    <td width="38%" bgcolor="#FFF8DD"><select name="idservicolec">
					<option value="sel" selected>Seleccione</option>
					<option value='0'>Cualquier Colectivo</option>
                        <%
				i=0
				if CodigoEsta<>"" then 
					sql="SELECT ColectivoIdi,Nombre FROM " & precrs & "ColectivosNomres INNER JOIN Colectivos "
					sql=sql & "ON ColectivosNomres.ColectivoIdi=Colectivos.CodigoColec "
					sql=sql & "WHERE CodigoEsta=" & CodigoEsta & " AND Idioma='" & idi & "' "
					cmdDC.CommandText = sql
					Set rs = Server.CreateObject("ADODB.Recordset")
					rs.Open cmdDC, , 2, 2
					marca=""
					do while not rs.eof
						if rs("ColectivoIdi")=idservicolec then marca="selected"
						response.Write "<option value='" & rs("ColectivoIdi") & "' " & marca & ">" & rs("Nombre") & "</option>" & vbcrlf
						marca=""
						rs.movenext
					loop
					rs.close
					set rs=nothing
					
				end if%>
                      </select>
					 </td>
                    <td width="5%" bgcolor="#FFF8DD">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#FFF8DD">&nbsp;</td>
                    <td bgcolor="#FFF8DD">Importe</td>
                    <td bgcolor="#FFF8DD"><input name="txtprecio" type="text" value="" size="10" <%Desactiva%>>
                      % </td>
                    <td bgcolor="#FFF8DD">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#FFF8DD">&nbsp;</td>
                    <td bgcolor="#FFF8DD">&nbsp;</td>
                    <td bgcolor="#FFF8DD" colspan='2'><input type="radio" name="porperso"  value="-1"   <%Desactiva%>>
                      x Por persona &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="porperso"  value="0" <%Desactiva%>>
                      x Por reserva</td>
                  </tr>
                  <tr> 
                    <td colspan='4' align='center'><input type="button" onClick="return reloadpage('act')" value="Actualizar " <%Desactiva%>> 
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Borrar" onClick="return reloadpage('borr')" <%Desactiva%>></td>
                  </tr>
                </table>

<input type='hidden' name='CodigoEsta' value='<%=CodigoEsta%>'>
<input type='hidden' name='idservi' value='<%=idservi%>'>
<input type='hidden' name='idi' value='<%=idi%>'>
<input type='hidden' name='modo'>
<iframe id='verFicha' name='verFicha' frameborder="0" hspace="0" vspace="0" src="" class="ficha"></iframe>
</form>
</body>
</html>
