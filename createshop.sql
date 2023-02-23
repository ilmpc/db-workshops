-- @block
CREATE DATABASE IF NOT EXISTS shop;

-- @block
USE shop;

-- @block
DROP TABLE IF EXISTS goods;

-- @block
CREATE TABLE goods (
  id integer AUTO_INCREMENT,
  title varchar(255),
  quantity integer,
  PRIMARY KEY (id) -- uniq, not null
);


-- @block
INSERT INTO goods (title, quantity)
VALUES ('apple', 152),
  ('banana', 789),
  ('kiwi', 55),
  ('table', 17);

-- @block
ALTER TABLE goods
ADD COLUMN price integer DEFAULT 0;

-- @block
SELECT *
FROM goods;

-- @block
UPDATE goods
SET price = NULL;

-- @block
ALTER TABLE goods
MODIFY COLUMN price numeric(8, 2);

-- @block
UPDATE goods
SET price = 100.22
WHERE id = 1;

-- @block
UPDATE goods
SET price = 120.44
WHERE id = 2;


UPDATE goods
SET price = 55
WHERE id = 3;


UPDATE goods
SET price = 899
WHERE id = 4;

-- @block
ALTER TABLE goods
  RENAME COLUMN price TO item_price;

  -- @block
SELECT SUM(item_price * quantity)
FROM goods;

-- @block test
-- INSERT INTO goods VALUES (null, 'orange', 789, 556);
UPDATE goods
SET id = NULL
WHERE id = 5;

-- @block
USE shop;

-- @block
ALTER TABLE goods
ADD CONSTRAINT price_less CHECK (item_price >= 0);

-- @block
UPDATE goods
SET item_price = 0
WHERE id = 1;

-- @block
ALTER TABLE goods
ADD COLUMN create_date datetime DEFAULT NOW();

-- @block
SELECT id,
  title,
  manufacturer
FROM shop.goods;

-- @block
INSERT INTO shop.goods (title, quantity, item_price)
VALUES ('chair', 52, 152.09);

-- @block
ALTER TABLE shop.goods
ADD COLUMN manufacturer varchar(128);

-- @block
UPDATE shop.goods
SET manufacturer = 'bosch';

-- @block
UPDATE shop.goods
SET manufacturer = 'toyota'
WHERE id = '7';

-- @block
ALTER TABLE shop.goods
ADD CONSTRAINT uniq_name UNIQUE(title, manufacturer);

-- @block
INSERT INTO shop.goods (title, manufacturer)
VALUES ('table', 'toyota');

-- @block
USE shop;


CREATE TABLE copy_goods AS
SELECT title,
  manufacturer
FROM goods;

-- @block
SELECT *
FROM copy_goods;

-- @block
INSERT INTO copy_goods
VALUES ('table', 'toyota');

-- @block
USE shop;


INSERT INTO copy_goods
SELECT title,
  manufacturer
FROM goods;

-- @block
CREATE VIEW goods_without_prices AS
SELECT title,
  manufacturer
FROM goods;

-- @block
SELECT *
FROM shop.goods_without_prices
WHERE manufacturer = 'toyota';
