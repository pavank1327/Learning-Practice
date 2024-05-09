drop table Policy;
drop table PolicyHolder;
drop table Claim;

-- Create tables
CREATE TABLE Policy (
    PolicyID INT PRIMARY KEY,
    PolicyNumber VARCHAR2(20) UNIQUE,
    PolicyHolderID INT,
    PolicyType VARCHAR2(50),
    StartDate DATE,
    EndDate DATE,
    PremiumAmount NUMBER(10, 2),
    Status VARCHAR2(20)
);

CREATE TABLE PolicyHolder (
    PolicyHolderID INT PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    DateOfBirth DATE,
    Gender VARCHAR2(10),
    Email VARCHAR2(100),
    Phone VARCHAR2(20),
    Address VARCHAR2(200)
);

CREATE TABLE Claim (
    ClaimID INT PRIMARY KEY,
    PolicyID INT,
    DateFiled DATE,
    ClaimAmount NUMBER(10, 2),
    Status VARCHAR2(20),
    FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID)
);

-- Insert sample data
INSERT INTO Policy (PolicyID, PolicyNumber, PolicyHolderID, PolicyType, StartDate, EndDate, PremiumAmount, Status)
VALUES
    (1, 'POL001', 1, 'Life Insurance', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), 1000.00, 'Active');
    INSERT INTO Policy (PolicyID, PolicyNumber, PolicyHolderID, PolicyType, StartDate, EndDate, PremiumAmount, Status)
VALUES
    (2, 'POL002', 2, 'Health Insurance', TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 800.00, 'Active');
    INSERT INTO Policy (PolicyID, PolicyNumber, PolicyHolderID, PolicyType, StartDate, EndDate, PremiumAmount, Status)
VALUES
    (3, 'POL003', 3, 'Car Insurance', TO_DATE('2022-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'), 1200.00, 'Active');

INSERT INTO PolicyHolder (PolicyHolderID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, Address)
VALUES
    (1, 'John', 'Doe', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'Male', 'john@example.com', '123-456-7890', '123 Main St, Anytown, USA');
    INSERT INTO PolicyHolder (PolicyHolderID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, Address)
VALUES
    (2, 'Jane', 'Smith', TO_DATE('1990-08-20', 'YYYY-MM-DD'), 'Female', 'jane@example.com', '987-654-3210', '456 Elm St, Othertown, USA');
    INSERT INTO PolicyHolder (PolicyHolderID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, Address)
VALUES
    (3, 'Bob', 'Johnson', TO_DATE('1985-03-10', 'YYYY-MM-DD'), 'Male', 'bob@example.com', '111-222-3333', '789 Oak St, Anycity, USA');

INSERT INTO Claim (ClaimID, PolicyID, DateFiled, ClaimAmount, Status)
VALUES
    (101, 1, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 5000.00, 'Pending');
    INSERT INTO Claim (ClaimID, PolicyID, DateFiled, ClaimAmount, Status)
VALUES
    (102, 2, TO_DATE('2022-07-15', 'YYYY-MM-DD'), 2000.00, 'Approved');INSERT INTO Claim (ClaimID, PolicyID, DateFiled, ClaimAmount, Status)
VALUES
    (103, 3, TO_DATE('2022-10-10', 'YYYY-MM-DD'), 1500.00, 'Denied');
    
select * from Policy;
select * from PolicyHolder;
select * from Claim;
    
    
    
-- Create a function to calculate age
CREATE OR REPLACE FUNCTION calculate_age(
    birth_date IN DATE
) RETURN NUMBER IS
    age NUMBER;
BEGIN
    SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, birth_date) / 12) INTO age FROM DUAL;
    RETURN age;
END calculate_age;
/

-- Create a stored procedure to approve a claim
CREATE OR REPLACE PROCEDURE approve_claim(
    claim_id IN INT
) AS
BEGIN
    UPDATE Claim
    SET Status = 'Approved'
    WHERE ClaimID = claim_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Claim ' || claim_id || ' has been approved.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END approve_claim;
/

-- Create a stored procedure to reject a claim
CREATE OR REPLACE PROCEDURE reject_claim(
    claim_id IN INT
) AS
BEGIN
    UPDATE Claim
    SET Status = 'Rejected'
    WHERE ClaimID = claim_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Claim ' || claim_id || ' has been rejected.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END reject_claim;
/

-- Example operations
DECLARE
    age NUMBER;
BEGIN
    -- Calculate age using the function
    age := calculate_age(TO_DATE('1990-01-15', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Age: ' || age);

    -- Approve a claim
    approve_claim(101);

    -- Reject a claim
    reject_claim(103);
END;
/

