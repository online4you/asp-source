<%
	'aqui solo llega si se envia la variable (dtos=si)

	modo=request.QueryString("modo")
	MiId=request.form("id")
	
	select case modo 
		case "borra" 'Borrar dtos marcados
			queborro=split(request.form("dtoborrar"),",")
			if ubound(queborro)>=0 then
				cs="DELETE FROM " & precrs & "DescuentosColectivos WHERE "
				for t=0 to ubound(queborro)
					'Buscar los datos
					valores=split(queborro(t),"-")
					'Formato (habi-colec-tempo)
					cs=cs & "(TipoHab=" & valores(0) & " AND CodigoColec=" & valores(1)
					cs=cs & " AND Temporada=" & valores(2) & ") OR "
				next
				if right(cs,4)=" OR " then 'Quitar el ultimo operador
					cs=left(cs,len(cs)-4)
				end if	
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "nuevo" 'Añadir
			'Añadir en DescuentosColectivos
			tempo=request.form("temporadadto")
			colec=request.form("colectivodto")
			dto=request.form("dtodto")
			precio=request.form("preciodto")
			
			'Comprobar que no exista en la tabla
			cs="SELECT TipoHab FROM " & precrs & "DescuentosColectivos "
			cs=cs & "WHERE TipoHab=" & MiId & " AND Temporada=" & tempo & " AND CodigoColec=" & colec
			cs=cs & " AND Anyo=" & anyo
			rs.open cs,base
			if not rs.eof then 'Ya existe
				rs.close
				set rs=nothing
				base.close
				set base=nothing
				response.write "<html><body><h2>Ese dto ya existe, modifíquelo y pulse actualizar tabla</h2>" & vbcrlf
				response.write "<input type='button' value='Volver' onclick='javascript:window.history.back();'>" & vbcrlf
				response.write "</body></html>"
				response.End()
			else
				rs.close
				cs="INSERT INTO " & precrs & "DescuentosColectivos (TipoHab,Temporada,CodigoColec,PreBase,Precio,Anyo) "
				cs=cs & "VALUES ("
				cs=cs & MiId & "," & tempo & "," & colec & "," & QuitarComa(dto) & ","
				cs=cs & QuitarComa(precio) & "," & anyo & ")"
				base.execute cs
				controlRegistro(cs) 'guarda seguimiento
			end if
			
		case "actu"

			'Buscar la lista de ids de descuentoscolectivos
			cs="SELECT CodigoColec,Temporada FROM " & precrs & "DescuentosColectivos WHERE TipoHab=" & MiId
			cs=cs & " AND Anyo=" & anyo
			rs.open cs,base
			hayregis=false
			if not rs.eof then
				RegIds=rs.getrows
				MiColec=0
				MiTempo=1
				hayregis=true
			end if
			rs.close
		
			if hayregis then 'Actualizar todos los registros
				for r=0 to ubound(RegIds,2)
					'Formato (habi-colec-tempo)
					tempo=request.form("temporada-" & MiId & "-" & RegIds(MiColec,r) & "-" & RegIds(MiTempo,r))
					colec=request.form("colectivo-" & MiId & "-" & RegIds(MiColec,r) & "-" & RegIds(MiTempo,r))
					dto=request.form("dto-" & MiId & "-" & RegIds(MiColec,r) & "-" & RegIds(MiTempo,r))
					precio=request.form("precio-" & MiId & "-" & RegIds(MiColec,r) & "-" & RegIds(MiTempo,r))
					cs="UPDATE " & precrs & "DescuentosColectivos SET "
					cs=cs & "CodigoColec=" & colec & ","
					cs=cs & "Temporada=" & Tempo & ","
					cs=cs & "PreBase=" & QuitarComa(dto) & ","
					cs=cs & "Precio=" & QuitarComa(precio) & " "
					cs=cs & "WHERE TipoHab=" & MiId & " AND CodigoColec=" & RegIds(MiColec,r) & " AND Temporada=" & RegIds(MiTempo,r) & " AND Anyo=" & anyo
					'response.write cs
					base.execute cs
					controlRegistro(cs) 'guarda seguimiento
				next	
			end if
			
	end select
			
%>