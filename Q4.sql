
CREATE DATABASE  Q4_ecommerce;
USE Q4_ecommerce;

-- Create tables

CREATE TABLE Carts (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    created_at DATETIME NOT NULL
);

CREATE TABLE CartItems (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id)
);

-- Insert sample data

-- Insert carts created on different days
INSERT INTO Carts (created_at) VALUES
('2025-06-14 10:00:00'),
('2025-06-14 11:00:00'),
('2025-06-15 09:30:00'),
('2025-06-15 15:45:00'),
('2025-06-16 08:00:00');

-- Insert cart items (only for some carts)
INSERT INTO CartItems (cart_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 103, 1),
(3, 104, 5),
(4, 101, 1);

-- Insert orders (only some carts checked out)
INSERT INTO Orders (cart_id, order_date) VALUES
(1, '2025-06-14 12:00:00'),  
(3, '2025-06-15 10:00:00');  

-- Q5
SELECT
  DATE(c.created_at) AS cart_date,
  YEARWEEK(c.created_at, 1) AS cart_week,

  COUNT(DISTINCT c.cart_id) AS total_carts_with_items,

  COUNT(DISTINCT CASE WHEN o.order_id IS NOT NULL THEN c.cart_id END) AS checked_out_carts,

  -- Modified to include the percentage symbol in the output
  CONCAT(
    ROUND(
      100.0 * (
        COUNT(DISTINCT c.cart_id) - COUNT(DISTINCT CASE WHEN o.order_id IS NOT NULL THEN c.cart_id END)
      ) / NULLIF(COUNT(DISTINCT c.cart_id), 0),
      2
    ), '%'
  ) AS abandoned_percentage
FROM
  Carts c
  JOIN CartItems ci ON c.cart_id = ci.cart_id
  LEFT JOIN Orders o ON c.cart_id = o.cart_id
GROUP BY
  cart_date,
  cart_week
ORDER BY
  cart_date;



