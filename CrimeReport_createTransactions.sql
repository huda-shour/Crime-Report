
-- SQLScripts(Transactions,storedprocedures,cursor,functions):

/* Transaction Scenario:
Suppose you want to insert a new crime report and a corresponding response action,
but ensure both succeed or fail together. */

BEGIN TRANSACTION;

BEGIN TRY
    -- Insert new crime report
    INSERT INTO CRIME_REPORT (REPORTID, RESIDENTSSN, POLICEMANSSN, CATEGORYCODE, ID, DATETIMEOFWITNESS, DESCRIPTION, IMAGECAPTURED, STATUS)
    VALUES (9016, 100003, 50005, 20, 3, '2024-12-15 14:00', 'Assault in Kaslik Avenue parking lot', 'img_9016.jpg', 'Open');

    -- Insert corresponding response action
    INSERT INTO RESPONSE_ACTION (ACTIONID, POLICEMANSSN, REPORTID, ACTIONNAME, TARGET, DATETIMEOFACTION, STATUS)
    VALUES (7016, 50005, 9016, 'Investigation', 'Suspects', '2024-12-15 15:00', 'In Progress');

    COMMIT TRANSACTION;
    PRINT 'Transaction committed successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back due to error: ' + ERROR_MESSAGE();
END CATCH;


/* to see the Returns of the total number of reports a particular policeman is handling. */
SELECT dbo.fnReportsCountByPoliceman(50005) AS ReportsHandled;


/* Transaction:
Scenario: A crime report with REPORTID = 9001 (theft report) is now being closed.
We want to update its status to “Closed” and add a response action indicating “Case Closed */
BEGIN TRANSACTION;
BEGIN TRY
    -- Update the status of the crime report
	UPDATE CRIME_REPORT
	SET STATUS = 'Closed'
	WHERE REPORTID = 9001;

	-- Update the response action 7001 to mark it as 'Completed'
	UPDATE RESPONSE_ACTION
	SET STATUS = 'Completed', DATETIMEOFACTION = '2025-12-15 20:00'
	WHERE ACTIONID = 7001;

	-- commit if both succeed
COMMIT TRANSACTION
	PRINT 'Transaction committed successfully: Crime report closed and action updated.';
END TRY

BEGIN CATCH
    -- Rollback if any error occurs
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back due to error: ' + ERROR_MESSAGE();
END CATCH;


/* Transaction: Update Policeman Salary */
BEGIN TRANSACTION;

BEGIN TRY
    -- Update salary
    UPDATE POLICEMAN
    SET SALARY = 5000
    WHERE POLICEMANSSN = 50005;

    -- Log response action for salary update
    -- Use a dummy REPORTID or an existing report if needed; otherwise, you must allow NULL in RESPONSE_ACTION.REPORTID
    INSERT INTO RESPONSE_ACTION (ACTIONID, POLICEMANSSN, REPORTID, ACTIONNAME, TARGET, DATETIMEOFACTION, STATUS)
    VALUES (8001, 50005, 9004, 'Salary Updated', 'Salary inc to 5000', GETDATE(), 'Completed');

    COMMIT TRANSACTION;
    PRINT 'Transaction committed: Salary updated and response action added.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back: ' + ERROR_MESSAGE();
END CATCH;

