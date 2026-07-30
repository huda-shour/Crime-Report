/* Cursor:
Suppose you want to go through all open crime reports and print their REPORTID and DESCRIPTION. */

DECLARE OpenReportsCursor CURSOR FOR
SELECT REPORTID, DESCRIPTION
FROM CRIME_REPORT
WHERE STATUS = 'Open';

DECLARE @OpenReportID INT;
DECLARE @Description VARCHAR(220);

OPEN OpenReportsCursor;

FETCH NEXT FROM OpenReportsCursor INTO @OpenReportID, @Description;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Open ReportID: ' + CAST(@OpenReportID AS VARCHAR) + ' - Description: ' + @Description;
    FETCH NEXT FROM OpenReportsCursor INTO @OpenReportID, @Description;
END

CLOSE OpenReportsCursor;
DEALLOCATE OpenReportsCursor;


/* Cursor: set all reports with STATUS = 'Under Investigation' older than
a certain date to 'Closed' */

DECLARE CloseOldCrimesCursor CURSOR FOR
SELECT REPORTID
FROM CRIME_REPORT
WHERE STATUS = 'Under Investigation' AND DATETIMEOFWITNESS < '2025-01-01';

DECLARE @CloseReportId INT;

OPEN CloseOldCrimesCursor;

FETCH NEXT FROM CloseOldCrimesCursor INTO @CloseReportId;

IF @@FETCH_STATUS = -1
BEGIN
    PRINT 'No reports to close.';
END

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE CRIME_REPORT
    SET STATUS = 'Closed'
    WHERE REPORTID = @CloseReportId;

    PRINT 'Closed ReportID: ' + CAST(@CloseReportID AS VARCHAR);

    FETCH NEXT FROM CloseOldCrimesCursor INTO @CloseReportId;
END

CLOSE CloseOldCrimesCursor;
DEALLOCATE CloseOldCrimesCursor;

-- Cursor: Update contact number of residents in Beirut
DECLARE ResidentCursor CURSOR FOR
SELECT R.RESIDENTSSN
FROM RESIDENT R, ADDRESSES A
WHERE R.RESIDENTSSN = A.RESIDENTSSN
  AND A.CITY = 'Beirut';

DECLARE @ResidentSSN INT;

OPEN ResidentCursor;

FETCH NEXT FROM ResidentCursor INTO @ResidentSSN;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE RESIDENT
    SET CONTACTNUMBER = 'Not Provided'
    WHERE RESIDENTSSN = @ResidentSSN;

    PRINT 'Updated ResidentSSN: ' + CAST(@ResidentSSN AS VARCHAR(20));

    FETCH NEXT FROM ResidentCursor INTO @ResidentSSN;
END;

CLOSE ResidentCursor;
DEALLOCATE ResidentCursor;