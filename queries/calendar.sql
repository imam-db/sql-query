-- Create table calendar
CREATE TABLE calendar (
  calendar_date DATE NOT NULL PRIMARY KEY,
  calendar_year YEAR NOT NULL,
  calendar_quarter TINYINT NOT NULL,
  calendar_month TINYINT NOT NULL,
  calendar_day_of_month TINYINT NOT NULL,
  calendar_day_of_week TINYINT NOT NULL,
  calendar_week_of_year TINYINT NOT NULL,
  calendar_day_name VARCHAR(9) NOT NULL
);

-- Create store procedure
DELIMITER $$
CREATE PROCEDURE populate_calendar(IN pStartDate DATE, IN pEndDate DATE)
BEGIN
  DECLARE start_date DATE;
  DECLARE end_date DATE;
  
  SET start_date = pStartDate;
  SET end_date = pEndDate;
  
  WHILE start_date <= end_date DO
    INSERT INTO calendar (calendar_date, calendar_year, calendar_quarter, calendar_month, calendar_day_of_month, calendar_day_of_week, calendar_week_of_year, calendar_day_name)
    VALUES (start_date, YEAR(start_date), QUARTER(start_date), MONTH(start_date), DAY(start_date), DAYOFWEEK(start_date), WEEKOFYEAR(start_date), DAYNAME(start_date));
    SET start_date = DATE_ADD(start_date, INTERVAL 1 DAY);
  END WHILE;
END$$
DELIMITER ;

-- call the store procedure to populate table calendar from '2023-01-01' until '2023-12-31'
CALL populate_calendar('2023-01-01', '2023-12-31')