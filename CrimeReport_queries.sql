-- Queries:

-- 1.Insert a new Category having the following info: code is PUBLIC,name is Social Security Threat 

INSERT INTO CRIME_CATEGORY (CATEGORYCODE, CATEGORYNAME)
VALUES (5, 'Social Sec Threat');

SELECT * FROM CRIME_CATEGORY

-- 2.Update the name of the policeman whose ssn is 112233. 

UPDATE POLICEMAN
SET FIRSTNAME  = 'Mariam',
    MIDDLENAME = 'mhmd',
    LASTNAME   = 'Atwi'
WHERE POLICEMANSSN = 50005;

-- 3.List the names of residents in Beirut City.

SELECT R.FIRSTNAME, R.MIDDLENAME, R.LASTNAME
FROM RESIDENT R, ADDRESSES A
WHERE R.RESIDENTSSN = A.RESIDENTSSN
  AND A.CITY = 'Beirut';

-- 4.List the name of policemen who joined after 1/1/2021 ordered alphabetically. 

SELECT FIRSTNAME, MIDDLENAME, LASTNAME
FROM POLICEMAN
WHERE JOININGDATE > '2021-01-15'
ORDER BY FIRSTNAME, MIDDLENAME, LASTNAME;

-- 5 List the ID and status of the crimes reported to the policeman
SELECT CR.REPORTID, CR.STATUS
FROM CRIME_REPORT CR, POLICEMAN P
WHERE P.POLICEMANSSN = CR.POLICEMANSSN
  AND P.FIRSTNAME = 'Tony'
  AND P.MIDDLENAME = 'Maroun'
  AND P.LASTNAME = 'Issa';


-- 6 List the number of pending crimes
SELECT COUNT(*) AS NbOfPendingCrimes
FROM CRIME_REPORT
WHERE STATUS <> 'Closed';

-- 7 The ID of crimes that were reported to "Tony Issa" or had an action done by "Tony Issa"
SELECT DISTINCT CR.REPORTID
FROM CRIME_REPORT CR, POLICEMAN P
WHERE CR.POLICEMANSSN = P.POLICEMANSSN
  AND P.FIRSTNAME = 'Tony'
  AND P.LASTNAME = 'Issa'

UNION

SELECT DISTINCT RA.REPORTID
FROM RESPONSE_ACTION RA, POLICEMAN P
WHERE RA.POLICEMANSSN = P.POLICEMANSSN
  AND P.FIRSTNAME = 'Tony'
  AND P.LASTNAME = 'Issa';


-- 8 The total number of crimes in each city
SELECT A.CITY, COUNT(CR.REPORTID) AS TOTALCRIMES
FROM CRIME_REPORT CR, ADDRESSES A
WHERE A.ID = CR.ID
GROUP BY A.CITY;


-- 9 The name of residents who have reported at least one crime. 
SELECT r.FIRSTNAME, r.LASTNAME, COUNT(c.REPORTID) AS TotalReports
FROM RESIDENT r, CRIME_REPORT c
WHERE r.RESIDENTSSN = c.RESIDENTSSN
GROUP BY r.RESIDENTSSN, r.FIRSTNAME, r.LASTNAME
HAVING COUNT(c.REPORTID) >= 1;


-- 10 The number of responses for each crime witnessed today
SELECT c.REPORTID, COUNT(r.ACTIONID) AS NumberOfResponses
FROM CRIME_REPORT c, RESPONSE_ACTION r
WHERE c.REPORTID = r.REPORTID
GROUP BY c.REPORTID;

-- 11 The number of crimes in each category 
SELECT cc.CATEGORYNAME, COUNT(c.REPORTID) AS NumberOfCrimes
FROM CRIME_CATEGORY cc, CRIME_REPORT c
WHERE cc.CATEGORYCODE = c.CATEGORYCODE
GROUP BY cc.CATEGORYNAME;

-- 12 The ID of crimes 
SELECT REPORTID
FROM CRIME_REPORT;
