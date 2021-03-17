-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 10 Maj 2020, 01:47
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `Magazyn`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Cennik`
--

CREATE TABLE `Cennik` (
  `DataOd` datetime NOT NULL,
  `DataDo` datetime DEFAULT NULL,
  `IdTowaru` bigint(20) NOT NULL,
  `Cena` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `Cennik`
--

INSERT INTO `Cennik` (`DataOd`, `DataDo`, `IdTowaru`, `Cena`) VALUES
('2017-01-01 00:00:00', '2017-05-31 00:00:00', 1, '8.00'),
('2017-01-01 00:00:00', NULL, 2, '10.00'),
('2017-06-01 00:00:00', NULL, 1, '9.00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `JednostkiMiary`
--

CREATE TABLE `JednostkiMiary` (
  `JednostkaMiary` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `JednostkiMiary`
--

INSERT INTO `JednostkiMiary` (`JednostkaMiary`) VALUES
('kg'),
('mb');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Obroty`
--

CREATE TABLE `Obroty` (
  `DataObrotu` datetime NOT NULL,
  `IdTowaru` bigint(20) NOT NULL,
  `Typ` char(20) NOT NULL,
  `JednostkaMiary` char(10) NOT NULL,
  `Ilosc` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `Obroty`
--

INSERT INTO `Obroty` (`DataObrotu`, `IdTowaru`, `Typ`, `JednostkaMiary`, `Ilosc`) VALUES
('2017-04-01 00:00:00', 1, 'P', 'kg', 3000),
('2017-04-01 00:00:00', 2, 'P', 'mb', 2000),
('2017-05-02 00:00:00', 1, 'R', 'kg', 350),
('2017-05-12 00:00:00', 2, 'P', 'mb', 1500),
('2017-05-21 00:00:00', 2, 'R', 'mb', 220),
('2017-06-05 00:00:00', 2, 'R', 'mb', 330),
('2017-06-06 00:00:00', 1, 'R', 'kg', 200);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TabelaObroty`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TabelaObroty` (
`DataObrotu` datetime
,`Typ` char(20)
,`NazwaTowaru` char(20)
,`JednostkaMiary` char(10)
,`Cena` decimal(15,2)
,`Ilosc` bigint(20)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TabelaObrotyWartosc`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TabelaObrotyWartosc` (
`DataObrotu` datetime
,`NazwaTowaru` char(20)
,`Typ` char(20)
,`JednostkaMiary` char(10)
,`Cena` decimal(15,2)
,`Ilosc` bigint(20)
,`Wartosc` decimal(34,2)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TabelaPrzychodyIlosc`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TabelaPrzychodyIlosc` (
`NazwaTowaru` char(20)
,`PrzychodyRazem` decimal(41,0)
,`WartoscPrzychodu` decimal(56,2)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TabelaRozchodyIlosc`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TabelaRozchodyIlosc` (
`NazwaTowaru` char(20)
,`RozchodyRazem` decimal(41,0)
,`WartoscRozchodu` decimal(56,2)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TabelaStan`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TabelaStan` (
`NazwaTowaru` char(20)
,`Stan` decimal(64,0)
,`Wartosc` decimal(65,2)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Towary`
--

CREATE TABLE `Towary` (
  `IdTowaru` bigint(20) NOT NULL,
  `NazwaTowaru` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `Towary`
--

INSERT INTO `Towary` (`IdTowaru`, `NazwaTowaru`) VALUES
(1, 'blachy'),
(2, 'rury');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `WszystkiePrzychody`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `WszystkiePrzychody` (
`DataObrotu` datetime
,`NazwaTowaru` char(20)
,`Typ` char(20)
,`JednostkaMiary` char(10)
,`Cena` decimal(15,2)
,`Ilosc` bigint(20)
,`Wartosc` decimal(34,2)
);

-- --------------------------------------------------------

--
-- Struktura widoku `TabelaObroty`
--
DROP TABLE IF EXISTS `TabelaObroty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TabelaObroty`  AS  select `Obroty`.`DataObrotu` AS `DataObrotu`,`Obroty`.`Typ` AS `Typ`,`Towary`.`NazwaTowaru` AS `NazwaTowaru`,`Obroty`.`JednostkaMiary` AS `JednostkaMiary`,`Cennik`.`Cena` AS `Cena`,`Obroty`.`Ilosc` AS `Ilosc` from (((`Obroty` join `JednostkiMiary` on(`Obroty`.`JednostkaMiary` = `JednostkiMiary`.`JednostkaMiary`)) join `Towary` on(`Obroty`.`IdTowaru` = `Towary`.`IdTowaru`)) join `Cennik` on(`Cennik`.`IdTowaru` = `Towary`.`IdTowaru` and `Obroty`.`DataObrotu` >= `Cennik`.`DataOd` and (`Obroty`.`DataObrotu` < `Cennik`.`DataDo` or `Cennik`.`DataDo` is null))) order by `Towary`.`NazwaTowaru` ;

-- --------------------------------------------------------

--
-- Struktura widoku `TabelaObrotyWartosc`
--
DROP TABLE IF EXISTS `TabelaObrotyWartosc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TabelaObrotyWartosc`  AS  select `Obroty`.`DataObrotu` AS `DataObrotu`,`Towary`.`NazwaTowaru` AS `NazwaTowaru`,`Obroty`.`Typ` AS `Typ`,`Obroty`.`JednostkaMiary` AS `JednostkaMiary`,`Cennik`.`Cena` AS `Cena`,`Obroty`.`Ilosc` AS `Ilosc`,`Obroty`.`Ilosc` * `Cennik`.`Cena` AS `Wartosc` from ((`Obroty` join `Towary` on(`Obroty`.`IdTowaru` = `Towary`.`IdTowaru`)) join `Cennik` on(`Obroty`.`IdTowaru` = `Cennik`.`IdTowaru` and `Obroty`.`DataObrotu` >= `Cennik`.`DataOd` and (`Obroty`.`DataObrotu` < `Cennik`.`DataDo` or `Cennik`.`DataDo` is null))) order by `Towary`.`NazwaTowaru` ;

-- --------------------------------------------------------

--
-- Struktura widoku `TabelaPrzychodyIlosc`
--
DROP TABLE IF EXISTS `TabelaPrzychodyIlosc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TabelaPrzychodyIlosc`  AS  select `Towary`.`NazwaTowaru` AS `NazwaTowaru`,sum(`Obroty`.`Ilosc`) AS `PrzychodyRazem`,sum(`Obroty`.`Ilosc` * `Cennik`.`Cena`) AS `WartoscPrzychodu` from (((`Obroty` left join `JednostkiMiary` on(`Obroty`.`JednostkaMiary` = `JednostkiMiary`.`JednostkaMiary`)) left join `Towary` on(`Obroty`.`IdTowaru` = `Towary`.`IdTowaru`)) left join `Cennik` on(`Cennik`.`IdTowaru` = `Towary`.`IdTowaru` and `Obroty`.`DataObrotu` >= `Cennik`.`DataOd` and (`Obroty`.`DataObrotu` < `Cennik`.`DataDo` or `Cennik`.`DataDo` is null))) where `Obroty`.`Typ` = 'P' group by `Towary`.`NazwaTowaru` ;

-- --------------------------------------------------------

--
-- Struktura widoku `TabelaRozchodyIlosc`
--
DROP TABLE IF EXISTS `TabelaRozchodyIlosc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TabelaRozchodyIlosc`  AS  select `Towary`.`NazwaTowaru` AS `NazwaTowaru`,sum(`Obroty`.`Ilosc`) AS `RozchodyRazem`,sum(`Obroty`.`Ilosc` * `Cennik`.`Cena`) AS `WartoscRozchodu` from (((`Obroty` left join `JednostkiMiary` on(`Obroty`.`JednostkaMiary` = `JednostkiMiary`.`JednostkaMiary`)) left join `Towary` on(`Obroty`.`IdTowaru` = `Towary`.`IdTowaru`)) left join `Cennik` on(`Cennik`.`IdTowaru` = `Towary`.`IdTowaru` and `Obroty`.`DataObrotu` >= `Cennik`.`DataOd` and (`Obroty`.`DataObrotu` < `Cennik`.`DataDo` or `Cennik`.`DataDo` is null))) where `Obroty`.`Typ` = 'R' group by `Towary`.`NazwaTowaru` ;

-- --------------------------------------------------------

--
-- Struktura widoku `TabelaStan`
--
DROP TABLE IF EXISTS `TabelaStan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TabelaStan`  AS  select `TabelaPrzychodyIlosc`.`NazwaTowaru` AS `NazwaTowaru`,sum(`TabelaPrzychodyIlosc`.`PrzychodyRazem` - `TabelaRozchodyIlosc`.`RozchodyRazem`) AS `Stan`,sum(`TabelaPrzychodyIlosc`.`WartoscPrzychodu` - `TabelaRozchodyIlosc`.`WartoscRozchodu`) AS `Wartosc` from (`TabelaPrzychodyIlosc` join `TabelaRozchodyIlosc` on(`TabelaPrzychodyIlosc`.`NazwaTowaru` = `TabelaRozchodyIlosc`.`NazwaTowaru`)) group by `TabelaPrzychodyIlosc`.`NazwaTowaru` ;

-- --------------------------------------------------------

--
-- Struktura widoku `WszystkiePrzychody`
--
DROP TABLE IF EXISTS `WszystkiePrzychody`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `WszystkiePrzychody`  AS  select `Obroty`.`DataObrotu` AS `DataObrotu`,`Towary`.`NazwaTowaru` AS `NazwaTowaru`,`Obroty`.`Typ` AS `Typ`,`Obroty`.`JednostkaMiary` AS `JednostkaMiary`,`Cennik`.`Cena` AS `Cena`,`Obroty`.`Ilosc` AS `Ilosc`,`Obroty`.`Ilosc` * `Cennik`.`Cena` AS `Wartosc` from ((`Obroty` join `Towary` on(`Obroty`.`IdTowaru` = `Towary`.`IdTowaru`)) join `Cennik` on(`Obroty`.`IdTowaru` = `Cennik`.`IdTowaru` and `Obroty`.`DataObrotu` >= `Cennik`.`DataOd` and (`Obroty`.`DataObrotu` < `Cennik`.`DataDo` or `Cennik`.`DataDo` is null))) where `Obroty`.`Typ` = 'P' order by `Towary`.`NazwaTowaru` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `Cennik`
--
ALTER TABLE `Cennik`
  ADD PRIMARY KEY (`DataOd`,`IdTowaru`),
  ADD KEY `IdTowaru` (`IdTowaru`);

--
-- Indeksy dla tabeli `JednostkiMiary`
--
ALTER TABLE `JednostkiMiary`
  ADD PRIMARY KEY (`JednostkaMiary`);

--
-- Indeksy dla tabeli `Obroty`
--
ALTER TABLE `Obroty`
  ADD PRIMARY KEY (`DataObrotu`,`IdTowaru`),
  ADD KEY `IdTowaru` (`IdTowaru`),
  ADD KEY `JednostkaMiary` (`JednostkaMiary`);

--
-- Indeksy dla tabeli `Towary`
--
ALTER TABLE `Towary`
  ADD PRIMARY KEY (`IdTowaru`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `Towary`
--
ALTER TABLE `Towary`
  MODIFY `IdTowaru` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `Cennik`
--
ALTER TABLE `Cennik`
  ADD CONSTRAINT `Cennik_ibfk_1` FOREIGN KEY (`IdTowaru`) REFERENCES `Towary` (`IdTowaru`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `Obroty`
--
ALTER TABLE `Obroty`
  ADD CONSTRAINT `Obroty_ibfk_1` FOREIGN KEY (`IdTowaru`) REFERENCES `Towary` (`IdTowaru`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `Obroty_ibfk_2` FOREIGN KEY (`JednostkaMiary`) REFERENCES `JednostkiMiary` (`JednostkaMiary`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
