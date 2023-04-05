--przypisanie oceny studentowi z danego przedmiotu
CREATE OR replace PROCEDURE add_mark (inst_id NUMBER, stud_id NUMBER, subj_id NUMBER, mark NUMBER)
AS
  mark_id   NUMBER:=1; 
  v_mark_row NUMBER:=0; 
  v_mark    NUMBER; --obecna ocena
  v_count_assignment NUMBER;
BEGIN
    SELECT mark_type_id INTO mark_id FROM mark_type WHERE value=mark;
    
    --czy istnieje wiersz
    SELECT count(*) INTO v_mark_row FROM mark
    WHERE student_id=stud_id AND subject_id=subj_id AND mark_type_id is null;
    
    SELECT max(value) INTO v_mark FROM mark JOIN mark_type using(mark_type_id)
     WHERE student_id=stud_id AND subject_id=subj_id;
     
    --czy student zapisany na przedmiot
    SELECT count(*) INTO v_count_assignment FROM assignment 
    JOIN subject_group using(subject_group_id) JOIN subject using(subject_id)
    WHERE student_id=stud_id AND subject_id=subj_id;

    IF v_mark is null THEN
        IF v_mark_row=0 THEN
            IF v_count_assignment >0 THEN
                INSERT INTO mark("date", instructor_id, student_id, subject_id, mark_type_id)
                    VALUES(SYSDATE, inst_id, stud_id, subj_id, mark_id);
                dbms_output.put_line ('Dodano ocenê');
            ELSE
                dbms_output.put_line ('Student nie zapisany na przedmiot');
            END IF;
        ELSE 
                
                UPDATE mark SET "date"=SYSDATE, instructor_id=inst_id, mark_type_id=(SELECT mark_type_id FROM mark_type WHERE value=mark)
                    WHERE student_id=stud_id AND subject_id=subj_id AND mark_type_id is null;
                dbms_output.put_line ('Wystawiono ocene');   
        END IF;
    ELSE
        dbms_output.put_line ('Ocena zaktualizowana');
        UPDATE mark SET "date"=SYSDATE, instructor_id=inst_id, mark_type_id=(SELECT mark_type_id FROM mark_type WHERE value=mark)
                    WHERE student_id=stud_id AND subject_id=subj_id;
    END IF;
END;
/

--rejestracja na przedmiot (grupy z danego przedmiotu) mo¿liwa tylko wtedy gdy student nie ma pozzytywnej oceny z danego przedmiotu
CREATE OR replace PROCEDURE regist_group (group_id NUMBER, stud_id NUMBER)
AS
  v_mark_row NUMBER:=0; 
  v_mark    NUMBER; --obecna max ocena
  v_count_assignment NUMBER;
  subj_id NUMBER;
BEGIN
    SELECT subject_id INTO subj_id FROM subject_group WHERE subject_group_id=group_id;
    
    --czy istnieje wiersz z ocenami
    SELECT count(*) INTO v_mark_row FROM mark WHERE student_id=stud_id AND subject_id=subj_id;
    
    SELECT max(value) INTO v_mark FROM mark JOIN mark_type using(mark_type_id)
     WHERE student_id=stud_id AND subject_id=subj_id;
    dbms_output.put_line (v_mark_row);
    IF v_mark_row=0 THEN
        INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, group_id, stud_id);
        dbms_output.put_line ('Zapisano na przedmiot');
    END IF;
    IF v_mark_row>0 THEN
        IF v_mark=2 THEN
            INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, group_id, stud_id);
            dbms_output.put_line ('Zapisano na przedmiot- poprawka');
        END IF;
        IF v_mark is null THEN
            INSERT INTO assignment ("date", subject_group_id, student_id) VALUES (SYSDATE, group_id, stud_id);
            dbms_output.put_line ('Zapisani');
        END IF;
        IF v_mark >2 THEN
            dbms_output.put_line ('Nie mo¿na siê zapisaæ, przedmiot zdany');
        END IF;

    END IF;
EXCEPTION
  WHEN no_data_found THEN
             dbms_output.put_line ('Niepoprawna dane');
             RAISE; 

    
END;
/
