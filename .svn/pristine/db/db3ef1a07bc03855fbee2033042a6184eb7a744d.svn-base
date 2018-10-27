<%@LANGUAGE='VBScript'%>
<%If session.Contents("OK")="no" or session.Contents("OK")="" then response.End()%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//DE">
<SCRIPT LANGUAGE="JavaScript">

function Recargar(Numberrr){
	//document.forms['Mail'].elements['Qui'].value="";
	//document.forms['Borrar'].elements['BorrarReg'].value="";
	//document.forms['Mail'].elements['to'].value="";
	//document.forms[0].submit();
}
function SendMailing(Numberr){
	var Str
	
	Str="";
	for (i=0; i < document.forms['Borrar'].elements.length ; i++)
		{
		
		if (document.forms['Borrar'].elements[i].type == "checkbox" )
		{
		for (cont=0; cont <= Numberr; cont++)
			{
			if (document.forms['Borrar'].elements[i].name == "check" + cont )	
				if (document.forms['Borrar'].elements[i].checked == true )
				{
					Str=Str + "Clients.Id=" + document.forms['Borrar'].elements['HF'+ cont].value + " OR ";
				}
			}
		}

	}
	document.forms['Mail'].elements['Qui'].value=Str;
	//document.forms['Mail'].elements['to'].value="OK"
}
function Deleting(Numberr){
	var Str
	
	Str="";
	for (i=0; i < document.forms['Borrar'].elements.length ; i++)
		{
		
		if (document.forms['Borrar'].elements[i].type == "checkbox" )
		{
		for (cont=0; cont <= Numberr; cont++)
			{
			if (document.forms['Borrar'].elements[i].name == "checkbox" + cont )	
				if (document.forms['Borrar'].elements[i].checked == true )
				{
					Str=Str + " (Dialeg.Ref=" + document.forms['Borrar'].elements['HF'+ cont].value + " AND " + "Dialeg.Idi='" + document.forms['Borrar'].elements['HI'+ cont].value + "') OR ";
				}
			}
		}

	}
	document.forms['Borrar'].elements['BorrarReg'].value=Str;

}
</SCRIPT>
<HTML>
<HEAD>
<TITLE>Gestión de enlaces</TITLE>
</HEAD>
<!-- #INCLUDE FILE="Connections/Functions.asp"  -->
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
 <div align="left"><a href="Users.asp">Gestión de usuarios</font></a>
<%
Function Taula1()
%>
<!--DWLayoutTable-->
  <tr> 
    <td height="23" colspan="1" valign="top" bgcolor="#FFFF00" class="formedio"></td>
    <td colspan="3" valign="top" bgcolor="#66CCFF" class="formedio"><center>Registros</center></td>

  </tr>
  <tr> 
    <td width="31" height="16" valign="top" bgcolor="#FF0000" class="marivent">
	Borrar
	</td>

      

<%
End function
Function Taula2()
%>

	
    <td width="79" valign="top" bgcolor="#FFFF00" class="marivent">Código</td>
    <td width="75" valign="top" bgcolor="#FFFF00" class="marivent">Idioma</td>
    <td width="82" valign="top" bgcolor="#FFFF00" class="marivent">Texto</td>
  </tr>

<%
End function

	'---- Declaració de variables i conect----
	Dim Base
	Dim SQL,Mail,Condicio
	Dim i,ii,bgcolorr
	Dim CN
	Dim CS,Res
	Dim Linkin

Set Res = Server.CreateObject("ADODB.Recordset")
Set CS = Server.CreateObject("ADODB.Recordset")

		if  request.form("BorrarReg")<>"" then 
				condicio=request.form("BorrarReg")
				condicio=left(condicio,len(condicio)-4)
				call executarsql ("DELETE Dialeg.* FROM Dialeg WHERE " &  condicio & ";")
		end if
		if  request.form("De")=""  then
			Call Vistes(Base)
		else
			'cmdDC.CommandText ="SELECT Count(Ref) AS Expr1 FROM Dialeg WHERE Dialeg.Ref='" & request.form("Client") & "' And Dialeg.Idi=""" & request.form("Tipo") & """;"
			'Res.Open cmdDC, , 0, 2
			SQL=""

			'If res.fields(0)=0 then 
			'	SQL="INSERT INTO Dialeg ( Ref, Idi, Texte ) "
			'	SQL=SQL & " SELECT '" & request.form("Client") & "' AS cc, "
			'	if request.form("Tipo")<>"" then SQL=SQL & "'" & request.form("Tipo") & "' AS tt, "
			'	if request.form("Tipo")="" then SQL=SQL & "Null AS tt, "
			'	if request.form("De")<>"" then SQL=SQL & "'" & sqlen(request.form("De")) & "' AS dd; "
			'	if request.form("De")="" then SQL=SQL & "Null AS dd; "
			'else
				SQL="UPDATE " & precrs & "Dialeg SET "
				if request.form("De")<>"" then SQL=SQL & " Dialeg.Texte = '" & sqlen(request.form("De")) & "' "
				if request.form("De")="" then SQL=SQL & " Dialeg.Texte = Null "
				SQL=SQL & " WHERE Dialeg.Ref='" & request.form("Client") & "' And Dialeg.Idi='" & request.form("Tipo") & "';"
			'end if

			Call ExecutarSQL(SQL)
			'Res.Close
			Call Vistes(Base)

			
		end if
	%>

</BODY>
</HTML>
<%

Function Vistes(Base)
	if  request.form("BorrarReg")<>"" then 
		condicio=request.form("BorrarReg")
		condicio=left(condicio,len(condicio)-4)
		call BorrarRegistres(Base,condicio)
	end if
	cmdDC.CommandText ="SELECT Dialeg.Ref, Dialeg.Idi, Dialeg.Texte FROM " & precrs & "Dialeg Order by Dialeg.Ref, Dialeg.Idi;"
	Res.Open cmdDC, , 0, 2
	'cmdDC.CommandText ="SELECT Count(Ref) AS Expr1 FROM Dialeg;"
	'CS.Open cmdDC, , 0, 2
	response.write("<br><br><br><br><center><table width=""90%"" border=""0""><tr bgcolor=""#CCFFCC""><div align=""center"">Gestión de registros</div><br><td width=""59%""  height=""103""><form name=""Mail"" method=""post"" action=""idiomes.asp"">")
	SQL="SELECT Dialeg.Ref, Dialeg.Ref FROM " & precrs & "Dialeg GROUP BY Dialeg.Ref, Dialeg.Ref;"
	response.write ("<center><table><tr><td>Código &nbsp;</td><td>")
	call desplegable("name=""Client"" class=""campo""",SQL,Base,False,"Elige un código",request.form("Client"))
	response.write ("<tr><td>Idioma:</td><td>")
	call desplegable("name=""Tipo"" class=""campo""","SELECT Dialeg.Idi, Dialeg.Idi as Idi2 FROM Dialeg GROUP BY Dialeg.Idi, Dialeg.Idi;",Base,False,"Elige idioma",request.form("Tipo"))	
	response.write ("</td></tr>")	
	response.write ("</td></tr><tr><td>Texto:</td><td><INPUT TYPE=""TEXT"" NAME=""De""></td></tr>")
	response.write ("</td></tr></table><INPUT TYPE=""hidden"" NAME=""Qui"">")
	response.write("</td></tr><tr bgcolor=""#CCFFCC""><td><center><input type=""submit"" name=""Submit"" value=""Grabar""></center><input type=""hidden"" name=""Correcte"" Value=""" & request.form("Correcte") & """></form></td></tr></table></center>")
	response.write("<form name=""Borrar"" method=""post"" action=""Idiomes.asp"">")
	response.write("<table width=""90%"" border=""1"" align=""center"">")
	Call Taula1
	response.write("<input type=""hidden"" name=""BorrarReg"" Value=""Ok""><input type=""hidden"" name=""Correcte"" Value=""Ok""></td>")
	response.write("<input type=""hidden"" name=""Correcte"" Value=""Ok""></td>")
	Call Taula2
	'response.write("<tr>")
		'response.write("<td><input type=""submit"" name=""Submit"" value=""Borrar"" OnMouseOver=""Javascript:Deleting(" &  CS.fields(0) & ");""></td>")
		'response.write("<input type=""hidden"" name=""BorrarReg"" Value=""Ok""><input type=""hidden"" name=""Correcte"" Value=""Ok""></td>")
		'response.write("<td><font color=""#0000FF"">Enviar </font> </td>")
		'response.write("<input type=""hidden"" name=""Correcte"" Value=""Ok""></td>")
		'for i=2 to 19
			'response.write("<td>" & res.fields(i).name & "</td>")
		'next
	'response.write("</tr>")
	cont=0
	ii=1
	do while not res.eof
		cont=cont+1
		if ii=11 then ii=1
		bgcolorr="#00CCFF"
		if ii<=5 then  bgcolorr="#66FF99"
		ii=ii+1
		response.write("<tr>")
		response.write("<td bgcolor=""" & bgcolorr & """><input type=""checkbox"" name=""" & "checkbox" & cont & """ value=""checkbox"" Disabled>")
		response.write("<input type=""hidden"" name=""" & "HF" & cont & """ Value=""" & res.fields(0) & """>")
		response.write("<input type=""hidden"" name=""" & "HI" & cont & """ Value=""" & res.fields(1) & """></td>")
		'response.write("<td><input type=""checkbox"" name=""" & "check" & cont & """ value=""checkbox"" " & res.fields(1) & ">")
		for i=0 to 2
			if not isnull(res.fields(i)) then  response.write("<td bgcolor=""" & bgcolorr & """>" & res.fields(i) & "</td>")
			if isnull(res.fields(i)) then  response.write("<td bgcolor=""" & bgcolorr & """>&nbsp;</td>")
		next
		response.write("</tr>")
		res.movenext
	loop
	response.write("<tr><td height=""34"" colspan=""20"" valign=""top"">")
	cmdDC.CommandText ="SELECT Count(Ref) AS Expr1 FROM " & precrs & "Dialeg;"
	CS.Open cmdDC, , 0, 2
	'response.write("<input type=""submit"" name=""Submit"" value=""Borrar los registros seleccionados"" OnMouseOver=""Javascript:Deleting(" &  CS.fields(0) & ");"">")
	response.write("</tr>")
	
	response.write("</table></form>")
	res.close			
End Function
function executarsql(SQLcomma)
	on error resume next
	cmdDC.commandtext=SQLcomma
	cmdDC.Execute
	if err.number<>0 then executarsql=err.Description
	if err.number=0 then executarsql=true
end function
Function Desplegable(Nom,SQL,Base,Blanc,Inici,Val)
	Dim CN
	Dim CS
	Dim filePath
	dim i
	Set CS = Server.CreateObject("ADODB.Recordset")
	cmdDC.commandtext=SQL
	CS.Open cmdDC, , 0, 2

	'if isnumeric(val) then val=clng(val)
	response.write "<select " & nom & ">"
	if Blanc=true then response.write "<option value="""" >" & Inici & "</option>" 
	do while not cs.eof
		if cstr(val) = cstr(cs.fields(0)) then 
			response.write ("<option value=""" & cs.fields(0)& """ selected>" & cs.fields(1) & "</option>")
		else
			response.write "<option value=""" & cs.fields(0)& """>" & cs.fields(1)&  "</option>"		
		end if
		cs.movenext
	loop
  	response.write "</select>" 
	cs.close
	
 end function
  Function BorrarRegistres(BaseD,Quins)
	Dim CN
	Dim Reg
	Dim filePath
	dim SQL,Idim

	BorrarRegistres = executarSQL("DELETE Clients.* FROM Clients WHERE " &  Quins & ";")
End Function

%>