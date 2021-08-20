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
);


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
Drop TABLE TutorReport;
CREATE TABLE TutorReport(
MatchID INT NOT NULL,
Month1 Date,
Hours1 INT,
Lessons INT,
CONSTRAINT TutorReport_FK1 FOREIGN KEY (MatchID) REFERENCES MatchHistory(MatchID),
);



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
INSERT INTO MatchHistory VALUES('7','104','3006','6/01/2008','')
/*Tutor Report*/
INSERT INTO TutorReport VALUES('1','6/08/2008','8','7');
INSERT INTO TutorReport VALUES('4','6/08/2008','8','6');
INSERT INTO TutorReport VALUES('5','6/08/2008','4','4');
INSERT INTO TutorReport VALUES('4','7/08/2008','10','5');
INSERT INTO TutorReport VALUES('1','7/08/2008','4','2');


/**/
/* 1.  Write SQL retrieval commands for each of the following queries:*/
/*a.  Display the course ID and course name for all courses with an ISM prefix.*/
Select CourseID CourseName From Course Where CourseID Like 'ISM%';
/*b.  Display all courses for which Professor Berndt has been qualified.*/
Select FacultyName, COURSE.CourseID, CourseName 
From Faculty, Course, Qualified
Where Qualified.FacultyID = 3467
And Faculty.FacultyID= Qualified.FacultyID
And Course.CourseID=Qualified.CourseID;
/*c.  Display the class roster, including student name, for all students enrolled in section 2714 of ISM 4212.*/
Select Student.StudentID, StudentName,
Section.CourseID, Registration.SectionNo,Section.Semester
From Student, Registration, Section
Where Section.SectionNo= Registration.SectionNo
AND Student.StudentID= Registration.StudentID AND Registration.SectionNo=2714
AND Section.Semester='I-2008'
AND Registration.Semester='I-2008'
Order By StudentName;

/*2. Write an SQL query to answer the following question: Which instructors are qualified to teach ISM 3113?*/
SELECT FacultyName
FROM Faculty,Qualified
WHERE Qualified.FacultyID=FACULTY. FacultyID
AND Qualified.CourseID='ISM 3113';

/*3. Write an SQL query to answer the following question: Is any instructor qualified to teach ISM 3113 and not qualified to teach ISM 4930?*/
SELECT Faculty.FacultyNAME
FROM Faculty, Qualified
WHERE Qualified.FacultyID=FACULTY. FacultyID
AND Qualified.CourseID='ISM 3113'
AND NOT (Qualified.CourseID='ISM 4930');

/*4.  Write SQL queries to answer the following questions:*/
/*a.  How many students were enrolled in section 2714 dur-ing semester I-2008?*/
SELECT COUNT (DISTINCT (StudentID))
FROM Registration
WHERE SectionNo = 2714
AND Semester = 'I-2008';
/*b.  How many students were enrolled in ISM 3113 during semester I-2008?*/
SELECT COUNT (DISTINCT (StudentID))
FROM Section, Registration
Where Section.SectionNO = Registration.SectionNO
And CourseID = 'ISM 3113'
And Semester = 'I-2008';

/* 5.  Write an SQL query to answer the following question: Which students were not enrolled in any courses during  semester  I-2008?*/
Select Student.StudentID, Student.StudentName from
Student Where NOT EXISTS(
Select * from Registration where Registration.StudentID = Student.StudentID and Registration.Semester = 'I-2008')
/**/
/* 6.  Determine the relationships among the four entities in Figure 7-15. 
List primary keys for each entity and any  foreign keys necessary to establish the relationships and maintain referential integrity.
Pay particular attention to the data contained in TUTOR REPORTS when you set up its  primary key.
Tutor:
Primary key- TutorID

Student:
Primary key-Student2ID

MATCH HISTORY:
Primary key - MatchID
Foreign key - Student2ID,TutorID

*/
/*7. Write the SQL command to add MATH SCORE to the STUDENT table.*/
ALTER TABLE Student2
ADD MathScore Int;

/*8. Write the SQL comand to add SUBJECT TO TUTOR.  The only values allowed for SUBJECT will be Reading,
Math, and ESL.*/
ALTER table tutor
add subject1 varchar(10) 
CONSTRAINT subject1 CHECK(subject1 IN ('reading', 'math', 'ESL'));

/**/
/*9.  What do you need to do if a tutor signs up and wants to tutor in both reading and math? 
Draw the new ERD and write any SQL statements that would be needed to handle this development.*/

/*10. Write the SQL command to find any tutors who have notsubmitted a report for July.*/


/*11. Where do you think student and tutor information such as
name, address, phone, and e-mail should be kept? Write the
necessary SQL commands to capture this information.
*/
Create Table information(
informationID INT NOT NULL,
informationName varchar(20),
informationAddress Varchar(20),
informationPhone Varchar(14),
informationEmail Varchar(25),
informationType Char(10),
CONSTRAINT information_PK PRIMARY KEY (informationID),
);

/*12. List all active students in June by name.
(Make up names and other data if you are actually building a prototype database.) 
Include the number of hours students received tutoring and how many lessons they completed.*/
Select MatchHistory.Student2ID, TutorReport.Hours1,TutorReport.Lessons 
From MatchHistory inner join TutorReport on
MatchHistory.MatchID = TutorReport.MatchID
where TutorReport.Month1 = '6/08/2008';


/*13. Which tutors, by name, are available to tutor? Write the SQL command.*/
SELECT TutorID FROM Tutor WHERE Tutor.Status_Tutor = 'Active';
/*14. Which tutor needs to be reminded to turn in reports?*/
SELECT distinct TutorID FROM MatchHistory
WHERE MatchID NOT IN(SELECT MatchID FROM TutorReport);
