SELECT *
FROM blog_user bu 

-- Data Manipulation Language (DML)


-- Adding rows to a table
-- Syntax:
-- INSERT INTO table_name(col_name1, col_name2, etc) VALUES (val_1, val_2, etc)

INSERT INTO blog_user(
	username,
	pw_hash,
	first_name,
	last_name,
	email_address,
	middle_name
) VALUES (
	'brian',
	'dghadfasdf',
	'Brian',
	'Stanton',
	'brian@ct.com',
	'Danger'
);

-- insert antoher user
-- order of the colummns matter
INSERT INTO blog_user(
	first_name,
	middle_name,
	last_name,
	email_address,
	username,
	pw_hash
) VALUES (
	'Travis',
	'Redflag',
	'Peck',
	'travispeck@ct.com',
	'travisp',
	'dafhdjskfajdcviadjfijdzs'
);

SELECT *
FROM blog_user bu ;


INSERT INTO blog_user(
	username,
	pw_hash,
	first_name,
	last_name,
	email_address	
) VALUES (
	'adonai',
	'dghadfdfasdf',
	'Adonai',
	'Romero',
	'adonai@ct.com'
);

SELECT *
FROM blog_user bu ;

-- insert calues ONLY
-- Syntax:
-- INSERT INTO table_name VALUES (val_1, val_2, etc.)
-- values follow the original order that the columns were added
SELECT * FROM category;

INSERT INTO category VALUES (
	1,
	'Programming',
	'Making cool programs with cool languages'
);

SELECT * FROM category;

-- becuase we added the first category with the manual entri of category_id = 1,, the serial default did not call nextval on the sequence. so, when we try to create a new catefory using the default, it will *initially* throw an error

INSERT INTO category (
	category_name,
	description
) VALUES (
	'Health & Fitness',
	'Get that body moving!'
);

SELECT * FROM category;

-- insert multiple rows at a time
-- Syntax:
-- INSERT INTO table_name (col_1, col_2, etc.) VALUES (val_a_1, val_a_2, etc.), (val_1, val_2, etc.)

SELECT * 
FROM post p;

INSERT INTO post (
	title,
	body,
	user_id
) VALUES (
	'Greetings world',
	'This is the first post that we are making',
	1
), (
	'Spring Equinox',
	'What seeds did you plant on this years Equinox?',
	2
), (
	'Manifestation Meditation',
	'Create space, find stillness, feel those manifestations happening now!',
	4
);

SELECT * 
FROM post p;



-- Try to add a post with a user that does not exist

--INSERT INTO post(title, body, user_id) 
-- VALUES ('Hi', 'Will this work?', 123 -- blog_user WITH ID 123 does not exist! will throw an error);
-- Blog User 123 DOES NOT exist! Error 
SELECT *
FROM blog_user;


INSERT INTO blog_user(
	username,
	password_hash,
	email_address,
	first_name,
	last_name 
) VALUES (
	'mickey',
	'dsfkdshfkdsfjk',
	'mickey.mouse@disney.com',
	'Mickey',
	'Mouse'
),(
	'minnie',
	'dklsfhjsdklfhkdl;fjds',
	'minnie.mouse@disney.com',
	'Minnie',
	'Mouse'
);

SELECT *
FROM blog_user;

-- To update existing data in a table
-- Syntax: 
-- UPDATE table_name SET col_1 = val_1, col_2 = val_2, etc. WHERE condition

-- User with the ID of 1 wants to change the username
UPDATE blog_user
SET username = 'bstanton'
WHERE user_id = 1;

SELECT *
FROM blog_user;

UPDATE post 
SET title = 'Greetings World!'
WHERE post_id = 1;

SELECT *
FROM post p 
ORDER BY post_id;

SELECT *
FROM blog_user bu 
WHERE username LIKE '%i%';


UPDATE blog_user
SET middle_name = 'Gunna'
WHERE username LIKE 't%';


SELECT *
FROM blog_user bu 
ORDER BY last_name;

-- Set multiple columns in one command
SELECT *
FROM post;

UPDATE post 
SET title = 'Goodbye World', body = 'The title makes this kind of depressing'
WHERE post_id = 1;

SELECT *
FROM post;

-- Alter the category table and add a color column
ALTER TABLE category 
ADD COLUMN color varchar(7);

SELECT *
FROM category c;

-- An UPDATE/SET without a WHERE will update all ROWS
UPDATE category 
SET color = '#2121b0';

SELECT *
FROM category c;

-- delete data from a table
-- Syntax:
-- DELETE FROM table_name WHERE condition
-- WHERE is not a requirement but HIGHLY RECOMMENDED ** without a WHERE, every row will be delted 

DELETE FROM post 
WHERE post_id = 1;

SELECT * 
FROM post ;

-- A delete from without a WHERE will delte all rows  -- DROP deletes whole table
DELETE FROM category;

SELECT * 
FROM category;

DELETE FROM category;

SELECT title, first_name, last_name, user_id
FROM blog_user bu 
JOIN post p 
ON b.user_id = p.user_id;

-- delete a user that has a post  --GIVES ERROR
DELETE FROM blog_user 
WHERE user_id = 4;


-- to make it so that when we delet a row, it will delete any rows in telatede tables that reference that row, we will ON DELETE CASCADE to foreign key constraint;

-- drop the foreign key constraint on post 
ALTER TABLE post 
DROP CONSTRAINT post_user_id_fkey;

-- ADD the foreign key back, but with the ON DELET CASCADE clause
ALTER TABLE post 
ADD FOREIGN KEY(user_id) REFERENCES blog_user(user_id) ON DELETE CASCADE;

SELECT *
FROM blog_user;

SELECT *
FROM post;

DELETE FROM blog_user 
WHERE user_id = 4;

SELECT *
FROM blog_user;
SELECT *
FROM post;





