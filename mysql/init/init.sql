-- ==========================================================
-- Library Management System - Database Initialization
-- ==========================================================

CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- ----------------------------------------------------------
-- Authors table (owned by the Microservice System, port 81)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    nationality VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO authors (full_name, nationality) VALUES
('Jose Rizal', 'Filipino'),
('George Orwell', 'British'),
('J.K. Rowling', 'British'),
('Haruki Murakami', 'Japanese'),
('Gabriel Garcia Marquez', 'Colombian'),
('F. Sydney Nicholas', 'American');

-- ----------------------------------------------------------
-- Books table (owned by the Main System, port 80)
-- author_id is a "soft" foreign key: the value is chosen from
-- a dropdown populated live via the Microservice API (port 81)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL,
    author_name VARCHAR(150) NOT NULL,
    genre VARCHAR(100),
    published_year INT,
    copies_available INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO books (title, author_id, author_name, genre, published_year, copies_available) VALUES
('Noli Me Tangere', 1, 'Jose Rizal', 'Classic Literature', 1887, 5),
('1984', 2, 'George Orwell', 'Dystopian', 1949, 3),
('Harry Potter and the Sorcerer''s Stone', 3, 'J.K. Rowling', 'Fantasy', 1997, 7),
('Norwegian Wood', 4, 'Haruki Murakami', 'Literary Fiction', 1987, 2);
