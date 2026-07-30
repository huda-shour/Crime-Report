
-- Security:

-- login:
CREATE LOGIN Admin_Login WITH PASSWORD = 'AdminPass@123';

CREATE LOGIN Policeman_Login WITH PASSWORD = 'PolicemanPass@123';

CREATE LOGIN Resident_Login WITH PASSWORD = 'ResidentPass@123';

CREATE LOGIN Supervisor_Login WITH PASSWORD = 'SupervisorPass@123';

CREATE LOGIN DataEntry_Login WITH PASSWORD = 'DataEntryPass@123';

CREATE LOGIN Analyst_Login WITH PASSWORD = 'AnalystPass@123';

CREATE LOGIN ReadOnly_Login WITH PASSWORD = 'ReadOnlyPass@123';

-- permissions:

USE CrimeReport;

-- Admin
CREATE USER Huda FOR LOGIN Admin_Login;

CREATE ROLE AdminRole;
Alter role AdminRole ADD member Huda;
-- Grant full access to all tables
GRANT select, insert, update, delete on CRIME_REPORT to AdminRole;
GRANT select, insert, update, delete on RESPONSE_ACTION to AdminRole;
GRANT select, insert, update, delete on RESIDENT to AdminRole;
GRANT select, insert, update, delete on ADDRESSES to AdminRole;
GRANT select, insert, update, delete on CRIME_CATEGORY to AdminRole;
GRANT select, insert, update, delete on POLICEMAN to AdminRole;

GRANT EXECUTE TO AdminRole;

-- Policeman
CREATE USER Mariam FOR LOGIN Policeman_Login;

CREATE ROLE PolicemanRole;
Alter role PolicemanRole ADD member Mariam;

-- Can manage crime reports and actions
GRANT select, insert, update ON CRIME_REPORT TO PolicemanRole;
GRANT select, insert, update ON RESPONSE_ACTION TO PolicemanRole;

-- Can view reference data
GRANT select ON RESIDENT TO PolicemanRole;
GRANT select ON ADDRESSES TO PolicemanRole;
GRANT select ON CRIME_CATEGORY TO PolicemanRole;

-- Resident
CREATE USER Fatima FOR LOGIN Resident_Login;

CREATE ROLE ResidentRole;
Alter role ResidentRole ADD member Fatima;
-- Resident can submit and view their own crime reports
GRANT select, insert ON CRIME_REPORT TO ResidentRole;
-- Resident can view crime categories
GRANT select ON CRIME_CATEGORY TO ResidentRole;

-- Supervisor
CREATE USER Hawraa FOR LOGIN Supervisor_Login;

CREATE ROLE SupervisorRole;
Alter role SupervisorRole ADD member Hawraa;
-- Can review reports, assign policemen
GRANT SELECT, UPDATE ON CRIME_REPORT TO SupervisorRole;
GRANT SELECT ON POLICEMAN TO SupervisorRole;
GRANT SELECT ON CRIME_CATEGORY TO SupervisorRole;

-- DataEntry
CREATE USER Alisar FOR LOGIN DataEntry_Login;

CREATE ROLE DataEntryRole;
Alter role DataEntryRole ADD member Alisar;

GRANT INSERT ON CRIME_REPORT TO DataEntryRole;
GRANT INSERT ON RESIDENT TO DataEntryRole;

-- ReadOnly
CREATE USER Ali FOR LOGIN ReadOnly_Login;

CREATE ROLE ReadOnlyRole;
Alter role ReadOnlyRole ADD member Ali;

GRANT SELECT ON CRIME_REPORT TO ReadOnlyRole;
GRANT SELECT ON RESPONSE_ACTION TO ReadOnlyRole;
GRANT SELECT ON RESIDENT TO ReadOnlyRole;
GRANT SELECT ON POLICEMAN TO ReadOnlyRole;
GRANT SELECT ON CRIME_CATEGORY TO ReadOnlyRole;

-- Analyst
CREATE USER Bushra FOR LOGIN Analyst_Login;

CREATE ROLE AnalystRole;
Alter role AnalystRole ADD member Bushra;
-- AnalystRole can only read data from the views.
GRANT SELECT ON vwResidentFullInfo TO AnalystRole;
GRANT SELECT ON vwCrimeReportDetails TO AnalystRole;
GRANT SELECT ON vwPolicemanAssignments TO AnalystRole;
GRANT SELECT ON vwCrimeCategorysummary TO AnalystRole;
GRANT SELECT ON vwResponseActionDetails TO AnalystRole;
GRANT SELECT ON vwActiveCrimeReports TO AnalystRole;
GRANT SELECT ON vwResidentCrimeHistory TO AnalystRole;
GRANT SELECT ON vwLatestResponseAction TO AnalystRole;
GRANT SELECT ON vwPolicemanSalaryActivity TO AnalystRole;

