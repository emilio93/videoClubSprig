-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: videoclub
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `prestamoscompleto`
--

DROP TABLE IF EXISTS `prestamoscompleto`;
/*!50001 DROP VIEW IF EXISTS `prestamoscompleto`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `prestamoscompleto` AS SELECT
 1 AS `idCliente`,
 1 AS `cedula`,
 1 AS `nombre`,
 1 AS `apellido1`,
 1 AS `apellido2`,
 1 AS `telefono`,
 1 AS `email`,
 1 AS `idPelicula`,
 1 AS `titulo`,
 1 AS `direccion`,
 1 AS `produccion`,
 1 AS `ano`,
 1 AS `genero`,
 1 AS `duracion`,
 1 AS `sinopsis`,
 1 AS `cantidad`,
 1 AS `idPrestamo`,
 1 AS `salida`,
 1 AS `devolucion`,
 1 AS `devuelta`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `prestamoscompleto`
--

/*!50001 DROP VIEW IF EXISTS `prestamoscompleto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `prestamoscompleto` AS select `clientes`.`idCliente` AS `idCliente`,`clientes`.`cedula` AS `cedula`,`clientes`.`nombre` AS `nombre`,`clientes`.`apellido1` AS `apellido1`,`clientes`.`apellido2` AS `apellido2`,`clientes`.`telefono` AS `telefono`,`clientes`.`email` AS `email`,`peliculas`.`idPelicula` AS `idPelicula`,`peliculas`.`titulo` AS `titulo`,`peliculas`.`direccion` AS `direccion`,`peliculas`.`produccion` AS `produccion`,`peliculas`.`ano` AS `ano`,`peliculas`.`genero` AS `genero`,`peliculas`.`duracion` AS `duracion`,`peliculas`.`sinopsis` AS `sinopsis`,`peliculas`.`cantidad` AS `cantidad`,`prestamos`.`idPrestamo` AS `idPrestamo`,`prestamos`.`salida` AS `salida`,`prestamos`.`devolucion` AS `devolucion`,`prestamos`.`devuelta` AS `devuelta` from ((`prestamos` join `clientes` on((`prestamos`.`idCliente` = `clientes`.`idCliente`))) join `peliculas` on((`prestamos`.`idPelicula` = `peliculas`.`idPelicula`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'videoclub'
--
/*!50003 DROP PROCEDURE IF EXISTS `addCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addCliente`(
	IN pcedula INT,
	IN pnombre VARCHAR(255),
	IN papellido1 VARCHAR(255),
    IN papellido2 VARCHAR(255),
    IN ptelefono INT,
    IN pemail VARCHAR(255),
    IN pdireccion LONGTEXT
)
BEGIN
	INSERT INTO clientes(cedula, nombre, apellido1, apellido2, telefono, email, direccion)
	values (pcedula, pnombre, papellido1, papellido2, ptelefono, pemail, pdireccion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addConfiguracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addConfiguracion`(
    IN pnombre VARCHAR(255),
    IN pvalor VARCHAR(255),
    IN ptipo VARCHAR(255),
    IN pdescripcion VARCHAR(255)
)
BEGIN
    INSERT INTO configuracion(nombre, valor, tipo, descripcion)
    VALUES (pnombre, pvalor, ptipo, pdescripcion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addPelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addPelicula`(
	IN ptitulo VARCHAR(255),
	IN pdireccion VARCHAR(255),
    IN pproduccion VARCHAR(255),
    IN pano INT,
    IN pgenero VARCHAR(255),
    IN pduracion INT,
    IN psinopsis LONGTEXT,
    IN pcantidad INT
)
BEGIN
	INSERT INTO peliculas(titulo, direccion, produccion, ano, genero, duracion, sinopsis, cantidad)
	VALUES (ptitulo, pdireccion, pproduccion, pano, pgenero, pduracion, psinopsis, pcantidad);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addPrestamo`(
	IN pidCliente INT,
    IN pidPelicula INT,
    IN psalida VARCHAR(255),
    IN pdevolucion VARCHAR(255)
)
BEGIN
	DECLARE puedeRentar INT;
    DECLARE rentasActivasCliente INT;
    DECLARE totalPeliculas INT;
    DECLARE peliculasActivas INT;
    DECLARE maximoPeliculas INT;

    SET puedeRentar = 0;

   	SELECT COUNT(*) FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE prestamos.devuelta = 0 AND prestamos.idCliente = pidCliente
    INTO rentasActivasCliente;

    SELECT COUNT(*) FROM prestamos
    INNER JOIN peliculas ON prestamos.idPelicula = peliculas.idPelicula
    WHERE prestamos.devuelta = 0 AND prestamos.idPelicula = pidPelicula
    INTO peliculasActivas;

    SELECT cantidad FROM peliculas
    WHERE idPelicula = pidPelicula
    INTO totalPeliculas;

    SELECT valor FROM configuracion
    WHERE nombre = 'MAX_PELICULAS_CLIENTE'
    INTO maximoPeliculas;

    IF rentasActivasCliente < maximoPeliculas && (totalPeliculas - peliculasActivas) > 0 THEN
		INSERT INTO prestamos(idCliente, idPelicula, salida, devolucion)
		VALUES (pidCliente, pidPelicula, psalida, pdevolucion);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `contarPrestamosCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `contarPrestamosCliente`(
    IN pidCliente INT
)
BEGIN
	SELECT COUNT(*) AS prestamos
    FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE prestamos.devuelta = 0 AND prestamos.idCliente = pidCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `deleteCliente`(
    IN pidCliente INT
)
BEGIN
	DELETE FROM clientes
    WHERE idCliente = pidCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `deletePelicula`(
    IN pidPelicula INT
)
BEGIN
	DELETE FROM clientes
    WHERE idPelicula = pidPelicula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `esMoroso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `esMoroso`(
    IN pidCliente INT
)
BEGIN
	-- Indica la cantidad de películas en mora de un cliente.
	DECLARE moras INT DEFAULT 0;
	SELECT COUNT(*)
    INTO moras
    FROM prestamos
    INNER JOIN clientes ON prestamos.idCliente = clientes.idCliente
    WHERE clientes.idCliente = pidCLiente AND NOW() > prestamos.devolucion;
	SELECT moras;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `finalizarPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `finalizarPrestamo`(
    IN pidPrestamo INT
)
BEGIN
	UPDATE prestamos
    SET devuelta = 1
    WHERE idPrestamo = pidPrestamo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getCliente`(
    IN pidCliente INT
)
BEGIN
	SELECT * FROM clientes WHERE idCliente = pidCliente LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getClientes`(
    IN cant INT,
    IN pag INT
)
BEGIN
	-- Si una página contiene cant cantidad de registros de clientes,
    -- se obtiene la pag-esima página con clientes.
    --
    -- Números negativos seran convertidos a positivos.
    --
    -- Solo se permiten los casos que cant y pag sean
    --     cero, o ambos distintos de 0.
    --
    -- Si cant y pag son 0, selecciona todos los clientes.
    DECLARE minLim INT DEFAULT 0;
    SET cant = ABS(cant);
    SET pag = ABS(pag);

    IF cant = 0 AND pag = 0 THEN
		SELECT * FROM clientes;
	END IF;

    IF cant != 0 AND pag != 0 THEN
		SET minLim = cant*(pag-1);
		SELECT * FROM clientes LIMIT cant OFFSET minLim ;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getClientesMorosos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getClientesMorosos`()
BEGIN
	-- Obtiene los clientes con mora en algún préstamo.
	SELECT * FROM clientes
    INNER JOIN prestamos ON cliente.idCliente = prestamos.idCliente
    WHERE prestamos.devolucion > NOW();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getConfiguracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getConfiguracion`(
    IN pnombre VARCHAR(255)
)
BEGIN
	-- Obtiene el valor, tipo y descripcion para la configuración solicitada.
	SELECT valor, tipo, descripcion FROM configuracion
    WHERE nombre = pnombre LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getIdFromCedula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getIdFromCedula`(
    IN pcedula INT
)
BEGIN
	SELECT idCliente FROM clientes WHERE cedula = pcedula LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNombrePeliclas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getNombrePeliclas`()
BEGIN
	SELECT nombre FROM peliculas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNombrePeliculas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getNombrePeliculas`()
BEGIN
	SELECT nombre FROM peliculas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPelicula`(
    IN pidPelicula INT
)
BEGIN
	SELECT * FROM peliculas WHERE idPelicula=pidPelicula LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPeliculaPorTitulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPeliculaPorTitulo`(IN ptitulo VARCHAR(255))
BEGIN
	SELECT * FROM peliculas WHERE titulo=ptitulo LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPeliculas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPeliculas`(
    IN cant INT,
    IN pag INT
)
BEGIN
	-- Si una página contiene cant cantidad de registros de peliculas,
    -- se obtiene la pag-esima página con peliculas.
    --
    -- Números negativos seran convertidos a positivos.
    --
    -- Solo se permiten los casos que cant y pag sean
    --     cero, o ambos distintos de 0.
    --
    -- Si cant y pag son 0, selecciona todas las peliculas.
    DECLARE minLim INT DEFAULT 0;
    SET cant = ABS(cant);
    SET pag = ABS(pag);

    IF cant = 0 AND pag = 0 THEN
		SELECT * FROM peliculas;
	END IF;

    IF cant != 0 AND pag != 0 THEN
		SET minLim = cant*(pag-1);
		SELECT * FROM peliculas LIMIT cant OFFSET minLim;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPeliculasEnMora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPeliculasEnMora`()
BEGIN
	-- Obtiene las películas con algún ejemplar en mora.
	SELECT * FROM peliculas
    INNER JOIN prestamos ON pelicula.idPelicula = prestamos.idPelicula
    WHERE prestamos.devolucion > NOW()
    GROUP BY peliculas.titulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamo`(IN pidPrestamo INT)
BEGIN
	SELECT * FROM prestamos WHERE idPrestamo = pidPrestamo LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamos`()
BEGIN
		SELECT
		prestamos.idPrestamo, prestamos.salida, prestamos.devolucion, prestamos.devuelta,
		clientes.idCliente, clientes.cedula, clientes.nombre, clientes.apellido1,
        clientes.apellido2, clientes.telefono, clientes.email,
		peliculas.idPelicula, peliculas.titulo, peliculas.direccion, peliculas.produccion,
        peliculas.ano
        FROM prestamos

		INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
        INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamosCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamosCliente`(
    IN pidCliente INT,
    pdevuelta TINYINT
)
BEGIN
	-- Obtiene todos los prestamos de un cliente.
    -- El parametro pdevuelta indica si se seleccionan los
    -- prestamos devueltos, los activos o bien todos según
    -- lo siguiente:
    --     0: activos
    --     1: inactivos
    --     2: todos

    IF pdevuelta = 0 THEN
		SELECT
			prestamos.salida, prestamos.devolucion, prestamos.devuelta,
			clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
			peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
        FROM prestamos
		INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
        RIGHT OUTER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
		WHERE prestamos.idCliente = pidCliente AND prestamos.devuelta = 0;
	END IF;

    IF pdevuelta = 1 THEN
		SELECT
			prestamos.salida, prestamos.devolucion, prestamos.devuelta,
			clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
			peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
        FROM prestamos
		INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
        RIGHT OUTER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
		WHERE prestamos.idCliente = pidCliente AND prestamos.devuelta = 1;
	END IF;

    IF pdevuelta = 2 THEN
		SELECT
			prestamos.salida, prestamos.devolucion, prestamos.devuelta,
			clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
			peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
        FROM prestamos
		INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
        RIGHT OUTER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
		WHERE prestamos.idCliente = pidCliente;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamosClientePelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamosClientePelicula`(
    IN pidCliente INT,
    pidPelicula INT
)
BEGIN
	-- Obtiene los valores relevantes de prestamo, cliente y pelicula
    -- al mostrar un prestamo según la pelicula y cliente solicitados.
    -- Obtiene únicamente los préstamos activos.
	SELECT
		prestamos.salida, prestamos.devolucion,
        cliente.cedula, cliente.nombre, cliente.apellido1, cliente.apellido2, cliente.telefono, cliente.email,
        pelicula.titulo, pelicula.direccion, pelicula.produccion, pelicula.ano
    FROM prestamos
    INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
    INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
    WHERE
		peliculas.idPelicula = pidPelicula AND
        prestamos.idCliente = pidCliente AND
        prestamos.devuelto = 1
	ORDER BY salida DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamosConMora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamosConMora`()
BEGIN
	SELECT
	prestamos.idPrestamo, prestamos.salida, prestamos.devolucion, prestamos.devuelta,
	clientes.cedula, clientes.nombre, clientes.apellido1, clientes.apellido2, clientes.telefono, clientes.email,
	peliculas.titulo, peliculas.direccion, peliculas.produccion, peliculas.ano
	FROM prestamos
	INNER JOIN clientes ON clientes.idCliente = prestamos.idCliente
	INNER JOIN peliculas ON peliculas.idPelicula = prestamos.idPelicula
	WHERE devuelta = 0 AND prestamos.devolucion > NOW();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPrestamosPelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `getPrestamosPelicula`(
    IN ptitulo VARCHAR(255)
)
BEGIN

	DECLARE pidPelicula INT;
    SELECT idPelicula FROM peliculas WHERE titulo = ptitulo LIMIT 1 INTO pidPelicula;

	SELECT * FROM peliculas
	INNER JOIN prestamos ON peliculas.idPelicula = prestamos.idPelicula
    WHERE prestamos.idPelicula = pidPelicula AND prestamo.devuelta = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reactivarPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `reactivarPrestamo`(
    IN pidPrestamo INT
)
BEGIN
	UPDATE prestamos
    SET devuelta = 0
    WHERE idPrestamo = pidPrestamo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateCliente`(
	IN pidCliente INT,
    IN pcedula INT,
    IN pnombre VARCHAR(255),
    IN papellido1 VARCHAR(255),
    IN papellido2 VARCHAR(255),
    IN ptelefono INT,
    IN pemail VARCHAR(255),
    IN pdireccion LONGTEXT
)
BEGIN
	UPDATE clientes
	SET
		cedula = pcedula,
        nombre = pnombre,
        apellido1 = papellido1,
        apellido2 = papellido2,
        telefono = ptelefono,
        email = pemail,
        direccion = pdireccion
	WHERE idCliente = pidCliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateConfiguracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateConfiguracion`(
	IN pnombre VARCHAR(255),
    IN pvalor VARCHAR(255),
    IN ptipo VARCHAR(255),
    IN pdescripcion VARCHAR(255)
)
BEGIN
	UPDATE configuracion
	SET
        valor = pvalor,
        tipo = ptipo,
        descripcion = pdescripcion
	WHERE nombre = pnombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePelicula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updatePelicula`(
    IN pidPelicula INT,
    IN ptitulo INT,
    IN pdireccion VARCHAR(255),
    IN pproduccion VARCHAR(255),
    IN pano INT,
    IN pgenero VARCHAR(255),
    IN pduracion INT,
    IN psinopsis LONGTEXT,
    IN pcantidad INT
)
BEGIN
	UPDATE peliculas
	SET
		idPelicula = pidPelicula,
		titulo = ptitulo,
		direccion = pdireccion,
		produccion = pproduccion,
		ano = pano,
		genero = pgenero,
		duracion = pduracion,
		sinopsis = psinopsis,
		cantidad = pcantidad
	WHERE idPelicula = pidPelicula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-29 21:11:54
