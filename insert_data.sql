-- ============================================================
--  Student Database Management System
--  File: insert_data.sql
--  Description: Realistic sample data for all tables
-- ============================================================

-- ------------------------------------------------------------
--  Departments  (6 rows)
-- ------------------------------------------------------------
INSERT INTO Departments (department_name, faculty) VALUES
    ('Computer Science',        'Faculty of Engineering'),
    ('Electrical Engineering',  'Faculty of Engineering'),
    ('Business Administration', 'Faculty of Commerce'),
    ('Mathematics',             'Faculty of Sciences'),
    ('Data Science',            'Faculty of Engineering'),
    ('Physics',                 'Faculty of Sciences');

-- ------------------------------------------------------------
--  Courses  (7 rows)
-- ------------------------------------------------------------
INSERT INTO Courses (course_code, course_name, department_id, credit_hours, instructor) VALUES
    ('CS101',  'Introduction to Programming',      1, 3, 'Dr. Ananya Sharma'),
    ('CS302',  'Database Management Systems',      1, 4, 'Dr. Rahul Verma'),
    ('EE201',  'Circuit Analysis',                 2, 3, 'Prof. Sunita Nair'),
    ('BA101',  'Principles of Management',         3, 3, 'Dr. Priya Mehta'),
    ('MA201',  'Linear Algebra',                   4, 4, 'Prof. Arun Gupta'),
    ('DS301',  'Machine Learning Fundamentals',    5, 4, 'Dr. Kavita Joshi'),
    ('PH101',  'Classical Mechanics',              6, 3, 'Prof. Deepak Patel');

-- ------------------------------------------------------------
--  Students  (12 rows — mix of departments & years)
-- ------------------------------------------------------------
INSERT INTO Students
    (first_name, last_name, email, phone, date_of_birth, gender, department_id, enrollment_year)
VALUES
    ('Aarav',    'Singh',     'aarav.singh@university.edu',    '9876543210', '2002-03-15', 'M', 1, 2021),
    ('Priya',    'Sharma',    'priya.sharma@university.edu',   '9876543211', '2001-07-22', 'F', 1, 2020),
    ('Rohan',    'Mehta',     'rohan.mehta@university.edu',    '9876543212', '2003-01-10', 'M', 2, 2022),
    ('Sneha',    'Patel',     'sneha.patel@university.edu',    '9876543213', '2002-11-05', 'F', 3, 2021),
    ('Vikram',   'Nair',      'vikram.nair@university.edu',    '9876543214', '2001-09-30', 'M', 4, 2020),
    ('Anjali',   'Verma',     'anjali.verma@university.edu',   '9876543215', '2002-06-18', 'F', 5, 2021),
    ('Karan',    'Joshi',     'karan.joshi@university.edu',    '9876543216', '2003-04-25', 'M', 1, 2022),
    ('Divya',    'Gupta',     'divya.gupta@university.edu',    '9876543217', '2001-12-08', 'F', 2, 2020),
    ('Arjun',    'Kumar',     'arjun.kumar@university.edu',    '9876543218', '2002-08-14', 'M', 5, 2021),
    ('Meera',    'Reddy',     'meera.reddy@university.edu',    '9876543219', '2003-02-28', 'F', 3, 2022),
    ('Siddharth','Bose',      'siddharth.bose@university.edu', '9876543220', '2001-05-17', 'M', 4, 2020),
    ('Nisha',    'Kapoor',    'nisha.kapoor@university.edu',   '9876543221', '2002-10-03', 'F', 6, 2021);

-- ------------------------------------------------------------
--  Enrollments  (25 rows — varied marks & statuses)
-- ------------------------------------------------------------
INSERT INTO Enrollments (student_id, course_id, enrolled_on, marks, grade, status) VALUES
    -- Aarav  (CS student, 2021)
    (1,  1, '2021-08-01',  88.50, 'A',  'completed'),
    (1,  2, '2022-01-10',  76.00, 'B',  'completed'),
    (1,  6, '2022-08-05',  91.00, 'A+', 'completed'),

    -- Priya  (CS student, 2020)
    (2,  1, '2020-08-01',  95.00, 'A+', 'completed'),
    (2,  2, '2021-01-10',  89.00, 'A',  'completed'),
    (2,  5, '2021-08-05',  72.50, 'B',  'completed'),

    -- Rohan  (EE student, 2022)
    (3,  3, '2022-08-01',  65.00, 'C',  'completed'),
    (3,  5, '2023-01-10',  55.00, 'C',  'enrolled'),

    -- Sneha  (BA student, 2021)
    (4,  4, '2021-08-01',  80.00, 'A',  'completed'),
    (4,  1, '2022-01-10',  70.00, 'B',  'completed'),

    -- Vikram  (Maths student, 2020)
    (5,  5, '2020-08-01',  93.00, 'A+', 'completed'),
    (5,  7, '2021-01-10',  88.00, 'A',  'completed'),

    -- Anjali  (DS student, 2021)
    (6,  6, '2021-08-01',  97.00, 'A+', 'completed'),
    (6,  1, '2022-01-10',  85.50, 'A',  'completed'),
    (6,  2, '2022-08-05',  79.00, 'B',  'enrolled'),

    -- Karan  (CS student, 2022)
    (7,  1, '2022-08-01',  60.00, 'C',  'completed'),
    (7,  2, '2023-01-10',  NULL,  NULL, 'enrolled'),

    -- Divya  (EE student, 2020)
    (8,  3, '2020-08-01',  74.00, 'B',  'completed'),
    (8,  7, '2021-01-10',  68.00, 'C',  'completed'),

    -- Arjun  (DS student, 2021)
    (9,  6, '2021-08-01',  82.00, 'A',  'completed'),
    (9,  5, '2022-01-10',  78.50, 'B',  'completed'),

    -- Meera  (BA student, 2022)
    (10, 4, '2022-08-01',  88.00, 'A',  'completed'),
    (10, 1, '2023-01-10',  NULL,  NULL, 'enrolled'),

    -- Siddharth  (Maths student, 2020)
    (11, 5, '2020-08-01',  99.00, 'A+', 'completed'),

    -- Nisha  (Physics student, 2021)
    (12, 7, '2021-08-01',  83.00, 'A',  'completed');
