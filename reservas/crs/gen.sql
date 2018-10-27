# --------------------------------------------------------
# Host:                         lldf444.servidoresdns.net
# Database:                     qgq826
# Server version:               5.0.77
# Server OS:                    redhat-linux-gnu
# HeidiSQL version:             5.0.0.3272
# Date/time:                    2010-09-28 17:53:06
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
# Dumping database structure for qgq826
CREATE DATABASE IF NOT EXISTS `qgq826` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `qgq826`;


# Dumping structure for table qgq826.jos_crsgen_aplicaciones
DROP TABLE IF EXISTS `jos_crsgen_aplicaciones`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_aplicaciones` (
  `id` int(11) NOT NULL auto_increment,
  `IdModulo` int(11) NOT NULL,
  `NombreBoton` varchar(25) collate latin1_spanish_ci NOT NULL,
  `programa` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Descripcion` text collate latin1_spanish_ci NOT NULL,
  `Ayuda` text collate latin1_spanish_ci NOT NULL,
  `Orden` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_aplicaciones: 15 rows
/*!40000 ALTER TABLE `jos_crsgen_aplicaciones` DISABLE KEYS */;
INSERT INTO `jos_crsgen_aplicaciones` (`id`, `IdModulo`, `NombreBoton`, `programa`, `Descripcion`, `Ayuda`, `Orden`) VALUES (1, 1, 'Tipo Alojamientos', 'TiposHotel.asp', 'Diferentes tipos de alojamiento, hoteles, apartamentos, hostales, etc., ', '', 0), (3, 1, 'CategorÃ­as', 'categorias.asp', 'CategorÃ­as de los alojamientos. ', '', 1), (4, 1, 'Zonas', 'zonas.asp', 'Zonas de los alojamientos', '', 2), (5, 1, 'Tipos HabitaciÃ³n', 'tiposHabitacion.asp', 'Tipos estandar de habitaciones, normalmente una vez creado no se toca.', '', 3), (6, 1, 'RegÃ©menes', 'regimen.asp', 'RÃ©gimenes normales de los alojamientos, en la secciÃ³n de tarifas habitaciÃ³n se indica los que se usan.', '', 4), (7, 1, 'Alojamientos', 'alojamientos.asp', 'Datos del hotel y el estado que tiene (online, request)', '', 5), (8, 1, 'Temporadas', 'temporadas.asp', 'Fechas de las temporadas por año.', '', 6), (9, 1, 'Colectivos', 'colectivos.asp', 'Colectivos de personas segun hotel, adultos, niños, etc,.', '', 7), (10, 1, 'Tarifas HabitaciÃ³n', 'habitaciones.asp', 'Precios, capacidad, regÃ­menes y descuentos por habitaciÃ³n', '', 8), (11, 1, 'Listado Reservas', 'listaReservas.asp', 'Listado de todas las reservas, confirmadas y NO confirmadas or hotel.', '', 10), (12, 1, 'EstadÃ­sticas', 'estadisticasMes.asp', 'EstadÃ­sticas por fecha reserva, fecha estancia, precios o habitaciones, de todo el aÃ±o o por mes.', '', 11), (13, 4, 'Usuarios', 'usuariosF.asp', 'Panel de control de usuarios de la Web.', '', 0), (16, 13, 'Servic. Extras', 'servicios/servicios.asp', 'Servicios complementarios al alojamiento', '', 0), (18, 15, 'Paquetes turisticos', 'packs/packs.asp', '', '', 0), (19, 18, 'Reservas OR', 'babeloo_OR/reservasOR.asp', '', '', 0);
/*!40000 ALTER TABLE `jos_crsgen_aplicaciones` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_condicionesempresa
DROP TABLE IF EXISTS `jos_crsgen_condicionesempresa`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_condicionesempresa` (
  `Id` int(11) NOT NULL auto_increment,
  `IdEmpresa` int(11) NOT NULL,
  `Texto` text collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_condicionesempresa: 2 rows
/*!40000 ALTER TABLE `jos_crsgen_condicionesempresa` DISABLE KEYS */;
INSERT INTO `jos_crsgen_condicionesempresa` (`Id`, `IdEmpresa`, `Texto`) VALUES (11, 80, '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la p&aacute;gina, el nombre de dominio, su c&oacute;digo fuente, dise&ntilde;o y estructura de navegaci&oacute;n en &eacute;l contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotaci&oacute;n de los mismos en cualquier forma, y, en especial los derechos de reproducci&oacute;n, distribuci&oacute;n, comunicaci&oacute;n p&uacute;blica y transformaci&oacute;n.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformaci&oacute;n, modificaci&oacute;n o alteraci&oacute;n contra ella que suponga un perjuicio a sus intereses leg&iacute;timos o menoscabo de su reputaci&oacute;n. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la informaci&oacute;n de la presente p&aacute;gina sin autorizaci&oacute;n por escrito de su titular.</p>'), (12, 73, '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la página, el nombre de dominio, su código fuente, diseño y estructura de navegación en él contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotación de los mismos en cualquier forma, y, en especial los derechos de reproducción, distribución, comunicación pública y transformación.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformación, modificación o alteración contra ella que suponga un perjuicio a sus intereses legítimos o menoscabo de su reputación. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la información de la presente página sin autorización por escrito de su titular.</p>');
/*!40000 ALTER TABLE `jos_crsgen_condicionesempresa` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_empresas
DROP TABLE IF EXISTS `jos_crsgen_empresas`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_empresas` (
  `Id` int(11) NOT NULL auto_increment,
  `Nombre` varchar(75) collate latin1_spanish_ci NOT NULL,
  `ConexionBD` varchar(75) collate latin1_spanish_ci NOT NULL,
  `NombreBD` varchar(75) collate latin1_spanish_ci NOT NULL,
  `UserBD` varchar(25) collate latin1_spanish_ci NOT NULL,
  `PwdBD` varchar(25) collate latin1_spanish_ci NOT NULL,
  `HojaEstilos` varchar(50) collate latin1_spanish_ci NOT NULL,
  `MetaTitulo` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Modulos` varchar(100) collate latin1_spanish_ci NOT NULL,
  `RutaFotos` varchar(75) collate latin1_spanish_ci NOT NULL,
  `RutaDocu` varchar(75) collate latin1_spanish_ci NOT NULL,
  `MySQL` varchar(1) collate latin1_spanish_ci NOT NULL,
  `SMTPServer` varchar(75) collate latin1_spanish_ci NOT NULL,
  `LoginCuenta` varchar(75) collate latin1_spanish_ci NOT NULL,
  `PWDCuenta` varchar(75) collate latin1_spanish_ci NOT NULL,
  `RemiteCuenta` varchar(75) collate latin1_spanish_ci NOT NULL,
  `MultiTarifa` bit(1) NOT NULL,
  `Idiomas` varchar(100) collate latin1_spanish_ci NOT NULL,
  `CMS` bit(1) NOT NULL,
  `GoogleMaps` bit(1) NOT NULL,
  `xDefaultMaps` double NOT NULL,
  `yDefaultMaps` double NOT NULL,
  `zoomDefaultMaps` bigint(20) NOT NULL,
  `CharSet` varchar(15) collate latin1_spanish_ci NOT NULL,
  `repiteMail` bit(1) NOT NULL,
  `AdmiteNinos` bit(1) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_empresas: 1 rows
/*!40000 ALTER TABLE `jos_crsgen_empresas` DISABLE KEYS */;
INSERT INTO `jos_crsgen_empresas` (`Id`, `Nombre`, `ConexionBD`, `NombreBD`, `UserBD`, `PwdBD`, `HojaEstilos`, `MetaTitulo`, `Modulos`, `RutaFotos`, `RutaDocu`, `MySQL`, `SMTPServer`, `LoginCuenta`, `PWDCuenta`, `RemiteCuenta`, `MultiTarifa`, `Idiomas`, `CMS`, `GoogleMaps`, `xDefaultMaps`, `yDefaultMaps`, `zoomDefaultMaps`, `CharSet`, `repiteMail`, `AdmiteNinos`) VALUES (98, 'Hotel Hoteles', 'lldf444.servidoresdns.net', 'qgq828', 'qgq828', 'Willy7612', '', 'Hotel Hoteles', ' 4, 1, 13, 2,', '/fotos/Hotel-Hoteles/', '/fotos/Hotel-Hoteles/', '1', '', '', '', '', '', 'es, en, de,', '', '', 39.661742, 2.949829, 9, 'ISO-8859-1', '', '');
/*!40000 ALTER TABLE `jos_crsgen_empresas` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_modulos
DROP TABLE IF EXISTS `jos_crsgen_modulos`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_modulos` (
  `Id` int(11) NOT NULL auto_increment,
  `Modulo` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Modulo_it` varchar(50) collate latin1_spanish_ci default NULL,
  `Modulo_en` varchar(50) collate latin1_spanish_ci default NULL,
  `Modulo_de` varchar(50) collate latin1_spanish_ci default NULL,
  `Modulo_fr` varchar(50) collate latin1_spanish_ci default NULL,
  `Modulo_bg` varchar(50) collate latin1_spanish_ci default NULL,
  `Modulo_pt` varchar(50) collate latin1_spanish_ci default NULL,
  `Descripcion` text collate latin1_spanish_ci,
  `Descripcion_it` text collate latin1_spanish_ci,
  `Descripcion_en` text collate latin1_spanish_ci,
  `Descripcion_de` text collate latin1_spanish_ci,
  `Descripcion_fr` text collate latin1_spanish_ci,
  `Descripcion_bg` text collate latin1_spanish_ci,
  `Descripcion_pt` text collate latin1_spanish_ci,
  `Programa` text collate latin1_spanish_ci,
  `Orden` int(11) NOT NULL,
  `Menu` bit(1) NOT NULL,
  `ModuloSuperior` int(11) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_modulos: 13 rows
/*!40000 ALTER TABLE `jos_crsgen_modulos` DISABLE KEYS */;
INSERT INTO `jos_crsgen_modulos` (`Id`, `Modulo`, `Modulo_it`, `Modulo_en`, `Modulo_de`, `Modulo_fr`, `Modulo_bg`, `Modulo_pt`, `Descripcion`, `Descripcion_it`, `Descripcion_en`, `Descripcion_de`, `Descripcion_fr`, `Descripcion_bg`, `Descripcion_pt`, `Programa`, `Orden`, `Menu`, `ModuloSuperior`) VALUES (1, 'Gestión Hoteles', 'Gestión Hoteles', 'Hotels Management', 'Gestión Hoteles', 'Gestión Hoteles', 'GestiÃ³n Hoteles', 'Gestão hoteleira', 'Modulo básico de la central de reservas', NULL, NULL, NULL, NULL, NULL, NULL, 'cr.asp', 2, '', 0), (2, 'Recepcionista Virtual', 'Recepcionista Virtual', 'Recepcionista Virtual', 'Recepcionista Virtual', 'Recepcionista Virtual', 'Recepcionista Virtual', 'Recepcionista Virtual', 'EMarketing del fichero de clientes', NULL, NULL, NULL, NULL, NULL, NULL, 'rvirtual/rvirtual.asp', 4, '', 0), (4, 'Gestión Usuarios', 'Gestión Usuarios', 'Users Management', 'Gestión Usuarios', 'Gestión Usuarios', 'GestiÃ³n Usuarios', 'Gestão usuários', '', NULL, NULL, NULL, NULL, NULL, NULL, 'usuariosF.asp', 0, '', 0), (7, 'Registro de Accesos', 'Registro de Accesos', 'Historic Updates', 'Registro de Accesos', 'Registro de Accesos', 'Registro de Accesos', 'Registro de Accesos', 'operaciones realizadas por los usuarios', NULL, NULL, NULL, NULL, NULL, NULL, 'registro.asp', 1, '', 0), (8, 'Fidelización Clientes VIP', 'Fidelización Clientes VIP', 'VIP Data', 'Fidelización Clientes VIP', 'Fidelización Clientes VIP', 'FidelizaciÃ³n Clientes VIP', 'Fidelización Clientes VIP', 'Clientes fidelizados, ofertas y registro estancias', NULL, NULL, NULL, NULL, NULL, NULL, 'VIP/vip.asp', 3, '', 0), (10, 'Gestión Idiomas', 'Gestión Idiomas', 'Gestión Idiomas', 'Gestión Idiomas', 'Gestión Idiomas', 'GestiÃ³n Idiomas', 'Gestión Idiomas', 'Traducciones del administrador', NULL, NULL, NULL, NULL, NULL, NULL, 'Idiomas/traducciones.asp', 0, '', 0), (11, 'Gestión Agencias', 'GestiÃ³n Agencias', 'GestiÃ³n Agencias', 'GestiÃ³n Agencias', 'GestiÃ³n Agencias', 'GestiÃ³n Agencias', 'Gestión Agencias', 'agencias como clientes', NULL, NULL, NULL, NULL, NULL, NULL, 'agencias/agencias.asp', 6, '', 0), (13, 'Servicios Extras', 'Servicios Extras', 'Servicios Extras', 'Servicios Extras', 'Servicios Extras', 'Servicios Extras', 'Servicios Extras', 'Servicios complementarios al alojamiento.', 'Servicios complementarios al alojamiento.', 'Servicios complementarios al alojamiento.', 'Servicios complementarios al alojamiento.', 'Servicios complementarios al alojamiento.', NULL, NULL, 'servicios/servicios.asp', 3, '', 1), (14, 'Gestión Castelldefels', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, 'castelldefels/castelldefels.asp', 0, '', 0), (15, 'Paquetes turísticos', NULL, NULL, NULL, NULL, NULL, NULL, 'Gestión para montar paquetes turísticos', NULL, NULL, NULL, NULL, NULL, NULL, 'packs/packs.asp', 4, '', 1), (16, 'Intertur Amigos', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, 'InterturAmigos/vip.asp', 3, '', 0), (17, 'Front Web', 'Front Web', 'Front Web', 'Front Web', 'Front Web', 'Front Web', 'Front Web', 'Menus y contenidos de la web', NULL, NULL, NULL, NULL, NULL, NULL, 'frontWeb/frontWeb.asp', 6, '', 0), (18, 'Reservas OR Babeloo', NULL, NULL, NULL, NULL, NULL, NULL, 'Control de confirmacion de reservas y cobro por tpv', NULL, NULL, NULL, NULL, NULL, NULL, 'babeloo_OR/reservasOR.asp', 0, '', 1);
/*!40000 ALTER TABLE `jos_crsgen_modulos` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_permisosporesta
DROP TABLE IF EXISTS `jos_crsgen_permisosporesta`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_permisosporesta` (
  `CodigoEsta` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_permisosporesta: 0 rows
/*!40000 ALTER TABLE `jos_crsgen_permisosporesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crsgen_permisosporesta` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_sizegraficos
DROP TABLE IF EXISTS `jos_crsgen_sizegraficos`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_sizegraficos` (
  `Id` int(11) NOT NULL auto_increment,
  `IdEmpresa` int(11) NOT NULL,
  `Ancho` int(11) NOT NULL,
  `Alto` int(11) NOT NULL,
  `Prefijo` varchar(15) collate latin1_spanish_ci NOT NULL,
  `ProporcionAncho` bit(1) NOT NULL,
  `ProporcionAlto` bit(1) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_sizegraficos: 0 rows
/*!40000 ALTER TABLE `jos_crsgen_sizegraficos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crsgen_sizegraficos` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_tablaaccesos
DROP TABLE IF EXISTS `jos_crsgen_tablaaccesos`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_tablaaccesos` (
  `IdUsuario` int(11) NOT NULL,
  `Modulo` int(11) NOT NULL,
  `Aplicacion` int(11) NOT NULL,
  `Ver` bit(1) NOT NULL,
  `Modificar` bit(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_tablaaccesos: 0 rows
/*!40000 ALTER TABLE `jos_crsgen_tablaaccesos` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crsgen_tablaaccesos` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_tbl_paises
DROP TABLE IF EXISTS `jos_crsgen_tbl_paises`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_tbl_paises` (
  `IdCountry` varchar(2) collate latin1_spanish_ci NOT NULL,
  `IdLanguage` varchar(2) collate latin1_spanish_ci NOT NULL,
  `CountryName` varchar(100) collate latin1_spanish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_tbl_paises: 492 rows
/*!40000 ALTER TABLE `jos_crsgen_tbl_paises` DISABLE KEYS */;
INSERT INTO `jos_crsgen_tbl_paises` (`IdCountry`, `IdLanguage`, `CountryName`) VALUES ('ad', 'en', 'Andorra'), ('ad', 'es', 'Andorra'), ('ae', 'en', 'United Arab Emirates'), ('ae', 'es', 'Emiratos Árabes Unidos'), ('af', 'en', 'Afghanistan'), ('af', 'es', 'Afghanistán'), ('ag', 'en', 'Antigua and Barbuda'), ('ag', 'es', 'Antigua y Barbuda'), ('ai', 'en', 'Anguilla'), ('ai', 'es', 'Anguilla'), ('al', 'en', 'Albania'), ('al', 'es', 'Albania'), ('am', 'en', 'Armenia'), ('am', 'es', 'Armenia'), ('an', 'en', 'Netherlands Antilles'), ('an', 'es', 'Antillas Holandesas'), ('ao', 'en', 'Angola'), ('ao', 'es', 'Angola'), ('aq', 'en', 'Antarctica'), ('aq', 'es', 'Antárctida'), ('ar', 'en', 'Argentina'), ('ar', 'es', 'Argentina'), ('as', 'en', 'American Samoa'), ('as', 'es', 'Samoa Americana'), ('at', 'en', 'Austria'), ('at', 'es', 'Austria'), ('au', 'en', 'Australia'), ('au', 'es', 'Australia'), ('aw', 'en', 'Aruba'), ('aw', 'es', 'Aruba'), ('ax', 'en', 'Åland Islands'), ('ax', 'es', 'Islas Åland'), ('az', 'en', 'Azerbaijan'), ('az', 'es', 'Azerbayán'), ('ba', 'en', 'Bosnia and Herzegovina'), ('ba', 'es', 'Bosnia y Herzegovina'), ('bb', 'en', 'Barbados'), ('bb', 'es', 'Barbados'), ('bd', 'en', 'Bangladesh'), ('bd', 'es', 'Bangladesh'), ('be', 'en', 'Belgium'), ('be', 'es', 'Bélgica'), ('bf', 'en', 'Burkina Faso'), ('bf', 'es', 'Burkina Faso'), ('bg', 'en', 'Bulgaria'), ('bg', 'es', 'Bulgaria'), ('bh', 'en', 'Bahrain'), ('bh', 'es', 'Bahréin'), ('bi', 'en', 'Burundi'), ('bi', 'es', 'Burundi'), ('bj', 'en', 'Benin'), ('bj', 'es', 'Benín'), ('bl', 'en', 'Saint Barthélemy'), ('bl', 'es', 'San Bartolomé'), ('bm', 'en', 'Bermuda'), ('bm', 'es', 'Bermudas'), ('bn', 'en', 'Brunei Darussalam'), ('bn', 'es', 'Brunéi'), ('bo', 'en', 'Bolivia'), ('bo', 'es', 'Bolivia'), ('br', 'en', 'Brazil'), ('br', 'es', 'Brasil'), ('bs', 'en', 'Bahamas'), ('bs', 'es', 'Bahamas'), ('bt', 'en', 'Bhutan'), ('bt', 'es', 'Bután'), ('bv', 'en', 'Bouvet Island'), ('bv', 'es', 'Isla Bouvet'), ('bw', 'en', 'Botswana'), ('bw', 'es', 'Botsuana'), ('by', 'en', 'Belarus'), ('by', 'es', 'Bielorrusia'), ('bz', 'en', 'Belize'), ('bz', 'es', 'Belice'), ('ca', 'en', 'Canada'), ('ca', 'es', 'Canadá'), ('cc', 'en', 'Cocos (Keeling) Islands'), ('cc', 'es', 'Islas Cocos'), ('cd', 'en', 'Congo, Democratic Republic of the'), ('cd', 'es', 'Congo, República Democrática del'), ('cf', 'en', 'Central African Republic'), ('cf', 'es', 'República Centro Africana'), ('cg', 'en', 'Congo'), ('cg', 'es', 'Congo'), ('ch', 'en', 'Switzerland'), ('ch', 'es', 'Suiza'), ('ci', 'en', 'Côte d\'Ivoire'), ('ci', 'es', 'Costa de Marfil'), ('ck', 'en', 'Cook Islands'), ('ck', 'es', 'Islas Cook'), ('cl', 'en', 'Chile'), ('cl', 'es', 'Chile'), ('cm', 'en', 'Cameroon'), ('cm', 'es', 'Camerún'), ('cn', 'en', 'China'), ('cn', 'es', 'China'), ('co', 'en', 'Colombia'), ('co', 'es', 'Colombia'), ('cr', 'en', 'Costa Rica'), ('cr', 'es', 'Costa Rica'), ('cu', 'en', 'Cuba'), ('cu', 'es', 'Cuba'), ('cv', 'en', 'Cape Verde'), ('cv', 'es', 'Cabo Verde'), ('cx', 'en', 'Christmas Island'), ('cx', 'es', 'Isla de Pascua'), ('cy', 'en', 'Cyprus'), ('cy', 'es', 'Chipre'), ('cz', 'en', 'Czech Republic'), ('cz', 'es', 'República Checa'), ('de', 'en', 'Germany'), ('de', 'es', 'Alemania'), ('dj', 'en', 'Djibouti'), ('dj', 'es', 'Djibouti'), ('dk', 'en', 'Denmark'), ('dk', 'es', 'Dinamarca'), ('dm', 'en', 'Dominica'), ('dm', 'es', 'Dominica'), ('do', 'en', 'Dominican Republic'), ('do', 'es', 'República Dominicana'), ('dz', 'en', 'Algeria'), ('dz', 'es', 'Algeria'), ('ec', 'en', 'Ecuador'), ('ec', 'es', 'Ecuador'), ('ee', 'en', 'Estonia'), ('ee', 'es', 'Estonia'), ('eg', 'en', 'Egypt'), ('eg', 'es', 'Egipto'), ('eh', 'en', 'Western Sahara'), ('eh', 'es', 'Sáhara Occidental'), ('er', 'en', 'Eritrea'), ('er', 'es', 'Eritrea'), ('es', 'en', 'Spain'), ('es', 'es', 'España'), ('et', 'en', 'Ethiopia'), ('et', 'es', 'Etiopía'), ('fi', 'en', 'Finland'), ('fi', 'es', 'Finlandia'), ('fj', 'en', 'Fiji'), ('fj', 'es', 'Fidji'), ('fk', 'en', 'Falkland Islands (Malvinas)'), ('fk', 'es', 'Islas Malvinas'), ('fm', 'en', 'Micronesia, Federated States of'), ('fm', 'es', 'Micronesia'), ('fo', 'en', 'Faroe Islands'), ('fo', 'es', 'Islas Feroe'), ('fr', 'en', 'France'), ('fr', 'es', 'Francia'), ('ga', 'en', 'Gabon'), ('ga', 'es', 'Gabón'), ('gb', 'en', 'United Kingdom'), ('gb', 'es', 'Reino Unido'), ('gd', 'en', 'Grenada'), ('gd', 'es', 'Granada'), ('ge', 'en', 'Georgia'), ('ge', 'es', 'Georgia'), ('gf', 'en', 'French Guiana'), ('gf', 'es', 'Guayana Francesa'), ('gg', 'en', 'Guernsey'), ('gg', 'es', 'Guernsey'), ('gh', 'en', 'Ghana'), ('gh', 'es', 'Ghana'), ('gi', 'en', 'Gibraltar'), ('gi', 'es', 'Gibraltar'), ('gl', 'en', 'Greenland'), ('gl', 'es', 'Groenlandia'), ('gm', 'en', 'Gambia'), ('gm', 'es', 'Gambia'), ('gn', 'en', 'Guinea'), ('gn', 'es', 'Guinea'), ('gp', 'en', 'Guadeloupe'), ('gp', 'es', 'Guadalupe'), ('gq', 'en', 'Equatorial Guinea'), ('gq', 'es', 'Guinea Ecuatorial'), ('gr', 'en', 'Greece'), ('gr', 'es', 'Grecia'), ('gs', 'en', 'South Georgia and the South Sandwich Islands'), ('gs', 'es', 'Islas Georgia del Sur y Sandwich del Sur'), ('gt', 'en', 'Guatemala'), ('gt', 'es', 'Guatemala'), ('gu', 'en', 'Guam'), ('gu', 'es', 'Guam'), ('gw', 'en', 'Guinea-Bissau'), ('gw', 'es', 'Guinea-Bissau'), ('gy', 'en', 'Guyana'), ('gy', 'es', 'Guyana'), ('hk', 'en', 'Hong Kong'), ('hk', 'es', 'Hong Kong'), ('hm', 'en', 'Heard Island and McDonald Islands'), ('hm', 'es', 'Islas Heard y McDonald'), ('hn', 'en', 'Honduras'), ('hn', 'es', 'Honduras'), ('hr', 'en', 'Croatia'), ('hr', 'es', 'Croacia'), ('ht', 'en', 'Haiti'), ('ht', 'es', 'Haití'), ('hu', 'en', 'Hungary'), ('hu', 'es', 'Hungaria'), ('id', 'en', 'Indonesia'), ('id', 'es', 'Indonesia'), ('ie', 'en', 'Ireland'), ('ie', 'es', 'Irlanda'), ('il', 'en', 'Israel'), ('il', 'es', 'Israel'), ('im', 'en', 'Isle of Man'), ('im', 'es', 'Isla de Man'), ('in', 'en', 'India'), ('in', 'es', 'India'), ('io', 'en', 'British Indian Ocean Territory'), ('io', 'es', 'Océano Índico, Territorio Británico del'), ('iq', 'en', 'Iraq'), ('iq', 'es', 'Irak'), ('ir', 'en', 'Iran, Islamic Republic of'), ('ir', 'es', 'Irán, República Islámica de'), ('is', 'en', 'Iceland'), ('is', 'es', 'Islandia'), ('it', 'en', 'Italy'), ('it', 'es', 'Italia'), ('je', 'en', 'Jersey'), ('je', 'es', 'Jersey'), ('jm', 'en', 'Jamaica'), ('jm', 'es', 'Jamaica'), ('jo', 'en', 'Jordan'), ('jo', 'es', 'Jordán'), ('jp', 'en', 'Japan'), ('jp', 'es', 'Japón'), ('ke', 'en', 'Kenya'), ('ke', 'es', 'Kenia'), ('kg', 'en', 'Kyrgyzstan'), ('kg', 'es', 'Kirguistán'), ('kh', 'en', 'Cambodia'), ('kh', 'es', 'Camboya'), ('ki', 'en', 'Kiribati'), ('ki', 'es', 'Kiribati'), ('km', 'en', 'Comoros'), ('km', 'es', 'Comoras'), ('kn', 'en', 'Saint Kitts and Nevis'), ('kn', 'es', 'San Cristobal y Nieves'), ('kp', 'en', 'Korea, Democratic People\'s Republic of'), ('kp', 'es', 'Corea del Norte'), ('kr', 'en', 'Korea, Republic of'), ('kr', 'es', 'Corea del Sur'), ('kw', 'en', 'Kuwait'), ('kw', 'es', 'Kuwait'), ('ky', 'en', 'Cayman Islands'), ('ky', 'es', 'Islas Caimán'), ('kz', 'en', 'Kazakhstan'), ('kz', 'es', 'Kazajistán'), ('la', 'en', 'Lao People\'s Democratic Republic'), ('la', 'es', 'Laos'), ('lb', 'en', 'Lebanon'), ('lb', 'es', 'Líbano'), ('lc', 'en', 'Saint Lucia'), ('lc', 'es', 'Santa Lucía'), ('li', 'en', 'Liechtenstein'), ('li', 'es', 'Liechtenstein'), ('lk', 'en', 'Sri Lanka'), ('lk', 'es', 'Sri Lanka'), ('lr', 'en', 'Liberia'), ('lr', 'es', 'Liberia'), ('ls', 'en', 'Lesotho'), ('ls', 'es', 'Lesoto'), ('lt', 'en', 'Lithuania'), ('lt', 'es', 'Lituania'), ('lu', 'en', 'Luxembourg'), ('lu', 'es', 'Luxemburgo'), ('lv', 'en', 'Latvia'), ('lv', 'es', 'Letonia'), ('ly', 'en', 'Libyan Arab Jamahiriya'), ('ly', 'es', 'Libia'), ('ma', 'en', 'Morocco'), ('ma', 'es', 'Marruecos'), ('mc', 'en', 'Monaco'), ('mc', 'es', 'Mónaco'), ('md', 'en', 'Moldova, Republic of'), ('md', 'es', 'Moldavia'), ('me', 'en', 'Montenegro'), ('me', 'es', 'Montenegro'), ('mf', 'en', 'Saint Martin (French part)'), ('mf', 'es', 'San Martín'), ('mg', 'en', 'Madagascar'), ('mg', 'es', 'Madagascar'), ('mh', 'en', 'Marshall Islands'), ('mh', 'es', 'Islas Marshall'), ('mk', 'en', 'Macedonia, the former Yugoslav Republic of'), ('mk', 'es', 'Macedonia'), ('ml', 'en', 'Mali'), ('ml', 'es', 'Mali'), ('mm', 'en', 'Myanmar'), ('mm', 'es', 'Birmania'), ('mn', 'en', 'Mongolia'), ('mn', 'es', 'Mongolia'), ('mo', 'en', 'Macao'), ('mo', 'es', 'Macao'), ('mp', 'en', 'Northern Mariana Islands'), ('mp', 'es', 'Islas Marianas del Norte'), ('mq', 'en', 'Martinique'), ('mq', 'es', 'Martinica'), ('mr', 'en', 'Mauritania'), ('mr', 'es', 'Mauritania'), ('ms', 'en', 'Montserrat'), ('ms', 'es', 'Montserrat'), ('mt', 'en', 'Malta'), ('mt', 'es', 'Malta'), ('mu', 'en', 'Mauritius'), ('mu', 'es', 'Mauricio'), ('mv', 'en', 'Maldives'), ('mv', 'es', 'Maldivas'), ('mw', 'en', 'Malawi'), ('mw', 'es', 'Malaui'), ('mx', 'en', 'Mexico'), ('mx', 'es', 'México'), ('my', 'en', 'Malaysia'), ('my', 'es', 'Malasia'), ('mz', 'en', 'Mozambique'), ('mz', 'es', 'Mozambique'), ('na', 'en', 'Namibia'), ('na', 'es', 'Namibia'), ('nc', 'en', 'New Caledonia'), ('nc', 'es', 'Nueva Caledonia'), ('ne', 'en', 'Niger'), ('ne', 'es', 'Níger'), ('nf', 'en', 'Norfolk Island'), ('nf', 'es', 'Norfolk'), ('ng', 'en', 'Nigeria'), ('ng', 'es', 'Nigeria'), ('ni', 'en', 'Nicaragua'), ('ni', 'es', 'Nicaragua'), ('nl', 'en', 'Netherlands'), ('nl', 'es', 'Holanda'), ('no', 'en', 'Norway'), ('no', 'es', 'Noruega'), ('np', 'en', 'Nepal'), ('np', 'es', 'Nepal'), ('nr', 'en', 'Nauru'), ('nr', 'es', 'Nauru'), ('nu', 'en', 'Niue'), ('nu', 'es', 'Niue'), ('nz', 'en', 'New Zealand'), ('nz', 'es', 'Nueva Zelanda'), ('om', 'en', 'Oman'), ('om', 'es', 'Omán'), ('pa', 'en', 'Panama'), ('pa', 'es', 'Panamá'), ('pe', 'en', 'Peru'), ('pe', 'es', 'Perú'), ('pf', 'en', 'French Polynesia'), ('pf', 'es', 'Polinesia Francesa'), ('pg', 'en', 'Papua New Guinea'), ('pg', 'es', 'Papua Nueva Guinea'), ('ph', 'en', 'Philippines'), ('ph', 'es', 'Filipinas'), ('pk', 'en', 'Pakistan'), ('pk', 'es', 'Pakistán'), ('pl', 'en', 'Poland'), ('pl', 'es', 'Polonia'), ('pm', 'en', 'Saint Pierre and Miquelon'), ('pm', 'es', 'San Pedro y Miquelón'), ('pn', 'en', 'Pitcairn'), ('pn', 'es', 'Islas Pitcairn'), ('pr', 'en', 'Puerto Rico'), ('pr', 'es', 'Puerto Rico'), ('ps', 'en', 'Palestinian Territory, Occupied'), ('ps', 'es', 'Territorios Palestinos'), ('pt', 'en', 'Portugal'), ('pt', 'es', 'Portugal'), ('pw', 'en', 'Palau'), ('pw', 'es', 'Palaos'), ('py', 'en', 'Paraguay'), ('py', 'es', 'Paraguay'), ('qa', 'en', 'Qatar'), ('qa', 'es', 'Qatar'), ('re', 'en', 'Réunion'), ('re', 'es', 'Reunión'), ('ro', 'en', 'Romania'), ('ro', 'es', 'Rumania'), ('rs', 'en', 'Serbia'), ('rs', 'es', 'Serbia'), ('ru', 'en', 'Russian Federation'), ('ru', 'es', 'Rusia'), ('rw', 'en', 'Rwanda'), ('rw', 'es', 'Ruanda'), ('sa', 'en', 'Saudi Arabia'), ('sa', 'es', 'Arabia Saudí'), ('sb', 'en', 'Solomon Islands'), ('sb', 'es', 'Islas Solomón'), ('sc', 'en', 'Seychelles'), ('sc', 'es', 'Seychelles'), ('sd', 'en', 'Sudan'), ('sd', 'es', 'Sudán'), ('se', 'en', 'Sweden'), ('se', 'es', 'Suecia'), ('sg', 'en', 'Singapore'), ('sg', 'es', 'Singapur'), ('sh', 'en', 'Saint Helena'), ('sh', 'es', 'Santa Helena'), ('si', 'en', 'Slovenia'), ('si', 'es', 'Eslovenia'), ('sj', 'en', 'Svalbard and Jan Mayen'), ('sj', 'es', 'Svalbard y Jan Mayen'), ('sk', 'en', 'Slovakia'), ('sk', 'es', 'Eslovaquia'), ('sl', 'en', 'Sierra Leone'), ('sl', 'es', 'Sierra Leona'), ('sm', 'en', 'San Marino'), ('sm', 'es', 'San Marino'), ('sn', 'en', 'Senegal'), ('sn', 'es', 'Senegal'), ('so', 'en', 'Somalia'), ('so', 'es', 'Somalia'), ('sr', 'en', 'Suriname'), ('sr', 'es', 'Surinam'), ('st', 'en', 'Sao Tome and Principe'), ('st', 'es', 'Santo Tomé y Príncipe'), ('sv', 'en', 'El Salvador'), ('sv', 'es', 'El Salvador'), ('sy', 'en', 'Syrian Arab Republic'), ('sy', 'es', 'Siria'), ('sz', 'en', 'Swaziland'), ('sz', 'es', 'Suazilandia'), ('tc', 'en', 'Turks and Caicos Islands'), ('tc', 'es', 'Islas Turcas y Caicos'), ('td', 'en', 'Chad'), ('td', 'es', 'Chad'), ('tf', 'en', 'French Southern Territories'), ('tf', 'es', 'Territorios Australes Franceses'), ('tg', 'en', 'Togo'), ('tg', 'es', 'Togo'), ('th', 'en', 'Thailand'), ('th', 'es', 'Tailandia'), ('tj', 'en', 'Tajikistan'), ('tj', 'es', 'Tayikistán'), ('tk', 'en', 'Tokelau'), ('tk', 'es', 'Tokelau'), ('tl', 'en', 'Timor-Leste'), ('tl', 'es', 'Timor Oriental'), ('tm', 'en', 'Turkmenistan'), ('tm', 'es', 'Turkmenistán'), ('tn', 'en', 'Tunisia'), ('tn', 'es', 'Túnez'), ('to', 'en', 'Tonga'), ('to', 'es', 'Tonga'), ('tr', 'en', 'Turkey'), ('tr', 'es', 'Turquía'), ('tt', 'en', 'Trinidad and Tobago'), ('tt', 'es', 'Trinidad y Tobago'), ('tv', 'en', 'Tuvalu'), ('tv', 'es', 'Tuvalu'), ('tw', 'en', 'Taiwan, Province of China'), ('tw', 'es', 'República de China'), ('tz', 'en', 'Tanzania, United Republic of'), ('tz', 'es', 'Tanzania'), ('ua', 'en', 'Ukraine'), ('ua', 'es', 'Ucrania'), ('ug', 'en', 'Uganda'), ('ug', 'es', 'Uganda'), ('um', 'en', 'United States Minor Outlying Islands'), ('um', 'es', 'Islas Ultramarinas de Estados Unidos'), ('us', 'en', 'United States'), ('us', 'es', 'Estados Unidos'), ('uy', 'en', 'Uruguay'), ('uy', 'es', 'Uruguay'), ('uz', 'en', 'Uzbekistan'), ('uz', 'es', 'Uzbekistán'), ('va', 'en', 'Holy See (Vatican City State)'), ('va', 'es', 'Ciudad del Vaticano'), ('vc', 'en', 'Saint Vincent and the Grenadines'), ('vc', 'es', 'San Vicente y las Granadinas'), ('ve', 'en', 'Venezuela'), ('ve', 'es', 'Venezuela'), ('vg', 'en', 'Virgin Islands, British'), ('vg', 'es', 'Islas Vírgenes Británicas'), ('vi', 'en', 'Virgin Islands, U.S.'), ('vi', 'es', 'Islas Vírgenes Estadounidenses'), ('vn', 'en', 'Viet Nam'), ('vn', 'es', 'Vietnam'), ('vu', 'en', 'Vanuatu'), ('vu', 'es', 'Vanuatu'), ('wf', 'en', 'Wallis and Futuna'), ('wf', 'es', 'Wallis y Futuna'), ('ws', 'en', 'Samoa'), ('ws', 'es', 'Samoa'), ('ye', 'en', 'Yemen'), ('ye', 'es', 'Yemen'), ('yt', 'en', 'Mayotte'), ('yt', 'es', 'Mayotte'), ('za', 'en', 'South Africa'), ('za', 'es', 'Sudáfrica'), ('zm', 'en', 'Zambia'), ('zm', 'es', 'Zambia'), ('zw', 'en', 'Zimbabwe'), ('zw', 'es', 'Zimbabue');
/*!40000 ALTER TABLE `jos_crsgen_tbl_paises` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_tpvempresas
DROP TABLE IF EXISTS `jos_crsgen_tpvempresas`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_tpvempresas` (
  `Id` int(11) NOT NULL auto_increment,
  `IdEmpresa` int(11) NOT NULL,
  `CodComercio` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Clave` varchar(250) collate latin1_spanish_ci NOT NULL,
  `ClaveXor` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Terminal` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Produccion` bit(1) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_tpvempresas: 0 rows
/*!40000 ALTER TABLE `jos_crsgen_tpvempresas` DISABLE KEYS */;
/*!40000 ALTER TABLE `jos_crsgen_tpvempresas` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_traducciones
DROP TABLE IF EXISTS `jos_crsgen_traducciones`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_traducciones` (
  `Id` int(11) NOT NULL auto_increment,
  `IdReferencia` int(11) NOT NULL,
  `Idioma` varchar(2) collate latin1_spanish_ci NOT NULL,
  `Tabla` varchar(75) collate latin1_spanish_ci NOT NULL,
  `Campo` varchar(75) collate latin1_spanish_ci NOT NULL,
  `Traduccion` text collate latin1_spanish_ci NOT NULL,
  `CodigoEsta` int(11) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_traducciones: 5 rows
/*!40000 ALTER TABLE `jos_crsgen_traducciones` DISABLE KEYS */;
INSERT INTO `jos_crsgen_traducciones` (`Id`, `IdReferencia`, `Idioma`, `Tabla`, `Campo`, `Traduccion`, `CodigoEsta`) VALUES (17, 80, 'en', 'CondicionesEmpresa', 'Texto', '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la p&aacute;gina, el nombre de dominio, su c&oacute;digo fuente, dise&ntilde;o y estructura de navegaci&oacute;n en &eacute;l contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotaci&oacute;n de los mismos en cualquier forma, y, en especial los derechos de reproducci&oacute;n, distribuci&oacute;n, comunicaci&oacute;n p&uacute;blica y transformaci&oacute;n.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformaci&oacute;n, modificaci&oacute;n o alteraci&oacute;n contra ella que suponga un perjuicio a sus intereses leg&iacute;timos o menoscabo de su reputaci&oacute;n. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la informaci&oacute;n de la presente p&aacute;gina sin autorizaci&oacute;n por escrito de su titular.</p>', 0), (18, 80, 'de', 'CondicionesEmpresa', 'Texto', '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la p&aacute;gina, el nombre de dominio, su c&oacute;digo fuente, dise&ntilde;o y estructura de navegaci&oacute;n en &eacute;l contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotaci&oacute;n de los mismos en cualquier forma, y, en especial los derechos de reproducci&oacute;n, distribuci&oacute;n, comunicaci&oacute;n p&uacute;blica y transformaci&oacute;n.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformaci&oacute;n, modificaci&oacute;n o alteraci&oacute;n contra ella que suponga un perjuicio a sus intereses leg&iacute;timos o menoscabo de su reputaci&oacute;n. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la informaci&oacute;n de la presente p&aacute;gina sin autorizaci&oacute;n por escrito de su titular.</p>', 0), (19, 80, 'fr', 'CondicionesEmpresa', 'Texto', '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la p&aacute;gina, el nombre de dominio, su c&oacute;digo fuente, dise&ntilde;o y estructura de navegaci&oacute;n en &eacute;l contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotaci&oacute;n de los mismos en cualquier forma, y, en especial los derechos de reproducci&oacute;n, distribuci&oacute;n, comunicaci&oacute;n p&uacute;blica y transformaci&oacute;n.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformaci&oacute;n, modificaci&oacute;n o alteraci&oacute;n contra ella que suponga un perjuicio a sus intereses leg&iacute;timos o menoscabo de su reputaci&oacute;n. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la informaci&oacute;n de la presente p&aacute;gina sin autorizaci&oacute;n por escrito de su titular.</p>', 0), (20, 73, 'ca', 'CondicionesEmpresa', 'Texto', '<p><strong>PROPIEDAD INTELECTUAL Y DERECHOS DE AUTOR </strong><br /><br /> Los derechos de propiedad intelectual de la página, el nombre de dominio, su código fuente, diseño y estructura de navegación en él contenidos son titularidad de la referida empresa, a quien corresponde el ejercicio exclusivo de los derechos de explotación de los mismos en cualquier forma, y, en especial los derechos de reproducción, distribución, comunicación pública y transformación.     El usuario se compromete, en cumplimiento de lo establecido en la Ley de Propiedad Intelectual a mantener la integridad de la obra e impedir cualquier deformación, modificación o alteración contra ella que suponga un perjuicio a sus intereses legítimos o menoscabo de su reputación. Asimismo se compromete a no reproducir, copiar, distribuir o publicar el contenido de la información de la presente página sin autorización por escrito de su titular.</p>', 0), (21, 73, 'en', 'CondicionesEmpresa', 'Texto', '<p><strong>TERMS AND CONDITIONS OF RESERVATIONS</strong> <br /><br />Processing a reservation on the website of the Castelldefels Tourism Promotion Consortium www.castelldefelsturisme.com, implies the express acceptance by the client of each and every one of the general conditions that are considered an integral part of the reservation and comply with specific applicable legislation.<br /><br /><strong> RESERVATIONS</strong> <br />At the time of making the reservation, a deposit must be made by means of a secure payment by credit card. The reservation is not considered to be a firm booking until this deposit has been made.  The rest of the payment must be made at the beginning of the service; if not, the reservation is considered to be cancelled.  The client will receive the details of his/her reservation by electronic mail, along with its identification number (localiser), all related data, and conditions. The transactions will be made in EUROS, whatever the origin of the client or the establishment selected.</p>\r\n<p><br /><strong> THE RESERVATION INCLUDES</strong> <br />The detailed services according to the reservation conditions stipulated by each tourism establishment selected at the time of making the reservation, VAT included.   <br /><br /><strong>LIABILITY OF THE CLIENT </strong><br />By making the reservation, the client is fully and exclusively liable for the accuracy of all the data that he/she has stated. If it proves to be incorrect, this may result in the cancellation of the reservation. <br /><br /><strong> CANCELATIONS </strong><br />The client may relinquish the services requested or contracted, in which case the deposit made at the time of reservation will be used as administration expenses of the cancellation.  <br /><br /><strong>NON-SHOW </strong><br />In the event of not arriving at the contracted establishment before 20.00 h on the day of arrival arranged, the reservation will be cancelled (the whole stay will be lost).  <br /><br /><strong>RESPONSIBILITY OF THE RESERVATIONS SYSTEM</strong> <br />The reservations system is the responsibility of the Castelldefels Tourism Promotion Consortium, with CIF (tax registration number) V-64813918 and registered office at C/Bishop Urquinaona, 23, Castelldefels, Spain.</p>', 0);
/*!40000 ALTER TABLE `jos_crsgen_traducciones` ENABLE KEYS */;


# Dumping structure for table qgq826.jos_crsgen_usuarios
DROP TABLE IF EXISTS `jos_crsgen_usuarios`;
CREATE TABLE IF NOT EXISTS `jos_crsgen_usuarios` (
  `Id` int(11) NOT NULL auto_increment,
  `Usuario` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Clave` varchar(50) collate latin1_spanish_ci NOT NULL,
  `Nombre` varchar(50) collate latin1_spanish_ci NOT NULL,
  `IdEmpresa` int(11) NOT NULL,
  `Nivel` int(11) NOT NULL,
  `Activo` varchar(1) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

# Dumping data for table qgq826.jos_crsgen_usuarios: 2 rows
/*!40000 ALTER TABLE `jos_crsgen_usuarios` DISABLE KEYS */;
INSERT INTO `jos_crsgen_usuarios` (`Id`, `Usuario`, `Clave`, `Nombre`, `IdEmpresa`, `Nivel`, `Activo`) VALUES (6, 'admin', 'Willy7612', 'Administrador', 0, 0, '1'), (7, 'online4you', 'online4you@001', 'online4you', 98, 0, '1');
/*!40000 ALTER TABLE `jos_crsgen_usuarios` ENABLE KEYS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
