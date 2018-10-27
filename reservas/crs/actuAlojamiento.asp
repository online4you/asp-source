<!--#include file="includes/claseUpload.asp"-->
<%
modo=request.QueryString("modo")

 
if modo<>"" then 'hay que actualizar
	MiId=paClng(request.QueryString("id"))
		
		nhotel=QuitarApos(request.QueryString("nombre"))
		email=QuitarApos(request.QueryString("email"))
		dire=QuitarApos(request.QueryString("direccion"))
		cp=QuitarApos(request.QueryString("cp"))
		pobla=QuitarApos(request.QueryString("poblacion"))
		tele=QuitarApos(request.QueryString("telefono"))
		fax=QuitarApos(request.QueryString("fax"))
		web=request.QueryString("web")
		moneda=request.QueryString("moneda")
		estado=clng("0" & request.QueryString("estado"))
		obs=QuitarApos(request.QueryString("obs"))
		aviso=request.QueryString("aviso")
		zona=request.QueryString("zona")
		if zona="" then zona=0
		prepago=QuitarComa(request.QueryString("prepago"))
		desde=QuitarComa(request.QueryString("desde"))
		porHabPer=request.QueryString("porHabPer")
		diasmin=QuitarComa(request.QueryString("diasmin"))
		diasanul=QuitarComa(request.QueryString("diasanul"))
		nombrepagina=request.QueryString("pagina")
		tipohotel=request.QueryString("tipohotel")
		categoria=request.QueryString("categoria")
		orden=request.QueryString("orden")

	select case modo 
		case "nuevo" 'Añadir
			
			on error resume next
			base.BeginTrans
			
			'Añadir en establecimientos
			cs="INSERT INTO " & precrs & "Establecimientos (Nombre,Orde,Porciento,DiasAnulacion,Estado,Obs,Moneda) VALUES ('"
			cs=cs & nhotel & "'," & orden & "," & prepago & "," & diasanul & "," & estado & ",'"
			cs=cs & obs & "'," & moneda & ")"
			'response.write cs & "<br>"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento

			'Busco el id del ult. establ.
			cs="SELECT MAX(CodigoEsta) as CodigoEsta FROM " & precrs & "Establecimientos"
			rs.open cs,base
			if not rs.eof then
				CodigoEsta=rs("CodigoEsta")
				MiId=CodigoEsta
			end if
			rs.close
			
			'Añadir los datos establecimientos
			cs="INSERT INTO " & precrs & "DatosHotel (CodigoEsta,EMail,Direccion,CP,Poblacion,Telefono,Fax,"
			cs=cs & "url,aviso,zona,TipoAlojamiento,NombrePagina,Categoria,Foto) VALUES ("
			cs=cs & CodigoEsta & ",'" & email & "','" & dire & "','" & cp & "','" & pobla & "','"
			cs=cs & tele & "','" & fax & "','" & web & "'," & aviso & "," & zona & ","
			cs=cs & tipohotel & ",'" & nombrepagina & "'," & categoria & ",'" & foto & "')"
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento

			'Traducciones de Colectivos
			cs="INSERT INTO " & precrs & "Colectivos (CodigoEsta,Orde,Nombre) VALUES (" & CodigoEsta & ",0,'Adultos')"
			base.execute cs
			'Buscar la id del colectivo
			cs="SELECT MAX(CodigoColec) AS Ulti FROM " & precrs & "Colectivos"
			rs.open cs,base
			if not rs.eof then
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'en','Colectivos','Nombre','Adults'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'de','Colectivos','Nombre','Erwachsene'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'fr','Colectivos','Nombre','Adultes'," & codigoesta & ")"
				base.execute cs
			end if
			rs.close			

			'Traducciones de Colectivos
			cs="INSERT INTO " & precrs & "Colectivos (CodigoEsta,Orde,Nombre) VALUES (" & CodigoEsta & ",1,'Ni&ntilde;os 2-6')"
			base.execute cs
			'Buscar la id del colectivo
			cs="SELECT MAX(CodigoColec) AS Ulti FROM Colectivos"
			rs.open cs,base
			if not rs.eof then
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'en','Colectivos','Nombre','Children 2-6'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'de','Colectivos','Nombre','Kinder 2-6'," & codigoesta & ")"
				base.execute cs

			end if
			rs.close			
			
			'Traducciones de Colectivos
			cs="INSERT INTO " & precrs & "Colectivos (CodigoEsta,Orde,Nombre) VALUES (" & CodigoEsta & ",3,'Ni&ntilde;os 7-12')"
			base.execute cs
						'Buscar la id del colectivo
			cs="SELECT MAX(CodigoColec) AS Ulti FROM Colectivos"
			rs.open cs,base
			if not rs.eof then
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'en','Colectivos','Nombre','Children 7-12'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & rs("ulti") & ",'de','Colectivos','Nombre','Kinder 7-12'," & codigoesta & ")"
				base.execute cs

			end if
			rs.close			

			if con_cms then 'añadir una seccion por defecto
				cs="INSERT INTO " & precrs & "SeccionesHotel (CodigoEsta,Seccion,Orden) VALUES (" & codigoesta & ",'Descripci&oacute;n',0)"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
				
				'Busxcar la ultima Id
				cs="SELECT MAX(Id) as Ulti FROM " & precrs & "SeccionesHotel"
				rs.open cs,base
				if not rs.eof then laulti=paClng(rs("ulti"))
				rs.close
			
				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & laulti & ",'en','SeccionesHotel','Seccion','Description'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & laulti & ",'de','SeccionesHotel','Seccion','Beschreibung'," & codigoesta & ")"
				base.execute cs

				cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
				cs=cs & laulti & ",'fr','SeccionesHotel','Seccion','Description'," & codigoesta & ")"
				base.execute cs
			
			end if 'con_cms
			
			'Si es un usuario dar de alta los permisos para ese hotel
			if not esAdmin then 
				cs="INSERT INTO " & precrs & "PermisosPorEsta (IdUsuario,CodigoEsta) VALUES ("
				cs=cs & request.Cookies("IdCR") & "," & codigoesta & ")"
				base.execute cs			
				controlRegistro(cs) 'guarda seguimiento
				response.Cookies("hotelboss")=request.Cookies("hotelboss") & ";" & codigoesta 'para la lista hoteles del usuario
			end if
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
			pasalir=1
			
		case "actu"
			'on error resume next
			base.BeginTrans
			
			'Actualizar fichero establecimientos
			cs="UPDATE " & precrs & "Establecimientos SET "
			cs=cs & "Nombre='" & nhotel & "',"
			cs=cs & "Orde=" & orden & ","
			cs=cs & "DiasAnulacion=" & diasanul & ","
			cs=cs & "Porciento=" & prepago & ","
			cs=cs & "Moneda=" & moneda & ","
			cs=cs & "Estado=" & estado & ","
			cs=cs & "Obs='" & obs & "' "
			cs=cs & "WHERE CodigoEsta=" & MiID
			'response.write cs
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			'Actualizar en datos hotel
			cs="UPDATE " & precrs & "DatosHotel SET email='" & email & "',"
			cs=cs & "direccion='" & dire & "',"
			cs=cs & "cp='" & cp& "',"
			cs=cs & "poblacion='" & pobla & "',"
			cs=cs & "telefono='" & tele & "',"
			cs=cs & "fax='" & fax & "',"
			cs=cs & "aviso=" & aviso & ","
			cs=cs & "desde=" & desde & ","
			cs=cs & "porHabPer=" & porHabPer & ","
			cs=cs & "TipoAlojamiento=" & tipohotel & ","
			cs=cs & "Categoria=" & categoria & ","
			cs=cs & "zona=" & zona & ","
			if filefoto then 'ha cambiado
				cs=cs & "Foto='" & foto & "',"
			end if 'filefoto
			cs=cs & "URL='" & web & "' "
			cs=cs & "WHERE CodigoEsta=" & MiId
			'response.write "cs=" & cs
			'response.write "id=" & request.QueryString("id")
			'response.end()
			base.execute cs
			controlRegistro(cs) 'guarda seguimiento
			
			if err.number<>0 then base.RollBackTrans
			base.CommitTrans
			on error goto 0
			
			if not con_cms or miNivel>=TComercial then pasalir=1

	end select

end if 'modo<>""
%>