--Insert members
INSERT INTO LibraryMember (PersonalNumber, PINCode, Email) VALUES 
(19900101, 1234, 'alice.reader@email.com'),
(19850520, 5678, 'bob.books@email.com'),
(19921115, 9911, 'charlie.lit@email.com'),
(19781212, 4422, 'sam.reader@provider.net'),
(20010310, 0000, 'jordan.student@university.edu'),
(19650704, 1776, 'liberty.books@history.org'),
(19700101, 9999, 'forgotful.borrower@example.com');

--Insert Books
INSERT INTO Book (ISBN, Author, BookTitle) VALUES 
(9780140449136, 'Fyodor Dostoevsky', 'Crime and Punishment'),
(9780451524935, 'George Orwell', '1984'),
(9780743273565, 'F. Scott Fitzgerald', 'The Great Gatsby'),
(9780316769174, 'J.D. Salinger', 'The Catcher in the Rye'),
(9780553103540, 'George R.R. Martin', 'A Game of Thrones'),
(9780618260300, 'J.R.R. Tolkien', 'The Fellowship of the Ring'),
(9780142437230, 'Miguel de Cervantes', 'Don Quixote'),
(9780060850524, 'Aldous Huxley', 'Brave New World'),
(9780307474278, 'Dan Brown', 'The Da Vinci Code'),
(9780140449266, 'Leo Tolstoy', 'War and Peace'),
(9780679720201, 'Franz Kafka', 'The Metamorphosis');

--Insert Loans
INSERT INTO Loan (FkLibraryMemberId, FkBookId, LoanDateTime, LoanPeriod) VALUES 
(1, 10, '2023-10-01 10:30:00', 14), 
(2, 11, '2023-10-05 14:15:00', 14), 
(3, 12, '2023-10-10 09:00:00', 14), 
(4, 14, '2023-11-01 12:00:00', 14), 
(4, 15, '2023-11-01 12:05:00', 14), 
(5, 16, '2023-11-15 10:30:00', 14), 
(6, 17, '2023-12-01 15:45:00', 14), 
(1, 18, '2023-12-05 09:20:00', 14);

--Late Loans
INSERT INTO Loan (FkLibraryMemberId, FkBookId, LoanDateTime, LoanPeriod) VALUES 
(
    (SELECT LibraryMemberId FROM LibraryMember WHERE Email = 'forgotful.borrower@example.com'),
    (SELECT BookId FROM Book WHERE ISBN = 9780140449266), 
    DATEADD(day, -45, GETDATE()),
    30 
),
(
    (SELECT LibraryMemberId FROM LibraryMember WHERE Email = 'forgotful.borrower@example.com'),
    (SELECT BookId FROM Book WHERE ISBN = 9780679720201), 
    DATEADD(day, -21, GETDATE()),
    7
),
(
    (SELECT LibraryMemberId FROM LibraryMember WHERE Email = 'forgotful.borrower@example.com'),
    (SELECT BookId FROM Book WHERE ISBN = 9780553103540), 
    DATEADD(day, -20, GETDATE()),
    14
);

--Insert Discharges
INSERT INTO Discharge (FkLoanId, DischargeDateTime) VALUES 
(100, '2023-10-15 11:00:00'), 
(101, '2023-10-20 16:30:00'),
(103, '2023-11-20 09:00:00'), 
(105, '2023-11-30 14:00:00');

