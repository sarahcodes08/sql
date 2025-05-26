USE DBHospital;

INSERT INTO Patients VALUES
(1, 'Ali Khan', 'Islamabad', '03001234567'),
(2, 'Sara Ahmed', 'Lahore', '03111234567'),
(3, 'Usman Tariq', 'Karachi', '03221234567'),
(4, 'Hina Shafiq', 'Peshawar', '03331234567'),
(5, 'Noman Riaz', 'Multan', '03441234567');

INSERT INTO Medical_Staff VALUES
(1, 'Dr. Zain Ul Abideen', '03451234567'),
(2, 'Dr. Hina Anwar', '03331234567'),
(3, 'Nurse Aliya Khan', '03261234567'),
(4, 'Dr. Faisal Mirza', '03151234567');

INSERT INTO Treatments VALUES
(1, 'Paracetamol', '500mg', 'Twice a day'),
(2, 'Amoxicillin', '250mg', 'Three times a day'),
(3, 'Ibuprofen', '400mg', 'Once a day'),
(4, 'Cough Syrup', '10ml', 'Twice a day'),
(5, 'Antacid', '1 tablet', 'After meals');

INSERT INTO MedicalRecords VALUES
(101, '2025-04-15', 'Flu', 'Rest and medication', 1, 1, 1),
(102, '2025-04-18', 'Throat Infection', 'Antibiotics and warm fluids', 2, 2, 2),
(103, '2025-04-20', 'Headache', 'Painkillers and rest', 3, 1, 3),
(104, '2025-04-22', 'Cold & Cough', 'Cough syrup and steam', 4, 3, 4),
(105, '2025-04-23', 'Acidity', 'Diet change and medication', 5, 4, 5);