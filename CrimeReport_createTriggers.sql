-- triggers:

/* 1.Description:
If someone changes a crime category’s name then all crime reports using that category 
should have their description updated to mention the new category name at the end. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_Update_CrimeCategoryName
ON CRIME_CATEGORY
AFTER UPDATE
AS
BEGIN
    DECLARE @CategoryCode INT;
    DECLARE @OldName VARCHAR;
    DECLARE @NewName VARCHAR;

    -- Get updated values
    SELECT @CategoryCode = CATEGORYCODE,
           @NewName = CATEGORYNAME
    FROM inserted;

    -- Get old name
    SELECT @OldName = CATEGORYNAME
    FROM deleted;

    -- Only run if the name actually changed
    IF @NewName <> @OldName
    BEGIN
        UPDATE CRIME_REPORT
        SET DESCRIPTION = DESCRIPTION + ' (Category updated to: ' + @NewName + ')'
        WHERE CATEGORYCODE = @CategoryCode;
    END
END
GO



/* 2.Description:
Prevent deleting a crime report when response actions are linked to it
If a crime report has related response actions,the deletion is blocked to 
preserve data integrity. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER trg_delete_CrimeReport
ON CRIME_REPORT
AFTER DELETE
AS
BEGIN
    DECLARE @ReportID INT;

    -- Get the ReportID of the row being deleted
    SELECT @ReportID = ReportID
    FROM deleted;

    -- Check if dependent ResponseActions exist
    IF EXISTS (SELECT 1 FROM RESPONSE_ACTION WHERE REPORTID = @ReportID)
    BEGIN
        RAISERROR('ERROR: Cannot delete crime report because response actions exist for it.', 16, 1);
        RETURN;
    END

    -- If no dependencies, delete the crime report
    DELETE FROM CRIME_REPORT
    WHERE REPORTID = @ReportID;
END
GO


/* 3.Description:
Whenever a new crime report is added to the system, the system should automatically append the text
"(Report received)" to the end of the DESCRIPTION field to indicate
that the report was successfully recorded. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER trg_Insert_CrimeReport
ON CRIME_REPORT
AFTER INSERT
AS
BEGIN
    DECLARE @ReportID INT;
    DECLARE @Description VARCHAR(220);

    SELECT @ReportID = REPORTID,
           @Description = DESCRIPTION
    FROM inserted;

    UPDATE CRIME_REPORT
    SET DESCRIPTION = @Description + ' (Report received)'
    WHERE REPORTID = @ReportID;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 4.Description:
If someone inserts a new crime report but forgets to put a status, 
the trigger will automatically set it to 'Pending'. */

CREATE TRIGGER trg_Insert_CrimeReport_DefaultStatus
ON CRIME_REPORT
AFTER INSERT
AS
BEGIN
    DECLARE @ReportID INT;

    SELECT @ReportID = REPORTID
    FROM inserted;

    UPDATE CRIME_REPORT
    SET STATUS = 'Pending'
    WHERE REPORTID = @ReportID
      AND STATUS IS NULL;
END
GO



/* 5.description: 
When a new policeman is added, automatically set the joining date if missing
and ensure the salary is not less than 1000 and the SSN is unique. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_Add_Policeman
ON POLICEMAN
AFTER INSERT
AS
BEGIN
    DECLARE @PolicemanSSN INT;
    DECLARE @JoiningDate DATE;
    DECLARE @Salary DECIMAL(10,2);

    SELECT 
        @PolicemanSSN = PolicemanSSN,
        @JoiningDate = JoiningDate,
        @Salary = Salary
    FROM inserted;

  -- Auto-set Joining Date if NULL
    IF (@JoiningDate IS NULL)
    BEGIN
        UPDATE Policeman
        SET JoiningDate = GETDATE()
        WHERE PolicemanSSN = @PolicemanSSN;
    END

  -- Validate minimum salary
    IF (@Salary < 1000)
    BEGIN
        RAISERROR('Error: Policeman salary cannot be less than 1000.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- SSN must be unique
    IF EXISTS (
        SELECT COUNT(*) 
        FROM Policeman 
        WHERE PolicemanSSN = @PolicemanSSN
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Error: Duplicate PolicemanSSN detected.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO


/* 6.Description:
If a policeman is removed from the system, then all response actions associated with that 
policeman should be updated by appending the text "(Policeman removed)" to the STATUS 
field to indicate that the officer responsible for the action no longer exists in the system. */

CREATE TRIGGER trg_Delete_Policeman
ON POLICEMAN
AFTER DELETE
AS
BEGIN
    DECLARE @SSN INT;

    SELECT @SSN = POLICEMANSSN
    FROM deleted;

    -- Fixed syntax: normal space between column and = 
    UPDATE RESPONSE_ACTION
    SET STATUS = STATUS + ' (Policeman removed)'
    WHERE POLICEMANSSN = @SSN;
END
GO




/* 7.Description:
When a policeman’s record is updated, ensure the contact number is not NULL
and apply the valid contact number to the policeman’s record. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER update_policeman
ON POLICEMAN
AFTER UPDATE
AS
BEGIN
    DECLARE @PSSN INT;
    DECLARE @nb VARCHAR(20);

    SELECT
        @PSSN = POLICEMANSSN,
        @nb = CONTACTNUMBER
    FROM inserted;

    -- Validate Contact Number
    IF (@nb IS NULL)
    BEGIN
        RAISERROR('ERROR: Contact number cannot be empty', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Update the table with the new contact number
    UPDATE POLICEMAN
    SET CONTACTNUMBER = @nb
    WHERE POLICEMANSSN = @PSSN;
END
GO


/* 8.Description:
Prevent deletion if the resident has any crime reports. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER trg_Delete_Resident
ON RESIDENT
AFTER DELETE
AS
BEGIN
    DECLARE @ResidentSSN INT;

    SELECT @ResidentSSN = RESIDENTSSN
    FROM deleted;

    -- If the resident has crime reports, close them
    IF EXISTS (
        SELECT 1
        FROM CRIME_REPORT
        WHERE RESIDENTSSN = @ResidentSSN
    )
    BEGIN
        UPDATE CRIME_REPORT
        SET STATUS = 'Closed'
        WHERE RESIDENTSSN = @ResidentSSN;
    END
END
GO


/* 9.Description:
If a resident’s last name is modified, then all address records that belong to 
this resident should be updated by appending the text "(Name updated)" to the CITY field, 
indicating that the resident’s information has changed. */


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_Update_ResidentLastName
ON RESIDENT
AFTER UPDATE
AS
BEGIN
    DECLARE @SSN INT;
    DECLARE @OldLast VARCHAR(20);
    DECLARE @NewLast VARCHAR(20);

    SELECT @SSN = RESIDENTSSN,
           @NewLast = LASTNAME
    FROM inserted;

    SELECT @OldLast = LASTNAME
    FROM deleted;

    IF @NewLast <> @OldLast
    BEGIN
        UPDATE ADDRESSES
        SET CITY = CITY + ' (Name updated)'
        WHERE RESIDENTSSN = @SSN;
    END
END
GO


/* 10.Description:
A policeman adds a new response action for an existing crime report.
•	Ensure that the CrimeID exists in CrimeReport before inserting.
•	Automatically set the Status of the CrimeReport to "In Progress" if it was "Pending" */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER trg_Add_ResponseAction
ON RESPONSE_ACTION 
AFTER INSERT
AS
BEGIN
    DECLARE @CrimeReportID INT;

    -- Take the ReportID from the inserted row
    SELECT @CrimeReportID = REPORTID
    FROM inserted;

    -- Update Crime Report only if it is currently 'Pending'
    UPDATE CRIME_REPORT
    SET STATUS = 'In Progress'
    WHERE REPORTID = @CrimeReportID
      AND STATUS = 'Pending';
END
GO


/* 11.Description:
A response action is completed, and we want the related crime report to update automatically.
•	After updating ResponseAction.Status to "Completed", check if all related response actions are completed.
•	If yes, set the CrimeReport.Status to "Closed" automatically. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_Update_ResponseAction_Status
ON RESPONSE_ACTION
AFTER UPDATE
AS
BEGIN
    DECLARE @ReportID INT;

    -- Get the ReportID only for rows whose STATUS became 'Completed'
    SELECT @ReportID = REPORTID
    FROM inserted
    WHERE STATUS = 'Completed';

    -- If no relevant row became Completed, stop here
    IF @ReportID IS NULL
        RETURN;

    -- Check if there is any action that is NOT completed
    IF NOT EXISTS (
        SELECT 1
        FROM RESPONSE_ACTION
        WHERE REPORTID = @ReportID
        AND STATUS <> 'Completed'
    )
    BEGIN
        -- All response actions are completed → close the crime report
        UPDATE CRIME_REPORT
        SET STATUS = 'Closed'
        WHERE REPORTID = @ReportID;
    END
END
GO


/* 12.Description:
Whenever a response action is updated, the system automatically
refreshes the action's timestamp. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER trg_Update_ResponseAction_Time
ON RESPONSE_ACTION
AFTER UPDATE
AS
BEGIN
    DECLARE @ActionID INT;

    SELECT @ActionID = ACTIONID
    FROM inserted;

    UPDATE RESPONSE_ACTION
    SET DATETIMEOFACTION = GETDATE()
    WHERE ACTIONID = @ActionID;
END
GO