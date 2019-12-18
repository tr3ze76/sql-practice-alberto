use master
go

USE Tournaments_CA_Alberto
drop database Tournaments_CA_Alberto
CREATE DATABASE Tournaments_CA_Alberto

CREATE SCHEMA Tournaments_CA_Alberto

CREATE TABLE Tournaments_CA_Alberto.Members
(
	MemberId int PRIMARY KEY,
	MemberFirstName varchar (50) NOT NULL,
	MemberLastName varchar (50) NOT NULL,
	MemberDateOfBirth date,
	MemberPhoneNumber bigint,
	MemberAddressLine1 varchar (200) NOT NULL,
	MemberAddressLine2 varchar (200) NOT NULL,
	MemberPostCode varchar (10) NOT NULL,
	MemberCity varchar (100) NOT NULL,
	MemberCountry varchar (50) NOT NULL
);
GO

CREATE TABLE Tournaments_CA_Alberto.CampusLocation
(
	CampusName INT PRIMARY KEY,
	CampusPhoneNumber bigint,
	CampusAddressLine1 varchar (250) NOT NULL,
	CampusAddressLine2 varchar (250) NOT NULL,
	CampusPostCode varchar (10) NOT NULL,
	CampusCity varchar (100) NOT NULL,
	CampusCountry varchar (50) NOT NULL
);
GO
	

	
	