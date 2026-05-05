# 📊 Student Database Management System

## 🔍 Overview

This project implements a relational database system for managing students, courses, enrollments, and academic performance using SQL.

It demonstrates real-world database design along with practical querying techniques ranging from basic retrieval to advanced analytics.

---

## 🧠 Key Features

* Structured relational schema with proper normalization
* Foreign key relationships ensuring data integrity
* Categorized SQL queries (Basic → Intermediate → Advanced)
* Analytical queries for performance tracking and reporting

---

## 🏗️ Database Structure

The system includes the following core tables:

* **Students** — Stores student information
* **Departments** — Stores department details
* **Courses** — Stores course-related data
* **Enrollments** — Links students and courses with performance data

---

## ⚙️ SQL Concepts Demonstrated

* Joins (INNER JOIN, LEFT JOIN)
* Aggregations (AVG, COUNT, MAX, MIN)
* Filtering (WHERE, HAVING)
* Grouping (GROUP BY)
* Sorting (ORDER BY)
* Conditional aggregation
* Window functions (for percentage calculations)

---

## 📂 Project Structure

```
Student-Database-Management-System/
│
├── schema.sql
├── insert_data.sql
├── queries.sql
└── README.md
```

---

## 📊 Query Categories

### 🔹 Basic Queries

* List all students with department details
* Filter students by department
* Retrieve active students

---

### 🔹 Intermediate Queries

* Students with enrolled courses
* Students enrolled in a specific course
* Course catalogue with department information

---

### 🔹 Advanced Queries

* Average marks per student
* Top-performing students (performance filtering)
* Course-wise performance analysis
* Student count per course
* Department-level performance summary
* Individual student transcript
* Students without enrollments
* Grade distribution analysis

---

## 💡 Example Use Cases

* Academic performance tracking
* Student transcript generation
* Course performance analysis
* Department-level reporting
* Identifying top-performing students

---

## 🚀 How to Run

1. Create database:

```sql
CREATE DATABASE student_db;
USE student_db;
```

2. Run files in order:

* schema.sql
* insert_data.sql
* queries.sql

---

## 📸 Sample Output 
<img width="1366" height="768" alt="Screenshot (66)" src="https://github.com/user-attachments/assets/f562f2e1-d7da-4ded-ba82-2482c5f9ddeb" />


---

## 🛠️ Tech Stack

* SQL (MySQL)

---

## 🎯 Learning Outcomes

* Strong understanding of relational database design
* Practical experience with SQL querying and analytics
* Ability to build real-world data-driven solutions

---

## 🔮 Future Improvements

* Add frontend interface (React / Web UI)
* Build API layer using Node.js
* Integrate with real-time data systems

---

## 📬 Contact

* GitHub: https://github.com/Shubhranshu331

---

⭐ If you found this useful, feel free to star the repository!
