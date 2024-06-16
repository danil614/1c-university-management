# University Management System

This repository contains the implementation of a University Management System developed in 1C:Enterprise. The system covers various aspects of student and faculty management, including:

- **University Information Management:**
  - Storing university name, number of courses, and maximum possible student grades.

- **Student Information Management:**
  - Storing student details (name, contact information, gender, date of birth).
  - Grouping students into groups associated with faculties.
  - Faculty information including dean details (name, contact information, gender, date of birth, academic degree).

- **Data Normalization:**
  - Normalizing names by trimming extra spaces and capitalizing the first letter.

- **Birthday Notification:**
  - Checking for birthdays upon system login and notifying users.

- **Enrollment Orders:**
  - Documenting enrollment orders with details like order number, date, faculty, group, course, students, class president status, budget-based education status, and tuition fees.

- **Payment Management:**
  - Recording partial or full tuition payments.

- **Transfer Orders:**
  - Documenting transfer orders with details about current and new faculties, groups, and courses.

- **Student Register:**
  - Maintaining a register of students, including group, course, faculty, class president status, and budget-based education status.

- **Financial Transactions Register:**
  - Maintaining a register of financial transactions for each student.

- **Validation Checks:**
  - Ensuring course number does not exceed the maximum allowed.
  - Ensuring tuition payments do not exceed the owed amount.
  - Ensuring no group has more than one class president.
  - Ensuring students are not already enrolled.
  - Verifying students in transfer orders exist in the group from which they are being transferred.

- **Grade Management:**
  - Creating and managing grade records with date, subject, student, and grade details.
  - Maintaining a cumulative register of grades.

- **Period Closing:**
  - Closing periods and calculating average grades.
  - Applying a 10% discount on tuition fees for high-achieving students on paid education.
  - Preventing modifications to documents after period closure.

- **Reporting:**
  - Generating a report showing students categorized by faculty, group, and course with details on class president status and budget-based education status.
  - Generating a bar chart report showing total tuition payments per faculty.

- **Print Form:**
  - Generating a printable form for student enrollment orders, matching an Excel template.
