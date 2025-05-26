USE DBHospital;

UPDATE Treatments SET Frequency = 'Once a day' WHERE TreatmentID = 2;

SELECT * FROM Treatments WHERE TreatmentID = 2;