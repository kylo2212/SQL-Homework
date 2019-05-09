((1))
I created the following tables and I had no problems.

CREATE TABLE rental_histories (
  rental_date   DATE DEFAULT SYSDATE,
  return_date  	DATE,
  disk#			VARCHAR2(5) CONSTRAINT rental_histories_disk#_fk REFERENCES disks(disk#),
  cust# 		VARCHAR2(5) CONSTRAINT rental_histories_cust#_fk REFERENCES members(cust#),
  payment_id	VARCHAR2(4) CONSTRAINT rental_histories_payment_id_uk UNIQUE
							CONSTRAINT rental_histories_payment_id_nn NOT NULL
							CONSTRAINT rental_histories_payment_id_fk REFERENCES payments(id),
  CONSTRAINT rental_hist_rtldate_d#_c#_pk PRIMARY KEY (rental_date, disk#, cust#) 
);
  
CREATE TABLE payments (
  id 			VARCHAR2(4) CONSTRAINT payments_id_pk PRIMARY KEY,
  amount 		NUMBER(4,2) CONSTRAINT payments_amount_nn NOT NULL,
  payment_type	VARCHAR2(6) CONSTRAINT payments_payment_type_nn NOT NULL,
  card_num		CHAR(8),
  exp_date		DATE,
  name_on_card	VARCHAR2(35),
  CONSTRAINT payments_cnum_epdate_namecd_ck CHECK ((payment_type = 'cash' AND card_num IS NULL AND exp_date IS NULL AND name_on_card IS NULL) OR 
  (payment_type = 'credit' AND card_num IS NOT NULL AND exp_date IS NOT NULL AND name_on_card IS NOT NULL))
);
  
CREATE TABLE star_billings (
  movie#	 	VARCHAR2(5) CONSTRAINT star_billings_movie#_fk REFERENCES movies(id),
  actor_code	VARCHAR2(4) CONSTRAINT star_billings_actor_code_fk REFERENCES actors(code),
  CONSTRAINT star_bill_movie#_actorcode_pk PRIMARY KEY (movie#, actor_code)
);
  
CREATE TABLE disks (
  disk#			VARCHAR2(5) CONSTRAINT disks_disk#_pk PRIMARY KEY,
  media			VARCHAR2(3) CONSTRAINT disks_media_nn NOT NULL
							CONSTRAINT disks_media_ck CHECK ((media = 'DVD') 
							OR (media = 'BR')),
  movie#		VARCHAR2(5) CONSTRAINT disks_movie#_nn NOT NULL
							CONSTRAINT disks_movie#_fk REFERENCES movies(id)
);
  
CREATE TABLE members (
  cust#			VARCHAR2(5)  CONSTRAINT members_cust#_pk PRIMARY KEY,
  last_name		VARCHAR2(20) CONSTRAINT members_last_name_nn NOT NULL,
  fisrt_name    VARCHAR2(15) CONSTRAINT members_first_name_nn NOT NULL,
  phone 		CHAR(10)     CONSTRAINT members_phone_nn NOT NULL
);
  
CREATE TABLE movies (
  id			VARCHAR2(5)  CONSTRAINT movies_id_pk PRIMARY KEY,
  title 		VARCHAR2(30) CONSTRAINT movies_title_nn NOT NULL,
  genre			VARCHAR2(8)	 CONSTRAINT movies_genre_nn NOT NULL
);
  
CREATE TABLE actors (
  code 			VARCHAR2(4)  CONSTRAINT actors_code_pk PRIMARY KEY,
  stage_name    VARCHAR2(30) CONSTRAINT actors_stage_name_uk UNIQUE
							 CONSTRAINT actors_stage_name_nn NOT NULL,
  real_name		VARCHAR2(30),
  birth_date	DATE
);  


((2))
There was a problem with the rental histories table not inserting all of the data from the
script. It was not accepting multiple payments ids for customers renting more than one disk#
in same payment. I removed the unique id and set check contraint for the cust# on same date 
not exceeding 3. See answer 3.


SELECT * FROM rental_histories;
SELECT * FROM payments;
SELECT * FROM star_billings;
SELECT * FROM disks;
SELECT * FROM members;
SELECT * FROM movies;
SELECT * FROM actors;


((3))
Adding this constraint will make the 3 part primary key as a whole unique.

ALTER TABLE rental_histories
ADD CONSTRAINT rtlhist_disk_cust_pmtid_uk
UNIQUE (disk#, cust#, payment_id);



((4))
Statements used to alter tables.

ALTER TABLE rental_histories
DROP CONSTRAINT rental_histories_payment_id_uk;

Added these after removing UK constraint:
INSERT INTO rental_histories (rental_date, return_date, disk#, cust#, payment_id)
VALUES ('06/APR/2018', '07/APR/2018', 'D0005', 'PM002', 'P002');
INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0004', 'DJ001', 'P003');
INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0010', 'DJ001', 'P003');
INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0006', 'PM002', 'P005');

((5))
CHECKING FOR THE UNIQUENESS OF THE PRIMARY KEY. 
INSERT INTO members
(cust#, last_name, first_name, phone)
VALUES ('DJ001', 'O''Connell', 'Kirstie', 816-699-3235);
CHECK OK! -- inserted like above and would not let me with the same cust# already used.
I had to of course create a unique cust#
+++++++++++++++++++++++
CHECKING FOR THE PK COMBO...RAN THE FOLLOWING 2 TIMES AND IT WAS BLOCKED THE SECOND TIME 
BY THE CONSTRAINT RESTRICTION. Even with a return date added it still was blocked.
INSERT INTO rental_histories 
(rental_date, disk#, cust#, payment_id)
VALUES 
(DEFAULT, 'D0001', 'KO001', 'P001');

WHEN I INSERTED THE FOLLOWING IT LET ME. THE PAYMENT CODE WAS DIFFERENT BUT IT WAS 
FOR THE SAME DISK# AND SAME DAY. NOT SURE HOW TO FIX IT YET.
INSERT INTO rental_histories 
(rental_date, disk#, cust#, payment_id)
VALUES 
(default, 'D0001', 'KO001', 'P002');
+++++++++++++++++++++++++
CHECKING THE CHECK CONSTRAINT FOR THE MEDIA IN THE DISKS TABLE
INSERT INTO disks
(disk#, media, movie#)
VALUES
('D0002', 'BDB', 'M0002');
WOULD NOT ALLOW ME TO ADD THE ABOVE UNTIL I CHANGED IT TO DVD OR BR.
I ALSO NOTICED IT WILL CHECK THE PRIMARY KEY FIRST THEN CHECK THE 
CHECK CONSTRAINT. IT WILL NOT LET A DISK WITH THE SAME DISK# ENTERED UNLESS YOU 
CHANGE THE DISK# ALSO.
+++++++++++++++++++++++++
Inserted the following into the movies table with a duplicate movie id number. 
INSERT INTO movies 
(id, title, genre)
VALUES
('M0001', 'Harry and the Hendersons', 'family');
The primary key constraint worked. I had to give the movie a unique number that has not 
been used. 
INSERT INTO movies 
(id, title, genre)
VALUES
('M0010', 'Harry and the Hendersons', 'family');
+++++++++++++++++++++++++++
Checking for the primary key constraint in actors table
INSERT INTO actors
(code, stage_name)
VALUES 
('A001', 'Goldie Hawn');
Constraint for PK worked.
Changed the number of the actor next to check the unique constraint for the stage name_on_card
INSERT INTO actors
(code, stage_name)
VALUES 
('A010', 'Goldie Hawn');
Unique constraint was violated.
+++++++++++++++++++++++++++++
Checking Primary Key constraint on the payments tableINSERT INTO payments
(id, amount, payment_type)
VALUES
('P001', '3.75', 'cash');
Constraint passed check for uniqueness in payment id. 
Next checking the check constraint for the cash or credit option.
INSERT INTO payments
(id, amount, payment_type)
VALUES
('P010', '3.75', 'credit');
The above violoated the check constraint for a credit transaction.
But it did run the following after all columns were filled in
INSERT INTO payments
(id, amount, payment_type, card_num, exp_date, name_on_card)
VALUES
('P010', '3.75', 'credit', '654987', '26-may-2020', 'Kirstie');

This finishes the constraint checking for inserting data into tables

((6))
Created simple view to see the names and phone numbers of members.
CREATE VIEW view_members
AS SELECT last_name, first_name, phone
FROM members;

((7))
Simple view created using aliases to see list of types of payments used and amounts.
CREATE VIEW view_members
AS SELECT cust#, last_name, first_name, phone
FROM members;

((8))
I changed my last name in view members to my maiden name and it changed in the
members table as well as the view.
UPDATE view_members
SET last_name = 'LaShell'
WHERE first_name = 'Kirstie';

((9))
A complex view with the join to find out what movies are on dvd
CREATE VIEW view_movies_dvd (Disk#, Movie#, Title)
AS SELECT d.disk#, m.id, m.title
FROM disks d, movies m
WHERE d.media IN ('DVD', 'dvd');

((10))
This view is to see what movies are rented out.
CREATE VIEW view_disks_rented (Rented_On, Disk#, Movie#)
AS SELECT r.rental_date, r.disk#, d.movie#
FROM rental_histories r, disks d
WHERE r.disk# = d.disk#
AND r.return_date IS NULL
GROUP BY r.rental_date, r.disk#, d.movie#;

((11))
This is to see the payment type used to pay for the highest 3 amounts paid for rentals
SELECT ROWNUM AS RANK, amount, payment_type
FROM (SELECT amount, payment_type
FROM payments
ORDER BY amount DESC)
WHERE ROWNUM <= 3;






