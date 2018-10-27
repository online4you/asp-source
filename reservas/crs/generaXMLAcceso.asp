<%
'Generar xml con los datos del acceso
xml="<?xml version='1.0' encoding='iso-8859-1'?>" & vbcrlf
xml=xml & "<datos>" & vbcrlf
xml=xml & "<userCR>" & user & "</userCR>" & vbcrlf
xml=xml & "<pwdCR>" & pass & "</pwdCR>" & vbcrlf
xml=xml & "<conexBD>" & conexBD & "</conexBD>" & vbcrlf
xml=xml & "<mysqlBD>" & mysqlBD & "</mysqlBD>" & vbcrlf
xml=xml & "<userBD>" & userBD & "</userBD>" & vbcrlf
xml=xml & "<pwdBD>" & pwdBD & "</pwdBD>" & vbcrlf
xml=xml & "<modulosCR>" & modulosCR & "</modulosCR>" & vbcrlf
xml=xml & "<hojaestilos>" & hojaestilos & "</hojaestilos>" & vbcrlf
xml=xml & "<hotelboss>" & hotelboss & "</hotelboss>" & vbcrlf
xml=xml & "<metaTitulo>" & metaTitulo & "</metaTitulo>" & vbcrlf
xml=xml & "<rutaFotos>" & rutaFotos & "</rutaFotos>" & vbcrlf
xml=xml & "<rutaDocu>" & rutaDocu & "</rutaDocu>" & vbcrlf
xml=xml & "<empresa>" & empresa & "</empresa>" & vbcrlf
xml=xml & "<IdEmpresa>" & IdEmpresa & "</IdEmpresa>" & vbcrlf
xml=xml & "<adminboss>" & adminboss & "</adminboss>" & vbcrlf
xml=xml & "</datos>" & vbcrlf

'guardar el fichero
set FSO = Server.CreateObject("Scripting.FileSystemObject") 
elfiche=server.MapPath(rutaXML) & "\Acceso_" & IdUsu & ".xml"
set MiFiche=FSO.CreateTextFile(elfiche,true,false) 
MiFiche.write xml
MiFiche.close
set MiFiche=nothing
set FSO=nothing
%>