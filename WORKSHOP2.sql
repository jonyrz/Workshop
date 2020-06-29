create user video2 identified by video2;
grant create session to video2;
grant all privileges to video2;
select table_name from user_tables;
select sequence_name from user_sequences;
select constraint_name from user_constraints;

 CREATE TABLE member
 (member_id NUMBER(10)
 	CONSTRAINT member_member_id_pk PRIMARY KEY,
 	last_name VARCHAR2(25) 
 	CONSTRAINT member_last_name_nn NOT NULL,
 	first_name VARCHAR2(25), 
 	address VARCHAR2(100),
 	city VARCHAR2(30), 
 	phone VARCHAR2(15),
 	join_date DATE DEFAULT SYSDATE
 	CONSTRAINT member_join_date_nn NOT NULL);

  CREATE TABLE title
  (title_id NUMBER(10)
  	CONSTRAINT title_title_id_pk PRIMARY KEY,
  	title VARCHAR2(60) 
  	CONSTRAINT title_title_nn NOT NULL,
  	description VARCHAR2(400)
  	CONSTRAINT title_description_nn NOT NULL, 
  	rating VARCHAR2(4)
  	CONSTRAINT title_rating_ck CHECK
  		(rating IN ('G', 'PG', 'R', 'NC17', 'NR')),
  		category VARCHAR2(20), 
  		CONSTRAINT title_category_ck CHECK
  		(category IN ('DRAMA', 'COMEDY', 'ACTION','CHILD', 
  			'SCIFI', 'DOCUMENTARY')),
  		release_date DATE);

 CREATE TABLE title_copy
 (copy_id NUMBER(10),
 	title_id NUMBER(10)
 	CONSTRAINT title_copy_title_if_fk REFERENCES title(title_id),
 	status VARCHAR2(15)
 	CONSTRAINT title_copy_status_nn NOT NULL 
 	CONSTRAINT title_copy_status_ck CHECK 
 	(status IN('AVAILABLE', 'DESTROYED','RENTED', 'RESERVED')),
 	CONSTRAINT title_copy_copy_id_title_id_pk 
 		PRIMARY KEY (copy_id, title_id));

/*CREATE TABLE rental
  (book_date DATE DEFAULT SYSDATE, 
  	member_id NUMBER(10)
  	CONSTRAINT rental_member_id_fk 
  	REFERENCES member(member_id),
  copy_id NUMBER(10),
  act_ret_date DATE,
  exp_ret_date DATE DEFAULT SYSDATE + 2,
  title_id NUMBER(10),
  CONSTRAINT rental_book_date_copy_title_pk
  PRIMARY KEY (book_date, member_id, copy_id, title_id),
  CONSTRAINT rental_copy_id_title_id_fk
  FOREIGN KEY (copy_id, title_id)
  REFERENCES title_copy(copy_id, title_id));

CREATE TABLE reservation
(res_date DATE, 
	member_id NUMBER(10)
	CONSTRAINT reservation_member_id 
	REFERENCES member(member_id),
	title_id NUMBER(10)
	CONSTRAINT reservation_title_id 
	REFERENCES title(title_id),
	CONSTRAINT reservation_resdate_mem_tit_pk 
	PRIMARY KEY(res_date, member_id, title_id));*/

 SELECT table_name 
 FROM user_tables 
 WHERE table_name IN ('MEMBER', 'TITLE', 'TITLE_COPY',
 	'RENTAL', 'RESERVATION');

 SELECT constraint_name, constraint_type, table_name
 FROM user_constraints 
 WHERE table_name IN ('MEMBER', 'TITLE', 'TITLE_COPY',
 	'RENTAL', 'RESERVATION');

CREATE SEQUENCE member_id_seq 
START WITH 101 
NOCACHE;

CREATE SEQUENCE title_id_seq 
START WITH 92 
NOCACHE;

 SELECT sequence_name, increment_by, last_number
 FROM user_sequences 
 WHERE sequence_name IN ('MEMBER_ID_SEQ', 'TITLE_ID_SEQ');

 SET ECHO OFF
	 INSERT INTO title(title_id, title, description, rating, 
	 	category, release_date) 
	 VALUES (title_id_seq.NEXTVAL, 'Willie and Christmas Too',
	 	'All ofWillie''sfriends make a Christmas list forSanta, 
	 	but Willie has yet to add his own wish list.','G', 'CHILD', 
	 	TO_DATE('05-OCT-1995','DD-MON-YYYY'))
	 /

 INSERT INTO title(title_id , title, description, rating,
 	category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'Alien Again', 'Yet anotherinstallment 
 	of science fiction history. Can theheroine save the planet from the 
 	alien life form?','R', 'SCIFI', TO_DATE( '19-MAY-1995','DD-MON-YYYY'))
 /

 INSERT INTO title(title_id, title, description, rating,category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'The Glob', 'A meteor crashesnear a small 
 	American town and unleashes carnivorousgooin this classic.', 'NR', 'SCIFI', 
 	TO_DATE( '12-AGO-1995','DD-MON-YYYY'))
 /

 INSERT INTO title(title_id, title, description, rating,category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'My Day Off', 'With a littleluck and a lot ingenuity, 
 	a teenager skips school fora day in New York.', 'PG', 'COMEDY', 
 	TO_DATE( '12-JUL-1995','DD-MON-YYYY'))
 /

 INSERT INTO title(title_id, title, description, rating,category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'Miracles on Ice', 'A six-year-old has doubts about 
 	Santa Claus, but she discovers that miracles really do exits', 'PG', 'DRAMA', 
 	TO_DATE( '12-SEP-1995','DD-MON-YYYY'))
 /

 INSERT INTO title(title_id, title, description, rating,category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'Soda Gang', 'After discoveryng a cache of drugs,
 	a young couple find themselves pitted against a vicious gang', 'NR', 'ACTION', 
 	TO_DATE( '01-JUN-1995','DD-MON-YYYY'))
/
 COMMIT
 /
 SET ECHO ON

 SELECT title
 FROM title;
 /

 SET ECHO OFF
 SET VERIFY OFF
 INSERT INTO member(member_id, first_name, last_name, address,
 	city, phone, join_date) 
 VALUES (member_id_seq.NEXTVAL, '&first_name', '&last_name','&address', 
 	'&city', '&phone', TO_DATE('&join_date','DD-MM-YYYY'));
 	COMMIT;
 	SET VERIFY ON
 	SET ECHO ON

 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 92, 'AVAILABLE');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 93, 'AVAILABLE');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (2, 93, 'RENTED');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 94, 'AVAILABLE');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 95, 'AVAILABLE');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (2, 95, 'RENTED');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 96, 'AVAILABLE');
 INSERT INTO title_copy(copy_id, title_id, status) 
 	VALUES (1, 97, 'AVAILABLE');

 INSERT INTO rental(title_id, copy_id, member_id, 
 	book_date, exp_ret_date, act_ret_date) 
 VALUES (92, 1, 101, sysdate-3, sysdate-1, sysdate-2);

 INSERT INTO rental(title_id, copy_id, member_id, 
 	book_date, exp_ret_date, act_ret_date) 
 VALUES (93, 2, 101, sysdate-1, sysdate-1, NULL);

 INSERT INTO rental(title_id, copy_id, member_id, 
 	book_date, exp_ret_date, act_ret_date) 
 VALUES (95, 3, 102, sysdate-2, sysdate, NULL);
 INSERT INTO rental(title_id, copy_id, member_id, 
 	book_date, exp_ret_date,act_ret_date) 
 VALUES (97, 1, 106, sysdate-4, sysdate-2, sysdate-2);
 COMMIT;

CREATE VIEW title_avail AS
SELECT t.title, c.copy_id, c.status, r.exp_ret_date
FROM title t, title_copy c, rental r 
WHERE t.title_id = c.title_id  
AND c.copy_id = r.copy_id(+) 
AND c.title_id = r.title_id(+);
SELECT *
FROM title_avail
ORDER BY title, copy_id;

 INSERT INTO title(title_id, title, description, rating,
 	category, release_date) 
 VALUES (title_id_seq.NEXTVAL, 'Interstellar Wars','Futuristic interstellar 
 	action movie. Can therebels save the humans from the evil Empire?',
 	'PG', 'SCIFI', '07-JUL-77');
 INSERT INTO title_copy (copy_id, title_id, status) 
 VALUES (1, 98, 'AVAILABLE');
 INSERT INTO title_copy (copy_id, title_id, status) 
 VALUES (2, 98, 'AVAILABLE');

 INSERT INTO reservation (res_date, member_id, title_id) 
 VALUES (SYSDATE, 101, 98);
 INSERT INTO reservation (res_date, member_id, title_id) 
 VALUES (SYSDATE, 104, 97

 INSERT INTO rental(title_id, copy_id, member_id) 
 VALUES (98,1,101);
 UPDATE title_copy
 SET status = 'RENTED' 
 WHERE title_id = 98 
 AND copy_id = 1; 
 DELETE 
 FROM reservation 
 WHERE member_id = 101;
 SELECT *
 FROM title_avail
 ORDER BY title, copy_id;

 ALTER TABLE title 
 ADD (price NUMBER(8,2));
 DESCRIBE title

  /*SET ECHO OFF
  SET VERIFY OFF
  DEFINE price = DEFINE title_id =UPDATE title
  SET price = &price 
  WHERE title_id = &title_id;
  SET VERIFY OFF
  SET ECHO OFF*/
  SET ECHO OFF
  SET VERIFY OFF
  UPDATE title
  SET price = &price
  WHERE title_id = &title_id
  /

  ALTER TABLE title MODIFY (price CONSTRAINT title_price_nn NOT NULL);
  SELECT constraint_name, constraint_type,search_condition
  FROM user_constraints WHERE table_name = 'TITLE';

   SET ECHO OFF
   SET VERIFY OFF
   TTITLE 'Customer History Report'
   BREAK ON member SKIP 1 ON REPORT
   SELECT m.first_name||' '||m.last_name MEMBER, t.title, 
   		r.book_date, r.act_ret_date -r.book_date DURATION
   		FROM member m, title t, rental r 
   		WHERE r.member_id = m.member_id  
   		AND r.title_id = t.title_id 
   		ORDER BY member;

   		CLEAR BREAK
   		TTITLE OFF
   		SET VERIFY ON
   		SET ECHO ON