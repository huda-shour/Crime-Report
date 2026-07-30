
/* Function:
Suppose you want a scalar function that calculates the number of reports handled by a policeman.*/

-- Drop and create ReportsCountByPoliceman
IF OBJECT_ID('dbo.ReportsCountByPoliceman', 'FN') IS NOT NULL
    DROP FUNCTION dbo.ReportsCountByPoliceman;
GO

CREATE FUNCTION dbo.ReportsCountByPoliceman (@PolicemanSSN INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM CRIME_REPORT
    WHERE POLICEMANSSN = @PolicemanSSN;

    RETURN @Count;
END
GO


/* Function: */
IF OBJECT_ID('dbo.GetReportsByCategory', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetReportsByCategory;
GO

CREATE FUNCTION dbo.GetReportsByCategory(@CategoryCode INT)
RETURNS INT
AS
BEGIN
    DECLARE @ReportCount INT;
    SELECT @ReportCount = COUNT(*)
    FROM CRIME_REPORT
    WHERE CATEGORYCODE = @CategoryCode;

    RETURN @ReportCount;
END
GO


 /* Function: Get number of crimes reported by a resident */
 IF OBJECT_ID('dbo.GetCrimeCountByResident', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetCrimeCountByResident;
GO

CREATE FUNCTION dbo.GetCrimeCountByResident(@ResidentSSN INT)
RETURNS INT
AS
BEGIN
    DECLARE @CrimeCount INT;
    SELECT @CrimeCount = COUNT(*)
    FROM CRIME_REPORT
    WHERE RESIDENTSSN = @ResidentSSN;

    RETURN @CrimeCount;
END
GO

-- Example usage
SELECT dbo.ReportsCountByPoliceman(50005) AS ReportsHandled;
SELECT dbo.GetReportsByCategory(10) AS REPORTSBYCATEGORY;
SELECT dbo.GetCrimeCountByResident(101) AS NumberOfCrimes;

