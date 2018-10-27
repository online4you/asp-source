<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang
ficheroCVS=server_path & "reservas\crs\csv\" & IdEmpresa & "_listaReservas.csv"
'response.write ficheroCVS
'response.end()
set FSO = Server.CreateObject("Scripting.FileSystemObject")
set MiFiche=FSO.CreateTextFile(ficheroCVS,true,false) 

set base=server.createobject("ADODB.Connection")
'response.write Conecta & "<br>"
'response.write ConectaMDB
'response.end
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

est=paClng(request.Cookies("codiHotel"))

condicion=request.Cookies("filtrores")
if condicion="" then
	condicion="WHERE Reservas.CodigoEsta=" & est & " AND YEAR(Reservas.FechaReserva)=" & anyo & " ORDER BY Cod_res DESC"
end if

'Lista de registros
cs="SELECT Cod_res,date(Reservas.FechaReserva) FechaReserva,date(Reservas.FechaIni) FechaIni,date(Reservas.FechaFin) FechaFin,Fichas.Apellidos as Apellidos, " & chr(13) & chr(10)
cs=cs & "Fichas.Nombre as Nom,Fichas.EMail,Fichas.Telefono,Reservas.Importe,Reservas.importepag,if(Reservas.Activa='-1','Si','No') Activa,Establecimientos.Nombre, " & chr(13) & chr(10)
cs=cs & "NumAdultos,NumBebes,NumNinos1,NumNinos2, " & chr(13) & chr(10)
cs=cs & "IF(ISNULL(TraduccionesHab.Traduccion),TipoHabitaNombres.Nombre,TraduccionesHab.Traduccion) AS Habitacion, " & chr(13) & chr(10)
cs=cs & "IF(ISNULL(TraduccionesS.Traduccion),Regimen.Nombre,TraduccionesS.Traduccion) AS Regimen , " & chr(13) & chr(10)
cs=cs & "if(TipoVenta='0','ONLINE',if(TipoVenta='2','ONLINE','ONREQUEST')) TipoVenta,Reservas.Idi, " & chr(13) & chr(10)
cs=cs & "	if(Fichas.checkFactura='1','Si','No') checkFactura, " & chr(13) & chr(10)
cs=cs & "	Fichas.factNombre, " & chr(13) & chr(10)
cs=cs & "	Fichas.factCifNif, " & chr(13) & chr(10)
cs=cs & "	Fichas.factCP, " & chr(13) & chr(10)
cs=cs & "	Fichas.factDir, " & chr(13) & chr(10)
cs=cs & "	Fichas.factLoc, " & chr(13) & chr(10)
cs=cs & "	Fichas.factProv, " & chr(13) & chr(10)
cs=cs & "	Fichas.factEmail, " & chr(13) & chr(10)
cs=cs & "	if(Fichas.checkPersonaContacto='1','Si','No') checkPersonaContacto, " & chr(13) & chr(10)
cs=cs & "	Fichas.nomContact, " & chr(13) & chr(10)
cs=cs & "	Fichas.apeContact, " & chr(13) & chr(10)
cs=cs & "	Fichas.telContact, " & chr(13) & chr(10)
cs=cs & "	if(Fichas.tipoDocu='1','NIF',if(Fichas.tipoDocu='2','Pasaporte','Otros')) tipoDocu, " & chr(13) & chr(10)
cs=cs & "	Fichas.documento, " & chr(13) & chr(10)
cs=cs & "	if(Fichas.deseoRecibirOfertas='1','Si','No') deseoRecibirOfertas, " & chr(13) & chr(10)
cs=cs & "	if(Fichas.acepto='1','Si','No') Acepto, " & chr(13) & chr(10)
cs=cs & "Ofertas.Titulo AS Oferta,CodigoOferta, " & chr(13) & chr(10)
cs=cs & "OfertasReserva.Importe as PelasOferta  " & chr(13) & chr(10)
cs=cs & "FROM (( " & chr(13) & chr(10)
cs=cs & "(jos_crs_Reservas Reservas INNER JOIN jos_crs_Establecimientos Establecimientos ON Reservas.CodigoEsta=Establecimientos.CodigoEsta)  " & chr(13) & chr(10)
cs=cs & "LEFT JOIN jos_crs_OfertasReserva OfertasReserva ON Reservas.Cod_Res=OfertasReserva.IdReserva)  " & chr(13) & chr(10)
cs=cs & "LEFT JOIN jos_crs_Ofertas Ofertas ON OfertasReserva.IdOferta=Ofertas.Id) LEFT JOIN jos_crs_Fichas Fichas ON Reservas.IdCliente=Fichas.Id  " & chr(13) & chr(10)
cs=cs & "inner join jos_crs_TipoReserva tres on tres.IdReserva=Reservas.Cod_res " & chr(13) & chr(10)
cs=cs & "LEFT JOIN jos_crs_TipoHabitaNombres TipoHabitaNombres ON tres.IdTipoHabitacion=TipoHabitaNombres.Id  " & chr(13) & chr(10)
cs=cs & "LEFT JOIN jos_crs_Traducciones TraduccionesHab " & chr(13) & chr(10)
cs=cs & "ON TipoHabitaNombres.id=TraduccionesHab.IdReferencia AND TraduccionesHab.Tabla='TipoHabitaNombres' AND TraduccionesHab.Campo='Nombre' AND TraduccionesHab.Idioma='es'  " & chr(13) & chr(10)
cs=cs & "inner join jos_crs_Regimen Regimen on Regimen.Id=tres.Suplementos " & chr(13) & chr(10)
cs=cs & "LEFT JOIN jos_crs_Traducciones TraduccionesS ON Regimen.id=TraduccionesS.IdReferencia AND TraduccionesS.Tabla='Regimen' AND TraduccionesS.Campo='Nombre' AND TraduccionesS.Idioma='es'  " & chr(13) & chr(10)

cs=cs & condicion & chr(13) & chr(10)
response.write cs & "<br>"
'response.end()
rs.Open cs, base
rows=rs.getrows

texto=""
fileds=ubound(rows)
for filed=0 to fileds
	texto= texto & rs.fields(filed).name & ";"
next
rs.close
texto= texto & chr(13) & chr(10)

for row=0 to ubound(rows,2)
	for filed=0 to fileds
		texto= texto & rows(filed,row) & ";"
	next
	texto= texto & chr(13) & chr(10)
next

'response.write (texto)& "<br>"
'response.end()

set rs=nothing
base.close
set base=nothing

'guardar fihero
MiFiche.write texto
MiFiche.close
set MiFiche=nothing
set FSO=nothing
%>
<script language="javascript" type="text/javascript">
//window.open("/csv/<%=IdEmpresa%>_listaReservas.csv");
window.location="<%=relative_url%>csv/<%=IdEmpresa%>_listaReservas.csv";
</script>