--AI generated testdata

-- 1. Clear all data in the correct order (child tables first due to Foreign Keys)
DELETE FROM Discharge;
DELETE FROM Loan;
DELETE FROM BookAuthor;
DELETE FROM Book;
DELETE FROM Author;
DELETE FROM LibraryMember;

-- 2. Variables to capture the generated IDs
DECLARE @MemberAlice INT, @MemberBob INT, @MemberCharlie INT;
DECLARE @AuthorTerry INT, @AuthorNeil INT, @AuthorGeorge INT, @AuthorKarin INT;
DECLARE @BookGoodOmens INT, @Book1984 INT, @BookBror INT;

-- 3. Insert Members
INSERT INTO LibraryMember (PersonalNumber, PINCode, Email) VALUES (199001011234, 1234, 'alice@example.com');
SET @MemberAlice = SCOPE_IDENTITY();
INSERT INTO LibraryMember (PersonalNumber, PINCode, Email) VALUES (198505205566, 5678, 'bob@example.com');
SET @MemberBob = SCOPE_IDENTITY();
INSERT INTO LibraryMember (PersonalNumber, PINCode, Email) VALUES (200203109988, 0000, 'charlie@example.com');
SET @MemberCharlie = SCOPE_IDENTITY();

-- 4. Insert Authors
INSERT INTO Author (AuthorFirstName, AuthorLastName) VALUES ('Terry', 'Pratchett');
SET @AuthorTerry = SCOPE_IDENTITY();
INSERT INTO Author (AuthorFirstName, AuthorLastName) VALUES ('Neil', 'Gaiman');
SET @AuthorNeil = SCOPE_IDENTITY();
INSERT INTO Author (AuthorFirstName, AuthorLastName) VALUES ('George', 'Orwell');
SET @AuthorGeorge = SCOPE_IDENTITY();
INSERT INTO Author (AuthorFirstName, AuthorLastName) VALUES ('Karin', 'Smirnoff');
SET @AuthorKarin = SCOPE_IDENTITY();

-- 5. Insert Books
INSERT INTO Book (ISBN, BookTitle) VALUES (9780552167390, 'Good Omens');
SET @BookGoodOmens = SCOPE_IDENTITY();
INSERT INTO Book (ISBN, BookTitle) VALUES (9780451524935, '1984');
SET @Book1984 = SCOPE_IDENTITY();
INSERT INTO Book (ISBN, BookTitle) VALUES (9789170379925, 'My Brother');
SET @BookBror = SCOPE_IDENTITY();

-- 6. Connections (BookAuthor) - Variables are used here!
INSERT INTO BookAuthor (FkBookId, FkAuthorId) VALUES (@BookGoodOmens, @AuthorTerry), (@BookGoodOmens, @AuthorNeil);
INSERT INTO BookAuthor (FkBookId, FkAuthorId) VALUES (@Book1984, @AuthorGeorge);
INSERT INTO BookAuthor (FkBookId, FkAuthorId) VALUES (@BookBror, @AuthorKarin);

-- 7. Loans (Capturing LoanId to allow for Discharges)
DECLARE @Loan1 INT;

-- A loan that has been returned (Alice borrows 1984)
INSERT INTO Loan (FkLibraryMemberId, FkBookId, LoanDateTime, LoanPeriod) 
VALUES (@MemberAlice, @Book1984, '2025-12-01', 14);
SET @Loan1 = SCOPE_IDENTITY();
INSERT INTO Discharge (FkLoanId, DischargeDateTime) VALUES (@Loan1, '2025-12-10');

-- An active overdue loan (Charlie borrowed Good Omens 40 days ago)
INSERT INTO Loan (FkLibraryMemberId, FkBookId, LoanDateTime, LoanPeriod) 
VALUES (@MemberCharlie, @BookGoodOmens, DATEADD(day, -40, GETDATE()), 14);

-- An active loan (Bob borrows "My Brother" today)
INSERT INTO Loan (FkLibraryMemberId, FkBookId, LoanDateTime, LoanPeriod) 
VALUES (@MemberBob, @BookBror, GETDATE(), 14);

-- 8. Final Results
SELECT 
    l.LoanId,
    m.Email AS Member,
    b.BookTitle AS Book,
    l.LoanDateTime AS BorrowedDate,
    DATEADD(day, l.LoanPeriod, l.LoanDateTime) AS DueDate,
    CASE 
        WHEN d.DischargeDateTime IS NOT NULL THEN 'Returned'
        WHEN GETDATE() > DATEADD(day, l.LoanPeriod, l.LoanDateTime) THEN 'OVERDUE'
        ELSE 'Active'
    END AS [Status]
FROM Loan l
JOIN LibraryMember m ON l.FkLibraryMemberId = m.LibraryMemberId
JOIN Book b ON l.FkBookId = b.BookId
LEFT JOIN Discharge d ON l.LoanId = d.FkLoanId;
