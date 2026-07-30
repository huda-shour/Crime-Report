-- DataInsertion

INSERT INTO RESIDENT (RESIDENTSSN, FIRSTNAME, MIDDLENAME, LASTNAME, CONTACTNUMBER, GENDER, DATEOFBIRTH)
VALUES
(100001, 'Ahmad', 'Nabil', 'Hassan', '03-552210', 'Male', '1988-05-12'),
(100002, 'Mariam', 'Samir', 'Atwi', '71-889123', 'Female', '1995-09-22'),
(100003, 'Jad', 'George', 'Khoury', '76-991245', 'Male', '1992-01-08'),
(100004, 'Rita', 'Elie', 'Hobeika', '70-332198', 'Female', '1985-11-30'),
(100005, 'Mustafa', 'Ali', 'Hamdan', '81-774200', 'Male', '1979-03-17'),
(100006, 'Tala', 'Rami', 'Khalil', '03-118200', 'Female', '1999-07-02'),
(100007, 'Omar', 'Hassan', 'Suleiman', '70-661299', 'Male', '1983-02-18'),
(100008, 'Lara', 'Joseph', 'Nassar', '71-552891', 'Female', '1990-11-11'),
(100009, 'Ziad', 'Fadi', 'Mansour', '76-119233', 'Male', '1987-04-04'),
(100010, 'Nour', 'Elias', 'Tarabay', '81-221390', 'Female', '2000-05-29'),
(100011, 'Hadi', 'Karim', 'Oueidat', '03-991122', 'Male', '1986-10-10'),
(100012, 'Sara', 'Michel', 'Dagher', '70-552761', 'Female', '1993-12-02'),
(100013, 'Ralph', 'Tony', 'Haddad', '71-662221', 'Male', '1991-06-06'),
(100014, 'Dalia', 'Bassel', 'Saleh', '76-995001', 'Female', '1997-03-25'),
(100015, 'Fadi', 'Youssef', 'Hijazi', '81-330789', 'Male', '1984-08-14');

INSERT INTO ADDRESSES (ID, RESIDENTSSN, CITY, STREET, APARTMENT)
VALUES
(1, 100001, 'Beirut', 'Hamra Main Street', '12'),
(2, 100002, 'Tyre', 'Sour Old Road', '3'),
(3, 100003, 'Jounieh', 'Kaslik Avenue', '22B'),
(4, 100004, 'Zahle', 'Main Boulevard', '47'),
(5, 100005, 'Tripoli', 'Abou Samra Street', '9A'),
(6, 100006, 'Beirut', 'Achrafieh Street 90', '5'),
(7, 100007, 'Saida', 'Riad El Solh Street', '18'),
(8, 100008, 'Byblos', 'Old Souks Road', '2'),
(9, 100009, 'Baabda', 'Fayyadieh Street', '11'),
(10, 100010, 'Jbeil', 'Sea Road', '8'),
(11, 100011, 'Batroun', 'Beachfront Road', '14'),
(12, 100012, 'Tyre', 'Ras El Ain Street', '6'),
(13, 100013, 'Beirut', 'Verdun Street', '10'),
(14, 100014, 'Zouk', 'Highway Exit 4', '3C'),
(15, 100015, 'Sidon', 'Qalaa Road', '22');

INSERT INTO CRIME_CATEGORY (CATEGORYCODE, CATEGORYNAME, DEGREEOFAFFECTION)
VALUES
(10, 'Theft', 'Moderate'),
(20, 'Assault', 'High'),
(30, 'Murder', 'Critical'),
(40, 'Drug Possession', 'High'),
(50, 'Vandalism', 'Low'),
(60, 'Robbery', 'High'),
(70, 'Fraud', 'Moderate'),
(80, 'Kidnapping', 'Critical'),
(90, 'Harassment', 'Low'),
(100, 'Cybercrime', 'Moderate');

INSERT INTO POLICEMAN (POLICEMANSSN, FIRSTNAME, MIDDLENAME, LASTNAME, CONTACTNUMBER, JOININGDATE, SALARY)
VALUES
(50001, 'Hassan', 'Rami', 'Darwish', '01-441188', '2010-04-10', 2100.00),
(50002, 'Tony', 'Maroun', 'Issa', '01-229900', '2015-09-01', 1850.00),
(50003, 'Walid', 'Toufic', 'Salman', '01-782233', '2009-12-15', 2500.00),
(50004, 'Ralph', 'Elias', 'Azar', '01-889900', '2020-05-28', 1600.00),
(50005, 'Fatima', 'Ali', 'Mansour', '01-662200', '2018-07-09', 1750.00),
(50006, 'Habib', 'Sami', 'Khoury', '01-111222', '2012-03-22', 1950.00),
(50007, 'Karim', 'Elias', 'Barakat', '01-889101', '2017-10-12', 1800.00),
(50008, 'Maya', 'Joseph', 'Nasr', '01-553390', '2021-01-15', 1500.00),
(50009, 'Nadim', 'Fadi', 'Tannous', '01-773344', '2014-06-18', 2000.00),
(50010, 'Said', 'Hani', 'Chami', '01-220019', '2008-11-27', 2600.00),
(50011, 'Lina', 'Rita', 'Makhlouf', '01-668812', '2019-09-09', 1650.00),
(50012, 'Ahmad', 'Walid', 'Hoteit', '01-771199', '2016-04-07', 1900.00),
(50013, 'Fouad', 'Issam', 'Aoun', '01-330200', '2013-08-30', 2050.00),
(50014, 'Rami', 'George', 'Saba', '01-229188', '2011-12-04', 2400.00),
(50015, 'Jana', 'Moussa', 'Kanaan', '01-110998', '2022-03-02', 1400.00);

INSERT INTO CRIME_REPORT
(REPORTID, RESIDENTSSN, POLICEMANSSN, CATEGORYCODE, ID, DATETIMEOFWITNESS, DESCRIPTION, IMAGECAPTURED, STATUS)
VALUES
(9001, 100001, 50001, 10, 1, '2024-06-11 22:30',
 'Theft of mobile phone in Hamra Main Street.', 'img_9001.jpg', 'Open'),

(9002, 100005, 50003, 20, 5, '2024-03-09 19:10',
 'Physical assault in Abou Samra Street.', 'img_9002.jpg', 'Closed'),

(9003, 100002, 50002, 30, 2, '2024-12-01 04:40',
 'Suspected homicide near Tyre corniche.', 'img_9003.jpg', 'Under Investigation'),

(9004, 100003, 50005, 40, 3, '2024-09-22 01:15',
 'Drug possession found in Kaslik Avenue.', 'img_9004.jpg', 'Open'),

(9005, 100004, 50004, 50, 4, '2024-10-15 08:50',
 'Vehicle vandalism in Zahle.', 'img_9005.jpg', 'Closed'),

(9006, 100006, 50006, 60, 6, '2024-04-12 14:30',
 'Armed robbery near Achrafieh.', 'img_9006.jpg', 'Open'),

(9007, 100007, 50007, 70, 7, '2024-07-21 18:50',
 'Fraud case involving money transfer.', 'img_9007.jpg', 'Under Investigation'),

(9008, 100008, 50008, 80, 8, '2024-08-03 02:20',
 'Kidnapping attempt reported in Byblos.', 'img_9008.jpg', 'Critical'),

(9009, 100009, 50009, 90, 9, '2024-02-28 09:10',
 'Harassment incident in Baabda.', 'img_9009.jpg', 'Open'),

(9010, 100010, 50010, 100, 10, '2024-01-15 13:40',
 'Cybercrime: hacked social account.', 'img_9010.jpg', 'Open'),

(9011, 100011, 50011, 10, 11, '2024-03-03 22:10',
 'Pickpocketing in Batroun.', 'img_9011.jpg', 'Closed'),

(9012, 100012, 50012, 20, 12, '2024-05-18 11:50',
 'Assault in Tyre neighborhood.', 'img_9012.jpg', 'Open'),

(9013, 100013, 50013, 50, 13, '2024-06-29 07:20',
 'Vandalism in Verdun Street.', 'img_9013.jpg', 'Closed'),

(9014, 100014, 50014, 40, 14, '2024-09-13 23:40',
 'Drug possession in Zouk Highway exit.', 'img_9014.jpg', 'Under Investigation'),

(9015, 100015, 50015, 90, 15, '2024-10-01 21:00',
 'Harassment complaint in Sidon.', 'img_9015.jpg', 'Open');

 INSERT INTO RESPONSE_ACTION
(ACTIONID, POLICEMANSSN, REPORTID, ACTIONNAME, TARGET, DATETIMEOFACTION, STATUS)
VALUES
(7001, 50001, 9001, 'Investigation', 'Suspects', '2024-06-12 10:00', 'In Progress'),
(7002, 50003, 9002, 'Arrest', 'Perpetrator', '2024-03-10 14:20', 'Completed'),
(7003, 50002, 9003, 'Scene Secured', 'Crime Scene', '2024-12-01 05:10', 'Completed'),
(7004, 50005, 9004, 'Confiscation', 'Drugs', '2024-09-22 01:40', 'In Progress'),
(7005, 50004, 9005, 'Inspection', 'Vehicle', '2024-10-15 09:30', 'Completed'),
(7006, 50006, 9006, 'Pursuit', 'Suspect', '2024-04-12 15:00', 'In Progress'),
(7007, 50007, 9007, 'Document Review', 'Records', '2024-07-21 20:00', 'Open'),
(7008, 50008, 9008, 'Area Sweep', 'Location', '2024-08-03 03:00', 'In Progress'),
(7009, 50009, 9009, 'Interview', 'Victim', '2024-02-28 10:00', 'Completed'),
(7010, 50010, 9010, 'Cyber Trace', 'IP Address', '2024-01-15 14:10', 'Open'),
(7011, 50011, 9011, 'Patrol Check', 'Area', '2024-03-03 23:00', 'Completed'),
(7012, 50012, 9012, 'Medical Aid', 'Victim', '2024-05-18 12:10', 'Completed'),
(7013, 50013, 9013, 'Evidence Collection', 'Objects', '2024-06-29 08:00', 'In Progress'),
(7014, 50014, 9014, 'Arrest Attempt', 'Suspect', '2024-09-13 23:55', 'Failed'),
(7015, 50015, 9015, 'Warning Issued', 'Accused', '2024-10-01 22:00', 'Completed');
