<%
precrsgen="jos_crsgen_"
'Nivel usuarios
const TAdmin=0 'administrador
const TCadena=2 'Cadena hotelera
const TRecepcion=5 'Recepcion
const TComercial=7 'Comercial sólo precios
const TRelacion=10 'Relaciones publicas
const TAgencia=15 'Agencias

miNivel=request.Cookies("nivelCR")
if miNivel="" then miNivel=TRelacion
miNivel=paClng(miNivel)

'Variables de modificacion datos
sololeer=""
desactivo=""
if miNivel>=TComercial then
	sololeer=" readOnly"
	desactivo=" disabled"
end if

set base=server.createobject("ADODB.Connection")
base.Open ConectaMDB
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType=adOpenForwardOnly
rs.LockType=adLockReadOnly

'Módulos visibles por la empresa
cs="SELECT Id,Modulo,Programa FROM " & precrsgen & "modulos "
cs=cs & "WHERE Menu<>0 and ModuloSuperior=0 "
cs=cs & " ORDER BY Orden"
rs.open cs,base
hayTModulos=false
if not rs.eof then
	RegTModulos=rs.getrows
	TMCodi=0
	TMModulo=1
	TMPrograma=2
	hayTModulos=true
end if
rs.close


set rs=nothing
base.close
set base=nothing
%>