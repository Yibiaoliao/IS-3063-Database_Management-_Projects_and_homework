/*Yibiao Liao seciton:01T*/
/*P1*/
CREATE TABLE Student(
StudentID INT NOT NULL,
StudentName VARCHAR(25)
CONSTRAINT Student_PK PRIMARY KEY (StudentID)
);
CREATE TABLE Faculty(
FacultyID INT NOT NULL,
FacultyName VARCHAR(25),
CONSTRAINT Faculty_PK PRIMARY KEY (FacultyID)
);

CREATE TABLE Course(
CourseID CHAR(8)NOT NULL,
CourseName VARCHAR(15),
CONSTRAINT Course_PK PRIMARY KEY (CourseID)
);
CREATE TABLE Qualified(
FacultyID INT NOT NULL,
CourseID CHAR(8)NOT NULL,
DateQualified DATE,
CONSTRAINT Qualified_PK PRIMARY KEY (FacultyID, CourseID),
CONSTRAINT Qualified_FK1 FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID),
CONSTRAINT Qualified_FK2 FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Section(
SectionNo INT NOT NULL,
Semester CHAR(7)NOT NULL,
CourseID CHAR(8)NOT NULL,/*P3 enfore courseid attribute by setting it not null*/
CONSTRAINT Section_PK PRIMARY KEY (SectionNo, Semester),
CONSTRAINT Section_FK FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Registration(
StudentID INT ,
SectionNo INT ,
Semester CHAR(7)

CREATE TABLE Tutor(
TutorID INT NOT NULL,
CertDate DATE,
Status_Tutor CHAR(10),
CONSTRAINT Tutor_PK PRIMARY KEY (TutorID)
);

CREATE TABLE Student2(
Student2ID INT NOT NULL,
Read_student NUMERIC NOT NULL,
CONSTRAINT Student2_PK PRIMARY KEY (Student2ID)
);

CREATE TABLE MatchHistory(
MatchID INT NOT NULL,
TutorID INT NOT NULL,
Student2ID INT NOT NULL,
StartDate DATE,
EndDate DATE,
CONSTRAINT MatchHistory_PK PRIMARY KEY (MatchID),
CONSTRAINT MatchHistory_FK1 FOREIGN KEY (TutorID) REFERENCES Tutor(TutorID),
);



);
/*Drop TABLE;*/
/*P2 Insert data to define the view*/
/*Student*/
INSERT INTO Student VALUES('38214','Letersky');
INSERT INTO Student VALUES('54907','Altvater');
INSERT INTO Student VALUES('66324','Aiken');
INSERT INTO Student VALUES('70542','Marra');
/*Faculty*/
INSERT INTO Faculty VALUES('2143','Birkin');
INSERT INTO Faculty VALUES('3467','Berndt');
INSERT INTO Faculty VALUES('4756','Collins');
/*Course*/
INSERT INTO Course VALUES('ISM 3113','Syst Analysis');
INSERT INTO Course VALUES('ISM 3112','Syst Design');
INSERT INTO Course VALUES('ISM 4212','Database');
INSERT INTO Course VALUES('ISM 4930','Networking');
/*Qualified*/
INSERT INTO Qualified VALUES('2143','ISM 3112','01/9/1988');
INSERT INTO Qualified VALUES('2143','ISM 3113','01/9/1988');
INSERT INTO Qualified VALUES('3467','ISM 4212','01/9/1995');
INSERT INTO Qualified VALUES('3467','ISM 4930','01/9/1996');
INSERT INTO Qualified VALUES('4756','ISM 3113','01/9/1991');
INSERT INTO Qualified VALUES('4756','ISM 3112','01/9/1991');
/*Section*/
INSERT INTO Section VALUES('2712','I-2008','ISM 3113');
INSERT INTO Section VALUES('2713','I-2008','ISM 3113');
INSERT INTO Section VALUES('2714','I-2008','ISM 4212');
INSERT INTO Section VALUES('2715','I-2008','ISM 4930');
/*Registration*/
INSERT INTO Registration VALUES('38214','2714','I-2008');
INSERT INTO Registration VALUES('54907','2714','I-2008');
INSERT INTO Registration VALUES('54907','2715','I-2008');
INSERT INTO Registration VALUES('66324','2713','I-2008');

/*Tutor*/
INSERT INTO Tutor VALUES('100','01/05/2008','Active');
INSERT INTO Tutor VALUES('101','01/05/2008','Temp Stop');
INSERT INTO Tutor VALUES('102','01/05/2008','Dropped');
INSERT INTO Tutor VALUES('103','05/22/2008','Active');
INSERT INTO Tutor VALUES('104','05/22/2008','Active');
INSERT INTO Tutor VALUES('105','05/22/2008','Temp Stop');
INSERT INTO Tutor VALUES('106','05/22/2008','Active');
/*Student*/
INSERT INTO Student2 VALUES('3000','2.3');
INSERT INTO Student2 VALUES('3001','5.6');
INSERT INTO Student2 VALUES('3002','1.3');
INSERT INTO Student2 VALUES('3003','3.3');
INSERT INTO Student2 VALUES('3004','2.7');
INSERT INTO Student2 VALUES('3005','4.8');
INSERT INTO Student2 VALUES('3006','7.8');
INSERT INTO Student2 VALUES('3007','1.5');
/*MatchHistory*/
INSERT INTO MatchHistory VALUES('1','100','3000','1/10/2008','');
INSERT INTO MatchHistory VALUES('2','101','3001','1/15/2008','5/15/2008');
INSERT INTO MatchHistory VALUES('3','102','3002','2/10/2008','3/01/2008');
INSERT INTO MatchHistory VALUES('4','106','3003','5/28/2008','');
INSERT INTO MatchHistory VALUES('5','103','3004','6/01/2008','6/15/2008');
INSERT INTO MatchHistory VALUES('6','104','3005','6/01/2008','6/28/2008');
INSERT INTO MatchHistory VALUES('7','104','3006','6/01/2008','');
/*Delete from MatchHistory where MatchID = '7';*/


/*P4*/
Alter TABLE Student ADD Class CHAR(20);/*add attribute class to student table*/
DROP TABLE IF EXISTS Registration;/*remove registration table*/
Alter TABLE Faculty /*change faculty name from 25 character to 40*/
Alter COLUMN FacultyName VARCHAR(40);

/*P5*/
INSERT INTO Student VALUES('65798','Lopez');/*add student lopez to the talbe*/
DELETE Student WHERE StudentName="Lopez";/*remove lopez*/
UPDATE Course /*modify course name*/
Set CourseName = 'Introduction to Relational Databases' where courseID='ISM 4212';

/*P6*/
Select StudentName From Student WHERE StudentID <50000; /*student with id number less than 50000*/
Select FacultyName From Faculty WHERE FacultyID =4756;/*faculty member with id of 4756*/
Select min(SectionNo) From Section WHERE Semester ='I-2008';/*smallest section number*/

/*P7*/
Select COUNT(SectionNo) from Section WHERE SectionNo=2714 and Semester='I-2008';/*number of student enroll in section 2714 in first semester of 2008*/
Select Qualified.FacultyID,Qualified.CourseID,Qualified.DateQualified FROM Qualified WHERE Qualified.DateQualified>'01/01/1993';/*faculty id, course and date since 1993*/

/*P8*/
Select Registration.StudentID from SECTION,Registration where SECTION.CourseID in (Select CourseID from COURSE where CourseName = 'Database' or CourseName = 'Networking' );
/*students enrooled in databseand networking*/

Select FacultyID,count(*) from Qualified where CourseID in('ISM 3113' ,'ISM 3112') group by FacultyID having count(*)<2 ;/*instructores can't teach both syst analysis and design*/
/*c*/
/*P9*/
Select DISTINCT CourseID from Section;/*course include in section*/
Select StudentName from Student ORDER BY StudentName;/*student name in alphabetical*/
/*c*/
SELECT CourseID from COURSE GROUP BY CourseID;/*course prefix order*/

/**/
/*P10*/
Select TutorID From Tutor Where Status_Tutor = 'Temp Stop';/*tutuor with status of temp stop*/
Select TutorID From Tutor Where Status_Tutor = 'Active';/*tutuor with status of active*/

/*P11*/
Select TutorID From Tutor Where TutorID Not in (Select TutorID from MatchHistory);/*tutor not tutored*/

/*P12*/
Select count(*) from MatchHistory where StartDate between '1/01/2008' and '5/31/2008'; /*student matched in first 5 month*/

/*P13*/
Select Student2ID From Student2 Where Read_student in (Select max(Read_student) from Student2);/*student have highest score*/
