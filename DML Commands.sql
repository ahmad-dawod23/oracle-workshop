
--using regular expressions:
--like for finding a word that matches the search critiria

SELECT first_name, last_name
FROM employees
WHERE REGEXP_LIKE (first_name, '^Ste(v|ph)en$');

--like for finding a string that matches the search critiria
SELECT
REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA',
'[^ ]+', 1, 6) "REGEXP_INSTR"
FROM DUAL;

--dropping tables with constraints cascading:
drop table md_constraints_details CASCADE constraints

--dropping bulk tables specificed with a condition
BEGIN

FOR c IN (SELECT table_name FROM user_tables) LOOP
EXECUTE IMMEDIATE ('DROP TABLE "' || c.table_name || '" CASCADE CONSTRAINTS');
END LOOP;

FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
EXECUTE IMMEDIATE ('DROP SEQUENCE ' || s.sequence_name);
END LOOP;

END;

--bulk insert VALUES not fetched from another table:

INSERT ALL
  INTO categories (id, name) VALUES (1, 'Film & Animation')
  INTO categories (id, name) VALUES (2, 'Autos & Vehicles')
  INTO categories (id, name) VALUES (4, 'Pets & Animals')
  INTO categories (id, name) VALUES (5, 'Sports')
  INTO categories (id, name) VALUES (6, 'Travel & Events')
  INTO categories (id, name) VALUES (7, 'Gaming')
SELECT * FROM dual;