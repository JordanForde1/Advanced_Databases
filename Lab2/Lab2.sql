DROP TABLE Reference;
DROP TABLE Application;
DROP TABLE School_history;
DROP TABLE School;
DROP TABLE Student_address;
DROP TABLE Student_details;

CREATE TABLE Student_details(
    StudentID INTEGER PRIMARY KEY,
    Student_Name VARCHAR(50)
);

CREATE TABLE Student_address(
	StudentID INTEGER,
    Street VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(50),

    FOREIGN KEY (StudentID) REFERENCES Student_details (StudentID)
);

CREATE TABLE School(
    PriorSchoolId INTEGER PRIMARY KEY,
    PriorSchoolAddr VARCHAR(100)
);

CREATE TABLE School_history(
	StudentID INTEGER,
    PriorSchoolId INTEGER NOT NULL,
    GPA NUMBER(2),
    PRIMARY KEY (StudentID, PriorSchoolId),
    FOREIGN KEY (StudentID) REFERENCES Student_details (StudentID),
    FOREIGN KEY (PriorSchoolId) REFERENCES School (PriorSchoolId)
);

CREATE TABLE Application(
    App_No INTEGER,
    App_Year INTEGER,
    StudentID INTEGER,
    PRIMARY KEY(App_No, App_year),
    FOREIGN KEY (StudentID) REFERENCES Student_details (StudentID)
);

CREATE TABLE Reference(
	App_No INTEGER not null,
    App_Year INTEGER,
    ReferenceName VARCHAR(100),
    RefInstitution  VARCHAR(100),
    ReferenceStatement VARCHAR(500),
    FOREIGN KEY (App_Year, App_No) REFERENCES Application (App_Year, App_No)
);

--Insert into Student_details
INSERT INTO Student_details VALUES(1,'MARK');
INSERT INTO Student_details VALUES(2,'SARAH');
INSERT INTO Student_details VALUES(3,'PAUL');
INSERT INTO Student_details VALUES(4,'JACK');
INSERT INTO Student_details VALUES(5,'MARY');
INSERT INTO Student_details VALUES(6,'SUSAN');

--Insert into Mark Student_address
INSERT INTO Student_address VALUES(1,'GRAFTON STREET', 'NEW YORK','NY234');
INSERT INTO Student_address VALUES(1,'WHITE STREET', 'FLORIDA','FLO435');
--Insert into Sarah Student_address
INSERT INTO Student_address VALUES(2,'Green Road', 'California','Cal123');
--Insert into Paul Student_address
INSERT INTO Student_address VALUES(3,'Red Crescent', 'California','Ca455');
INSERT INTO Student_address VALUES(3,'Yellow Park', 'Mexico','Mex1');
--Insert into Jack Student_address
INSERT INTO Student_address VALUES(4,'Dartry Road', 'Ohio','Oh34');
--Insert into Mary Student_address
INSERT INTO Student_address VALUES(5,'Malahide Road', 'Ireland','IRE');
INSERT INTO Student_address VALUES(5,'Black Bay', 'Kansas','Kan45');
--Insert into Susan Student_address
INSERT INTO Student_address VALUES(6,'River Road', 'Kansas','Kan45');

--Insert into School
INSERT INTO School VALUES(1,'Castleknock');
INSERT INTO School VALUES(2,'Loreto College');
INSERT INTO School VALUES(3,'St. Patrick');
INSERT INTO School VALUES(4,'DBS');
INSERT INTO School VALUES(5,'Harvard');

--Insert into Mark School_history
INSERT INTO School_history VALUES(1,1,65);
INSERT INTO School_history VALUES(1,2,87);
--Insert into Sarah School_historY
INSERT INTO School_history VALUES(2,1,90);
INSERT INTO School_history VALUES(2,3,76);
INSERT INTO School_history VALUES(2,4,66);
INSERT INTO School_history VALUES(2,5,45);
--Insert into Paul School_history
INSERT INTO School_history VALUES(3,1,45);
INSERT INTO School_history VALUES(3,3,67);
INSERT INTO School_history VALUES(3,4,23);
INSERT INTO School_history VALUES(3,5,67);
--Insert into Jack School_history
INSERT INTO School_history VALUES(4,3,29);
INSERT INTO School_history VALUES(4,4,88);
INSERT INTO School_history VALUES(4,5,66);
--Insert into Mary School_history
INSERT INTO School_history VALUES(5,1,74);
INSERT INTO School_history VALUES(5,3,44);
INSERT INTO School_history VALUES(5,4,55);
INSERT INTO School_history VALUES(5,5,66);
--Insert into Susan School_history
INSERT INTO School_history VALUES(6,1,88);
INSERT INTO School_history VALUES(6,2,45);
INSERT INTO School_history VALUES(6,3,77);
INSERT INTO School_history VALUES(6,4,56);

--Insert into Mark Application
INSERT INTO Application VALUES(1,2003,1);
INSERT INTO Application VALUES(1,2004,1);
INSERT INTO Application VALUES(2,2007,1);
INSERT INTO Application VALUES(3,2012,1);
--Insert into Sarah Application
INSERT INTO Application VALUES(2,2010,2);
INSERT INTO Application VALUES(2,2011,2);
INSERT INTO Application VALUES(2,2012,2);
--Insert into Paul Application
INSERT INTO Application VALUES(1,2012,3);
INSERT INTO Application VALUES(3,2008,3);
--Insert into Jack Application
INSERT INTO Application VALUES(1,2009,4);
--Insert into Mary Application
INSERT INTO Application VALUES(1,2005,5);
INSERT INTO Application VALUES(2,2009,5);
--Insert into Mary Application
INSERT INTO Application VALUES(3,2011,6);

--Insert into Mark Reference
INSERT INTO Reference VALUES(1,2003,'Dr. Jones', 'Trinity College', 'Good Guy');
INSERT INTO Reference VALUES(1,2004,'Dr. Jones', 'Trinity College', 'Good Guy');
INSERT INTO Reference VALUES(2,2007,'Dr. Jones', 'Trinity College', 'Good Guy');
INSERT INTO Reference VALUES(3,2012,'Dr. Jones', 'U Limerick', 'Very Good Guy');
--Insert into Sarah Reference
INSERT INTO Reference VALUES(2,2010,'Dr. Byrne', 'DIT', 'Perfect');
INSERT INTO Reference VALUES(2,2011,'Dr. Byrne', 'DIT', 'Perfect');
INSERT INTO Reference VALUES(2,2012,'Dr. Byrne', 'UCD', 'Average');
--Insert into Paul Reference
INSERT INTO Reference VALUES(1,2012,'Dr. Jones', 'Trinity College', 'Poor');
INSERT INTO Reference VALUES(3,2008,'Prof. Cahill', 'UCC', 'Excellent');
--Insert into Jack Reference
INSERT INTO Reference VALUES(1,2009,'Prof. Lillis', 'DIT', 'Fair');
--Insert into Mary Reference
INSERT INTO Reference VALUES(1,2005,'Dr. Byrne', 'DIT', 'Perfect');
INSERT INTO Reference VALUES(2,2009,'Prof. Lillis', 'DIT', 'Good girl');
--Insert into Susan Reference
INSERT INTO Reference VALUES(3,2011,'Prof. Cahill', 'UCC', 'Messy');