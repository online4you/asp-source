<!--#include file="includes/FunGestion.asp"-->
<%
set base=server.createobject("ADODB.Connection")
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly
base.Open Conecta
dim ColecNom(4)
cs="SELECT CodigoEsta FROM " & precrs & "Establecimientos Establecimientos ORDER BY CodigoEsta"
rs.open cs,base
if not rs.eof then
	RegHotel=rs.getrows
	HCodi=0
end if
rs.close
for r=0 to ubound(RegHotel,2)
	codigoesta=regHotel(HCodi,r)
	response.write "CodigoEsta: " & codigoesta & "<br>"
					for i=0 to 2
						if i=0 then 
							Colecnom(0)="Adultos"
							Colecnom(1)="Adults"
							Colecnom(2)="Adults"
							Colecnom(3)="Adultes"
							Colecnom(4)="Erwachsene"
						end if
						if i=1 then
							Colecnom(0)="Niños 2-12"
							Colecnom(1)="Nins 2-12"
							Colecnom(2)="Children 2-12"
							Colecnom(3)="Enfants 2-12"
							Colecnom(4)="Kinder 2-12"
						end if
						if i=2 then 
							Colecnom(0)=""
							Colecnom(1)=""
							Colecnom(2)=""
							Colecnom(3)=""
							Colecnom(4)=""
						end if
						cs="INSERT INTO " & precrs & "Colectivos (CodigoEsta,Orde) VALUES ("
						cs=cs & CodigoEsta & "," & i & ")"
						base.execute cs
		
						cs="SELECT MAX(CodigoColec) as IDColec FROM " & precrs & "Colectivos"
						rs.open cs,base
						idcolec=rs("idcolec")
						rs.close
						
						for cont=0 to 4
							if cont=0 then IdiName="es"
							if cont=1 then IdiName="it"
							if cont=2 then IdiName="en"
							if cont=3 then IdiName="fr"
							if cont=4 then IdiName="de"
							cs="INSERT INTO " & precrs & "ColectivosNomres (Idioma, ColectivoIdi, Nombre) VALUES ('"
							cs=cs & IdiName & "'," & idcolec & ",'" & Colecnom(cont) & "')"
							base.execute cs
							
						next
		
					next

next
set rs=nothing
base.close
set base=nothing					

%>