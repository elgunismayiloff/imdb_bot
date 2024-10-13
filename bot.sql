-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Hazırlanma Vaxtı: 13 Okt, 2024 saat 23:51
-- Server versiyası: 10.6.5-MariaDB
-- PHP Versiyası: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Verilənlər Bazası: `shopink_film`
--

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `actors`
--

CREATE TABLE `actors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cədvəl üçün cədvəl strukturu `directors`
--

CREATE TABLE `directors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cədvəl üçün cədvəl strukturu `films`
--

CREATE TABLE `films` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `release_year` int(11) DEFAULT NULL,
  `imdb_rating` decimal(3,1) DEFAULT NULL,
  `poster` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `embed_code` text DEFAULT NULL,
  `views` int(11) NOT NULL,
  `featured` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `runtime` varchar(50) DEFAULT NULL,
  `awards` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cədvəl üçün cədvəl strukturu `film_actors`
--

CREATE TABLE `film_actors` (
  `film_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `film_directors`
--

CREATE TABLE `film_directors` (
  `film_id` int(11) NOT NULL,
  `director_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `film_genres`
--

CREATE TABLE `film_genres` (
  `film_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Cədvəl üçün cədvəl strukturu `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Cədvəl üçün indekslər `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Cədvəl üçün indekslər `directors`
--
ALTER TABLE `directors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Cədvəl üçün indekslər `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id`);

--
-- Cədvəl üçün indekslər `film_actors`
--
ALTER TABLE `film_actors`
  ADD PRIMARY KEY (`film_id`,`actor_id`),
  ADD KEY `actor_id` (`actor_id`);

--
-- Cədvəl üçün indekslər `film_directors`
--
ALTER TABLE `film_directors`
  ADD PRIMARY KEY (`film_id`,`director_id`),
  ADD KEY `director_id` (`director_id`);

--
-- Cədvəl üçün indekslər `film_genres`
--
ALTER TABLE `film_genres`
  ADD PRIMARY KEY (`film_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Cədvəl üçün indekslər `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- Cədvəl üçün AUTO_INCREMENT `actors`
--
ALTER TABLE `actors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;


--
-- Cədvəl üçün AUTO_INCREMENT `directors`
--
ALTER TABLE `directors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Cədvəl üçün AUTO_INCREMENT `films`
--
ALTER TABLE `films`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Cədvəl üçün AUTO_INCREMENT `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `film_actors`
--
ALTER TABLE `film_actors`
  ADD CONSTRAINT `film_actors_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `film_actors_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `film_directors`
--
ALTER TABLE `film_directors`
  ADD CONSTRAINT `film_directors_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `film_directors_ibfk_2` FOREIGN KEY (`director_id`) REFERENCES `directors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `film_genres`
--
ALTER TABLE `film_genres`
  ADD CONSTRAINT `film_genres_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `film_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
