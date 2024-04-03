SELECT * FROM Satellite.s;
-- CREATE TABLE Satellite AS (SELECT SatID,Purpose,COSPAR_Number FROM Satellite.s);
CREATE TABLE S AS (SELECT * FROM Satellite.s);
Select * from S ;
Alter table S rename column Owner to Company_Name;

CREATE TABLE Satellite AS (SELECT SatID,Sat_Name,Users,Purpose,COSPAR_Number FROM S);
CREATE TABLE Orbit AS (SELECT Type_Of_Orbit,Perigee_in_km,Apogee_in_km,COSPAR_Number FROM S);
CREATE TABLE Technical_Details AS (SELECT SatID,Contractor,Country_of_Contractor,Comments FROM S);
CREATE TABLE Launch_Details AS (SELECT Date_of_Launch,Launch_Vehicle,Launch_Site,COSPAR_Number FROM S);
CREATE TABLE Owner AS (SELECT SatID,Company_Name,Country,Country_of_Operator,COSPAR_Number FROM S);


SELECT COUNT(*) FROM Satellite;

-- fartest satellite
Select SatID,Sat_Name,Users,Purpose from Satellite INNER JOIN Orbit ON Satellite.COSPAR_Number=Orbit.COSPAR_Number ORDER BY Orbit.Apogee_in_km DESC LIMIT 10;

-- nearest satellite
Select SatID,Sat_Name,Users,Purpose from Satellite INNER JOIN Orbit ON Satellite.COSPAR_Number=Orbit.COSPAR_Number ORDER BY Orbit.Perigee_in_km  LIMIT 10;

SELECT DISTINCT Country_of_Contractor FROM Technical_Details;
SELECT DISTINCT Date_of_Launch FROM Launch_Details;

SELECT Launch_Site,COUNT(*) FROM Launch_Details where Date_of_Launch LIKE '%/01/%' GROUP BY Launch_Site;

SELECT DISTINCT Company_Name FROM Owner WHERE Country = 'USA';

SELECT Users,Count(*) FROM Satellite  GROUP BY Users;

SELECT  Purpose,Count(*) FROM Satellite WHERE Users = 'Commercial' GROUP BY Purpose;

SELECT Satellite.Sat_Name, Technical_Details.Contractor FROM Satellite LEFT JOIN Technical_Details ON Satellite.SatID = Technical_Details.SatID;

SELECT Company_Name, COUNT(*)  FROM Owner RIGHT JOIN  (SELECT * FROM Launch_Details WHERE Launch_Vehicle = 'Falcon 9') AS Launch_Details ON Owner.COSPAR_Number = Launch_Details.COSPAR_Number GROUP BY Company_Name;

select AVG(Perigee_in_km),AVG(Apogee_in_km) from Orbit ;

Select * from Jan_Sat;
CREATE TABLE Jan_Sat AS SELECT Satellite.Sat_Name, Launch_Details.Date_of_Launch FROM Launch_Details INNER JOIN Satellite ON Launch_Details.COSPAR_Number = Satellite.COSPAR_Number WHERE Launch_Details.Date_of_Launch LIKE '%/01/%';
SELECT * FROM Jan_Sat ORDER BY Date_of_Launch LIMIT 10;

SELECT Sat_Name, Launch_Vehicle FROM Satellite JOIN Launch_Details ON Satellite.COSPAR_Number = Launch_Details.COSPAR_Number WHERE Date_of_Launch BETWEEN '01/2/23' AND '31/3/23';

SELECT COUNT(*) FROM Owner WHERE Country_of_Operator != Country;
SELECT COUNT(*) AS Total_Count,Owner.Country_of_Operator, Owner.Country, Satellite.Sat_Name FROM Owner JOIN Satellite ON Owner.SatID = Satellite.SatID WHERE Owner.Country_of_Operator != Owner.Country GROUP BY Owner.Country_of_Operator, Owner.Country, Satellite.Sat_Name;

SELECT * FROM Owner WHERE Country  LIKE 'NR%';

SELECT DISTINCT Type_Of_Orbit FROM Orbit ORDER BY Type_Of_Orbit;

-- SELECT Sat_Name, Purpose FROM Satellite WHERE SatID IN (SELECT SatID FROM Owner GROUP BY SatID HAVING COUNT(*) > 1);

-- SELECT Satellite.Sat_Name, Satellite.Purpose, Owner.Company_Name FROM Satellite JOIN Owner ON Satellite.SatID = Owner.SatID WHERE Satellite.SatID IN (SELECT SatID FROM Owner GROUP BY SatID HAVING COUNT(*) > 1);

SELECT DISTINCT Contractor FROM Technical_Details WHERE Country_of_Contractor = 'Russia';

SELECT COUNT(*) FROM Owner WHERE Country = Country_of_Operator;

SELECT Sat_Name, Purpose FROM Satellite WHERE SatID NOT IN (SELECT SatID FROM Owner);

SELECT Satellite.Sat_Name, Orbit.Perigee_in_km FROM Satellite JOIN Orbit ON Satellite.COSPAR_Number = Orbit.COSPAR_Number WHERE Satellite.Sat_Name LIKE 'starlink%' ORDER BY Orbit.Perigee_in_km ASC LIMIT 5;

SELECT Satellite.Sat_Name, Owner.Company;

SELECT Owner.Company_Name, Satellite.Sat_Name FROM Owner RIGHT JOIN (SELECT * FROM Satellite ORDER BY Sat_Name ASC LIMIT 10) AS Satellite ON Owner.SatID = Satellite.SatID;

SELECT Satellite.Sat_Name, COUNT(Owner.SatID) AS Total_Owners FROM Satellite LEFT JOIN (SELECT * FROM Owner WHERE Country = 'USA') AS Owner ON Satellite.SatID = Owner.SatID GROUP BY Satellite.Sat_Name;

SELECT Satellite.Sat_Name, Owner.Company_Name FROM Satellite INNER JOIN Owner ON Satellite.SatID = Owner.SatID UNION SELECT Orbit.Type_Of_Orbit, Launch_Details.Launch_Site FROM Orbit INNER JOIN Launch_Details ON Orbit.COSPAR_Number = Launch_Details.COSPAR_Number;

SELECT Satellite.Sat_Name,Satellite.Purpose, Technical_Details.Contractor,Technical_Details.Comments FROM Satellite LEFT JOIN Technical_Details ON Satellite.SatID = Technical_Details.SatID;

