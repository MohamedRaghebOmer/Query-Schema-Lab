-- Problem 47: Employees with manager name
SELECT e.*, m.Name AS ManagerName
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- Problem 48: Employees with or without manager (null if no manager)
SELECT e.*, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- Problem 49: Employees showing own name if no manager
SELECT Name, ManagerID, Salary,
CASE WHEN Managers.Name IS NULL THEN Name ELSE Managers.Name END AS ManagerName
FROM Employees
LEFT JOIN Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID;

-- Problem 50: Employees managed by 'Mohammed'
SELECT e.Name, e.ManagerID, e.Salary, m.Name AS ManagerName
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE m.Name = 'Mohammed';