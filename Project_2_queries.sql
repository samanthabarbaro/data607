----Making tables. After googling, I found out that you can't set a max integer in postgre. --

CREATE TABLE marvelmovies (
    viewer            varchar(20),
     iron_man     	  int,
	 captain_america  int,
	 avengers 		  int
);

--table for DC movies and their ratings--

CREATE TABLE dcmovies (
    viewer      	varchar(20),
     super_man  	int,
	 birds_of_prey 	int,
	the_suicide_squad int
);

-- table for classic holiday movies, such as Love, Actually and The Grinch --

CREATE TABLE holidaymovies (
  	 viewer      varchar(20),
     the_grinch  int,
	 the_holiday int,
	 love_actually int,
	 rudolph int
);

--- uploading values into each table -- 

INSERT INTO holidaymovies (viewer, the_grinch, the_holiday, love_actually, rudolph)
VALUES 
	('cat', 2, 4, NULL, 4),
	('james', 3, 2, 5, NULL),
	('anne', 1, 1, 2, 1),
	('jeff', NULL, NULL, 5, 5);

INSERT INTO dcmovies (viewer, super_man, birds_of_prey, the_suicide_squad)
VALUES 
	('cat', 5, 4, NULL)
	('james', 2, NULL, 4),
	('anne', NULL, 5, 4),
	('nico', 2, 5, 4),
	('jeff', 1, NULL, NULL);

INSERT INTO marvelmovies (viewer, iron_man, captain_america, avengers)
VALUES 
	('james', 2, 5, NULL),
	('anne', 1, 2, 3),
	('nico', 5, NULL, 2),
	('jeff', NULL, NULL, 4),
	('greta', NULL, 4, 3);

 ---verify null values: this shows null values in a specific column--
 SELECT *
FROM marvelmovies
WHERE iron_man IS NULL;

--- counting total null values per table -- 
--for marvel movies -- 
SELECT COUNT(*)
FROM marvelmovies
WHERE iron_man IS NULL 
   OR captain_america IS NULL 
   OR avengers IS NULL;
   
--- for dcmovies--

  SELECT COUNT(*)
FROM dcmovies
WHERE  super_man IS NULL 
   OR birds_of_prey IS NULL 
   OR the_suicide_squad IS NULL;

--- for holidaymovies --

  SELECT COUNT(*)
FROM holidaymovies
WHERE  the_grinch IS NULL 
   OR the_holiday IS NULL
   OR rudolph IS NULL
   OR love_actually IS NULL;

--- full outer join to include anyone who only watched one or two types of movies

SELECT * FROM marvelmovies
FULL OUTER JOIN dcmovies
 USING(viewer)
 FULL OUTER JOIN holidaymovies
 USING(viewer); 