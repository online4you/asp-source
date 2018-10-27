<!--#include file="includes/FunGestion.asp"-->
<!--#include file="idiomas/claseIdioma.asp"-->
<%
set objIdioma = new clsIdioma 'carga la clase con el idioma de lang

set base=server.createobject("ADODB.Connection")
base.Open Conecta
set rs=server.createobject("ADODB.Recordset")
rs.CursorLocation = adUseServer
rs.CursorType = adOpenForwardOnly
rs.LockType = adLockReadOnly

recarga = request.QueryString("recarga") 'id del frame de la ventana
est = paClng(request.QueryString("est"))
if est = 0 then est=paClng(request.Cookies("codiHotel"))
laid = paClng(request.QueryString("idh"))

pasalir = 0
if request.Form<>"" then
	'Añadir dto
	'regimen = paClng(request.form("regimen"))	
	regimen = split(request.form("regimen"), ",")	
	colectivo = paClng(request.form("colectivo"))
	dto = paDbl(request.form("dto"))
	precio = paDbl(request.form("precio"))
	desdeplazas = paClng(request.form("desdeplazas"))
	hastaplazas = paClng(request.form("hastaplazas"))

	fail = -1

	for i = 0 to UBound(regimen)
		r = paClng(regimen(i))
	
		'Comprobar que no exista el mismo
		cs = "SELECT Id FROM " & precrs & "RegimenDtos RegimenDtos WHERE IdRegimenHotel = " & r & " AND CodigoColec = " & colectivo
		cs = cs & " AND DesdePlazas = " & desdeplazas & " AND HastaPlazas = " & hastaplazas
		rs.open cs, base
		
		if rs.eof then
			'Añadir el nuevo
			cs = "INSERT INTO " & precrs & "RegimenDtos (IdRegimenHotel,CodigoColec,Descuento,Precio,DesdePlazas,HastaPlazas) VALUES ("
			cs = cs & r & "," & colectivo & "," & quitarComa(dto) & "," & quitarComa(precio) & ","
			cs = cs & desdeplazas & "," & hastaplazas & ")"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			pasalir = 1			
		else 'ya está
			fail = fail + 1
			
			if UBound(regimen) = 0 or fail = UBound(regimen) then
				msgerror = objIdioma.getTraduccionHTML("i_dtoexiste")
			end if
		end if
		rs.close
	next
end if 'form<>""

'Precio Dtos Suplementos por temporadas
cs = "SELECT RegimenHotel.Id,FInicio,FFinal,IF(ISNULL(Traducciones.Traduccion),Regimen.Nombre,Traducciones.Traduccion) AS Tradu "
cs = cs & "FROM ((" & precrs & "RegimenHotel RegimenHotel INNER JOIN " & precrs & "Regimen Regimen "
cs = cs & "ON RegimenHotel.IdRegimen=Regimen.Id) LEFT JOIN " & precrs & "Traducciones Traducciones "
cs = cs & "ON Regimen.Id=Traducciones.IdReferencia AND Tabla='Regimen' AND Campo='Nombre' AND Idioma='" & lang & "') "
cs = cs & "LEFT JOIN " & precrs & "Temporadas Temporadas "
cs = cs & "ON RegimenHotel.CodigoTempo=Temporadas.CodigoTemp "
cs = cs & "WHERE RegimenHotel.CodigoEsta=" & est & " AND Anyo=" & anyo & " AND (CodigoHab=" & laId & " OR CodigoHab=0)"
cs = cs & " AND RegimenHotel.Tarifa=" & laTarifa & " ORDER BY Regimen.Id,FInicio"

rs.open cs,base

hayDsuples = false

if not rs.eof then
	RegDSuples = rs.getrows
	SDId = 0
	SDFIni = 1
	SDFFin = 2
	SDRegimen = 3
	hayDsuples = true
end if
rs.close

'Bucar los nombres colectivos de este hotel
cs = "SELECT CodigoColec,IF(ISNULL(Traducciones.Traduccion),Colectivos.Nombre,Traducciones.Traduccion) as Tradu,Orde FROM " & precrs & "Colectivos Colectivos LEFT JOIN " & precrs & "Traducciones Traducciones "
cs = cs & "ON Colectivos.CodigoColec=Traducciones.IdReferencia AND "
cs = cs & "Tabla='Colectivos' AND Campo='Nombre' AND Idioma='" & lang & "' "
cs = cs & "WHERE Colectivos.CodigoEsta=" & est & " AND Nombre<>'' ORDER BY Orde"
rs.open cs,base
if not rs.eof then
	RegColec=rs.getrows
	CCodi=0
	CNombre=1
	COrde=2
end if
rs.close

set rs=nothing
base.close
set base=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--#include file="metasCabecera.asp"-->
<script language="javascript" type="text/javascript" src="/js/eventosVentana.js"></script>
</head>
<script language="javascript" type="text/javascript">
function cerrar(){
	top.quitaFlota(self.name); //quito esa ventana
}
<%if pasalir=1 then%>
	//Refrescar el que lo ha llamado
	recargaFrame("<%=recarga%>");
	cerrar();
<%end if%>

function Modificar(){
	document.f1.action="<%=MiPag%>?modo=nuevo&idh=<%=laId%>&est=<%=est%>&recarga=<%=recarga%>";
	document.f1.submit();
}
</script>
<body class="laFicha">
<div class="tituloFicha" id='tituloFicha'>
	<div class="nombreFicha"><%=objIdioma.getTraduccionHTML("i_dtosregimen")%></div>
	<div class="laX" id='laX'></div>
	<img id='iconoForma' src="img/Mini.gif" border="0" width="21" height="17" class="Minimizar" alt="Minimizar" />
</div>
<form name='f1' action="<%=MiPag%>" method="POST">
<table align='center' width='100%' border='0' cellpadding="0" cellspacing="2" class="tdTabla">
	<%if msgerror<>"" then 'repetido%>
	<tr><th align='left' colspan="2" class="colu_impar">&nbsp;*&nbsp;<%=msgerror%></th>
	</tr>
	<%end if%>
    <tr><td colspan="2"><%=objIdioma.getTraduccionHTML("i_textodtoregi")%></td></tr>
    <tr><td colspan="2" height="10"></td></tr>
	<tr><td align='right'><%=objIdioma.getTraduccionHTML("i_regimen")%></td>
    	<td>
        <!--select name='regimen'>
		<%'Poner lista de Regimen
		if haydsuples then
		for c=0 to ubound(RegDSuples,2)%>
			<option value='<%=RegDSuples(SDId,c)%>'>
				<%response.write RegDSuples(SDRegimen,c)
				if not isnull(RegDSuples(SDFIni,c)) then
					response.write " -> " & verFecha(RegDSuples(SDFIni,c)) & " - " & verFecha(RegDSuples(SDFFin,c))
				end if%>
			</option>
		<%next
		end if%>
		</select-->
        
		<select name='regimen'>
        
        <%
			'Poner lista de Regimen
			optionsGroup = ""
			options = ""
			
			if haydsuples then				

				regimen = ""
				valGroup = ""
				
				for c = 0 to ubound(RegDSuples, 2)
					addGroupOption = false
					hasDates = false					

					r = RegDSuples(SDRegimen, c)				
					val = RegDSuples(SDId, c)
					ini = verFecha(RegDSuples(SDFIni, c))
					fin = verFecha(RegDSuples(SDFFin, c))

					if regimen = "" then
						regimen = r
					end if

					if not isnull(RegDSuples(SDFIni,c)) then
						hasDates = true
					end if

					if regimen <> r then
						addOptionGroup = true
					else
						addOptionGroup = false
					end if
					
					'options de agrupación
					if addOptionGroup then
						optionsGroup = optionsGroup & "<option value='" & valGroup & "'>"
						optionsGroup = optionsGroup & regimen & " (" & objIdioma.getTraduccionHTML("i_cualquiera") & ")"
						optionsGroup = optionsGroup & "</option>"
						
						regimen = r
						valGroup = ""
					end if
					
					'options normales
					if hasDates then
						options = options & "<option value='" & val & "'>"
						options = options & r
						
						options = options & " -> " & ini & " - " & fin
						
						options = options & "</option>"						
					end if
					
					if valGroup <> "" then
						valGroup = valGroup & ","
					end if
					
					valGroup = valGroup & val
				next
				
				optionsGroup = optionsGroup & "<option value='" & valGroup & "'>"
				optionsGroup = optionsGroup & regimen & " (" & objIdioma.getTraduccionHTML("i_cualquiera") & ")"
				optionsGroup = optionsGroup & "</option>"
			end if
		%>
        
        <%= optionsGroup %>
        <%= options %>
		</select>
        </td>
    </tr>
    <tr><td align="right"><%=objIdioma.getTraduccionHTML("i_colectivo")%></td>
    	<td>
        <select name='colectivo'>
		<%'Poner lista de Colectivos 
		for c=0 to ubound(RegColec,2)%>
			<option value='<%=RegColec(CCodi,c)%>'>
				<%=RegColec(CNombre,c)%>
			</option>
		<%next%>
		</select>
        </td>
    </tr>
    <tr><td align="right"><%=objIdioma.getTraduccionHTML("i_desdeplazas")%></td>
    	<td><input type="text" name="desdeplazas" value="0" style="width:30px">
        &nbsp;<%=objIdioma.getTraduccionHTML("i_hasta")%>&nbsp;<input type="text" name="hastaplazas" value="0" style="width:30px">
        </td>
    </tr>
    <tr><td align="right"><%=objIdioma.getTraduccionHTML("i_descuento")%></td>
    	<td><input type="text" name="dto" style="width:40px;"></td>
    </tr>
    <tr><td align="right"><%=objIdioma.getTraduccionHTML("i_precio")%></td>
    	<td><input type="text" name="precio" style="width:40px;"></td>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>
	<tr><td align='center' colspan='2'>
		<input id='boton' type='button' value='<%=objIdioma.getTraduccionHTML("i_nuevo")%>' onclick="javascript:Modificar();" class="boton86">	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%=objIdioma.getTraduccionHTML("i_cerrar")%>" class='boton86' onClick="javascript:cerrar();" ></td></tr>
</table>
</form>
<script language="javascript" type="text/javascript">
	document.f1.regimen.focus();
</script>
</body>
</html>