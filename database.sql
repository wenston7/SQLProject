
CREATE TABLE Member (
	UniqueID		CHAR(7)			NOT NULL,
    LastName		VARCHAR(25)		NOT NULL,
    FirstName		VARCHAR(25)		NOT NULL,
    SSN				CHAR(11)		NOT NULL,
    Address						VARCHAR(50)		NOT NULL,
    PhoneNumber					CHAR(12)		NOT NULL,
    EmailAddress				NVARCHAR(100)	NULL,
		CONSTRAINT			MemberPK		PRIMARY KEY (UniqueID),
        CONSTRAINT			MemberAK		UNIQUE(SSN)
        ); 

CREATE TABLE Rate (
	AccountType					VARCHAR(12)		NOT NULL,
	CurrentInterestRate			DEC(3,2)		NOT NULL,
    Term						VARCHAR(12)		NULL
    );
    
ALTER TABLE Rate 
	ADD CONSTRAINT 		RatePK		PRIMARY KEY(AccountType, CurrentInterestRate);


CREATE TABLE Account (
	AccountNumber				INT(9)			NOT NULL,
    AccountType					VARCHAR(12)		NOT NULL,
	CurrentInterestRate			DEC(3,2)		NOT NULL,
    CurrentBalance				BIGINT			NOT NULL,
    UniqueID 					CHAR(7) 		NOT NULL,
		CONSTRAINT 			AccountPK			PRIMARY KEY (AccountNumber),
		CONSTRAINT			AccountFK1			FOREIGN KEY(UniqueID)  				REFERENCES Member(UniqueID),
        CONSTRAINT			AccountFK2			FOREIGN KEY(AccountType)  			REFERENCES Rate(AccountType));
		

ALTER TABLE	Account
	ADD CONSTRAINT AccountFK3 FOREIGN KEY(CurrentInterestRate)	
			REFERENCES Rate(CurrentInterestRate)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION;
   

CREATE TABLE Joint_Owner (
	UniqueID		CHAR(7)			NOT NULL,
    AccountNumber				INT(9)			NOT NULL,
		CONSTRAINT 			JointOwnerPK			PRIMARY KEY (AccountNumber, UniqueID),
		CONSTRAINT			JointOwnerFK1			FOREIGN KEY(UniqueID)  				REFERENCES Member(UniqueID),
        CONSTRAINT			JointOwnerFK2			FOREIGN KEY(AccountNumber) 			REFERENCES  Account(AccountNumber)
);

CREATE TABLE Checkings_Account(
	AccountNumber					INT(9)		NOT NULL,
	MinimumBalanceRequirement		BIGINT		NOT NULL,
	LastInterestDate				DATE		NULL,
    CONSTRAINT			CAPK			PRIMARY KEY(AccountNumber),
    CONSTRAINT			CAFK			FOREIGN KEY(AccountNumber) REFERENCES  Account(AccountNumber)
);
  
CREATE TABLE Savings_Account(
	AccountNumber					INT(9)		NOT NULL,
	MinimumBalanceRequirement		BIGINT		NOT NULL,
	LastInterestDate				DATE		NULL,
    CONSTRAINT			SAPK			PRIMARY KEY(AccountNumber),
    CONSTRAINT			SAFK			FOREIGN KEY(AccountNumber) REFERENCES  Account(AccountNumber)
);


CREATE TABLE CD_Account (
	AccountNumber		INT(9)			NOT NULL,
    CDType				CHAR(3)			NOT NULL,
    CDTerm				VARCHAR(12) 	NOT NULL, 
    LastInterestDate	DATE			NULL,
    CONSTRAINT			CDPK			PRIMARY KEY(AccountNumber),
    CONSTRAINT			CDFK			FOREIGN KEY(AccountNumber) REFERENCES  Account(AccountNumber)
);

CREATE TABLE Loan_Account (
	AccountNumber				INT(9)					NOT NULL,
	LoanType					VARCHAR(10)				NOT NULL,
	LoanTerm					VARCHAR(12)				NOT NULL,
	Principal					BIGINT					NOT NULL,
	UnpaidInterest				DEC(3,2)				NULL,
	AnnualRate					DEC(3,2)				NOT NULL,
	MonthlyPayment				BIGINT					NOT NULL,
	PaymentReceivedLastMonth	BIGINT					NOT NULL,
	NextPaymentDate				DATE					NOT NULL,
	NextPaymentAmount			BIGINT					NOT NULL,
	TerminationDate				DATE					NULL,
	AccountStatus				VARCHAR(4)				NOT NULL,
    CONSTRAINT			LAPK			PRIMARY KEY(AccountNumber),
    CONSTRAINT			LAFK			FOREIGN KEY(AccountNumber) REFERENCES  Account(AccountNumber)
);

CREATE TABLE Delinquency (
	AccountNumber			INT(9)			NOT NULL,
	LoanType				VARCHAR(10)		NOT NULL,
	AccountStatus			VARCHAR(4)		NOT NULL,
	MoneyOwed				BIGINT			NOT NULL,
	PaymentDueNextMonth		BIGINT			NOT NULL,
	Date					DATE			NOT NULL,
    CONSTRAINT			DelinquencyPK			PRIMARY KEY(AccountNumber),
    CONSTRAINT			DelinquencyFK			FOREIGN KEY(AccountNumber) 		REFERENCES  Account(AccountNumber)
    );
    
CREATE TABLE Transaction (
	TransactionID				INT(8)				NOT NULL,
	TransactionType				VARCHAR(25)			NOT NULL,
	Initiator					VARCHAR(25)			NOT NULL,
	TransferTo					VARCHAR(25)			NULL,
	TransferFrom				VARCHAR(25)			NULL,
	AccountNumber				INT(9)				NOT NULL,
	TransferAmount				BIGINT				NOT NULL,
    CONSTRAINT			TransactionPK		PRIMARY KEY(TransactionID),
    CONSTRAINT 			TransactionFK		FOREIGN KEY(AccountNumber)		REFERENCES Account(AccountNumber)
    );

CREATE TABLE Messages (
	MessageID		CHAR(8)				NOT NULL,
	Message			VARCHAR(500)		NOT NULL,
    CONSTRAINT 		MessagesPK		PRIMARY KEY(MessageID)
    );

CREATE TABLE Message_To (
	MessageID		CHAR(8)		NOT NULL,
	UniqueID		CHAR(7)		NOT NULL,
    CONSTRAINT 		MessageToPK				PRIMARY KEY(MessageID, UniqueID),
    CONSTRAINT		MessageToFK1			FOREIGN KEY(MessageID)  				REFERENCES Messages(MessageID),
    CONSTRAINT		MessageToFK2			FOREIGN KEY(UniqueID)  					REFERENCES Member(UniqueID)
    );
    
CREATE TABLE Daily_Balance (
	AccountNumber		INT(9)	NOT NULL,
	Date				DATE	NOT NULL,
	BalanceAtEndOfDay	BIGINT	NOT NULL,
    CONSTRAINT 		DBPK		PRIMARY KEY(AccountNumber, Date),
    CONSTRAINT 		DBFK		FOREIGN KEY(AccountNumber)		REFERENCES Account(AccountNumber)
    );
						
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES ('D131346', 'Brown', 'Jenny', '123-11-4567', '385 Broadway Revere MA', '857-123-4567', 'Jenny.Brown@gmail.com') ;

INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES ('D131348', 'Cruz', 'Jamie', '234-10-5678', 	'181 Independnece Rd, Danvers MA', '617-234-5678', 'Jamie.Cruz@gmail.com') ;
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131350', 'Ford', 'Ashley', '345-11-6789', '16 Union St, Lynn MA', '781-345-6789', 'Ashely.Ford@yahoo.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131352', 'Spencer', 'Colin', '987-10-6543', '111 West Park St, Lynn MA', '781-987-6543', 'Colin.Spencer@gmail.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131354','West', 'Lucy', '876-11-5432', '8 Douglas St, Saugus MA',	'857-876-5432',	'Lucy.West@yahoo.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
	VALUES('D131356', 'Lowe', 'Patrick', '765-10-4321', '9 Bell Rd, Everett MA', '248-765-4321', 'Patrick.Lowe@outlook.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131358',	'Frenchie',	'Melissa',	'246-11-8102',	'63 Loring Ave, Salem MA',	'339-246-8102',	'Melissa.Frenchie@ssu.edu');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131360',	'Jones', 'Tom',	'357-10-9113',	'76 Selden Street, Boston MA',	'787-357-9113',	'Tommy.Jones@gmail.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131366', 'Herring', 'Emmett',	'017-42-0573',	'454 Burke Street, Cambridge MA', '617-561-9969', 'Emmett.Herring@gmail.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131371',	'Diaz',	'Trenton',	'563-24-4626',	'1202 Hillcrest Avenue, Rockland MA',	'857-424-8754',	'Trenton.Diaz@gmail.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131373', 'Ross',	'Stephanie',	'062-23-5732',	'1907 Kennedy Court, Roxbury MA',	'617-589-2202',	'Stephanie.Ross@gmial.com');
INSERT INTO Member
	(UniqueID, LastName, FirstName, SocialSecurityNumber, Address, PhoneNumber, EmailAddress)
    VALUES('D131374', 'Gonzalez', 'Henry', '071-11-2641' , '1859 Ferguson Street, Falmouth MA', '857-214-1023', 'Henry.Gonzalez@gmail.com');

INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Checking',	'0.03');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Savings'	,'0.06');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('CD1', '0.45');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('CD2', '0.55');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('CD3', '0.70');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('CD4', '1.00');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Home120',	'2.61');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Home360',	'3.99');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Auto24',	'3.59');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
    VALUES('Auto36',	'4.09');
INSERT INTO RATE 
	(AccountType, CurrentInterestRate)
	VALUES('Auto48',	'8.66');
    
    
INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('117038670', 'Checking', '0.03', '$1,073.84', 'D131346');
    
INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('112658784', 'Checking', '0.03', '($127.33)', 'D131352');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('114589002', 'Checking', '0.03', '$501.01', 'D131350');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('118092721', 'Checking', '0.03', '$11,781.67', 'D131366');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('117334587', 'Checking', '0.03', '$2,145.52', 'D131371');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('119830450', 'Checking', '0.03', '$15,287.77', 'D131373');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('131456714', 'Savings', '0.06', '$5,784.95', 'D131348');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('138907876', 'Savings', '0.06', '$7,448.11', 'D131358');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('139285361', 'Savings', '0.06', '$6,371.57', 'D131346');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('135507212', 'Savings', '0.06', '$52,481.67', 'D131354');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('136925282', 'Savings', '0.06', '$122,573.84', 'D131366');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('134642248', 'Savings', '0.06', '$622.54', 'D131352');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('140967672', 'CD1', '0.45', '$3,500.29', 'D131354');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('141086106', 'CD2', '0.55', '$5,281.51', 'D131354');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('143006150', 'CD1', '0.45', '$1,004.14', 'D131348');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('144382746', 'CD4', '1.00', '$4,827.56', 'D131352');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('143692077', 'CD3', '0.70', '$7,821.11', 'D131350');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('125783564', 'Auto36', '4.09', '$14,556.54', 'D131356');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('128923401', 'Home360', '3.99', '$318,474.12', 'D131360');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('125605095', 'Auto48', '8.66', '$6,778.51', 'D131374');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('123604304', 'Auto24', '3.59', '$40,183.81', 'D131358');

INSERT INTO Account
	(AccountNumber, AccountType, CurrentInterestRate, CurrentBalance, UniqueID)
    VALUES ('123604304', 'Home120', '2.61', '$445,735.31', 'D131346');


INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('117038670', 'D131374');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('117038670', 'D131350');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('112658784', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('114589002', 'D131350');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('118092721', ' ');
    
INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('117334587', ' ');
    
INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('119830450', 'D131366');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('131456714', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('138907876', 'D131356');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('138907876', 'D131354');
    
INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('139285361', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('135507212', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('136925282', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('134642248', 'D131360');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('140967672', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('141086106', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('143006150', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('144382746', ' ');
    
INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('143692077', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('125783564', 'D131373');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('128923401', ' ');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('125605095', ' ');    

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('123604304', 'D131356');

INSERT INTO Joint_Owner
	(UniqueID, AccountNumber)
	VALUES ('123604304', ' ');
    

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('117038670', '$2,500', '11/1/2021');

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('114589002', '$1,500', '11/1/2021');

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('112658784', '$2,000', '11/1/2021');

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('118092721', '$2,000', '11/1/2021');

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('117334587', '$1,500', '11/1/2021');

INSERT INTO Checkings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('119830450', '$2,000', '11/1/2021');
    

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('131456714', '$300', '11/1/2021');

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('138907876', '$500', '11/1/2021');

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('139285361', '$450', '11/1/2021');

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('135507212', '$300', '11/1/2021');

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('136925282', '$300', '11/1/2021');

INSERT INTO Savings_Account
	(AccountNumber, MinimumBalanceRequirement, LastInterestDate)
    VALUES ('134642248', '$500', '11/1/2021');
    

INSERT INTO CD_Account
	(AccountNumber, CDType, CDTerm, LastInterestDate)
    VALUES ('140967672', 'CD1', '6 Months', '11/1/2021');

INSERT INTO CD_Account
	(AccountNumber, CDType, CDTerm, LastInterestDate)
    VALUES ('141086106', 'CD2', '12 Months', '11/1/2021');

INSERT INTO CD_Account
	(AccountNumber, CDType, CDTerm, LastInterestDate)
    VALUES ('143006150', 'CD1', '6 Months', '11/1/2021');

INSERT INTO CD_Account
	(AccountNumber, CDType, CDTerm, LastInterestDate)
    VALUES ('144382746', 'CD4', '24 Months', '11/1/2021');

INSERT INTO CD_Account
	(AccountNumber, CDType, CDTerm, LastInterestDate)
    VALUES ('143692077', 'CD3', '60 Months', '11/1/2021');

INSERT INTO Loan_Account
	(AccountNumber, LoanType, LoanTerm, Principal, UnpaidInterest, AnnualRate, MonthlyPayment, 
    PaymentReceivedLastMonth, NextPaymentDate, NextPaymentAmount, TerminationDate, AccountStatus)
    VALUES ('125783564', 'Auto', '36 Months', '$15,000.00', ' ', '4.09', '$443.46', '$443.46', '12/1/2021', '$443.46', NULL, 'GOOD');

INSERT INTO Loan_Account
	(AccountNumber, LoanType, LoanTerm, Principal, UnpaidInterest, AnnualRate, MonthlyPayment, 
    PaymentReceivedLastMonth, NextPaymentDate, NextPaymentAmount, TerminationDate, AccountStatus)
    VALUES ('128923401', 'Home', '360 Months', '$320,000.00', ' ', '3.99', '$1,525.88', '$1,525.88', '12/1/2021', '$1,525.88', NULL, 'GOOD');
    
INSERT INTO Loan_Account
	(AccountNumber, LoanType, LoanTerm, Principal, UnpaidInterest, AnnualRate, MonthlyPayment, 
    PaymentReceivedLastMonth, NextPaymentDate, NextPaymentAmount, TerminationDate, AccountStatus)
    VALUES ('125605095', 'Auto', '48 Months', '$7,000.00', ' ', '8.66', '$221.49', '$221.49', '12/1/2021', '$221.49', NULL, 'GOOD');
    
INSERT INTO Loan_Account
	(AccountNumber, LoanType, LoanTerm, Principal, UnpaidInterest, AnnualRate, MonthlyPayment, 
    PaymentReceivedLastMonth, NextPaymentDate, NextPaymentAmount, TerminationDate, AccountStatus)
    VALUES ('123604304', 'Auto', '24 Months', '$42,000.00', ' ', '3.59', '$1,816.19', '$1,816.19', '12/1/2021', '$1,816.19', NULL, 'GOOD');
    
INSERT INTO Loan_Account
	(AccountNumber, LoanType, LoanTerm, Principal, UnpaidInterest, AnnualRate, MonthlyPayment, 
    PaymentReceivedLastMonth, NextPaymentDate, NextPaymentAmount, TerminationDate, AccountStatus)
    VALUES ('123604304', 'Home', '120 Months', '$450,000.00', ' ', '2.61', '$4,264.69', '$3,182.56', '12/1/2021', '$5,346.82', NULL, 'BAD');

INSERT INTO Delinquency
	(AccountNumber, LoanType, AccountStatus, MoneyOwed, PaymentDueNextMonth, Date)
    VALUES ('123604304', 'Home', 'BAD', '$1,082.13', '$5,346.82', '11/1/2021');

INSERT INTO Transaction
	(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber, TransferAmount, TransactionDate)
	VALUES ('01041150', 'Deposit', 'Bank', 'Savings', ' ', '131456714', '$3.47', '12/5/2021');

INSERT INTO Transaction
	(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber, TransferAmount, TransactionDate)
	VALUES ('01051331', 'Deposit', 'Owner', 'Checking', ' ', '117334587', '$150.00', '12/5/2021');

INSERT INTO Transaction
(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber,
TransferAmount, TransactionDate)
VALUES ('01017528', 'Withdraw', 'Owner', ' ', 'Checking', '117038670', '($100.00)',
'12/6/2021');
INSERT INTO Transaction
	(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber, TransferAmount, TransactionDate)
	VALUES ('01092946', 'Withdraw', 'Owner', ' ', 'Checking', '119830450', '($550.00)', '12/7/2021');

INSERT INTO Transaction
	(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber, TransferAmount, TransactionDate)
	VALUES ('01090090', 'Transfer', 'Owner', ' ', ' ', '118092721', '$18.00', '12/13/2021');

INSERT INTO Transaction
	(TransactionID, TransactionType, Initiator, TransferTo, TransferFrom, AccountNumber, TransferAmount, TransactionDate)
	VALUES ('01088864', 'PaymentReceived', 'Owner', 'Bank', 'Checking', '123604304', '$3,182.56', '12/16/2021');


INSERT INTO Messages
	(MessageID, Message)
	VALUES ('M0179942', 'multiple transactions today');

INSERT INTO Messages
	(MessageID, Message)
	VALUES ('M0160936', 'insufficient funds');

INSERT INTO Messages
	(MessageID, Message)
	VALUES ('M0159316', 'duplicate check');

INSERT INTO Messages
	(MessageID, Message)
	VALUES ('M0148186', 'credit card ad');

INSERT INTO Messages
	(MessageID, Message)
	VALUES ('M0174542', 'hold/stop payment on account');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0179942', 'D131360');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0179942', 'D131358');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0160936', 'D131366');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0159316', 'D131371');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0159316', 'D131360');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0148186', 'D131373');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0174542', 'D131358');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0174542', 'D131346');

INSERT INTO Message_To
	(MessageID, UniqueID)
	VALUES ('M0174542', 'D131374');


INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('117038670', '12/1/2021', '$1,221.73');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('117038670', '12/2/2021', '$1,073.84');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('112658784', '12/1/2021', '-$127.33');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('114589002', '12/2/2021', '$501.01');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('118092721', '12/2/2021', '$11,781.67');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('117334587', '12/1/2021', '$2,112.52');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('119830450', '12/3/2021', '$15,201.63');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('131456714', '12/1/2021', '$5,784.95');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('138907876', '12/1/2021', '$7,501.12');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('138907876', '12/2/2021', '$6,349.24');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('139285361', '12/2/2021', '$52,481.67');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('135507212', '12/1/2021', '$122,573.84');

INSERT INTO Daily_Balance
	(AccountNumber, Date, BalanceAtEndofDay)
	VALUES ('136925282', '12/1/2021', '$602.55');