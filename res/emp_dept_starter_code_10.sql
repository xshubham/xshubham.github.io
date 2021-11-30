/* --------------------------------------------------------------- *\
                    1. Creating tables
\* --------------------------------------------------------------- */
CREATE TABLE dept (
    deptno INTEGER CHECK (deptno > 0),
    dname VARCHAR2(32) NOT NULL,
    location VARCHAR2(32) NOT NULL,
    mgr INTEGER,
    CONSTRAINT pkey PRIMARY KEY(deptno)
);

CREATE TABLE emp (
    empno INTEGER CHECK (empno > 0),
    ename VARCHAR2(15) NOT NULL,
    init VARCHAR2(10),
    job VARCHAR2(32) NOT NULL,
    mgr INTEGER,
    bdate DATE NOT NULL,
    msal NUMBER(10),
    comm NUMBER(10),
    deptno INTEGER,
    CONSTRAINT pkey_emp PRIMARY KEY(empno),
    CONSTRAINT fkey1 FOREIGN KEY(mgr) REFERENCES emp(empno) ON DELETE SET NULL,
    CONSTRAINT fkey2 FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE SET NULL
);

ALTER TABLE dept ADD CONSTRAINT fkey_dept FOREIGN KEY(mgr) REFERENCES emp(empno) ON DELETE SET NULL;


/* --------------------------------------------------------------- *\
                    2. Inserting data
\* --------------------------------------------------------------- */
INSERT INTO emp(empno, ename, init, job, mgr, bdate, msal, comm, deptno) VALUES(1, 'OMKAR', 'MR', 'CEO', NULL, '27-OCT-1992', 137000, NULL, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(2, 'AMRIT', 'MR', 'SUPERVISOR', '25-DEC-1997', 17450, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(3, 'AMISHA', 'MISS', 'ASSISTANT MANAGER', '12-AUG-1995', 34600, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(4, 'ANURAMA', 'MRS', 'MANAGER', '12-APR-1984', 44775, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(5, 'RAJESH', 'MR', 'SALES REP', '21-JAN-2003', 12720, 2500);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(6, 'SHUBHANKAR', 'MR', 'MANAGER', '20-NOV-1999', 40580, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(7, 'ANUBHAV', 'MR', 'SALES REP', '25-DEC-2002', 15300, 4000);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(8, 'ANKITA', 'MISS', 'SALES REP', '17-MAY-2000', 17150, 1000);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(9, 'DIKSHA', 'MISS', 'ANALYST', '25-DEC-2002', 25420, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(10, 'BHUPAL', 'MR', 'MANAGER', '11-DEC-1980', 45580, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(11, 'RAMESH', 'MR', 'CLERK', '19-JAN-1995', 10720, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(12, 'RAGHAV', 'MR', 'SUPERVISOR', '25-APR-2001', 16250, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(13, 'SHIVANI', 'MRS.', 'ANALYST', '14-MAR-1992', 30650, NULL);
INSERT INTO emp(empno, ename, init, job, bdate, msal, comm) VALUES(14, 'VAISHALI', 'MRS.', 'CLERK', '12-APR-1987', 10720, NULL);

UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'OMKAR') WHERE job = 'MANAGER';
UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'BHUPAL') WHERE ename LIKE '%SH%' AND NOT job = 'CEO' AND NOT job = 'MANAGER';
UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'ANURAMA') WHERE ename = 'AMRIT';
UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'ANURAMA') WHERE ename = 'RAGHAV';
UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'SHUBHANKAR') WHERE ename = 'ANUBHAV';
UPDATE emp SET mgr = (SELECT empno FROM emp WHERE ename = 'SHUBHANKAR') WHERE ename = 'ANKITA';

INSERT INTO dept(deptno, dname, location, mgr) SELECT 1, 'PRODUCTION', 'KANPUR', empno FROM emp WHERE ename = 'ANURAMA';
INSERT INTO dept(deptno, dname, location, mgr) SELECT 2, 'SALES', 'DELHI', empno FROM emp WHERE ename = 'SHUBHANKAR';
-- so '&' in the 'R & D' string won't prompt for the input.
SET DEFINE OFF;
INSERT INTO dept(deptno, dname, location, mgr) SELECT 3, 'R & D', 'BENGALURU', empno FROM emp WHERE ename = 'BHUPAL';

UPDATE emp SET deptno = (SELECT deptno FROM dept WHERE mgr IN (SELECT empno FROM emp WHERE ename = 'ANURAMA')) WHERE mgr = (SELECT empno FROM emp WHERE ename = 'ANURAMA') OR ename = 'ANURAMA';
UPDATE emp SET deptno = (SELECT deptno FROM dept WHERE mgr IN (SELECT empno FROM emp WHERE ename = 'SHUBHANKAR')) WHERE mgr = (SELECT empno FROM emp WHERE ename = 'SHUBHANKAR') OR ename = 'SHUBHANKAR';
UPDATE emp SET deptno = (SELECT deptno FROM dept WHERE mgr IN (SELECT empno FROM emp WHERE ename = 'BHUPAL')) WHERE mgr = (SELECT empno FROM emp WHERE ename = 'BHUPAL') OR ename = 'BHUPAL';

UPDATE emp SET msal = 10500 WHERE ename = UPPER('ramesh');