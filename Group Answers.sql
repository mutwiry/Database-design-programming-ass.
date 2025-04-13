SET default_storage_engine=InnoDB;

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_language_name UNIQUE (language_name) 
) ENGINE=InnoDB;

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    CONSTRAINT uk_publisher_name UNIQUE (publisher_name) 
) ENGINE=InnoDB;

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100), 
    last_name VARCHAR(100) NOT NULL, 
    INDEX idx_author_name (last_name, first_name) 
) ENGINE=InnoDB;

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20), 
    language_id INT, 
    publisher_id INT, 
    publication_date DATE, 
    num_pages INT,         
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00, 
    CONSTRAINT uk_isbn UNIQUE (isbn), 
    INDEX idx_book_language (language_id),
    INDEX idx_book_publisher (publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE 
) ENGINE=InnoDB;

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
) ENGINE=InnoDB;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code_iso2 CHAR(2), 
    CONSTRAINT uk_country_name UNIQUE (country_name),
    CONSTRAINT uk_country_code UNIQUE (country_code_iso2) 
) ENGINE=InnoDB;

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_address_status_name UNIQUE (status_name)
) ENGINE=InnoDB;

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(20),
    street_name VARCHAR(200),
    address_line2 VARCHAR(200), 
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT NOT NULL, 
    INDEX idx_addr_country (country_id),
    INDEX idx_addr_postal_code (postal_code), 
    FOREIGN KEY (country_id) REFERENCES country(country_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(25), 
    registration_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_customer_email UNIQUE (email), 
    INDEX idx_customer_name (last_name, first_name)
) ENGINE=InnoDB;

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT NOT NULL, 
    PRIMARY KEY (customer_id, address_id), 
    INDEX idx_ca_addr (address_id), 
    INDEX idx_ca_status (status_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT uk_shipping_method_name UNIQUE (method_name)
) ENGINE=InnoDB;

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_order_status_name UNIQUE (status_name)
) ENGINE=InnoDB;

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT, 
    dest_address_id INT, 
    current_status_id INT NOT NULL, 
    order_total DECIMAL(12, 2), 
    INDEX idx_order_customer (customer_id),
    INDEX idx_order_shipping_method (shipping_method_id),
    INDEX idx_order_dest_address (dest_address_id),
    INDEX idx_order_status (current_status_id),
    INDEX idx_order_date (order_date),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    FOREIGN KEY (dest_address_id) REFERENCES address(address_id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    FOREIGN KEY (current_status_id) REFERENCES order_status(status_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE order_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0), 
    price DECIMAL(10, 2) NOT NULL, 
    INDEX idx_line_order (order_id),
    INDEX idx_line_book (book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL, 
    status_timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    notes VARCHAR(255), 
    INDEX idx_hist_order (order_id),
    INDEX idx_hist_status (status_id),
    INDEX idx_hist_timestamp (status_timestamp),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;