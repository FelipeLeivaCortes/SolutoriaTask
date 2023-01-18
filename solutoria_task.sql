-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-01-2023 a las 17:19:59
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `easyappointments`
--
CREATE DATABASE IF NOT EXISTS `easyappointments` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `easyappointments`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_appointments`
--

CREATE TABLE `ea_appointments` (
  `id` int(11) NOT NULL,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `location` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `hash` text DEFAULT NULL,
  `is_unavailable` tinyint(4) NOT NULL DEFAULT 0,
  `id_users_provider` int(11) DEFAULT NULL,
  `id_users_customer` int(11) DEFAULT NULL,
  `id_services` int(11) DEFAULT NULL,
  `id_google_calendar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_consents`
--

CREATE TABLE `ea_consents` (
  `id` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(256) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `ip` varchar(256) DEFAULT NULL,
  `type` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_migrations`
--

CREATE TABLE `ea_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_migrations`
--

INSERT INTO `ea_migrations` (`version`) VALUES
(21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_roles`
--

CREATE TABLE `ea_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL,
  `appointments` int(11) DEFAULT NULL,
  `customers` int(11) DEFAULT NULL,
  `services` int(11) DEFAULT NULL,
  `users` int(11) DEFAULT NULL,
  `system_settings` int(11) DEFAULT NULL,
  `user_settings` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_roles`
--

INSERT INTO `ea_roles` (`id`, `name`, `slug`, `is_admin`, `appointments`, `customers`, `services`, `users`, `system_settings`, `user_settings`) VALUES
(1, 'Administrator', 'admin', 1, 15, 15, 15, 15, 15, 15),
(2, 'Provider', 'provider', 0, 15, 15, 0, 0, 0, 15),
(3, 'Customer', 'customer', 0, 0, 0, 0, 0, 0, 0),
(4, 'Secretary', 'secretary', 0, 15, 15, 0, 0, 0, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_secretaries_providers`
--

CREATE TABLE `ea_secretaries_providers` (
  `id_users_secretary` int(11) NOT NULL,
  `id_users_provider` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_services`
--

CREATE TABLE `ea_services` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `availabilities_type` varchar(32) DEFAULT 'flexible',
  `attendants_number` int(11) DEFAULT 1,
  `id_service_categories` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_services`
--

INSERT INTO `ea_services` (`id`, `name`, `duration`, `price`, `currency`, `description`, `location`, `availabilities_type`, `attendants_number`, `id_service_categories`) VALUES
(1, 'Service', 30, '0.00', '', NULL, NULL, 'flexible', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_services_providers`
--

CREATE TABLE `ea_services_providers` (
  `id_users` int(11) NOT NULL,
  `id_services` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_services_providers`
--

INSERT INTO `ea_services_providers` (`id_users`, `id_services`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_service_categories`
--

CREATE TABLE `ea_service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_settings`
--

CREATE TABLE `ea_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_settings`
--

INSERT INTO `ea_settings` (`id`, `name`, `value`) VALUES
(1, 'company_working_plan', '{\"monday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"tuesday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"wednesday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"thursday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"friday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"saturday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"sunday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]}}'),
(2, 'book_advance_timeout', '30'),
(3, 'google_analytics_code', ''),
(4, 'customer_notifications', '1'),
(5, 'date_format', 'DMY'),
(6, 'require_captcha', '0'),
(7, 'time_format', 'regular'),
(8, 'display_cookie_notice', '0'),
(9, 'cookie_notice_content', 'Cookie notice content.'),
(10, 'display_terms_and_conditions', '0'),
(11, 'terms_and_conditions_content', 'Terms and conditions content.'),
(12, 'display_privacy_policy', '0'),
(13, 'privacy_policy_content', 'Privacy policy content.'),
(14, 'first_weekday', 'sunday'),
(15, 'require_phone_number', '1'),
(16, 'api_token', ''),
(17, 'display_any_provider', '1'),
(18, 'company_name', 'Company 1'),
(19, 'company_email', 'company@test.com'),
(20, 'company_link', 'company.test');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_users`
--

CREATE TABLE `ea_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(512) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `mobile_number` varchar(128) DEFAULT NULL,
  `phone_number` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(256) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip_code` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `timezone` varchar(256) DEFAULT 'UTC',
  `language` varchar(256) DEFAULT 'english',
  `id_roles` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_users`
--

INSERT INTO `ea_users` (`id`, `first_name`, `last_name`, `email`, `mobile_number`, `phone_number`, `address`, `city`, `state`, `zip_code`, `notes`, `timezone`, `language`, `id_roles`) VALUES
(1, 'Felipe', 'Leiva', 'felipe-leiva@hotmail.cl', NULL, '123456789', NULL, NULL, NULL, NULL, NULL, 'UTC', 'english', 1),
(2, 'Jane', 'Doe', 'jane@example.org', NULL, '+1 (000) 000-0000', NULL, NULL, NULL, NULL, NULL, 'UTC', 'english', 2),
(3, 'James', 'Doe', 'james@example.org', NULL, '+1 (000) 000-0000', NULL, NULL, NULL, NULL, NULL, 'UTC', 'english', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_user_settings`
--

CREATE TABLE `ea_user_settings` (
  `id_users` int(11) NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text DEFAULT NULL,
  `working_plan_exceptions` text DEFAULT NULL,
  `notifications` tinyint(4) DEFAULT NULL,
  `google_sync` tinyint(4) DEFAULT NULL,
  `google_token` text DEFAULT NULL,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT 30,
  `sync_future_days` int(11) DEFAULT 90,
  `calendar_view` varchar(32) DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_user_settings`
--

INSERT INTO `ea_user_settings` (`id_users`, `username`, `password`, `salt`, `working_plan`, `working_plan_exceptions`, `notifications`, `google_sync`, `google_token`, `google_calendar`, `sync_past_days`, `sync_future_days`, `calendar_view`) VALUES
(1, 'felipe', '6932fb049a8e826a3dcbbd08f0ea435079e4c2db82889fec6ad8fe3c38e1f074', '1b63a16edd31f437bfa6b8f7ebabf4d6d3f4965fa896650c27982bdb129cb300', NULL, NULL, 1, NULL, NULL, NULL, 30, 90, 'default'),
(2, 'janedoe', '759cad71eed7b5ad0b01a50880e10dce9bbdd93229ec8f7dd7c1c9199e7305a2', 'dc7d36568d58a8acdbbd1772c0b6db9e284714d5e048f5a7bd03a9ff202dcea6', '{\"monday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"tuesday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"wednesday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"thursday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"friday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"saturday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"sunday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"14:30\",\"end\":\"15:00\"}]}}', NULL, 1, 0, NULL, NULL, 30, 90, 'default');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_users_provider` (`id_users_provider`),
  ADD KEY `id_users_customer` (`id_users_customer`),
  ADD KEY `id_services` (`id_services`);

--
-- Indices de la tabla `ea_consents`
--
ALTER TABLE `ea_consents`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_roles`
--
ALTER TABLE `ea_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  ADD KEY `secretaries_users_provider` (`id_users_provider`);

--
-- Indices de la tabla `ea_services`
--
ALTER TABLE `ea_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_categories` (`id_service_categories`);

--
-- Indices de la tabla `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD PRIMARY KEY (`id_users`,`id_services`),
  ADD KEY `services_providers_services` (`id_services`);

--
-- Indices de la tabla `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_settings`
--
ALTER TABLE `ea_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_users`
--
ALTER TABLE `ea_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_roles` (`id_roles`);

--
-- Indices de la tabla `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ea_consents`
--
ALTER TABLE `ea_consents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ea_roles`
--
ALTER TABLE `ea_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ea_services`
--
ALTER TABLE `ea_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ea_settings`
--
ALTER TABLE `ea_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `ea_users`
--
ALTER TABLE `ea_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD CONSTRAINT `appointments_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_customer` FOREIGN KEY (`id_users_customer`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD CONSTRAINT `secretaries_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `secretaries_users_secretary` FOREIGN KEY (`id_users_secretary`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_services`
--
ALTER TABLE `ea_services`
  ADD CONSTRAINT `services_service_categories` FOREIGN KEY (`id_service_categories`) REFERENCES `ea_service_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD CONSTRAINT `services_providers_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `services_providers_users_provider` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_users`
--
ALTER TABLE `ea_users`
  ADD CONSTRAINT `users_roles` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD CONSTRAINT `user_settings_users` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `easy_b`
--
CREATE DATABASE IF NOT EXISTS `easy_b` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `easy_b`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_appointments`
--

CREATE TABLE `ea_appointments` (
  `id` int(11) NOT NULL,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `location` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `hash` text DEFAULT NULL,
  `is_unavailable` tinyint(4) NOT NULL DEFAULT 0,
  `id_users_provider` int(11) DEFAULT NULL,
  `id_users_customer` int(11) DEFAULT NULL,
  `id_services` int(11) DEFAULT NULL,
  `id_google_calendar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_appointments`
--

INSERT INTO `ea_appointments` (`id`, `book_datetime`, `start_datetime`, `end_datetime`, `location`, `notes`, `hash`, `is_unavailable`, `id_users_provider`, `id_users_customer`, `id_services`, `id_google_calendar`) VALUES
(10, '2021-12-27 03:03:18', '2021-12-28 12:45:00', '2021-12-28 13:45:00', NULL, '', 'E3PGSf2YaJwQ', 0, 7, 8, 5, NULL),
(12, '2021-12-27 03:20:20', '2021-12-28 09:15:00', '2021-12-28 10:15:00', NULL, '', '5XSlRcaB40KE', 0, 7, 8, 5, NULL),
(13, '2022-01-03 00:26:35', '2022-01-19 09:30:00', '2022-01-19 10:30:00', NULL, '', 'nWEFdVy6Ra5X', 0, 7, 8, 5, NULL),
(14, '2022-01-03 02:14:15', '2022-01-03 05:45:00', '2022-01-03 06:15:00', NULL, '', 'TK9Vxycq6SPs', 0, 6, 10, 4, NULL),
(15, '2022-01-03 19:09:52', '2022-01-03 15:45:00', '2022-01-03 16:45:00', NULL, '', '0EPvxFkNBwre', 0, 6, 12, 18, NULL),
(16, '2022-01-03 20:17:28', '2022-01-03 17:00:00', '2022-01-03 17:30:00', NULL, '', 'KyoUmGIN2Rr0', 0, 6, 13, 4, NULL),
(17, '2022-01-09 13:47:18', '2022-01-09 10:30:00', '2022-01-09 11:00:00', NULL, '', 'd21q5gV9IFba', 0, 6, 8, 4, NULL),
(18, '2022-01-09 16:31:00', '2022-01-09 13:15:00', '2022-01-09 13:45:00', NULL, '', '2LYKRUqAGkwS', 0, 6, 8, 4, NULL),
(19, '2022-01-10 14:43:55', '2022-01-10 11:45:00', '2022-01-10 12:15:00', NULL, '', 'opc3EgSVkwIY', 0, 6, 8, 3, NULL),
(20, '2022-01-27 13:29:39', '2022-01-27 19:00:00', '2022-01-27 19:30:00', NULL, '', '5bKFsBgknXha', 0, 6, 8, 2, NULL),
(21, '2022-01-27 13:35:21', '2022-01-27 11:30:00', '2022-01-27 12:00:00', NULL, '', 'ie6HNMw3IVDg', 0, 6, 8, 4, NULL),
(22, '2022-01-27 13:36:28', '2022-01-27 13:30:00', '2022-01-27 14:00:00', NULL, '', 'xnD2e0VURYql', 0, 6, 8, 4, NULL),
(23, '2022-01-27 13:38:26', '2022-01-27 09:00:00', '2022-01-27 09:15:00', '', '', '8jXWigPBdU9C', 0, 6, 14, 4, NULL),
(24, '2022-01-27 17:36:14', '2022-01-27 14:30:00', '2022-01-27 15:00:00', NULL, '', 'LNqr4JYv7cCI', 0, 6, 15, 2, NULL),
(25, '2022-01-27 17:46:57', '2022-01-27 15:00:00', '2022-01-27 15:30:00', NULL, '', 'A5vh98JdreOg', 0, 6, 8, 2, NULL),
(40, '2022-02-01 17:19:18', '2022-02-01 18:30:00', '2022-02-01 19:30:00', NULL, '', 'KoP2mx3QGZUg', 0, 7, 17, 12, NULL),
(41, '2022-02-01 19:04:42', '2022-02-23 11:00:00', '2022-02-23 11:30:00', NULL, '', 'CqX10Q79ylEZ', 0, 6, 17, 20, NULL),
(42, '2022-02-09 14:38:19', '2022-02-09 16:30:00', '2022-02-09 17:00:00', NULL, '', 'ISdmgBquyORC', 0, 6, 17, 2, NULL),
(43, '2022-02-09 14:38:57', '2022-02-09 18:00:00', '2022-02-09 18:30:00', NULL, '', 'MvSUIiPu7F8s', 0, 6, 17, 2, NULL),
(44, '2022-02-09 14:41:35', '2022-02-10 17:00:00', '2022-02-10 17:15:00', '', '', 'ckxwps9zWiVJ', 0, 6, 17, 2, NULL),
(45, '2022-02-09 14:42:13', '2022-02-11 16:00:00', '2022-02-11 16:15:00', '', '', 'ZO7lCq01FWLf', 0, 6, 17, 2, NULL),
(46, '2022-02-10 17:21:03', '2022-02-10 18:45:00', '2022-02-10 19:15:00', NULL, '', 'IbM3G94KgJcR', 0, 6, 17, 2, NULL),
(47, '2022-02-10 17:23:50', '2022-02-10 16:30:00', '2022-02-10 17:00:00', NULL, '', '2gdlQPpImTJx', 0, 6, 17, 2, NULL),
(48, '2022-03-11 14:24:03', '2022-03-08 10:30:00', '2022-03-08 10:45:00', '', '', 'xQWryCdcIoBS', 0, 7, 14, 5, NULL),
(49, '2022-04-14 02:55:15', '2022-04-14 11:00:00', '2022-04-14 11:30:00', NULL, '', 'Nw5ndpAZ6tC8', 0, 6, 8, 2, NULL),
(50, '2022-04-14 02:56:16', '2022-04-14 14:00:00', '2022-04-14 14:30:00', NULL, '', 'ZahX2PkiKgAt', 0, 6, 17, 2, NULL),
(51, '2022-04-14 02:58:19', '2022-04-14 16:30:00', '2022-04-14 17:00:00', NULL, '', 'bdxn3ge7NlcQ', 0, 6, 17, 2, NULL),
(52, '2022-04-14 03:13:31', '2022-04-14 15:30:00', '2022-04-14 16:00:00', NULL, '', 'xuiLbR8qdDke', 0, 6, 17, 2, NULL),
(53, '2022-04-14 03:19:08', '2022-04-20 10:00:00', '2022-04-20 10:30:00', NULL, '', 'astjQUpBISwb', 0, 6, 17, 2, NULL),
(54, '2022-04-14 03:24:58', '2022-04-14 12:30:00', '2022-04-14 13:00:00', NULL, '', 'okWDUfTyBXnv', 0, 6, 17, 2, NULL),
(55, '2022-04-14 03:30:13', '2022-04-14 12:00:00', '2022-04-14 12:30:00', NULL, '', 'rgE2uSy9l1PW', 0, 6, 17, 2, NULL),
(56, '2022-04-14 03:35:12', '2022-04-14 16:00:00', '2022-04-14 16:30:00', NULL, '', 'geW7djaT2nuI', 0, 6, 17, 2, NULL),
(57, '2022-04-14 03:37:51', '2022-04-14 13:00:00', '2022-04-14 13:30:00', NULL, '', 'b5h7aMvnFtqy', 0, 6, 17, 2, NULL),
(58, '2022-04-14 16:35:38', '2022-04-14 19:00:00', '2022-04-14 19:30:00', NULL, '', 'bHmVPhMyzwET', 0, 6, 19, 2, NULL),
(59, '2022-04-14 16:43:21', '2022-04-14 18:00:00', '2022-04-14 18:30:00', NULL, '', 'DdvsIJzFxVk8', 0, 6, 14, 2, NULL),
(60, '2022-04-14 16:45:09', '2022-04-14 18:30:00', '2022-04-14 19:00:00', NULL, '', 'eUWEbmwYyDtK', 0, 6, 17, 2, NULL),
(61, '2022-08-28 17:17:18', '2022-08-30 10:00:00', '2022-08-30 10:30:00', NULL, '', 'yzd3c9j0gmtp', 0, 6, 17, 2, NULL),
(62, '2022-08-28 17:19:09', '2022-08-30 11:30:00', '2022-08-30 12:00:00', NULL, '', 'CUwefPQSqVHL', 0, 6, 17, 2, NULL),
(63, '2022-08-28 17:25:31', '2022-08-30 10:30:00', '2022-08-30 11:00:00', NULL, '', 'YerkAVl1XLmz', 0, 6, 17, 2, NULL),
(64, '2022-08-28 17:26:46', '2022-08-30 13:00:00', '2022-08-30 13:30:00', NULL, '', 'Yiem5DpCnX6w', 0, 6, 17, 2, NULL),
(65, '2022-08-28 17:29:10', '2022-08-30 14:00:00', '2022-08-30 14:30:00', NULL, '', 'rSDjwlYicHnI', 0, 6, 17, 2, NULL),
(66, '2022-08-28 17:31:10', '2022-08-30 14:30:00', '2022-08-30 15:00:00', NULL, '', '0zNZ9A7qDQwd', 0, 6, 17, 2, NULL),
(67, '2022-08-28 17:45:41', '2022-08-30 12:30:00', '2022-08-30 13:00:00', NULL, '', 'f67wIxbFpCz0', 0, 6, 17, 2, NULL),
(68, '2022-08-28 17:47:49', '2022-08-31 11:00:00', '2022-08-31 11:30:00', NULL, '', 'J6hQlLeZRmAv', 0, 6, 17, 2, NULL),
(69, '2022-08-28 17:54:21', '2022-08-30 15:00:00', '2022-08-30 15:30:00', NULL, '', 'oV4IUcjBCqDX', 0, 6, 17, 2, NULL),
(70, '2022-08-29 00:32:49', '2022-08-31 14:00:00', '2022-08-31 14:30:00', NULL, '', 'J8HOiEwk4QIS', 0, 6, 17, 2, NULL),
(71, '2022-08-29 00:34:36', '2022-08-31 12:30:00', '2022-08-31 13:00:00', NULL, '', 'hm1r6BfM0Xiu', 0, 6, 17, 2, NULL),
(72, '2022-08-29 00:46:24', '2022-08-30 18:00:00', '2022-08-30 18:30:00', NULL, '', 'bAUM2L89T0jQ', 0, 6, 17, 2, NULL),
(73, '2022-08-29 00:46:59', '2022-08-30 18:30:00', '2022-08-30 19:00:00', NULL, '', 'gU91EktMDFvK', 0, 6, 17, 2, NULL),
(74, '2022-08-29 00:50:43', '2022-08-31 14:30:00', '2022-08-31 15:00:00', NULL, '', 'VgjcqCrzXs6P', 0, 6, 17, 2, NULL),
(75, '2022-08-29 01:02:14', '2022-08-31 15:30:00', '2022-08-31 16:00:00', NULL, '', 'Nw064OClYBP8', 0, 6, 17, 2, NULL),
(76, '2022-08-29 01:04:51', '2022-08-30 16:00:00', '2022-08-30 16:30:00', NULL, '', 'FgjaBvYJTpO4', 0, 6, 17, 2, NULL),
(77, '2022-08-29 01:13:02', '2022-08-30 16:30:00', '2022-08-30 17:00:00', NULL, '', '7qEjmUXHb9PO', 0, 6, 17, 2, NULL),
(78, '2022-08-29 01:19:45', '2022-08-30 11:00:00', '2022-08-30 11:30:00', NULL, '', 'w92ei5vQ3OMj', 0, 6, 17, 2, NULL),
(79, '2022-08-29 01:20:19', '2022-08-30 15:30:00', '2022-08-30 16:00:00', NULL, '', 'BLcHUxWze3QI', 0, 6, 17, 2, NULL),
(80, '2022-08-29 01:25:33', '2022-08-30 13:30:00', '2022-08-30 14:00:00', NULL, '', 'H95usvgrtELK', 0, 6, 17, 2, NULL),
(81, '2022-08-29 01:36:21', '2022-08-30 12:00:00', '2022-08-30 12:30:00', NULL, '', 'ChY3w0IGMuXR', 0, 6, 17, 2, NULL),
(82, '2022-08-29 01:40:24', '2022-09-01 12:30:00', '2022-09-01 13:00:00', NULL, '', 'C3Gi4BJe0Pdu', 0, 6, 17, 2, NULL),
(83, '2022-08-29 01:41:11', '2022-08-30 19:00:00', '2022-08-30 19:30:00', NULL, '', 'rdtukmSHcQDY', 0, 6, 17, 2, NULL),
(84, '2022-08-29 16:34:07', '2022-08-31 16:30:00', '2022-08-31 17:00:00', NULL, '', 'kL4gJSWyT3N5', 0, 6, 17, 2, NULL),
(85, '2022-08-29 16:34:57', '2022-08-31 11:30:00', '2022-08-31 12:00:00', NULL, '', 'LNq3hWOtv1lc', 0, 6, 17, 2, NULL),
(86, '2022-08-29 16:36:15', '2022-09-01 11:00:00', '2022-09-01 11:30:00', NULL, '', 'ymgt3kVw20Ap', 0, 6, 17, 2, NULL),
(87, '2022-08-29 16:37:54', '2022-08-30 19:30:00', '2022-08-30 20:00:00', NULL, '', 'TSdElsy7k2qn', 0, 6, 17, 2, NULL),
(88, '2022-08-29 16:39:43', '2022-08-31 19:00:00', '2022-08-31 19:30:00', NULL, '', 'kDbeSOZnVcRx', 0, 6, 17, 2, NULL),
(89, '2022-08-29 16:40:30', '2022-10-19 13:00:00', '2022-10-19 13:30:00', NULL, '', 'sVNmxqXS8Hje', 0, 6, 17, 2, NULL),
(90, '2022-08-29 16:44:11', '2022-09-14 14:00:00', '2022-09-14 14:30:00', NULL, '', 'joMtISAm3WgE', 0, 6, 17, 2, NULL),
(91, '2022-08-29 16:45:29', '2022-10-18 19:00:00', '2022-10-18 19:30:00', NULL, '', 'og8jynM19E0e', 0, 6, 17, 2, NULL),
(92, '2022-08-29 16:53:44', '2022-09-20 10:00:00', '2022-09-20 10:30:00', NULL, '', 'bP76pIuOXacz', 0, 6, 17, 2, NULL),
(93, '2022-08-29 16:54:50', '2022-09-15 13:30:00', '2022-09-15 14:00:00', NULL, '', 'Vglx7BTSQ8wJ', 0, 6, 17, 2, NULL),
(94, '2022-08-29 16:57:39', '2022-10-11 14:30:00', '2022-10-11 15:00:00', NULL, '', 'MhZHRA1cG2Q4', 0, 6, 17, 2, NULL),
(95, '2022-08-29 17:02:51', '2022-10-12 13:30:00', '2022-10-12 14:00:00', NULL, '', 'oISjwLPxNFDc', 0, 6, 17, 2, NULL),
(96, '2022-08-29 17:03:38', '2022-09-14 10:00:00', '2022-09-14 10:30:00', NULL, '', 'qUdpZSo2jz7s', 0, 6, 17, 2, NULL),
(97, '2022-08-29 17:04:48', '2022-09-27 14:30:00', '2022-09-27 15:00:00', NULL, '', 'uy2FIWCosmU3', 0, 6, 17, 2, NULL),
(98, '2022-08-29 17:12:09', '2022-09-28 14:30:00', '2022-09-28 15:00:00', NULL, '', 'XJqc04VlhrdM', 0, 6, 17, 2, NULL),
(99, '2022-08-29 17:14:23', '2022-09-27 10:00:00', '2022-09-27 10:30:00', NULL, '', 'HK2UeWtyQM7D', 0, 6, 17, 2, NULL),
(100, '2022-08-29 17:16:08', '2022-10-26 14:30:00', '2022-10-26 15:00:00', NULL, '', 'Spf0Z6UmevLX', 0, 6, 17, 2, NULL),
(101, '2022-08-29 17:18:53', '2022-09-22 14:30:00', '2022-09-22 15:00:00', NULL, '', 'E60eQ73ZrjaM', 0, 6, 17, 2, NULL),
(102, '2022-08-29 17:26:26', '2022-09-21 16:00:00', '2022-09-21 16:30:00', NULL, '', 'hi0AX7tUb29T', 0, 6, 17, 2, NULL),
(103, '2022-08-29 17:27:40', '2022-09-16 10:00:00', '2022-09-16 10:30:00', NULL, '', 'IS3xKjoGEsOM', 0, 6, 17, 2, NULL),
(104, '2022-08-29 17:59:07', '2022-09-21 14:30:00', '2022-09-21 15:00:00', NULL, '', 'xwcmAdhk8olf', 0, 6, 17, 2, NULL),
(105, '2022-08-29 18:02:11', '2022-08-31 19:30:00', '2022-08-31 20:00:00', NULL, '', 'G3tMyfag4mC1', 0, 6, 17, 2, NULL),
(106, '2022-08-29 18:03:46', '2022-09-22 18:00:00', '2022-09-22 18:30:00', NULL, '', 'PoUwMbd1LxE4', 0, 6, 17, 2, NULL),
(107, '2022-08-29 18:06:36', '2022-09-28 14:00:00', '2022-09-28 14:30:00', NULL, '', 'ht64THaOd82z', 0, 6, 17, 2, NULL),
(108, '2022-08-29 18:08:24', '2022-09-15 16:30:00', '2022-09-15 17:00:00', NULL, '', 'XVZG9panC4y3', 0, 6, 17, 2, NULL),
(109, '2022-08-29 18:12:03', '2022-09-08 19:30:00', '2022-09-08 20:00:00', NULL, '', 'ydMVW0clLzja', 0, 6, 17, 2, NULL),
(110, '2022-08-29 18:13:21', '2022-09-16 19:30:00', '2022-09-16 20:00:00', NULL, '', '8GECRlf6wPQd', 0, 6, 17, 2, NULL),
(111, '2022-08-29 18:17:14', '2022-09-08 15:30:00', '2022-09-08 16:00:00', NULL, '', 'vT9XksBeqmgY', 0, 6, 17, 2, NULL),
(112, '2022-08-29 18:18:24', '2022-09-22 10:00:00', '2022-09-22 10:30:00', NULL, '', 'iET9pYRGNzS3', 0, 6, 17, 2, NULL),
(113, '2022-08-29 18:19:50', '2022-09-23 19:30:00', '2022-09-23 20:00:00', NULL, '', 'bk9xJmget7sq', 0, 6, 17, 2, NULL),
(114, '2022-08-29 18:21:07', '2022-09-20 19:30:00', '2022-09-20 20:00:00', NULL, '', 'TBj4KJw6YMH7', 0, 6, 17, 2, NULL),
(115, '2022-08-29 18:27:27', '2022-08-30 17:00:00', '2022-08-30 17:30:00', NULL, '', 'WFQIukdciH1p', 0, 6, 17, 2, NULL),
(116, '2022-08-29 18:30:55', '2022-10-07 16:30:00', '2022-10-07 17:00:00', NULL, '', 'BhAW3qUDV2Q8', 0, 6, 17, 2, NULL),
(117, '2022-08-29 18:35:14', '2022-09-28 10:30:00', '2022-09-28 11:00:00', NULL, '', 'MV0rcBHQ1f7N', 0, 6, 17, 2, NULL),
(118, '2022-08-29 18:45:26', '2022-09-21 16:30:00', '2022-09-21 17:00:00', NULL, '', 'IbS6ORC1PVAa', 0, 6, 17, 2, NULL),
(119, '2022-09-28 16:40:35', '2022-09-28 15:00:00', '2022-09-28 16:30:00', NULL, '', 'psN9nChJW0te', 0, 7, 8, 6, NULL),
(120, '2022-12-25 22:12:21', '2022-12-26 10:00:00', '2022-12-26 11:30:00', NULL, '', 'AHgP0rbCa8oc', 0, 7, 8, 6, NULL),
(121, '2022-12-25 22:13:25', '2022-12-26 11:30:00', '2022-12-26 13:00:00', NULL, '', 'AZNvE5jo4GT1', 0, 7, 8, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_consents`
--

CREATE TABLE `ea_consents` (
  `id` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(256) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `ip` varchar(256) DEFAULT NULL,
  `type` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_migrations`
--

CREATE TABLE `ea_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_migrations`
--

INSERT INTO `ea_migrations` (`version`) VALUES
(21),
(21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_roles`
--

CREATE TABLE `ea_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL,
  `appointments` int(11) DEFAULT NULL,
  `customers` int(11) DEFAULT NULL,
  `services` int(11) DEFAULT NULL,
  `users` int(11) DEFAULT NULL,
  `system_settings` int(11) DEFAULT NULL,
  `user_settings` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_roles`
--

INSERT INTO `ea_roles` (`id`, `name`, `slug`, `is_admin`, `appointments`, `customers`, `services`, `users`, `system_settings`, `user_settings`) VALUES
(1, 'Administrator', 'admin', 1, 15, 15, 15, 15, 15, 15),
(2, 'Provider', 'provider', 0, 15, 15, 0, 0, 0, 15),
(3, 'Customer', 'customer', 0, 0, 0, 0, 0, 0, 0),
(4, 'Secretary', 'secretary', 0, 15, 15, 0, 0, 0, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_secretaries_providers`
--

CREATE TABLE `ea_secretaries_providers` (
  `id_users_secretary` int(11) NOT NULL,
  `id_users_provider` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_services`
--

CREATE TABLE `ea_services` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `availabilities_type` varchar(32) DEFAULT 'flexible',
  `attendants_number` int(11) DEFAULT 1,
  `id_service_categories` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_services`
--

INSERT INTO `ea_services` (`id`, `name`, `duration`, `price`, `currency`, `description`, `location`, `availabilities_type`, `attendants_number`, `id_service_categories`) VALUES
(1, 'Service', 30, '0.00', '', NULL, NULL, 'flexible', 1, NULL),
(2, ' Corte', 30, '600.00', '$', '', '', 'flexible', 1, 1),
(3, 'Corte + Barba', 30, '0.00', '$', '', '', 'flexible', 1, 1),
(4, 'Barba', 30, '400.00', '$', '', '', 'flexible', 1, 1),
(5, ' Henna', 60, '500.00', '$', '', '', 'flexible', 1, 2),
(6, 'Pestañas - Clasicas', 90, '900.00', '$', '', '', 'flexible', 1, 2),
(7, 'Vol media', 150, '1300.00', '$', '', '', 'flexible', 1, 2),
(8, 'Vol ruso', 180, '1500.00', '', '', '', 'flexible', 1, 2),
(9, 'Vol mega', 180, '1700.00', '$', '', '', 'flexible', 1, 2),
(10, 'Permanente', 60, '700.00', '$', '', '', 'flexible', 1, 2),
(11, 'Lifting', 60, '700.00', '$', '', '', 'flexible', 1, 2),
(12, 'Perfilado de cejas', 60, '500.00', '$', '', '', 'flexible', 1, 2),
(13, 'Perfilado de cejas + Henna', 90, '900.00', '$', '', '', 'flexible', 1, 2),
(14, 'Semipermanente de manos', 60, '900.00', '$', '', '', 'flexible', 1, 3),
(15, 'Semipermanente de pies', 60, '1000.00', '$', '', '', 'flexible', 1, 3),
(16, 'Kapping', 90, '1100.00', '$', '', '', 'flexible', 1, 3),
(17, 'Esculpidas en Gel', 120, '1300.00', '$', '', '', 'flexible', 1, 3),
(18, 'Corte + Reflejos', 60, '0.00', '$', '', '', 'flexible', 1, 1),
(19, 'Corte dama', 30, '0.00', '$', '', '', 'flexible', 1, 1),
(20, 'Color', 30, '0.00', '$', '', '', 'flexible', 1, 1),
(21, 'Alisado de Hombre', 60, '700.00', '', '', '', 'flexible', 1, 1),
(22, 'Corte + Color', 60, '0.00', '', '', '', 'flexible', 1, 1),
(23, 'Service de Esculpidas', 30, '1100.00', '', '', '', 'flexible', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_services_providers`
--

CREATE TABLE `ea_services_providers` (
  `id_users` int(11) NOT NULL,
  `id_services` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_services_providers`
--

INSERT INTO `ea_services_providers` (`id_users`, `id_services`) VALUES
(6, 2),
(6, 3),
(6, 4),
(6, 18),
(6, 19),
(6, 20),
(6, 21),
(6, 22),
(7, 3),
(7, 5),
(7, 6),
(7, 7),
(7, 8),
(7, 9),
(7, 10),
(7, 11),
(7, 12),
(7, 13),
(7, 15),
(11, 14),
(11, 15),
(11, 16),
(11, 17),
(11, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_service_categories`
--

CREATE TABLE `ea_service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_service_categories`
--

INSERT INTO `ea_service_categories` (`id`, `name`, `description`) VALUES
(1, 'Peluqueria - Barberia', ''),
(2, 'Lashes E.M', ''),
(3, 'Ped - Manicura', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_settings`
--

CREATE TABLE `ea_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_settings`
--

INSERT INTO `ea_settings` (`id`, `name`, `value`) VALUES
(1, 'company_working_plan', '{\"sunday\":null,\"monday\":null,\"tuesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"wednesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"thursday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"friday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"saturday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]}}'),
(2, 'book_advance_timeout', '120'),
(3, 'google_analytics_code', ''),
(4, 'customer_notifications', '1'),
(5, 'date_format', 'DMY'),
(6, 'require_captcha', '0'),
(7, 'time_format', 'regular'),
(8, 'display_cookie_notice', '0'),
(9, 'cookie_notice_content', 'Cookie notice content.'),
(10, 'display_terms_and_conditions', '0'),
(11, 'terms_and_conditions_content', 'Terms and conditions content.'),
(12, 'display_privacy_policy', '0'),
(13, 'privacy_policy_content', 'Privacy policy content.'),
(14, 'first_weekday', 'sunday'),
(15, 'require_phone_number', '1'),
(16, 'api_token', ''),
(17, 'display_any_provider', '0'),
(18, 'company_name', 'Barberia - Peluqueria'),
(19, 'company_email', 'info@barberiapeluqueria-ezequielmino.com.ar'),
(20, 'company_link', 'www.google.com.ar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_users`
--

CREATE TABLE `ea_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(512) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `mobile_number` varchar(128) DEFAULT NULL,
  `phone_number` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(256) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip_code` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `timezone` varchar(256) DEFAULT 'UTC',
  `language` varchar(256) DEFAULT 'english',
  `id_roles` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_users`
--

INSERT INTO `ea_users` (`id`, `first_name`, `last_name`, `email`, `mobile_number`, `phone_number`, `address`, `city`, `state`, `zip_code`, `notes`, `timezone`, `language`, `id_roles`) VALUES
(1, 'Lucas', 'ezequiel', 'info@barberiapeluqueria-ezequielmino.com.ar', '', '11111111111', '', '', '', '', '', 'America/Buenos_Aires', 'english', 1),
(6, 'Ezequiel', 'Miño', 'lucas_e@hotmail.com', '', '123123', '', '', '', '', '', 'America/Buenos_Aires', 'english', 2),
(7, 'Ana', 'l', 'n@nnnn.com', '', '123123', '', '', '', '', '', 'America/Buenos_Aires', 'english', 2),
(8, 'g', 'gggg', 'eeeee@gmail.com', NULL, '11', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3),
(10, 'nn', 'nn', 'lucas1999@hotmail.com', NULL, '11111', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3),
(11, 'Manicura', 'Manicura', 'n@nnnnn.com', '', '123123', '', '', '', '', '', 'America/Buenos_Aires', 'english', 2),
(12, 'e', 'e', 'lucasna@hotmail.com', NULL, '11111', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3),
(13, 'eee', 'eerer', 'luererea@hotmail.com', NULL, '44444', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3),
(14, 'nncc', 'nncc', 'eeeene@gmail.com', NULL, '22', '', '', NULL, '', '', 'America/Buenos_Aires', 'spanish', 3),
(15, 'ee', 'ee', 'eee@hotmail.com', NULL, '1111', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3),
(16, 'Ezequiel ', 'Miño - Admin', 'eeee@hotmail.com', '', '11111', '', '', '', '', '', 'America/Buenos_Aires', 'english', 1),
(17, '1136605105', 'uuuuuuuuuu', 'Lucasez_@hotmail.com', NULL, '2222222222', '', '', NULL, '', '', 'America/Buenos_Aires', 'spanish', 3),
(18, 'lICAS', 'eZEQUIEL', 'eeee2e@gmail.com', NULL, '+541136605105', 'Magdalena 1140', 'Lanus', NULL, '1825', '', 'UTC', 'english', 3),
(19, 'kkoo', 'kkoo', 'lucas1999_sabale@hotmail.com', NULL, '22', '', '', NULL, '', NULL, 'America/Buenos_Aires', 'spanish', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ea_user_settings`
--

CREATE TABLE `ea_user_settings` (
  `id_users` int(11) NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text DEFAULT NULL,
  `working_plan_exceptions` text DEFAULT NULL,
  `notifications` tinyint(4) DEFAULT NULL,
  `google_sync` tinyint(4) DEFAULT NULL,
  `google_token` text DEFAULT NULL,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT 30,
  `sync_future_days` int(11) DEFAULT 90,
  `calendar_view` varchar(32) DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ea_user_settings`
--

INSERT INTO `ea_user_settings` (`id_users`, `username`, `password`, `salt`, `working_plan`, `working_plan_exceptions`, `notifications`, `google_sync`, `google_token`, `google_calendar`, `sync_past_days`, `sync_future_days`, `calendar_view`) VALUES
(1, 'luc', 'ee47b608f1d8d63b56bea4172b78bed91630014c24fa1d9802cf2eba4f16ade8', '1cff55f112c7f504a25ac02cd4bb0a9ca242e8e3b80cc9f1fb6a1c3ffbefd0c7', NULL, NULL, 1, NULL, NULL, NULL, 30, 90, 'default'),
(6, 'Eze', '8791a01ac097780503303762cf4c19256fd9e6f345e902f0c300ed249e682fd7', '81135cbd1e0963151d574f122640c181ef309958d9bace38a3c8b970541659ac', '{\"sunday\":null,\"monday\":null,\"tuesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"wednesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"thursday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"friday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"saturday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]}}', '[]', 1, NULL, NULL, NULL, 30, 90, 'default'),
(7, 'Ani', '46bfabb9e2d1c98ff0d234e3992231d49449c94b596a2e9deb2f4b5e05cc22cc', '88f8a57b4ecf54a89a3e65448066b491ca2b0b8bdc05991d1a81545a76866b41', '{\"sunday\":null,\"monday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[{\"start\":\"13:30\",\"end\":\"14:00\"}]},\"tuesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"wednesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"thursday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"friday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"saturday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]}}', '[]', 0, NULL, NULL, NULL, 30, 90, 'default'),
(11, 'Ped', 'acf3c5c0973893f48c31d6f4efe054cf7b85784bdc134ded2d6929c63cb14328', '67c22c32c04714d89e81775b529fa50b817718ec9224e65b294603732d6879e8', '{\"sunday\":null,\"monday\":null,\"tuesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"wednesday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"thursday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"friday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]},\"saturday\":{\"start\":\"10:00\",\"end\":\"20:00\",\"breaks\":[]}}', '[]', 0, NULL, NULL, NULL, 30, 90, 'default'),
(16, 'EzeMiño', '86fc02322491a0b829ea44938d756ce08fbb5a02c38a2aa1887fd51d385a3060', '627228292010a927d4a8e35e890a0305f2a635279cfe383dd83fa21a9b718899', NULL, NULL, 0, NULL, NULL, NULL, 30, 90, 'default');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_users_provider` (`id_users_provider`),
  ADD KEY `id_users_customer` (`id_users_customer`),
  ADD KEY `id_services` (`id_services`);

--
-- Indices de la tabla `ea_consents`
--
ALTER TABLE `ea_consents`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_roles`
--
ALTER TABLE `ea_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  ADD KEY `secretaries_users_provider` (`id_users_provider`);

--
-- Indices de la tabla `ea_services`
--
ALTER TABLE `ea_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_categories` (`id_service_categories`);

--
-- Indices de la tabla `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD PRIMARY KEY (`id_users`,`id_services`),
  ADD KEY `services_providers_services` (`id_services`);

--
-- Indices de la tabla `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_settings`
--
ALTER TABLE `ea_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ea_users`
--
ALTER TABLE `ea_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_roles` (`id_roles`);

--
-- Indices de la tabla `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT de la tabla `ea_consents`
--
ALTER TABLE `ea_consents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ea_roles`
--
ALTER TABLE `ea_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ea_services`
--
ALTER TABLE `ea_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `ea_service_categories`
--
ALTER TABLE `ea_service_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ea_settings`
--
ALTER TABLE `ea_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `ea_users`
--
ALTER TABLE `ea_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ea_appointments`
--
ALTER TABLE `ea_appointments`
  ADD CONSTRAINT `appointments_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_customer` FOREIGN KEY (`id_users_customer`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_secretaries_providers`
--
ALTER TABLE `ea_secretaries_providers`
  ADD CONSTRAINT `secretaries_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `secretaries_users_secretary` FOREIGN KEY (`id_users_secretary`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_services`
--
ALTER TABLE `ea_services`
  ADD CONSTRAINT `services_service_categories` FOREIGN KEY (`id_service_categories`) REFERENCES `ea_service_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_services_providers`
--
ALTER TABLE `ea_services_providers`
  ADD CONSTRAINT `services_providers_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `services_providers_users_provider` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_users`
--
ALTER TABLE `ea_users`
  ADD CONSTRAINT `users_roles` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ea_user_settings`
--
ALTER TABLE `ea_user_settings`
  ADD CONSTRAINT `user_settings_users` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `mantenc1_aquarela_db`
--
CREATE DATABASE IF NOT EXISTS `mantenc1_aquarela_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mantenc1_aquarela_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `causes`
--

CREATE TABLE `causes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `causes`
--

INSERT INTO `causes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'PROTECCIÓN SEGÚN ORDEN DEL TRIBUNAL', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(2, 'VICTIMA DE MALTRATO FÍSICO MODERADO', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(3, 'VICTIMA DE MALTRATO PSICOLÓGICO LEVE A MODERADO', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(4, 'VICTIMA DE NEGLIGENCIA LEVE', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(5, 'VICTIMA DE NEGLIGENCIA MODERADA', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(6, 'VICTIMA-TESTIGO DE NEGLIGENCIA MODERADA', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(7, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR MODERADA', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(8, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR LEVE', '2023-01-17 04:19:08', '2023-01-17 04:19:08'),
(9, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR MODERADA', '2023-01-17 04:19:08', '2023-01-17 04:19:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_01_10_231613_create_sessions_table', 1),
(7, '2023_01_11_130011_create_causes_table', 1),
(8, '2023_01_11_193632_create_records_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `records`
--

CREATE TABLE `records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_tutor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `month_stay` int(10) UNSIGNED NOT NULL,
  `send_prorogation` datetime NOT NULL,
  `rit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cause_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `state` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rut`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `state`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, '19.040.800-0', 'Felipe Leiva Cortés', 'a@a.com', NULL, '$2y$10$dDjVSxfGHGO2kyVLzCHWAuvn6ri3.88mNBL.bFNVfpfl0DhuDwTlK', NULL, NULL, NULL, '1', NULL, NULL, NULL, '2023-01-17 04:19:08', '2023-01-17 04:19:08');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `causes`
--
ALTER TABLE `causes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `records_cause_id_foreign` (`cause_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `causes`
--
ALTER TABLE `causes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `records`
--
ALTER TABLE `records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `records`
--
ALTER TABLE `records`
  ADD CONSTRAINT `records_cause_id_foreign` FOREIGN KEY (`cause_id`) REFERENCES `causes` (`id`) ON DELETE CASCADE;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin DEFAULT NULL,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"solutoria_task\",\"table\":\"indicators\"},{\"db\":\"mantenc1_aquarela_db\",\"table\":\"users\"},{\"db\":\"mantenc1_aquarela_db\",\"table\":\"migrations\"},{\"db\":\"mantenc1_aquarela_db\",\"table\":\"causes\"},{\"db\":\"mantenc1_aquarela_db\",\"table\":\"sessions\"},{\"db\":\"mantenc1_aquarela_db\",\"table\":\"records\"},{\"db\":\"refueler_acuarela_db\",\"table\":\"causes\"},{\"db\":\"refueler_acuarela_db\",\"table\":\"records\"},{\"db\":\"refueler_acuarela_db\",\"table\":\"users\"},{\"db\":\"acuarela_db\",\"table\":\"users\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'solutoria_task', 'indicators', '{\"sorted_col\":\"`indicators`.`date` DESC\"}', '2023-01-18 12:42:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin DEFAULT NULL,
  `data_sql` longtext COLLATE utf8_bin DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2023-01-18 16:19:41', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `refueler_acuarela_db`
--
CREATE DATABASE IF NOT EXISTS `refueler_acuarela_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `refueler_acuarela_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `causes`
--

CREATE TABLE `causes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `causes`
--

INSERT INTO `causes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'PROTECCIÓN SEGÚN ORDEN DEL TRIBUNAL', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(2, 'VICTIMA DE MALTRATO FÍSICO MODERADO', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(3, 'VICTIMA DE MALTRATO PSICOLÓGICO LEVE A MODERADO', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(4, 'VICTIMA DE NEGLIGENCIA LEVE', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(5, 'VICTIMA DE NEGLIGENCIA MODERADA', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(6, 'VICTIMA-TESTIGO DE NEGLIGENCIA MODERADA', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(7, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR MODERADA', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(8, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR LEVE', '2023-01-17 04:36:50', '2023-01-17 04:36:50'),
(9, 'VICTIMA-TESTIGO DE VIOLENCIA INTRAFAMILIAR MODERADA', '2023-01-17 04:36:50', '2023-01-17 04:36:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_01_10_231613_create_sessions_table', 1),
(7, '2023_01_11_130011_create_causes_table', 1),
(8, '2023_01_11_193632_create_records_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `records`
--

CREATE TABLE `records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_tutor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `month_stay` int(10) UNSIGNED NOT NULL,
  `send_prorogation` datetime NOT NULL,
  `rit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cause_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `state` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rut`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `state`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, '19.040.800-0', 'Felipe Leiva Cortés', 'a@a.com', NULL, '$2y$10$OrgsDP/tjorEgX0dOZuiWecguqaA7zDwWkPC38XPdtvYSLn4qorsC', NULL, NULL, NULL, '1', NULL, NULL, NULL, '2023-01-17 04:36:50', '2023-01-17 04:36:50');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `causes`
--
ALTER TABLE `causes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `records_cause_id_foreign` (`cause_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `causes`
--
ALTER TABLE `causes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `records`
--
ALTER TABLE `records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `records`
--
ALTER TABLE `records`
  ADD CONSTRAINT `records_cause_id_foreign` FOREIGN KEY (`cause_id`) REFERENCES `causes` (`id`) ON DELETE CASCADE;
--
-- Base de datos: `solutoria_task`
--
CREATE DATABASE IF NOT EXISTS `solutoria_task` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `solutoria_task`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicators`
--

CREATE TABLE `indicators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `time` date DEFAULT NULL,
  `origin` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_01_17_224903_create_indicators_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `indicators`
--
ALTER TABLE `indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicators`
--
ALTER TABLE `indicators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
