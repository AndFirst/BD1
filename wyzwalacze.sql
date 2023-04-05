--wyzwalacz sprawdzaj¹cy limit miejsc do grupy przed zapisaniem 
CREATE OR REPLACE TRIGGER tg_assignment
BEFORE INSERT ON assignment FOR EACH ROW
DECLARE
    v_count NUMBER;          
    v_limit NUMBER;
BEGIN
    SELECT count(*) INTO v_count FROM assignment 
        WHERE subject_group_id=:new.subject_group_id;
    SELECT capacity INTO v_limit FROM subject_group
        WHERE subject_group_id=:new.subject_group_id;
    IF v_count >= v_limit THEN
        dbms_output.put_line('Grupa zajeciowa jest pelna');
        raise_application_error(-20001, 'Przekroczono limit miejsc');
    END IF;
END;
/
--DROP TRIGGER tg_assignment2;

--wyzwalacz sprawdzaj¹cy czy student juz sie nie zapisa³
CREATE OR REPLACE TRIGGER tg_assignment2
BEFORE INSERT ON assignment FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT count(*) INTO v_count FROM assignment 
        WHERE subject_group_id=:new.subject_group_id AND student_id=:new.student_id;

    IF v_count >= 1 THEN
        dbms_output.put_line('Student jest ju¿ w tej grupie');
        raise_application_error(-20002, 'Student o ID '|| :new.student_id ||' ju¿ zapisany do grupy ' ||:new.subject_group_id);
    END IF;
END;
/

--tworzenie rekordu w tabeli mark przy do³¹czeniu do grupy (tylko 1 raz- zapisanie siê do kolejnej grupy nie powoduje dodania)
CREATE OR REPLACE TRIGGER tg_assignment_mark
AFTER INSERT ON assignment FOR EACH ROW
DECLARE
    v_subject_id NUMBER;
    v_count NUMBER;
BEGIN
    SELECT subject_id INTO v_subject_id FROM subject_group WHERE subject_group_id=:new.subject_group_id;
    SELECT count(*) INTO v_count FROM mark WHERE student_id=:new.student_id AND subject_id=v_subject_id AND mark_type_id is null;
    IF v_count = 0 THEN
        INSERT INTO mark(instructor_id, student_id, subject_id, mark_type_id)
            VALUES(null, :new.student_id, v_subject_id, null);
    END IF;
END;
/
