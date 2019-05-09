
INSERT INTO members (cust#, last_name, first_name, phone)
VALUES ('DJ001', 'Doe', 'John', '9876543210');

INSERT INTO members (cust#, last_name, first_name, phone)
VALUES ('PM002', 'Poppins', 'Mary', '8765432109');

INSERT INTO members (cust#, last_name, first_name, phone)
VALUES ('BK003', 'Brinkmeyer', 'Kurt', '7654321098');
____________________________________________________________________
INSERT INTO actors (code, stage_name)
VALUES ('A001', 'Goldie Hawn');

INSERT INTO actors (code, stage_name)
VALUES ('A002', 'Kurt Russell');

INSERT INTO actors (code, stage_name)
VALUES ('A003', 'Scott Eastwood');

INSERT INTO actors (code, stage_name)
VALUES ('A004', 'Dick Van Dyke');

INSERT INTO actors (code, stage_name)
VALUES ('A005', 'John Wayne');

INSERT INTO actors (code, stage_name)
VALUES ('A006', 'Mel Gibson');

INSERT INTO actors (code, stage_name)
VALUES ('A007', 'Brad Pitt');

INSERT INTO actors (code, stage_name)
VALUES ('A008', 'Julia Roberts');

INSERT INTO actors (code, stage_name)
VALUES ('A009', 'George Clooney');

INSERT INTO movies (id, title, genre)
VALUES ('M0001', 'Braveheart', 'drama');

INSERT INTO movies (id, title, genre)
VALUES ('M0002', 'Oceans Eleven', 'drama');

INSERT INTO movies (id, title, genre)
VALUES ('M0003', 'The Cowboys', 'western');

INSERT INTO movies (id, title, genre)
VALUES ('M0004', 'Chitty Chitty Bang Bang', 'family');

INSERT INTO movies (id, title, genre)
VALUES ('M0005', 'The Longest Ride', 'western');

INSERT INTO movies (id, title, genre)
VALUES ('M0006', 'Overboard', 'comedy');

INSERT INTO payments (id, amount, payment_type)
VALUES ('P001', 3.75, 'cash');

INSERT INTO payments (id, amount, payment_type)
VALUES ('P002', 7.5, 'cash');

INSERT INTO payments (id, amount, payment_type, card_num, exp_date, name_on_card)
VALUES ('P003', 11.25, 'credit', 45627891, '30/JUN/2019', 'John Doe');

********************************************************************************************************************
INSERT INTO payments (id, amount, payment_type, card_num, exp_date, name_on_card)
VALUES ('P004', 3.75, 'credit', 56792581, '30/SEP/2020', 'Kurt Brinkmeyer');

INSERT INTO payments (id, amount, payment_type)
VALUES ('P005', 7.5, 'cash');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0001', 'DVD', 'M0005');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0002', 'DVD', 'M0006');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0003', 'BR', 'M0001');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0004', 'BR', 'M0003');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0005', 'BR', 'M0003');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0006', 'DVD', 'M0004');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0007', 'BR', 'M0002');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0008', 'DVD', 'M0002');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0009', 'DVD', 'M0001');

INSERT INTO disks (disk#, media, movie#)
VALUES ('D0010', 'BR', 'M0004');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0006', 'A001');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0006', 'A002');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0001', 'A006');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0004', 'A004');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0005', 'A003');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0002', 'A007');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0002', 'A008');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0002', 'A009');

INSERT INTO star_billings (movie#, actor_code)
VALUES ('M0003', 'A005');

*INSERT INTO rental_histories (rental_date, return_date, disk#, cust#, payment_id)
VALUES ('05/APR/2018', '06/APR/2018', 'D0003', 'DJ001', 'P001');

*INSERT INTO rental_histories (rental_date, return_date, disk#, cust#, payment_id)
VALUES ('06/APR/2018', '07/APR/2018', 'D0001', 'PM002', 'P002');

*INSERT INTO rental_histories (rental_date, return_date, disk#, cust#, payment_id)
VALUES ('06/APR/2018', '07/APR/2018', 'D0005', 'PM002', 'P002');

*INSERT INTO rental_histories (rental_date, return_date, disk#, cust#, payment_id)
VALUES ('15/APR/2018', '16/APR/2018', 'D0010', 'BK003', 'P004');

*INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0008', 'DJ001', 'P003');

*INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0004', 'DJ001', 'P003');

*INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0010', 'DJ001', 'P003');

*INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0002', 'PM002', 'P005');

*INSERT INTO rental_histories (rental_date, disk#, cust#, payment_id)
VALUES (DEFAULT, 'D0006', 'PM002', 'P005');
