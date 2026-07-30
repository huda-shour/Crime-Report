/* Stored Procedure: 
Suppose you want a procedure to get all reports by a particular resident. */

CREATE PROCEDURE GetReportsByResident
    @ResidentSSN INT
AS
BEGIN
    SELECT 
        CR.REPORTID,
        CR.DESCRIPTION,
        CR.STATUS,
        CR.DATETIMEOFWITNESS,
        PC.FIRSTNAME + ' ' + PC.LASTNAME AS PolicemanName,
        CC.CATEGORYNAME
    FROM CRIME_REPORT CR, POLICEMAN PC, CRIME_CATEGORY CC
    WHERE CR.POLICEMANSSN = PC.POLICEMANSSN
      AND CR.CATEGORYCODE = CC.CATEGORYCODE
      AND CR.RESIDENTSSN = @ResidentSSN
    ORDER BY CR.DATETIMEOFWITNESS DESC;
END;
GO
EXEC GetReportsByResident @ResidentSSN = 100002;
GO


/* Stored procedure: lists all residents along with the number of crimes they reported */
CREATE PROCEDURE GetResidentCrimeCounts
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        R.RESIDENTSSN,
        R.FIRSTNAME + ' ' + R.MIDDLENAME + ' ' + R.LASTNAME AS ResidentName,
        (
            SELECT COUNT(*)
            FROM CRIME_REPORT CR
            WHERE CR.RESIDENTSSN = R.RESIDENTSSN
        ) AS NumberOfCrimesReported
    FROM RESIDENT R
    ORDER BY NumberOfCrimesReported DESC, ResidentName;
END;
GO
EXEC GetResidentCrimeCounts;
GO


/* Stored Procedure: Number of actions per policeman */
  
CREATE PROCEDURE GetPolicemanActionCounts
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.POLICEMANSSN,
        P.FIRSTNAME + ' ' + P.MIDDLENAME + ' ' + P.LASTNAME AS PolicemanName,
        (
            SELECT COUNT(*)
            FROM RESPONSE_ACTION R
            WHERE R.POLICEMANSSN = P.POLICEMANSSN
        ) AS NumberOfActions
    FROM POLICEMAN P
    ORDER BY NumberOfActions DESC, PolicemanName;
END;
GO
EXEC GetPolicemanActionCounts;
GO