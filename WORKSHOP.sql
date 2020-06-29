create user video7 identified by video7;
grant create session to video7;
grant all privileges to video7;
select table_name from user_tables;
select sequence_name from user_sequences;
select constraint_name from user_constraints;

create table member(
    member_id number,
    last_name varchar2(25) not null,
    first_name varchar2(25),
    address varchar2(100),
    city varchar2(30),
    phone varchar2(15),
    join_date date DEFAULT SYSDATE not null,
        constraint pk_member primary key(member_id));

commit;

    create table title(
    Title_id number,
    Title varchar2(60) not null,
    Description varchar2(400) not null,
    Rating varchar2(4),
    Category varchar2(20),
    Release_Date date,
        constraint pk_title primary key(Title_id),
        constraint ck_title check(Category = 'Drama''Comedy''Action''Child''Scifi' AND Rating = 'Available''Destroyed''Rented''Reserved'));


commit;

create table title_copy(
    Copy_id number,
    Title_id number,
    Status varchar2(15) not null,
        constraint pk_title_copy primary key(Copy_id,Title_id));


commit;

create table rental(
    Book_Date date,
    Member_id number,
    Copy_id number,
    Act_Ret_Date date,
    Exp_Ret_Date date DEFAULT sysdate+2,
    Title_id number,
        constraint pk_rental primary key(Book_Date,Member_id,Copy_id,Title_id));

commit;


create table reservation(
    Res_Date date,
    Member_id number,
    Title_id number,
        constraint pk_reservation primary key(Res_date,Member_id,Title_id));

commit;     

	
/*
CREATE TABLE member
(member_id 	NUMBER(10)
			CONSTRAINT member_member_id_pk PRIMARY KEY,
last_name   VARCHAR2(25)
			CONSTRAINT member_last_name_nn NOT NULL,
first_name  VARCHAR2(25),
address	    VARCHAR2(100),
city	    VARCHAR2(30),
phone	    VARCHAR2(15),
join_date   DATE DEFAULT SYSDATE
			CONSTRAINT member_join_date_nn NOT NULL);*/

/*CREATE TABLE title
(title_id   NUMBER(10)
		    CONSTRAINT title_title_id_pk PRIMARY KEY,
title    	VARCHAR2(60)
	        CONSTRAINT title_title_nn NOT NULL,
description VARCHAR2(400)
		    CONSTRAINT title_description_nn NOT NULL,
rating	    VARCHAR2(4)
		    CONSTRAINT title_rating_ck CHECK
		    (rating IN ('G','PG','R','NC17','NR')),
category    VARCHAR2(20),
		    CONSTRAINT title_category_ck CHECK
		    (category IN ('DRAMA','COMEDY','ACTION',
				'CHILD','SCRIPT','DOCUMENTARY')),
release_date DATE);*/

/*create table title(
    Title_id number,
    Title varchar2(60) not null,
    Description varchar2(400) not null,
    Rating varchar2(4),
    Category varchar2(20),
    Release_Date date,
        constraint pk_title primary key(Title_id),
        constraint ck_title check(Category = 
        	'Drama''Comedy''Action''Child''Scifi' AND 
        	Rating = 'Available''Destroyed''Rented''Reserved'));
commit;*/

/*CREATE TABLE title_copy
(copy_id    NUMBER(10),
title_id    NUMBER(10)
		    CONSTRAINT title_copy_title_if_fk REFERENCES title(title_id), 
		    status VARCHAR2(15)
		    CONSTRAINT title_copy_status_nn NOT NULL
		    CONSTRAINT title_copy_status_ck CHECK (status IN
		        ('AVAILABLE', 'DESTROYED', 'RENTED', 'RESERVED')),
		    CONSTRAINT title_copy_copy_id_title_id_pk
			    PRIMARY KEY (copy_id, title_id));
			    */
/*
CREATE TABLE title_copy 

(copy_id NUMBER(10), 
title_id NUMBER(10) 
CONSTRAINT title_copy_title_id_fk REFERENCES 
title(title_id), status VARCHAR2(15) 
CONSTRAINT title_copy_status_nn NOT NULL 
CONSTRAINT title_copy_status_ck CHECK (status IN 
('AVAILABLE', 'DESTROYED', 'RENTED', 'RESERVED')), 
CONSTRAINT title_copy_copy_id_pk PRIMARY KEY (copy_id, title_id));
*/


/*CREATE TABLE rental
(book_date	    DATE DEFAULT SYSDATE,
member_id       NUMBER(10)
			    CONSTRAINT rental_member_id_fk
			    REFERENCES member(member_id),
copy_id 	    NUMBER(10),
act_ret_date    DATE,
exp_ret_date    DATE DEFAULT SYSDATE + 2,
title_id 	    NUMBER(10),
			    CONSTRAINT rental_book_date_copy_title_pk
			    PRIMARY KEY (book_date, member_id, copy_id, 
			       title_id),
			    CONSTRAINT rental_copy_id_title_id_fk
			    FOREIGN KEY (copy_id, title_id)
			    REFERENCES title_copy(copy_id, title_id));*/
/*
CREATE TABLE reservation
(res_date   DATE,
member_id   NUMBER(10)
    CONSTRAINT reservation_member_id
    REFERENCES member(member_id),
title_id    NUMBER(10)
    CONSTRAINT reservation_title_id
    REFERENCES title(title_id),
    CONSTRAINT reservation_resdate_mem_tit_pk PRIMARY KEY
    (res_date, member_id, title_id));*/

Select table_name
FROM user_tables
WHERE table_name IN ('MEMBER', 'TITLE', 'TITLE_COPY', 'RENTAL', 'RESERVATION');

COLUMN CONSTRAINT_name FORMAT A30
COLUMN table_name FORMAT A15

 SELECT constraint_name, constraint_type, table_name
 FROM user_constraints
 WHERE table_name IN ('MEMBER', 'TITLE', 'TITLE COPY', 'RENTAL', 'RESERVATION');

 CREATE SEQUENCE member_id_seq
 START WITH 101
 NOCACHE;

 CREATE SEQUENCE title_id_seq
 START WITH 92
 NOCACHE;

 SELECT sequence_name, increment_by, last_number
 FROM user_sequences
 WHERE sequence_name IN('MEMBER_ID_SEQ', 'TITLE_ID_SEQ');

/*C.*/

/*INSERT INTO title_copy(copy_id, title_id, status)
VALUES ('&copy_id', '&title_id', '&status');*/

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 92, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 93, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 93, 'RENTED');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 94, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 95, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 95, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 95, 'RENTED');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 96, 'AVAILABLE');

INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 97, 'AVAILABLE');

/*D.*/
INSERT INTO rental (title_id, copy_id, member_id,
	book_date, exp_ret_date, act_ret_date)
VALUES (92, 1, 101, SYSDATE-3, SYSDATE-1, SYSDATE-2);

INSERT INTO rental (title_id, copy_id, member_id,
	book_date, exp_ret_date, act_ret_date)
VALUES (93, 2, 101, SYSDATE-1, SYSDATE-1, NULL);

INSERT INTO rental (title_id, copy_id, member_id,
	book_date, exp_ret_date, act_ret_date)
VALUES (95, 3, 102, SYSDATE-2, SYSDATE, NULL);

INSERT INTO rental (title_id, copy_id, member_id,
	book_date, exp_ret_date, act_ret_date)
VALUES (97, 1, 106, SYSDATE-4, SYSDATE-2, SYSDATE-2);
COMMIT;

/*5*/
CREATE VIEW title_avail AS 
SELECT t.title, c.copy_id, c.status, r.exp_ret_date
FROM title t, title_copy c, rental r
WHERE t.title_id = c.title_id
AND c.copy_id = r.copy_id(+)
AND c.title_id = r.title_id(+);

COLUMN title FORMAT A30

SELECT *
FROM title_avail
ORDER BY title, copy_id;

/*6*/
INSERT INTO title (title_id, title, description, rating,
	category, release_date)
VALUES (title_id_seq.NEXTVAL, 'Interstellar Wars', 'Futuristic
	Interstellar action movie. Can the rebels save the humans from 
	the evil Empire?','PG','SCIFI','07-JUL-77')
/
INSERT INTO title_copy(copy_id, title_id, status)
VALUES (1, 98, 'AVAILABLE')
/
INSERT INTO title_copy(copy_id, title_id, status)
VALUES (12, 98, 'AVAILABLE')
/

/*B*/
INSERT INTO reservation (res_date, member_id, title_id)
VALUES (SYSDATE, 101, 98);

INSERT INTO reservation (res_date, member_id, title_id)
VALUES (SYSDATE, 104, 97);
 /*@ C:\Users\beawu\Desktop\p15q4b.sql
  @ C:\Users\beawu\Desktop\p15q4b.sql*/

/*C*/
INSERT INTO rental(title_id, copy_id, member_id)
VALUES (98,1,101);

UPDATE title_copy
SET status='RENTED'
WHERE title_id = 98
AND copy_id = 1;

DELETE 
FROM reservation
WHERE member_id = 101;

SELECT *
FROM title_avail
ORDER BY title, copy_id;

/*7*/
ALTER TABLE title
ADD (price NUMBER(8,2));

DESCIBE title 

/*b*/
SET ECHO OFF
SET VERIFY OFF
UPDATE title
SET price = &price
WHERE title_id = &title_id
/ 
SET VERIFY OFF
SET ECHO OFF
@ C:\Users\beawu\Desktop\p15q7b.sql
START p15q7b.sql

/*c*/

ALTER TABLE title
MODIFY (price CONSTRAINT title_price_nm NOT NULL);

SELECT constraint_name, constraint_type,
search_condition
FROM user_constraints
WHERE table_name = 'TITLE';

/*8*/
 SET ECHO OFF
 SET VERIFY OFF
 TTITLE 'Customer History Report'
 BREAK ON member SKIP 1 ON REPORT
 SELECT m.first_name||' '||m.last_name MEMBER, t.title, 
 	r.book_date, r.act_ret_date - r.book_date DURATION
 FROM member m, title t, rental r 
 WHERE r.member_id = m.member_id  
 AND r.title_id = t.title_id 
 ORDER BY member;

 CLEAR BREAK
 TTITLE OFF
 SET VERIFY ON
 SET ECHO ON

