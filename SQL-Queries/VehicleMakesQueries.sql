-- Vehicle SQL Practice Queries

-- Problem 1: Get all vehicles made between 1950 and 2000
SELECT *
FROM VehicleDetails 
WHERE Year BETWEEN 1950 AND 2000;

-- Problem 2: Count the number of vehicles made between 1950 and 2000
SELECT COUNT(*) AS NumberOfVehicles 
FROM VehicleDetails 
WHERE Year BETWEEN 1950 AND 2000;

-- Problem 3: Count vehicles per make made between 1950 and 2000
SELECT Makes.Make, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY Makes.Make
ORDER BY NumberOfVehicles DESC;

-- Problem 4: Get Makes with more than 12,000 vehicles made between 1950 and 2000
SELECT Makes.Make, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY Makes.Make
HAVING COUNT(*) > 12000
ORDER BY NumberOfVehicles DESC;

-- Problem 5: Vehicles per make with total vehicles and percentage
SELECT Makes.Make, COUNT(*) AS NumberOfVehicles,
       (SELECT COUNT(*) FROM VehicleDetails) AS TotalVehicles,
       CAST(COUNT(*) AS FLOAT) / CAST((SELECT COUNT(*) FROM VehicleDetails) AS FLOAT) AS Percentage
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY Makes.Make
ORDER BY NumberOfVehicles DESC;

-- Problem 6: Vehicles per make and fuel type
SELECT Makes.Make, FuelTypes.FuelTypeName, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY Makes.Make, FuelTypes.FuelTypeName
ORDER BY Makes.Make;

-- Problem 7: All vehicles running on GAS
SELECT VehicleDetails.*, FuelTypes.FuelTypeName
FROM VehicleDetails
INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = N'GAS';

-- Problem 8: All Makes that run on GAS
SELECT DISTINCT Makes.Make, FuelTypes.FuelTypeName
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = N'GAS'
ORDER BY Makes.Make;

-- Problem 9: Total Makes that run on GAS
SELECT COUNT(*) AS TotalMakesRunsOnGAS 
FROM (
    SELECT DISTINCT Makes.Make
    FROM VehicleDetails
    INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
    INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
    WHERE FuelTypes.FuelTypeName = N'GAS'
) AS R1;

-- Problem 10: Count vehicles by make
SELECT Makes.Make, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Makes.Make
ORDER BY NumberOfVehicles DESC;

-- Problem 11: Makes that manufacture more than 20K vehicles
SELECT Makes.Make, COUNT(*) AS NumberOfVehicles
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Makes.Make
HAVING COUNT(*) > 20000
ORDER BY NumberOfVehicles DESC;

-- Problem 12: Makes starting with 'B'
SELECT * FROM Makes
WHERE Makes.Make LIKE '[Bb]%';

-- Problem 13: Makes ending with 'W'
SELECT * FROM Makes
WHERE Makes.Make LIKE '%[wW]';

-- Problem 14: Makes with DriveTypeName = FWD
SELECT DISTINCT Makes.Make, DriveTypes.DriveTypeName
FROM Makes
INNER JOIN VehicleDetails ON VehicleDetails.MakeID = Makes.MakeID
INNER JOIN DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
WHERE DriveTypes.DriveTypeName = 'FWD'
ORDER BY Makes.Make;

-- Problem 15: Total Makes with DriveType FWD
SELECT COUNT(*) AS MakeWithFWD
FROM (
    SELECT DISTINCT Makes.Make
    FROM Makes
    INNER JOIN VehicleDetails ON VehicleDetails.MakeID = Makes.MakeID
    INNER JOIN DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
    WHERE DriveTypes.DriveTypeName = 'FWD'
) AS Q;

-- Problem 16: Total vehicles per DriveType per Make
SELECT Makes.Make, DriveTypes.DriveTypeName, COUNT(*) AS TotalVehicles
FROM VehicleDetails
INNER JOIN DriveTypes ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
INNER JOIN Makes ON Makes.MakeID = VehicleDetails.MakeID
GROUP BY Makes.Make, DriveTypes.DriveTypeName
ORDER BY Makes.Make ASC, TotalVehicles DESC;

-- Problem 17: Vehicles per DriveType per Make with total > 10,000
SELECT Makes.Make, DriveTypes.DriveTypeName, COUNT(*) AS TotalVehicles
FROM VehicleDetails
INNER JOIN DriveTypes ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
INNER JOIN Makes ON Makes.MakeID = VehicleDetails.MakeID
GROUP BY Makes.Make, DriveTypes.DriveTypeName
HAVING COUNT(*) > 10000
ORDER BY Makes.Make ASC, TotalVehicles DESC;

-- Problem 18: Vehicles with no specified doors
SELECT * FROM VehicleDetails
WHERE NumDoors IS NULL;

-- Problem 19: Count of vehicles with no specified doors
SELECT COUNT(*) AS TotalWithNoSpecifiedDoors
FROM VehicleDetails
WHERE NumDoors IS NULL;

-- Problem 20: Percentage of vehicles with no specified doors
SELECT CAST((SELECT COUNT(*) FROM VehicleDetails WHERE NumDoors IS NULL) AS FLOAT)
       / CAST((SELECT COUNT(*) FROM VehicleDetails) AS FLOAT) * 100 AS PercOfNoSpecifiedDoors;

-- Problem 21: Vehicles with SubModelName 'Elite'
SELECT VehicleDetails.MakeID, Makes.Make, SubModels.SubModelName
FROM SubModels
INNER JOIN VehicleDetails ON VehicleDetails.SubModelID = SubModels.SubModelID
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE SubModels.SubModelName = 'Elite';

-- Problem 22: Vehicles with engine > 3 liters and 2 doors
SELECT * FROM VehicleDetails
WHERE Engine_Liter_Display > 3 AND NumDoors = 2;

-- Problem 23: Vehicles with engine containing 'OHV' and 4 cylinders
SELECT Makes.Make, VehicleDetails.*
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE VehicleDetails.Engine LIKE '%OHV%' AND Engine_Cylinders = 4;

-- Problem 24: Vehicles with Body 'Sport Utility' and Year > 2020
SELECT VehicleDetails.*, Bodies.BodyName
FROM VehicleDetails
INNER JOIN Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE VehicleDetails.Year > 2020 AND Bodies.BodyName = 'Sport Utility';

-- Problem 25: Vehicles with Body 'Coupe', 'Hatchback', or 'Sedan'
SELECT VehicleDetails.*, Bodies.BodyName
FROM VehicleDetails
INNER JOIN Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName IN ('Coupe', 'Hatchback', 'Sedan');

-- Problem 26: Vehicles with specified bodies and years 2008, 2020, 2021
SELECT VehicleDetails.*, Bodies.BodyName
FROM VehicleDetails
INNER JOIN Bodies ON VehicleDetails.BodyID = Bodies.BodyID
WHERE BodyName IN ('Coupe', 'Hatchback', 'Sedan') AND Year IN (2008, 2020, 2021);

-- Problem 27: Check if any vehicle made in 1950 exists
SELECT CASE WHEN EXISTS (SELECT 1 FROM VehicleDetails WHERE Year = 1950) THEN 1 ELSE 0 END AS Found;

-- Problem 28: Vehicle display name and number of doors with description
SELECT Vehicle_Display_Name, NumDoors,
CASE 
    WHEN NumDoors IS NULL THEN 'Not Set'
    WHEN NumDoors = 0 THEN 'Zero Doors'
    WHEN NumDoors = 1 THEN 'One Door'
    WHEN NumDoors = 2 THEN 'Two Doors'
    WHEN NumDoors = 3 THEN 'Three Doors'
    WHEN NumDoors = 4 THEN 'Four Doors'
    WHEN NumDoors = 5 THEN 'Five Doors'
    WHEN NumDoors = 6 THEN 'Six Doors'
    WHEN NumDoors = 8 THEN 'Eight Doors'
    ELSE 'Unknown'
END AS DoorDescription
FROM VehicleDetails;

-- Problem 29: Vehicle age calculation and sorting
SELECT Vehicle_Display_Name, Year, YEAR(GETDATE()) - Year AS CarAge
FROM VehicleDetails
ORDER BY CarAge DESC;

-- Problem 30: Vehicles aged between 15 and 25 years
SELECT R.Vehicle_Display_Name, R.Year, R.CarAge
FROM (
    SELECT Vehicle_Display_Name, Year, YEAR(GETDATE()) - Year AS CarAge
    FROM VehicleDetails
) AS R
WHERE R.CarAge BETWEEN 15 AND 25
ORDER BY R.CarAge DESC;

-- Problem 31: Engine CC statistics (min, max, avg)
SELECT MIN(Engine_CC) AS MinCC, MAX(Engine_CC) AS MaxCC, AVG(Engine_CC) AS AvgCC
FROM VehicleDetails;

-- Problem 32: Vehicles with minimum Engine_CC
SELECT Vehicle_Display_Name, Engine_CC
FROM VehicleDetails
WHERE Engine_CC = (SELECT MIN(Engine_CC) FROM VehicleDetails);

-- Problem 33: Vehicles with maximum Engine_CC
SELECT Vehicle_Display_Name, Engine_CC
FROM VehicleDetails
WHERE Engine_CC = (SELECT MAX(Engine_CC) FROM VehicleDetails);

-- Problem 34: Vehicles with Engine_CC below average
SELECT Vehicle_Display_Name, Engine_CC
FROM VehicleDetails
WHERE Engine_CC < (SELECT AVG(Engine_CC) FROM VehicleDetails);

-- Problem 35: Total vehicles above average Engine_CC
SELECT COUNT(*) AS TotalVehiclesAboveAVG_Engine_CC
FROM VehicleDetails
WHERE Engine_CC > (SELECT AVG(Engine_CC) FROM VehicleDetails);

-- Problem 36: Top 3 Engine CC values
SELECT DISTINCT TOP 3 Engine_CC
FROM VehicleDetails
ORDER BY Engine_CC DESC;

-- Problem 37: Vehicles with one of the top 3 Engine CC
SELECT Vehicle_Display_Name, Engine_CC
FROM VehicleDetails
WHERE Engine_CC IN (
    SELECT DISTINCT TOP 3 Engine_CC FROM VehicleDetails ORDER BY Engine_CC DESC
);

-- Problem 38: Makes producing vehicles with top 3 Engine CC
SELECT DISTINCT m.Make
FROM Makes m
INNER JOIN VehicleDetails vd ON m.MakeID = vd.MakeID
WHERE vd.Engine_CC IN (
    SELECT DISTINCT TOP 3 Engine_CC FROM VehicleDetails ORDER BY Engine_CC DESC
)
ORDER BY m.Make;

-- Problem 39: Unique Engine_CC and tax calculation
SELECT DISTINCT Engine_CC,
CASE
    WHEN Engine_CC BETWEEN 0 AND 1000 THEN 100
    WHEN Engine_CC BETWEEN 1001 AND 2000 THEN 200
    WHEN Engine_CC BETWEEN 2001 AND 4000 THEN 300
    WHEN Engine_CC BETWEEN 4001 AND 6000 THEN 400
    WHEN Engine_CC BETWEEN 6001 AND 8000 THEN 500
    WHEN Engine_CC > 8000 THEN 600
    ELSE 0
END AS EngineTax
FROM VehicleDetails
ORDER BY Engine_CC;

-- Problem 40: Total number of doors per make
SELECT Makes.Make, SUM(NumDoors) AS TotalNumOfDoors
FROM Makes
INNER JOIN VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID
GROUP BY Makes.Make
ORDER BY TotalNumOfDoors DESC;

-- Problem 41: Total doors manufactured by Ford
SELECT SUM(NumDoors) AS FordTotalDoors
FROM VehicleDetails
INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE Makes.Make = 'Ford';

-- Problem 42: Number of models per make
SELECT Makes.Make, COUNT(*) AS TotalModels
FROM Makes
INNER JOIN MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
ORDER BY TotalModels DESC;

-- Problem 43: Top 3 manufacturers with the most models
SELECT TOP 3 Make, TotalModels
FROM (
    SELECT Makes.Make, COUNT(*) AS TotalModels
    FROM Makes
    INNER JOIN MakeModels ON Makes.MakeID = MakeModels.MakeID
    GROUP BY Makes.Make
) AS q;

-- Problem 44: Manufacturer with highest number of models
SELECT m.Make, COUNT(*) AS TotalCount
FROM Makes m
INNER JOIN MakeModels mm ON m.MakeID = mm.MakeID
GROUP BY m.Make
HAVING COUNT(*) = (
    SELECT MAX(ModelCount) FROM (
        SELECT COUNT(*) AS ModelCount FROM MakeModels GROUP BY MakeID
    ) AS Q
);

-- Problem 45: Manufacturer with lowest number of models
SELECT m.Make, COUNT(*) AS TotalCount
FROM Makes m
INNER JOIN MakeModels mm ON m.MakeID = mm.MakeID
GROUP BY m.Make
HAVING COUNT(*) = (
    SELECT MIN(ModelCount) FROM (
        SELECT COUNT(*) AS ModelCount FROM MakeModels GROUP BY MakeID
    ) AS Q
);

-- Problem 46: Fuel Types in random order
SELECT * FROM FuelTypes ORDER BY NEWID();
