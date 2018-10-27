<%@LANGUAGE='VBScript'%>
<%Option Explicit%>
<%
If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()
%>
<!-- #Include File="Connections/Functions.asp"-->
<!-- #Include File="Connections/JSFunctions.js"-->
<!-- #Include File="Connections/IndexFunctions.asp"--> <%'funcions de Index.asp i inicilitzacio de variables%>

<%
if lcase(Valors(47,1)) <> lcase("Establecimientos") then
	if valors(0,1)="sel" then valors(0,1)=""
	if valors(0,1)="new" then valors(0,1)=""
end if
if ubound(split(session.Contents("QuinsHotels"),";",-1,vbTextCompare))=0 and session.Contents("QuinsHotels")<>"" then 
	valors(0,1)=session.Contents("QuinsHotels")
	cmdDC.CommandText = "SELECT Idioma FROM LocalParameters"
	Set rsDC = Server.CreateObject("ADODB.Recordset")
	rsDC.Open cmdDC, , 0, 2
	if session.Contents("idiomafet")="" then valors(2,1)=rsDC.Fields(0)
	session.Contents("idiomafet")=rsDC.Fields(0)
	rsdc.Close
	set rsDC=nothing
end if


'Funció per actualitzar/Gravar dades
SQLAccess

'Desactivar controles cuando esta en idioma
function Desactiva()
	if  Valors(2,1) <> "es" and  Valors(2,1) <> "" then response.Write("Disabled")
end function
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Hotel-Hoteles.com - Gestión</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css1.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
//Envio al iframe los datos cambiados de servicio
function DatosIFrame(idh,ids,idi){
	document.all.servitempos.src="ListaServicios.asp?codesta="+idh+"&idservi="+ids+"&idi="+idi;
}
</script>
<body bgcolor="#d7ecF7" alink="#ffffff" vlink="#ffffff" link="#ffffff">
<center>
<table width="750" border=0 cellpadding=0 cellspacing=0>
  <tr><td colspan="2" bgcolor="#003bb3" align="center" style="color:#ffffff;font-size:10pt;"><b>&nbsp;Central de Reservas Online</b></td></tr>
  <tr>
  	<td colspan="2" bgcolor="#54a2f0" align="center"><%=htmlen(debug)%></td>
  </tr>
  <tr> 
	  <td height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
  </tr>
  <tr> 
    <td width=375 height=20 bgcolor=#FFFFE align=center>
<form name="establecimiento">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFE1">
            <tr bgcolor="#FFCC33"> 
              <td  colspan="4">&nbsp;<img src="img/1.gif" alt="" width="15" height="15"><img src="img/establecimiento.gif" alt="" width="100" height="15"> 
              </td>
            </tr>
            <tr> 
              <td width="31%" >&nbsp;</td>
              <td width="19%" >&nbsp;</td>
              <td width="22%" >&nbsp; </td>
              <td width="28%" >&nbsp; </td>
            </tr>
            <tr> 
              <td colspan="2" > <select name="cbe1" id="select19"  onChange="document.forms.establecimiento.txte1.value=document.forms.establecimiento.cbe1.options[document.forms.establecimiento.cbe1.selectedIndex].text;return comprovar();">
                  <option value="sel" selected>Seleccione</option>
                  <%if session.Contents("QuinsHotels")="" then%>
                  <option value="new" <%if request.Form("hcbe1")="new" then RESPONSE.Write("SELECTED")%>>Nuevo</option>
                  <%End if%>
                  <%
				if session.Contents("QuinsHotels")="" then 
					SQL="SELECT Establecimientos.CodigoEsta, Establecimientos.Nombre, Establecimientos.Orde, Establecimientos.PorCiento, Establecimientos.Pers3, Establecimientos.Mindias FROM Establecimientos ORDER BY Orde"
				else
					SQL="SELECT Establecimientos.CodigoEsta, Establecimientos.Nombre, Establecimientos.Orde, Establecimientos.PorCiento, Establecimientos.Pers3, Establecimientos.Mindias FROM Establecimientos"
					ii=session.Contents("QuinsHotels")
					cont=""
					for i=0 to ubound(split(ii,";",-1,vbTextCompare))
						session.Contents("QuinsHotels")
						cont=cont & "(CodigoEsta = " & split(ii,";",-1,vbTextCompare)(i) & ") OR"
					next
					cont=left(cont,len(cont)-3)
					SQL=SQL & " WHERE " & cont
					SQL=SQL & " ORDER BY Orde"
				end if
				debug=SQL
				cmdDC.CommandText = SQL
				Set rsDC = Server.CreateObject("ADODB.Recordset")
				rsDC.Open cmdDC, , 0, 2
				i=0
				do while not rsdc.eof
					if cstr(rsdc(0)) = cstr(valors(0,1)) then  
						response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
						valors(53,1)=rsdc(2)
						valors(54,1)=rsdc(3)
						valors(55,1)=rsdc(4)
						valors(56,1)=rsdc(5)
					else
						response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
					end if
					Redim preserve estable(i+1)
					estable(i)=rsdc(0)
					i=i+1
					rsdc.movenext
				loop
				rsDC.close
				set rsDC=nothing
				response.Write("<script>var estable=new Array(" & i & ");var estableci=" & i & ";")
				for cont=0 to i-1
					response.Write("estable[" & cont & "]='" & estable(cont) & "';")
				next
				response.Write("</script>")			
				%>
                </select></td>
              <td>Nombre</td>
              <td><input name="txte1" type="text" id="txte12"  onChange="document.forms.actualizar.htxte1.value=document.forms.establecimiento.txte1.value" value="<%=Valors(1,1)%>" size="20" <%if session.Contents("TipusUser")<>"ADMIN" then response.Write("disabled")%>> 
              </td>
            </tr>
            <tr> 
              <td >&nbsp; </td>
              <td>&nbsp;</td>
              <td><div align="left">&nbsp;Orden </div></td>
              <td><select name="ordehotels" id="ordehotels" onChange="document.forms.actualizar.hordehotels.value=document.forms.establecimiento.ordehotels.value" <%Desactiva%> <%if session.Contents("TipusUser")<>"ADMIN" then response.Write("disabled")%>>
                  <option value="sel" selected>Seleccione</option>
                  <%for i=1 to 50%>
                  <%if isnumeric(valors(53,1)) then 
						if cint(valors(53,1))=i then %>
                  <option value="<%=i%>" selected><%=i%></option>
                  <%else%>
                  <option value="<%=i%>"><%=i%></option>
                  <%end if%>
                  <%else%>
                  <option value="<%=i%>"><%=i%></option>
                  <%end if%>
                  <%next%>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                  <option value="8">8</option>
                  <option value="9">9</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                  <option value="13">13</option>
                  <option value="14">14</option>
                  <option value="15">15</option>
                  <option value="16">16</option>
                  <option value="17">17</option>
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                  <option value="22">22</option>
                  <option value="23">23</option>
                  <option value="24">24</option>
                  <option value="25">25</option>
                  <option value="26">26</option>
                  <option value="27">27</option>
                  <option value="28">28</option>
                  <option value="29">29</option>
                  <option value="30">30</option>
                  <option value="31">31</option>
                  <option value="32">32</option>
                  <option value="33">33</option>
                  <option value="34">34</option>
                  <option value="35">35</option>
                  <option value="36">36</option>
                  <option value="37">37</option>
                  <option value="38">38</option>
                  <option value="39">39</option>
                  <option value="40">40</option>
                  <option value="41">41</option>
                  <option value="42">42</option>
                  <option value="43">43</option>
                  <option value="44">44</option>
                  <option value="45">45</option>
                  <option value="46">46</option>
                  <option value="47">47</option>
                  <option value="48">48</option>
                  <option value="49">49</option>
                  <option value="50">50</option>
                </select> </td>
            </tr>
            <tr> 
              <td>&nbsp;<%if valors(0,1)<>"" then 'Comprueba si hay hotel especific. %>
                <a href='DatosHotel.asp?est=<%=valors(0,1)%>&nest=<%=Valors(1,1)%>' target="_blank">&nbsp;Datos Alojamiento&nbsp;</a> 
                <%end if%></td>
              <td>&nbsp;</td>
              <td>D&iacute;as m&iacute;n.</td>
              <td><input name="mindias" type="text" id="mindias" onChange="document.forms.actualizar.hmindias.value=document.forms.establecimiento.mindias.value" value="<%=Valors(56,1)%>" maxlength="3" size="4" <%Desactiva%>></td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>Dto. 3a pers</td>
              <td><input name="pers3" type="text" id="pers3" onChange="document.forms.actualizar.hpers3.value=document.forms.establecimiento.pers3.value" value="<%=Valors(55,1)%>" maxlength="3" size="4" <%Desactiva%>>
                %</td>
            </tr>
            <tr> 
              <td >&nbsp;</td>
              <td>&nbsp;</td>
              <td>% Prepago</td>
              <td><input name="prepago" type="text" id="prepago" onChange="document.forms.actualizar.hprepago.value=document.forms.establecimiento.prepago.value" value="<%=Valors(54,1)%>" maxlength="3" size="4" <%Desactiva%>>
                %</td>
            </tr>
            <tr>
              <td><input type="button" name="Submit4" value="Actualizar" onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en ESTABLECIMIENTO.\nSi desea continuar pulse Aceptar.','Establecimientos','act')"> 
                <input type="button" name="Submit23" value="Borrar"  onClick="return reloadpage('Borrar un establecimiento supone la eliminación de TEMPORADAS, COLECTIVOS (y descuentos por colectivos), HABITACIONES, DESCUENTOS POR FECHAS y SUPLEMENTOS asociadas a éste.\nSi desea continuar pulse Aceptar.','Establecimientos','borr')" <%if session.Contents("TipusUser")<>"ADMIN" then response.Write("disabled")%>></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
      </form></td>
    <td width=375 height=20 align=center valign="top" bgcolor=#F9F0FB> 
      <form name="idioma" method="post" action="">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F9F0FB">
            <tr bgcolor="#CC99FF"> 
              <td height="17" colspan="4">&nbsp;<img src="img/2.gif" alt="" width="15" height="15"><img src="img/idioma.gif" alt="" width="100" height="15"></td>
            </tr>
            <tr> 
              <td >&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr> 
              <td> &nbsp; <select name="cbi1" id="select"  onChange="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados.\nSi desea continuar pulse Aceptar.','Idiomas','ref');document.forms.actualizar.hcbi1.value=document.forms.idioma.cbi1.value;">
                  <%
				cmdDC.CommandText = "SELECT Idioma FROM LocalParameters"
				Set rsDC = Server.CreateObject("ADODB.Recordset")
				rsDC.Open cmdDC, , 0, 2
				if session.Contents("idiomafet")="" then valors(2,1)=rsDC.Fields(0)
				session.Contents("idiomafet")=rsDC.Fields(0)
				rsDC.Close
				cmdDC.CommandText = "SELECT * FROM Idiomas ORDER By orden;"
				Set rsDC = Server.CreateObject("ADODB.Recordset")
				rsDC.Open cmdDC, , 0, 2
				i=0
				do while not rsdc.eof
					if cstr(rsdc(0)) = cstr(valors(2,1)) then  
						response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
					else
						response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
					end if
					Redim preserve Idiomas(i+1)
					Idiomas(i)=rsdc(0)
					i=i+1
					rsdc.movenext
				loop
				rsDC.close
				set rsDC=nothing
				response.Write("<script>var idiomas=new Array(" & i & ");var iditot=" & i & ";")
				for cont=0 to i-1
					response.Write("idiomas[" & cont & "]='" & Idiomas(cont) & "';")
				next
				response.Write("</script>")
				%>
                </select></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
      </form></td>
  </tr>
  <tr> 
    <td width=375 height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
  </tr>
  <tr> 
    <td width=375 height=114 align=cente valign="top" bgcolor=#F0FFFF><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F0FFFF">
        <form name="temporadas" method="post" action="">
          <tr bgcolor="#6699CC"> 
            <td height="17" colspan="4">&nbsp;<img src="img/3.gif" alt="" width="15" height="15"><img src="img/temporadas.gif" alt="habitaci&oacute;n" width="100" height="15"></td>
          </tr>
          <tr>
            <td height="17">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="87" height="17">&nbsp; </td>
            <td width="99"><select name="cbt1" id="select20"  onChange="document.forms.actualizar.hcbt1.value=document.forms.temporadas.cbt1.value;tempname()">
                <option value="sel" selected>Seleccione</option>
                <option value="new">Nueva</option>
                <%
				if Valors(0,1)<>"" then 
					cmdDC.CommandText = "SELECT CodigoTemp, FInicio, FFinal FROM Temporadas WHERE Temporadas.CodigoEsta = " & Valors(0,1)
					Set rsDC = Server.CreateObject("ADODB.Recordset")
					Set rs = Server.CreateObject("ADODB.Recordset")
					rsDC.Open cmdDC, , 2, 2
					i=1
					ii=1
					do while not rsdc.eof
						ii=ii+1
						rsDC.Movenext
					loop
					ReDim Preserve Tempora(ii,8)
					if ii>1 then rsDC.moveFirst()
					do while not rsdc.eof
						cmdDC.CommandText = "SELECT Nombre FROM TemporadasNomres WHERE (TempIdi = " & rsdc(0) & ") AND (Idioma = N'" & Valors(2,1) & "')"
						rs.Open cmdDC, , 0, 2
						Tempora(i-1,0)=rsdc(0)
						if not rs.eof then Tempora(i-1,1)=rs(0)
						if rs.eof then Tempora(i-1,1)=""
						rs.Close
						Tempora(i-1,2)=clng(day(rsdc(1)))
						Tempora(i-1,3)=clng(month(rsdc(1)))
						Tempora(i-1,4)=clng(year(rsdc(1)))-year(now())+1
						Tempora(i-1,5)=clng(day(rsdc(2)))
						Tempora(i-1,6)=clng(month(rsdc(2)))
						Tempora(i-1,7)=clng(year(rsdc(2)))-year(now())+1
						i=i+1
						if cstr(rsdc(0)) = cstr(valors(3,1)) then  
							response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(Tempora(i-2,1)) & "</option>")
						else
							response.Write("<option value=""" & rsdc(0) & """>" &  htmlen(Tempora(i-2,1)) & "</option>")
						end if
						rsdc.movenext
					loop
					rsDC.close
					set rsDC=nothing
				end if			
				%>
              </select> <%	
				if Valors(0,1)<>"" then 
					response.Write("<script>")
						for cont=0 to i-2
							response.Write("temporada[" & Tempora(cont,0) & "]=new Array ();")
							response.Write("temporada[" & Tempora(cont,0) & "][0]='" & Tempora(cont,1) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][1]='" & Tempora(cont,2) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][2]='" & Tempora(cont,3) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][3]='" & Tempora(cont,4) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][4]='" & Tempora(cont,5) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][5]='" & Tempora(cont,6) & "';")
							response.Write("temporada[" & Tempora(cont,0) & "][6]='" & Tempora(cont,7) & "';")
						next
					response.Write("</script>")
				end if
			%> </td>
            <td width="108">&nbsp;Nombre</td>
            <td width="81"><input name="txtt1" type="text" id="txtt12" onChange="document.forms.actualizar.htxtt1.value=document.forms.temporadas.txtt1.value" value="<%=Valors(4,1)%>" size="20"> 
            </td>
          </tr>
          <tr> 
            <td height="21">&nbsp;</td>
            <td>&nbsp;Fecha inicio</td>
            <td colspan="2"><select name="cbdia" id="cbdia"  onChange="document.forms.actualizar.hcbdiat.value=document.forms.temporadas.cbdia.value" <%Desactiva%>>
                <option value="sel">D&iacute;a</option>
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
                <option value="06">06</option>
                <option value="07">07</option>
                <option value="08">08</option>
                <option value="09">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
                <option value="23">23</option>
                <option value="24">24</option>
                <option value="25">25</option>
                <option value="26">26</option>
                <option value="27">27</option>
                <option value="28">28</option>
                <option value="29">29</option>
                <option value="30">30</option>
                <option value="31">31</option>
              </select> <select name="cbmes" id="cbmes"  onChange="document.forms.actualizar.hcbmest.value=document.forms.temporadas.cbmes.value" <%Desactiva%>>
                <option value="sel" selected>Mes</option>
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
                <option value="06">06</option>
                <option value="07">07</option>
                <option value="08">08</option>
                <option value="09">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
              </select> <select name="cbany" id="cbany"  onChange="document.forms.actualizar.hcbanyt.value=document.forms.temporadas.cbany.value" <%Desactiva%>>
                <option value="sel">A&ntilde;o</option>
                <%
				for i=0 to 9
					response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
				next
				%>
              </select> <div align="left"> </div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;Fecha final</td>
            <td colspan="2"><select name="cbdia1" id="select2"  onChange="document.forms.actualizar.hcbdia1t.value=document.forms.temporadas.cbdia1.value" <%Desactiva%>>
                <option value="sel">D&iacute;a</option>
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
                <option value="06">06</option>
                <option value="07">07</option>
                <option value="08">08</option>
                <option value="09">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
                <option value="23">23</option>
                <option value="24">24</option>
                <option value="25">25</option>
                <option value="26">26</option>
                <option value="27">27</option>
                <option value="28">28</option>
                <option value="29">29</option>
                <option value="30">30</option>
                <option value="31">31</option>
              </select> <select name="cbmes1" id="cbmes1" onChange="document.forms.actualizar.hcbmes1t.value=document.forms.temporadas.cbmes1.value" <%Desactiva%>>
                <option value="sel" selected>Mes</option>
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
                <option value="04">04</option>
                <option value="05">05</option>
                <option value="06">06</option>
                <option value="07">07</option>
                <option value="08">08</option>
                <option value="09">09</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
              </select> <select name="cbany1" id="cbany1" onChange="document.forms.actualizar.hcbany1t.value=document.forms.temporadas.cbany1.value"  <%Desactiva%>>
                <option value="sel">A&ntilde;o</option>
                <%
				for i=0 to 9
					response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
				next
				%>
              </select> </td>
          </tr>
          <tr> 
            <td height="10" colspan="3"><input type="button" name="Submit332" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en TEMPORADAS.\nSi desea continuar pulse Aceptar.','Temporadas','act')"> 
              <input type="button" name="Submit2" value="Borrar" onClick="return reloadpage('Va ha borrar la TEMPORADA selecionada.\nSi desea continuar pulse Aceptar.','Temporadas','borr')"  <%Desactiva%>> 
            </td>
            <td width="81"> <div align="left">&nbsp; </div></td>
          </tr>
        </form>
      </table> </td>
    <td width=375 height=114 align=center valign="top" bgcolor=#E8FFEE> 
      <form name="colectivos" method="post" action="">
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#E8FFEE">
          <tr bgcolor="#33CC99"> 
            <td height="17" colspan="4">&nbsp;<img src="img/4.gif" alt="" width="15" height="15"><img src="img/colectivos.gif" alt="habitaci&oacute;n" width="100" height="15"></td>
          </tr>
          <tr>
            <td height="17">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="134" height="17">&nbsp; </td>
            <td width="95">&nbsp;</td>
            <td width="60">&nbsp; </td>
            <td width="86"> <div align="left"></div></td>
          </tr>
          <tr> 
            <td height="17">&nbsp; </td>
            <td width="95"><select name="cbco1" id="select18" onChange="document.forms.colectivos.txtco1.value=document.forms.colectivos.cbco1.options[document.forms.colectivos.cbco1.selectedIndex].text;document.forms.actualizar.hcbco1.value=document.forms.colectivos.cbco1.value;">
                <option value="sel" selected>Seleccione</option>
                <%
				if Valors(0,1)<>"" then 
					cmdDC.CommandText = "SELECT Colectivos.CodigoColec,ColectivosNomres.Nombre FROM Colectivos INNER JOIN ColectivosNomres ON Colectivos.CodigoColec = ColectivosNomres.ColectivoIdi WHERE (Colectivos.CodigoEsta = " & Valors(0,1) & ") AND (ColectivosNomres.Idioma = N'" & Valors(2,1) & "')"
					Set rsDC = Server.CreateObject("ADODB.Recordset")
					rsDC.Open cmdDC, , 0, 2
					do while not rsdc.eof
						if cstr(rsdc(0)) = cstr(valors(11,1)) then  
							response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
						else
							response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
						end if
						rsdc.movenext
					loop
					rsDC.close
					set rsDC=nothing
				end if
				%>
              </select></td>
            <td width="60">&nbsp;Nombre</td>
            <td width="86"><input name="txtco1" type="text" id="txtco12" onChange="document.forms.actualizar.htxtco1.value=document.forms.colectivos.txtco1.value" value="<%=Valors(12,1)%>" size="20"> 
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="left">&nbsp; </div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><input type="button" name="Submit3" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en COLECTIVOS.\nSi desea continuar pulse Aceptar.','Colectivos','act')">
            </td>
          </tr>
        </table>
      </form></td>
  </tr>
  <tr> 
    <td width=375 height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
  </tr>
  <tr valign="top"> 
    <td colspan="2" align=center bgcolor=#FFFFFF> <table cellspacing=0 cellpadding=0 border=0>
<tr valign="top" bgcolor="#FFF8DD"> 
          <td height=20 colspan="2" align=center> 
<form name="habitaciones" method="post" action="">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="4" bgcolor="#FFCC99">&nbsp;<img src="img/5.gif" alt="" width="15" height="15"><img src="img/habitacion.gif" alt="habitaci&oacute;n" width="100" height="15"></td>
                  <td height="17" colspan="5" bgcolor="#FFCC99"> <div align="center"><strong><font size="1">Par&aacute;metros</font></strong></div></td>
                </tr>
                <tr> 
                  <td width="118" height="17" bgcolor="#FFF8DD">&nbsp; </td>
                  <td width="54" bgcolor="#FFF8DD">&nbsp;</td>
                  <td width="117" bgcolor="#FFF8DD">&nbsp; </td>
                  <td width="76" bgcolor="#FFF8DD">&nbsp; </td>
                  <td height="17" colspan="2" bgcolor="#FFF8DD">&nbsp;</td>
                  <td width="96" bgcolor="#FFF8DD">&nbsp; </td>
                  <td width="83" bgcolor="#FFF8DD">&nbsp; </td>
                  <td width="114" bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td height="17" bgcolor="#FFF8DD">&nbsp; <select name="cbha1" id="cbha1" onChange="document.forms.actualizar.hcbha1.value=document.forms.habitaciones.cbha1.value;habitaci();tempohabita();desconconame();document.forms.suplementos.cbsu1.selectedIndex=0;suplemen();document.forms.descuentosfechas.cbdesfe1.selectedIndex=0;desconfename();">
                      <option value="sel" selected>Seleccione</option>
                      <option value="new">Nueva</option>
                      <%
							if Valors(0,1)<>"" then 
								cmdDC.CommandText = "SELECT TipoHabita.CodigoHab,TipoHabitaNombres.Nombre FROM TipoHabita LEFT OUTER JOIN TipoHabitaNombres ON TipoHabita.CodigoHab = TipoHabitaNombres.TipoHabiIdi WHERE (TipoHabita.CodigoEsta = " & Valors(0,1) & ") AND (TipoHabitaNombres.Idioma = N'" & Valors(2,1) & "')"
								Set rsDC = Server.CreateObject("ADODB.Recordset")
								rsDC.Open cmdDC, , 2, 4
								i=1
								ii=1
								do while not rsdc.eof
									ii=ii+1
									rsDC.Movenext
								loop
								ReDim Preserve habita(ii,14)
								if ii>1 then rsDC.moveFirst()
								do while not rsdc.eof
									cmdDC.CommandText = "SELECT CodigoHab, CodigoEsta, Orden, ParaCapMax, ParaCapMin, ParaAdultMax, ParaNiMax, CupoCant, CupoDesde, CupoHasta FROM TipoHabita WHERE CodigoHab = " & rsdc(0) 
									rs.Open cmdDC, , 0, 2
									habita(i-1,0)=rsdc(0)
									if not rs.eof then 
										habita(i-1,1)=rs(1)
										habita(i-1,2)=rs(2)
										habita(i-1,3)=rs(3)
										habita(i-1,4)=rs(4)
										habita(i-1,5)=rs(5)
										habita(i-1,6)=rs(6)
										habita(i-1,7)=rs(7)
										habita(i-1,8)=clng(day(rs(8)))
										habita(i-1,9)=clng(month(rs(8)))
										habita(i-1,10)=clng(year(rs(8)))-year(now())+1
										habita(i-1,11)=clng(day(rs(9)))
										habita(i-1,12)=clng(month(rs(9)))
										habita(i-1,13)=clng(year(rs(9)))-year(now())+1
									else
										habita(i-1,1)=""
										habita(i-1,2)=""
										habita(i-1,3)=""
										habita(i-1,4)=""
										habita(i-1,5)=""
										habita(i-1,6)=""
										habita(i-1,7)=""
										habita(i-1,8)=""
										habita(i-1,9)=""
										habita(i-1,10)=""
										habita(i-1,11)=""
										habita(i-1,12)=""
										habita(i-1,13)=""
									end if
									rs.Close
									i=i+1
									if cstr(rsdc(0)) = cstr(valors(13,1)) then  
										response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
									else
										response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
									end if
									rsdc.movenext
								loop
								rsDC.close
								set rsDC=nothing
							end if
							%>
                    </select> <%	
					if Valors(0,1)<>"" then 
						response.Write("<script>")
							for cont=0 to i-2
								response.Write("habita[" & habita(cont,0) & "]=new Array ();")
								response.Write("habita[" & habita(cont,0) & "][0]='" & habita(cont,1) & "';")
								response.Write("habita[" & habita(cont,0) & "][1]='" & habita(cont,2) & "';")
								response.Write("habita[" & habita(cont,0) & "][2]='" & habita(cont,3) & "';")
								response.Write("habita[" & habita(cont,0) & "][3]='" & habita(cont,4) & "';")
								response.Write("habita[" & habita(cont,0) & "][4]='" & habita(cont,5) & "';")
								response.Write("habita[" & habita(cont,0) & "][5]='" & habita(cont,6) & "';")
								response.Write("habita[" & habita(cont,0) & "][6]='" & habita(cont,7) & "';")
								response.Write("habita[" & habita(cont,0) & "][7]='" & habita(cont,8) & "';")
								response.Write("habita[" & habita(cont,0) & "][8]='" & habita(cont,9) & "';")
								response.Write("habita[" & habita(cont,0) & "][9]='" & habita(cont,10) & "';")
								response.Write("habita[" & habita(cont,0) & "][10]='" & habita(cont,11) & "';")
								response.Write("habita[" & habita(cont,0) & "][11]='" & habita(cont,12) & "';")
								response.Write("habita[" & habita(cont,0) & "][12]='" & habita(cont,13) & "';")
							next
						response.Write("</script>")
					end if
				%> </td>
                  <td width="54" bgcolor="#FFF8DD">&nbsp;Nombre</td>
                  <td width="117" bgcolor="#FFF8DD"><input name="txtha1" type="text" id="txtha1" onChange="document.forms.actualizar.htxtha1.value=document.forms.habitaciones.txtha1.value" value="<%=Valors(14,1)%>" size="20"></td>
                  <td width="76" bgcolor="#FFF8DD">&nbsp; </td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp;Capacidad m&aacute;x</td>
                  <td bgcolor="#FFF8DD">&nbsp; <select name="cbha3" id="cbha3" onChange="document.forms.actualizar.hcbha3.value=document.forms.habitaciones.cbha3.value" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select></td>
                  <td bgcolor="#FFF8DD">&nbsp;Capacidad m&iacute;n.</td>
                  <td bgcolor="#FFF8DD"><select name="cbha4" id="cbha4" onChange="document.forms.actualizar.hcbha4.value=document.forms.habitaciones.cbha4.value" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select> </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;Orden</td>
                  <td bgcolor="#FFF8DD"><select name="cbha2" id="cbha2" onChange="document.forms.actualizar.hcbha2.value=document.forms.habitaciones.cbha2.value" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                    </select></td>
                  <td bgcolor="#FFF8DD"><div align="left">&nbsp; </div></td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp;Adultos m&aacute;x.</td>
                  <td bgcolor="#FFF8DD">&nbsp; <select name="cbha5" id="cbha5" onChange="document.forms.actualizar.hcbha5.value=document.forms.habitaciones.cbha5.value" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select></td>
                  <td bgcolor="#FFF8DD">&nbsp;&nbsp;Ni&ntilde;os m&aacute;x.</td>
                  <td bgcolor="#FFF8DD"><select name="cbha6" id="cbha6" onChange="document.forms.actualizar.hcbha6.value=document.forms.habitaciones.cbha6.value" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select></td>
                </tr>
                <tr> 
                  <td height="17" colspan="4"> <div align="center"></div></td>
                  <td width="27" bgcolor="#FFF8DD">&nbsp;</td>
                  <td width="65" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="4" bgcolor="#FFCC99"> <div align="center"><strong>Cupo</strong> 
                    </div></td>
                  <td height="18" colspan="5" bgcolor="#FFCC99"> <div align="center"></div></td>
                </tr>
                <tr> 
                  <td height="17" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp; </td>
                  <td height="17"> <div align="center"></div></td>
                  <td height="17" colspan="2">&nbsp;</td>
                  <td height="17">&nbsp;</td>
                  <td height="17">&nbsp;</td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;Cantidad &nbsp; <input name="txtha2" type="text" id="txtha2" onChange="document.forms.actualizar.htxtha2.value=document.forms.habitaciones.txtha2.value" value="<%=Valors(20,1)%>" size="5" <%Desactiva%>></td>
                  <td bgcolor="#FFF8DD">&nbsp;Desde</td>
                  <td colspan="2" bgcolor="#FFF8DD"><select name="cbdia" id="cbdia"  onChange="document.forms.actualizar.hcbdiaha.value=document.forms.habitaciones.cbdia.value" <%Desactiva%>>
                      <option value="sel">D&iacute;a</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                    </select> <select name="cbmes" id="cbmes" onChange="document.forms.actualizar.hcbmesha.value=document.forms.habitaciones.cbmes.value" <%Desactiva%>>
                      <option value="sel" selected>Mes</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select> <select name="cbany" id="cbany"  onChange="document.forms.actualizar.hcbanyha.value=document.forms.habitaciones.cbany.value" <%Desactiva%>>
                      <option value="sel">A&ntilde;o</option>
                      <%
						for i=0 to 9
							response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
						next
						%>
                    </select> </td>
                  <td rowspan="3" bgcolor="#FFF8DD">&nbsp;</td>
                  <td colspan="2" bgcolor="#FFF8DD">	
				    <font size="1" class="titulo">
					<div align="left" STYLE="cursor:pointer;" onClick="obrirfin();">
					Parón de Ventas
					</div></font>
				</td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">Hasta</td>
                  <td colspan="2" bgcolor="#FFF8DD"><select name="cbdia1" id="select5" onChange="document.forms.actualizar.hcbdia1ha.value=document.forms.habitaciones.cbdia1.value" <%Desactiva%>>
                      <option value="sel">D&iacute;a</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                    </select>
                    <select name="cbmes1" id="select6" onChange="document.forms.actualizar.hcbmes1ha.value=document.forms.habitaciones.cbmes1.value" <%Desactiva%>>
                      <option value="sel" selected>Mes</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select>
                    <select name="cbany1" id="select7" onChange="document.forms.actualizar.hcbany1ha.value=document.forms.habitaciones.cbany1.value" <%Desactiva%>>
                      <option value="sel">A&ntilde;o</option>
                      <%
						for i=0 to 9
							response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
						next
						%>
                    </select></td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp; </td>
                  <td colspan="2" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD"><input type="button" name="Submit3222" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en HABITACIONES.\nSi desea continuar pulse Aceptar.','TipoHabita','act')">
                    <input type="button" name="Submit2223" value="Borrar" onClick="return reloadpage('Va ha borrar el TIPO DE HABITACIÖN selecionado.\nSi desea continuar pulse Aceptar.','TipoHabita','borr')" <%Desactiva%>> 
                  </td>
                </tr>
              </table>
            </form></td>
        </tr>
        <tr> 
          <td height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
        </tr>
        <tr> 
          <td width=750 height=98 align=center valign="top" bgcolor=#FFF8DD colspan='2'> 
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td width=375 height=98 align=center valign="top" bgcolor='#FFF8DD'> 
            <form name="habitap" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="4" bgcolor="#FFCC99"> <div align="center"><strong>Precios</strong></div></td>
                </tr>
                <tr bgcolor="#FFF8DD">
				<td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td>Temporada</td>
                  <td><select name="cbtempha" id="select17"  onChange="document.forms.actualizar.hcbtempha.value=document.forms.habitap.cbtempha.value;tempohabita();" <%Desactiva%>>
                      <%
				i=0
				if Valors(0,1)<>"" then 
					cmdDC.CommandText = "SELECT CodigoTemp, FInicio, FFinal FROM Temporadas WHERE Temporadas.CodigoEsta = " & Valors(0,1)
					Set rsDC = Server.CreateObject("ADODB.Recordset")
					Set rs = Server.CreateObject("ADODB.Recordset")
					rsDC.Open cmdDC, , 2, 2
					do while not rsdc.eof
						cmdDC.CommandText = "SELECT Nombre FROM TemporadasNomres WHERE (TempIdi = " & rsdc(0) & ") AND (Idioma = N'" & Valors(2,1) & "')"
						rs.Open cmdDC, , 0, 2
						if cstr(rsdc(0)) = cstr(valors(49,1)) then  
							response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rs(0)) & "</option>")
						else
							response.Write("<option value=""" & rsdc(0) & """>" &  htmlen(rs(0)) & "</option>")
						end if
						i=1
						rs.Close
						rsdc.movenext
					loop
					rsDC.close
					set rsDC=nothing
				end if
				if i=0 then response.Write("<option>" & htmlen("Vacio") & "</option>")
				'Cream l'script especial per habitacions/temporades
				 TemporadaHabitacio			
				%>
                    </select></td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td>Precio base</td>
                  <td><input name="txtha3" type="text" id="txtha3" onChange="document.forms.actualizar.htxtha3.value=document.forms.habitap.txtha3.value" value="<%=Valors(21,1)%>" size="5" <%Desactiva%>> 
                    &nbsp;&euro;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td width="34%">Como determinar precios</td>
                  <td width="30%" COLSPAN='2'><input type="radio" name="rbha1"  value="0"  onClick="radiobha()" <%Desactiva%>>
                    x pax 
                    <input type="radio" name="rbha1"  value="-1" onClick="radiobha()" <%Desactiva%>>
                    x hab </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td colspan='4' align='center'><input name="descoact" type="button" id="descoact" onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en PRECIOS.\nSi desea continuar pulse Aceptar.','TipoHabitaPrecios','act')" value="Actualizar " <%Desactiva%>> 
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input name="descobrr" type="button" id="descobrr" onClick="return reloadpage('Va ha borrar el PRECIO selecionado.\nSi desea continuar pulse Aceptar.','TipoHabitaPrecios','borr')" value="Borrar" <%Desactiva%>> 
                  </td>
                </tr>
              </table>
            </form>
		</td>
        <td width=375 height=98 align=center valign="top" bgcolor=#FFF8DD> 
            <form name="suplementos" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="4" bgcolor="#FFCC99"> <div align="center"><strong>Suplementos</strong></div></td>
                </tr>
                <tr bgcolor="#FFF8DD">
                  <td width='20%'>&nbsp;</td>
				  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td>Suplemento</td>
                  <td><select name="cbsu1" id="select16" onChange="document.forms.actualizar.hcbsu1.value=document.forms.suplementos.cbsu1.value;suplemen();" >
                      <option value="Sel">seleccione</option>
					  <%TemporadaSuple%>
                    </select>
                  </td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td width="22%">Nombre</td>
                  <td width="31%"><input name="txtsu1" type="text"  onChange="document.forms.actualizar.htxtsu1.value=document.forms.suplementos.txtsu1.value" size="20"></td>
                  <td>&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
				<td>&nbsp;</td>
                  <td>Precio</td>
                  <td bgcolor="#FFF8DD"><input name="txtsu2" type="text"  onChange="document.forms.actualizar.htxtsu2.value=document.forms.suplementos.txtsu2.value" size="5" <%Desactiva%>> 
                    &nbsp;&euro;</td>
                  <td>&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td height="17" colspan='4' align='center'><input type="button" name="Submit33" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en SUPLEMENTOS.\nSi desea continuar pulse Aceptar.','Suplementos','act')"> 
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" name="Submit2222" value="Borrar"  onClick="return reloadpage('Va ha borrar el SUPLEMENTO selecionado.\nSi desea continuar pulse Aceptar.','Suplementos','borr')" <%Desactiva%>></td>
                </tr>
              </table>
            </form></td>
        </tr>
		</table>
		</td>
        <tr> 
          <td height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
        </tr>
        <tr> 
          <td width=375 height=20 align=center valign="top" bgcolor=#FFF8DD>
		  <form name="descuentoscolec" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="3" bgcolor="#FFCC99"> <div align="center"><strong>Descuentos 
                      por Colectivos</strong></div></td>
                </tr>
                <tr>
                  <td height="17" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="32%" height="17" bgcolor="#FFF8DD">&nbsp;</td>
                  <td width="25%" bgcolor="#FFF8DD">Temporada</td>
                  <td width="38%" bgcolor="#FFF8DD"><select name="cbtempdesco" id="select13"  onChange="document.forms.actualizar.hcbtempdesco.value=document.forms.descuentoscolec.cbtempdesco.value;desconconame();" <%Desactiva%>>
                      <%
				i=0
				if Valors(0,1)<>"" then 
					cmdDC.CommandText = "SELECT CodigoTemp, FInicio, FFinal FROM Temporadas WHERE Temporadas.CodigoEsta = " & Valors(0,1)
					Set rsDC = Server.CreateObject("ADODB.Recordset")
					Set rs = Server.CreateObject("ADODB.Recordset")
					rsDC.Open cmdDC, , 2, 2
					do while not rsdc.eof
						cmdDC.CommandText = "SELECT Nombre FROM TemporadasNomres WHERE (TempIdi = " & rsdc(0) & ") AND (Idioma = N'" & Valors(2,1) & "')"
						rs.Open cmdDC, , 0, 2
						if cstr(rsdc(0)) = cstr(valors(50,1)) then  
							response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rs(0)) & "</option>")
						else
							response.Write("<option value=""" & rsdc(0) & """>" &  htmlen(rs(0)) & "</option>")
						end if
						i=1
						rs.Close
						rsdc.movenext
					loop
					rsDC.close
					set rsDC=nothing
				end if
				if i=0 then response.Write("<option>" & htmlen("Vacio") & "</option>")
				'Cream l'script especial per habitacions/temporades
				 'TemporadaHabitacio			
				%>
                    </select> </td>
                  <td width="5%" bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD"><input type="hidden" name="cbdesco1"> 
                  </td>
                  <td bgcolor="#FFF8DD">Colectivo</td>
                  <td bgcolor="#FFF8DD"> <select name="cbdesco2" id="cbdesco2" onChange="document.forms.actualizar.hcbdesco2.value=document.forms.descuentoscolec.cbdesco2.value;desconconame();" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <%
						if Valors(0,1)<>"" then 
							cmdDC.CommandText = "SELECT Colectivos.CodigoColec,ColectivosNomres.Nombre FROM Colectivos INNER JOIN ColectivosNomres ON Colectivos.CodigoColec = ColectivosNomres.ColectivoIdi WHERE (Colectivos.CodigoEsta = " & Valors(0,1) & ") AND (ColectivosNomres.Idioma = N'" & Valors(2,1) & "')"
							Set rsDC = Server.CreateObject("ADODB.Recordset")
							rsDC.Open cmdDC, , 0, 2
							do while not rsdc.eof
								if cstr(rsdc(0)) = cstr(valors(30,1)) then  
									response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
								else
									response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
								end if
								rsdc.movenext
							loop
							rsDC.close
							set rsDC=nothing
						end if
						'Creació del array 
						TemporadaDesColectivo
						%>
                    </select>
                  </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">Descuento</td>
                  <td bgcolor="#FFF8DD"><input name="txtdesco1" type="text" id="txtdesco1" onChange="document.forms.actualizar.htxtdesco1.value=document.forms.descuentoscolec.txtdesco1.value" value="<%=Valors(31,1)%>" size="5" <%Desactiva%>>
                    % </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
				<tr>
				  <td ><input name="bdescoact" type="button" id="bdescoact" onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en DESCUENTOS POR COLECTIVOS.\nSi desea continuar pulse Aceptar.','Colectivosdes','act')" value="Actualizar " <%Desactiva%>> 
                    <input type="button" name="bdescobrr" value="Borrar" onClick="return reloadpage('Va ha borrar el COLECTIVO selecionado.\nSi desea continuar pulse Aceptar.','Colectivosdes','borr')" <%Desactiva%>></td>
					
                  <td>&nbsp; </td>
                  <td>&nbsp; </td>
				</tr>
              </table>
            </form></td>
          <td width=372 height=20 bgcolor=#FFF8DD valign="top">
		  <form name="descuentosfechas" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="4" bgcolor="#FFCC99"> <div align="center">Descuentos 
                      por Fechas</div></td>
                </tr>
                <tr bgcolor="#FFF8DD">
                  <td height="17">&nbsp;</td>
                  <td colspan="2">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td width="23%" height="17">&nbsp;</td>
				  <td >&nbsp;</td>
                  <td><select name="cbdesfe1" id="select4" onChange="document.forms.actualizar.hcbdesfe1.value=document.forms.descuentosfechas.cbdesfe1.value;desconfename();" >
				      <option value="sel" selected>Seleccione</option>
                      <%
'                    If valors(0, 1) <> "" Then
'                        cmdDC.CommandText = "SELECT CodigoFechas, Desde, Hasta, Value FROM DescuentosFechas WHERE DescuentosFechas.CodigoEsta = " & valors(0, 1)
'                        Set rsDC = Server.CreateObject("ADODB.Recordset")
'                        rsDC.Open cmdDC, , 0, 2
'                        Do While Not rsDC.EOF
'                            If CStr(rsDC(0)) = CStr(valors(42, 1)) Then
'                                response.Write ("<option value=""" & rsDC(0) & """ SELECTED>" & htmlen(rsDC(1) & " - " & rsDC(2)) & "</option>")
'                            Else
'                                response.Write ("<option value=""" & rsDC(0) & """>" & htmlen(rsDC(1) & " - " & rsDC(2)) & "</option>")
'                            End If
'                            rsDC.MoveNext
'                        Loop
'                        rsDC.Close
'                        Set rsDC = Nothing
'                    End If
					'Creació de l'Array JavaScript
					HabitaFechas			
					%>
                    </select>
                  </td>
                  <td width="6%">&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td>&nbsp; </td>
                  <td width="13%">Desde</td>
                  <td width="55%"> <select name="cbdia" id="cbdia" onChange="document.forms.actualizar.hcbdiadesfe.value=document.forms.descuentosfechas.cbdia.value" <%Desactiva%>>
                      <option value="sel">D&iacute;a</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                    </select> <select name="cbmes" id="cbmes" onChange="document.forms.actualizar.hcbmesdesfe.value=document.forms.descuentosfechas.cbmes.value" <%Desactiva%>>
                      <option value="sel" selected>Mes</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select> <select name="cbany" id="cbany" onChange="document.forms.actualizar.hcbanydesfe.value=document.forms.descuentosfechas.cbany.value" <%Desactiva%>>
                      <option value="sel">A&ntilde;o</option>
                      <%
						for i=0 to 9
							response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
						next
						%>
                    </select> </td>
                  <td>&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td>Hasta</td>
                  <td><select name="cbdia1" id="cbdia1" onChange="document.forms.actualizar.hcbdia1desfe.value=document.forms.descuentosfechas.cbdia1.value" <%Desactiva%>>
                      <option value="sel">D&iacute;a</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                    </select> <select name="cbmes1" id="select3" onChange="document.forms.actualizar.hcbmes1desfe.value=document.forms.descuentosfechas.cbmes1.value" <%Desactiva%>>
                      <option value="sel" selected>Mes</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select> <select name="cbany1" id="cbany1" onChange="document.forms.actualizar.hcbany1desfe.value=document.forms.descuentosfechas.cbany1.value" <%Desactiva%>>
                      <option value="sel">A&ntilde;o</option>
                      <%
						for i=0 to 9
							response.write ("<option value=""" & year(now())+i & """>" & year(now())+i & "</option>")
						next
						%>
                    </select></td>
                  <td>&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td>Valor</td>
                  <td><input name="txtdesfe1" type="text" id="txtdesfe1" onChange="document.forms.actualizar.htxtdesfe1.value=document.forms.descuentosfechas.txtdesfe1.value" value="<%=Valors(41,1)%>" size="5" <%Desactiva%>>
                    % </td>
                  <td>&nbsp; </td>
                </tr>
                <tr bgcolor="#FFF8DD"> 
                  <td height="17" colspan="4" align='center'><input type="button" name="Submit34" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en DESCUENTOS POR FECHAS.\nSi desea continuar pulse Aceptar.','DescuentosFechas','act')" <%Desactiva%>> 
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" name="Submit22222" value="Borrar" onClick="return reloadpage('Va ha borrar el DESCUENTO POR FECHA selecionado.\nSi desea continuar pulse Aceptar.','DescuentosFechas','borr')" <%Desactiva%>>
                    </td>
                </tr>
              </table>
            </form>
		  </td>
        </tr>
		<tr> 
		  <td height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
	  </tr>
      <tr> 
          <td width=375 height=20 align=center valign="top" bgcolor=#FFF8DD>
		  <form name="descuentossuple" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="17" colspan="4" bgcolor="#FFCC99"> <div align="center"><strong>Descuentos 
                      por Suplementos</strong></div></td>
                </tr>
                <tr>
                  <td height="17" bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="32%" height="17" bgcolor="#FFF8DD">&nbsp;</td>
                  <td width="25%" bgcolor="#FFF8DD">Suplemento</td>
                  <td width="38%" bgcolor="#FFF8DD"><select name="cbsuple" id="cbsuple" onChange="descosuplename();">
                      <option value="sel" selected>Seleccione</option>
                      <% DescuentosSuple %>
                    </select>
                  </td>
                  <td width="5%" bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">Colectivo</td>
                  <td bgcolor="#FFF8DD"><select name="cbdessucolec" id="cbdessucolec" onChange="descosuplename();" <%Desactiva%>>
                      <option value="sel" selected>Seleccione</option>
                      <%
						if Valors(0,1)<>"" then 
							cmdDC.CommandText = "SELECT Colectivos.CodigoColec,ColectivosNomres.Nombre FROM Colectivos INNER JOIN ColectivosNomres ON Colectivos.CodigoColec = ColectivosNomres.ColectivoIdi WHERE (Colectivos.CodigoEsta = " & Valors(0,1) & ") AND (ColectivosNomres.Idioma = N'" & Valors(2,1) & "')"
							Set rsDC = Server.CreateObject("ADODB.Recordset")
							rsDC.Open cmdDC, , 0, 2
							do while not rsdc.eof
								if cstr(rsdc(0)) = cstr(valors(30,1)) then  
									response.Write("<option value=""" & rsdc(0) & """ SELECTED>" & htmlen(rsdc(1)) & "</option>")
								else
									response.Write("<option value=""" & rsdc(0) & """>" & htmlen(rsdc(1)) & "</option>")
								end if
								rsdc.movenext
							loop
							rsDC.close
							set rsDC=nothing
						end if
						%>
                    </select> </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">Descuento</td>
                  <td bgcolor="#FFF8DD"><input name="txtdesconte" type="text" id="txtdesconte"  value="<%=Valors(32,1)%>" size="5" <%Desactiva%>>
                    % </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp;</td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                  <td bgcolor="#FFF8DD">&nbsp; </td>
                </tr>
				<tr>
				  <td ><input type="button" name="Submit35" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en DESCUENTOS POR COLECTIVOS.\nSi desea continuar pulse Aceptar.','dessuple','act')" <%Desactiva%>>
                    <input type="button" name="Submit22223" value="Borrar" onClick="return reloadpage('Va ha borrar el COLECTIVO selecionado.\nSi desea continuar pulse Aceptar.','dessuple','borr')" <%Desactiva%>></td>
					
                  <td>&nbsp; </td>
                  <td>&nbsp; </td>
				</tr>
              </table>
            </form></td>
          <td width=375 height=98 align=center valign="top" bgcolor=#FFF8DD> 
			</td>
        </tr>
		<tr><td colspan='2'  bgcolor="#FFF8DD">
<form name="servicios" method="post" action="">
                <table width="500" align='center' border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                    <td height="17" colspan="4" bgcolor="#FFCC99"> <div align="center"><strong>Servicios</strong></div></td>
                  </tr>
                  <tr bgcolor="#FFF8DD"> 
				  <td width='20%'>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFF8DD"> 
				  <td>&nbsp;</td>
                    <td>Servicio</td>
                    <td><select name="idservi" onChange="document.forms.actualizar.idservicio.value=document.forms.servicios.idservi.value;elservicio();DatosIFrame('<%=Valors(0,1)%>',this.value,'<%=Valors(2,1)%>')">
                        <option value="Sel">Seleccione</option>
						<option value="new">Nuevo</option>
                        <%PonServicios%>
                      </select> </td>
                    <td>&nbsp; </td>
                  </tr>
                  <tr bgcolor="#FFF8DD"> 
				  <td width='20%'>&nbsp;</td>
                    <td width="13%">Nombre</td>
                    <td width="49%"> 
                      <input name="txtservicio" type="text"  onChange="document.forms.actualizar.nombreservicio.value=document.forms.servicios.txtservicio.value" size="50" maxlength='80'></td>
                    <td>&nbsp; </td>
                  </tr>
                  <tr bgcolor="#FFF8DD"> 
                    <td height="17" colspan='4' align='center'> 
                      <input type="button" name="Submit333" value="Actualizar " onClick="return reloadpage('Esta acción recargará la página perdiendo los datos no guardados a excepción de los introducidos en SERVICIOS.\nSi desea continuar pulse Aceptar.','Servicios','act')">
					   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <input type="button" name="Submit22224" value="Borrar"  onClick="return reloadpage('Va ha borrar el SERVICIO selecionado.\nSi desea continuar pulse Aceptar.','Servicios','borr')" <%Desactiva%>> 
                    </td>
                  </tr>
                </table>
            </form>
			<iframe id="servitempos" name="servitempos" height='300' width="600" align='center' frameborder="0" hspace="0" vspace="0" src="ListaServivios.asp?codesta=<%=Valors(0,1)%>&idservi=<%=Valors(57,1)%>&idi=<%=Valors(2,1)%>">
			</iframe>
		</td></tr>
        <tr> 
          <td height=1 bgcolor=#CC0000 colspan=2><img src="img/transparent.gif" width=1 height=1></td>
        </tr>
        <tr> 
          <td colspan="2" align=center bgcolor=#FFFFFF>
<table width="100%" bgcolor="#003bb3" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2"> <div align="center"></div></td>
             </tr>
			<%if session.Contents("TipusUser")="ADMIN" then %>
					<tr> <td> <div align="left">&nbsp;&nbsp;&nbsp;<a href="Users.asp"><b>Gestión de usuarios</b></font></a></div></td><td><div align="right"><a href="gestio.asp"><strong>Gestión 
                      de hoteles</font></strong></a>&nbsp;&nbsp;&nbsp;</div></td></tr>
            <%end if%>
			</table></td>
        </tr>
      </table></td>
  </tr>
  
</table>
<%
	if request.Form("hcbe1")="sel" then valors(0,1)="sel"
	if request.Form("hcbe1")="new" then valors(0,1)="new"
%>
<form action="gestio.asp" method="post" name="actualizar">
  <input name="hcbe1" type="hidden" value="<%=Valors(0,1)%>">
  <input name="htxte1" type="hidden" value="<%=Valors(1,1)%>">
  <input type="hidden" name="hcbi1" value="<%=Valors(2,1)%>">
  <input type="hidden" name="hcbt1" value="<%=Valors(3,1)%>">
  <input type="hidden" name="htxtt1" value="<%=Valors(4,1)%>">
  <input type="hidden" name="hcbdiat" value="<%=Valors(5,1)%>">
  <input type="hidden" name="hcbmest" value="<%=Valors(6,1)%>">
  <input type="hidden" name="hcbanyt" value="<%=Valors(7,1)%>">
  <input type="hidden" name="hcbdia1t" value="<%=Valors(8,1)%>">
  <input type="hidden" name="hcbmes1t" value="<%=Valors(9,1)%>">  
  <input type="hidden" name="hcbany1t" value="<%=Valors(10,1)%>">
  <input type="hidden" name="hcbco1" value="<%=Valors(11,1)%>">
  <input type="hidden" name="htxtco1" value="<%=Valors(12,1)%>">
  <input type="hidden" name="hcbha1" value="<%=Valors(13,1)%>">
  <input type="hidden" name="htxtha1" value="<%=Valors(14,1)%>">
  <input type="hidden" name="hcbha2" value="<%=Valors(15,1)%>">
  <input type="hidden" name="hcbha3" value="<%=Valors(16,1)%>">
  <input type="hidden" name="hcbha4" value="<%=Valors(17,1)%>">
  <input type="hidden" name="hcbha5" value="<%=Valors(18,1)%>">
  <input type="hidden" name="hcbha6" value="<%=Valors(19,1)%>">
  <input type="hidden" name="htxtha2" value="<%=Valors(20,1)%>">
  <input type="hidden" name="htxtha3" value="<%=Valors(21,1)%>">
  <input type="hidden" name="hrbha1" value="<%=Valors(22,1)%>">
  <input type="hidden" name="hcbdiaha" value="<%=Valors(23,1)%>">
  <input type="hidden" name="hcbmesha" value="<%=Valors(24,1)%>">
  <input type="hidden" name="hcbanyha" value="<%=Valors(25,1)%>">
  <input type="hidden" name="hcbdia1ha" value="<%=Valors(26,1)%>">
  <input type="hidden" name="hcbmes1ha" value="<%=Valors(27,1)%>">
  <input type="hidden" name="hcbany1ha" value="<%=Valors(28,1)%>">
  <input type="hidden" name="hcbdesco1" value="<%=Valors(29,1)%>">
  <input type="hidden" name="hcbdesco2" value="<%=Valors(30,1)%>">
  <input type="hidden" name="htxtdesco1" value="<%=Valors(31,1)%>">
  <input type="hidden" name="htxtdesconte" value="<%=Valors(32,1)%>">
  <input type="hidden" name="hrbdesco1" value="<%=Valors(33,1)%>">
  <input type="hidden" name="hrbdesco2" value="<%=Valors(34,1)%>">
  <input type="hidden" name="hcbdiadesfe" value="<%=Valors(35,1)%>">
  <input type="hidden" name="hcbmesdesfe" value="<%=Valors(36,1)%>">
  <input type="hidden" name="hcbanydesfe" value="<%=Valors(37,1)%>">
  <input type="hidden" name="hcbdia1desfe" value="<%=Valors(38,1)%>">
  <input type="hidden" name="hcbmes1desfe" value="<%=Valors(39,1)%>">
  <input type="hidden" name="hcbany1desfe" value="<%=Valors(40,1)%>">
  <input type="hidden" name="htxtdesfe1" value="<%=Valors(41,1)%>">
  <input type="hidden" name="hcbdesfe1" value="<%=Valors(42,1)%>">
  <input type="hidden" name="hrbdesfe1" value="<%=Valors(43,1)%>">
  <input type="hidden" name="hcbsu1" value="<%=Valors(44,1)%>">
  <input type="hidden" name="htxtsu1" value="<%=Valors(45,1)%>">
  <input type="hidden" name="htxtsu2" value="<%=Valors(46,1)%>">
  <input type="hidden" name="hqui" value="<%=Valors(47,1)%>">
  <input type="hidden" name="hque" value="<%=Valors(48,1)%>">
  <input type="hidden" name="hcbtempha" value="<%=Valors(49,1)%>">
  <input type="hidden" name="hcbtempdesco" value="<%=Valors(50,1)%>">
  <input name="hcbsuple" type="hidden" id="hcbsuple" value="<%=Valors(51,1)%>">
  <input type="hidden" name="hcbdessucolec" value="<%=Valors(52,1)%>">
  <input name="hordehotels" type="hidden" id="hordehotels" value="<%=Valors(53,1)%>">
  <input name="hprepago" type="hidden" id="hprepago" value="<%=Valors(54,1)%>">
  <input name="hpers3" type="hidden" id="hpers3" value="<%=Valors(55,1)%>">
  <input name="hmindias" type="hidden" id="hmindias" value="<%=Valors(56,1)%>">
  <input name="idservicio" type="hidden" value="<%=Valors(57,1)%>">
  <input name="nombreservicio" type="hidden" value="<%=Valors(58,1)%>">
  <input name="idserviciotempo" type="hidden" value="<%=Valors(59,1)%>">
  <input name="precioservi" type="hidden" value="<%=Valors(60,1)%>">
  <input name="serviporpersona" type="hidden" value="<%=Valors(61,1)%>">    
  
</form>
</center>
</body>
<script>
	radiobha();
	tempname();
	colecname();
	desconconame();
	desconfename();
	suplemen();
	habitaci();
	tempohabita();
	descosuplename();
	//Añadido Vicente
	elservicio();
	DatosIFrame('<%=Valors(0,1)%>','<%=Valors(57,1)%>','<%=Valors(2,1)%>');
	
	document.establecimiento.txte1.value=document.establecimiento.cbe1.options[document.establecimiento.cbe1.selectedIndex].text
</script>

</html>
