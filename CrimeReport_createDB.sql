/* Create of Database: */
USE master

GO

CREATE DATABASE CrimeReport
ON 
( NAME = CrimeReport_dat,
  FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CrimeRepORT.mdf")
LOG ON
( NAME = CrimeReport_log,
  FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CrimeReport_log.ldf")

go