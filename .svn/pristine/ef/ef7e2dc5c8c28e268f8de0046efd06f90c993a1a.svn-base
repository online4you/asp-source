<%
cs="INSERT INTO " & precrs & "Tarifas (Nombre) VALUES ('General')"
basecs.execute cs
'traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'en','Tarifas','Nombre','General',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'de','Tarifas','Nombre','General',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'fr','Tarifas','Nombre','General',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'it','Tarifas','Nombre','General',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "TiposMoneda (Id,Nombre,CodigoISO,Orden,PorDefecto) VALUES (0,'Euro','EUR',0,1)"
basecs.execute cs
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (0,'en','TiposMoneda','Nombre','Euro',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (0,'de','TiposMoneda','Nombre','Euro',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (0,'fr','TiposMoneda','Nombre','Euro',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (0,'it','TiposMoneda','Nombre','Euro',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "TiposMoneda (Id,Nombre,CodigoISO,Orden,PorDefecto) VALUES (1,'Dolar','USD',1,0)"
basecs.execute cs
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'en','TiposMoneda','Nombre','Dolar',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'de','TiposMoneda','Nombre','Dolar',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'fr','TiposMoneda','Nombre','Dolar',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) "
cs=cs & "VALUES (1,'it','TiposMoneda','Nombre','Dolar',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "TipoAlojamiento (Nombre,IdTipo) VALUES ('Apartamentos',2)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoAlojamiento"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoAlojamiento','Nombre','Apartments',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoAlojamiento','Nombre','Ferienwohnung',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoAlojamiento','Nombre','Appartements',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoAlojamiento','Nombre','Appartamenti',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "TipoAlojamiento (Nombre,IdTipo) VALUES ('Aparthotel',2)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoAlojamiento"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoAlojamiento','Nombre','Aparthotel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoAlojamiento','Nombre','Aparthotel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoAlojamiento','Nombre','Aparthôtel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoAlojamiento','Nombre','Aparthotel',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "TipoAlojamiento (Nombre,IdTipo) VALUES ('Agroturismo',0)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoAlojamiento"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoAlojamiento','Nombre','Rural Tourism',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoAlojamiento','Nombre','Agrotourismus',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoAlojamiento','Nombre','Agroturismo',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoAlojamiento','Nombre','Agriturismo',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "TipoAlojamiento (Nombre,IdTipo) VALUES ('Hostal',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoAlojamiento"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoAlojamiento','Nombre','Hostel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoAlojamiento','Nombre','Gasthäuser',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoAlojamiento','Nombre','Hostal',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoAlojamiento','Nombre','Pensioni',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "TipoAlojamiento (Nombre,IdTipo) VALUES ('Hotel',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoAlojamiento"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoAlojamiento','Nombre','Hotel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoAlojamiento','Nombre','Hotel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoAlojamiento','Nombre','Hôtel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoAlojamiento','Nombre','Hotel',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('1 Estrella',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','1 Star',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','1 Sterne',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','1 Estrella',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','1 Estrella',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('2 Estrellas',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','2 Stars',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','2 Sterne',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','2 Estrellas',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','2 Estrellas',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('3 Estrellas',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','3 Stars',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','3 Sterne',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','3 Estrellas',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','3 Estrellas',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('4 Estrellas',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','4 Stars',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','4 Sterne',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','4 Estrellas',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','4 Estrellas',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('5 Estrellas',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','5 Stars',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','5 Sterne',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','5 Estrellas',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','5 Estrellas',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('1 Llave',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','1 Key',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','1 Schlüssel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','1 Llave',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','1 Llave',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('2 Llaves',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','2 Keys',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','2 Schlüssel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','2 Llaves',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','2 Llaves',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Categorias (Nombre,IdTipo) VALUES ('3 Llaves',1)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Categorias"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Categorias','Nombre','3 Keys',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Categorias','Nombre','3 Schlüssel',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Categorias','Nombre','3 Llaves',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Categorias','Nombre','3 Llaves',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "Regimen (Nombre) VALUES ('Sólo alojamiento')"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Regimen"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Regimen','Nombre','Room only',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Regimen','Nombre','Nur Unterkunft',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Regimen','Nombre','Seulement Logement',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Regimen','Nombre','Solo aloggio',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "Regimen (Nombre) VALUES ('Alojamiento y desayuno')"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Regimen"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Regimen','Nombre','Bed and breackfast',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Regimen','Nombre','Übernachtung mit Frühstück',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Regimen','Nombre','Logement avec petit déjeuner',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Regimen','Nombre','Aloggio con calazione',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "Regimen (Nombre) VALUES ('Media pensión')"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Regimen"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Regimen','Nombre','Half-board',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Regimen','Nombre','Halbpension',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Regimen','Nombre','Demie-pension',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Regimen','Nombre','Mezza pensione',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Regimen (Nombre) VALUES ('Pensión completa')"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Regimen"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Regimen','Nombre','Fullboard',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Regimen','Nombre','Vollpension',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Regimen','Nombre','Pension complete',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Regimen','Nombre','Pensione completa',0)"
basecs.execute cs

cs="INSERT INTO " & precrs & "Regimen (Nombre) VALUES ('Todo incluido')"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "Regimen"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','Regimen','Nombre','All Iinclusive',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','Regimen','Nombre','Alles Inklusive',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','Regimen','Nombre','Tout inclus',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','Regimen','Nombre','All Iinclusive',0)"
basecs.execute cs


cs="INSERT INTO " & precrs & "TipoHabita (Nombre,ParaCapMax,ParaCapMin,ParaAdultMax,"
cs=cs & "ParaNiMax,ParaCapNormal,Orden,ParaAdultMin) VALUES ('Habitación Doble',2,2,2,1,2,0,2)"
basecs.execute cs
cs="SELECT MAX(Id) as Ulti FROM " & precrs & "TipoHabita"
rs.open cs,basecs
laid=0
if not rs.eof then
	laid=paClng(rs("ulti"))
end if
rs.close
'Traducciones
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'en','TipoHabita','Nombre','Double Room',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'de','TipoHabita','Nombre','Doppelzimmer',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'fr','TipoHabita','Nombre','Chambre Double',0)"
basecs.execute cs
cs="INSERT INTO " & precrs & "Traducciones (IdReferencia,Idioma,Tabla,Campo,Traduccion,CodigoEsta) VALUES ("
cs=cs & laid & ",'it','TipoHabita','Nombre','Double Room',0)"
basecs.execute cs

%>