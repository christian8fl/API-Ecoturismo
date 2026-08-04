/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.32-MariaDB : Database - db_ecoturismo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_ecoturismo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_ecoturismo`;

/*Table structure for table `tbl_actividad` */

DROP TABLE IF EXISTS `tbl_actividad`;

CREATE TABLE `tbl_actividad` (
  `act_id` int(11) NOT NULL AUTO_INCREMENT,
  `act_nombre` varchar(100) NOT NULL,
  `act_descripcion` text DEFAULT NULL,
  `act_precio` decimal(10,2) NOT NULL,
  `act_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`act_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_actividad` */

/*Table structure for table `tbl_cabana` */

DROP TABLE IF EXISTS `tbl_cabana`;

CREATE TABLE `tbl_cabana` (
  `cab_id` int(11) NOT NULL AUTO_INCREMENT,
  `cab_num` varchar(20) NOT NULL,
  `cab_cap` int(11) NOT NULL,
  `cab_pre` decimal(10,2) NOT NULL,
  `cab_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`cab_id`),
  UNIQUE KEY `uq_cabana_num` (`cab_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_cabana` */

/*Table structure for table `tbl_huesped` */

DROP TABLE IF EXISTS `tbl_huesped`;

CREATE TABLE `tbl_huesped` (
  `hue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hue_nom` varchar(100) NOT NULL,
  `hue_ape` varchar(100) NOT NULL,
  `hue_cor` varchar(150) NOT NULL,
  `hue_tel` varchar(15) DEFAULT NULL,
  `hue_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`hue_id`),
  UNIQUE KEY `uq_huesped_cor` (`hue_cor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_huesped` */

/*Table structure for table `tbl_pago` */

DROP TABLE IF EXISTS `tbl_pago`;

CREATE TABLE `tbl_pago` (
  `pag_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `pag_fecha` datetime NOT NULL,
  `pag_monto` decimal(10,2) NOT NULL,
  `pag_metodo` varchar(50) NOT NULL DEFAULT 'Efectivo',
  `pag_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`pag_id`),
  KEY `fk_pago_reserva` (`res_id`),
  CONSTRAINT `fk_pago_reserva` FOREIGN KEY (`res_id`) REFERENCES `tbl_reserva` (`res_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_pago` */

/*Table structure for table `tbl_reserva` */

DROP TABLE IF EXISTS `tbl_reserva`;

CREATE TABLE `tbl_reserva` (
  `res_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) NOT NULL,
  `hue_id` int(11) NOT NULL,
  `cab_id` int(11) NOT NULL,
  `res_fec_ini` date NOT NULL,
  `res_fec_fin` date NOT NULL,
  `res_tot` decimal(10,2) NOT NULL DEFAULT 0.00,
  `res_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`res_id`),
  KEY `fk_reserva_usuario` (`usu_id`),
  KEY `fk_reserva_huesped` (`hue_id`),
  KEY `fk_reserva_cabana` (`cab_id`),
  CONSTRAINT `fk_reserva_cabana` FOREIGN KEY (`cab_id`) REFERENCES `tbl_cabana` (`cab_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reserva_huesped` FOREIGN KEY (`hue_id`) REFERENCES `tbl_huesped` (`hue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reserva_usuario` FOREIGN KEY (`usu_id`) REFERENCES `tbl_usuario` (`usu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_reserva` */

/*Table structure for table `tbl_reserva_actividad` */

DROP TABLE IF EXISTS `tbl_reserva_actividad`;

CREATE TABLE `tbl_reserva_actividad` (
  `ract_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) NOT NULL,
  `act_id` int(11) NOT NULL,
  `ract_cantidad` int(11) NOT NULL DEFAULT 1,
  `ract_precio_unitario` decimal(10,2) NOT NULL,
  `ract_subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ract_id`),
  KEY `fk_ract_reserva` (`res_id`),
  KEY `fk_ract_actividad` (`act_id`),
  CONSTRAINT `fk_ract_actividad` FOREIGN KEY (`act_id`) REFERENCES `tbl_actividad` (`act_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ract_reserva` FOREIGN KEY (`res_id`) REFERENCES `tbl_reserva` (`res_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_reserva_actividad` */

/*Table structure for table `tbl_usuario` */

DROP TABLE IF EXISTS `tbl_usuario`;

CREATE TABLE `tbl_usuario` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_nombre` varchar(100) NOT NULL,
  `usu_correo` varchar(150) NOT NULL,
  `usu_clave` varchar(255) NOT NULL,
  `usu_rol` varchar(50) NOT NULL DEFAULT 'Recepcionista',
  `usu_est` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`usu_id`),
  UNIQUE KEY `uq_usuario_correo` (`usu_correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_usuario` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
