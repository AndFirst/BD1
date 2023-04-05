--tabela academic_degree
INSERT INTO academic_degree VALUES(1,'licencjat');
INSERT INTO academic_degree VALUES(2,'inynier');
INSERT INTO academic_degree VALUES(3,'magister');
INSERT INTO academic_degree VALUES(4,'doktor');
INSERT INTO academic_degree VALUES(5,'doktor habilitowany');
INSERT INTO academic_degree VALUES(6,'profesor');
--DELETE FROM academic_degree;

--------------------------------------------------------------------

INSERT INTO subject_type (name) VALUES ('Wychowanie fizyczne');
INSERT INTO subject_type (name) VALUES ('Jêzyki obce');
INSERT INTO subject_type (name) VALUES ('Przedmioty ekonomiczno-spo³eczne');
INSERT INTO subject_type (name) VALUES ('Matematyka');
INSERT INTO subject_type (name) VALUES ('Architektura komputerów i sprzêt komputerowy');
INSERT INTO subject_type (name) VALUES ('Metody wytwarzania oprogramowania');
INSERT INTO subject_type (name) VALUES ('Podstawy informatyki');
INSERT INTO subject_type (name) VALUES ('Fizyka');

--------------------------------------------------------------------
INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Pi³ka no¿na', 0,  1);
    
INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Judo', 0,  1);
    
INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Kulturystyka', 0,  1);
    
----------------------------------------------------------

INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Jêzyk angielski - B2', 4,  2);
    
INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Jêzyk rosyjski - A1', 2,  2);
    
INSERT INTO subject (name, ects_points, subject_type_id) 
    VALUES ('Jêzyk w³oski - A1', 2,  2);    
---------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Podstawy prawa - prawa autorskie', 2, 'PRAUT', 3);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Protokó³ dyplomatyczny', 2, 'PROD', 3);
---------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Analiza matematyczna', 6, 'ANMA', 4);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Matematyka konkretna 1', 5, 'MAKO1', 4);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Matematyka konkretna 2', 5, 'MAKO2', 4);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Probabilistyka', 5, 'PROB', 4);
    
----------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Podstawy techniki cyfrowej', 6, 'PTCY', 5);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Architektura komputerów', 4, 'ARKO', 5);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Podstawy techniki cyfrowej', 6, 'PTCY', 5);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Wstêp do automatyki elektroniki i telekomunikacji', 3, 'WAET', 5);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Systemy komputerowe w pomiarach i sterowaniu', 4, 'SKPS', 5);
    
----------------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Podstawy informatyki i programowania', 6, 'PIPR', 6);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Projekt zespo³owy pierwszy', 5, 'PZSP1', 6);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Programowaie obiektowe', 4, 'PROI', 6);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Programowaie aplikacyjne', 5, 'PAP', 6);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Sztuka wytwarzania oprogramowania', 4, 'SWO', 6);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Programowaie sieciowe', 4, 'PSI', 6);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Projekt zespo³owy drugi', 6, 'PZSP2', 6);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Paradygmaty programowania', 3, 'PARP', 6);
    
----------------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Algorytmy i struktury danych', 6, 'AISDI', 7);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Sieci komputerowe', 4, 'SKM', 7);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Wprowadzenie do sztucznej inteligencji', 5, 'WSI', 7);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Systemy operacyjne', 5, 'SOI', 7);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Bazy danych 1', 4, 'BD1', 7);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Wprowadzenie do systemów zarz¹dzania', 5, 'WSYZ', 7);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Wstêp do multimediów', 5, 'WMM', 7);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Bezpieczeñstwo systemó i sieci', 4, 'BSS', 7);

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Bazy danych 2', 4, 'BD2', 7);

---------------------------------------------------------------

INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Fizyka ogólna', 4, 'FO', 8);
    
INSERT INTO subject (name, ects_points, code, subject_type_id) 
    VALUES ('Fizyczne podstawy przetwarzania informacji', 4, 'FPPI', 8);
    
--------------------------------------------------------------    

INSERT INTO course (name, academic_degree_id) 
    VALUES ('Informatyka I stopnia', 2);

INSERT INTO course (name, academic_degree_id) 
    VALUES ('Informatyka II stopnia', 3);

INSERT INTO course (name, academic_degree_id) 
    VALUES ('Informatyka III stopnia', 4);
    
INSERT INTO course (name, academic_degree_id) 
    VALUES ('Automatyka i robotyka ', 2);
    
INSERT INTO course (name, academic_degree_id) 
    VALUES ('Administracja I stopnia', 1);
    
INSERT INTO course (name, academic_degree_id) 
    VALUES ('Telekomunikacja I stopnia', 2);

INSERT INTO course (name, academic_degree_id) 
    VALUES ('Telekomunikacja  II stopnia', 3);


-----------------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY";
--tabela marks
INSERT INTO mark_type VALUES(1,2,'dwa');
INSERT INTO mark_type VALUES(2,3,'trzy');
INSERT INTO mark_type VALUES(3,3.5,'trzy i p');
INSERT INTO mark_type VALUES(4,4,'cztery');
INSERT INTO mark_type VALUES(5,4.5,'cztery i p');
INSERT INTO mark_type VALUES(6,5,'pi');
COMMIT;
--SELECT * FROM mark_type;
--Delete FROM mark_type;

--------------------------------------------------------------------------

--tabela student
INSERT INTO student VALUES(1, 'Jan', 'Nowak', '01/02/2000', 'M', '100000', 1);
INSERT INTO student VALUES(2, 'Alexander', 'Nos', '06/05/1998', 'M', '100001', 2);
INSERT INTO student VALUES(3, 'Ignacy', 'Kowal', '24/10/2002', 'M', '100002', 4);
INSERT INTO student VALUES(4, 'Jan', 'Kowalski', '11/11/1996', 'M', '100003', 2);
INSERT INTO student VALUES(5, 'Kamil', 'Ko', '16/02/2000', 'M', '100004', 7);
INSERT INTO student VALUES(6, 'Jakub', 'Domienik', '07/01/1997', 'M', '100005', 2);
INSERT INTO student VALUES(7, 'Adam', 'Nowak', '28/02/2000', 'M', '100006', 1);
INSERT INTO student VALUES(8, 'Piotr', 'Kukieko', '18/07/1995', 'M', '100007', 3);
INSERT INTO student VALUES(9, 'Pawe', 'Rudy', '24/10/2002', 'M', '100008', 1);
INSERT INTO student VALUES(10, 'Mariusz', 'Zieleniuch', '01/11/1996', 'M', '100009', 6);
INSERT INTO student VALUES(11, 'Gustaw', 'Kowalski', '24/12/2001', 'M', '100010', 1);
INSERT INTO student VALUES(12, 'Jakub', 'Mikus', '30/05/1997', 'M', '100011', 2);

INSERT INTO student VALUES(13, 'Anna', 'Iga', '13/02/2001', 'K', '100012', 7);
INSERT INTO student VALUES(14, 'Ola', 'Wlazo', '19/07/1999', 'K', '100013', 6);
INSERT INTO student VALUES(15, 'Aneta', 'Kowal', '24/10/2001', 'K', '100014', 1);
INSERT INTO student VALUES(16, 'Barbara', 'Kowalska', '27/11/1999', 'K', '100015', 2);
INSERT INTO student VALUES(17, 'Kamila', 'Kowalska', '28/06/2000', 'K', '100016', 7);
INSERT INTO student VALUES(18, 'Faustyna', 'Domienik', '30/03/1997', 'K', '100017', 2);
INSERT INTO student VALUES(19, 'Angelika', 'Nowak', '19/02/2002', 'K', '100018', 1);
INSERT INTO student VALUES(20, 'Patrycja', 'Teterycz', '02/01/1996', 'K', '100019', 2);
INSERT INTO student VALUES(21, 'Paulina', 'Gaan', '04/12/2002', 'K', '100020', 5);
INSERT INTO student VALUES(22, 'Katarzyna', 'Ruda', '01/11/1998', 'K', '100021', 6);
INSERT INTO student VALUES(23, 'Klaudia', 'Kowalska', '05/10/2002', 'K', '100022', 7);
INSERT INTO student VALUES(24, 'Natalia', 'Mikus', '03/09/1997', 'K', '100023', 2);
--DELETE FROM student;
--select * from student;

----------------------------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY";

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Jan', 'Kowalski', 'M', '15/07/1975', 3);
    
INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Anna', 'Nowak', 'K', '20/03/1980', 4);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Tomasz', 'Wiœniewski', 'M', '01/05/1958', 4);
    
INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Katarzyna', 'Wójcik', 'K', '12/12/1962', 5);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Piotr', 'Kowalczyk', 'M', '23/06/1977', 3);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Agata', 'Zieliñska', 'K', '18/09/1955', 6);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('£ukasz', 'Szewczyk', 'M', '28/02/1970', 4);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Ma³gorzata', 'WoŸniak', 'K', '14/08/1965', 3); 

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Adam', 'Dudek', 'M', '30/11/1978', 4);

INSERT INTO instructor (first_name, last_name, gender, birth_date, academic_degree_id)
    VALUES ('Ewa', 'Koz³owska', 'K', '12/04/1973', 5);

-----------------------------------------------------------------------------

INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (120, 1, 1);

INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (100, 2, 5);
    
INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (60, 1, 8);
    
INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (30, 10, 1);
    
INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (120, 5, 4);

INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (100, 3, 7);
    
INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (120, 3, 9);
    
INSERT INTO subject_group (capacity, instructor_id, subject_id)
    VALUES (30, 9, 2);

------------------------------------------------------------------------------------

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 1, 1);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 2, 1);

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 3, 1);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 4, 1);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 5, 1);

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 6, 1);

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 1, 2);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 2, 4);

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 3, 2);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 4, 4);
    
INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 5, 2);

INSERT INTO assignment ("date", subject_group_id, student_id)
    VALUES (SYSDATE, 6, 4);

--------------------------------------------------------------------

INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 36, 5);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 26, 6);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 7, 5);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 6, 5);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 11, null);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 12, null);
INSERT INTO mark(student_id, subject_id, mark_type_id) VALUES(1, 13, null);