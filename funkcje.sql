CREATE OR replace FUNCTION calculate_average_grade(p_id NUMBER)
RETURN NUMBER
AS
  v_mean NUMBER:=0;
  v_sum NUMBER:=0;
  v_ects NUMBER:=0;

BEGIN
    FOR r_mark IN (SELECT mt.value as value, s.ects_points as ects_point
                FROM mark m JOIN subject s using(subject_id)
                JOIN mark_type mt using(mark_type_id) WHERE student_id=p_id)
    LOOP
        v_sum:=v_sum+r_mark.value*r_mark.ects_point;
        v_ects:=v_ects +r_mark.ects_point;
    END LOOP;

    IF v_ects >0 THEN
        v_mean:=v_sum/v_ects;
    END IF;
    RETURN ROUND(v_mean,2);
END;
/ 
-- suma ects dla studenta (gdy zaliczy przedmiot)
CREATE OR replace FUNCTION calculate_ects_sum(p_id NUMBER)
RETURN NUMBER
AS
  v_sum NUMBER:=0;

BEGIN
    SELECT sum(ECTS_POINTS) INTO v_sum FROM mark JOIN subject using(subject_id)
    WHERE student_id=p_id AND mark_type_id is not null;
    RETURN v_sum;
END;
/ 
-- suma ects dla studenta dla danej grupy przedmiotów (gdy zaliczy przedmiot)
CREATE OR replace FUNCTION calculate_ects_sum_group (p_id NUMBER, p_group VARCHAR)
RETURN NUMBER
AS
  v_sum NUMBER:=0;

BEGIN
    SELECT sum(ECTS_POINTS) INTO v_sum 
    FROM mark m JOIN subject s using(subject_id) JOIN subject_type st using (subject_type_id)
    WHERE student_id=p_id AND mark_type_id is not null AND st.name=p_group;
    RETURN v_sum;
END;
/ 