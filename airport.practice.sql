USE airport;


-- @block
-- Divide aircraft into short, medium and long haul. We will consider 
-- short-haul aircraft with a flight range of > 1000 km and <= 2500 km.
-- Medium-haul - with a flight range> 2500 km and <= 6000 km. 
--- Long-haul - with a flight range> 6000 km. 
-- There should be two columns in the selection, where the aircraft model is indicated in the first one. The second column is a category with the values short-haul, medium-haul, long-haul. Each aircraft falls into exactly one category.
SELECT;


-- @block
-- Add additional category for previous query. If the maximum flight range is 
-- <= 1000 km or there is no flight range data, put 'UNDEFINED' as category.
SELECT;


-- @block
-- Query data about tickets of different price categories.
-- `Economy` class are tickets with a price of 10,000 to 11,000 inclusive to the selection.
-- `PremiumEconomy` are tickets with a price of 20,000 to 30,000 inclusive. 
-- `Business` are tickets with a price strictly greater than 100,000.
-- The solution must use the CASE operator.
-- The selection must contain three attributes - id, service_class, price.
SELECT;


-- @block
-- Divide the planes into three classes according to age.
-- If the aircraft was manufactured before 2000, classify it as 'Old'.
-- If the aircraft was manufactured between 2000 and 2010 inclusive, classify it as 'Mid'.
-- For newer aircraft, classify them as 'New'. 
-- Exclude from the sample long-haul aircraft with a maximum range greater than 10,000 km. 
-- Sort the sample by age class in ascending order.
-- The selection must contain two attributes - side_number, age.
SELECT;


-- @block
-- The airline 's management has reduced ticket prices for flights 
-- LL4S1G8PQW, 0SE4S0HRRU and JQF04Q8I9G.
-- The discount for an economy class ticket (Economy) was 15%,
-- for a business class ticket (Business) - 10%,
-- and for a comfort class ticket (PremiumEconomy) - 20%. 
-- Determine the price of the ticket in each segment, taking into account the discount.
-- The selection must contain three attributes - id, trip_id, new_price.
SELECT;

-- @block
SELECT id,
  service_class,
  price
FROM airport.tickets
WHERE CASE
    service_class
    WHEN 'Business' THEN price > 100000
    WHEN 'PremiumEconomy' THEN price BETWEEN 20000 AND 30000
    WHEN 'Economy' THEN price BETWEEN 10000 AND 11000
  END