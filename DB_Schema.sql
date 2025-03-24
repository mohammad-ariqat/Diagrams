-- Create Countries table first as it's referenced by many others
CREATE TABLE countries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL UNIQUE,
    name_ar VARCHAR(255) NOT NULL UNIQUE,
    code VARCHAR(10) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Create Users table
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(50) UNIQUE,
    language VARCHAR(50) NOT NULL,
    ip_country_id BIGINT UNSIGNED NOT NULL,
    time_zone VARCHAR(50) NOT NULL,
    is_banned BOOLEAN DEFAULT FALSE,
    bio TEXT,
    address_id BIGINT UNSIGNED,
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ip_country_id) REFERENCES countries(id)
) ENGINE=InnoDB;

-- Create Address table
CREATE TABLE address (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    city VARCHAR(255) NOT NULL,
    address_line TEXT NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Add foreign key for address_id in users table
ALTER TABLE users
ADD FOREIGN KEY (address_id) REFERENCES address(id);

-- Create Products table
CREATE TABLE products (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL UNIQUE,
    name_ar VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255) NOT NULL,
    description_en TEXT NOT NULL,
    description_ar TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    availability VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
) ENGINE=InnoDB;

-- Create Customers table
CREATE TABLE customers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    balance DECIMAL(10,2) NOT NULL,
    payment_info_id BIGINT UNSIGNED NOT NULL UNIQUE,
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Payment_Info table
CREATE TABLE payment_info (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    data TEXT NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Add foreign key for payment_info_id in customers table
ALTER TABLE customers
ADD FOREIGN KEY (payment_info_id) REFERENCES payment_info(id);

-- Create Cart table
CREATE TABLE cart (
    cart_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    ordered_at TIMESTAMP NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cart_id, customer_id, product_id, ordered_at),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

-- Create Roles table
CREATE TABLE roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- Create Model_Has_Roles table
CREATE TABLE user_has_roles (
    user_id BIGINT UNSIGNED NOT NULL,
    model_type VARCHAR(255) NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB;

-- Create Category table
CREATE TABLE category (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL UNIQUE,
    name_ar VARCHAR(255) NOT NULL UNIQUE,
    image VARCHAR(255) NOT NULL,
    description_en TEXT NOT NULL,
    description_ar TEXT NOT NULL
) ENGINE=InnoDB;

-- Create Post table
CREATE TABLE post (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title_en VARCHAR(255) NOT NULL,
    title_ar VARCHAR(255) NOT NULL,
    content_en TEXT NOT NULL,
    content_ar TEXT NOT NULL,
    image VARCHAR(255) NOT NULL,
    expert_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (expert_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Specialty table
CREATE TABLE specialty (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL UNIQUE,
    name_ar VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Create Payments table
CREATE TABLE payments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL UNIQUE,
    customer_id BIGINT UNSIGNED NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_info_id BIGINT UNSIGNED NOT NULL,
    status VARCHAR(50) NOT NULL,
    refund_status VARCHAR(50),
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (payment_info_id) REFERENCES payment_info(id)
) ENGINE=InnoDB;

-- Create Services table
CREATE TABLE services (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL UNIQUE,
    name_ar VARCHAR(255) NOT NULL UNIQUE,
    image VARCHAR(255) NOT NULL,
    description_en TEXT NOT NULL,
    description_ar TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
) ENGINE=InnoDB;

-- Create Log table
CREATE TABLE log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    action TEXT NOT NULL,
    log_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Discount table
CREATE TABLE discount (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    title VARCHAR(255) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    is_active BOOLEAN NOT NULL,
    expire_date DATE NOT NULL,
    quantity INT NOT NULL,
    country_id BIGINT UNSIGNED,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
) ENGINE=InnoDB;

-- Create Shops table
CREATE TABLE shops (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    details TEXT NOT NULL,
    owner_phone_number VARCHAR(50) NOT NULL,
    owner_name VARCHAR(255) NOT NULL,
    is_partner BOOLEAN NOT NULL,
    image VARCHAR(255) NOT NULL,
    employee_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (employee_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Product_Shops table
CREATE TABLE product_shops (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT UNSIGNED NOT NULL,
    shop_id BIGINT UNSIGNED NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    employee_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    UNIQUE (product_id, shop_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (shop_id) REFERENCES shops(id),
    FOREIGN KEY (employee_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Orders table
CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cart_id BIGINT UNSIGNED NOT NULL UNIQUE,
    address_id BIGINT UNSIGNED NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    employee_id BIGINT UNSIGNED NOT NULL,
    payment_id BIGINT UNSIGNED NOT NULL,
    status VARCHAR(50) NOT NULL,
    delivery_cost DECIMAL(10,2) NOT NULL,
    product_total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (employee_id) REFERENCES users(id),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
) ENGINE=InnoDB;

-- Create Service_Requests table
CREATE TABLE service_requests (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    service_id BIGINT UNSIGNED NOT NULL,
    address_id BIGINT UNSIGNED NOT NULL,
    details TEXT NOT NULL,
    image VARCHAR(255) NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    employee_id BIGINT UNSIGNED NOT NULL,
    expert_id BIGINT UNSIGNED NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (employee_id) REFERENCES users(id),
    FOREIGN KEY (expert_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- Create Category_Products table
CREATE TABLE category_products (
    category_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    PRIMARY KEY (category_id, product_id),
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

-- Create Discount_Products table
CREATE TABLE discount_products (
    discount_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    PRIMARY KEY (discount_id, product_id),
    FOREIGN KEY (discount_id) REFERENCES discount(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

-- Create Expert_Specialty table
CREATE TABLE expert_specialty (
    expert_id BIGINT UNSIGNED NOT NULL,
    specialty_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    PRIMARY KEY (expert_id, specialty_id),
    FOREIGN KEY (expert_id) REFERENCES users(id),
    FOREIGN KEY (specialty_id) REFERENCES specialty(id)
) ENGINE=InnoDB;

-- Create Review table
CREATE TABLE review (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rating INT NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;