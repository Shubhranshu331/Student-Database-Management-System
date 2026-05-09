-- ============================================================
--  Student Database Management System
--  File: queries.sql
--  Description: Categorised SQL queries — Basic → Advanced
-- ============================================================


-- ============================================================
--  SECTION 1 — BASIC QUERIES
-- ============================================================

-- ------------------------------------------------------------
--  Q1. All students (full list)
--  Returns every student with their department name and year.
--  ORDER BY makes output predictable and easy to scan.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    d.department_name,
    s.enrollment_year,
    s.is_active
FROM Students     s
JOIN Departments  d ON s.department_id = d.department_id
ORDER BY s.enrollment_year DESC, s.last_name;


-- ------------------------------------------------------------
--  Q2. Filter students by department
--  Change the literal to any department name as needed.
--  Using the JOIN means we never hard-code a numeric ID here.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.enrollment_year
FROM Students     s
JOIN Departments  d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science'
ORDER BY s.last_name;


-- ------------------------------------------------------------
--  Q3. All active students only
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    d.department_name,
    s.enrollment_year
FROM Students     s
JOIN Departments  d ON s.department_id = d.department_id
WHERE s.is_active = TRUE
ORDER BY d.department_name, s.last_name;


-- ============================================================
--  SECTION 2 — INTERMEDIATE QUERIES
-- ============================================================

-- ------------------------------------------------------------
--  Q4. Students with their enrolled courses  (three-table JOIN)
--  Shows each student alongside the course they enrolled in,
--  their marks, and current status.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    e.marks,
    e.grade,
    e.status
FROM Enrollments  e
JOIN Students     s ON e.student_id = s.student_id
JOIN Courses      c ON e.course_id  = c.course_id
ORDER BY s.last_name, c.course_code;


-- ------------------------------------------------------------
--  Q5. Students enrolled in a specific course
--  Lists every student in "Database Management Systems"
--  along with their current marks.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    e.marks,
    e.grade,
    e.status
FROM Enrollments  e
JOIN Students     s ON e.student_id     = s.student_id
JOIN Courses      c ON e.course_id      = c.course_id
JOIN Departments  d ON s.department_id  = d.department_id
WHERE c.course_name = 'Database Management Systems'
ORDER BY e.marks IS NULL, e.marks DESC; 


-- ------------------------------------------------------------
--  Q6. Course catalogue with department info
--  Useful for an admin dashboard listing all courses.
-- ------------------------------------------------------------
SELECT
    c.course_code,
    c.course_name,
    d.department_name,
    c.credit_hours,
    c.instructor
FROM Courses      c
JOIN Departments  d ON c.department_id = d.department_id
ORDER BY d.department_name, c.course_code;


-- ============================================================
--  SECTION 3 — ADVANCED QUERIES
-- ============================================================

-- ------------------------------------------------------------
--  Q7. Average marks per student (completed courses only)
--  Aggregates each student's performance into a single row.
--  NULL marks (still enrolled) are excluded by the WHERE.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    COUNT(e.enrollment_id)              AS courses_completed,
    ROUND(AVG(e.marks), 2)              AS average_marks
FROM Students     s
JOIN Departments  d ON s.department_id  = d.department_id
JOIN Enrollments  e ON s.student_id     = e.student_id
WHERE e.status = 'completed'
  AND e.marks IS NOT NULL
GROUP BY s.student_id, s.first_name, s.last_name, d.department_name
ORDER BY average_marks DESC;


-- ------------------------------------------------------------
--  Q8. Top-performing students  (average marks ≥ 85)
--  Filters the aggregation above with HAVING.
--  Great for honour-roll or scholarship reports.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    COUNT(e.enrollment_id)              AS courses_completed,
    ROUND(AVG(e.marks), 2)              AS average_marks
FROM Students     s
JOIN Departments  d ON s.department_id  = d.department_id
JOIN Enrollments  e ON s.student_id     = e.student_id
WHERE e.status = 'enrolled'
  AND e.marks IS NOT NULL
GROUP BY s.student_id, s.first_name, s.last_name, d.department_name
HAVING AVG(e.marks) >= 85
ORDER BY average_marks DESC;


-- ------------------------------------------------------------
--  Q9. Course-wise average marks
--  One row per course — shows how difficult each course is
--  relative to others based on student performance.
-- ------------------------------------------------------------
SELECT
    c.course_code,
    c.course_name,
    c.instructor,
    COUNT(e.enrollment_id)              AS total_enrolled,
    COUNT(CASE WHEN e.status = 'completed' THEN 1 END)
                                        AS total_completed,
    ROUND(AVG(CASE WHEN e.status = 'completed' THEN e.marks END), 2)
                                        AS avg_marks_completed
FROM Courses      c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_name, c.instructor
ORDER BY avg_marks_completed IS NULL, avg_marks_completed DESC;


-- ------------------------------------------------------------
--  Q10. Student count per course
--  Helps identify the most popular / under-enrolled courses.
-- ------------------------------------------------------------
SELECT
    c.course_code,
    c.course_name,
    d.department_name,
    COUNT(e.enrollment_id)              AS total_students,
    COUNT(CASE WHEN e.status = 'enrolled'  THEN 1 END) AS currently_enrolled,
    COUNT(CASE WHEN e.status = 'completed' THEN 1 END) AS completed,
    COUNT(CASE WHEN e.status = 'dropped'   THEN 1 END) AS dropped
FROM Courses      c
JOIN Departments  d ON c.department_id = d.department_id
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_name, d.department_name
ORDER BY total_students DESC;


-- ------------------------------------------------------------
--  Q11. Department-wise performance summary
--  Rolls everything up to department level — useful for
--  faculty reports and academic review boards.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(DISTINCT s.student_id)        AS total_students,
    COUNT(DISTINCT e.enrollment_id)     AS total_enrollments,
    ROUND(AVG(e.marks), 2)              AS dept_avg_marks,
    MAX(e.marks)                        AS highest_mark,
    MIN(e.marks)                        AS lowest_mark
FROM Departments  d
LEFT JOIN Students     s ON d.department_id = s.department_id
LEFT JOIN Enrollments  e ON s.student_id    = e.student_id
                         AND e.status = 'completed'
                         AND e.marks  IS NOT NULL
GROUP BY d.department_id, d.department_name
ORDER BY dept_avg_marks IS NULL, dept_avg_marks DESC;


-- ------------------------------------------------------------
--  Q12. Student transcript  (parameterise with a student_id)
--  Returns the full course history for one student.
--  Replace '1' with any valid student_id.
-- ------------------------------------------------------------
SELECT
    CONCAT(s.first_name, ' ', s.last_name)   AS student_name,
    d.department_name,
    c.course_code,
    c.course_name,
    c.credit_hours,
    c.instructor,
    e.enrolled_on,
    e.marks,
    e.grade,
    e.status
FROM Enrollments  e
JOIN Students     s ON e.student_id     = s.student_id
JOIN Courses      c ON e.course_id      = c.course_id
JOIN Departments  d ON s.department_id  = d.department_id
WHERE s.student_id = 1            -- << replace with target student_id
ORDER BY e.enrolled_on;


-- ------------------------------------------------------------
--  Q13. Students who have NOT enrolled in any course yet
--  Uses LEFT JOIN + IS NULL to find "orphan" student records.
-- ------------------------------------------------------------
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name,
    s.enrollment_year
FROM Students     s
JOIN Departments  d  ON s.department_id  = d.department_id
LEFT JOIN Enrollments e ON s.student_id  = e.student_id
WHERE e.enrollment_id IS NULL
ORDER BY s.enrollment_year;


-- ------------------------------------------------------------
--  Q14. Grade distribution across all courses
--  Aggregates grade frequency — useful for a bell-curve view.
-- ------------------------------------------------------------
SELECT
    e.grade,
    COUNT(*)                            AS frequency,
    ROUND(COUNT(*) * 100.0
          / SUM(COUNT(*)) OVER (), 2)   AS percentage
FROM Enrollments e
WHERE e.grade IS NOT NULL
GROUP BY e.grade
ORDER BY frequency DESC;
