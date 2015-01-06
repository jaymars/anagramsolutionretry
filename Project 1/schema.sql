CREATE TABLE users(id serial primary key, name varchar, email varchar);

CREATE TABLE micro_posts(id serial primary key, title varchar, post text, photo varchar);

CREATE TABLE tags(id serial primary key, tag_name varchar);