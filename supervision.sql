-- phpMyAdmin SQL Dump
-- version 4.1.4
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 11 Mars 2025 à 12:51
-- Version du serveur :  5.6.15-log
-- Version de PHP :  5.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `supervision`
--

-- --------------------------------------------------------

--
-- Structure de la table `equipements`
--

CREATE TABLE IF NOT EXISTS `equipements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `etat` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `equipements`
--

INSERT INTO `equipements` (`id`, `nom`, `ip`, `etat`) VALUES
(1, 'Serveur Web', '192.168.1.10', 'En panne'),
(2, 'Serveur SSH', '192.168.1.20', 'En panne'),
(3, 'Routeur Principal', '192.168.1.1', 'En panne');

-- --------------------------------------------------------

--
-- Structure de la table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `message` text NOT NULL,
  `equipement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipement_id` (`equipement_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Contenu de la table `logs`
--

INSERT INTO `logs` (`id`, `timestamp`, `message`, `equipement_id`) VALUES
(1, '2025-03-08 17:13:22', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(2, '2025-03-08 17:14:05', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(3, '2025-03-08 17:14:16', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(4, '2025-03-08 17:14:23', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(5, '2025-03-08 17:15:01', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(6, '2025-03-08 17:15:09', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(7, '2025-03-08 17:19:32', 'ALERTE : Routeur Principal (192.168.1.1) est inactif !', 3),
(8, '2025-03-08 17:20:14', 'ÉCHEC DE RÉPARATION : Routeur Principal (192.168.1.1) toujours en panne.', 3),
(9, '2025-03-08 17:20:19', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(10, '2025-03-08 17:21:09', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(11, '2025-03-08 17:21:17', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(12, '2025-03-08 17:21:22', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(13, '2025-03-08 17:21:57', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(14, '2025-03-08 17:22:05', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(15, '2025-03-08 18:37:28', 'Routeur Principal (192.168.1.1) est inactif !', 3),
(16, '2025-03-08 18:38:07', 'Serveur Web (192.168.1.10) est inactif !', 1),
(17, '2025-03-08 18:38:44', 'Serveur SSH (192.168.1.20) est inactif !', 2),
(18, '2025-03-08 19:30:43', 'Routeur Principal (192.168.1.1) est inactif !', 3),
(19, '2025-03-08 19:31:23', 'Serveur Web (192.168.1.10) est inactif !', 1),
(20, '2025-03-08 19:31:58', 'Serveur SSH (192.168.1.20) est inactif !', 2),
(21, '2025-03-08 19:40:12', 'ALERTE : Routeur Principal (192.168.1.1) est inactif !', 3),
(22, '2025-03-08 19:40:51', 'ÉCHEC DE RÉPARATION : Routeur Principal (192.168.1.1) toujours en panne.', 3),
(23, '2025-03-08 19:40:56', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(24, '2025-03-08 19:41:31', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(25, '2025-03-08 19:41:45', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(26, '2025-03-08 19:41:53', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(27, '2025-03-08 19:42:34', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(28, '2025-03-08 19:42:42', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(29, '2025-03-08 19:43:47', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(30, '2025-03-08 19:44:26', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(31, '2025-03-08 19:44:38', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(32, '2025-03-08 19:44:46', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(33, '2025-03-08 20:00:21', 'ALERTE : Routeur Principal (192.168.1.1) est inactif !', 3),
(34, '2025-03-08 20:01:07', 'ÉCHEC DE RÉPARATION : Routeur Principal (192.168.1.1) toujours en panne.', 3),
(35, '2025-03-08 20:01:14', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(36, '2025-03-08 20:01:54', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(37, '2025-03-08 20:02:12', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(38, '2025-03-08 20:02:25', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(39, '2025-03-08 20:03:04', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(40, '2025-03-08 20:03:25', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(41, '2025-03-11 12:26:05', 'ALERTE : Routeur Principal (192.168.1.1) est inactif !', 3),
(42, '2025-03-11 12:27:03', 'ÉCHEC DE RÉPARATION : Routeur Principal (192.168.1.1) toujours en panne.', 3),
(43, '2025-03-11 12:27:15', 'ALERTE : Serveur Web (192.168.1.10) est inactif !', 1),
(44, '2025-03-11 12:28:11', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(45, '2025-03-11 12:28:38', 'ÉCHEC DE RÉPARATION : Serveur Web (192.168.1.10) toujours en panne.', 1),
(46, '2025-03-11 12:28:48', 'ALERTE : Serveur SSH (192.168.1.20) est inactif !', 2),
(47, '2025-03-11 12:29:31', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2),
(48, '2025-03-11 12:30:07', 'ÉCHEC DE RÉPARATION : Serveur SSH (192.168.1.20) toujours en panne.', 2);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
