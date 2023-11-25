
--login as admin to system pluggable database
sqlplus FREEPDB1 as sysdba
sqlplus sys@localhost:1521/FREEPDB1 as sysdba


--login as sysdba to container DATABASE
sqlplus FREE as sysdba
sqlplus sys@localhost:1521/FREE as sysdba

--configuring a pluggable database:

alter pluggable database all open;
select name, open_mode from v$pdbs

CREATE PLUGGABLE DATABASE ORCLPDB2
ADMIN USER testuser IDENTIFIED BY password1
FILE_NAME_CONVERT=('/opt/oracle/oradata/ORCLCDB/pdbseed/','/opt/oracle/oradata/ORCLCDB/orclpdb2/');


ALTER PLUGGABLE DATABASE ORCLPDB2 OPEN

GRANT CREATE ANY INDEXTYPE TO testuser CONTAINER=current;

ALTER SESSION SET CONTAINER = ORCLPDB2;



---creating a backup from a database:

expdp hr DIRECTORY=C:\oraclexe\backup\ DUMPFILE=expdat.dmp SCHEMAS=hr

expdp scott/tiger@db10g schemas=SCOTT directory=TEST_DIR dumpfile=SCOTT.dmp logfile=expdpSCOTT.log

exp system/123 FULL=Y FILE=C:\oraclexe\backup\FULLcrm.DMP



--change password for the system user, useful when you want to create odbc drivers.
ALTER USER system IDENTIFIED BY "[add your pass here]";

--create a user and assign which container db they should be limited to:
CREATE USER "C##user-here" IDENTIFIED BY "[pass-here]" CONTAINER=ALL DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--give them permissions
GRANT connect, CREATE SESSION, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TABLE, CREATE TRIGGER, CREATE TYPE, CREATE MATERIALIZED VIEW TO "C##user-here" CONTAINER=ALL;

--altenative way:

CREATE USER testuser IDENTIFIED BY password1 CONTAINER=CURRENT;
GRANT ALL PRIVILEGES, CREATE SESSION TO testuser CONTAINER=CURRENT;


--List all users that are visible to the current user:

SELECT * FROM all_users;

--List all users in the Oracle Database:

SELECT * FROM dba_users;

--Show the information of the current user:

SELECT * FROM user_users;

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