<!--#include file="includes/FunGestion.asp"-->
<%
set baseNew=server.createobject("ADODB.Connection")
baseNew.Open "Provider=SQLOLEDB.1;Persist Security Info=True;User ID=qcy257;pwd=Planeta2007;Initial Catalog=qcy257;Data Source=lwda214.servidoresdns.net"

set rsN=server.createobject("ADODB.Recordset")
rsN.CursorLocation = adUseServer
rsN.CursorType=adOpenForwardOnly
rsN.LockType=adLockReadOnly


cs="SELECT CodigoEsta FROM Establecimientos "
rsN.open cs,baseNew
do while not rsN.eof
	codigoesta=rsN("codigoEsta")
	'SubProcesado de Colectivos
	cs="INSERT INTO Colectivos (CodigoEsta,Orde,Nombre_es,Nombre_it,Nombre_en,"
	cs=cs & "Nombre_de,Nombre_fr) VALUES ("
	cs=cs & CodigoEsta & ",0,'Adultos','Adultos','Adults','Erwachsene','Adultes')"
	baseNew.execute cs
	cs="INSERT INTO Colectivos (CodigoEsta,Orde,Nombre_es,Nombre_it,Nombre_en,"
	cs=cs & "Nombre_de,Nombre_fr) VALUES ("
	cs=cs & CodigoEsta & ",1,'Niños 2-12','Niños 2-12','Children 2-12','Kinder 2-12','Enfants 2-12')"
	baseNew.execute cs
	cs="INSERT INTO Colectivos (CodigoEsta,Orde,Nombre_es,Nombre_it,Nombre_en,"
	cs=cs & "Nombre_de,Nombre_fr) VALUES ("
	cs=cs & CodigoEsta & ",2,'','','','','')"
	baseNew.execute cs
	
	rsN.movenext
loop
rsN.close

set rsN=nothing
baseNew.close
set BaseNew=nothing
%>