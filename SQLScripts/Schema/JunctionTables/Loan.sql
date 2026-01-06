USE [LibraryDB]
GO

/****** Object:  Table [dbo].[Loan]    Script Date: 1/6/2026 7:52:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Loan](
	[LoanId] [int] IDENTITY(100,1) NOT NULL,
	[FkLibraryMemberId] [int] NULL,
	[FkBookId] [int] NULL,
	[LoanDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LoanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Loan]  WITH CHECK ADD  CONSTRAINT [Fk_BookLoan] FOREIGN KEY([FkBookId])
REFERENCES [dbo].[Book] ([BookId])
GO

ALTER TABLE [dbo].[Loan] CHECK CONSTRAINT [Fk_BookLoan]
GO

ALTER TABLE [dbo].[Loan]  WITH CHECK ADD  CONSTRAINT [Fk_LibraryMemberLoan] FOREIGN KEY([FkLibraryMemberId])
REFERENCES [dbo].[LibraryMember] ([LibraryMemberId])
GO

ALTER TABLE [dbo].[Loan] CHECK CONSTRAINT [Fk_LibraryMemberLoan]
GO


