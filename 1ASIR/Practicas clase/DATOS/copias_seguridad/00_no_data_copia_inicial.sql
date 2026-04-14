-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: logistica_global
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `almacenes`
--

DROP TABLE IF EXISTS `almacenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `almacenes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cod_almacen` varchar(50) DEFAULT NULL,
  `nombre_sucursal` varchar(150) DEFAULT NULL,
  `ciudad_ubicacion` varchar(100) DEFAULT NULL,
  `capacidad_m3` varchar(50) DEFAULT NULL,
  `tel_contacto` varchar(50) DEFAULT NULL,
  `tipo_gestion` varchar(50) DEFAULT NULL,
  `ubicacion_geografica` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cif_nif` varchar(50) DEFAULT NULL,
  `razon_social` varchar(200) DEFAULT NULL,
  `direccion_fiscal` text,
  `cp_postal` varchar(20) DEFAULT NULL,
  `email_facturacion` varchar(150) DEFAULT NULL,
  `tipo_cliente` varchar(50) DEFAULT NULL,
  `limite_credito_sucio` varchar(50) DEFAULT NULL,
  `fecha_alta_cliente` varchar(50) DEFAULT NULL,
  `activo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nif_nie` varchar(50) DEFAULT NULL,
  `nombre_completo` varchar(200) DEFAULT NULL,
  `email_corp` varchar(150) DEFAULT NULL,
  `f_alta` varchar(100) DEFAULT NULL,
  `puesto_rol` varchar(50) DEFAULT NULL,
  `salario_base_sucio` varchar(50) DEFAULT NULL,
  `num_ss` varchar(50) DEFAULT NULL,
  `almacen_id` int DEFAULT NULL,
  `seguro_medico` varchar(50) DEFAULT NULL,
  `activo_boolean` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(100) DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `vehiculo_id` int DEFAULT NULL,
  `empleado_id` int DEFAULT NULL,
  `f_salida` varchar(100) DEFAULT NULL,
  `f_llegada_prevista` varchar(100) DEFAULT NULL,
  `f_entrega_real` varchar(100) DEFAULT NULL,
  `peso_kg_bruto` varchar(50) DEFAULT NULL,
  `volumen_m3` varchar(50) DEFAULT NULL,
  `importe_envio` varchar(50) DEFAULT NULL,
  `seguro_contratado` varchar(50) DEFAULT NULL,
  `estado_envio` varchar(50) DEFAULT NULL,
  `almacen_destino_id` int DEFAULT NULL,
  `prioridad` varchar(20) DEFAULT NULL,
  `ruta_origen_ciudad` varchar(100) DEFAULT NULL,
  `ruta_destino_ciudad` varchar(100) DEFAULT NULL,
  `ruta_distancia_km` varchar(50) DEFAULT NULL,
  `ruta_peajes_estimados` varchar(50) DEFAULT NULL,
  `ruta_tiempo_estimado_h` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `envio_id` int DEFAULT NULL,
  `f_incidencia` varchar(50) DEFAULT NULL,
  `descripcion_breve` text,
  `coste_asociado_sucio` varchar(50) DEFAULT NULL,
  `responsable_id` int DEFAULT NULL,
  `estado_resolucion` varchar(50) DEFAULT NULL,
  `tipo_incidencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=506 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mantenimientos_flota`
--

DROP TABLE IF EXISTS `mantenimientos_flota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mantenimientos_flota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_id` int DEFAULT NULL,
  `f_mantenimiento` varchar(50) DEFAULT NULL,
  `taller_nombre` varchar(150) DEFAULT NULL,
  `coste_reparacion` varchar(50) DEFAULT NULL,
  `piezas_reemplazadas` text,
  `proxima_revision_estimada` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cif_prov` varchar(50) DEFAULT NULL,
  `nombre_comercial` varchar(150) DEFAULT NULL,
  `tipo_suministro` varchar(100) DEFAULT NULL,
  `tel_emergencias` varchar(50) DEFAULT NULL,
  `email_prov` varchar(150) DEFAULT NULL,
  `condiciones_pago` varchar(100) DEFAULT NULL,
  `valoracion_estrellas` varchar(10) DEFAULT NULL,
  `ultimo_pedido` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehiculos`
--

DROP TABLE IF EXISTS `vehiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matricula` varchar(50) DEFAULT NULL,
  `marca_modelo` varchar(150) DEFAULT NULL,
  `año_fabricacion` varchar(20) DEFAULT NULL,
  `capacidad_carga_kg` varchar(50) DEFAULT NULL,
  `f_ultima_itv` varchar(50) DEFAULT NULL,
  `estado_vehiculo` varchar(30) DEFAULT NULL,
  `num_bastidor_vin` varchar(100) DEFAULT NULL,
  `coordenadas_gps` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-14 12:35:45
