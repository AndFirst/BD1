--testy (polecenia wykonywa� po kolei)
--------------------------------------------------------------------------------
--------------------------------wyzwalacze--------------------------------------
--------------------------------------------------------------------------------
SELECT * FROM subject_group;
SELECT * FROM mark;
INSERT INTO subject_group (capacity, instructor_id, subject_id) VALUES (2, 5, 4);
INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, 9, 10);
INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, 9, 11);
--wyzwalacz limit miejsc
INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, 9, 12);
--wyzwalacz ju� zapisany
INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, 9, 11);
--dodanie wiersza do mark za kaa�dym nowym insertem do assigment
SELECT * FROM mark;
COMMIT;
ROLLBACK;


--------------------------------------------------------------------------------
-------------------------------procedury----------------------------------------
--------------------------------------------------------------------------------
SELECT * FROM mark;
SELECT a.student_id, subject_id , subject_group_id ,s.subject_type_id
    FROM assignment a NATURAL JOIN subject_group sg  NATURAL JOIN subject s;
--przypisanie oceny: add_mark (inst_id NUMBER, stud_id NUMBER, subj_id NUMBER, mark NUMBER)
-- update ju� obecnego wiersza -------------------------------------------------
exec add_mark(5, 11, 4, '2');
SELECT * FROM mark JOIN mark_type using (mark_type_id) WHERE student_id=11;

-- zmiana ju� wystawionej oceny ------------------------------------------------
exec add_mark(5, 11, 4, '4,5');
SELECT * FROM mark JOIN mark_type using (mark_type_id) WHERE student_id=11;

-- wystawienie oceny dla danych bez wiersza wst�pnego wiersza w mark -----------
SELECT a.student_id, subject_id, subject_group_id, s.subject_type_id
    FROM assignment a NATURAL JOIN subject_group sg  NATURAL JOIN subject s
    WHERE student_id ||' '||subject_id NOT IN 
        (SELECT student_id ||' '||subject_id FROM mark); --te elementy co s� w assignment ale nie w mark
SELECT * FROM mark WHERE student_id=1;
exec add_mark(5, 1, 8, '4,5');
SELECT * FROM mark WHERE student_id=1;

-- pr�ba wystawienia oceny dla przebiotu, na kt�ry student nie jest zapisany----
SELECT subject_id FROM subject  --przedmioty na ktore student 1 nie jest zapisany
MINUS
SELECT subject_id FROM assignment a NATURAL JOIN subject_group sg  NATURAL JOIN subject s
    WHERE student_id=1;
exec add_mark(5, 1, 2, '4,5');  --pojawia si� komunikat dbms

--------------------------------------------------------------------------------
--rejestracja na przedmioty: regist_group (group_id NUMBER, stud_id NUMBER) ----
SELECT * FROM assignment WHERE student_id=12;
-- zapisano --------------------------------------------------------------------
exec regist_group (5, 12);
SELECT * FROM assignment WHERE student_id=12;
exec regist_group (5, 12); --wyzwalacz ponowne zapisanie
-- zapisano bo poprawka --------------------------------------------------------
SELECT a.student_id, subject_id FROM assignment a 
    JOIN subject_group sg using(subject_group_id) JOIN subject s using(subject_id)
    WHERE student_id=12;
exec add_mark(5, 12, 4, '2');
SELECT * FROM mark NATURAL JOIN mark_type WHERE student_id=12;
INSERT INTO subject_group (capacity, instructor_id, subject_id) VALUES (30, 5, 4);
SELECT * FROM subject_group WHERE subject_id=4;
exec regist_group (13, 12);
-- przedmiot zdany nie mo�na si� zapisa�----------------------------------------
exec add_mark(5, 12, 4, '3,5');
exec regist_group (12, 12); 


--------------------------------------------------------------------------------
-------------------------------funkcje------------------------------------------
--------------------------------------------------------------------------------
-- calculate_average_grade(p_id NUMBER) ----------------------------------------
SELECT value, ects_points
    FROM mark NATURAL JOIN mark_type NATURAL JOIN subject 
    WHERE student_id=1 AND mark_type_id is not null;
SELECT calculate_average_grade(1) FROM dual;

-- calculate_ects_sum(p_id NUMBER) ---------------------------------------------
SELECT calculate_ects_sum(1) FROM dual;

-- calculate_ects_sum_group (p_id NUMBER, p_group VARCHAR) ---------------------
SELECT st.name, count(*), sum(ects_points) 
FROM mark JOIN subject using(subject_id) JOIN subject_type st using(subject_type_id)
WHERE student_id=1 AND mark_type_id is not null GROUP BY st.name;

SELECT subject_type_id, name, calculate_ects_sum_group(1, name) FROM subject_type;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- wy�wietl uczni�w i przedmioty na jakie s� zapisani
SELECT * FROM student s 
 LEFT JOIN assignment a on(s.student_id = a.student_id);
 
 
-- Lista studentów z kieunku informatyka majacych niezaliczone przedmioty
SELECT student_id, first_name, last_name, COUNT(*) as liczba_niezaliczonych  
    FROM mark 
    natural join mark_type 
    natural join student 
    natural join course
        where value < 3 and course.name like 'Informatyka%'
            GROUP BY student_id, first_name, last_name;


-- Pięciu studentów i wykładowców grup do których są zapisani wśród których występuje największa różnica wieku.
select s.first_name s_name, s.last_name s_surname, s.birth_date s_date,
       i.first_name i_name, i.last_name i_surname, i.birth_date 
    from instructor i
    join subject_group using(instructor_id) 
    join assignment using(subject_group_id) 
    join student s using(student_id) 
    order by s.birth_date - i.birth_date desc
    fetch first 5 rows only;


-- Wyznacz 3 najlepszych student�w (o najwy�szej �redniej) dla ka�dego z kierunk�w
CREATE VIEW best_students AS
 SELECT student_id, course_id, calculate_average_grade(student_id) as grade
    FROM student s 
 WHERE student_id IN (
        SELECT student_id FROM student s2 WHERE s2.course_id = s.course_id
        ORDER BY calculate_average_grade(student_id) desc fetch first 3 rows only)
 ORDER BY course_id;
 
 SELECT c.name, bs.student_id, grade FROM best_students bs JOIN course c using(course_id);
 
 -- wylicz ile student�w zapisanych jest na przedmioty
SELECT gs.name, count(gs.student_id) as count_students FROM (SELECT s.name, a.student_id, count(*) FROM assignment a 
    JOIN subject_group sg using(subject_group_id) JOIN subject s using(subject_id) 
    GROUP BY s.name, a.student_id) gs GROUP BY gs.name
UNION
SELECT name, 0 FROM subject WHERE subject_id not in (SELECT subject_id FROM subject_group);
 