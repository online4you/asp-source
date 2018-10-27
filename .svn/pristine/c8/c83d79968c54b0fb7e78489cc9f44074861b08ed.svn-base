<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%Option Explicit%>
<%
'If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()
%>
<!-- #Include File="Connections/Functions.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Hotel-Hoteles.com</TITLE>
<%
Dim col1,col2,fini,ffin,DllDisp,ii,i,cont,rs,rsh,j,fechaini,fecha,calend,calenm,calena,sql,datamin,cest,chab,data,orde,pos,amefecha,color,Errdes,Disp(),dies,Disp2(),dies2
Dim pv,SQL3,pv2,SQL4,paronSI,paronNO,fechaSI,fechaNO,diaSI,mesSI,anoSI,diaNO,mesNO,anoNO,longitud
if request.Form("horde")="" then orde=0
if request.Form("hpos")="" then pos=0
if request.Form("horde")<>"" then orde=request.Form("horde")
if request.Form("hpos")<>"" then pos=request.Form("hpos")

cest=request.QueryString("hcbestable") 
chab=request.QueryString("hcbhab")
if request.Form("fIni1")="" then  fini=request.QueryString("fini")
if request.Form("fIni2")="" then   ffin=request.QueryString("ffin")
if request.Form("fIni1")<>"" then  fini=request.Form("fIni1")
if request.Form("fIni2")<>"" then   ffin=request.Form("fIni2")
sql="SELECT CAST(" & UserSQL & ".GetMax(CAST(TipoHabita.CupoDesde AS datetime), CAST(Temporadas.FInicio AS datetime)) AS datetime) AS MaxIni " & _
	"FROM " & precrs & "TipoHabita TipoHabita INNER JOIN " & precrs & "TipoHabitaPrecios TipoHabitaPrecios ON TipoHabita.CodigoHab = TipoHabitaPrecios.TipoHabita INNER JOIN " & _
	"Temporadas ON TipoHabitaPrecios.Temporada = Temporadas.CodigoTemp " & _
	"WHERE (TipoHabita.CodigoHab = " & chab & ") " & _ 
	"AND (TipoHabita.CodigoEsta = " & cest & ") " & _ 
	"AND (Temporadas.FFinal >= { fn NOW() }) " & _ 
	"AND (TipoHabita.CupoHasta >= { fn NOW() }) " & _ 
	"AND (CAST(" & UserSQL & ".GetMax(CAST(TipoHabita.CupoDesde AS datetime), CAST(Temporadas.FInicio AS datetime)) AS datetime) >= CAST({ fn NOW() } AS Datetime)) LIMIT 1"

cmdDC.CommandText = sql
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open cmdDC, , 2, 2
if not rs.eof then datamin=rs.Fields(0)
rs.close
Set rs=nothing

if cdate(datamin)> cdate(now()) then data=datamin
if cdate(datamin)<= cdate(now()) then data=Now()
if month(cdate(data)) mod 2 =0 then data=dateadd("m",-1,cdate(data))

fechaini=cdate("01/" & month(cdate(data)) & "/" & year(cdate(data)))
fecha=dateadd("m",orde,cdate(fechaini))
data=dateadd("m",orde,cdate(data))
calend=day(fecha)
calenm=month(fecha)
calena=year(fecha)
set DllDisp=Server.CreateObject(OBJ1)
DllDisp.Getprefitxe=UserSQL
Errdes =""
Errdes = DllDisp.getdispmes(cstr(year(data) & "-" & month(data) & "-" & day(data) & " 00:00:00"),cstr(chab),cstr(cest), Disp, dies)
data=dateadd("m",1,data)
Errdes = DllDisp.getdispmes(cstr(year(data) & "-" & month(data) & "-" & day(data) & " 00:00:00"),cstr(chab),cstr(cest), Disp2, dies2)
data=dateadd("m",-1,data)
set DllDisp = nothing
if month(data)=month(fini) then col1=day(fini)-1
if month(data)=month(ffin) then col2=day(ffin)-1
if month(dateadd("m",1,data))=month(fini) then col1=dies + day(fini)-1
if month(dateadd("m",1,data))=month(ffin) then col2=dies + day(ffin)-1
if col2="" and col1<>"" then col2=dies + dies2 -1
if col1="" then col1=0
if col2="" then col2=0

'Comprobar si actualizamos paron de ventas
if request.form("actualiza")="1" then 'Actualiza
	dim fechai,fechaf,fechaparon,paron,cs,BDatos,RsParon
	Set Bdatos= Server.CreateObject("ADODB.Connection")
	set rsparon=server.createobject("ADODB.Recordset")
	rsparon.CursorLocation = adUseServer
	rsparon.CursorType=adOpenForwardOnly
	rsparon.LockType=adLockReadOnly	
	Bdatos.ConnectionTimeout = 15
	Bdatos.CommandTimeout = 30
	Bdatos.Open conecta

	if request.form("marca")="1" then 'añade fechas del paron de ventas
		fechai=cdate(request.form("fini1"))
		fechaf=cdate(request.form("fini2"))
		for fechaparon=fechai to fechaf
			paron=year(fechaparon) & "-" & month(fechaparon) & "-" & day(fechaparon) & " 00:00:00"
			'Comprobar que no existe, para evitar el fallo de PRIMARY_KEY
			cs= "SELECT * FROM " & precrs & "paronventas WHERE CodigoHab= '"&chab&"' AND CodigoEsta = '"&cest&"' AND Dia = CONVERT(DATETIME, '" & paron & "', 102)"
			rsparon.Open cs, BDatos
			if rsparon.eof then 'Puedo añadir registro
				rsparon.close
				cs= "INSERT INTO " & precrs & "ParonVentas (CodigoHab, CodigoEsta, Dia) Values ('"&chab&"', '"&cest&"',CONVERT(DATETIME, '" & paron & "', 102))"
				Bdatos.execute cs
			else
				rsparon.close
			end if
		next
		'pv2.close

	else 'Quita las fecha del paron de ventas
		fechai=cdate(request.form("fini1"))
		fechaf=cdate(request.form("fini2"))
		for fechaparon=fechai to fechaf
			paron=year(fechaparon) & "-" & month(fechaparon) & "-" & day(fechaparon) & " 00:00:00"
			'cmdDC.CommandText = "DELETE FROM ParonVentas WHERE CodigoHab= '"&chab&"' AND CodigoEsta = '"&cest&"' AND Dia = CONVERT(DATETIME, '" & paronNO & "', 102) "
			cs="DELETE FROM " & precrs & "ParonVentas WHERE CodigoHab= '"&chab&"' AND CodigoEsta = '"&cest&"' AND Dia = CONVERT(DATETIME, '" & paron & "', 102) "
			'response.write paron
			'pv2.Open cmdDC, , 2, 2
			'pv2.close
			BDatos.execute cs
		next
	end if
	set rsparon=nothing
	BDatos.close
	set BDatos=nothing
end if
%>

<script language="JavaScript">
var orde=<%=orde%>;
var pos=<%=pos%>;
var maxcolor;
var hecho=false;

function reloadpage(){
	document.forms.actualizar.hpos.value=pos;
	document.forms.actualizar.horde.value=orde;
	document.forms.actualizar.submit();
}

function CompruebaMarca(){
	if (!hecho){
		alert("falta marcar último día");
		return false;
		}
	
	document.all.actualiza.value='1';
	document.forms.actualizar.submit();
}

var inicial;
var final;
var marcar;

function getfechas(vfecha,ii){
	if (pos==0){
		document.forms.actualizar.hpos.value=1;
		pos=1;
		marcar=true;
		hecho=false;
		document.forms.actualizar.Ini1.value=ii;
		document.forms.actualizar.fIni1.value=vfecha;
		document.forms.actualizar.marca.value=1; //está en modo marca
		inicial=ii;
		document.all.notas.value="Marcar último día";
		//Comprobar si está marcado
		if (document.all[ii + 'a'].style.background=="#ff6666"){
			marcar=false;
			document.forms.actualizar.marca.value=0; //está desmarcando
			document.all.notas.value="Desmarcar último día";
			}
	}else{
		document.forms.actualizar.hpos.value=0;
		pos=0;
		if (inicial>ii){
			alert("Por favor compruebe que el dia primero\n es menor que el último día");
			if (marcar)
				document.all.notas.value="Marcar primer día";
			else
				document.all.notas.value="Desmarcar primer día";
			return false;
			}
		document.forms.actualizar.Ini2.value=ii;
		document.forms.actualizar.fIni2.value=vfecha;
		final=ii;
		hecho=true;
		document.all.notas.value="Pulsar sobre actualizar";

		if (marcar){
		//poner en rojo los dias marcados
		for (var i=inicial; i<=final;i++){
			if(document.all[i.toString() + 'a'].style.background!="#cccccc"){
				document.all[i.toString() + 'a'].style.background="#ff6666";
				if (i >= maxcolor){
					return false;}
				}
			}
		}else{
		//poner en verde los dias marcados
		for (var i=inicial; i<=final;i++){
			if(document.all[i.toString() + 'a'].style.background!="#cccccc"){
				document.all[i.toString() + 'a'].style.background="#00FF66";
				if (i >= maxcolor){
					return false;}
				}
			}
		
		
		}
	}

}

</script>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<STYLE type=text/css>.fondoindex {
	BACKGROUND-IMAGE: url(file:///C|/CLIENTES/THB/thb_web_actual/images/comunes/fondo_index.jpg); BACKGROUND-REPEAT: repeat
}
.thbwhite {
	COLOR: #ffffff; TEXT-DECORATION: underline
}
</STYLE>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<link href="css1.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgColor=#d7ecf7>


<div align="center" class="titulo">Parón de Ventas</div>
<br>
<div align="center">
<TABLE align="center">
  <TBODY>
    <TR> 
      <TD><div align="center" STYLE="cursor:pointer;" onClick="orde-=2;reloadpage();"><font color="blue"><IMG height=29 src="img/flechizq.gif" width=30 border=0></font></div></TD>
      <TD> <TABLE>
          <TBODY>
            <TR> 
              <TD height="79" vAlign=top> <TABLE borderColor=#000000 bgColor=#3399ff border=1>
                  <TBODY>
                    <TR> 
                      <TD class=titulotabla align=left colSpan=7 style="color:#ffffff;"> 
                        <%response.Write(ucase1(monthname(calenm)) & "&nbsp;" & calena)%>
                      </TD>
                    </TR>
                    <TR> 
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(1, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(2, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(3, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(4, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(5, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(6, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(7, true, 2))%></TD>
                    </TR>
                    <TR> 
                      <%
						fecha=cdate(fechaini)
						fecha=dateadd("m",clng(orde),cdate(fechaini))
						set rsh = Server.CreateObject("ADODB.Recordset")
						set rs = Server.CreateObject("ADODB.Recordset")
						j=0
						ii=0
						cont=0
						do while clng(month(fecha))=clng(calenm)%>
                    <tr> 
                      <%for i=0 to 6
							if weekday(fecha,2)=i+1 and clng(month(fecha))=clng(calenm)then%>
							<%amefecha=year(cdate(fecha)) & "-" & month(cdate(fecha)) & "-" & day(cdate(fecha)) & " 00:00:00"
									color="#cccccc"
								if clng(Disp(cont,0))<>0 and cdate(Disp(cont,1))=cdate(fecha) then 
									color="#00FF66"
									
									SQL3 = "SELECT Dia FROM " & precrs & "ParonVentas WHERE (ParonVentas.CodigoHab = " & chab & ") " & _ 
										"AND (ParonVentas.CodigoEsta = " & cest & ") "
									cmdDC.CommandText = sql3
									Set pv = Server.CreateObject("ADODB.Recordset")
									pv.Open cmdDC, , 2, 2
									
									if not pv.EOF then
										while NOT pv.EOF and color<>"#ff6666"
											if cdate(fecha) = cdate(pv.Fields("dia")) then
												color="#ff6666"											
											end if
											pv.movenext
										wend 
									end if
								end if
								if cdate(fecha) < cdate(day(now()) & "/" & month(now()) & "/" & year(now())) then color="#cccccc"
								if color="#00FF66" then
									diaSI=day(fecha)
									mesSI=month(fecha)
									if len(mesSI) = 1 then
										mesSI="0"&mesSI
									end if
									fechaSI=""&diaSI & mesSI & year(cdate(fecha))&""%>
									<TD align=right><div id="<%=ii%>a" align="center" STYLE="cursor:pointer;background:<%=color%>" onClick="getfechas('<%=cdate(fecha)%>',<%=ii%>);"><font color="blue"><%=day(fecha)%></font></div></TD>
								<%else
								if color="#ff6666" then
									diaNO=day(fecha)
									mesNO=month(fecha)
									if len(mesNO) = 1 then
										mesNO="0"&mesNO
									end if
									fechaNO=""&diaNO & mesNO & year(cdate(fecha))&""%>
									<TD align=right><div id="<%=ii%>a" align="center" STYLE="cursor:pointer;background:<%=color%>" onClick="getfechas('<%=cdate(fecha)%>',<%=ii%>);"><font color="blue"><%=day(fecha)%></font></div></TD>
								<%else%>
									<TD align=right ><div id="<%=ii%>a" align="center" STYLE="background:<%=color%>"><font color="#000000"><%=day(fecha)%></font></div></TD>
								<%end if
							end if
						set pv = nothing%>
                      <%ii=ii+1%>
					  <%fecha=dateadd("d",1,fecha)%>
                      <%cont=cont+1%>
					  <%j=j+1%>
                      <%else%>
                      <TD align=right bgColor=#cccccc>&nbsp;</TD>
                      <%end if%>
                      <%next%>
                    <tr> 
                      <%loop%>
                      <%set rsh = nothing%>
                      <%set rs = nothing%>
                  </TBODY>
                </TABLE></td>
				</tr><tr>
              <TD vAlign=top> <TABLE borderColor=#000000 bgColor=#3399ff border=1>
                  <TBODY>
                    <TR> 
                      <TD class=titulotabla align=left colSpan=7 style="color:#ffffff;"> 
                        <%response.Write(ucase1(monthname(month(dateadd("m",1,cdate(calend & "/" & calenm & "/" & calena))))) & "&nbsp;" & year(dateadd("m",1,cdate(calend & "/" & calenm & "/" & calena))))%>
                      </TD>
                    </TR>
                    <TR> 
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(1, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(2, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(3, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(4, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(5, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(6, true, 2))%></TD>
                      <TD class=titulotabla style="color:#ffffff;"><%=ucase1(WeekdayName(7, true, 2))%></TD>
                    </TR>
                    <TR> 
                      <%
						fecha=cdate(fechaini)
						fecha=dateadd("m",clng(orde),cdate(fechaini))
						fecha=dateadd("m",1,fecha)
						set rsh = Server.CreateObject("ADODB.Recordset")
						set rs = Server.CreateObject("ADODB.Recordset")
						cont=0
						do while clng(month(fecha))-1=clng(calenm)%>
                    <tr> 
                      <%for i=0 to 6
						if weekday(fecha,2)=i+1 and clng(month(fecha))-1=clng(calenm)then%>
							<%amefecha=year(cdate(fecha)) & "-" & month(cdate(fecha)) & "-" & day(cdate(fecha)) & " 00:00:00"
							color="#cccccc"
							if clng(Disp2(cont,0))<>0 and cdate(Disp2(cont,1))=cdate(fecha)  then 
								color="#00FF66"
								SQL3 = "SELECT Dia FROM " & precrs & "ParonVentas WHERE (ParonVentas.CodigoHab = " & chab & ") " & _ 
										"AND (ParonVentas.CodigoEsta = " & cest & ") "
									cmdDC.CommandText = sql3
									Set pv = Server.CreateObject("ADODB.Recordset")
									pv.Open cmdDC, , 2, 2
									
									if not pv.EOF then
										while NOT pv.EOF and color<>"#ff6666"
											if cdate(fecha) = cdate(pv.Fields("dia")) then
												color="#ff6666"											
											end if
											pv.movenext
										wend 
									end if
								end if
							if cdate(fecha) < cdate(day(now()) & "/" & month(now()) & "/" & year(now())) then color="#cccccc"
							if color="#00FF66" then
									diaSI=day(fecha)
									mesSI=month(fecha)
									if len(mesSI) = 1 then
										mesSI="0"&mesSI
									end if
									fechaSI=""&diaSI & mesSI & year(cdate(fecha))&""%>
									<TD align=right><div id="<%=ii%>a" align="center" STYLE="cursor:pointer;background:<%=color%>" onClick="getfechas('<%=cdate(fecha)%>',<%=ii%>)"><font color="blue"><%=day(fecha)%></font></div></TD>
								<%else
								if color="#ff6666" then
									diaNO=day(fecha)
									mesNO=month(fecha)
									if len(mesNO) = 1 then
										mesNO="0"&mesNO
									end if
									fechaNO=""&diaNO & mesNO & year(cdate(fecha))&""%>
									<TD align=right><div id="<%=ii%>a" align="center" STYLE="cursor:pointer;background:<%=color%>" onClick="getfechas('<%=cdate(fecha)%>',<%=ii%>)"><font color="blue"><%=day(fecha)%></font></div></TD>
								<%else%>
									<TD align=right ><div id="<%=ii%>a" align="center" STYLE="background:<%=color%>"><font color="#000000"><%=day(fecha)%></font></div></TD>
								<%end if
							end if
							set pv = nothing%>
							<%ii=ii+1%>
						  <%fecha=dateadd("d",1,fecha)%>
						  <%cont=cont+1%>
						  <%j=j+1%>
						<%else%>
                      		<TD align=right bgColor=#cccccc>&nbsp;</TD>
                        <%end if%>
                      <%next%>
                    <tr> 
						  <script>
						maxcolor=<%=ii-1%>;
						</script>
				  <%loop%>
				  <%set rsh = nothing%>
				  <%set rs = nothing%>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
      <TD><div align="center" STYLE="cursor:pointer;" onClick="orde+=2;reloadpage();"><font color="blue"><IMG height=29 src="img/flechder.gif" width=30 border=0></font></div></TD>
    </TR>
	<tr>
		<td colspan="3" align='center'>
			<input type='text' class='titulo' readonly id='notas' style='border:0; text-decoration:none; background:#d7ecf7;'>
		</td>
	</tr>
	<tr>
		<td colspan="3" align='center'>
			<input type='button' value='Actualizar Cambios' onclick="CompruebaMarca();">
		</td>
	</tr>

  </TBODY>
</TABLE>
</div>
<form action="paronventas2.asp?hcbestable=<%=cest%>&hcbhab=<%=chab%>" method="post" name="actualizar">
  <input name="hpos" type="hidden" id="hpos" value="<%=pos%>">
  <input name="horde" type="hidden" id="horde" value="<%=orde%>">
  <input name="Ini1" type="hidden" id="Ini1" value="<%=col1%>">
  <input name="Ini2" type="hidden" id="Ini2" value="<%=col2%>">
  <input name="fIni1" type="hidden" id="fIni1" value="<%=fini%>">
  <input name="fIni2" type="hidden" id="fIni2" value="<%=ffin%>">
  <input name='marca' type='hidden' id='marca' value=''>
  <input name='actualiza' type='hidden' id='actualiza' value='0'>
</form>
<script language='javascript'>
	document.all.notas.value="Marcar primer día";
</script>
</body>
</html>