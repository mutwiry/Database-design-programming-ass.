# Database-design-programming-ass.
The role of a database administrator tasked with building a MySQL database to store and manage data for a BookStore.
# Bookstore Database Project (MySQL) - Power Learn Project

# Group Members
1.Vincent Mutwiri
2.Tanyaradzwa Roshly Musonza

## Overview

This project involves the design and implementation of a relational database using MySQL for a fictional Bookstore. The goal is to create an efficient and well-structured database to manage core operational data, including information about books, authors, customers, orders, addresses, and related entities.

This database serves as a practical application of database design principles, SQL programming, and user management concepts, as outlined by the Power Learn Project requirements.

## Technologies Used

*   **Database:** MySQL
*   **Schema Visualization (Recommended):** Draw.io or similar ERD tool
*   **Language:** SQL (Structured Query Language)

## Schema Design

The database consists of several interconnected tables designed to store information logically and minimize redundancy. Key entities include:

*   **Books & Related Info:** `book`, `author`, `book_author` (linking table), `publisher`, `book_language`
*   **Customers & Addresses:** `customer`, `address`, `country`, `customer_address` (linking table), `address_status`
*   **Orders & Shipping:** `cust_order` (order header), `order_line` (order details), `shipping_method`, `order_status`, `order_history`

Relationships between tables are enforced using Primary Keys and Foreign Keys with appropriate `ON DELETE` and `ON UPDATE` actions (`CASCADE`, `SET NULL`, `RESTRICT`). Indexes have been added to relevant columns (foreign keys, frequently searched fields like names/codes) to optimize query performance.


## Setup and Usage

To create this database structure in your local MySQL environment:

1.  **Ensure MySQL is running.**
2.  **Connect** to your MySQL server using a client (e.g., MySQL Workbench, `mysql` command line).
3.  **Create the database:**
    ```sql
    CREATE DATABASE bookstore_db; 
    ```
    *(You can choose a different name if desired)*
4.  **Switch to the database:**
    ```sql
    USE bookstore_db;
    ```
5.  **Execute the SQL script:** Run the commands within the `bookstore_schema.sql` file included in this repository.
    *   If using the command line: `SOURCE /path/to/bookstore_schema.sql;`
    *   If using a GUI client, open the `.sql` file and execute its contents.

## Steps Completed

This project involved the following key steps:

1.  **Requirement Analysis:** Understood the project objectives and the list of required tables from the Power Learn Project description.
2.  **Schema Design:** Determined the necessary tables, columns, data types, and relationships (one-to-many, many-to-many) to accurately model the bookstore's data.
3.  **SQL Implementation:** Wrote the initial `CREATE TABLE` statements for MySQL.
4.  **Code Refinement & Correction:** Reviewed and enhanced the SQL code by:
    *   Specifying the `InnoDB` storage engine for all tables to ensure transaction and foreign key support.
    *   Defining Primary Keys (`AUTO_INCREMENT` where applicable) and Composite Keys.
    *   Implementing Foreign Key constraints with appropriate `ON DELETE` and `ON UPDATE` referential actions.
    *   Adding `UNIQUE` constraints to enforce data integrity (e.g., ISBNs, email addresses, lookup table names).
    *   Creating `INDEX`es on foreign keys and other commonly queried columns to improve performance.
    *   Choosing appropriate data types (`VARCHAR`, `INT`, `DECIMAL`, `DATE`, `DATETIME`, etc.) and applying `NOT NULL` constraints where necessary.
    *   Setting default values (e.g., `DEFAULT CURRENT_TIMESTAMP`).
5.  **Final Script Creation:** Consolidated the corrected and refined SQL commands into the `bookstore_schema.sql` file.
6.  **Documentation:** Created this README file to explain the project, schema, setup, and process.



## Project Structure