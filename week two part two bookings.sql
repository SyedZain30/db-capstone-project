DROP PROCEDURE IF EXISTS CheckBooking;

DELIMITER //

CREATE PROCEDURE CheckBooking(booking_date DATE, table_number INT)
BEGIN 
SELECT CONCAT('Table','table_number', 'is already booked') AS 'Booking status'
FROM bookings
WHERE BookingDate = booking_date
AND TableNumber = table_number;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(booking_date DATE, table_number INT, staff_id INT)
BEGIN
START TRANSACTION;
SELECT 1 AS 'status'
FROM bookings
WHERE BookingDate = booking_date
AND TableNumber = table_number
LIMIT 1
INTO @booking_status;
IF @booking_status =1 THEN 
ROLLBACK;
SELECT CONCAT('Table ', table_number, ' is already booked - cancelled') AS 'Booking status';
ELSE
INSERT INTO bookings (BookingDate, TableNumber, StaffID) VALUES 
(booking_date, table_number, staff_id);
COMMIT;
SELECT CONCAT('Table','table_number','has been booked succesfully');
END IF;
END //

DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //

CREATE PROCEDURE AddBooking(booking_date DATE, table_number INT, staff_id INT)
BEGIN

INSERT INTO bookings (BookingDate,TableNumber, StaffID)
VALUES(booking_date, table_number, staff_id);

SELECT 'New booking added' AS 'Confirmation';

END //

DELIMITER ;


DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //

CREATE PROCEDURE CancelBooking(booking_id INT)
BEGIN
DELETE FROM bookings WHERE BookingID = booking_id;
SELECT CONCAT('Booking',booking_id,'cancelled') AS Confirmation;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //

CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN
UPDATE bookings SET BookingDate=booking_date
WHERE BookingID = booking_id;

SELECT CONCAT('Booking ', booking_id, ' updated') AS 'Confirmation';

END //

DELIMITER ;

