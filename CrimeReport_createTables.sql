/* Table: RESIDENT */

create table RESIDENT 
(
   RESIDENTSSN          integer                        not null,
   FIRSTNAME            varchar(20)                    null,
   MIDDLENAME           varchar(20)                    null,
   LASTNAME             varchar(20)                    null,
   CONTACTNUMBER        varchar(20)                    null,
   GENDER               varchar(10)                    null,
   DATEOFBIRTH          date                           null,
   primary key clustered (RESIDENTSSN)
)
GO


/* Table: ADDRESSES */

create table ADDRESSES 
(
   ID                   integer                        not null,
   RESIDENTSSN          integer                        not null,
   CITY                 varchar(50)                    null,
   STREET               varchar(100)                    null,
   APARTMENT            varchar(10)                    null,
   primary key clustered (ID),
   foreign key (RESIDENTSSN)
      references RESIDENT (RESIDENTSSN)
)
GO


/* Table: CRIME_CATEGORY */

create table CRIME_CATEGORY 
(
   CATEGORYCODE         integer                        not null,
   CATEGORYNAME         varchar(20)                    null,
   DEGREEOFAFFECTION    varchar(20)                    null,
   primary key clustered (CATEGORYCODE)
)
GO


/* Table: POLICEMAN */

create table POLICEMAN 
(
   POLICEMANSSN         integer                        not null,
   FIRSTNAME            varchar(20)                    null,
   MIDDLENAME           varchar(20)                    null,
   LASTNAME             varchar(20)                    null,
   CONTACTNUMBER        varchar(20)                    null,
   JOININGDATE          date                           null,
   SALARY               decimal(10,2)                  null,
   primary key clustered (POLICEMANSSN)
)
GO


/* Table: CRIME_REPORT */

create table CRIME_REPORT 
(
   REPORTID             integer                        not null,
   RESIDENTSSN          integer                        not null,
   POLICEMANSSN         integer                        not null,
   CATEGORYCODE         integer                        not null,
   ID                   integer                        not null,
   DATETIMEOFWITNESS    DATETIME                       null,
   DESCRIPTION          varchar(220)                   null,
   IMAGECAPTURED        varchar(220)                   null,
   STATUS               varchar(20)                    null,
   primary key clustered (REPORTID),
   foreign key (RESIDENTSSN) references RESIDENT (RESIDENTSSN),
   foreign key (POLICEMANSSN)references POLICEMAN (POLICEMANSSN),
   foreign key (CATEGORYCODE)references CRIME_CATEGORY (CATEGORYCODE),
   foreign key (ID) references ADDRESSES (ID)
)
GO



/* Table: RESPONSE_ACTION */

create table RESPONSE_ACTION 
(
   ACTIONID             integer                        not null,
   POLICEMANSSN         integer                        not null,
   REPORTID             integer                        not null,
   ACTIONNAME           varchar(20)                    null,
   TARGET               varchar(20)                    null,
   DATETIMEOFACTION     DATETIME                       null,
   STATUS               varchar(20)                    null,
   primary key clustered (ACTIONID),
   foreign key (REPORTID) references CRIME_REPORT (REPORTID),
   foreign key (POLICEMANSSN) references POLICEMAN (POLICEMANSSN)
      
)
GO

