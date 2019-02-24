--
-- Database: academy
--

--
-- Table structure for table `Authors` - authors of the books
--

CREATE TABLE IF NOT EXISTS `Authors` (
  `authorId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`authorId`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `Authors`
--

INSERT INTO `Authors` (`authorId`, `name`) VALUES
(1, 'Chris Smith'),
(2, 'Steven Levithan'),
(3, ' Jan Goyvaerts'),
(4, 'Ryan Benedetti'),
(5, ' Al Anderson'),
(6, 'Clay Breshears'),
(7, 'Kevlin Henney');

--
-- Table structure for table `Books` - books with only main info
--

CREATE TABLE IF NOT EXISTS `Books` (
  `bookId` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `year` year(4) DEFAULT NULL,
  PRIMARY KEY (`bookId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`bookId`, `authorId`, `title`, `year`) VALUES
(1, 1, 'Programming F# 3.0, 2nd Edition', 2012),
(2, 2, 'Regular Expressions Cookbook, 2nd Edition', 2012),
(3, 4, 'Head First Networking', 2009),
(4, 6, 'The Art of Concurrency', 2009),
(5, 7, '97 Things Every Programmer Should Know', 2010),
(6, NULL, 'McCullough and Berglund on Mastering Advanced Git', NULL),
(7, NULL, 'Version Control with Git, 2nd Edition', 2012),
(8, NULL, 'Learning Python, 4th Edition', 2009);


--
-- a)	Suskirstyti knygas į žanrus.
--
-- Table structure for table 'Genres'.
--

CREATE TABLE genres (
genreID int(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(20),
PRIMARY KEY (genreId)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Data for table 'Genres'
--

INSERT INTO genres   
(genreId,name)
VALUES
(1,'Science'),
(2,'Fiction');

--
-- Adding column to table 'Books'
--
ALTER TABLE books
ADD COLUMN genreId INT;

--
-- Additional data for table 'Books'
--
UPDATE books SET genreId =1 WHERE bookId IN (1,3,5);
UPDATE books SET genreId =2 WHERE bookId IN (2,4);
--
-- b)	Knygos gali turėti vieną ir daugiau autorių.
--
-- Adding additional table 'books_authors'
--

CREATE TABLE books_authors (
bookID int(11) NOT NULL,
authorID int(11) NOT NULL
) ;

--
-- Data for table 'books_authors'
--

INSERT INTO books_authors
(bookId,authorId)
 VALUES
 (1,1),
 (2,1),
 (3,4),
 (4,6),
 (5,7),
 (5,6),
 (5,5);
 
--
-- d)	Išrinkite visas knygas su jų autoriais. (autorius, jei jų daugiau nei vienas atskirkite kableliais)
--
 
SELECT GROUP_CONCAT(authors.name) AS Autoriai, books.title FROM books
INNER JOIN books_authors ON books_authors.bookId = books.bookId
INNER JOIN authors ON books_authors.authorId = authors.authorId
GROUP BY books.bookId


--
-- e)	Papildykite knygų lentelę, kad galėtumėte išsaugoti originalų knygos pavadinimą. (Pavadinime išsaugokite, lietuviškas raides kaip ą,ė,š ir pan.)
--

ALTER TABLE books MODIFY COLUMN title VARCHAR(255)  
CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

INSERT INTO books
(authorId,title,year)
 VALUES
 (1,'Jūratė ir Kąstytis',1986);


