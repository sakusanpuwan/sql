CREATE SEQUENCE TEST_TABLE1_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOORDER
  NOCACHE
  NOCYCLE;
COMMIT;
/

BEGIN
  EXECUTE IMMEDIATE 
  'CREATE TABLE TEST_TABLE1 (
    X_RRNO NUMBER PRIMARY KEY,
    NAME VARCHAR2(100),
    ADDRESS VARCHAR2(15 CHAR) -- By default VARCHAR2 is in bytes, VARCHAR2(15 CHAR) specifies 15 character length
  )';
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN
      RAISE;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TEST_TABLE1_BI
BEFORE INSERT ON TEST_TABLE1
FOR EACH ROW
BEGIN
  IF :NEW.X_RRNO IS NULL THEN
    :NEW.X_RRNO := TEST_TABLE1_SEQ.NEXTVAL;
  END IF;
END;
/