
-- Task 1.1: Basic CHECK Constraint

CREATE TABLE employees (
    employee_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    age INTEGER CHECK (age BETWEEN 18 AND 65),
    salary NUMERIC CHECK (salary > 0)
);


-- Task 1.2: Named CHECK Constraint

CREATE TABLE products_catalog (
    product_id INTEGER,
    product_name TEXT,
    regular_price NUMERIC,
    discount_price NUMERIC,
    CONSTRAINT valid_discount CHECK (
        regular_price > 0
        AND discount_price > 0
        AND discount_price < regular_price
    )
);


-- Task 1.3: Multiple Column CHECK

CREATE TABLE bookings (
    booking_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    num_guests INTEGER,
    CHECK (num_guests BETWEEN 1 AND 10),
    CHECK (check_out_date > check_in_date)
);


-- Task 1.4: Testing CHECK Constraints

-- Valid employees
INSERT INTO employees VALUES (1, 'John', 'Smith', 25, 250000);
INSERT INTO employees VALUES (2, 'Anna', 'Brown', 40, 400000);

-- Invalid: age must be between 18 and 65
-- INSERT INTO employees VALUES (3, 'Mike', 'Johnson', 17, 200000);

-- Invalid: salary must be greater than 0
-- INSERT INTO employees VALUES (4, 'Alex', 'Taylor', 30, -1000);


-- Valid products_catalog
INSERT INTO products_catalog VALUES (1, 'Laptop', 500000, 450000);
INSERT INTO products_catalog VALUES (2, 'Phone', 300000, 270000);

-- Invalid: regular_price must be greater than 0
-- INSERT INTO products_catalog VALUES (3, 'Tablet', -100000, 90000);

-- Invalid: discount_price must be greater than 0
-- INSERT INTO products_catalog VALUES (4, 'Monitor', 150000, -10000);

-- Invalid: discount_price must be less than regular_price
-- INSERT INTO products_catalog VALUES (5, 'Keyboard', 30000, 35000);


-- Valid bookings
INSERT INTO bookings VALUES (1, '2026-10-15', '2026-10-20', 2);
INSERT INTO bookings VALUES (2, '2026-11-01', '2026-11-05', 5);

-- Invalid: num_guests must be between 1 and 10
-- INSERT INTO bookings VALUES (3, '2026-10-15', '2026-10-20', 0);

-- Invalid: check_out_date must be after check_in_date
-- INSERT INTO bookings VALUES (4, '2026-10-20', '2026-10-15', 3);


SELECT * FROM employees;
SELECT * FROM products_catalog;
SELECT * FROM bookings;


-- Task 2.1: NOT NULL Implementation

CREATE TABLE customers (
    customer_id INTEGER NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);


-- Task 2.2: Combining Constraints

CREATE TABLE inventory (
    item_id INTEGER NOT NULL,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
    last_updated TIMESTAMP NOT NULL
);


-- Task 2.3: Testing NOT NULL

-- Valid customers
INSERT INTO customers VALUES (1, 'john@gmail.com', '+77001234567', '2026-10-13');
INSERT INTO customers VALUES (2, 'anna@gmail.com', NULL, '2026-10-13');

-- Invalid: customer_id cannot be NULL
-- INSERT INTO customers VALUES (NULL, 'mike@gmail.com', '+77005555555', '2026-10-13');

-- Invalid: email cannot be NULL
-- INSERT INTO customers VALUES (3, NULL, '+77007777777', '2026-10-13');

-- Invalid: registration_date cannot be NULL
-- INSERT INTO customers VALUES (4, 'alex@gmail.com', '+77009999999', NULL);

-- Valid: phone is nullable
INSERT INTO customers VALUES (5, 'emma@gmail.com', NULL, '2026-10-13');


-- Valid inventory
INSERT INTO inventory VALUES (1, 'Laptop', 10, 500000, '2026-10-13 12:00:00');
INSERT INTO inventory VALUES (2, 'Mouse', 25, 15000, '2026-10-13 13:00:00');

-- Invalid: item_name cannot be NULL
-- INSERT INTO inventory VALUES (3, NULL, 5, 10000, '2026-10-13 14:00:00');

-- Invalid: quantity cannot be NULL
-- INSERT INTO inventory VALUES (4, 'Keyboard', NULL, 25000, '2026-10-13 15:00:00');

-- Invalid: unit_price cannot be NULL
-- INSERT INTO inventory VALUES (5, 'Monitor', 7, NULL, '2026-10-13 16:00:00');

-- Invalid: last_updated cannot be NULL
-- INSERT INTO inventory VALUES (6, 'Printer', 3, 120000, NULL);


SELECT * FROM customers;
SELECT * FROM inventory;




-- Task 3.1: Single Column UNIQUE

CREATE TABLE users (
    user_id INTEGER,
    username TEXT UNIQUE,
    email TEXT UNIQUE,
    created_at TIMESTAMP
);

INSERT INTO users VALUES (1, 'john123', 'john@gmail.com', '2026-10-13 12:00:00');
INSERT INTO users VALUES (2, 'anna456', 'anna@gmail.com', '2026-10-13 13:00:00');


-- Task 3.2: Multi-Column UNIQUE

CREATE TABLE course_enrollments (
    enrollment_id INTEGER,
    student_id INTEGER,
    course_code TEXT,
    semester TEXT,
    UNIQUE (student_id, course_code, semester)
);

INSERT INTO course_enrollments VALUES (1, 101, 'CS101', 'Fall2026');
INSERT INTO course_enrollments VALUES (2, 101, 'CS102', 'Fall2026');
INSERT INTO course_enrollments VALUES (3, 101, 'CS101', 'Spring2027');

-- Invalid: the same (student_id, course_code, semester) combination
-- INSERT INTO course_enrollments VALUES (4, 101, 'CS101', 'Fall2026');


-- Task 3.3: Named UNIQUE Constraints

ALTER TABLE users DROP CONSTRAINT users_username_key;
ALTER TABLE users DROP CONSTRAINT users_email_key;

ALTER TABLE users
ADD CONSTRAINT unique_username UNIQUE (username);

ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);

-- Invalid: duplicate username, violates unique_username
-- INSERT INTO users VALUES (3, 'john123', 'mike@gmail.com', '2026-10-13 14:00:00');

-- Invalid: duplicate email, violates unique_email
-- INSERT INTO users VALUES (4, 'mike789', 'anna@gmail.com', '2026-10-13 15:00:00');


SELECT * FROM users;
SELECT * FROM course_enrollments;




-- Task 4.1: Single Column Primary Key

CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT NOT NULL,
    location TEXT
);

INSERT INTO departments VALUES (1, 'IT', 'Almaty');
INSERT INTO departments VALUES (2, 'Finance', 'Astana');
INSERT INTO departments VALUES (3, 'HR', 'Almaty');

-- Invalid: duplicate dept_id
-- INSERT INTO departments VALUES (1, 'Marketing', 'Shymkent');

-- Invalid: PRIMARY KEY cannot be NULL
-- INSERT INTO departments VALUES (NULL, 'Legal', 'Almaty');


-- Task 4.2: Composite Primary Key

CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_courses VALUES (101, 1, '2026-09-01', 'A');
INSERT INTO student_courses VALUES (101, 2, '2026-09-01', 'B');
INSERT INTO student_courses VALUES (102, 1, '2026-09-01', 'A');

-- Invalid: duplicate composite primary key (101, 1)
-- INSERT INTO student_courses VALUES (101, 1, '2026-10-01', 'A+');


-- Task 4.3: Comparison Exercise

-- 1. UNIQUE vs PRIMARY KEY:
-- PRIMARY KEY uniquely identifies each row and cannot contain NULL values.
-- UNIQUE also prevents duplicate values, but PostgreSQL allows NULL values
-- in a UNIQUE column by default.

-- 2. Single-column vs composite PRIMARY KEY:
-- Use a single-column PRIMARY KEY when one column uniquely identifies a row,
-- for example dept_id.
-- Use a composite PRIMARY KEY when uniqueness depends on a combination
-- of columns, for example (student_id, course_id).

-- 3. One PRIMARY KEY but multiple UNIQUE constraints:
-- A table has one PRIMARY KEY because it is the main identifier of rows.
-- However, a table may have several other candidate keys, so multiple
-- UNIQUE constraints are allowed.


SELECT * FROM departments;
SELECT * FROM student_courses;



-- Task 5.1: Basic Foreign Key

CREATE TABLE employees_dept (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id),
    hire_date DATE
);

INSERT INTO employees_dept VALUES (1, 'Alice', 1, '2026-01-15');
INSERT INTO employees_dept VALUES (2, 'Bob', 2, '2026-02-10');

-- Invalid: dept_id 99 does not exist in departments
-- INSERT INTO employees_dept VALUES (3, 'Charlie', 99, '2026-03-01');


-- Task 5.2: Multiple Foreign Keys

CREATE TABLE authors (
    author_id INTEGER PRIMARY KEY,
    author_name TEXT NOT NULL,
    country TEXT
);

CREATE TABLE publishers (
    publisher_id INTEGER PRIMARY KEY,
    publisher_name TEXT NOT NULL,
    city TEXT
);

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER REFERENCES authors(author_id),
    publisher_id INTEGER REFERENCES publishers(publisher_id),
    publication_year INTEGER,
    isbn TEXT UNIQUE
);

INSERT INTO authors VALUES (1, 'George Orwell', 'United Kingdom');
INSERT INTO authors VALUES (2, 'Haruki Murakami', 'Japan');
INSERT INTO authors VALUES (3, 'Abai Kunanbayev', 'Kazakhstan');

INSERT INTO publishers VALUES (1, 'Penguin Books', 'London');
INSERT INTO publishers VALUES (2, 'Vintage', 'New York');
INSERT INTO publishers VALUES (3, 'Atamura', 'Almaty');

INSERT INTO books VALUES (1, '1984', 1, 1, 1949, '9780451524935');
INSERT INTO books VALUES (2, 'Norwegian Wood', 2, 2, 1987, '9780375704024');
INSERT INTO books VALUES (3, 'Book of Words', 3, 3, 1845, '9786010000001');


-- Task 5.3: ON DELETE Options

CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE products_fk (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER REFERENCES categories(category_id) ON DELETE RESTRICT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL
);

CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products_fk(product_id),
    quantity INTEGER CHECK (quantity > 0)
);


INSERT INTO categories VALUES (1, 'Electronics');
INSERT INTO categories VALUES (2, 'Books');

INSERT INTO products_fk VALUES (1, 'Laptop', 1);
INSERT INTO products_fk VALUES (2, 'SQL Book', 2);

INSERT INTO orders VALUES (1, '2026-10-13');
INSERT INTO orders VALUES (2, '2026-10-14');

INSERT INTO order_items VALUES (1, 1, 1, 2);
INSERT INTO order_items VALUES (2, 1, 2, 1);
INSERT INTO order_items VALUES (3, 2, 2, 3);


-- Scenario 1: RESTRICT
-- This fails because category 1 is referenced by Laptop in products_fk.
-- DELETE FROM categories WHERE category_id = 1;
-- Result: PostgreSQL rejects the deletion because ON DELETE RESTRICT
-- prevents deletion of a referenced category.


-- Scenario 2: CASCADE
-- Before deletion, order 2 has one related order_item.
SELECT * FROM order_items WHERE order_id = 2;

DELETE FROM orders WHERE order_id = 2;

-- After deletion, no rows with order_id = 2 remain in order_items,
-- because ON DELETE CASCADE automatically deleted them.
SELECT * FROM order_items WHERE order_id = 2;


SELECT * FROM employees_dept;
SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM books;
SELECT * FROM categories;
SELECT * FROM products_fk;
SELECT * FROM orders;
SELECT * FROM order_items;


-- Task 6.1: E-commerce Database Design
-- ============================================================

-- The names "customers" and "orders" were already used in earlier parts.
-- Drop the earlier versions before creating the final e-commerce schema.
-- order_items is dropped because it depends on the previous orders table.

DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;


-- customers

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    registration_date DATE NOT NULL
);


-- products

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0)
);


-- orders

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC NOT NULL CHECK (total_amount >= 0),
    status TEXT NOT NULL CHECK (
        status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')
    ),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE RESTRICT
);


-- order_details

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price >= 0),

    CONSTRAINT fk_order_details_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_details_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);


-- ------------------------------------------------------------
-- Part 6: At least 5 sample records per table
-- ------------------------------------------------------------

INSERT INTO customers VALUES
(1, 'John Smith', 'john.smith@gmail.com', '+77001111111', '2026-09-01'),
(2, 'Anna Brown', 'anna.brown@gmail.com', '+77002222222', '2026-09-05'),
(3, 'Mike Johnson', 'mike.johnson@gmail.com', NULL, '2026-09-10'),
(4, 'Emma Davis', 'emma.davis@gmail.com', '+77004444444', '2026-09-15'),
(5, 'Alex Wilson', 'alex.wilson@gmail.com', '+77005555555', '2026-09-20');


INSERT INTO products VALUES
(1, 'Laptop', '15-inch laptop', 500000, 10),
(2, 'Smartphone', '128 GB smartphone', 300000, 20),
(3, 'Keyboard', 'Mechanical keyboard', 35000, 30),
(4, 'Mouse', 'Wireless mouse', 18000, 50),
(5, 'Monitor', '27-inch monitor', 150000, 15);


INSERT INTO orders VALUES
(1, 1, '2026-10-01', 535000, 'delivered'),
(2, 2, '2026-10-03', 318000, 'shipped'),
(3, 3, '2026-10-05', 150000, 'processing'),
(4, 4, '2026-10-07', 70000, 'pending'),
(5, 5, '2026-10-09', 0, 'cancelled');


INSERT INTO order_details VALUES
(1, 1, 1, 1, 500000),
(2, 1, 3, 1, 35000),
(3, 2, 2, 1, 300000),
(4, 2, 4, 1, 18000),
(5, 3, 5, 1, 150000),
(6, 4, 3, 2, 35000);


-- ------------------------------------------------------------
-- Part 6: Constraint tests
-- Failed attempts are commented out, as required.
-- ------------------------------------------------------------

-- PRIMARY KEY test: duplicate customer_id
-- INSERT INTO customers
-- VALUES (1, 'Duplicate User', 'duplicate@gmail.com', NULL, '2026-10-10');

-- UNIQUE test: duplicate customer email
-- INSERT INTO customers
-- VALUES (6, 'Another John', 'john.smith@gmail.com', NULL, '2026-10-10');

-- NOT NULL test: customer name cannot be NULL
-- INSERT INTO customers
-- VALUES (6, NULL, 'test@gmail.com', NULL, '2026-10-10');

-- CHECK test: product price cannot be negative
-- INSERT INTO products
-- VALUES (6, 'Invalid Product', 'Negative price', -100, 5);

-- CHECK test: stock_quantity cannot be negative
-- INSERT INTO products
-- VALUES (6, 'Invalid Product', 'Negative stock', 1000, -5);

-- FOREIGN KEY test: customer_id 999 does not exist
-- INSERT INTO orders
-- VALUES (6, 999, '2026-10-10', 10000, 'pending');

-- CHECK test: invalid order status
-- INSERT INTO orders
-- VALUES (6, 1, '2026-10-10', 10000, 'waiting');

-- CHECK test: order_details quantity must be positive
-- INSERT INTO order_details
-- VALUES (7, 1, 1, 0, 500000);

-- FOREIGN KEY test: product_id 999 does not exist
-- INSERT INTO order_details
-- VALUES (7, 1, 999, 1, 1000);


-- ON DELETE RESTRICT test:
-- Customer 1 has an order, so this deletion should fail.
-- DELETE FROM customers WHERE customer_id = 1;


-- ON DELETE CASCADE test:
-- Create a temporary order and order detail for demonstration.
INSERT INTO orders
VALUES (6, 1, '2026-10-11', 18000, 'pending');

INSERT INTO order_details
VALUES (7, 6, 4, 1, 18000);

-- Verify that the detail exists
SELECT * FROM order_details WHERE order_id = 6;

-- Deleting order 6 automatically deletes its order_details
DELETE FROM orders WHERE order_id = 6;

-- Should return zero rows
SELECT * FROM order_details WHERE order_id = 6;


-- Final data
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;

