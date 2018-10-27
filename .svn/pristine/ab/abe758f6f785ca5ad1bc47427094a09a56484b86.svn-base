CREATE INDEX IndiIDColec ON Colectivos (CodigoEsta);
CREATE INDEX CONDICIONESHOTEL_CodigoEsta ON CONDICIONESHOTEL (CodigoEsta);
CREATE INDEX CUPOS_CODIGOHAB ON CUPOS (CodigoHab);
CREATE INDEX CUPOS_Dia ON CUPOS (dia);
CREATE INDEX DATOSHOTEL_CodigoEsta ON DATOSHOTEL (CodigoEsta);
CREATE INDEX DESCUENTOSCOLECTIVOS_CODIGOCOLEC ON DescuentosColectivos (CodigoColec);
CREATE INDEX DESCUENTOSCOLECTIVOS_Hab ON DescuentosColectivos (TipoHab);
CREATE INDEX DESCUENTOSCOLECTIVOS_Tempo ON DescuentosColectivos (Temporada);
CREATE INDEX EXTRAS_CodigoEsta ON EXTRAS (CodigoEsta);
CREATE INDEX EXTRAS_Fechas ON EXTRAS (FInicio,FFinal);
CREATE INDEX FICHAS_CODRESERVA ON FICHAS (Id);
CREATE INDEX FICHAS_VIP ON FICHAS (CodigoVIP);
CREATE INDEX OFERTAS_CodigoEsta ON Ofertas (CodigoEsta);
CREATE INDEX OFERTAS_Fechas ON Ofertas (FechaInicio,FechaFin);
CREATE INDEX OFERTAS_Promo ON Ofertas (CodigoPromocion);
CREATE INDEX OFERVIP_Fechas ON OfertasVIP (FechaInicio,FechaFin);
CREATE INDEX OFERVIP_Promo ON OfertasVIP (CodigoPromocion);
CREATE INDEX Visitas_reserva ON VisitasVIP (CodReserva);
CREATE INDEX Visitas_ficha ON VisitasVIP (IdFicha);
CREATE INDEX Visitas_hotel ON VisitasVIP (CodigoEsta);
CREATE INDEX PERMISOSPORESTA_CodigoEsta ON PERMISOSPORESTA (IdUsuario);
CREATE INDEX REGIMENHOTEL_IdRegimen ON REGIMENHOTEL (IdRegimen);
CREATE INDEX REGIMENHOTEL_CodigoEsta ON REGIMENHOTEL (CodigoEsta);
CREATE INDEX REGIMENHOTEL_CODIGOHAB ON REGIMENHOTEL (CODIGOHAB);
CREATE INDEX REGIMENHOTEL_CODIGOTEMPO ON REGIMENHOTEL (CODIGOTEMPO);
CREATE INDEX REGIMENDTOS_RegiHotel ON REGIMENDTOS (IdRegimenHotel);
CREATE INDEX REGISTRO_CodigoEsta ON REGISTRO (CodigoEsta);
CREATE INDEX REGISTRO_User ON REGISTRO (IdUsuario);
CREATE INDEX REGISTRO_Fecha ON REGISTRO (Fecha);
CREATE INDEX RESERVAS_CodigoEsta ON RESERVAS (CodigoEsta);
CREATE INDEX RESERVAS_FechaRes ON RESERVAS (FechaReserva);
CREATE INDEX RESERVAS_FechaIn ON RESERVAS (FechaIni,FechaFin);
CREATE INDEX RESERVAS_Cliente ON RESERVAS (IdCliente);
CREATE INDEX TEMPORADAS_CodigoEsta ON TEMPORADAS (CodigoEsta);
CREATE INDEX TEMPORADAS_Fechas ON TEMPORADAS (FInicio,FFinal);
CREATE INDEX TEMPORADASNomres_Id ON TemporadasNomres (TempIdi);
CREATE INDEX TIPOHABITANOMBRES_CodigoEsta ON TIPOHABITANOMBRES (CodigoEsta);
CREATE INDEX TIPOHABITANOMBRES_Habita ON TIPOHABITANOMBRES (TipoHabitacion);
CREATE INDEX TIPOHABITAPrecios_Habita ON TipoHabitaPrecios (IdHabita);
CREATE INDEX TIPOHABITAPrecios_Tempo ON TipoHabitaPrecios (Temporada);
CREATE INDEX TIPORESERVA_Res ON TIPORESERVA (IdReserva);
CREATE INDEX TIPORESERVA_Fechas ON TIPORESERVA (FechaInicio,FechaFinal);
CREATE INDEX FHabi ON FotosHabitacion (IdHabitacion);
CREATE INDEX HabiHotel ON HabitacionesHotel (CodigoEsta);
CREATE INDEX IdHabiHotel ON HabitacionesHotel (IdHabitacion);
CREATE INDEX PolMensaje ON ErrorEMails (IdMensaje);
CREATE INDEX PolCliente ON ErrorEMails (IdCliente);

ALTER TABLE Agencias ADD CONSTRAINT DF_Agencias_Activa DEFAULT 0 FOR Activa;
ALTER TABLE Categorias ADD CONSTRAINT DF_Categorias_IdTipo DEFAULT 0 FOR IdTipo;
ALTER TABLE Colectivos ADD CONSTRAINT DF_Colectivos_Orde DEFAULT 0 FOR Orde;
ALTER TABLE Cupos ADD CONSTRAINT DF_Cupos_Cupo DEFAULT 0 FOR Cupo;
ALTER TABLE Cupos ADD CONSTRAINT DF_Cupos_Precio DEFAULT 0 FOR Precio;
ALTER TABLE Cupos ADD CONSTRAINT DF_Cupos_DiasMinimos DEFAULT 1 FOR DiasMinimos;
ALTER TABLE Cupos ADD CONSTRAINT DF_Cupos_Release DEFAULT 0 FOR Release;
ALTER TABLE Cupos ADD CONSTRAINT DF_Cupos_Estado DEFAULT 2 FOR Estado;
ALTER TABLE Reservas ADD CONSTRAINT DF_Reservas_CodAgencia DEFAULT 0 FOR CodAgencia;
ALTER TABLE Reservas ADD CONSTRAINT DF_Reservas_TipoVentaAgencia DEFAULT 0 FOR TipoVentaAgencia;
ALTER TABLE Reservas ADD CONSTRAINT DF_Reservas_TipoVenta DEFAULT 0 FOR TipoVenta;
ALTER TABLE Reservas ADD CONSTRAINT DF_Reservas_IdCliente DEFAULT 0 FOR IdCliente;
ALTER TABLE Reservas ADD CONSTRAINT DF_Reservas_Activa DEFAULT 0 FOR Activa;




CREATE VIEW ConsultaHoteles AS SELECT Establecimientos.CodigoEsta,Establecimientos.Nombre, Establecimientos.Estado, DatosHotel.Poblacion, DatosHotel.Zona, DatosHotel.TipoAlojamiento, DatosHotel.Categoria, Establecimientos.Orde FROM Establecimientos INNER JOIN DatosHotel ON Establecimientos.CodigoEsta = DatosHotel.CodigoEsta;

CREATE VIEW Confirmadas AS SELECT TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal, COUNT(*) AS cuantas FROM TipoReserva INNER JOIN Reservas ON TipoReserva.IdReserva = Reservas.Cod_Res WHERE (Reservas.Activa <> 0) GROUP BY TipoReserva.CodigoEsta, TipoReserva.IdTipoHabitacion, TipoReserva.FechaInicio, TipoReserva.FechaFinal;

CREATE VIEW Disponibles AS SELECT TOP 100 PERCENT Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Dia, Cupos.Cupo, Cupos.Estado, SUM(Confirmadas.cuantas) AS Confirmadas FROM Cupos LEFT OUTER JOIN Confirmadas ON Cupos.CodigoHab = Confirmadas.IdTipoHabitacion AND Cupos.Dia >= Confirmadas.FechaInicio AND Cupos.Dia < Confirmadas.FechaFinal GROUP BY Cupos.Dia, Cupos.CodigoEsta, Cupos.CodigoHab, Cupos.Cupo, Cupos.Estado ORDER BY Cupos.Dia;

CREATE VIEW PrecioMinimo AS SELECT CodigoEsta, MIN(Precio) AS Minimo FROM Cupos WHERE (Dia BETWEEN { fn NOW() } AND { fn NOW() } + 60) GROUP BY CodigoEsta;

CREATE VIEW PrecioMejorDia AS SELECT TOP 100 PERCENT Cupos.Dia, Cupos.CodigoEsta, MIN(Cupos.Precio) AS Minimo FROM Cupos INNER JOIN Establecimientos ON Cupos.CodigoEsta = Establecimientos.CodigoEsta WHERE (Establecimientos.Estado <> 0) GROUP BY Cupos.Dia, Cupos.CodigoEsta ORDER BY Cupos.Dia, Minimo;

CREATE VIEW PrecioMinimoHabitacion AS SELECT CodigoEsta, CodigoHab, MIN(Precio) AS Minimo FROM Cupos WHERE (Dia BETWEEN { fn NOW() } AND { fn NOW() } + 60) GROUP BY CodigoEsta, CodigoHab;

