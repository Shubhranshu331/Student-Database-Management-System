-- ============================================================
--  Student Database Management System
--  File: schema.sql
--  Compatible: MySQL 8.0+
-- ============================================================

-- Drop tables in reverse dependency order (safe re-runs)
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Departments;

-- ------------------------------------------------------------
--  TABLE: Departments
-- ------------------------------------------------------------
CREATE TABLE Departments (
    department_id   INT             AUTO_INCREMENT  PRIMARY KEY,
    department_name VARCHAR(100)    NOT NULL UNIQUE,
    faculty         VARCHAR(100)    NOT NULL
);

-- ------------------------------------------------------------
--  TABLE: Students
-- ------------------------------------------------------------
CREATE TABLE Students (
    student_id      INT             AUTO_INCREMENT  PRIMARY KEY,
    first_name      VARCHAR(50)     NOT NULL,
    last_name       VARCHAR(50)     NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    phone           VARCHAR(15),
    date_of_birth   DATE            NOT NULL,
    gender          CHAR(1)         CHECK (gender IN ('M', 'F', 'O')),
    department_id   INT             NOT NULL,
    enrollment_year SMALLINT        NOT NULL,
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id) REFERENCES Departments (department_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ------------------------------------------------------------
--  TABLE: Courses
-- ------------------------------------------------------------
CREATE TABLE Courses (
    course_id       INT             AUTO_INCREMENT  PRIMARY KEY,
    course_code     VARCHAR(10)     NOT NULL UNIQUE,
    course_name     VARCHAR(150)    NOT NULL,
    department_id   INT             NOT NULL,
    credit_hours    SMALLINT        NOT NULL CHECK (credit_hours BETWEEN 1 AND 6),
    instructor      VARCHAR(100)    NOT NULL,

    CONSTRAINT fk_course_department
        FOREIGN KEY (department_id) REFERENCES Departments (department_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ------------------------------------------------------------
--  TABLE: Enrollments
-- ------------------------------------------------------------
CREATE TABLE Enrollments (
    enrollment_id   INT             AUTO_INCREMENT  PRIMARY KEY,
    student_id      INT             NOT NULL,
    course_id       INT             NOT NULL,
    enrolled_on     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    marks           NUMERIC(5, 2)   CHECK (marks BETWEEN 0 AND 100),
    grade           CHAR(2),
    status          VARCHAR(20)     NOT NULL DEFAULT 'enrolled'
                                    CHECK (status IN ('enrolled', 'completed', 'dropped')),

    CONSTRAINT uq_student_course
        UNIQUE (student_id, course_id),

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id) REFERENCES Students (student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id) REFERENCES Courses (course_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ------------------------------------------------------------
--  Indexes
-- ------------------------------------------------------------
CREATE INDEX idx_students_department   ON Students    (department_id);
CREATE INDEX idx_courses_department    ON Courses     (department_id);
CREATE INDEX idx_enrollments_student   ON Enrollments (student_id);
CREATE INDEX idx_enrollments_course    ON Enrollments (course_id);