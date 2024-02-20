/* char(1) is used as a boolean type: room_availability: 1 or room_availability: 0, since sql does not have boolean types */
DROP TABLE Guest CASCADE CONSTRAINTS;
DROP TABLE Guest_Email CASCADE CONSTRAINTS;
DROP TABLE Guest_Phone CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE Reservation CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Staff_Phone CASCADE CONSTRAINTS;
DROP TABLE Supply CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Consumable CASCADE CONSTRAINTS;


alter session set nls_language='ENGLISH';
alter session set nls_date_format='DD-MON-YYYY'; 

CREATE TABLE Guest (
    guest_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    gender VARCHAR(10),
    date_of_birth Date
);


CREATE TABLE Guest_Phone (
    guest_id INT NOT NULL,
    phone_number INT NOT NULL,
    CONSTRAINT PK_GUEST_PHONE PRIMARY KEY(guest_id, phone_number)
);


CREATE TABLE Guest_Email (
    guest_id INT NOT NULL,
    email VARCHAR2(40) NOT NULL,
    CONSTRAINT PK_GUEST_EMAIL PRIMARY KEY(guest_id, email)
);

CREATE TABLE Staff (
    staff_id INT NOT NULL PRIMARY KEY,
    staff_first_name VARCHAR2(30),
    staff_last_name VARCHAR2(30),
    staff_position VARCHAR2(30)
);


CREATE TABLE Staff_Phone (
    staff_id INT NOT NULL,
    staff_phone INT NOT NULL,
    CONSTRAINT PK_STAFF_PHONE PRIMARY KEY(staff_id, staff_phone)
);


CREATE TABLE Room (
    room_number INT NOT NULL PRIMARY KEY,
    room_availability CHAR(1), 
    room_is_clear CHAR(1),
    staff_id INT,

    CONSTRAINT FK_ROOM_STAFF_ID FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Supply (
    supply_id INT NOT NULL,
    supply_type VARCHAR2(20),
    quantity INT,
    room_number INT NOT NULL,

    CONSTRAINT PK_SUPPLY PRIMARY KEY(supply_id, room_number),
    CONSTRAINT FK_SUPPLY_ROOM_NUMBER FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE
);

CREATE TABLE Payment (
    payment_id int not null primary key,
    payment_date date,
    billing_amount decimal(10, 2),
    payment_type varchar(30),
    guest_id int,

    constraint pk_payment_guest_id foreign key (guest_id) references Guest(guest_id) ON DELETE CASCADE

);

CREATE TABLE Orders (
    order_id INT NOT NULL PRIMARY KEY,
    table_number int,
    total_price int,
    payment_id int,
    guest_id int,
    staff_id int,

    CONSTRAINT FK_ORDER_PAYMENT_ID FOREIGN KEY (payment_id) REFERENCES Payment(payment_id) ON DELETE CASCADE,
    CONSTRAINT FK_ORDER_GUEST_ID FOREIGN KEY (guest_id) REFERENCES Guest(guest_id) ON DELETE CASCADE, 
    CONSTRAINT FK_ORDER_STAFF_ID FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Consumable (
    item_id INT not null,
    item_name VARCHAR2(30),
    item_price INT,
    item_amount INT,
    item_type VARCHAR2(30),
    order_id INT,

    CONSTRAINT PK_CONSUMABLE PRIMARY KEY (item_id, order_id),
    CONSTRAINT FK_CONSUMABLE_ORDER_ID FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);


CREATE TABLE Reservation (
    reservation_id INT NOT NULL PRIMARY KEY,
    check_in_date DATE,
    check_out_date DATE,
    reservation_cancellation CHAR(1),
    booking_status CHAR(1),
    number_of_people INT,
    staff_id INT,
    guest_id INT,
    payment_id INT,
    room_number INT,
    CONSTRAINT FK_RESERVATION_GUEST_ID FOREIGN KEY (guest_id) REFERENCES Guest(guest_id) ON DELETE CASCADE,
    CONSTRAINT FK_RESERVATION_STAFF_ID FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE,
    CONSTRAINT FK_RESERVATION_PAYMENT_ID FOREIGN KEY (payment_id) REFERENCES Payment(payment_id) ON DELETE CASCADE,
    CONSTRAINT FK_RESERVATION_ROOM_ID FOREIGN KEY (room_number) REFERENCES Room(room_number) ON DELETE CASCADE
);

/**********************************************************************************/


DELETE FROM Guest;
DELETE FROM Guest_Email;
DELETE FROM Guest_Phone;
DELETE FROM Room;
DELETE FROM Reservation;
DELETE FROM Payment;
DELETE FROM Staff;
DELETE FROM Staff_Phone;
DELETE FROM Supply;
DELETE FROM Orders;
DELETE FROM Consumable;



--guest_id, first_name, last_name, gender, birth_date
INSERT INTO Guest VALUES
(100001, 'Hasan', 'Coban', 'Male', TO_DATE('25-MAY-1985', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100002, 'Bora', 'Ersoy', 'Male', TO_DATE('15-APR-1985', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100003, 'Ramazan', 'Cuhaci', 'Male', TO_DATE('15-MAY-1955', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100004, 'Onur', 'Sahinler', 'Male', TO_DATE('25-MAY-1985', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100005, 'Emir', 'Kaldirimci', 'Male', TO_DATE('15-JUN-1985', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100006, 'Sebnem', 'Ferah', 'Male', TO_DATE('15-MAY-1985', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100007, 'Duke ', 'Ellington', 'Male', TO_DATE('22-AUG-1990', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100008, 'LeBron', 'James', 'Male', TO_DATE('10-DEC-1978', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100009, 'Sarah', 'Brown', 'Female', TO_DATE('03-APR-1982', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100010, 'Jones', 'Breckie', 'Male', TO_DATE('30-MAY-2005', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100011, 'Jessica', 'Miller', 'Female', TO_DATE('17-SEP-1989', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100012, 'Brian', 'Moore', 'Male', TO_DATE('09-FEB-1974', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100013, 'Megan', 'Taylor', 'Female', TO_DATE('14-JUL-1987', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100014, 'Christopher', 'White', 'Male', TO_DATE('26-NOV-1980', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100015, 'Ashley', 'Garcia', 'Female', TO_DATE('05-MAR-1993', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100016, 'Kevin', 'Anderson', 'Male', TO_DATE('18-AUG-1983', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100017, 'Olivia', 'Thomas', 'Female', TO_DATE('21-JAN-1998', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100018, 'Daniel', 'Lee', 'Male', TO_DATE('14-MAY-1977', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100019, 'Sophia', 'Hernandez', 'Female', TO_DATE('30-SEP-1984', 'DD-MON-YYYY'));
INSERT INTO Guest VALUES
(100020, 'Andrew', 'Hall', 'Male', TO_DATE('08-DEC-1991', 'DD-MON-YYYY'));


--guest_id, phone_number
INSERT INTO Guest_Phone VALUES
(100001, '5351234567');
INSERT INTO Guest_Phone VALUES
(100001, '5314234541');
INSERT INTO Guest_Phone VALUES
(100002, '5329876543');
INSERT INTO Guest_Phone VALUES
(100002, '5329833466');
INSERT INTO Guest_Phone VALUES
(100003, '5558765432');
INSERT INTO Guest_Phone VALUES
(100003, '5558111322');
INSERT INTO Guest_Phone VALUES
(100003, '5558767128');
INSERT INTO Guest_Phone VALUES
(100004, '5334567890');
INSERT INTO Guest_Phone VALUES
(100005, '5362345678');
INSERT INTO Guest_Phone VALUES
(100006, '5398765432');
INSERT INTO Guest_Phone VALUES
(100007, '5557891123');
INSERT INTO Guest_Phone VALUES
(100007, '5457894123');
INSERT INTO Guest_Phone VALUES
(100007, '5357890141');
INSERT INTO Guest_Phone VALUES
(100008, '5341234567');
INSERT INTO Guest_Phone VALUES
(100009, '5329876543');
INSERT INTO Guest_Phone VALUES
(100010, '5352345678');
INSERT INTO Guest_Phone VALUES
(100010, '5312342258');
INSERT INTO Guest_Phone VALUES
(100011, '5388765432');
INSERT INTO Guest_Phone VALUES
(100012, '5321234567');
INSERT INTO Guest_Phone VALUES
(100012, '5361234567');
INSERT INTO Guest_Phone VALUES
(100013, '5559876543');
INSERT INTO Guest_Phone VALUES
(100014, '5368765432');
INSERT INTO Guest_Phone VALUES
(100015, '5331234567');
INSERT INTO Guest_Phone VALUES
(100016, '5399876543');
INSERT INTO Guest_Phone VALUES
(100017, '5348765432');
INSERT INTO Guest_Phone VALUES
(100018, '5381234567');
INSERT INTO Guest_Phone VALUES
(100019, '5339876543');
INSERT INTO Guest_Phone VALUES
(100020, '5361234567');
INSERT INTO Guest_Phone VALUES
(100020, '5321232567');


--guest_id, email
INSERT INTO Guest_Email VALUES
(100001, 'hasan.coban@example.com');
INSERT INTO Guest_Email VALUES
(100001, 'hasancoban13579@example.com');
INSERT INTO Guest_Email VALUES
(100002, 'bora.ersoy@example.com');
INSERT INTO Guest_Email VALUES
(100002, 'boraersoy35@example.com');
INSERT INTO Guest_Email VALUES
(100003, 'ramazan.cuhaci@example.com');
INSERT INTO Guest_Email VALUES
(100003, 'cuhaciramazan@example.com');
INSERT INTO Guest_Email VALUES
(100004, 'onur.sahinler@example.com');
INSERT INTO Guest_Email VALUES
(100004, 'onurshnlr@example.com');
INSERT INTO Guest_Email VALUES
(100005, 'emir.kaldirimci@example.com');
INSERT INTO Guest_Email VALUES
(100005, 'emir_kaldirimci@example.com');
INSERT INTO Guest_Email VALUES
(100006, 'john.smith@example.com');
INSERT INTO Guest_Email VALUES
(100007, 'emily.johnson@example.com');
INSERT INTO Guest_Email VALUES
(100007, 'johnson_emily@example.com');
INSERT INTO Guest_Email VALUES
(100008, 'michael.davis@example.com');
INSERT INTO Guest_Email VALUES
(100008, 'michael.davis.4@example.com');
INSERT INTO Guest_Email VALUES
(100009, 'sarah.brown@example.com');
INSERT INTO Guest_Email VALUES
(100010, 'jones.breckie@std.iyte.edu.tr');
INSERT INTO Guest_Email VALUES
(100011, 'jessica.miller@example.com');
INSERT INTO Guest_Email VALUES
(100012, 'brian.moore@example.com');
INSERT INTO Guest_Email VALUES
(100013, 'megan.taylor@example.com');
INSERT INTO Guest_Email VALUES
(100014, 'christopher.white@example.com');
INSERT INTO Guest_Email VALUES
(100015, 'ashley.garcia@example.com');
INSERT INTO Guest_Email VALUES
(100016, 'kevin.anderson@example.com');
INSERT INTO Guest_Email VALUES
(100017, 'olivia.thomas@example.com');
INSERT INTO Guest_Email VALUES
(100018, 'daniel.lee@example.com');
INSERT INTO Guest_Email VALUES
(100019, 'sophia.hernandez@example.com');
INSERT INTO Guest_Email VALUES
(100020, 'andrew.hall@example.com');
INSERT INTO Guest_Email VALUES
(100020, 'andrew_halll@example.com');




--staff_id, staff_first_name, staff_last_name, staff_position
INSERT INTO Staff VALUES 
(20001, 'Xavier', 'Brooks', 'Receptionist');
INSERT INTO Staff VALUES 
(20002, 'Jane', 'Smith', 'Receptionist');
INSERT INTO Staff VALUES 
(20003, 'Robert', 'Johnson', 'Receptionist');
INSERT INTO Staff VALUES 
(20004, 'Emily', 'Williams', 'Chef');
INSERT INTO Staff VALUES 
(20005, 'Michael', 'Jones', 'Housekeeping');
INSERT INTO Staff VALUES 
(20006, 'Sophia', 'Brown', 'Bartender');
INSERT INTO Staff VALUES 
(20007, 'William', 'Taylor', 'Maintenance');
INSERT INTO Staff VALUES 
(20008, 'Olivia', 'Miller', 'Waiter');
INSERT INTO Staff VALUES 
(20009, 'James', 'Davis', 'Bartender');
INSERT INTO Staff VALUES 
(20010, 'Emma', 'Garcia', 'Kitchen Chef');
INSERT INTO Staff VALUES 
(20011, 'Daniel', 'Rodriguez', 'Waiter');
INSERT INTO Staff VALUES 
(20012, 'Ava', 'Martinez', 'Waitress');
INSERT INTO Staff VALUES 
(20013, 'Logan', 'Hernandez', 'Bellboy');
INSERT INTO Staff VALUES 
(20014, 'Grace', 'Moore', 'Housekeeping');
INSERT INTO Staff VALUES 
(20015, 'Carter', 'Jackson', 'Housekeeping');
INSERT INTO Staff VALUES 
(20016, 'Chloe', 'White', 'Front Desk Clerk');
INSERT INTO Staff VALUES 
(20017, 'Ethan', 'Harris', 'Concierge');
INSERT INTO Staff VALUES 
(20018, 'Lily', 'Clark', 'Waitress');
INSERT INTO Staff VALUES 
(20019, 'Mason', 'Lewis', 'Security');
INSERT INTO Staff VALUES 
(20020, 'Aria', 'Allen', 'Chef');




--staff_id, staff_phone
INSERT INTO Staff_Phone VALUES 
(20002, 5123456789);
INSERT INTO Staff_Phone VALUES 
(20002, 5123222223);
INSERT INTO Staff_Phone VALUES 
(20003, 5234567890);
INSERT INTO Staff_Phone VALUES 
(20003, 5634367892);
INSERT INTO Staff_Phone VALUES 
(20004, 5345678901);
INSERT INTO Staff_Phone VALUES 
(20005, 5456789012);
INSERT INTO Staff_Phone VALUES 
(20006, 5567890123);
INSERT INTO Staff_Phone VALUES 
(20007, 5678901234);
INSERT INTO Staff_Phone VALUES 
(20008, 5789012345);
INSERT INTO Staff_Phone VALUES 
(20008, 5489012341);
INSERT INTO Staff_Phone VALUES 
(20008, 5389012344);
INSERT INTO Staff_Phone VALUES 
(20009, 5890123456);
INSERT INTO Staff_Phone VALUES 
(20010, 5901234567);
INSERT INTO Staff_Phone VALUES 
(20011, 5123456789);
INSERT INTO Staff_Phone VALUES 
(20012, 5234567890);
INSERT INTO Staff_Phone VALUES 
(20013, 5345678901);
INSERT INTO Staff_Phone VALUES 
(20014, 5456789012);
INSERT INTO Staff_Phone VALUES 
(20015, 5567890123);
INSERT INTO Staff_Phone VALUES 
(20016, 5678901234);
INSERT INTO Staff_Phone VALUES 
(20016, 5378901234);
INSERT INTO Staff_Phone VALUES 
(20016, 5478901234);
INSERT INTO Staff_Phone VALUES 
(20017, 5789012345);
INSERT INTO Staff_Phone VALUES 
(20018, 5890123456);
INSERT INTO Staff_Phone VALUES 
(20019, 5901234567);
INSERT INTO Staff_Phone VALUES 
(20019, 5301234261);
INSERT INTO Staff_Phone VALUES 
(20020, 5123456789);
INSERT INTO Staff_Phone VALUES 
(20020, 5423456789);


--room_number, room_availability, room_is_clear, staff_id
INSERT INTO Room VALUES
(101, 'Y', 'T', 20005);
INSERT INTO Room VALUES
(102, 'N', 'T', 20015);
INSERT INTO Room VALUES
(103, 'N', 'T', 20005);
INSERT INTO Room VALUES
(201, 'Y', 'F', 20014);
INSERT INTO Room VALUES
(202, 'N', 'F', 20014);
INSERT INTO Room VALUES
(203, 'Y', 'T', 20014);
INSERT INTO Room VALUES
(301, 'N', 'F', 20015);
INSERT INTO Room VALUES
(302, 'Y', 'F', 20015);
INSERT INTO Room VALUES
(303, 'Y', 'F', 20015);
INSERT INTO Room VALUES
(401, 'Y', 'T', 20005);
INSERT INTO Room VALUES
(402, 'N', 'T', 20014);
INSERT INTO Room VALUES
(403, 'N', 'F', 20015);
INSERT INTO Room VALUES
(501, 'N', 'F', 20014);
INSERT INTO Room VALUES
(502, 'Y', 'F', 20005);
INSERT INTO Room VALUES
(503, 'Y', 'F', 20005);
INSERT INTO Room VALUES
(601, 'Y', 'T', 20015);
INSERT INTO Room VALUES
(602, 'N', 'T', 20014);
INSERT INTO Room VALUES
(701, 'Y', 'F', 20015);
INSERT INTO Room VALUES
(702, 'N', 'F', 20015);
INSERT INTO Room VALUES
(703, 'Y', 'T', 20005);


--supply_id, supply_type, quantity, room_number
INSERT INTO Supply VALUES (300001, 'Pen', 3, 101);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 102);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 103);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 201);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 202);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 203);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 301);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 302);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 303);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 401);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 402);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 403);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 501);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 502);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 503);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 601);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 602);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 701);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 702);
INSERT INTO Supply VALUES (300001, 'Pen', 3, 703);


INSERT INTO Supply VALUES (300002, 'Notepad', 2, 101);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 102);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 103);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 201);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 202);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 203);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 301);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 302);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 303);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 401);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 402);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 403);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 501);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 502);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 503);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 601);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 602);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 701);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 702);
INSERT INTO Supply VALUES (300002, 'Notepad', 2, 703);


INSERT INTO Supply VALUES (300003, 'Key Card', 2, 101);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 102);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 103);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 201);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 202);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 203);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 301);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 302);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 303);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 401);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 402);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 403);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 501);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 502);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 503);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 601);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 602);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 701);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 702);
INSERT INTO Supply VALUES (300003, 'Key Card', 2, 703);


INSERT INTO Supply VALUES (300004, 'Towel', 5, 101);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 102);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 103);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 201);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 202);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 203);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 301);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 302);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 303);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 401);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 402);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 403);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 501);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 502);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 503);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 601);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 602);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 701);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 702);
INSERT INTO Supply VALUES (300004, 'Towel', 5, 703);


INSERT INTO Supply VALUES (300005, 'Sheet', 5, 101);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 102);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 103);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 201);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 202);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 203);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 301);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 302);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 303);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 401);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 402);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 403);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 501);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 502);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 503);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 601);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 602);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 701);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 702);
INSERT INTO Supply VALUES (300005, 'Sheet', 5, 703);


INSERT INTO Supply VALUES (300006, 'Duvet', 3, 101);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 102);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 103);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 201);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 202);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 203);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 301);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 302);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 303);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 401);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 402);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 403);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 501);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 502);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 503);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 601);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 602);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 701);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 702);
INSERT INTO Supply VALUES (300006, 'Duvet', 3, 703);


INSERT INTO Supply VALUES (300007, 'Pillow', 4, 101);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 102);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 103);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 201);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 202);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 203);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 301);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 302);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 303);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 401);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 402);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 403);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 501);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 502);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 503);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 601);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 602);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 701);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 702);
INSERT INTO Supply VALUES (300007, 'Pillow', 4, 703);


INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 101);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 102);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 103);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 201);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 202);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 203);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 301);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 302);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 303);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 401);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 402);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 403);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 501);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 502);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 503);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 601);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 602);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 701);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 702);
INSERT INTO Supply VALUES (300008, 'Pillowcase', 4, 703);


INSERT INTO Supply VALUES (300009, 'Glass', 4, 101);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 102);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 103);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 201);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 202);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 203);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 301);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 302);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 303);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 401);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 402);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 403);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 501);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 502);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 503);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 601);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 602);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 701);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 702);
INSERT INTO Supply VALUES (300009, 'Glass', 4, 703);


INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 101);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 102);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 103);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 201);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 202);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 203);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 301);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 302);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 303);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 401);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 402);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 403);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 501);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 502);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 503);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 601);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 602);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 701);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 702);
INSERT INTO Supply VALUES (300010, 'Hairdryer', 2, 703);



INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 101);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 102);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 103);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 201);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 202);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 203);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 301);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 302);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 303);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 401);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 402);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 403);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 501);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 502);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 503);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 601);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 602);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 701);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 702);
INSERT INTO Supply VALUES (300011, 'Corkscrew', 1, 703);



INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 101);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 102);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 103);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 201);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 202);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 203);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 301);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 302);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 303);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 401);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 402);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 403);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 501);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 502);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 503);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 601);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 602);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 701);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 702);
INSERT INTO Supply VALUES (300012, 'Bathrobe', 5, 703);



INSERT INTO Supply VALUES (300013, 'Slipper', 4, 101);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 102);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 103);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 201);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 202);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 203);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 301);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 302);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 303);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 401);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 402);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 403);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 501);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 502);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 503);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 601);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 602);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 701);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 702);
INSERT INTO Supply VALUES (300013, 'Slipper', 4, 703);


INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 101);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 102);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 103);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 201);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 202);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 203);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 301);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 302);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 303);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 401);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 402);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 403);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 501);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 502);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 503);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 601);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 602);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 701);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 702);
INSERT INTO Supply VALUES (300014, 'Toilet Paper', 3, 703);


INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 101);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 102);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 103);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 201);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 202);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 203);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 301);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 302);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 303);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 401);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 402);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 403);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 501);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 502);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 503);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 601);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 602);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 701);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 702);
INSERT INTO Supply VALUES (300015, 'Shampoo', 4, 703);


INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 101);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 102);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 103);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 201);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 202);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 203);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 301);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 302);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 303);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 401);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 402);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 403);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 501);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 502);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 503);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 601);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 602);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 701);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 702);
INSERT INTO Supply VALUES (300016, 'Toothbrush', 2, 703);


INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 101);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 102);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 103);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 201);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 202);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 203);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 301);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 302);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 303);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 401);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 402);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 403);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 501);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 502);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 503);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 601);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 602);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 701);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 702);
INSERT INTO Supply VALUES (300017, 'Toothpaste', 3, 703);


INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 101);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 102);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 103);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 201);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 202);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 203);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 301);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 302);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 303);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 401);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 402);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 403);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 501);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 502);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 503);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 601);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 602);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 701);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 702);
INSERT INTO Supply VALUES (300018, 'Laundry Bag', 2, 703);


INSERT INTO Supply VALUES (300019, 'Hanger', 20, 101);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 102);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 103);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 201);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 202);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 203);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 301);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 302);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 303);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 401);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 402);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 403);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 501);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 502);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 503);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 601);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 602);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 701);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 702);
INSERT INTO Supply VALUES (300019, 'Hanger', 20, 703);


INSERT INTO Supply VALUES (300020, 'Soap', 3, 101);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 102);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 103);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 201);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 202);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 203);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 301);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 302);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 303);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 401);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 402);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 403);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 501);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 502);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 503);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 601);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 602);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 701);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 702);
INSERT INTO Supply VALUES (300020, 'Soap', 3, 703);


--payment_id, payment_date, billing_amount, payment_type, guest_id
INSERT INTO Payment VALUES
(209, TO_DATE('10-APR-2024', 'DD-MON-YYYY'), null, 'Reservation', 100001);
INSERT INTO Payment VALUES
(202, TO_DATE('22-JAN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100013);
INSERT INTO Payment VALUES
(203, TO_DATE('05-FEB-2024', 'DD-MON-YYYY'), null, 'Reservation', 100004);
INSERT INTO Payment VALUES
(204, TO_DATE('18-FEB-2024', 'DD-MON-YYYY'), null, 'Reservation', 100005);
INSERT INTO Payment VALUES
(205, TO_DATE('28-FEB-2024', 'DD-MON-YYYY'), null, 'Reservation', 100006);
INSERT INTO Payment VALUES
(206, TO_DATE('08-MAR-2024','DD-MON-YYYY'), null, 'Reservation', 100007);                                                                                                                                                                                                                            
INSERT INTO Payment VALUES
(207, TO_DATE('20-MAR-2024', 'DD-MON-YYYY'), null, 'Reservation', 100018);
INSERT INTO Payment VALUES
(208, TO_DATE('25-MAR-2024', 'DD-MON-YYYY'), null, 'Reservation', 100009);
INSERT INTO Payment VALUES
(201, TO_DATE('10-JAN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100012);
INSERT INTO Payment VALUES
(210, TO_DATE('20-APR-2024', 'DD-MON-YYYY'), null, 'Reservation', 100015);
INSERT INTO Payment VALUES
(211, TO_DATE('18-JUN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100008);
INSERT INTO Payment VALUES
(212, TO_DATE('27-JUN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100010);
INSERT INTO Payment VALUES
(213, TO_DATE('29-JUN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100011);
INSERT INTO Payment VALUES
(214, TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), null, 'Reservation', 100002);
INSERT INTO Payment VALUES
(215, TO_DATE('20-JUL-2024', 'DD-MON-YYYY'), null, 'Reservation', 100019);
INSERT INTO Payment VALUES
(216, TO_DATE('05-MAY-2024', 'DD-MON-YYYY'), null, 'Reservation', 100017);
INSERT INTO Payment VALUES
(217, TO_DATE('15-MAY-2024', 'DD-MON-YYYY'), null, 'Reservation', 100016);
INSERT INTO Payment VALUES
(218, TO_DATE('25-MAY-2024', 'DD-MON-YYYY'), null, 'Reservation', 100014);
INSERT INTO Payment VALUES
(219, TO_DATE('05-JUN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100020);
INSERT INTO Payment VALUES
(220, TO_DATE('15-JUN-2024', 'DD-MON-YYYY'), null, 'Reservation', 100003);
INSERT INTO Payment VALUES
(221, TO_DATE('10-APR-2024', 'DD-MON-YYYY'), null, 'Order', 100001);
INSERT INTO Payment VALUES
(222, TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), null, 'Order', 100002);
INSERT INTO Payment VALUES
(223, TO_DATE('15-JUN-2024', 'DD-MON-YYYY'), null, 'Order', 100003);
INSERT INTO Payment VALUES
(224, TO_DATE('05-FEB-2024', 'DD-MON-YYYY'), null, 'Order', 100004);
INSERT INTO Payment VALUES
(225, TO_DATE('18-FEB-2024', 'DD-MON-YYYY'), null, 'Order', 100005);
INSERT INTO Payment VALUES
(226, TO_DATE('28-FEB-2024', 'DD-MON-YYYY'), null, 'Order', 100006);
INSERT INTO Payment VALUES
(227, TO_DATE('08-MAR-2024', 'DD-MON-YYYY'), null, 'Order', 100007);
INSERT INTO Payment VALUES
(228, TO_DATE('18-JUN-2024', 'DD-MON-YYYY'), null, 'Order', 100008);
INSERT INTO Payment VALUES
(229, TO_DATE('25-MAR-2024', 'DD-MON-YYYY'), null, 'Order', 100009);
INSERT INTO Payment VALUES
(230, TO_DATE('25-MAR-2024', 'DD-MON-YYYY'), null, 'Order', 100010);
INSERT INTO Payment VALUES
(231, TO_DATE('29-JUN-2024', 'DD-MON-YYYY'), null, 'Order', 100011);




--order_id, table_number, total_price, payment_id, guest_id, staff_id
INSERT INTO Orders VALUES
(101, 1, Null, 221, 100001, 20004);

INSERT INTO Orders VALUES
(102, 1, Null, 221, 100001, 20004);

INSERT INTO Orders VALUES
(103, 1, Null, 221, 100001, 20004);

INSERT INTO Orders VALUES
(104, 1, Null, 221, 100001, 20020);

INSERT INTO Orders VALUES
(105, 1, Null, 222, 100002, 20006);

INSERT INTO Orders VALUES
(106, 1, Null, 222, 100002, 20006);

INSERT INTO Orders VALUES
(107, 1, Null, 222, 100002, 20020);

INSERT INTO Orders VALUES
(108, 1, Null, 223, 100003, 20020);

INSERT INTO Orders VALUES
(109, 1, Null, 223, 100003, 20020);

INSERT INTO Orders VALUES
(110, 1, Null, 223, 100003, 20020);

INSERT INTO Orders VALUES
(111, 2, Null, 224, 100004, 20004);

INSERT INTO Orders VALUES
(112, 2, Null, 225, 100005, 20004);

INSERT INTO Orders VALUES
(113, 2, Null, 226, 100006, 20020);

INSERT INTO Orders VALUES
(114, 2, Null, 227, 100007, 20020);

INSERT INTO Orders VALUES
(115, 2, Null, 228, 100008, 20020);

INSERT INTO Orders VALUES
(116, 2, Null, 228, 100008, 20020);

INSERT INTO Orders VALUES
(117, 2, Null, 228, 100008, 20004);

INSERT INTO Orders VALUES
(118, 3, Null, 229, 100009, 20004);

INSERT INTO Orders VALUES
(119, 3, Null, 230, 100010, 20004);

INSERT INTO Orders VALUES
(120, 3, Null, 231, 100011, 20020);




--item_id, item_name, item_price, item_amount, item_type, order_id
INSERT INTO Consumable VALUES
(1, 'Grilled Salmon', 18.99, 20, 'Main Course', 101);

INSERT INTO Consumable VALUES
(2, 'Chicken Parmesan', 15.99, 15, 'Main Course', 102);

INSERT INTO Consumable VALUES
(2, 'Chicken Parmesan', 15.99, 15, 'Main Course', 118);

INSERT INTO Consumable VALUES
(2, 'Chicken Parmesan', 15.99, 15, 'Main Course', 117);

INSERT INTO Consumable VALUES
(3, 'Vegetarian Pasta', 12.99, 25, 'Main Course', 103);

INSERT INTO Consumable VALUES
(3, 'Vegetarian Pasta', 12.99, 25, 'Main Course', 116);

INSERT INTO Consumable VALUES
(4, 'Caesar Salad', 8.99, 18, 'Appetizer', 104);

INSERT INTO Consumable VALUES
(4, 'Caesar Salad', 8.99, 18, 'Appetizer', 115);

INSERT INTO Consumable VALUES
(5, 'Red Wine Bottle', 20.49, 12, 'Beverage', 105);

INSERT INTO Consumable VALUES
(6, 'White Wine Bottle', 18.99, 10, 'Beverage', 106);

INSERT INTO Consumable VALUES
(6, 'White Wine Bottle', 18.99, 10, 'Beverage', 114);

INSERT INTO Consumable VALUES
(7, 'Garlic Bread', 3.99, 30, 'Bread', 107);

INSERT INTO Consumable VALUES
(8, 'Chocolate Cake', 7.99, 8, 'Dessert', 108);

INSERT INTO Consumable VALUES
(8, 'Chocolate Cake', 7.99, 8, 'Dessert', 119);

INSERT INTO Consumable VALUES
(8, 'Chocolate Cake', 7.99, 8, 'Dessert', 120);

INSERT INTO Consumable VALUES
(9, 'Coffee', 2.49, 50, 'Hot Beverage', 109);

INSERT INTO Consumable VALUES
(10, 'Cheese Platter', 14.99, 15, 'Appetizer', 110);

INSERT INTO Consumable VALUES
(11, 'New York Strip Steak', 24.99, 12, 'Main Course', 101);

INSERT INTO Consumable VALUES
(12, 'Shrimp Scampi', 22.99, 20, 'Main Course', 101);

INSERT INTO Consumable VALUES
(13, 'Mashed Potatoes', 4.99, 25, 'Side Dish', 102);

INSERT INTO Consumable VALUES
(9, 'Coffee', 2.49, 50, 'Hot Beverage', 104);

INSERT INTO Consumable VALUES
(9, 'Coffee', 2.49, 50, 'Hot Beverage', 111);

INSERT INTO Consumable VALUES
(1, 'Grilled Salmon', 18.99, 20, 'Main Course', 104);

INSERT INTO Consumable VALUES
(9, 'Coffee', 2.49, 50, 'Hot Beverage', 113);

INSERT INTO Consumable VALUES
(16, 'Caprese Salad', 9.99, 15, 'Appetizer', 106);

INSERT INTO Consumable VALUES
(17, 'Lobster Bisque', 12.49, 12, 'Soup', 102);

INSERT INTO Consumable VALUES
(18, 'Tiramisu', 8.49, 10, 'Dessert', 108);

INSERT INTO Consumable VALUES
(18, 'Tiramisu', 8.49, 10, 'Dessert', 112);

INSERT INTO Consumable VALUES
(1, 'Grilled Salmon', 18.99, 20, 'Main Course', 109);

INSERT INTO Consumable VALUES
(7, 'Garlic Bread', 3.99, 30, 'Bread', 105);



--reservation_id, check_in_date, check_out_date, reservation_cancellation, booking_status, number_of_people, staff_id, guest_id, payment_id, room_number
INSERT INTO Reservation VALUES  
(80001, TO_DATE('05-JAN-2024', 'DD-MON-YYYY'), TO_DATE('10-JAN-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20002,100012, 201, 101);
INSERT INTO Reservation VALUES  
(80002, TO_DATE('18-JAN-2024', 'DD-MON-YYYY'), TO_DATE('22-JAN-2024', 'DD-MON-YYYY'), 'N', 'P', 1,20003, 100013, 202, 201);
INSERT INTO Reservation VALUES  
(80003, TO_DATE('02-FEB-2024', 'DD-MON-YYYY'), TO_DATE('05-FEB-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20001, 100004, 203, 202);
INSERT INTO Reservation VALUES  
(80004, TO_DATE('12-FEB-2024', 'DD-MON-YYYY'), TO_DATE('18-FEB-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002, 100005, 204, 203);
INSERT INTO Reservation VALUES  
(80005, TO_DATE('25-FEB-2024', 'DD-MON-YYYY'), TO_DATE('28-FEB-2024', 'DD-MON-YYYY'), 'N', 'B', 1,20002, 100006, 205, 401);
INSERT INTO Reservation VALUES  
(80006, TO_DATE('03-MAR-2024', 'DD-MON-YYYY'), TO_DATE('08-MAR-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20001, 100007,206, 402);
INSERT INTO Reservation VALUES  
(80007, TO_DATE('15-MAR-2024', 'DD-MON-YYYY'), TO_DATE('20-MAR-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20016, 100018,207, 403);
INSERT INTO Reservation VALUES  
(80008, TO_DATE('22-MAR-2024', 'DD-MON-YYYY'), TO_DATE('25-MAR-2024', 'DD-MON-YYYY'), 'N', 'P', 1,20002, 100009,208, 301);
INSERT INTO Reservation VALUES  
(80009, TO_DATE('05-APR-2024', 'DD-MON-YYYY'), TO_DATE('10-APR-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20002, 100001,209, 302);
INSERT INTO Reservation VALUES  
(80010, TO_DATE('15-APR-2024', 'DD-MON-YYYY'), TO_DATE('20-APR-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100015, 210, 501);
INSERT INTO Reservation VALUES  
(80011, TO_DATE('17-JUN-2024', 'DD-MON-YYYY'), TO_DATE('18-JUN-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100008, 211, 501);
INSERT INTO Reservation VALUES  
(80012, TO_DATE('20-JUN-2024', 'DD-MON-YYYY'), TO_DATE('27-JUN-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100010, 212, 501);
INSERT INTO Reservation VALUES  
(80013, TO_DATE('28-JUN-2024', 'DD-MON-YYYY'), TO_DATE('29-JUN-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100011,  213, 501);
INSERT INTO Reservation VALUES  
(80014, TO_DATE('01-JUL-2024', 'DD-MON-YYYY'), TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100002, 214, 501);
INSERT INTO Reservation VALUES  
(80015, TO_DATE('15-JUL-2024', 'DD-MON-YYYY'), TO_DATE('20-JUL-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20002,100019, 215, 501);
INSERT INTO Reservation VALUES  
(80016, TO_DATE('01-MAY-2024', 'DD-MON-YYYY'), TO_DATE('05-MAY-2024', 'DD-MON-YYYY'), 'N', 'B', 1,20001, 100017,216, 502);
INSERT INTO Reservation VALUES  
(80017, TO_DATE('10-MAY-2024', 'DD-MON-YYYY'), TO_DATE('15-MAY-2024', 'DD-MON-YYYY'), 'N', 'P', 2,20003,100016,217, 602);
INSERT INTO Reservation VALUES  
(80018, TO_DATE('20-MAY-2024', 'DD-MON-YYYY'), TO_DATE('25-MAY-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20003,100014,218, 701);
INSERT INTO Reservation VALUES  
(80019, TO_DATE('01-JUN-2024', 'DD-MON-YYYY'), TO_DATE('05-JUN-2024', 'DD-MON-YYYY'), 'N', 'P', 1, 20002,100020,219, 503);
INSERT INTO Reservation VALUES  
(80020, TO_DATE('10-JUN-2024', 'DD-MON-YYYY'), TO_DATE('15-JUN-2024', 'DD-MON-YYYY'), 'N', 'B', 2,20001,100003,220, 102);


UPDATE Orders o
SET Total_Price = (
    SELECT NVL(SUM(ci.item_price * ci.Item_Amount), 0)
    FROM consumable ci
    WHERE ci.Order_ID = o.Order_ID
)
WHERE total_price = 0 or total_price is null;

UPDATE Payment p
SET Billing_Amount = (
    SELECT COALESCE(SUM(
               CASE
                   WHEN o.Total_Price IS NOT NULL AND p.Payment_Type = 'Order' THEN o.Total_Price
                   ELSE 0
               END
           ), 0) AS Total_Amount
    FROM orders o
    JOIN Reservation r ON o.Guest_ID = r.Guest_ID
    WHERE o.Guest_ID = p.Guest_ID
)
WHERE billing_amount is null;

UPDATE Payment p
SET Billing_Amount = (
    SELECT COALESCE(SUM(
               CASE
                   WHEN r.Check_Out_Date IS NOT NULL AND r.Check_In_Date IS NOT NULL AND p.Payment_Type = 'Reservation' THEN (r.Check_Out_Date - r.Check_In_Date) * 400
                   ELSE 0
               END
           ), 0) AS Total_Amount
    FROM guest g
    JOIN Reservation r ON p.Guest_ID = r.Guest_ID
    WHERE p.Guest_ID = g.Guest_ID
)
WHERE billing_amount is null or billing_amount = 0;

